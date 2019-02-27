Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A92C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEDB21850
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 20:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="RMKRB70X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfB0Uu6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:50:58 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36556 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfB0Uu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 15:50:58 -0500
Received: by mail-wr1-f43.google.com with SMTP id o17so19563705wrw.3
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 12:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UQLUgxj23iYvqOwNHgjg9/XTeTduTOc0LwqQ80BWHqg=;
        b=RMKRB70XSkC+j6vtRRu+/aTW3NL2+RgHTFkbKm2CoLvb2LR/yuRR4SsXHoutpG6PVW
         s9oDmroKTBmaWiyVQ+d+JH51K70d+hXBrPhvl/GmExNvJCOHyLOImny3ejfVYjDO8/79
         /GRX7WcyatsBwCzkA0xamXtQdc3r7F2fiz0KQH9MbSbMzib9UH5we6Zqg3GVAezZfHze
         988oSACiR0fycrysm6Nn87fd/hIOZi8Z4Drvqru3q97fBtF8Su/S5U5qy9Ks0NF1gB8R
         c/e0HuUuHhcxOVixpmvCh+VSQzettaJLzNyoXhIe20RrNRL/xt1CiyO3QXbaUKp5WRCW
         RBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UQLUgxj23iYvqOwNHgjg9/XTeTduTOc0LwqQ80BWHqg=;
        b=LR5aNwf1onw1USTHewhhpa8wZ4Bh8Q4ci+7FeQUC57FOX88/EvSGrgt1TD2uC8f1Uy
         uJTl/HUlo5o/lI8rKEZsWjDL60IAHfjcAj13ATvYIEyOKYvrPDgQySWZ1ohwgpaBMQDt
         20VHpA/KQHVs2Dk4zfLLO9InN1ZFYwGA2Z0PLpByRytvY9BDobCGCynIHYdvVmHqwNEX
         blmvz01zDOPdklexNGKLMcua3YKzHBW2gGnjf8JLsgXV7nbzKDL/dgosLpBHIWUE7dJq
         VIlz0n/yVujkbaPVQ11uDgFl6h7jb/pKK+LDQ5t6K9oZSC58AOi8WJVth1A/w5oS73TK
         6RFw==
X-Gm-Message-State: APjAAAXUv76EG4oo/36nY5CeelHhxZxGf/RyWbjJmTAJtDAtTR9yZj3j
        m3zj3UN3JI3VkQbdEld5HUTOAGwfIWk=
X-Google-Smtp-Source: APXvYqx30N66eqhEnziPuVEiKX4Di/5/oNoxE6WQQxDTitVRfQVc34PFOkFzcbN+ytp+rMIw4asZQA==
X-Received: by 2002:a5d:4147:: with SMTP id c7mr3979139wrq.235.1551300655715;
        Wed, 27 Feb 2019 12:50:55 -0800 (PST)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id e193sm5362912wmg.18.2019.02.27.12.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 12:50:55 -0800 (PST)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, yhs@fb.com
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH LLVM 1/3] bpf: improve dead Defs check for XADD
Date:   Wed, 27 Feb 2019 20:50:39 +0000
Message-Id: <1551300641-1727-2-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
References: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF XADD semantics require all Defs of XADD are dead, meaning any result of
XADD insn is not used.

However, BPF backend hasn't enabled sub-register liveness track, so when
the source and destination operands of XADD are GPR32, there is no
sub-register dead info. If we rely on the generic
MachineInstr::allDefsAreDead, then we will raise false alarm on GPR32 Def.
This was fine as there was no sub-register code-gen support for XADD which
will be added by the next patch.

To support GPR32 Def, ideally we could just enable sub-registr liveness
track on BPF backend, then allDefsAreDead could work on GPR32 Def. This
requires implementing TargetSubtargetInfo::enableSubRegLiveness on BPF.

However, sub-register liveness tracking module inside LLVM is actually
designed for the situation where one register could be splitted into more
than one sub-registers for which case each sub-register could have their
own liveness and kill one of them doesn't kill others. So, tracking
liveness for each make sense.

For BPF, each 64-bit register could only have one 32-bit sub-register. This
is exactly the case which LLVM think brings no benefits for doing
sub-register tracking, because the live range of sub-register must always
equal to its parent register, therefore liveness tracking is disabled even
the back-end has implemented enableSubRegLiveness. The detailed information
is at r232695:

  Author: Matthias Braun <matze@braunis.de>
  Date:   Thu Mar 19 00:21:58 2015 +0000
  Do not track subregister liveness when it brings no benefits

Hence, for BPF, we enhance MachineInstr::allDefsAreDead. Given the solo
sub-register always has the same liveness as its parent register, LLVM is
already attaching a implicit 64-bit register Def whenever the there is
a sub-register Def. The liveness of the implicit 64-bit Def is available.
For example, for "lock *(u32 *)(r0 + 4) += w9", the MachineOperand info
could be:

  $w9 = XADDW32 killed $r0, 4, $w9(tied-def 0),
                       implicit killed $r9, implicit-def dead $r9

