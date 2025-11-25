-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
require("vim-options")
-- Setup lazy.nvim
require("lazy").setup("plugins")
vim.lsp.enable('clangd')


-- Git environment setup for bare repo (dotfiles managemen)

-- If you try to open a bare repo (like for managing dotfiles) with neovim, some plugins will complain about not being in a git repo.
-- You can fix this by creating a `.git` file (not directory) that points to your bare repo. Run this command:
-- ```bash
-- echo "gitdir: /home/pierluigi/.dotfiles-bare-repo" > ~/.git
-- ```
-- This tells Git (and any tools using libgit2 or Git commands) where the actual repository is located. This is the standard Git mechanism for detached worktrees and should make Snacks recognize the repo correctly.

local function update_git_env_for_dotfiles()
    -- Define the home directory and the location of your bare repo
    local home = vim.fn.expand("~")
    local git_dir = home .. "/.dotfiles-bare-repo" -- Replace .dotfiles.git with your bare repo name

    -- Check if the current directory is within the scope you want to manage with the bare repo
    -- For dotfiles, this is usually the home directory
    if vim.fn.getcwd() == home then
        vim.env.GIT_WORK_TREE = home
        vim.env.GIT_DIR = git_dir
    else
        -- Clear the variables if not in the bare repo's scope, so other repos work normally
        vim.env.GIT_WORK_TREE = nil
        vim.env.GIT_DIR = nil
    end
end

-- Set up an autocommand to run this function when Neovim starts or changes directory
vim.api.nvim_create_autocmd({"VimEnter", "BufEnter", "DirChanged"}, {
    callback = update_git_env_for_dotfiles,
    pattern = {"*"},
})
