Overview
========

Utility methods for generating lists of files for testing.

By default, `git ls-files` is used to generate the list of files to process.

If files were passed as arguments on the command line, use those.

Finally, if the `TEST_FILES` environment variable is set to a space-separated list of files, use that.

Any files specified manually that don't exist are silently ignored. Each method returning a list of files may have additional criteria.

### method all-files

```raku
method all-files() returns Bool
```

Are we working with all the files in the repository? See the overview for the rules.

### method files

```raku
method files() returns Iterable
```

Return list of files to test without filtering by type.

### method pods

```raku
method pods() returns Iterable
```

Filter list of files to return only C<rakudoc> files.

### method documents

```raku
method documents() returns Iterable
```

Filter list of C<files> to return only C<rakudoc> and Markdown.

### method tests

```raku
method tests() returns Iterable
```

Filter list of files to return only C<rakutest> files.

