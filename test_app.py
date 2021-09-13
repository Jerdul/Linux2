import unittest

import hello


def test_sample_single_word():
    l = ('foo', 'bar', 'foobar')
    word = hello.sample(l)
    assert word in l
