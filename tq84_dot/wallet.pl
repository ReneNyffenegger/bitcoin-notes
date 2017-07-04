#!/usr/bin/perl
use warnings;
use strict;

use TQ84_DOT;

TQ84_DOT::start("wallet", "Bitcoin core: Wallet related classes");

TQ84_DOT::class("CAccountingEntry");
TQ84_DOT::file("wallet/wallet.h");
TQ84_DOT::comment("Internal transfers");
TQ84_DOT::comment("DB key: acentry-account-counter");
TQ84_DOT::class_end();

TQ84_DOT::class("CMerkleTx");
TQ84_DOT::file("wallet/wallet.h");
TQ84_DOT::class_end();

TQ84_DOT::class("CWalletTx");
TQ84_DOT::file("wallet/wallet.h");
TQ84_DOT::comment("Transaction with info for user.");
TQ84_DOT::attribute("strFromAccount");
TQ84_DOT::class_end();

TQ84_DOT::class("CDB");
TQ84_DOT::file("wallet/db.h");
TQ84_DOT::comment("Interface to Berkeley DB");
TQ84_DOT::method("Read");
TQ84_DOT::method("Write");
TQ84_DOT::attribute("env");
TQ84_DOT::class_end();

TQ84_DOT::class("CWalletDB");
TQ84_DOT::file("wallet/walletdb.h");
TQ84_DOT::comment("Access to the wallet database.");
TQ84_DOT::comment("Represents a DB-transaction.");
TQ84_DOT::attribute("batch");
TQ84_DOT::attribute("mapValue");
TQ84_DOT::method("LoadWallet");
TQ84_DOT::class_end();


TQ84_DOT::class("CKeyStore");
TQ84_DOT::file("keystore.h");
TQ84_DOT::class_end();

TQ84_DOT::class("CBasicKeyStore");
TQ84_DOT::file("keystore.h");
TQ84_DOT::class_end();

TQ84_DOT::class("CCryptoKeyStore");
TQ84_DOT::file("wallet/crypter.h");
TQ84_DOT::method("GetKey");
TQ84_DOT::class_end();


TQ84_DOT::class("CValidationInterface");
TQ84_DOT::file("validationinterface.h");
TQ84_DOT::class_end();


TQ84_DOT::class("CWallet");
TQ84_DOT::file("wallet/wallet.h");
TQ84_DOT::attribute("dbw");
TQ84_DOT::attribute("pwalletdbEncryption");
TQ84_DOT::attribute("mapWallet");
TQ84_DOT::attribute("laccentries");
TQ84_DOT::method("CreateWalletFromFile");
TQ84_DOT::class_end();

TQ84_DOT::class("CWalletDBWrapper");
TQ84_DOT::file("wallet/db.h");
TQ84_DOT::comment("Represents a wallet database");
TQ84_DOT::attribute("env");
TQ84_DOT::class_end();

TQ84_DOT::class("CDBEnv");
TQ84_DOT::file("wallet/db.h");
TQ84_DOT::attribute("dbenv", {comment=> 'Pointer to BerkleyDB DbEnv'});
TQ84_DOT::class_end();


TQ84_DOT::derives_from('CWalletTx', 'CMerkleTx');
TQ84_DOT::derives_from('CWallet', 'CCryptoKeyStore');
TQ84_DOT::derives_from('CWallet', 'CValidationInterface');
TQ84_DOT::derives_from('CBasicKeyStore', 'CKeyStore');
TQ84_DOT::derives_from('CCryptoKeyStore', 'CBasicKeyStore');



TQ84_DOT::link('CWallet:dbw'                , 'CWalletDBWrapper');
TQ84_DOT::link('CWallet:pwalletdbEncryption', 'CWalletDB'       , {dir=>'back'});
TQ84_DOT::link('CWalletDBWrapper:env'       , 'CDBEnv');
TQ84_DOT::link('CDB:env'                    , 'CDBEnv');
TQ84_DOT::link('CWalletDB:batch'            , 'CDB'             , {dir=>'back'});
TQ84_DOT::link('CWallet:laccentries'        , 'CAccountingEntry', {head=>'crow'});
TQ84_DOT::link('CWallet:mapWallet'          , 'CWalletTx'       , {head=>'crow'});


TQ84_DOT::same_rank(qw(CDB CWallet CWalletDB CWalletDBWrapper CDBEnv));

TQ84_DOT::end();
TQ84_DOT::open();


# my $filename_without_suffix = 'Wallet';
# 
# open (my $din, '<', "$filename_without_suffix.din") or die;
# open (my $dot, '>', "$filename_without_suffix.dot") or die;

# print $dot 'digraph G {
# 
#   fontname="Helvetica";
#   node [shape=plaintext];
# 
# ';
# 
# my $in_class = 0;
# while (my $in = <$din>) {
# 
#   if ($in =~ /^\s*$/) { #_{
# 
#      if ($in_class) {
#         $in_class = 0;
# 
# print $dot"    >
#   ];
# ";
#      }
# 
#      next;
#   } #_}
# 
#   if ($in =~ /^(\w+)/) { #_{ new class
#      my $classname = $1;
#      $in_class = 1;
# 
# print $dot "  $classname [
#     label=<
#       <table border="1" cellcorder="0"
#   ];
# ";
# 
# 
#   } #_}
# }
# 
# 
# print $dot "}\n";
