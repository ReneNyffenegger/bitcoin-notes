#!/usr/bin/perl
use warnings;
use strict;

use TQ84_DOT;

TQ84_DOT::start("blob", "Bitcoin core: Blob related classes");


TQ84_DOT::class("base_blob<BITS>");
TQ84_DOT::file("uint256.h");
TQ84_DOT::method("GetHex");
TQ84_DOT::method("ToString");
TQ84_DOT::class_end();

TQ84_DOT::class("uint160");
TQ84_DOT::file("uint256.h");
TQ84_DOT::class_end();

TQ84_DOT::class("uint256");
TQ84_DOT::file("uint256.h");
TQ84_DOT::method("GetCheapHash");
TQ84_DOT::class_end();

TQ84_DOT::derives_from("uint160", "base_blob<BITS>");
TQ84_DOT::derives_from("uint256", "base_blob<BITS>");

TQ84_DOT::class("CKeyID");
TQ84_DOT::file("pubkey.h");
TQ84_DOT::comment("A reference to a CKey: the Hash160 of its serialzed public key");
TQ84_DOT::class_end();

TQ84_DOT::derives_from("CKeyID", "uint160");

TQ84_DOT::end();
TQ84_DOT::open();
