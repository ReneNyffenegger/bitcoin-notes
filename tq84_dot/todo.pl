#!/usr/bin/perl
use warnings;
use strict;

use TQ84_DOT;

TQ84_DOT::start("todo");


TQ84_DOT::global_var("pblocktreedb", "CBlockTreeDB");





TQ84_DOT::same_rank("CDBWrapper", "CDBBatch", "CCoinsViewDB", "CDBIterator");


TQ84_DOT::end();
TQ84_DOT::open();
