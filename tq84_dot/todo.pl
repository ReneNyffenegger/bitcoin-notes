#!/usr/bin/perl
use warnings;
use strict;

use TQ84_DOT;

TQ84_DOT::start("todo");
TQ84_DOT::link("CCoinsViewDB:db", "CDBWrapper");

TQ84_DOT::class("CDBWrapper");
TQ84_DOT::file("dbwrapper.h");
TQ84_DOT::comment("Wrapper for LevelDB?");
TQ84_DOT::comment("Used for DATADIR/blocks/index and DATADIR/chainstate");
TQ84_DOT::class_end();


TQ84_DOT::class("CBlockFileInfo");
TQ84_DOT::file("chain.h");
TQ84_DOT::class_end();

TQ84_DOT::class("CBlockTreeDB");
TQ84_DOT::file("txdb.h");
TQ84_DOT::comment("Access to the block database (DATADIR/blocks/index/)");
TQ84_DOT::method("LoadBlockIndexGuts", {comment=>'Load mapBlockIndex'});
TQ84_DOT::method("ReadLastBlockFile" , {comment=>'How many block info files are there?'});
TQ84_DOT::method("ReadBlockFileInfo" , {comment=>'Read a specific CBlockFileInfo'});
TQ84_DOT::method("Read/WriteFlag"    , {comment=>'...'});
TQ84_DOT::class_end();

TQ84_DOT::class("CBlockIndex");
TQ84_DOT::file("chain.h");
TQ84_DOT::comment("A Bitcoin block?");
TQ84_DOT::comment("Apparently keeps track of a block.");
TQ84_DOT::attribute("phashBlock", {comment=>"hash of block"});
TQ84_DOT::attribute("pprev", {comment=>"hash of previous block"});
TQ84_DOT::attribute("pskip");
TQ84_DOT::class_end();

TQ84_DOT::class("CDBBatch");
TQ84_DOT::file("dbwrapper.h");
TQ84_DOT::comment("Batch of changes queued to be written to a CDBWrapper");
TQ84_DOT::attribute("parent");
TQ84_DOT::class_end();

TQ84_DOT::link("CBlockIndex:pprev", "CBlockIndex");
TQ84_DOT::link("CBlockIndex:pskip", "CBlockIndex");
TQ84_DOT::link("CDBBatch:parent", "CDBWrapper");

TQ84_DOT::class("CCoinsView");
TQ84_DOT::file("coins.h");
TQ84_DOT::comment("Abstract view on the open txout dataset");
TQ84_DOT::method("Cursor", {comment=>'Returns a CCoinsViewCursor'});
TQ84_DOT::method("GetBestBlock", {comment=>'Retrieve the block hash whose state this CCoinsView currently represents'});
TQ84_DOT::class_end();

TQ84_DOT::class("CCoinsViewBacked");
TQ84_DOT::file("coins.h");
TQ84_DOT::class_end();

TQ84_DOT::derives_from("CCoinsViewBacked", "CCoinsView");

TQ84_DOT::class("CCoinsViewCache");
TQ84_DOT::file("coins.h");
TQ84_DOT::comment("adds a memory cache for transactions to another CCoinsView");
TQ84_DOT::attribute("hashBlock");
TQ84_DOT::class_end();

TQ84_DOT::derives_from("CCoinsViewCache", "CCoinsViewBacked");

TQ84_DOT::class("CCoinsViewCursor");
TQ84_DOT::file("coins.h");
TQ84_DOT::comment("Cursor for iterating over CoinsView state");
TQ84_DOT::class_end();

TQ84_DOT::class("CDBIterator");
TQ84_DOT::file("dbwrapper.h");
TQ84_DOT::attribute("parent");
TQ84_DOT::method("GetKey");
TQ84_DOT::class_end();

TQ84_DOT::link("CDBIterator:parent", "CDBWrapper");

TQ84_DOT::class("CCoinsViewDB");
TQ84_DOT::file("txdb.h");
TQ84_DOT::comment("CCoinsView backed by the coin database (chainstate/)");
TQ84_DOT::comment("Compare CCoinsViewBacked.");
TQ84_DOT::attribute("db");
TQ84_DOT::class_end();

TQ84_DOT::derives_from("CCoinsViewDB", "CCoinsView");

TQ84_DOT::class("CDiskBlockIndex");
TQ84_DOT::file("chain.h");
TQ84_DOT::comment("Used to marshal pointers into hashes for db storage.");
TQ84_DOT::class_end();

TQ84_DOT::class("CDiskBlockPos");
TQ84_DOT::file("chain.h");
TQ84_DOT::class_end();

TQ84_DOT::derives_from("CBlockTreeDB", "CDBWrapper");
TQ84_DOT::derives_from("CDiskBlockIndex", "CBlockIndex");


TQ84_DOT::same_rank("CDBWrapper", "CDBBatch", "CCoinsViewDB", "CDBIterator");

TQ84_DOT::class("CChain");
TQ84_DOT::file("chain.h");
TQ84_DOT::comment("An in-memory indexed chain of blocks");
TQ84_DOT::attribute("vChain");
TQ84_DOT::method("Genesis");
TQ84_DOT::class_end();

TQ84_DOT::end();
TQ84_DOT::open();
