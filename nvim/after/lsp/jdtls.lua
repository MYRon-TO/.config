return {
  settings = {
    java = {
      root_dir =
          {
            -- Single-module projects
            {
              'build.xml',           -- Ant
              'pom.xml',             -- Maven
              'settings.gradle',     -- Gradle
              'settings.gradle.kts', -- Gradle
            },
            -- Multi-module projects
            -- { 'build.gradle', 'build.gradle.kts' },
          } or vim.fn.getcwd(),
    }
  }
}
