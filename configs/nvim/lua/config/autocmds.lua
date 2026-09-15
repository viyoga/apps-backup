-- Disable line wrap for markdown so table borders stay aligned
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown.mdx" },
  callback = function()
    vim.opt_local.wrap = false
  end,
  desc = "Disable wrap in markdown (keeps render-markdown table borders intact)",
})

-- Noctalia live-reload bridge (see journal 2026-09-15): matugen.lua's own
-- SIGUSR1 handle is GC-bait and base16 never fires ColorScheme, so do the
-- re-setup + event here. Anchored handle; idempotent; order-safe.
_G._noctalia_reload = _G._noctalia_reload or {}
do
  local sig = vim.uv.new_signal()
  -- Anchor the handle: an unreferenced uv handle is GC-collected and its
  -- callback silently stops firing. This was the actual live bug.
  _G._noctalia_reload.sig = sig
  sig:start("sigusr1", function()
    vim.schedule(function()
      package.loaded["matugen"] = nil
      local ok, matugen = pcall(require, "matugen")
      if ok then
        local ok2, err = pcall(matugen.setup)
        if not ok2 then
          vim.notify("Noctalia theme reload FAILED: " .. tostring(err), vim.log.levels.ERROR)
        end
      else
        vim.notify("Noctalia theme reload: require failed", vim.log.levels.ERROR)
      end
      vim.cmd("doautocmd ColorScheme")
    end)
  end)
end
