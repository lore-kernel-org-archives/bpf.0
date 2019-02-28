Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFB7C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2942183F
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 09:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="c+wJM1mV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfB1J72 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:59:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42310 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfB1J72 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 04:59:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so21190239wrg.9
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 01:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TfgNU5ffzwZrndgsR5yvrBofZSBegRVvHeY7c6d6E94=;
        b=c+wJM1mVh9pAnTD6nfrwhUGkPZto2Tym8UclhTFWBG9FNxuKmJdHfZnSIr4/TK9Vjp
         QtWxZcDx8qLZTxoB8QSHuCF5tmFVmQZxvodmvw4XtZNnDyI3fQFGoIGd+nhWrgngz3Pq
         EOBOOfCDmucgyFnaAON7hYxAAZ7++8yJAgrK/blUDFv7bt+lnHIRQwxmRePLEB5DcAyX
         5nwaHes15CjXF5yRDnGqmeU7i4jsPYmE7xXDaQtFDAuTUHxzIfi0BdRmi6QaeddPpRHo
         RFqSX/94Txc17ty20jvp+ITadW4R04oKur0HuPZhIaAUU5l5y5Atix6MHPV+PSQM5i/T
         Mj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TfgNU5ffzwZrndgsR5yvrBofZSBegRVvHeY7c6d6E94=;
        b=WS9CYFhqDZEe0zpRzONV0CiUi6LjrI8voVqkEwIk1TSM2WFdkretJUAhMbnpDIVZy+
         jVMi7qQNIx2QmoeGwVraknWbyxRz1KNS0OGwwz0hjJv8pCUZvK0Jyv88FFe2hXfrdLXJ
         7lsRY8qFE//xJd+jlApiz5kia3sScTG9vwpknT664kIE1bvzwUO+MRWS8CeKddP4ND0q
         MID9xdmwcRVuOq4ndCfVD9+ghwiID9spG2PTvjSu9+RKhaSSLWwKFsLtTpKSJxNFz5bc
         8FeNNky9827Ams2pqWXufxPZAUVfyfUQi42uHxY/YbGppxVarLuZfJUxXpQVPiRgI8+A
         Ogog==
X-Gm-Message-State: APjAAAWuv8qNa+a7qVKtKImWS2Wc7UB+FjCcDf7bQzcUos6Aqf1HaPQH
        OIFnIHWajfhVtdum2UHLtkHp0A==
X-Google-Smtp-Source: APXvYqxbNfKXUtONaZFfpAM1aE5QkDRmdFKcXWkyI4i2brfn11CdBRzVZJPk1Qp6hSx4RO44AjqC7g==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr5298976wro.266.1551347965622;
        Thu, 28 Feb 2019 01:59:25 -0800 (PST)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id y5sm4965261wmg.31.2019.02.28.01.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Feb 2019 01:59:24 -0800 (PST)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, yhs@fb.com
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH LLVM v2 2/3] bpf: enable sub-register code-gen for XADD
Date:   Thu, 28 Feb 2019 09:59:16 +0000
Message-Id: <1551347957-4068-3-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551347957-4068-1-git-send-email-jiong.wang@netronome.com>
References: <1551347957-4068-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support sub-register code-gen for XADD is like supporting any other Load
and Store patterns.

No new instruction is introduced.

  lock *(u32 *)(r1 + 0) += w2

has exactly the same underlying insn as:

  lock *(u32 *)(r1 + 0) += r2

BPF_W width modifier has guaranteed they behave the same at runtime. This
patch merely teaches BPF back-end that BPF_W width modifier could work
GPR32 register class and that's all needed for sub-register code-gen
support for XADD.

test/CodeGen/BPF/xadd.ll updated to include sub-register code-gen tests.

A new testcase test/CodeGen/BPF/xadd_legal.ll is added to make sure the
legal case could pass on all code-gen modes. It could also test dead Def
check on GPR32. If there is no proper handling like what has been done
inside BPFMIChecking.cpp:hasLivingDefs, then this testcase will fail.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 lib/Target/BPF/BPFInstrInfo.td   | 28 ++++++++++++++++++++++++----
 lib/Target/BPF/BPFMIChecking.cpp |  4 +++-
 test/CodeGen/BPF/xadd.ll         |  2 ++
 test/CodeGen/BPF/xadd_legal.ll   | 26 ++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 5 deletions(-)
 create mode 100644 test/CodeGen/BPF/xadd_legal.ll

diff --git a/lib/Target/BPF/BPFInstrInfo.td b/lib/Target/BPF/BPFInstrInfo.td
index 36724b8..c44702a 100644
--- a/lib/Target/BPF/BPFInstrInfo.td
+++ b/lib/Target/BPF/BPFInstrInfo.td
@@ -614,11 +614,31 @@ class XADD<BPFWidthModifer SizeOp, string OpcodeStr, PatFrag OpNode>
   let BPFClass = BPF_STX;
 }
 
