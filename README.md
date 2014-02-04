# Jokes

## About
Jokes app is a simple app that allows mycroft to tell jokes. Someone can say "Mycroft tell me a joke" and mycroft will tell a random joke from `jokes.yml`. After it has exhausted all the jokes, it will reshuffle the jokes and start over again. Jokes app does not wait for a response before telling the next part of the joke. It uses a delay. The default delay is 1.5 seconds.

## Adding a joke
`jokes.yml` contains all the jokes for jokes app. There are four types of jokes:
* Knock Knock
* One Liners
* Normal
* Special

The jokes are organized by type. Please keep it that way. Also do not include punctuation at the end of your joke statements. It adds extra delay that we don't want.

### Knock Knock

```yaml
-
  type: knock_knock
  name: doris
  joke:
    set_up: Doris
    punchline: Doris locked, that's why I'm knocking
```

You may also specify `set_up_delay` and `punchline_delay`. `set_up_delay` is the delay between saying knock knock and the set up. `punchline_delay`is the delay between the set_up and the punchline.

### One Liners
```yaml
-
  type: one_liner
  name: shitzu
  joke: I went to the zoo the other day, there was only one dog in it. it was a shitzu
```

### Normal Jokes
```yaml
-
  type: normal
  name: hat
  joke:
    set_up: What did one hat say to another
    punchline: You stay here, I'll go on a head
```
You may also specify `delay`, which is the delay between the set up and the punchline. 

### Special jokes
Special jokes are any jokes that fall into the previous 3 categories. You must specify delays for all special joke phrases. The last one should be delay of 0.

```yaml
-
  type: special
  name: sally
  joke:
    -
      phrase: Why did sally fall off the swing
      delay: 2
    -
      phrase: Because she had no arms. Knock Knock
      delay: 2
    -
      phrase: Not Sally
      delay: 0
```
