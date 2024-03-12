return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  -- colorscheme = "catppuccin",
  colorscheme = "dracula",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "tex", "latex"
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/user/snippets"})
    require("luasnip").config.set_config({
      -- Autotriggered snippets
      enable_autosnippets = true,

      -- Tab to trigger visual selection
      store_selection_keys = "<Tab>"
    })

    -- LaTeX local settings
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.tex",
      callback = function()
        vim.opt_local.shiftwidth = 1
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "csa"
        vim.opt_local.textwidth = 80
        vim.opt_local.wrapmargin = 2
        vim.opt_local.formatoptions = "tcq"
        vim.opt_local.colorcolumn = "81"
        -- add item on Enter in itemize/enumerate/description
        vim.cmd([[
          function! AddItem()
            let [end_lnum, end_col] = searchpairpos('\\begin{', '', '\\end{', 'nW')
            if match(getline(end_lnum), '\(itemize\|enumerate\|description\)') != -1
              return "\\item "
            else
              return ""
            endif
          endfunction
          inoremap <expr><buffer> <CR> getline('.') =~ '\item $' 
            \ ? '<c-w><c-w>' 
            \ : (col(".") < col("$") ? '<CR>' : '<CR>'.AddItem() )
          nnoremap <expr><buffer> o "o".AddItem()
          nnoremap <expr><buffer> O "O".AddItem()
        ]])
      end
    })

    -- Python local settings
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.py",
      callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.spell = false
        vim.opt_local.textwidth = 79
        vim.opt_local.colorcolumn = "80"
        vim.opt_local.expandtab = true
        vim.opt_local.autoindent = true
        vim.opt_local.fileformat = "unix"
      end
    })

    -- HTML, JS, CSS local settings
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = { "*.html", "*.jinja", "*.jinja2", "*.css", "*.scss", "*.sass", "*.js", "*.ts", "*.jsx", "*.tsx" },
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.spell = false
      end
    })

    -- Custom commands for loading Web and Python plugins
    -- vim.api.nvim_create_user_command('WebDev', 'echo "Web Development plugins loaded."', { nargs = 0})
    -- vim.api.nvim_create_user_command('PythonDev', 'echo "Python Development plugins loaded."', { nargs = 0})

    -- The setup config table shows all available config options with their default values:
    require("presence").setup({
        -- General options
        auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
        main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
        client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
        log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number  = false,                      -- Displays the current line number instead of the current project
        blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
        show_time           = true,                       -- Show the timer

        -- Rich Presence text options
        editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    })
    
    -- Restore cursor to beam upon exit
    vim.api.nvim_create_autocmd("ExitPre", {
	    group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	    command = "set guicursor=a:ver90",
	    desc = "Set cursor back to beam when leaving Neovim."
    }) 
  end,
}
