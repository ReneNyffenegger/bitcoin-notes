#!/usr/bin/perl
use warnings;
use strict;

use TQ84_DOT;

TQ84_DOT::start("blob");


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

TQ84_DOT::end();
TQ84_DOT::open();
