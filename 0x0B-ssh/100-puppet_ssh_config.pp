# Using Puppet to configure the default SSH settings for passwordless connection.

# Include the stdlib module for additional Puppet functionality.
include stdlib

# Configure the SSH client to use a specific private key for authentication.
file_line { 'SSH Private Key':
  path               => '/etc/ssh/ssh_config',
  line               => '    IdentityFile ~/.ssh/school',
  match              => '^[#]+[\s]*(?i)IdentityFile[\s]+~/.ssh/id_rsa$', # Match the line containing the default SSH private key path.
  replace            => true,
  append_on_no_match => true
}

# Explanation of the Regex Match:
#
# ^       Beginning of the line
# [#]*    At least one hash character (for commented lines)
# [\s]*   Zero or more white space characters
# (?i)    Case-insensitive match
# IdentityFile case-insensitive "IdentityFile"
# [\s]+   At least one whitespace character
# ~/.ssh/id_rsa The default SSH private key file path to be replaced
# $       End of the line

# Deny password authentication for enhanced security.
file_line { 'Deny Password Auth':
  path               => '/etc/ssh/ssh_config',
  line               => '    PasswordAuthentication no',
  match              => '^[#]+[\s]*(?i)PasswordAuthentication[\s]+(yes|no)$', # Match the line containing PasswordAuthentication with "yes" or "no" value.
  replace            => true,
  append_on_no_match => true
}

# Explanation of the Regex Match:
#
# ^       Beginning of the line
# [#]*    At least one hash character (for commented lines)
# [\s]*   Zero or more white space characters
# (?i)    Case-insensitive match
# PasswordAuthentication case-insensitive "PasswordAuthentication"
# [\s]+   At least one whitespace character
# (yes|no) Match "yes" or "no" for the PasswordAuthentication value
# $       End of the line
