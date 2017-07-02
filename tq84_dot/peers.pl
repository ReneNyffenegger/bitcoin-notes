#!/usr/bin/perl
use warnings;
use strict;

use TQ84_DOT;

TQ84_DOT::start("Peers");

TQ84_DOT::class("CNetAddr");
TQ84_DOT::file("netaddress.h");
TQ84_DOT::comment("IP address (IPv6, or IPv4 using mapped IPv6 range (::FFFF:0:0/96))");
TQ84_DOT::class_end();

TQ84_DOT::class("CService");
TQ84_DOT::file("netaddress.h");
TQ84_DOT::comment("A combination of a network address (CNetAddr) and a (TCP) port");
TQ84_DOT::class_end();

TQ84_DOT::class("CAddress");
TQ84_DOT::file("protocol.h");
TQ84_DOT::comment("A CService with information about it as peer");
TQ84_DOT::class_end();

TQ84_DOT::class("CAddrInfo");
TQ84_DOT::file("addrman.h");
TQ84_DOT::comment("Extended statistics about a CAddress");
TQ84_DOT::class_end();

TQ84_DOT::derives_from("CService" , "CNetAddr");
TQ84_DOT::derives_from("CAddress" , "CService");
TQ84_DOT::derives_from("CAddrInfo", "CAddress");

TQ84_DOT::end();
TQ84_DOT::open();
