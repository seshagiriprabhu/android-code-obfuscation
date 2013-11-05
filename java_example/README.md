Java class obfuscation using merge
=================================

Class hello:
------------

```java
class hello { 
    void m() {
        System.out.println("Hello");
    }
}
```

Class: world (malicous)
----------------------

```java
class world {
    void n() {
        System.out.println("World");
    }
}
```

Class: hellouser
----------------
```java
class hellouser {
    hellouser() {
        hello obj = new hello();
        obj.m();     
    }
    public static void main(String[] args) {
        hellouser huser = new hellouser();
    }
}
```

Class: Worlduser
----------------
```java
class worlduser {
    worlduser() {
        world obj = new world();
        obj.n();
    }
    public static void main(String[] args) {
        worlduser wuser = new worlduser();
    }
}
```

## Merging

We remove class `world` and we merge it with class `hello`. i.e we copy
all the methods from class `world` to class `hello`.

 
Class:hello
-----------
```java
class hello {
    void m() {
        System.out.println("Hello");
    }
    void n() {
        System.out.println("World");
    }
}
```

Class: hellouser (modified)
---------------------------
```java 
class hellouser {
    hellouser() {
        hello obj = new hello();
        obj.m();
    }
    public static void main(String[] args) {
        hellouser hobj = new hellouser();
    }
}
```

Class: worlduser (modified)
---------------------------

```java
class worlduser {
    worlduser() {
        hello obj = new hello();
        obj.n();
    }
    public static void main(String[] args) {
        worlduser wobj = new worlduser();
    }
}
```

## How to compile it on GNU/Linux operating systems?

Install java compiler
---------------------

```bash
$ sudo apt-get install ecj-gcj
```

Compile the programs
--------------------

```bash
$ javac *.java
```

Run the program
---------------
```bash
$ java CLASSNAME
```
CLASSNAME = {'hellouser', 'hellouser\_new', 'worlduser',
'worlduser\_new'}
