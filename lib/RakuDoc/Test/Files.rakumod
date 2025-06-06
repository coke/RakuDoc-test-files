unit class RakuDoc::Test::Files;

=begin Overview

Utility methods for generating lists of files for testing.

By default, C<git ls-files> is used to generate the list
of files to process.

If files were passed as arguments on the command line, use those.

Finally, if the C<TEST_FILES> environment variable is set to
a space-separated list of files, use that.

Any files specified manually that don't exist are silently ignored.
Each method returning a list of files may have additional criteria.

=end Overview

#|(
    Are we working with all the files in the repository?

    See the overview for the rules.
)
method all-files() returns Bool {
    not (@*ARGS or %*ENV<TEST_FILES>);
}

#|(
    Return list of files to test without filtering by type.
)
method files() returns Iterable {
    my @files;

    if @*ARGS {
        @files = @*ARGS;
    } else {
        if %*ENV<TEST_FILES> {
            @files = %*ENV<TEST_FILES>.trim.split(/ \s /).grep(*.IO.e);
        } else {
            @files = qx<git ls-files>.lines;
        }
    }
    return @files.sort;
}

#|(
    Filter list of files to return only C<rakudoc> files.
)
method pods() returns Iterable {
    return $.files.grep({$_.ends-with: '.rakudoc'})
}

#|(
    Filter list of C<files> to return only C<rakudoc> and Markdown.
)
method documents() returns Iterable {
    return $.files.grep({$_.ends-with: '.rakudoc' or $_.ends-with: '.md'})
}

#|(
    Filter list of files to return only C<rakutest> files.
)
method tests() returns Iterable {
    return $.files.grep({$_.ends-with: '.rakutest'})
}
