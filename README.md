# Proto Repository

A centralized, "single source of truth" for gRPC service definitions. This repository manages `.proto` files, handles linting/formatting via **Buf v2**, and generates type-safe **TypeScript** code for downstream services.

## 🚀 Quick Start

### Prerequisites
* [Buf CLI](https://buf.build/docs/installation) installed.
* [Go](https://go.dev/) (optional, if using Go plugins).
* [Node.js](https://nodejs.org/) (for TypeScript runtime support).

### Setup
1. Clone the repository.
2. Run the initialization suite:
   ```bash
   make all
   ```

---

## 🛠 Development Workflow

We use a `Makefile` to automate the Protobuf lifecycle. This ensures consistency across all development environments.

| Command         | Description |
|:----------------| :--- |
| `make format`   | Automatically fix indentation and style in `.proto` files. |
| `make lint`     | Run the Buf linter (ignores Google internal protos). |
| `make generate` | Clean the `gen/` directory and regenerate TypeScript code. |
| `make commit`   | **Interactive:** Build a Conventional Commit with numeric type selection. |

---

## 📂 Project Structure

```text
.
├── proto/             # Raw .proto definitions
│   └── services/      # Domain-specific services
├── codegen/               # Generated code (Git ignored)
├── buf.yaml           # Buf v2 configuration (Lint/Breaking rules)
├── buf.gen.yaml       # Generation strategy (Plugins)
└── Makefile           # Automation engine
```

---

## 📝 Commit Standards

This project follows the **Conventional Commits** specification. When using `make commit-pro`, you will be prompted to select a type:

1. **feat**: A new feature (e.g., a new RPC or message).
2. **fix**: A bug fix in a definition or configuration.
3. **chore**: Maintenance (updating dependencies, CI/CD).
4. **docs**: Changes to documentation or comments.
5. **refactor**: Rearranging protos without changing logic.
6. **style**: Formatting changes only.

**Format:** `<type>(<scope>): <subject>`

---

## 📦 Consumption

To use the generated TypeScript definitions in your application:

1. **Install dependencies**:
   ```bash
   npm install @bufbuild/protobuf @connectrpc/connect @connectrpc/connect-web
   ```
2. **Import code**:
   ```typescript
   import { UserService } from "./gen/ts/services/v1/user_connect";
   ```

---

## 🛡 License
Internal Proprietary / MIT (Choose your license)