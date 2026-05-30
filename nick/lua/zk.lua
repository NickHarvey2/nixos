require("zk").setup({
  picker = "telescope"
})

vim.api.nvim_create_user_command('Qwerty', function(opts)
  -- local newIndent = tonumber(opts.args)
  local cmd = 'exa -DT --absolute --no-quotes | sed "s|^.*$(pwd)|.|" | sort -r'
  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      vim.notify(data[1])
    end
  })
end, { desc = "", nargs = 0 })

