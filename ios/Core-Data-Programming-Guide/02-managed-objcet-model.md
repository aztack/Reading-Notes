托管对象模型 Managed Object Models
====
Core Data需要你为应用中的实体（entity）创建schema，以描述它们属性和相互关系。这个schema就是用`托管对象模型`来表示的。
每个模型对应于一个`NSManagedObjectModel`实例。

下面介绍如何创建和使用它。

下面先介绍一下什么是`实体`（entity）：

Entitiy
----

- 每个模型都包含多个`NSentityDescription`对象用来表示模型中的实体。
- 实体中两个重要的部分是：实体名和运行时用来表示这个实体的类名。注意二者的区别
- `NSentityDescription`实例可能包含`NSAttributeDescription`和`NSRelationshipDescription`对象
- 还可能包含`NSFetchedPropertyDescription`对象
- 还有抓取请求模板，用`NSFetchRequest`实例表示

在模型中，实体可以被组织成继承关系，可以是抽象的。

下面介绍一下实体继承：

Entity Inheritance
----

和类继承相似

![Figure 1  Selecting a parent entity in Xcode]
(https://developer.apple.com/library/ios/documentation/cocoa/conceptual/CoreData/Art/xcodeparententity_2x.png)

> If you want to create an entity inheritance hierarchy in code, you must build it top-down. You cannot set an entity’s super-entity directly, you can only set an entity’s sub-entities (using the method setSubentities:). To set a super-entity for a given entity, you must therefore set an array of sub-entities for that super entity and include the current entity in that array.

Abstract Entities
----

