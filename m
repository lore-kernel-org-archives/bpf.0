Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E92C00319
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D55A2186A
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 20:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="pGLXiilM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfB0Uu6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:50:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37449 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbfB0Uu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 15:50:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so6828282wmg.2
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 12:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M6hEoFTAQYWQnXlTnVHaafgtTgadVE2nvws6JP9pO3M=;
        b=pGLXiilMa8t7XusEY2BIQqoCzXxGl9NFpmwy0VOtaIf59oEjgoJRjHxHxK4hfuN3Ft
         wSKiuBGkmXB0+U8hNDVtzyA69Mq62vzailMtxeuPi7XfGYFCq7v+D+1LftqMBAWf2yy+
         TqiWEwqqbbcjsCWJzMIbKWIHUcm59NbO+kUD5rfk1M0eG2Bk1RdudbHnuzRM3Y+IJoc1
         VbYh2cHfTNT3Kie7mvJVwytRWdlIzASscHB7a+JW0tYfjs1kk/nrYGN/4Z1lWRT/bTRZ
         BZkricVra6ZN1Az0grJmpKMrFpuJ5NMK0Fani+Ex4AVD0lE7BCGLYMGFUF3TocMk86HG
         b+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M6hEoFTAQYWQnXlTnVHaafgtTgadVE2nvws6JP9pO3M=;
        b=oJljQ7Fe34blfI202vsZXvoCjUa2WDOwyPk/HXE60/ma97W2bBY7wGeucYUOO1RhQ7
         HhszDACq8SNW5rt/eEFzK7a62B1u09ycqrR5yzChf+f/hgFSeojaddBmY8dtrJbSZ2I/
         +xMdCCGT7WqbfCNcCRM49XGUh1i6CaM2GEFVlzIGABjA7fdR6I/4ZLYivNuYxBCSrEhs
         JRlXCyB/qT4q/K5YvYG7GVd4XMpHhzUcQfqd0heNAo+XqaJbUA9LY/huJP4bxC7lySv9
         IxusDvURH8jh7eMnjTZBEZ8sZN/2NFdH/HpyQOJlf8uQ7mHFQpdKjxW5TopCgxR9Se+W
         6HeA==
X-Gm-Message-State: APjAAAXRbZyY6QgjmRYGgYlxfpIn/x/jeJbLTsbxwJuQcG0ob0J/qSel
        qbdBlbxva/gB8poQjcDdUvCWTA==
X-Google-Smtp-Source: AHgI3IZmcydYA4mYS7paIqGyvdu4Y++/NVy+oMv8p7vA6MjG5v74qjlws4jameTgSCdQ7QmJdbyiTw==
X-Received: by 2002:a1c:4889:: with SMTP id v131mr694253wma.146.1551300656415;
        Wed, 27 Feb 2019 12:50:56 -0800 (PST)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id e193sm5362912wmg.18.2019.02.27.12.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 12:50:55 -0800 (PST)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, yhs@fb.com
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH LLVM 2/3] bpf: enable sub-register code-gen for XADD
Date:   Wed, 27 Feb 2019 20:50:40 +0000
Message-Id: <1551300641-1727-3-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
References: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
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
index 7a4ba96..938e539 100644
--- a/lib/Target/BPF/BPFMIChecking.cpp
+++ b/lib/Target/BPF/BPFMIChecking.cpp
@@ -165,7 +165,9 @@ static bool hasLivingDefs(const MachineInstr &MI,
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

