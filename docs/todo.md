# What Do I Want to Accomplish?

- I want to have a node library that downloads all daily data for an instrument from TradingView.
- I want that to be a part of a pnpm workspace.
- Do the above without racket, just normal js setup.
- I want to be able to generate that code using racket. At first, just copy files or use plain text for generation.


- Use `gm-trading` for reference when creating the workspace.
- First things to do:
  - Add:
    - `.gitignore`
    - `.ignore`
    - `nx.json`
    - `package.json`
      - Just with name, empty scripts, and devDependencies with latest version of `nx`.
    - `pnpm-workspace.yaml`
  - Preserve:
    - `node_modules\`
    - `pnpm-lock.yaml`


- deletion
  - accept string, list of strings, regex, or list of regexes
