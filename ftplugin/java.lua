local jdtls = require("jdtls")

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local lombok_jar = vim.fn.expand("~/.m2/repository/org/projectlombok/lombok/1.18.34/lombok-1.18.34.jar")
local jdtls_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local jdtls_config = jdtls_path .. "/config_linux"
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local capabilities = require("plugin.completion").capabilities

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }
  vim.keymap.set("n", "<leader>ee", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>ew", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>ei", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<leader>ed", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>e>", function() vim.lsp.buf.format({ async = true }) end, opts)
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-javaagent:" .. lombok_jar,
    "-Xms1g",
    "-Xmx2G",
    "-jar", jdtls_jar,
    "-configuration", jdtls_config,
    "-data", workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  on_attach = on_attach,
  capabilities = capabilities,
}

jdtls.start_or_attach(config)
