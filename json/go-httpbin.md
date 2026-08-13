# go-httpbin Metadata

## Basic Information

- **Name**: go-httpbin
- **Type**: Container Script (CT)
- **Category**: Testing/Development Tools
- **Tags**: http-testing, debugging, api-testing, echo-server

## Description

HTTP testing service - provides 50+ endpoints for testing HTTP clients and applications. Zero-dependency Go implementation of httpbin service.

## Features

- 50+ HTTP endpoints for comprehensive testing
- Request inspection (headers, body, method)
- Configurable delays and redirects
- Multiple authentication methods
- Content type testing (JSON, XML, HTML, binary)
- WebSocket support
- Detailed request logging with LOG_REQUEST flag
- Minimal resource footprint

## Installation Method

- **Type**: LXC Container
- **Distro**: Debian
- **Default Port**: 8080

## Resource Requirements

### Minimum
- CPU: 1 core
- RAM: 256 MB
- Storage: 2 GB

### Recommended
- CPU: 2 cores
- RAM: 1 GB
- Storage: 5 GB

## Configuration Variables

- `HTTP_PORT` — HTTP listening port (default: 8080)
- `LOG_REQUEST` — Enable detailed request logging (default: false)
- `LOG_LEVEL` — Log level: DEBUG, INFO, WARN, ERROR, OFF (default: INFO)

## Notes

go-httpbin is a complete, zero-dependency Go port of Kenneth Reitz's httpbin service. Perfect for testing HTTP client implementations, debugging API interactions, and integration testing.

The LOG_REQUEST feature (enabled via flag or environment variable) logs incoming request details including headers, method, and body - useful for troubleshooting HTTP client issues.

All logs are sent to systemd journal and viewable via `journalctl -u go-httpbin -f`.

## Project Links

- GitHub: https://github.com/community-scripts/go-httpbin
- Original httpbin: https://httpbin.org
- Documentation: https://github.com/community-scripts/go-httpbin#readme

## Author

Community Scripts Contributors

## License

MIT License
