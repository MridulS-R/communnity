# Ensure Tailwind build runs before assets:precompile even when
# Render uses the default Ruby build command.
Rake::Task["assets:precompile"].enhance(["tailwindcss:build"]) if Rake::Task.task_defined?("assets:precompile")

