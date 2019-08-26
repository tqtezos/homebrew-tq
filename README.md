# homebrew-tq

A [Homebrew](https://brew.sh/) Tap for [TQ Tezos](https://tqtezos.com/)'s formulae.


## How do I install these formulae?

To setup the Tap so Homebrew can find this formulae, run:

```bash
brew tap TQTezos/homebrew-tq https://gitlab.com/TQTezos/homebrew-tq.git
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
brew install TQTezos/homebrew-tq/<formula>
```


### To use the Tap with SSH

Run the following instead of the above `https` command:

```bash
brew tap TQTezos/homebrew-tq git@gitlab.com:TQTezos/homebrew-tq.git
```

## Updating the bottles

Build the bottles:

```bash
brew test-bot --root-url=https://bintray.com/michaeljklein/bottles-tq \
  --bintray-org=michaeljklein --tap=TQTezos/homebrew-tq TQTezos/homebrew-tq/tezos
brew test-bot --root-url=https://bintray.com/michaeljklein/bottles-tq \
  --bintray-org=michaeljklein --tap=TQTezos/homebrew-tq TQTezos/homebrew-tq/lorentz-contract-param
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


