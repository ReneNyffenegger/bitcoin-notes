#!/usr/bin/perl
use warnings;
use strict;

use lib '/home/rene/github/lib/perl-GraphViz-ClassDiagram/lib/';

use GraphViz::ClassDiagram;

my $class_diagram = GraphViz::ClassDiagram->new("trx.pdf");

$class_diagram->title("Bitcoin TRX classes");

my $CDBWrapper       = $class_diagram -> class('CDBWrapper'      ); #_{

   $CDBWrapper->file('dbwrapper.h');
   $CDBWrapper->comment("Wrapper for LevelDB");
   $CDBWrapper->comment("Used for DATADIR/blocks/index and DATADIR/chainstate");

#_}
my $CBlockFileInfo   = $class_diagram -> class('CBlockFileInfo'  ); #_{
   $CBlockFileInfo -> file('chain.h');
#_}
my $CChain           = $class_diagram -> class('CChain'          ); #_{
   $CChain->file('chain.h');  
   $CChain->comment("An in-memory indexed chain of blocks");
   $CChain->attribute("vChain");
   $CChain->method("Genesis");
#_}
my $CBlockTreeDB     = $class_diagram -> class('CBlockTreeDB'    ); #_{
   $CBlockTreeDB -> file('txdb.h');
   $CBlockTreeDB -> comment("Access to the block database (DATADIR/blocks/index/)");
   
   $CBlockTreeDB -> method('LoadBlockIndexGuts', {comment=>'Load mapBlockIndex'});
   $CBlockTreeDB -> method("ReadLastBlockFile" , {comment=>'How many block info files are there?'});
   $CBlockTreeDB -> method("ReadBlockFileInfo" , {comment=>'Read a specific CBlockFileInfo'});
   $CBlockTreeDB -> method("Read/WriteFlag"    , {comment=>'...'});

#_}
my $CBlockIndex      = $class_diagram -> class('CBlockIndex'     ); #_{
   $CBlockIndex->file('chain.h');
   $CBlockIndex->comment('A Bitcoin block?');
   $CBlockIndex->comment('Apparently keeps track of a block');

   $CBlockIndex->attribute('phashBlock', {comment=>'hash of block'});
   $CBlockIndex->attribute('pprev'     , {comment=>'hash of previous block'});
   $CBlockIndex->attribute('pskip');

#_}
my $CDBBatch         = $class_diagram -> class('CDBBatch'        ); #_{
   $CDBBatch->comment('Batch of changes queued to be written to a CDBWrapper');
   $CDBBatch->file('dbwrapper.h');
   $CDBBatch->attribute('parent');
#_}
my $CCoinsView       = $class_diagram -> class('CCoinsView'      ); #_{
   $CCoinsView->file('coins.h');
   $CCoinsView->comment("Abstract view on the open txout dataset");
   $CCoinsView->method("Cursor"      , {comment=>'Returns a CCoinsViewCursor', returns=>'CCoinsViewCursor'});
   $CCoinsView->method("GetBestBlock", {comment=>'Retrieve the block hash whose state this CCoinsView currently represents'});
#_}
my $CCoinsViewBacked = $class_diagram -> class('CCoinsViewBacked'); #_{
   $CCoinsViewBacked->file('coins.h');
#_}
my $CCoinsViewCache  = $class_diagram -> class('CCoinsViewCache' ); #_{
   $CCoinsViewCache->file('coins.h');
   $CCoinsViewCache->comment('adds a memory cache for transactions to another CCoinsView');
   $CCoinsViewCache->attribute('hashBlock');
#_}
my $CCoinsViewCursor = $class_diagram -> class('CCoinsViewCursor'); #_{
   $CCoinsViewCursor->file('coins.h');
   $CCoinsViewCursor->comment("Cursor for iterating over CoinsView state");
#_}
my $CDBIterator      = $class_diagram -> class('CDBIterator'     ); #_{
   $CDBIterator->file('dbwrapper.h');
   $CDBIterator->attribute("parent");
   $CDBIterator->method("GetKey");
#_}
my $CCoinsViewDB     = $class_diagram -> class('CCoinsViewDB'    ); #_{
   $CCoinsViewDB->file('txdb.h');
   $CCoinsViewDB->comment("CCoinsView backed by the coin database (chainstate/)");
   $CCoinsViewDB->comment("Compare CCoinsViewBacked.");
   $CCoinsViewDB->attribute("db");
#_}
my $CDiskBlockIndex  = $class_diagram -> class('CDiskBlockIndex' ); #_{
   $CDiskBlockIndex->file('chain.h');
   $CDiskBlockIndex->comment("Used to marshal pointers into hashes for db storage.");
#_}
my $CDiskBlockPos    = $class_diagram -> class('CDiskBlockPos'   ); #_{
   $CDiskBlockPos->file('chain.h');  
#_}
   

$class_diagram->create();
