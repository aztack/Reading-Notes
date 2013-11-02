http://dmitrysoshnikov.com/ecmascript/chapter-4-scope-chain/#function-life-cycle

- 闭包=函数体+[[scope]]
- [[scope]] 是在函数的internal的属性。在函数被创建的时候创建。包含所在上下文的‘作用域’（Scope）
- 某个函数执行时的 Scope = AO + [[scope]]
