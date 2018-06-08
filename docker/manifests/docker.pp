# Default ipaddress to use
$ipaddr = '127.0.0.1'
# Comma separated list of 'tenant:user:passwd:privileges'
$default_tempauth_users = ['rio:user:4ttqqTZ2#_P%nHRz:.admin']

# Deploy a single node
class {'gridinit':
  no_exec => true,
}
class{'openiosds':}
openiosds::namespace {'OPENIO':
  ns                       => 'OPENIO',
  conscience_url           => "${ipaddr}:6000",
  oioproxy_url             => "${ipaddr}:6006",
  eventagent_url           => "beanstalk://${ipaddr}:6014",
  ecd_url                  => "${ipaddr}:6017",
  meta1_digits             => 0,
  ns_storage_policy        => 'SINGLE',
  ns_chunk_size            => '10485760',
  ns_service_update_policy => {
    'meta2' => 'KEEP|1|1|',
    'sqlx'  => 'KEEP|1|1|',
    'rdir'  => 'KEEP|1|1|user_is_a_service=rawx'},
}
openiosds::account {'account-0':
  ns         => 'OPENIO',
  ipaddress  => $ipaddr,
  redis_host => $ipaddr,
  no_exec    => true,
}
openiosds::conscience {'conscience-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
openiosds::meta0 {'meta0-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
openiosds::meta1 {'meta1-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
openiosds::meta2 {'meta2-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
openiosds::rawx {'rawx-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
openiosds::rdir {'rdir-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  location  => "${hostname}-other",
  no_exec   => true,
}
openiosds::oioblobindexer {'oio-blob-indexer-rawx-0':
  ns        => 'OPENIO',
  no_exec   => true,
}
openiosds::oioeventagent {'oio-event-agent-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
openiosds::oioproxy {'oioproxy-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
openiosds::redis {'redis-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
openiosds::conscienceagent {'conscienceagent-0':
  ns        => 'OPENIO',
  no_exec   => true,
}
openiosds::beanstalkd {'beanstalkd-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
openiosds::ecd {'ecd-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
openiosds::oioswift {'oioswift-0':
  ns               => 'OPENIO',
  ipaddress        => '0.0.0.0',
  sds_proxy_url    => "http://${ipaddr}:6006",
  auth_system      => 'tempauth',
  tempauth_users   => $default_tempauth_users,
  memcache_servers => "${ipaddr}:6019",
  no_exec          => true,
}
openiosds::memcached {'memcached-0':
  ns        => 'OPENIO',
  ipaddress => $ipaddr,
  no_exec   => true,
}
