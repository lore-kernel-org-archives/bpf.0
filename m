Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2457C10F01
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 20:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE3021850
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 20:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xm1Hru9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfB0UvA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:51:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35414 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbfB0UvA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 15:51:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id y15so6905901wma.0
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 12:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fEPlwIxP75pYgftYB8xZJ63xi2KZoglJe7dCzi3f46M=;
        b=xm1Hru9IyVOw/tuakZ+pZjbFvPo4u4hs/Vk5gHgtZuKVXseWmaTnsgShXpN62bLVU+
         qvKu409ZPMlSGY8RDwIIUKf4ozPbDh3A3Q6Gfj6/HhOQTC4kRLTw9XogWslVJWtKL74f
         /3RX/ZzfFbReAKrWqpLzgA5TyVQK7RGeP+RsVjescGkiZC4IvNJdc7vzj2hzkQlxAbx+
         oj9GDG8xX5FMdo/G7LWhga+VoZ7TFrt/BQ5kOKmhMa0NXWTPh+psdN2NRkGZlCAjEYqX
         E0R+WyeTEZmoUl3hiz/zQ47BFEGWOBYoN9GTNWOyejizrpxMmwVjF9geHW+h4Rw6SFQL
         TSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fEPlwIxP75pYgftYB8xZJ63xi2KZoglJe7dCzi3f46M=;
        b=gRLuOrL6IU6ON02V58sQULfauq0iQdvYBqNS97EiDgT0Yxy5EOq6fZzXXjl1EgR1vo
         MwM8IJ33A3Z+W8fhKthkWn8vTC0YvwN/EsjN6B2Of6IwFOKGBT8H6rkJjsSrQju2A3pq
         jvs1Yf+eUkcHdZ6KkjS90wqfpO5K6Az25OGeNCflMCzLxzffJRVWqYCV+K5DJkvjeFW4
         9nUiuZ3zZ8Q7JuNSOVdcL2/A0gEShzNjcuLlScqxUFMRyE6BWcigA8V/3eeq2aQYCTeW
         xKkesnR2X0F87Hebkkig+nydtJjCuGyBL53z9xtEOIck0Bih7wQWW9lz06nHfw+iwVMK
         hzMA==
X-Gm-Message-State: AHQUAuYRUc3S68aRtvuPZVYbQZ8quZRrVoHwKWDYYr1F5pyyjXQl6BkK
        XVfOPo27q7H/THBKc6+9tEEiow==
X-Google-Smtp-Source: AHgI3IYroC36M8qMzr73oc6uC4K6vp6m/qWX3XN8dnDCLTHL7ldrqgyvA/CHKgMKsVa2zkMBjffmTw==
X-Received: by 2002:a1c:4e09:: with SMTP id g9mr677531wmh.56.1551300657855;
        Wed, 27 Feb 2019 12:50:57 -0800 (PST)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id e193sm5362912wmg.18.2019.02.27.12.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 12:50:56 -0800 (PST)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, yhs@fb.com
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH LLVM 3/3] bpf: disassembler support for XADD under sub-register mode
Date:   Wed, 27 Feb 2019 20:50:41 +0000
Message-Id: <1551300641-1727-4-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
References: <1551300641-1727-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Like the other load/store instructions, "w" register is prefered when
disassembling BPF_STX | BPF_W | BPF_XADD under sub-register mode.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 lib/Target/BPF/Disassembler/BPFDisassembler.cpp | 3 ++-
 test/MC/BPF/load-store-32.s                     | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

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

