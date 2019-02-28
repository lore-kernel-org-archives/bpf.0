Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF9BC10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48D1218AE
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 09:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ozshRHEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfB1J73 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:59:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33393 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732159AbfB1J72 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 04:59:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so21260254wrw.0
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 01:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dp/aKuIjGOhTjb06AvYPmwO12zWRB0DTfpqSoALA5ew=;
        b=ozshRHEMfUpF/3V22f3vSGz32Uo5OHfXyPAtMXS0C1qVYFTF/9PAIQq8Dd6wQxaiL/
         VBbuNtmoy0RJlbg6BW1SAeQUglCFTUcd/SWfAwcSD4JtiIj3uim9gdgCFzWkFDXBl/V8
         ZXIjt6J4fyLwdKOvhe3A/WPSyOcja1OouSXZoEmoQsMZcGQqouMaeyyQXr33dm+LEpy8
         wvHsKC/f6JHlmRjGgtA6TdE+irW3ud4D3VXw6fW56LZQIVp8fV3BKTzZ/RWkr/R8UvNB
         BMpFFUGAUQEDrz7hW2g0SVsLOEnNYeG/zWYf9a9kk7KuYxQ9pxwMTo4R2tNbOnyLm6D0
         XJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dp/aKuIjGOhTjb06AvYPmwO12zWRB0DTfpqSoALA5ew=;
        b=rZbYKgEUr+cFDN2QyzXNQQ5i8a90Oqjh1eyl5w5ch8kg6P7KMvYRfpo1hVZSReHXXd
         z4XwmBUassCbJQoYbioPJGUFPOhwsYQUJTOY1tKGJdxPwQPF0RVZZz9n+qsC3KHhERca
         HyAaFWOx+e1yS78DHRA1OgqptMgBl/+MfBsQEOnGyTM+uKM/EdIHPC+2riFU2IDvkAfg
         lqVT3AKqQh/9vDQMDrJkJc5rcU1RlAc8sKTNvq0Fk4/DTAx6Bml2iXsrLMEQbJSqjkRy
         WDDA7oxRyb02WpjEm4/e27XhfjNbedmEc4ORKLqqB0bghkY+w/gaP6d+RG08SxKvdjzj
         rj0Q==
X-Gm-Message-State: APjAAAWIYLnD5OEQ6JMZQxSoDjMVbplYxJawaulABoMKjtJt+cpWtQcC
        kCzsnGgunyABprWQU/vKUM+YIw==
X-Google-Smtp-Source: APXvYqzE/i6XoJB2AUyf3HLcOChXSuOoOlMMTWFuG4JfM39KqTihRt/rrPnCkRHYvffdpn585qE8OQ==
X-Received: by 2002:a5d:6781:: with SMTP id v1mr5342197wru.167.1551347966707;
        Thu, 28 Feb 2019 01:59:26 -0800 (PST)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id y5sm4965261wmg.31.2019.02.28.01.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Feb 2019 01:59:25 -0800 (PST)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, yhs@fb.com
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH LLVM v2 3/3] bpf: disassembler support for XADD under sub-register mode
Date:   Thu, 28 Feb 2019 09:59:17 +0000
Message-Id: <1551347957-4068-4-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551347957-4068-1-git-send-email-jiong.wang@netronome.com>
References: <1551347957-4068-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Like the other load/store instructions, "w" register is preferred when
disassembling BPF_STX | BPF_W | BPF_XADD.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 lib/Target/BPF/Disassembler/BPFDisassembler.cpp | 3 ++-
 test/MC/BPF/insn-unit.s                         | 3 ++-
 test/MC/BPF/load-store-32.s                     | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/Target/BPF/Disassembler/BPFDisassembler.cpp b/lib/Target/BPF/Disassembler/BPFDisassembler.cpp
index ed09e44..c5be7cb 100644
--- a/lib/Target/BPF/Disassembler/BPFDisassembler.cpp
+++ b/lib/Target/BPF/Disassembler/BPFDisassembler.cpp
@@ -171,9 +171,10 @@ DecodeStatus BPFDisassembler::getInstruction(MCInst &Instr, uint64_t &Size,
   if (Result == MCDisassembler::Fail) return MCDisassembler::Fail;
 
   uint8_t InstClass = getInstClass(Insn);
+  uint8_t InstMode = getInstMode(Insn);
   if ((InstClass == BPF_LDX || InstClass == BPF_STX) &&
       getInstSize(Insn) != BPF_DW &&
-      getInstMode(Insn) == BPF_MEM &&
+      (InstMode == BPF_MEM || InstMode == BPF_XADD) &&
       STI.getFeatureBits()[BPF::ALU32])
     Result = decodeInstruction(DecoderTableBPFALU3264, Instr, Insn, Address,
                                this, STI);
diff --git a/test/MC/BPF/insn-unit.s b/test/MC/BPF/insn-unit.s
index c61c002..ff56cfa 100644
--- a/test/MC/BPF/insn-unit.s
+++ b/test/MC/BPF/insn-unit.s
@@ -57,7 +57,8 @@
 
   lock *(u32 *)(r2 + 16) += r9  // BPF_STX | BPF_W | BPF_XADD
   lock *(u64 *)(r3 - 30) += r10 // BPF_STX | BPF_DW | BPF_XADD
-// CHECK: c3 92 10 00 00 00 00 00 	lock *(u32 *)(r2 + 16) += r9
+// CHECK-64: c3 92 10 00 00 00 00 00 	lock *(u32 *)(r2 + 16) += r9
+// CHECK-32: c3 92 10 00 00 00 00 00 	lock *(u32 *)(r2 + 16) += w9
 // CHECK: db a3 e2 ff 00 00 00 00 	lock *(u64 *)(r3 - 30) += r10
 
 // ======== BPF_JMP Class ========
diff --git a/test/MC/BPF/load-store-32.s b/test/MC/BPF/load-store-32.s
index 73ed9fc..be576d2 100644
--- a/test/MC/BPF/load-store-32.s
+++ b/test/MC/BPF/load-store-32.s
@@ -17,9 +17,12 @@
   *(u8 *)(r0 + 0) = w7    // BPF_STX | BPF_B
   *(u16 *)(r1 + 8) = w8   // BPF_STX | BPF_H
   *(u32 *)(r2 + 16) = w9  // BPF_STX | BPF_W
+  lock *(u32 *)(r2 + 16) += w9  // BPF_STX | BPF_W | BPF_XADD
 // CHECK-32: 73 70 00 00 00 00 00 00 	*(u8 *)(r0 + 0) = w7
 // CHECK-32: 6b 81 08 00 00 00 00 00 	*(u16 *)(r1 + 8) = w8
 // CHECK-32: 63 92 10 00 00 00 00 00 	*(u32 *)(r2 + 16) = w9
+// CHECK-32: c3 92 10 00 00 00 00 00 	lock *(u32 *)(r2 + 16) += w9
 // CHECK: 73 70 00 00 00 00 00 00 	*(u8 *)(r0 + 0) = r7
 // CHECK: 6b 81 08 00 00 00 00 00 	*(u16 *)(r1 + 8) = r8
 // CHECK: 63 92 10 00 00 00 00 00 	*(u32 *)(r2 + 16) = r9
+// CHECK: c3 92 10 00 00 00 00 00 	lock *(u32 *)(r2 + 16) += r9
-- 
2.7.4

