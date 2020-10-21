Return-Path: <SRS0=mVHy=D4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2542C4363A
	for <bpf@archiver.kernel.org>; Wed, 21 Oct 2020 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A95722248
	for <bpf@archiver.kernel.org>; Wed, 21 Oct 2020 20:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505370AbgJUUdS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:33:18 -0400
Received: from www62.your-server.de ([213.133.104.62]:58516 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505367AbgJUUdR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 16:33:17 -0400
Received: from 75.57.196.178.dynamic.wline.res.cust.swisscom.ch ([178.196.57.75] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kVKnK-0000A7-Ho; Wed, 21 Oct 2020 22:33:14 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     alexei.starovoitov@gmail.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, yanivagman@gmail.com,
        yhs@fb.com, andrii.nakryiko@gmail.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf, libbpf: guard bpf inline asm from bpf_tail_call_static
Date:   Wed, 21 Oct 2020 22:32:57 +0200
Message-Id: <20201021203257.26223-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25512/Tue Jul 16 10:09:55 2019)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yaniv reported a compilation error after pulling latest libbpf:

  [...]
  ../libbpf/src/root/usr/include/bpf/bpf_helpers.h:99:10: error:
  unknown register name 'r0' in asm
                     : "r0", "r1", "r2", "r3", "r4", "r5");
  [...]

The issue got triggered given Yaniv was compiling tracing programs with native
target (e.g. x86) instead of BPF target, hence no BTF generated vmlinux.h nor
CO-RE used, and later llc with -march=bpf was invoked to compile from LLVM IR
to BPF object file. Given that clang was expecting x86 inline asm and not BPF
one the error complained that these regs don't exist on the former.

Guard bpf_tail_call_static() with defined(__bpf__) where BPF inline asm is valid
to use. BPF tracing programs on more modern kernels use BPF target anyway and
thus the bpf_tail_call_static() function will be available for them. BPF inline
asm is supported since clang 7 (clang <= 6 otherwise throws same above error),
and __bpf_unreachable() since clang 8, therefore include the latter condition
in order to prevent compilation errors for older clang versions. Given even an
old Ubuntu 18.04 LTS has official LLVM packages all the way up to llvm-10, I did
not bother to special case the __bpf_unreachable() inside bpf_tail_call_static()
further.

Fixes: 0e9f6841f664 ("bpf, libbpf: Add bpf_tail_call_static helper for bpf programs")
Reported-by: Yaniv Agman <yanivagman@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com
---
 tools/lib/bpf/bpf_helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 2bdb7d6dbad2..72b251110c4d 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -72,6 +72,7 @@
 /*
  * Helper function to perform a tail call with a constant/immediate map slot.
  */
+#if __clang_major__ >= 8 && defined(__bpf__)
 static __always_inline void
 bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 {
@@ -98,6 +99,7 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 		     :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
 		     : "r0", "r1", "r2", "r3", "r4", "r5");
 }
+#endif
 
 /*
  * Helper structure used by eBPF C program
-- 
2.17.1

