# == Class: profiles::jenkins::slave
# ================================
#
# Install and configure a Jenkins slave
#
class profiles::jenkins::slave {
  include epel

  #
  # Support for Puppet
  #
  package { 'puppet-lint':
    ensure   => latest,
    provider => 'pe_gem',
  }
  # Add puppet-lint plugins
  $puppet_lint_plugins = [
    'puppet-lint-absolute_template_path',
    'puppet-lint-param-docs', 'puppet-lint-roles_and_profiles-check',
    'puppet-lint-strict_indent-check', 'puppet-lint-trailing_newline-check',
    'puppet-lint-unquoted_string-check', 'puppet-lint-variable_contains_upcase'
  ]
  package { $puppet_lint_plugins :
    ensure   => latest,
    provider => 'pe_gem',
  }

  package { 'lsb': ensure => latest, }
  package { 'jq': ensure => latest, }
}
