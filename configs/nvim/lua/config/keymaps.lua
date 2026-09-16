-- Custom keymaps

local map = vim.keymap.set

-- Scroll half-page: center cursor line to middle first, then scroll
map({ "n", "v" }, "<C-d>", "zz<C-d>", { desc = "Scroll down (center first)" })
map({ "n", "v" }, "<C-u>", "zz<C-u>", { desc = "Scroll up (center first)" })

-- Close/Delete current buffer (:bd) with <leader>d (and <leader>x)
map("n", "<leader>d", function()
  if Snacks and Snacks.bufdelete then
    Snacks.bufdelete()
  else
    vim.cmd("bdelete")
  end
end, { desc = "Delete/Close Buffer (:bd)" })

map("n", "<leader>x", function()
  if Snacks and Snacks.bufdelete then
    Snacks.bufdelete()
  else
    vim.cmd("bdelete")
  end
end, { desc = "Delete/Close Buffer (:bd)" })
