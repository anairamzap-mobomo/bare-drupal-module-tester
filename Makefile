# Default Drupal version to test against if none is provided
DRUPAL_VERSION ?= "11.3"

# Initialize bare Drupal
.PHONY: init-drupal
init-drupal: ## Inits drupal installing dependencies.
	@echo "Initializing Drupal $(DRUPAL_VERSION) in the 'drupal-tester' directory..."
	./composer create-project drupal/recommended-project:$(DRUPAL_VERSION).x-dev@dev "drupal-tester"

init-ddev: ## Inits the ddev project with config inside the drupal-tester project root.
	cd drupal-tester && ddev config --project-name=drupal-tester --project-type=drupal11 --docroot=web

start: ## Starts the ddev project and installs drush, admin_toolbar and drupal core.
	@if [ ! "$$(ddev describe | grep OK)" ]; then \
		cd drupal-tester; \
		ddev auth ssh; \
		ddev start; \
		ddev composer require drush/drush; \
		ddev composer require 'drupal/admin_toolbar:^3.6'; \
		ddev drush site:install standard --account-name=admin --account-pass=admin -y; \
		ddev drush pm:enable admin_toolbar -y; \
		ddev drush cr && ddev launch; \
	fi

##############################################
# Development tools (xdebug, drupal dev mode).
##############################################
debug-on: # Turn on xdebug
	@echo "Enabling XDebug"
	ddev xdebug on

debug-off: # Turn off xdebug
	@echo "Disabling XDebug"
	ddev xdebug off

debug-mode: # Display the current mode
	ddev xdebug status

dev-mode-on: # Enables development mode disabling cache layers and enabling twig debug.
	@echo "Enabling development mode"
	ddev drush theme:dev on

dev-mode-off: # Disables development mode.
	@echo "Disabling development mode"
	ddev drush theme:dev off

