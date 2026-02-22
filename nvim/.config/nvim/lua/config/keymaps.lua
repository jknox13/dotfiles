local map = vim.keymap.set

-- Consistency with C, D
map("n", "Y", "y$")

-- Hard mode
map("n", "<Up>", "<nop>")
map("n", "<Down>", "<nop>")
map("n", "<Left>", "<nop>")
map("n", "<Right>", "<nop>")

-- Edit relative to current file
map("n", "<leader>eh", ":edit %:h/")

-- Edit / source config
map("n", "<leader>i", ":edit ~/.config/nvim/init.lua<CR>")
map("n", "<leader><CR>", ":source ~/.config/nvim/init.lua<CR>")

-- Directory helpers
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")
map("n", "<leader>lcd", ":lcd %:p:h<CR>:pwd<CR>")

-- Spelling
map("n", "<leader>sp", ":setlocal spell spelllang=en_us<CR>")

-- Insert / command home & end
map("i", "<C-a>", "<home>")
map("i", "<C-e>", "<end>")
map("c", "<C-a>", "<home>")
map("c", "<C-e>", "<end>")

-- Colorscheme switching
map("n", "<leader>csd", ':let ayucolor="dark"<bar>:colorscheme ayu<CR>')
map("n", "<leader>csm", ':let ayucolor="mirage"<bar>:colorscheme ayu<CR>')
map("n", "<leader>csl", ':let ayucolor="light"<bar>:colorscheme ayu<CR>')
