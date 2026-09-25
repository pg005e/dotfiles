-- Attach jdtls on Java filetypes. Everything is built inside the callback so
-- it runs per-buffer (root_dir derived from the file, not nvim's cwd) and only
-- after the lazy-loaded (ft='java') nvim-jdtls plugin is available.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function(args)
    -- Find the project root from the current file, walking upward. vim.fs.find
    -- returns a list, so take the first match (nil-safe).
    local root_markers = { 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', '.git' }
    local marker = vim.fs.find(root_markers, {
      upward = true,
      path = vim.api.nvim_buf_get_name(args.buf),
    })[1]
    local root_dir = marker and vim.fs.dirname(marker) or vim.fn.getcwd()

    -- One workspace dir per project.
    local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
    local workspace_dir = vim.fn.expand('~/.cache/jdtls/workspace/') .. project_name

    local config = {
      cmd = {
        'java', -- Ensure 'java' is in your $PATH, or provide the full path
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/config_linux'), -- Use config_mac or config_win as needed
        '-data', workspace_dir,
      },
      root_dir = root_dir,
      settings = {
        java = {
          project = {
            referencedLibraries = {
              "/home/prayush/javafx-sdk-21.0.2/lib/javafx-swt.jar",
              "/home/prayush/javafx-sdk-21.0.2/lib/javafx.base.jar",
              "/home/prayush/javafx-sdk-21.0.2/lib/javafx.controls.jar",
              "/home/prayush/javafx-sdk-21.0.2/lib/javafx.fxml.jar",
              "/home/prayush/javafx-sdk-21.0.2/lib/javafx.graphics.jar",
              "/home/prayush/javafx-sdk-21.0.2/lib/javafx.media.jar",
              "/home/prayush/javafx-sdk-21.0.2/lib/javafx.properties",
              "/home/prayush/javafx-sdk-21.0.2/lib/javafx.swing.jar",
              "/home/prayush/javafx-sdk-21.0.2/lib/javafx.web.jar",
            },
          },
        },
      },
      init_options = {
        bundles = {},
      },
    }

    require('jdtls').start_or_attach(config)
  end,
})
