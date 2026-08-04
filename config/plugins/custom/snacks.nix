{ config, lib, ... }:
{
  plugins.snacks = {
    enable = true;

    settings = {
      bigfile = {
        enabled = true;
      };
      dashboard = {
        preset = {
          pick = null;
          keys = [
            {
              icon = " ";
              key = "f";
              desc = "Find File";
              action = ":lua Snacks.dashboard.pick('files')";
            }
            {
              icon = " ";
              key = "n";
              desc = "New File";
              action = ":ene | startinsert";
            }
            {
              icon = " ";
              key = "g";
              desc = "Find Text";
              action = ":lua Snacks.dashboard.pick('live_grep')";
            }
            {
              icon = " ";
              key = "r";
              desc = "Recent Files";
              action = ":lua Snacks.dashboard.pick('oldfiles')";
            }
            {
              icon = " ";
              key = "c";
              desc = "Config";
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})";
            }
            {
              icon = " ";
              key = "s";
              desc = "Restore Session";
              section = "session";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = ":qa";
            }
          ];
          header = ''
                                                                                
                  ████ ██████           █████      ██                     
                 ███████████             █████                             
                 █████████ ███████████████████ ███   ███████████   
                █████████  ███    █████████████ █████ ██████████████   
               █████████ ██████████ █████████ █████ █████ ████ █████   
             ███████████ ███    ███ █████████ █████ █████ ████ █████  
            ██████  █████████████████████ ████ █████ █████ ████ ██████ 
          '';
        };
        sections = [
          { section = "header"; }
          {
            section = "keys";
            indent = 1;
            padding = 1;
          }
          {
            section = "recent_files";
            icon = " ";
            title = "Recent Files";
            indent = 3;
            padding = 2;
          }
        ];
      };
      explorer = {
        enabled = false;
      };
      indent = {
        enabled = true;
      };
      input = {
        enabled = false;
      };
      picker = {
        enabled = false;
      };
      notifier = {
        enabled = false;
      };
      quickfile = {
        enabled = true;
      };
      scope = {
        enabled = false;
      };
      statuscolumn = {
        enabled = false;
      };
      words = {
        enabled = false;
      };
      rename = {
        enabled = true;
      };
      zen = {
        enabled = true;
        toggles = {
          ufo = true;
          dim = true;
          git_signs = false;
          diagnostics = false;
          line_number = false;
          relative_number = false;
          signcolumn = "no";
          indent = false;
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>bd";
      action.__raw = "function() Snacks.bufdelete() end";
      options = {
        desc = "Buffer delete";
      };
    }
    {
      mode = "n";
      key = "<leader>ba";
      action.__raw = "function() Snacks.bufdelete.all() end";
      options = {
        desc = "Buffer delete all";
      };
    }
    {
      mode = "n";
      key = "<leader>bo";
      action.__raw = "function() Snacks.bufdelete.other() end";
      options = {
        desc = "Buffer delete other";
      };
    }
    {
      mode = "n";
      key = "<leader>bz";
      action.__raw = "function() Snacks.zen() end";
      options = {
        desc = "Toggle Zen Mode";
      };
    }
  ];

  autoCmd = [
    {
      event = [ "User" ];
      pattern = "OilActionsPost";
      callback.__raw = ''
        function(event)
          if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end
      '';
    }
  ];

  extraConfigLua = ''
    if Snacks and Snacks.toggle then
      Snacks.toggle.new({
        id = "ufo",
        name = "Enable/Disable ufo",
        get = function()
          local ok, ufo = pcall(require, "ufo")
          if ok then
            return ufo.inspect()
          end
          return false
        end,
        set = function(state)
          if state == nil then
            pcall(function() require("noice").enable() end)
            pcall(function() require("ufo").enable() end)
            vim.o.foldenable = true
            vim.o.foldcolumn = "1"
          else
            pcall(function() require("noice").disable() end)
            pcall(function() require("ufo").disable() end)
            vim.o.foldenable = false
            vim.o.foldcolumn = "0"
          end
        end,
      })
    end
  '';
}
