if lvim.builtin.dap.active == true then
  local dap_install = require('dap-install')
  dap_install.config('go_delve_dbg', {})
end
