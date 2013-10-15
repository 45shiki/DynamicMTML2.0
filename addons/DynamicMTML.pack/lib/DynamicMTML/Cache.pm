package DynamicMTML::Cache;

use strict;
use warnings;

sub new {
    my $class = shift;
    my %args  = @_;
    my $ttl = $args{ ttl };
    my $driver = $args{ driver };
    if (! $driver ) {
        $driver = MT->config( 'DynamicCacheDriver' );
    }
    $ttl = MT->config( 'DynamicCacheTTL' ) unless $ttl;
    $ttl = 7200 unless $ttl;
    if ( $driver ) {
        if ( $driver =~ /^memcache/i ) {
            $driver = 'Memcache';
        } else {
            $driver = ucfirst( $driver );
        }
        my $child .=  $class . '::' . $driver;
        eval "use $child;";
        if (! $@ ) {
            $class = $child;
        } else {
            die $@;
        }
    } else {
        return MT::Cache::Negotiate->new( ttl => $ttl );
    }
    my $obj = bless {}, $class;
    $obj->{ ttl } = $ttl;
    $obj->{ prefix } = MT->config( 'DynamicCachePrefix' );
    $obj->init( @_ );
}

sub init {
    my $class = shift;
    return $class;
}

sub flush_by_key {
    my $class = shift;
    my $key = shift;
    my $prefix = $class->{ prefix };
    if ( $key !~ /^$prefix/ ) {
        $key = $prefix . '_upldate_key_' . $key;
    }
    my $do = 0;
    my $error;
    if ( my $update_keys = $class->get( $key ) ) {
        my @keys = split( /,/, $update_keys );
        for my $key ( @keys ) {
            if ( $class->remove( $key ) ) {
                $do = 1;
            } else {
                $error = 1;
            }
        }
        if ( $class->remove( $key ) ) {
            $do = 1;
        } else {
            $error = 1;
        }
    }
    return undef if $error;
    return $do;
}

1;