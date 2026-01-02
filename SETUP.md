# Project Setup Guide

This guide will help you set up the Solana Explorer project for local development.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **Node.js**: Version ^18.20 or ^20.19 (specified in `package.json`)
- **pnpm**: Version 9.10.0 (package manager)
- **Git**: For cloning the repository

## Quick Start

The fastest way to set up the project is using the automated setup script:

```bash
# Clone the repository
git clone https://github.com/char23-web/explorer.git
cd explorer

# Run the setup script
bash setup.sh
```

The setup script will:
1. Check your Node.js version
2. Install pnpm version 9.10.0 if not already installed
3. Create a `.env` file from `.env.example`
4. Install all project dependencies

## Manual Setup

If you prefer to set up the project manually, follow these steps:

### 1. Install pnpm

Install the specific version of pnpm required by this project:

```bash
npm install -g pnpm@9.10.0
```

### 2. Configure Environment Variables

Create a `.env` file from the example template:

```bash
cp .env.example .env
```

**Important:** Update the `.env` file with your custom RPC URLs. Do not use the public endpoints (`api.mainnet-beta.solana.com` or `api.devnet.solana.com`) as they will rate-limit your requests. Use endpoints from your own Solana RPC provider.

Required environment variables:
- `NEXT_PUBLIC_MAINNET_RPC_URL` - Your mainnet RPC endpoint
- `NEXT_PUBLIC_DEVNET_RPC_URL` - Your devnet RPC endpoint
- `NEXT_PUBLIC_TESTNET_RPC_URL` - Your testnet RPC endpoint

### 3. Install Dependencies

Install all project dependencies using pnpm:

```bash
pnpm install
```

This will install all packages specified in `package.json`, including both dependencies and devDependencies.

## Using Make Commands

The project includes a Makefile with convenient shortcuts for common tasks. To see all available commands:

```bash
make help
```

Common commands:
- `make setup` - Run initial project setup
- `make dev` - Start development server
- `make build` - Build for production
- `make test` - Run tests
- `make lint` - Run linter

## Development

### Start the Development Server

```bash
pnpm dev
# or
make dev
```

This will start the Next.js development server on [http://localhost:3000](http://localhost:3000). The page will automatically reload when you make changes.

### Build for Production

```bash
pnpm build
# or
make build
```

This creates an optimized production build of the application.

### Run Tests

```bash
# Run tests in watch mode (for development)
pnpm test

# Run tests once (for CI)
pnpm test:ci

# Run tests with coverage
pnpm coverage
```

### Code Quality

```bash
# Run linter
pnpm lint

# Check code formatting
pnpm format
```

## Troubleshooting

### Sass Dependency Errors

If you encounter sass dependency errors:

1. Make sure you have pnpm version 9.10.0
2. Stash your changes: `git stash`
3. Reset your environment: `rm -rf node_modules && git reset --hard HEAD`
4. Reinstall: `pnpm install`
5. Reapply your changes: `git stash pop`

### Port Already in Use

If port 3000 is already in use, you can specify a different port:

```bash
PORT=3001 pnpm dev
```

### Build Failures

If the build fails:

1. Ensure all environment variables are set in `.env`
2. Clear the Next.js cache: `rm -rf .next`
3. Reinstall dependencies: `rm -rf node_modules && pnpm install`
4. Try building again: `pnpm build`

### Rate Limiting Issues

If you're experiencing rate limiting:

1. Verify that you're using custom RPC URLs in your `.env` file
2. Do not use the public Solana endpoints
3. Consider using a dedicated RPC provider like QuickNode, Helius, or Triton

## Project Structure

```
explorer/
├── app/                    # Next.js app directory with pages and components
├── public/                 # Static assets
├── scripts/                # Utility scripts
├── docs/                   # Documentation
├── .storybook/            # Storybook configuration
├── .github/               # GitHub Actions workflows
├── package.json           # Project dependencies and scripts
├── tsconfig.json          # TypeScript configuration
├── next.config.mjs        # Next.js configuration
├── tailwind.config.ts     # Tailwind CSS configuration
├── setup.sh               # Automated setup script
├── Makefile               # Make commands for common tasks
└── SETUP.md               # This file
```

## Additional Resources

- [CONTRIBUTING.md](./CONTRIBUTING.md) - Contribution guidelines
- [README.md](./README.md) - Project overview
- [Next.js Documentation](https://nextjs.org/docs)
- [Solana Documentation](https://docs.solana.com/)

## Getting Help

If you encounter issues not covered in this guide:

1. Check the [CONTRIBUTING.md](./CONTRIBUTING.md) guide
2. Search existing [GitHub Issues](https://github.com/char23-web/explorer/issues)
3. Create a new issue with:
   - Clear description of the problem
   - Steps to reproduce
   - Your environment (OS, Node.js version, pnpm version)
   - Error messages or logs

## Next Steps

Once setup is complete:

1. Review the [CONTRIBUTING.md](./CONTRIBUTING.md) guide if you plan to contribute
2. Explore the codebase starting with `app/` directory
3. Run the development server and test the application
4. Check out the documentation in the `docs/` directory

Happy coding! 🚀
