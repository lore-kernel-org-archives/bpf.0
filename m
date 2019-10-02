Return-Path: <SRS0=XbBo=X3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591F3C47404
	for <bpf@archiver.kernel.org>; Wed,  2 Oct 2019 23:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D16D21848
	for <bpf@archiver.kernel.org>; Wed,  2 Oct 2019 23:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfJBXpV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:45:21 -0400
Received: from www62.your-server.de ([213.133.104.62]:50936 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfJBXpV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 19:45:21 -0400
Received: from 57.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.57] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iFoJ5-0001sL-O9; Thu, 03 Oct 2019 01:45:19 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 2/2] bpf: Add loop test case with 32 bit reg comparison against 0
Date:   Thu,  3 Oct 2019 01:45:12 +0200
Message-Id: <20191002234512.25902-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002234512.25902-1-daniel@iogearbox.net>
References: <20191002234512.25902-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25590/Wed Oct  2 10:31:24 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a loop test with 32 bit register against 0 immediate:

  # ./test_verifier 631
  #631/p taken loop with back jump to 1st insn, 2 OK

Disassembly:

  [...]
  1b:	test   %edi,%edi
  1d:	jne    0x0000000000000014
  [...]

Pretty much similar to prior "taken loop with back jump to 1st
insn" test case just as jmp32 variant.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/verifier/loops1.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/loops1.c b/tools/testing/selftests/bpf/verifier/loops1.c
index 1fc4e61e9f9f..1af37187dc12 100644
--- a/tools/testing/selftests/bpf/verifier/loops1.c
+++ b/tools/testing/selftests/bpf/verifier/loops1.c
@@ -187,3 +187,20 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.retval = 55,
 },
+{
+	"taken loop with back jump to 1st insn, 2",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, 10),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1),
+	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
+	BPF_JMP32_IMM(BPF_JNE, BPF_REG_1, 0, -3),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.retval = 55,
+},
-- 
2.17.1