+class XADD32<BPFWidthModifer SizeOp, string OpcodeStr, PatFrag OpNode>
+    : TYPE_LD_ST<BPF_XADD.Value, SizeOp.Value,
+                 (outs GPR32:$dst),
+                 (ins MEMri:$addr, GPR32:$val),
+                 "lock *("#OpcodeStr#" *)($addr) += $val",
+                 [(set GPR32:$dst, (OpNode ADDRri:$addr, GPR32:$val))]> {
+  bits<4> dst;
+  bits<20> addr;
+
+  let Inst{51-48} = addr{19-16}; // base reg
+  let Inst{55-52} = dst;
+  let Inst{47-32} = addr{15-0}; // offset
+  let BPFClass = BPF_STX;
+}
+
 let Constraints = "$dst = $val" in {
-def XADD32 : XADD<BPF_W, "u32", atomic_load_add_32>;
-def XADD64 : XADD<BPF_DW, "u64", atomic_load_add_64>;
-// undefined def XADD16 : XADD<1, "xadd16", atomic_load_add_16>;
-// undefined def XADD8  : XADD<2, "xadd8", atomic_load_add_8>;
+  let Predicates = [BPFNoALU32] in {
+    def XADDW : XADD<BPF_W, "u32", atomic_load_add_32>;
+  }
+
+  let Predicates = [BPFHasALU32], DecoderNamespace = "BPFALU32" in {
+    def XADDW32 : XADD32<BPF_W, "u32", atomic_load_add_32>;
+  }
+
+  def XADDD : XADD<BPF_DW, "u64", atomic_load_add_64>;
 }
 
 // bswap16, bswap32, bswap64
diff --git a/lib/Target/BPF/BPFMIChecking.cpp b/lib/Target/BPF/BPFMIChecking.cpp
index 514af76..4c46289 100644
--- a/lib/Target/BPF/BPFMIChecking.cpp
+++ b/lib/Target/BPF/BPFMIChecking.cpp
@@ -155,7 +155,9 @@ static bool hasLiveDefs(const MachineInstr &MI, const TargetRegisterInfo *TRI) {
 void BPFMIPreEmitChecking::checkingIllegalXADD(void) {
   for (MachineBasicBlock &MBB : *MF) {
     for (MachineInstr &MI : MBB) {
-      if (MI.getOpcode() != BPF::XADD32 && MI.getOpcode() != BPF::XADD64)
+      if (MI.getOpcode() != BPF::XADDW &&
+          MI.getOpcode() != BPF::XADDD &&
+          MI.getOpcode() != BPF::XADDW32)
         continue;
 
       LLVM_DEBUG(MI.dump());
diff --git a/test/CodeGen/BPF/xadd.ll b/test/CodeGen/BPF/xadd.ll
index c5f2620..49f0c10 100644
--- a/test/CodeGen/BPF/xadd.ll
+++ b/test/CodeGen/BPF/xadd.ll
@@ -1,5 +1,7 @@
 ; RUN: not llc -march=bpfel < %s 2>&1 | FileCheck %s
 ; RUN: not llc -march=bpfeb < %s 2>&1 | FileCheck %s
+; RUN: not llc -march=bpfel -mattr=+alu32 < %s 2>&1 | FileCheck %s
+; RUN: not llc -march=bpfeb -mattr=+alu32 < %s 2>&1 | FileCheck %s
 
 ; This file is generated with the source command and source
 ; $ clang -target bpf -O2 -g -S -emit-llvm t.c
diff --git a/test/CodeGen/BPF/xadd_legal.ll b/test/CodeGen/BPF/xadd_legal.ll
new file mode 100644
index 0000000..0d30084
--- /dev/null
+++ b/test/CodeGen/BPF/xadd_legal.ll
@@ -0,0 +1,26 @@
+; RUN: llc -march=bpfel < %s 2>&1 | FileCheck --check-prefix=CHECK-64 %s
+; RUN: llc -march=bpfeb < %s 2>&1 | FileCheck --check-prefix=CHECK-64 %s
+; RUN: llc -march=bpfel -mattr=+alu32 < %s 2>&1 | FileCheck --check-prefix=CHECK-32 %s
+; RUN: llc -march=bpfeb -mattr=+alu32 < %s 2>&1 | FileCheck --check-prefix=CHECK-32 %s
+
+; This file is generated with the source command and source
+; $ clang -target bpf -O2 -S -emit-llvm t.c
+; $ cat t.c
+; int test(int *ptr, unsigned long long a) {
+;    __sync_fetch_and_add(ptr, a);
+;    return *ptr;
+; }
+;
+; NOTE: passing unsigned long long as the second operand of __sync_fetch_and_add
+; could effectively create sub-register reference coming from indexing a full
+; register which could then exerceise hasLivingDefs inside BPFMIChecker.cpp.
+
+define dso_local i32 @test(i32* nocapture %ptr, i64 %a) {
+entry:
+  %conv = trunc i64 %a to i32
+  %0 = atomicrmw add i32* %ptr, i32 %conv seq_cst
+; CHECK-64: lock *(u32 *)(r1 + 0) += r2
+; CHECK-32: lock *(u32 *)(r1 + 0) += w2
+  %1 = load i32, i32* %ptr, align 4
+  ret i32 %1
+}
-- 
2.7.4

