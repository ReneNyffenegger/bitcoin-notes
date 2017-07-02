#!/usr/bin/perl
use warnings;
use strict;

use TQ84_DOT;

TQ84_DOT::start("todo");

TQ84_DOT::class("CDBWrapper");
TQ84_DOT::file("dbwrapper.h");
TQ84_DOT::comment("Wrapper for LevelDB?");
TQ84_DOT::class_end();

TQ84_DOT::class("CBlockFileInfo");
TQ84_DOT::file("chain.h");
TQ84_DOT::class_end();

TQ84_DOT::class("CBlockTreeDB");
TQ84_DOT::file("txdb.h");
TQ84_DOT::comment("Access to the block database (blocks/index/)");
TQ84_DOT::method("ReadLastBlockFile", {comment=>'How many block info files are there?'});
TQ84_DOT::method("ReadBlockFileInfo", {comment=>'Read a specific CBlockFileInfo'});
TQ84_DOT::class_end();

TQ84_DOT::class("CBlockIndex");
TQ84_DOT::file("chain.h");
TQ84_DOT::comment("Apparently keeps track of a block.");
TQ84_DOT::attribute("phashBlock");
TQ84_DOT::attribute("pprev");
TQ84_DOT::attribute("pskip");
TQ84_DOT::class_end();

TQ84_DOT::class("CDBBatch");
TQ84_DOT::comment("Batch of changes queued to be written to a CDBWrapper");
TQ84_DOT::attribute("parent");
TQ84_DOT::class_end();

TQ84_DOT::link("CBlockIndex:pprev", "CBlockIndex");
TQ84_DOT::link("CBlockIndex:pskip", "CBlockIndex");
TQ84_DOT::link("CDBBatch:parent", "CDBWrapper");

TQ84_DOT::class("CDiskBlockIndex");
TQ84_DOT::file("chain.h");
TQ84_DOT::class_end();

TQ84_DOT::class("CDiskBlockPos");
TQ84_DOT::file("chain.h");
TQ84_DOT::class_end();

TQ84_DOT::derives_from("CBlockTreeDB", "CDBWrapper");
TQ84_DOT::derives_from("CDiskBlockIndex", "CBlockIndex");

TQ84_DOT::same_rank("CDBWrapper", "CDBBatch");

TQ84_DOT::end();
TQ84_DOT::open();