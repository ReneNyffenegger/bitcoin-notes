#!/usr/bin/perl
use warnings;
use strict;

use TQ84_DOT;
TQ84_DOT::start("messages", "Bitcoin core: message related classes");

TQ84_DOT::class("CNode");
TQ84_DOT::file("net.h");
# TQ84_DOT::comment("");
TQ84_DOT::attribute("vProcessMsg");
TQ84_DOT::class_end();

TQ84_DOT::class("CNetMessage");
TQ84_DOT::file("net.h");
# TQ84_DOT::comment("");
TQ84_DOT::attribute("hdr");
TQ84_DOT::attribute("vRecv", {comment=>'received message data'});
TQ84_DOT::method("GetCommand");
TQ84_DOT::class_end();

TQ84_DOT::class("CMessageHeader");
TQ84_DOT::file("protocol.h");
# TQ84_DOT::comment("");
TQ84_DOT::class_end();

TQ84_DOT::class("CDataStream");
TQ84_DOT::file("streams.h");
# TQ84_DOT::comment("");
TQ84_DOT::class_end();

TQ84_DOT::link("CNode:vProcessMsg", "CNetMessage", {head=>'crow'});
TQ84_DOT::link("CNetMessage:hdr", "CMessageHeader");
TQ84_DOT::link("CNetMessage:vRecv", "CDataStream");

TQ84_DOT::same_rank(qw(CNode CNetMessage));

TQ84_DOT::end();
TQ84_DOT::open();
