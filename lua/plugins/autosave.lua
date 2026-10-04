return {
  "okuuva/auto-save.nvim",
  version = "^1.0.0",
  cmd = "ASToggle",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    debounce_delay = 1000,
    condition = function(buf)
      -- claudecode's diff buffers: saving one accepts the change
      if vim.bo[buf].buftype == "acwrite" then
        return false
      end
      local b = vim.b[buf]
      if b.claudecode_diff_tab_name or b.claudecode_diff_new_win or b.claudecode_diff_target_win then
        return false
      end
      local name = vim.api.nvim_buf_get_name(buf)
      if name:match("%(proposed%)") or name:match("%(New%)") then
        return false
      end
      return true
    end,
  },
}
