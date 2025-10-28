{
  # opencode.nvim configuration using the custom module
  # This enables plugins.opencode.enable support
  #
  # Requirements:
  # - Install opencode CLI: curl -fsSL https://opencode.ai/install | bash
  # - Or: npm i -g opencode-ai
  #
  # Run `:checkhealth opencode` after setup to verify installation
  #
  # For more info: https://github.com/NickvanDyke/opencode.nvim

  plugins.snacks.enable = true;

  plugins.opencode = {
    enable = true;
    # Optional: Override the package (defaults to pkgs.vimPlugins.opencode-nvim)
    # package = pkgs.vimPlugins.opencode-nvim;
    # Configure plugin settings
    settings = {
      input.enabled = true;
      auto_reload = true;
      provider = {
        enabled = "snacks";
        snacks = {
          win = {
            enter = true;
          };
        };
      };
    };
  };

  keymaps = [
    # Ask opencode (with submit)
    {
      mode = [
        "n"
        "x"
      ];
      key = "<C-a>";
      action.__raw = ''function() require("opencode").ask("@this: ", { submit = true }) end'';
      options = {
        desc = "Ask opencode…";
      };
    }

    # Execute opencode action
    {
      mode = [
        "n"
        "x"
      ];
      key = "<C-x>";
      action.__raw = ''function() require("opencode").select() end'';
      options = {
        desc = "Execute opencode action…";
      };
    }

    # Toggle opencode
    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-.>";
      action.__raw = ''function() require("opencode").toggle() end'';
      options = {
        desc = "Toggle opencode";
      };
    }
    # Add range to opencode (operator)
    {
      mode = [
        "n"
        "x"
      ];
      key = "go";
      action.__raw = ''function() return require("opencode").operator("@this ") end'';
      options = {
        desc = "Add range to opencode";
        expr = true;
      };
    }

    # Add line to opencode (operator)
    {
      mode = "n";
      key = "goo";
      action.__raw = ''function() return require("opencode").operator("@this ") .. "_" end'';
      options = {
        desc = "Add line to opencode";
        expr = true;
      };
    }
    # Scroll opencode up
    {
      mode = "n";
      key = "<S-C-u>";
      action.__raw = ''function() require("opencode").command("session.half.page.up") end'';
      options = {
        desc = "Scroll opencode up";
      };
    }

    # Scroll opencode down
    {
      mode = "n";
      key = "<S-C-d>";
      action.__raw = ''function() require("opencode").command("session.half.page.down") end'';
      options = {
        desc = "Scroll opencode down";
      };
    }
    # Remap increment (since <C-a> is used by opencode)
    {
      mode = "n";
      key = "+";
      action = "<C-a>";
      options = {
        desc = "Increment under cursor";
        noremap = true;
      };
    }

    # Remap decrement (since <C-x> is used by opencode)
    {
      mode = "n";
      key = "-";
      action = "<C-x>";
      options = {
        desc = "Decrement under cursor";
        noremap = true;
      };
    }
  ];
}
