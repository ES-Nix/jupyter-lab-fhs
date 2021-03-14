


From https://gist.github.com/tbenst/c8247a1abcf318d231c396dcdd1f5304

TODO: check if the fork of the gist has some diff


```
nix build .#julia-fhs
result/bin/julia-fhs -c 'julia --version'
```

In two steps:

```
nix develop
```

```
env
```

Note: the environment variables isolation comes from the `exec` with the `-c` flag.

file /usr/lib/locale/locale-archive

