---
title: front matter is dropped
---

# viewme sample

A **bold**, *italic*, ~~struck~~ and `inline code` line with a [link](https://example.com "Example") and a bare https://example.org/path URL.
Second line with a hard break.  
Third line.

> [!NOTE]
> Alerts work like on GitHub.

> A plain blockquote
> over two lines.

## Lists

- one
- two
  - nested a
  - nested b
- three

1. first
2. second
   1. inner

- [x] done task
- [ ] open task

## Code

```python
def greet(name):
    # say hello
    return f"hello {name}" if name else None
```

```bash
echo "hi" # comment
```

    indented code

## Table

| Name  | Qty | Price |
|:------|:---:|------:|
| Apple |  3  |  1.50 |
| Pear  | 12  | 10.25 |

## HTML

<details><summary>Click me</summary>

Hidden **markdown** content.

</details>

<p align="center"><b>centered</b> <kbd>Ctrl</kbd>+<kbd>C</kbd></p>

<script>alert("xss")</script>
<img src="javascript:alert(1)" onerror="alert(2)">
[bad](javascript:alert(3))

![local image](docs/none.png)

[other doc](other.md) and [ref link][r1].

[r1]: https://example.net "Ref"

---

Setext Heading
--------------

Escaped \*stars\* and a footer.
