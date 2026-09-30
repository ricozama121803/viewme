import importlib.machinery, importlib.util, pathlib, unittest

path = pathlib.Path(__file__).resolve().parent.parent / "viewme"
loader = importlib.machinery.SourceFileLoader("viewme", str(path))
spec = importlib.util.spec_from_loader("viewme", loader)
viewme = importlib.util.module_from_spec(spec)
loader.exec_module(viewme)


def render(md, cur_dir="."):
    return viewme.Renderer().render(md, cur_dir)


class RenderTests(unittest.TestCase):
    def test_inline(self):
        out = render("**b** *i* ~~s~~ `c<x>`")
        for frag in ("<strong>b</strong>", "<em>i</em>", "<del>s</del>", "<code>c&lt;x&gt;</code>"):
            self.assertIn(frag, out)

    def test_heading_ids_unique(self):
        out = render("# A\n\n# A\n")
        self.assertIn('id="a"', out)
        self.assertIn('id="a-1"', out)

    def test_table_alignment(self):
        out = render("| a | b |\n|:-:|--:|\n| 1 | 2 |\n")
        self.assertIn("text-align:center", out)
        self.assertIn("text-align:right", out)

    def test_nested_list_and_tasks(self):
        out = render("- a\n  - b\n- [x] c\n")
        self.assertEqual(out.count("<ul>"), 2)
        self.assertIn("checked", out)

    def test_code_fence_escapes(self):
        self.assertIn("&lt;b&gt;", render("```\n<b>\n```"))

    def test_xss_is_neutralised(self):
        out = render('<script>alert(1)</script>\n\n<img src="javascript:x" onerror="y">\n\n[a](javascript:alert(1))')
        self.assertNotIn("<script", out)
        self.assertNotIn("onerror", out)
        self.assertNotIn("javascript:", out)

    def test_relative_urls_are_local_and_confined(self):
        self.assertIn('href="/doc/docs/x.md"', render("[x](x.md)", "docs"))
        self.assertIn('src="/raw/img/a.png"', render("![a](img/a.png)"))
        self.assertNotIn("/raw/", render("![a](../../etc/passwd)"))

    def test_alert(self):
        self.assertIn("alert-note", render("> [!NOTE]\n> hi"))


if __name__ == "__main__":
    unittest.main()
