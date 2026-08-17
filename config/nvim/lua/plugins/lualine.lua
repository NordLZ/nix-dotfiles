local function parse_hex(int_color)
  return string.format("#%x", int_color)
end

local function get_hl(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local group = get_hl(0, { name = name })

    local hl = {
      fg = group.fg == nil and "NONE" or parse_hex(group.fg),
      bg = group.bg == nil and "NONE" or parse_hex(group.bg),
    }

    return hl
  end
  return fallback or {}
end

local function get_buffer_count()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.bo[buf].buftype ~= "nofile" then
      count = count + 1
    end
  end
  return count
end

local function active_lsp()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if next(clients) == nil then
    return 'No LSP'
  end

  local c = {}
  for _, client in pairs(clients) do
    table.insert(c, client.name)
  end
  return 'LSP: ' .. table.concat(c, ', ')
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = function()
      local filetype_map = {
        lazy = { name = "lazy.nvim", icon = "💤" },
      }

      return {
        options = {
          component_separators = { left = " ", right = " " },
          section_separators = { left = " ", right = " " },
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { { "branch", icon = "" } },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = "󰝶 ",
              },
            },
            {
              function()
                local devicons = require("nvim-web-devicons")
                local ft = vim.bo.filetype
                local icon
                if filetype_map[ft] then
                  return " " .. filetype_map[ft].icon
                end
                if icon == nil then
                  icon = devicons.get_icon(vim.fn.expand("%:t"))
                end
                if icon == nil then
                  icon = devicons.get_icon_by_filetype(ft)
                end
                if icon == nil then
                  icon = " 󰈤"
                end

                return icon .. " "
              end,
              color = function()
                local _, hl = require("nvim-web-devicons").get_icon(vim.fn.expand("%:t"))
                if hl then
                  return hl
                end
                return get_hl("Normal")
              end,
              separator = "",
              padding = { left = 0, right = 0 },
            },
            {
              "filename",
              padding = { left = 0, right = 0 },
              fmt = function(name)
                if filetype_map[vim.bo.filetype] then
                  return filetype_map[vim.bo.filetype].name
                else
                  return name
                end
              end,
            },
            {
              function()
                local buffer_count = get_buffer_count()
                return "+" .. buffer_count - 1 .. " "
              end,
              cond = function()
                return get_buffer_count() > 1
              end,
              color = get_hl("Operator"),
              padding = { left = 0, right = 1 },
            },
            {
              function()
                local tab_count = vim.fn.tabpagenr("$")
                if tab_count > 1 then
                  return vim.fn.tabpagenr() .. " of " .. tab_count
                end
              end,
              cond = function()
                return vim.fn.tabpagenr("$") > 1
              end,
              icon = "󰓩",
              color = get_hl("Special"),
            },
          },
          lualine_x = {
            active_lsp,
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = get_hl("String"),
            },
            {
              function()
                return vim.bo.filetype
              end,
              color = function()
                local _, hl = require("nvim-web-devicons").get_icon(vim.fn.expand("%:t"))
                if hl then
                  return hl
                end
                return get_hl("Normal")
              end,
              separator = "",
            },
            -- { "diff" },
          },
          lualine_y = {
            {
              "progress",
            },
            {
              "location",
              color = get_hl("Boolean"),
            },
          },
          lualine_z = {
            {
              "datetime",
              style = "  %H:%M",
            },
          },
        },
      }
    end
  }
}
