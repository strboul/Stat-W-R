#Wickham, H. (2011). testthat: Get started with testing. The R Journal, 3(1), 5-10.

#Test structure
#1.Expectation: "binary assertion about whether or not a value is as you expect." && "What the result of a computation should be. Does it have the right value and right class? Does it produce error messages when you expect it to? There are 11 types of built-in expectations."

###"expect_that(a, equals(b)) reads as “I expect that a will equal b”. If the expectation isn’t true, testthat will raise an error."

#2.Test: "groups together multiple expectations to test one function"

#3.Context: "groups together multiple tests that test related functionality."

library(testthat)
library(stringr)

#equals() uses all.equal() to check for equality with numerical tolerance.
# Passes
expect_that(10, equals(10))
# Also passes
expect_that(10, equals(10 + 1e-7))
# Fails
expect_that(10, equals(10 + 1e-6))
# Definitely fails!
expect_that(10, equals(11))

#is_identical_to() uses identical() to check for exact equality
# Passes
expect_that(10, is_identical_to(10))
# Fails
expect_that(10, is_identical_to(10 + 1e-10))

#is_equivalent_to() is a more relaxed version of equals() that ignores attributes
# Fails
expect_that(c("one" = 1, "two" = 2),
            equals(1:2))
# Passes
expect_that(c("one" = 1, "two" = 2),
            is_equivalent_to(1:2))

#is_a() checks that an object inherit()s from a specified class
model <- lm(mpg ~ wt, data = mtcars)
# Passes
expect_that(model, is_a("lm"))
# Fails
expect_that(model, is_a("glm"))

#matches() matches a character vector against a regular expression. The optional all argu- ment controls where all elements or just one element need to match.
string <- "Testing is fun!"
# Passes
expect_that(string, matches("Testing"))
# Fails, match is case-sensitive
expect_that(string, matches("testing"))
# Passes, match can be a regular expression
expect_that(string, matches("t.+ting"))

#prints_text() matches the printed output from an expression against a regular expression
a <- list(1:10, letters)
# Passes
expect_that(str(a), prints_text("List of 2"))
# Fails
expect_that(str(a),
            prints_text(fixed("int [1:10]")))

#shows_message() checks that an expression shows a message

# Passes
expect_that(library(mgcv),
            shows_message("This is mgcv"))

#gives_warning() expects that you get a warning
# Passes
expect_that(log(-1), gives_warning())
expect_that(log(-1),
            gives_warning("NaNs produced"))
# Fails
expect_that(log(0), gives_warning())

#throws_error() verifies that the expression throws an error. You can also supply a regular expression which is applied to the text of the error.
# Fails
expect_that(1 / 2, throws_error())
# Passes
expect_that(1 / "a", throws_error())
# But better to be explicit
expect_that(1 / "a",
            throws_error("non-numeric argument"))

#is_true() is a useful catchall if none of the other expectations do what you want - it checks that an expression is true. is_false() is the complement of is_true().

is_true <- function() {
  function(x) {
    expectation( identical(x, TRUE), "isn't true"
    ) }
}
