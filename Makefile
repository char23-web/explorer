.PHONY: help setup install dev build test test-ci lint format clean

# Default target
help:
	@echo "Solana Explorer - Available Commands"
	@echo "===================================="
	@echo ""
	@echo "Setup & Installation:"
	@echo "  make setup      - Run initial project setup (installs pnpm, creates .env, installs deps)"
	@echo "  make install    - Install project dependencies"
	@echo ""
	@echo "Development:"
	@echo "  make dev        - Start development server"
	@echo "  make build      - Build for production"
	@echo ""
	@echo "Testing:"
	@echo "  make test       - Run tests in watch mode"
	@echo "  make test-ci    - Run tests once (CI mode)"
	@echo "  make coverage   - Run tests with coverage report"
	@echo ""
	@echo "Code Quality:"
	@echo "  make lint       - Run linter"
	@echo "  make format     - Check code formatting"
	@echo ""
	@echo "Storybook:"
	@echo "  make sb         - Start Storybook development server"
	@echo "  make build-sb   - Build Storybook"
	@echo ""
	@echo "Maintenance:"
	@echo "  make clean      - Clean build artifacts and dependencies"
	@echo ""

# Setup project
setup:
	@echo "Running setup script..."
	@bash setup.sh

# Install dependencies
install:
	@echo "Installing dependencies..."
	@pnpm install

# Development server
dev:
	@echo "Starting development server..."
	@pnpm dev

# Build for production
build:
	@echo "Building for production..."
	@pnpm build

# Run tests in watch mode
test:
	@echo "Running tests in watch mode..."
	@pnpm test

# Run tests once (CI mode)
test-ci:
	@echo "Running tests in CI mode..."
	@pnpm test:ci

# Run tests with coverage
coverage:
	@echo "Running tests with coverage..."
	@pnpm coverage

# Run linter
lint:
	@echo "Running linter..."
	@pnpm lint

# Check code formatting
format:
	@echo "Checking code formatting..."
	@pnpm format

# Start Storybook
sb:
	@echo "Starting Storybook..."
	@pnpm sb

# Build Storybook
build-sb:
	@echo "Building Storybook..."
	@pnpm build-sb

# Clean build artifacts and dependencies
clean:
	@echo "Cleaning build artifacts and dependencies..."
	@rm -rf node_modules
	@rm -rf .next
	@rm -rf out
	@rm -rf storybook-static
	@echo "Clean complete"
