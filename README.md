# Drupal module tester
A bare drupal to test custom or contrib modules.
Uses a Makefile to init Drupal and ddev project.

## Docs
1. Clone the repo in your desired directory
```
git clone git@github.com:anairamzap-mobomo/bare-drupal-module-tester.git
```
2. Init Drupal 
```
make init-drupal
```
If no parameters are passed Drupal 11.3.x-dev will be used.

You can change the Drupal version passing `make init-drupal DRUPAL_VERSION="11.4"` for example.

3. Init the ddev project 
```
make init-ddev
```
4. Install drupal and dependencies and launch ddev 
```
make start
```
5. Install the module/s you want to test. For example: `cd drupal-tester && ddev composer require 'drupal/pathauto:^1.15'`

**NOTE**: To run composer or drush you must always cd into the `drupal-tester` module. That's where the drupal project is :)
