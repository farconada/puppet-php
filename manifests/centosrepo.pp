class php::centosrepo {
	  $osver = split($::operatingsystemrelease, '[.]')
	  $mirrorlist = $osver[0] ? {
	    '5' => 'http://repo.webtatic.com/yum/centos/5/$basearch/mirrorlist',
	    '6' => 'http://repo.webtatic.com/yum/el6/$basearch/mirrorlist',
	    '7' => 'http://repo.webtatic.com/yum/el7/$basearch/mirrorlist',
	  }
	  $gpgkey = $osver[0] ? {
	    '7'     => 'https://mirror.webtatic.com/yum/RPM-GPG-KEY-webtatic-el7',
	    default => 'https://mirror.webtatic.com/yum/RPM-GPG-KEY-webtatic-andy'
	  }
	  yumrepo { 'webtatic':
	    descr         => 'Webtatic Repository $releasever - $basearch',
	    mirrorlist    => $mirrorlist,
	    enabled       => 1,
	    gpgcheck      => 1,
	    gpgkey        => $gpgkey,
	    priority      => 1,
	  }
}
