-- Startup profiling script to identify slow plugins
-- Add this to your init.lua temporarily to profile startup times

local start_time = vim.loop.hrtime()

-- Function to measure and log plugin loading time
local function time_plugin(plugin_name, func)
  local plugin_start = vim.loop.hrtime()
  func()
  local plugin_end = vim.loop.hrtime()
  local plugin_time = (plugin_end - plugin_start) / 1000000 -- Convert to milliseconds
  print(string.format("Plugin '%s' loaded in %.2f ms", plugin_name, plugin_time))
  return plugin_time
end

-- Store timing results
local plugin_times = {}

-- Profile require calls
local original_require = require
_G.require = function(module_name)
  if module_name:match("^acidleroy") or 
     module_name:match("telescope") or
     module_name:match("treesitter") or
     module_name:match("lsp") or
     module_name:match("mason") or
     module_name:match("cmp") or
     module_name:match("harpoon") or
     module_name:match("nvim%-tree") or
     module_name:match("bufferline") or
     module_name:match("leap") or
     module_name:match("zen%-mode") or
     module_name:match("copilot") or
     module_name:match("undotree") or
     module_name:match("fugitive") or
     module_name:match("gruvbox") then
    
    local start = vim.loop.hrtime()
    local result = original_require(module_name)
    local end_time = vim.loop.hrtime()
    local load_time = (end_time - start) / 1000000
    
    if load_time > 1 then -- Only log if > 1ms
      plugin_times[module_name] = load_time
      print(string.format("Module '%s' required in %.2f ms", module_name, load_time))
    end
    
    return result
  else
    return original_require(module_name)
  end
end

-- Add autocmd to print final results
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local total_time = (vim.loop.hrtime() - start_time) / 1000000
    print("\n=== STARTUP PROFILING RESULTS ===")
    print(string.format("Total startup time: %.2f ms", total_time))
    print("\nSlowest modules (>1ms):")
    
    -- Sort plugins by load time
    local sorted_plugins = {}
    for plugin, time in pairs(plugin_times) do
      table.insert(sorted_plugins, {plugin = plugin, time = time})
    end
    
    table.sort(sorted_plugins, function(a, b) return a.time > b.time end)
    
    for i, entry in ipairs(sorted_plugins) do
      if i <= 10 then -- Show top 10
        print(string.format("%d. %s: %.2f ms", i, entry.plugin, entry.time))
      end
    end
    
    print("\nRecommendation: Consider lazy loading the slowest plugins above.")
    print("=====================================\n")
  end
})
