# omni-jupyter

This is a docker container of jupyter notebook supporting the following kernels simultaneously:

- IPython on Python2
- IPython on Python3
- IJulia
- IRuby
- IRKernel

## Installation

```
$ docker build .
```

## Usage

```
$ docker run -it -p 8888:8888 IMAGE
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

- 2015-10-15: First release

## Author

Kenta Murata

## License

MIT
