vim.g.mapleader = " "
vim.keymap.set("n","<leader>pv", vim.cmd.Ex)

vim.api.nvim_create_user_command("DiffOrig", function()
  if vim.fn.expand("%") == "" then
    vim.notify("No file associated with current buffer", vim.log.levels.WARN)
    return
  end

  vim.cmd("vert new")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false

  vim.cmd("read ++edit #")
  vim.cmd("0delete _")

  vim.cmd("diffthis")
  vim.cmd("wincmd p")
  vim.cmd("diffthis")
end, {})

