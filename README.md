# HaskellKatas

<img alt="Follow me on X" src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/Haskell-Logo.svg/245px-Haskell-Logo.svg.png" height="60" width="82"/>

Haskell training repository used to learn Haskell and functional programming.

### List of katas:

* [FizzBuzz](http://codingdojo.org/cgi-bin/index.pl?KataFizzBuzz).
* [String calculator](http://osherove.com/tdd-kata-1/).
* [Finding the right triangle](https://gist.github.com/pedrovgs/32189838165fbe5c9e773ede534b97f4).
* [Rock paper scissors](http://agilekatas.co.uk/katas/RockPaperScissors-Kata).
* [Bingo](http://agilekatas.co.uk/katas/Bingo-Kata).
* [Potter](http://codingdojo.org/kata/Potter/).
* [Roman numerals](http://codingdojo.org/cgi-bin/index.pl?KataRomanNumerals).
* [Prime factors](https://www.rubyplus.com/articles/511-TDD-Beyond-Basics-Prime-Factors-Kata).
* [Fibonacci](https://medium.com/@chmeese/fibonacci-kata-93773b30dbb2#.3opu63eoj).
* [Contacts](https://github.com/Karumi/KataContactsJava).


### Development environment:

If you are going to modify the code or just review the implementation from any IDE I strongly recommend you to install [Atom](https://atom.io/) following this [guide](https://github.com/simonmichael/haskell-atom-setup) to set up the whole Haskell environment in a few minutes.

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

Some of our tests and katas work with random values. The Bingo Kata is an example. Remember that you can generate a ``StdGen`` instance from a seed value using ``read "12 33" :: StdGen`` when ``"12 33"`` is the result of ``show mkStdGen 1``.

### Debug logs:

Debug logs are a common way to debug programs. In imperative languages, we can just sprinkle the code with print statements to standard output or to some as log file in order to track debug information (e.g. value of a particular variable, or some human-readable message). In Haskell, however, we cannot output any information other than through the IO monad; and we don't want to introduce that just for debugging. To deal with this problem, the standard library provides the Debug.Trace. That module exports a function called trace which provides a convenient way to attach debug print statements anywhere in a program.

You can always add a trace importing the ``Debug.Trace`` module and using the ``trace`` function which receives a ``String`` and a expression ``a -> a`` which will be evaluated as a second param:

```haskell
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = trace ("n: " ++ show n) $ fib (n - 1) + fib (n - 2)
```

Developed By
------------

* Pedro Vicente Gómez Sánchez - <pedrovicente.gomez@gmail.com>

<a href="https://x.com/pedro_g_s">
  <img alt="Follow me on X" src="https://img.icons8.com/?size=100&id=6Fsj3rv2DCmG&format=png&color=000000" height="60" width="60"/>
</a>
<a href="https://es.linkedin.com/in/pedrovgs">
  <img alt="Add me to Linkedin" src="https://img.icons8.com/?size=100&id=447&format=png&color=000000" height="60" width="60"/>
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
