# == Class: profiles::jenkins::slave
# ================================
#
# Install and configure a Jenkins slave
#
class profiles::jenkins::slave {
  include ::epel

  if str2bool("$::is_pe") {
    provider_gem => 'pe_gem'
  } else {
    provider_gem => 'gem'
  }

  #
  # Support for Puppet
  #
  package { 'puppet-lint':
    ensure   => latest,
    provider => $provider_gem,
  }
  # Add puppet-lint plugins
  # On GitHub from: puppet-community, camptocamp, fiddyspence, floek,
  #                 jpmasters, llowder, ninech, relud, robertpearce
  $puppet_lint_plugins = [
    'puppet-lint-absolute_classname-check',
    'puppet-lint-absolute_template_path',
    'puppet-lint-alias-check',
    'puppet-lint-appends-check',
    'puppet-lint-classes_and_types_beginning_with_digits-check',
    'puppet-lint-empty_string-check',
    'puppet-lint-file_ensure-check',
    'puppet-lint-file_source_rights-check',
    'puppet-lint-fileserver-check',
    'puppet-lint-global_resource-check',
    'puppet-lint-leading_zero-check',
    'puppet-lint-numericvariable',
    'puppet-lint-param-docs',
    'puppet-lint-resource_outside_class-check',
    'puppet-lint-roles_and_profiles-check',
    'puppet-lint-security-plugins',
    'puppet-lint-spaceship_operator_without_tag-check',
    'puppet-lint-strict_indent-check',
    'puppet-lint-trailing_comma-check',
    'puppet-lint-trailing_newline-check',
    'puppet-lint-undef_in_function-check',
    'puppet-lint-unquoted_string-check',
    'puppet-lint-usascii_format-check',
    'puppet-lint-variable_contains_upcase',
    'puppet-lint-version_comparison-check',
    #'puppet-lint-vim_modeline-check',
  ]
  package { $puppet_lint_plugins :
    ensure   => latest,
    provider => $provider_gem,
  }
  package { 'metadata-json-lint':
    ensure   => latest,
    provider => $provider_gem,
  }
  $r10k_gems = [ 'r10k', 'r10kdiff' ]
  package { $r10k_gems :
    ensure   => latest,
    provider => $provider_gem,
  }

  #
  # Shell
  #
  # gem shlint

  package { 'redhat-lsb': ensure => latest, }
  package { 'jq': ensure => latest, }
}
