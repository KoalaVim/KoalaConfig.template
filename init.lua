------------------------------
-- This file is the entry point of a neovim configuration
--
-- In order to load the config with KoalaVim we load:
--     1. KoalaVim - loads kvim.conf, then registers the loading of the configs below
--     2. lazy.nvim - Loads the plugins (LazyVim -> KoalaVim -> user plugins), and then in this order:
--         a. LazyVim config - keymaps, options, autocmds
--         b. KoalaVim config - keymaps, options, usercmds, autocmds (Overrides LazyVim config)
--         c. User config (`lua/config/`) - keymaps, options, usercmds, autocmds (Overrides KoalaVim config)
------------------------------

------------------------------
-- Remap space as leader key to set the keymaps with correct leader key
------------------------------

-- TODO: [configure me] set different leader key
local leader_key = ' '

------------------------------
-- Load KoalaVim config
------------------------------
require('koala_init').load_koala(leader_key)

------------------------------
-- Load user config
-- `lua/config/` is loaded by LazyVim and KoalaVim, don't require it here (it would load twice)
------------------------------

-- Lazy load config/lazy after KoalaVim
vim.api.nvim_create_autocmd('User', {
	pattern = 'KoalaVimStarted',
	callback = function()
		require('KoalaVim.utils.require_dir').recursive_require('config_lazy')
	end,
})

------------------------------
-- Load lazy.nvim
------------------------------
require('koala_init').load_lazy({
	-- lazy.nvim user spec (combined with KoalaVim spec, loaded after it)
	user_spec = {
		{ import = 'plugins' },
	},
	-- lazy.nvim user opts (overrides KoalaVim lazy.nvim opts)
	lazy_opts = {
		install = {
			-- TODO: [configure me] set your colorscheme
			colorscheme = { 'ofirkai' }, -- Which colorscheme to let lazy.nvim load first
		},
	},
})
