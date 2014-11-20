[Lessons learned in CoffeeScript](http://evansolomon.me/notes/lessons-learned-in-coffeescript/)
#Always return something#
By far my favorite CoffeeScript feature is its implicit return values. CoffeeScript functions will automatically return their final values, even without using the return keyword. If you have a function with multiple possible final values, like an if/else conditional, the CoffeeScript compiler is smart about making sure both are return’d. I consistently forgot about this feature at first, and for a while it seemed a little weird, but as I used it more I really started to love it for two reasons. First, it’s a good assumption that the last thing a function does is the best thing for it to return, and at least as good as returning undefined. Second, it means I can always assume that a function returns something.

我：适时地return value或者return，以避免不必要的“表达式返回值”和“IIF(Immediately Inovation of Function)”

#Always be explicit#
CoffeeScript automatically handles one of the most annoying parts of JavaScript, declaring local variables with the var keyword. Any variable you use in CoffeeScript is automatically declared with var at the top of its scope, which is awesome. On the other hand, that means that if you want to use non-local variables you have to explicitly declare them. This confused me a bit at first but now I really enjoy being forced to use, for example, window.foo instead of just foo. It’s much clearer than the implicit approach and reduces lots of possible confusion.

我：可以以在顶部 localRef = this.globaVariable。后面直接用localRef

#Always be defensive#
I debated whether or not to include this one because I think there are some styles of defensive coding that are bad, but CoffeeScript does a great job with it. The easiest example of this is the top level closure that CoffeeScript wraps your code in by default. Most (good) JavaScript you see looks something like this: ( function() { ...some JS here... } )(). That is a closure and it contains the scope of your code so that you don’t accidentally pollute the global namespace. CoffeeScript does this for you automatically, which lets you remove a couple lines of syntactic cruft from your code. The automatic var declarations is another example of good, defensive assumptions. Another good one, which I won’t go into here, is function scope binding via the “fat arrow” syntax (=>).

我：JS中总要检查变量是否为null，undefined。有了Existential Operator方便了检查
