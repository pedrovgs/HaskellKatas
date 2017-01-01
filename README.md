# HaskellKatas [![Build Status](https://travis-ci.org/pedrovgs/HaskellKatas.svg?branch=master)](https://travis-ci.org/pedrovgs/HaskellKatas)

Haskell training repository used to learn Haskell and functional programming.


### List of katas:

* [FizzBuzz](http://codingdojo.org/cgi-bin/index.pl?KataFizzBuzz).
* [String calculator](http://osherove.com/tdd-kata-1/).
* [Finding the right triangle](https://gist.github.com/pedrovgs/32189838165fbe5c9e773ede534b97f4).
* [Rock paper scissors](http://agilekatas.co.uk/katas/RockPaperScissors-Kata).


### Executing tests:

All these katas are covered using unit and [property based](https://en.wikipedia.org/wiki/QuickCheck) tests. If you want to build and execute the project tests you just need to install [Haskell](https://www.haskell.org/platform/) and [Stack](https://docs.haskellstack.org/en/stable/README/) and execute the following command:

```
stack build --test
```

If you want to review if there is any pending execution branch to be covered you can generate a coverage report executing the following command:

```
stack build --test --coverage
```

As some of the tests have been developed using [QuickCheck](https://wiki.haskell.org/Introduction_to_QuickCheck2) if you want to review the input used for our tests you can replace any ``property`` invocation in any spec for ``verboseCheck``. Doing this all the values used as input will be shown on the terminal before to execute any property based test.

If you are going to modify the code or just review the implementation from any IDE I strongly recommend you to install [Atom](https://atom.io/) following this [guide](https://github.com/simonmichael/haskell-atom-setup) to set up the whole Haskell environment in a few minutes.


![HaskellLogo](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/Haskell-Logo.svg/245px-Haskell-Logo.svg.png)

Developed By
------------

* Pedro Vicente Gómez Sánchez - <pedrovicente.gomez@gmail.com>

<a href="https://twitter.com/pedro_g_s">
  <img alt="Follow me on Twitter" src="https://image.freepik.com/iconos-gratis/twitter-logo_318-40209.jpg" height="60" width="60"/>
</a>
<a href="https://es.linkedin.com/in/pedrovgs">
  <img alt="Add me to Linkedin" src="https://image.freepik.com/iconos-gratis/boton-del-logotipo-linkedin_318-84979.png" height="60" width="60"/>
</a>

License
-------

    Copyright 2017 Pedro Vicente Gómez Sánchez

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
