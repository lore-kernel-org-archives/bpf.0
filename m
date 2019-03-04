Return-Path: <SRS0=/NIo=RH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1BC43381
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 20:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64AF20835
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 20:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfCDUJC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:09:02 -0500
Received: from www62.your-server.de ([213.133.104.62]:36270 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfCDUJC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Mar 2019 15:09:02 -0500
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h0ttU-0003GZ-M8; Mon, 04 Mar 2019 21:09:00 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf: fix replace_map_fd_with_map_ptr's ldimm64 second imm field
Date:   Mon,  4 Mar 2019 21:08:53 +0100
Message-Id: <20190304200853.22558-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25378/Mon Mar  4 11:47:26 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Non-zero imm value in the second part of the ldimm64 instruction for
BPF_PSEUDO_MAP_FD is invalid, and thus must be rejected. The map fd
only ever sits in the first instructions' imm field. None of the BPF
loaders known to us are using it, so risk of regression is minimal.
For clarity and consistency, the few insn->{src_reg,imm} occurrences
are rewritten into insn[0].{src_reg,imm}. Add a test case to the BPF
selftest suite as well.

Fixes: 0246e64d9a5f ("bpf: handle pseudo BPF_LD_IMM64 insn")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 [ Needs to wait until bpf tree has everything fast-forwarded from
   Linus' tree. ]

 kernel/bpf/verifier.c                           | 10 +++++-----
 tools/testing/selftests/bpf/verifier/ld_imm64.c | 15 ++++++++++++++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0e4edd7..c8d2a94 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6678,17 +6678,17 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 				/* valid generic load 64-bit imm */
 				goto next_insn;
 
-			if (insn->src_reg != BPF_PSEUDO_MAP_FD) {
-				verbose(env,
-					"unrecognized bpf_ld_imm64 insn\n");
+			if (insn[0].src_reg != BPF_PSEUDO_MAP_FD ||
+			    insn[1].imm != 0) {
+				verbose(env, "unrecognized bpf_ld_imm64 insn\n");
 				return -EINVAL;
 			}
 
-			f = fdget(insn->imm);
+			f = fdget(insn[0].imm);
 			map = __bpf_map_get(f);
 			if (IS_ERR(map)) {
 				verbose(env, "fd %d is not pointing to valid bpf_map\n",
-					insn->imm);
+					insn[0].imm);
 				return PTR_ERR(map);
 			}
 
diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
index 28b8c80..3856dba 100644
--- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
+++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
@@ -122,7 +122,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, BPF_REG_1, 0, 1),
-	BPF_RAW_INSN(0, 0, 0, 0, 1),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "not pointing to valid bpf_map",
@@ -139,3 +139,16 @@
 	.errstr = "invalid bpf_ld_imm64 insn",
 	.result = REJECT,
 },
+{
+	"test14 ld_imm64: reject 2nd imm != 0",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_1,
+		     BPF_PSEUDO_MAP_FD, 0, 0),
+	BPF_RAW_INSN(0, 0, 0, 0, 0xfefefe),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_48b = { 1 },
+	.errstr = "unrecognized bpf_ld_imm64 insn",
+	.result = REJECT,
+},
-- 
2.9.5

