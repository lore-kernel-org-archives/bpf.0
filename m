Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D804C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 21:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F44206B6
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 21:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfCAVIY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:08:24 -0500
Received: from www62.your-server.de ([213.133.104.62]:45900 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCAVIY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 16:08:24 -0500
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzpOI-00024U-6r; Fri, 01 Mar 2019 22:08:22 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@fb.com
Cc:     afabre@cloudflare.com, marek@cloudflare.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf: add test cases for non-pointer sanitiation logic
Date:   Fri,  1 Mar 2019 22:08:21 +0100
Message-Id: <20190301210821.8330-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two additional tests for further asserting the
BPF_ALU_NON_POINTER logic with cases that were missed
previously.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Marek Majkowski <marek@cloudflare.com>
Cc: Arthur Fabre <afabre@cloudflare.com>
---
 .../selftests/bpf/verifier/value_ptr_arith.c  | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
index 4b721a77bebb..c3de1a2c9dc5 100644
--- a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
@@ -173,7 +173,7 @@
 	.retval = 0,
 },
 {
-	"sanitation: alu with different scalars",
+	"sanitation: alu with different scalars 1",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
@@ -198,6 +198,48 @@
 	.result = ACCEPT,
 	.retval = 0x100000,
 },
+{
+	"sanitation: alu with different scalars 2",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
+	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
+	BPF_EMIT_CALL(BPF_FUNC_map_delete_elem),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
+	BPF_EMIT_CALL(BPF_FUNC_map_delete_elem),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_6),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_7),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = ACCEPT,
+	.retval = -EINVAL * 2,
+},
+{
+	"sanitation: alu with different scalars 3",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, EINVAL),
+	BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, -1),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_0, EINVAL),
+	BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, -1),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_6),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_7),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = -EINVAL * 2,
+},
 {
 	"map access: value_ptr += known scalar, upper oob arith, test 1",
 	.insns = {
-- 
2.17.1

