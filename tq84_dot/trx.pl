#!/usr/bin/perl
use warnings;
use strict;

use lib '/home/rene/github/lib/perl-GraphViz-Diagram-ClassDiagram/lib/';

use GraphViz::Diagram::ClassDiagram;

my $class_diagram = GraphViz::Diagram::ClassDiagram->new("trx.pdf");

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

   my $CBlockIndex_pprev =
   $CBlockIndex->attribute('pprev'     , {comment=>'hash of previous block'});

   my $CBlockIndex_pskip =
   $CBlockIndex->attribute('pskip');

   $class_diagram->link($CBlockIndex_pprev, $CBlockIndex);
   $class_diagram->link($CBlockIndex_pskip, $CBlockIndex);

#_}
my $CDBBatch         = $class_diagram -> class('CDBBatch'        ); #_{
   $CDBBatch->comment('Batch of changes queued to be written to a CDBWrapper');
   $CDBBatch->file('dbwrapper.h');

   my $CDBBatch_parent =
   $CDBBatch->attribute('parent');

   $class_diagram->link($CDBBatch_parent, $CDBWrapper);
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

   my $CCoinsViewDB_db =
   $CCoinsViewDB->attribute("db");

   $class_diagram->link($CCoinsViewDB_db, $CDBWrapper);
#_}
my $CDiskBlockIndex  = $class_diagram -> class('CDiskBlockIndex' ); #_{
   $CDiskBlockIndex->file('chain.h');
   $CDiskBlockIndex->comment("Used to marshal pointers into hashes for db storage.");
#_}
my $CDiskBlockPos    = $class_diagram -> class('CDiskBlockPos'   ); #_{
   $CDiskBlockPos->file('chain.h');  
#_}
   
   $class_diagram->inheritance($CCoinsView      , $CCoinsViewBacked);
   $class_diagram->inheritance($CCoinsViewBacked, $CCoinsViewCache );
   $class_diagram->inheritance($CCoinsView      , $CCoinsViewDB    );

   $class_diagram->inheritance($CDBWrapper      , $CBlockTreeDB    );
   $class_diagram->inheritance($CBlockIndex     , $CDiskBlockIndex );

my $pblocktreedb = $class_diagram->global_var("pblocktreedb");

$pblocktreedb->class($CBlockTreeDB);

$class_diagram->same_rank($CDBWrapper, $CDBBatch, $CCoinsViewDB, $CDBIterator);

$class_diagram->create();
