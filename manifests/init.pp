class php (
  $php_packages = ['php5', 'php5-fpm', 'php5-mysqlnd', 'php5-curl', 'php5-gd', 'php5-json', 'php5-mhash', 'php5-apcu', 'php-apc', 'php5-sqlite', 'php5-readline'],
  $php_ini = ''
  ){
  if $operatingsystem =~  /(?i-mx:ubuntu|debian)/  {
    $repo_class = 'php::ubunturepo'
    require $repo_class
  }

  if $operatingsystem =~  /(?i-mx:centos|fedora|redhat)/  {
    $repo_class = 'php::centosrepo'
    require $repo_class
  }

  package {$php_packages:
    ensure => latest,
    require => Class[$repo_class]
  }

  if $php_ini != '' {
	file {'/etc/php.ini':
		ensure => present,
		source => $php_ini
	}
	file {'/etc/php5/fpm/php.ini':
		ensure 	=> link,
		target 	=> '/etc/php.ini',
		require => File['/etc/php.ini'],
		onlyif 	=> "test -d /etc/php5/fpm"
	}
	file {'/etc/php5/cli/php.ini':
		ensure 	=> link,
		target 	=> '/etc/php.ini',
		require => File['/etc/php.ini'],
		onlyif 	=> "test -d /etc/php5/cli"
	}
  }
}
