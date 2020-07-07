# frozen_string_literal: true

module Script
  module Messages
    MESSAGES = {
      script: {
        error: {
          generic: "{{red:{{x}} Error}}",
          eacces_cause: "You don't have permission to write to this directory.",
          eacces_help: "Change your directory permissions and try again.",

          enospc_cause: "You don't have enough disk space to perform this action.",
          enospc_help: "Free up some space and try again.",

          oauth_cause: "Something went wrong while authenticating your account with the Partner Dashboard.",
          oauth_help: "Try again.",

          invalid_context_cause: "Your .shopify-cli.yml file is not correct.",
          invalid_context_help: "See https://help.shopify.com",

          no_existing_apps_cause: "You don't have any apps.",
          no_existing_apps_help: "Please create an app with {{command:shopify create}} or"\
                                 "visit https://partners.shopify.com/.",

          no_existing_orgs_cause: "You don't have any partner organizations.",
          no_existing_orgs_help: "Please visit https://partners.shopify.com/ to create a partners account.",

          no_existing_stores_cause: "You don't have any development stores.",
          no_existing_stores_help: "Visit https://partners.shopify.com/%{organization_id}/stores/ to create one.",

          project_exists_cause: "Directory with the same name as the script already exists.",
          project_exists_help: "Use different script name and try again.",

          invalid_extension_cause: "Invalid extension point %s",
          invalid_extension_help: "Allowed values: %s.",

          script_not_found_cause: "Couldn't find script %s for extension point %s",

          app_not_installed_cause: "App not installed on development store.",

          app_script_undefined_help: "Push script to app.",

          build_error_cause: "Something went wrong while building the script.",
          build_error_help: "Correct the errors and try again.",

          dependency_install_cause: "Something went wrong while installing the dependencies that are needed.",
          dependency_install_help: "Correct the errors and try again.",

          forbidden_error_cause: "You do not have permission to do this action.",

          graphql_error_cause: "An error was returned: %s.",
          graphql_error_help: "\nReview the error and try again.",

          script_repush_cause: "A script with the same extension point already exists on app (API key: %s).",
          script_repush_help: "Use {{cyan:--force}} to replace the existing script.",

          shop_auth_cause: "Unable to authenticate with the store.",
          shop_auth_help: "Try again.",

          shop_script_conflict_cause: "Another app in this store has already enabled a script "\
                                      "on this extension point.",
          shop_script_conflict_help: "Disable that script or uninstall that app and try again.",

          shop_script_undefined_cause: "Script is already turned off in development store.",
        },

        create: {
          help: <<~HELP,
          {{command:%1$s create script}}: Creates a script project.
            Usage: {{command:%1$s create script}}
          HELP
          extended_help: <<~HELP,
            \s\sOptions:
              \s\s{{command:--name=NAME}} Script project name. Use any string.
              \s\s{{command:--extension_point=TYPE}} Extension point name. Allowed values: %2$s.
          HELP

          error: {
            operation_failed: "Script not created.",
          },

          changed_dir: "{{v}} Changed to project directory: {{green:%{folder}}}",
          script_created: "{{v}} Script created: {{green:%{script_id}}}",
          creating: "Creating script",
          created: "Created script",
        },

        push: {
          help: <<~HELP,
          Build the script and put it into production. If you've already pushed a script with the same extension point, use --force to replace the current script with the newest one.
            Usage: {{command:%s push}}
          HELP
          extended_help: <<~HELP,
            \s\sOptions:
              \s\s{{command:--API_key=<API_key>}} API key. Must be a valid API key, otherwise store access fails.
              \s\s{{command:[--force]}} Forces the script to be overwritten if an instance of it already exists.
          HELP

          error: {
            operation_failed: "Script not pushed.",
          },

          script_pushed: "{{v}} Script pushed to app (API key: %{api_key}).",
        },

        disable: {
          help: <<~HELP,
          Turn off script in development store.
            Usage: {{command:%s disable}}
          HELP
          extended_help: <<~HELP,
            \s\sOptions:
              \s\s{{command:--API_key=<API_key>}} API key. Must be a valid API key, otherwise store access fails.
              \s\s{{command:--shop_domain=<my_store.myshopify.com>}} Test store URL. Must be an existing test store.
          HELP

          error: {
            operation_failed: "Can't disable script.",
          },

          script_disabled: "{{v}} Script disabled. Script is turned off in development store.",
        },

        enable: {
          help: <<~HELP,
          Turn on script in development store.
            Usage: {{command:%s enable}}
          HELP
          extended_help: <<~HELP,
            \s\sOptions:
              \s\s{{command:--API_key=<API_key>}} API key. Must be a valid API key, otherwise store access fails.
              \s\s{{command:--shop_domain=<my_store.myshopify.com>}} Test store URL. Must be an existing test store.
              \s\s{{command:--config_props='name1:value1, name2:value2'}} Optional. Define the configuration of your script by passing individual name and value pairs. If used with --config_file, then matching values in --config_props will override those set in the file.
              \s\s{{command:--config_file=<path/to/JSONFilename>}} Optional. Define the configuration of your script using a JSON formatted file. --config_props values override properties in this file.
          HELP

          info: "{{*}} A script always remains enabled until you disable it - even after pushing "\
                "script changes with the same extension point to an app. To disable a script, use "\
                "the 'disable' command.",

          error: {
            operation_failed: "Can't enable script.",
          },

          script_enabled: "{{v}} Script enabled. %{type} script %{title} in app (API key: %{api_key}) "\
                          "is turned on in development store {{green:%{shop_domain}}}",
        },

        project_deps: {
          none_required: "{{v}} None required",
          checking_with_npm: "Checking dependencies with npm",
          installing: "Dependencies installing",
          installed: "Missing dependencies installed",
        },

        test: {
          help: <<~HELP,
          Runs unit tests on your script.
            Usage: {{command:%s test}}
          HELP

          error: {
            operation_failed: "Tests didn't run or they ran with failures.",
          },

          running: "Running tests",
          success: "{{v}} Tests finished.",
        },

        forms: {
          create: {
            select_extension_point: "Which extension point do you want to use?",
            script_name: "Script Name",

            error: {
              invalid_name: "Invalid script name: replace or remove unsupported characters. Valid "\
                            "characters are numbers, letters, spaces, hyphens, or underscores.",
            },
          },
          script_form: {
            ask_app_api_key_default: "Which app do you want this script to belong to?",
            ask_shop_domain_default: "Select a development store",
            fetching_organizations: "{{i}} Fetching partner organizations",
            select_organization: "Select partner organization.",
            using_app: "Using app {{green:%{title} (%{api_key})}}.",
            using_development_store: "Using development store {{green:%{domain}}}",
            using_organization: "Partner organization {{green:%s}}.",
          },
          enable: {
            ask_app_api_key: "Which app is the script pushed to?",
            ask_shop_domain: "Which development store is the app installed on?",
          },
        },

        application: {
          building: "Building",
          building_script: "Building script",
          built: "Built",
          pushed: "{{v}} Pushed",
          disabled: "{{v}} Disabled",
          enabled: "{{v}} Enabled",
        },
      },
    }.freeze
  end
end
