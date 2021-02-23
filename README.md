# homebrew-tq

<span style="color: #900; font-size: 300%">⚠ This repository is NOT maintained ☣</span>

**PLEASE FIND BOTTLES AT** [serokell/tezos-packaging](https://github.com/serokell/tezos-packaging/releases/tag/v8.2-1)

**ADDITIONALLY YOU MAY ADD THEIR TAP BY ISSUING THE FOLLOWING COMMAND**

``` bash
brew tap serokell/tezos-packaging https://github.com/serokell/tezos-packaging.git
```

A [Homebrew](https://brew.sh/) Tap for [TQ Tezos](https://tqtezos.com/)'s formulae.


## How do I install these formulae?

To setup the Tap so Homebrew can find this formulae, run:

```bash
brew tap tqtezos/homebrew-tq https://github.com/tqtezos/homebrew-tq.git
```

To install a particular formula whose name is unique to this Tap, run:

```bash
brew install <formula>
```

For example, to install [Tezos](https://gitlab.com/tezos/tezos)
(including the [`tezos-client`](https://tezos.gitlab.io/master/introduction/howtouse.html)), run:

```bash
brew install tezos
```

Otherwise, run:

```bash
brew install tqtezos/homebrew-tq/<formula>
```


### To use the Tap with SSH

Run the following instead of the above `https` command:

```bash
brew tap tqtezos/homebrew-tq git@github.com:tqtezos/homebrew-tq.git
```

## Updating the bottles

Build the bottles:

```bash
brew test-bot --root-url=https://bintray.com/michaeljklein/bottles-tq \
  --bintray-org=michaeljklein --tap=tqtezos/homebrew-tq tqtezos/homebrew-tq/tezos
brew test-bot --root-url=https://bintray.com/michaeljklein/bottles-tq \
  --bintray-org=michaeljklein --tap=tqtezos/homebrew-tq tqtezos/homebrew-tq/lorentz-contract-param
brew test-bot --root-url=https://bintray.com/michaeljklein/bottles-tq \
  --bintray-org=michaeljklein --tap=tqtezos/homebrew-tq tqtezos/homebrew-tq/lorentz-contracts-sale
```

Set the environment variables to upload the bottles:

```bash
export HOMEBREW_BINTRAY_USER="michaeljklein"
export HOMEBREW_BINTRAY_KEY="API_KEY_HERE"
```


Add packages for each formula: `tezos`, `lorentz-contract-param`

```bash
brew test-bot --ci-upload --git-name=michaeljklein --git-email=michael@tqgroup.io \
  --bintray-org=michaeljklein --root-url=https://bintray.com/michaeljklein/bottles-tq
```