Even though w9 is not marked as Dead, the parent register r9 is marked as
Dead correctly, and it is safe to use such information or our purpose.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 lib/Target/BPF/BPFMIChecking.cpp | 103 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/lib/Target/BPF/BPFMIChecking.cpp b/lib/Target/BPF/BPFMIChecking.cpp
index a1e81cb..7a4ba96 100644
--- a/lib/Target/BPF/BPFMIChecking.cpp
+++ b/lib/Target/BPF/BPFMIChecking.cpp
@@ -61,6 +61,107 @@ void BPFMIPreEmitChecking::initialize(MachineFunction &MFParm) {
   LLVM_DEBUG(dbgs() << "*** BPF PreEmit checking pass ***\n\n");
 }
 
+// Make sure all Defs of XADD are dead, meaning any result of XADD insn is not
+// used.
+//
+// NOTE: BPF backend hasn't enabled sub-register liveness track, so when the
+// source and destination operands of XADD are GPR32, there is no sub-register
+// dead info. If we rely on the generic MachineInstr::allDefsAreDead, then we
+// will raise false alarm on GPR32 Def.
+//
+// To support GPR32 Def, ideally we could just enable sub-registr liveness track
+// on BPF backend, then allDefsAreDead could work on GPR32 Def. This requires
+// implementing TargetSubtargetInfo::enableSubRegLiveness on BPF.
+//
+// However, sub-register liveness tracking module inside LLVM is actually
+// designed for the situation where one register could be splitted into more
+// than one sub-registers for which case each sub-register could have their own
+// liveness and kill one of them doesn't kill others. So, tracking liveness for
+// each make sense.
+//
+// For BPF, each 64-bit register could only have one 32-bit sub-register. This
+// is exactly the case which LLVM think brings no benefits for doing
+// sub-register tracking, because the live range of sub-register must always
+// equal to its parent register, therefore liveness tracking is disabled even
+// the back-end has implemented enableSubRegLiveness. The detailed information
+// is at r232695:
+//
+//   Author: Matthias Braun <matze@braunis.de>
+//   Date:   Thu Mar 19 00:21:58 2015 +0000
+//   Do not track subregister liveness when it brings no benefits
+//
+// Hence, for BPF, we enhance MachineInstr::allDefsAreDead. Given the solo
+// sub-register always has the same liveness as its parent register, LLVM is
+// already attaching a implicit 64-bit register Def whenever the there is
+// a sub-register Def. The liveness of the implicit 64-bit Def is available.
+// For example, for "lock *(u32 *)(r0 + 4) += w9", the MachineOperand info could
+// be:
+//
+//   $w9 = XADDW32 killed $r0, 4, $w9(tied-def 0),
+//                        implicit killed $r9, implicit-def dead $r9
+//
+// Even though w9 is not marked as Dead, the parent register r9 is marked as
+// Dead correctly, and it is safe to use such information or our purpose.
+static bool hasLivingDefs(const MachineInstr &MI,
+                          const TargetRegisterInfo *TRI) {
+  const MCRegisterClass *GPR64RegClass =
+    &BPFMCRegisterClasses[BPF::GPRRegClassID];
+  std::vector<unsigned> GPR32LiveDefs;
+  std::vector<unsigned> GPR64DeadDefs;
+
+  for (const MachineOperand &MO : MI.operands()) {
+    bool RegIsGPR64;
+
+    if (!MO.isReg() || MO.isUse())
+      continue;
+
+    RegIsGPR64 = GPR64RegClass->contains(MO.getReg());
+    if (!MO.isDead()) {
+      // It is a GPR64 live Def, we are sure it is live. */
+      if (RegIsGPR64)
+        return true;
+      // It is a GPR32 live Def, we are unsure whether it is really dead due to
+      // no sub-register liveness tracking. Push it to vector for deferred
+      // check.
+      GPR32LiveDefs.push_back(MO.getReg());
+      continue;
+    }
+
+    // Record any GPR64 dead Def as some unmarked GPR32 could be alias of its
+    // low 32-bit.
+    if (RegIsGPR64)
+      GPR64DeadDefs.push_back(MO.getReg());
+  }
+
+  // No GPR32 live Def, safe to return false.
+  if (GPR32LiveDefs.empty())
+    return false;
+
+  // No GPR64 dead Def, so all those GPR32 live Def can't have alias, therefore
+  // must be truely live, safe to return true.
+  if (GPR64DeadDefs.empty())
+    return true;
+
+  // Otherwise, return true if any aliased SuperReg of GPR32 is not dead.
+  std::vector<unsigned>::iterator search_begin = GPR64DeadDefs.begin();
+  std::vector<unsigned>::iterator search_end = GPR64DeadDefs.end();
+  for (auto I : GPR32LiveDefs) {
+    bool ActuallyDead = true;
+
+    for (MCSuperRegIterator SR(I, TRI); SR.isValid(); ++SR) {
+       if (std::find(search_begin, search_end, *SR) == search_end) {
+         ActuallyDead = false;
+         break;
+       }
+    }
+
+    if (!ActuallyDead)
+      return true;
+  }
+
+  return false;
+}
+
 void BPFMIPreEmitChecking::checkingIllegalXADD(void) {
   for (MachineBasicBlock &MBB : *MF) {
     for (MachineInstr &MI : MBB) {
@@ -68,7 +169,7 @@ void BPFMIPreEmitChecking::checkingIllegalXADD(void) {
         continue;
 
       LLVM_DEBUG(MI.dump());
-      if (!MI.allDefsAreDead()) {
+      if (hasLivingDefs(MI, TRI)) {
         DebugLoc Empty;
         const DebugLoc &DL = MI.getDebugLoc();
         if (DL != Empty)
-- 
2.7.4

