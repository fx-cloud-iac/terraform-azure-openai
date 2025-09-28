# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.2] - 2025-04-30

### Changed
- Fixed version provider azurerm to use stricter
- Changed configuration terraform in pipeline Jenkins to use the image 5519/terraform-jenkins-agent

## [2.0.1] - 2025-04-21

### Fixed
- Update dependency module source

## [2.0.0] - 2025-13-10

### Changed
- the "name" variable now require valide format to match naming convention

## [1.3.2] - 2024-11-05

### Changed
- Updated READMEs to redirect users to user guide and examples

## [1.3.1] - 2024-10-24

### Added
- Support for DEV-TI-TA use case for PrivateEndpoint subnet name

## [1.3.0] - 2024-07-25

### Added
- Power platform subscription targets

## [1.2.1] - 2023-12-07

### Fixed
- Set `default_action` to `Allow` when public network access is enabled

## [1.2.0] - 2023-12-07

### Updated
- Not creating a private endpoint if network is public

## [1.1.0] - 2023-12-07

### Added
- Ability to customize network & local auth parameters

## [1.0.2] - 2023-08-01

### Added
- New meaningful variable descriptions

## [1.0.1] - 2023-08-01

### Added
- New tests to ensure service is created & healthy

### Changed
- Jenkinsfile to always use latest shared library

## [1.0.0] - 2023-07-31

### Added
- Azure OpenAI module creation
