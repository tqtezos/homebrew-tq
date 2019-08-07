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

