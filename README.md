# System (for) Hasty Evaluation (of) Literature (in the) Future

The System (for) Hasty Evaluation (of) Literature (in the) Future (SHELF) is software used to manage and index books within a home network.
SHELF does **NOT** provide any sort of authentication for who is allowed to enter/modify book data, it should not be used on publicly facing servers.

#### Features:
- SHELF interfaces with the GoogleBooks API to make ingestion of books easy (all you have to do is enter the ISBN).
- SHELF allows easy searching of all fields of books or individual fields of books.
  - SHELF has search prefixes to narrow down your search.

## Search Prefixes
| Prefix | Description | Example |
|---|---|---|
| `title:` | Searches through the title field only. | `title:Frankenstein` finds all books with the title `Frankenstein`. |
| `author:` | Searches through the author field only. | `author:Shelley` finds all books with the author `Shelley`. |
| `publisher:` | Searches through the publisher field only. | `publisher:Bantam` finds all books published by `Bantam`. |
| `year:` | Searches through the year field only. | `year:1984` finds all published in `1984`. |
| `isbn:` | Searches through the isbn field only. | `isbn:9780553212471` finds all books with the ISBN `9780553212471`. |
| `scannable:` | Searches through the scannable field only. | `scannable:0553212478` finds all books with the scannable field set to `0553212478`. |
| `shelf:` | Searches through the shelf field only. | `shelf:A0` finds all books on the shelf `A0`. |

[Currently Broken] **NOTE:** More than one prefix can be used in a query. For example `author:Shelley year:1984` searches for all books with the author `Shelley` that were published in `1984`.
