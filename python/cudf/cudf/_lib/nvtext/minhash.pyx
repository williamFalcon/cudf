# Copyright (c) 2023-2024, NVIDIA CORPORATION.

from cudf.core.buffer import acquire_spill_lock

from libcpp.memory cimport unique_ptr
from libcpp.utility cimport move

from pylibcudf.libcudf.column.column cimport column
from pylibcudf.libcudf.column.column_view cimport column_view
from pylibcudf.libcudf.nvtext.minhash cimport (
    minhash as cpp_minhash,
    minhash64 as cpp_minhash64,
    minhash64_permuted as cpp_minhash64_permuted,
    minhash_permuted as cpp_minhash_permuted,
    word_minhash as cpp_word_minhash,
    word_minhash64 as cpp_word_minhash64,
)
from pylibcudf.libcudf.types cimport size_type

from cudf._lib.column cimport Column


@acquire_spill_lock()
def minhash(Column strings, Column seeds, int width):

    cdef column_view c_strings = strings.view()
    cdef size_type c_width = width
    cdef column_view c_seeds = seeds.view()
    cdef unique_ptr[column] c_result

    with nogil:
        c_result = move(
            cpp_minhash(
                c_strings,
                c_seeds,
                c_width
            )
        )

    return Column.from_unique_ptr(move(c_result))


@acquire_spill_lock()
def minhash_permuted(Column strings, Column a, Column b, int width):

    cdef column_view c_strings = strings.view()
    cdef size_type c_width = width
    cdef column_view c_a = a.view()
    cdef column_view c_b = b.view()
    cdef unique_ptr[column] c_result

    with nogil:
        c_result = move(
            cpp_minhash_permuted(
                c_strings,
                c_a,
                c_b,
                c_width
            )
        )

    return Column.from_unique_ptr(move(c_result))


@acquire_spill_lock()
def minhash64(Column strings, Column seeds, int width):

    cdef column_view c_strings = strings.view()
    cdef size_type c_width = width
    cdef column_view c_seeds = seeds.view()
    cdef unique_ptr[column] c_result

    with nogil:
        c_result = move(
            cpp_minhash64(
                c_strings,
                c_seeds,
                c_width
            )
        )

    return Column.from_unique_ptr(move(c_result))


@acquire_spill_lock()
def minhash64_permuted(Column strings, Column a, Column b, int width):

    cdef column_view c_strings = strings.view()
    cdef size_type c_width = width
    cdef column_view c_a = a.view()
    cdef column_view c_b = b.view()
    cdef unique_ptr[column] c_result

    with nogil:
        c_result = move(
            cpp_minhash64_permuted(
                c_strings,
                c_a,
                c_b,
                c_width
            )
        )

    return Column.from_unique_ptr(move(c_result))


@acquire_spill_lock()
def word_minhash(Column input, Column seeds):

    cdef column_view c_input = input.view()
    cdef column_view c_seeds = seeds.view()
    cdef unique_ptr[column] c_result

    with nogil:
        c_result = move(
            cpp_word_minhash(
                c_input,
                c_seeds
            )
        )

    return Column.from_unique_ptr(move(c_result))


@acquire_spill_lock()
def word_minhash64(Column input, Column seeds):

    cdef column_view c_input = input.view()
    cdef column_view c_seeds = seeds.view()
    cdef unique_ptr[column] c_result

    with nogil:
        c_result = move(
            cpp_word_minhash64(
                c_input,
                c_seeds
            )
        )

    return Column.from_unique_ptr(move(c_result))
