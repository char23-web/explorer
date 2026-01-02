#!/bin/bash

# Solana Explorer Setup Script
# This script automates the setup process for the Solana Explorer project

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Required versions
REQUIRED_PNPM_VERSION="9.10.0"

echo "=========================================="
echo "Solana Explorer Setup"
echo "=========================================="
echo ""

# Check Node.js version
echo "Checking Node.js version..."
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed${NC}"
    echo "Please install Node.js version ^18.20 or ^20.19"
    exit 1
fi

NODE_VERSION=$(node --version | cut -d'v' -f2)
echo "Found Node.js version: $NODE_VERSION"

# Check if Node version meets minimum requirements
# Extract major and minor version
NODE_MAJOR=$(echo $NODE_VERSION | cut -d. -f1)
NODE_MINOR=$(echo $NODE_VERSION | cut -d. -f2)

# Check if version is 18.20+ or 20.19+, with upper bound of 22
if [[ $NODE_MAJOR -eq 18 ]] && [[ $NODE_MINOR -ge 20 ]]; then
    # Node 18.20 or higher
    NODE_OK=true
elif [[ $NODE_MAJOR -eq 20 ]] && [[ $NODE_MINOR -ge 19 ]]; then
    # Node 20.19 or higher
    NODE_OK=true
elif [[ $NODE_MAJOR -eq 21 ]]; then
    # Node 21.x
    NODE_OK=true
elif [[ $NODE_MAJOR -gt 21 ]] && [[ $NODE_MAJOR -le 22 ]]; then
    # Node 22.x (allow with warning)
    NODE_OK=true
    echo -e "${YELLOW}Warning: Node.js version $NODE_VERSION has not been tested. Recommended versions are ^18.20 or ^20.19${NC}"
else
    NODE_OK=false
fi

if [[ "$NODE_OK" != "true" ]]; then
    echo -e "${RED}Error: Node.js version $NODE_VERSION does not meet requirements${NC}"
    echo "Required: ^18.20 or ^20.19"
    echo "Current: $NODE_VERSION"
    exit 1
fi

echo -e "${GREEN}✓ Node.js version is compatible${NC}"
echo ""

# Check if pnpm is installed
echo "Checking pnpm installation..."
if ! command -v pnpm &> /dev/null; then
    echo -e "${YELLOW}pnpm is not installed. Installing pnpm version $REQUIRED_PNPM_VERSION...${NC}"
    npm install -g pnpm@$REQUIRED_PNPM_VERSION
else
    PNPM_VERSION=$(pnpm --version)
    echo "Found pnpm version: $PNPM_VERSION"
    
    if [[ "$PNPM_VERSION" != "$REQUIRED_PNPM_VERSION" ]]; then
        echo -e "${YELLOW}Warning: pnpm version $PNPM_VERSION does not match required version $REQUIRED_PNPM_VERSION${NC}"
        echo "Installing correct version..."
        npm install -g pnpm@$REQUIRED_PNPM_VERSION
    else
        echo -e "${GREEN}✓ pnpm version is correct${NC}"
    fi
fi
echo ""

# Create .env file if it doesn't exist
echo "Setting up environment configuration..."
if [ ! -f .env ]; then
    echo "Creating .env file from .env.example..."
    cp .env.example .env
    echo -e "${GREEN}✓ .env file created${NC}"
    echo -e "${YELLOW}Note: Please update .env with your custom RPC URLs to avoid rate limiting${NC}"
else
    echo -e "${GREEN}✓ .env file already exists${NC}"
fi
echo ""

# Install dependencies
echo "Installing project dependencies..."
echo "This may take a few minutes..."
pnpm install

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Dependencies installed successfully${NC}"
else
    echo -e "${RED}Error: Failed to install dependencies${NC}"
    exit 1
fi
echo ""

echo "=========================================="
echo -e "${GREEN}Setup completed successfully!${NC}"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Update .env file with your custom RPC URLs"
echo "  2. Run 'pnpm dev' to start the development server"
echo "  3. Open http://localhost:3000 in your browser"
echo ""
echo "Available commands:"
echo "  pnpm dev        - Start development server"
echo "  pnpm build      - Build for production"
echo "  pnpm test       - Run tests in watch mode"
echo "  pnpm test:ci    - Run tests once (CI mode)"
echo "  pnpm lint       - Run linter"
echo "  pnpm format     - Check code formatting"
echo ""
