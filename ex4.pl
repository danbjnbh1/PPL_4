:- module('ex4',
        [author/2,
         genre/2,
         book/4
        ]).

/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).
:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).



author(a, asimov).
author(h, herbert).
author(m, morris).
author(t, tolkien).

genre(s, science).
genre(l, literature).
genre(sf, science_fiction).
genre(f, fantasy).

book(inside_the_atom, a, s, s(s(s(s(s(zero)))))).
book(asimov_guide_to_shakespeare, a, l, s(s(s(s(zero))))).
book(i_robot, a, sf, s(s(s(zero)))).
book(dune, h, sf, s(s(s(s(s(zero)))))).
book(the_well_at_the_worlds_end, m, f, s(s(s(s(zero))))).
book(the_hobbit, t, f, s(s(s(zero)))).
book(the_lord_of_the_rings, t, f, s(s(s(s(s(s(zero))))))).

% You can add more facts.


% Signature: max_list(Lst, Max)/2
% Purpose: true if Max is the maximum church number in Lst, false if Lst is emoty.
% max_list(+List, -Max)
% True if Max is the largest Church numeral in the list
% False if the list is empty
max_list([], _) :- fail.
max_list([X], X).
max_list([H|T], Max) :-
    max_list(T, TempMax),
    max_church(H, TempMax, Max).

% max_church(+A, +B, -Max)
% Max is the greater of Church numerals A and B
max_church(A, B, A) :- greater_than_church(A, B).
max_church(A, B, B) :- greater_than_church(B, A).
max_church(A, B, A) :- equal_church(A, B). 

equal_church(zero, zero).
equal_church(s(A), s(B)) :- equal_church(A, B).

% greater_than_church(+A, +B)
% True if Church numeral A is greater than B
greater_than_church(s(_), zero).
greater_than_church(s(A), s(B)) :-
    greater_than_church(A, B).
greater_than_church(zero, zero) :- fail.
greater_than_church(zero, s(_)) :- fail.






% Signature: author_of_genre(GenreName, AuthorName)/2
% Purpose: true if an author by the name AuthorName has written a book belonging to the genre named GenreName.

author_of_genre(GenreName, AuthorName):-
    author(AuthorId, AuthorName),
    book(_, AuthorId, GenreId, _),
    genre(GenreId, GenreName).




% Signature: longest_book(AuthorName, BookName)/2
% Purpose: true if the longest book that an author by the name AuthorName has written is titled BookName.

longest_book(AuthorName, BookName) :-
    author(AuthorId, AuthorName),
    books_by_author(AuthorId, BookList),
    extract_lengths(BookList, Lengths),
    max_list(Lengths, MaxLength),
    member(book(BookName, AuthorId, _, MaxLength), BookList).

% extract_lengths(+Books, -Lengths)
% Extracts a list of lengths from a list of book(Name, AuthorId, GenreId, Length)

extract_lengths([], []).
extract_lengths([book(_, _, _, Length)|Rest], [Length|LengthsRest]) :-
    extract_lengths(Rest, LengthsRest).

books_by_author(AuthorId, BookList) :-
    findall(book(Name, AuthorId, GenreId, Length),
            book(Name, AuthorId, GenreId, Length),
            BookList).
