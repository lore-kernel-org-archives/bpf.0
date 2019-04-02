Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C316BC10F00
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916E5206B8
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554179298;
	bh=JrUfXBh+Hfi5L2BM9JJ6TpvuPh2yJKWwbmFYWwsqajY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sNcs3hGfBW2pWuo5XT/K+YUT7gAMBTpiXAKWCvmsDyJkYPEEH7Wy2Dag+Q0V+yRrX
	 wEaoUk9Zq1t5RJ27W9l4kEerMlkZJT+pHf+whyklW57OR0N0+5BABxXNsmAl/v/73h
	 88nyzZp0AluuGcgD9Bm1c3J4JwshXPQH2bS0irUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfDBE2S convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 2 Apr 2019 00:28:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40084 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728949AbfDBE2L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Apr 2019 00:28:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x324R4Qf020328
        for <bpf@vger.kernel.org>; Mon, 1 Apr 2019 21:28:10 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2rkug60v43-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 21:28:10 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 1 Apr 2019 21:28:10 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 04058760E11; Mon,  1 Apr 2019 21:28:09 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 10/10] selftests/bpf: synthetic tests to push verifier limits
Date:   Mon, 1 Apr 2019 21:27:49 -0700
Message-ID: <20190402042749.3670015-11-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190402042749.3670015-1-ast@kernel.org>
References: <20190402042749.3670015-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test to generate 1m ld_imm64 insns to stress the verifier.

Bump the size of fill_ld_abs_vlan_push_pop test from 4k to 29k
and jump_around_ld_abs from 4k to 5.5k.
Larger sizes are not possible due to 16-bit offset encoding
in jump instructions.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c  | 35 +++++++++++++++-----
 tools/testing/selftests/bpf/verifier/ld_dw.c |  9 +++++
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 19b5d03acc2a..75ef63b42f2c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -50,6 +50,7 @@
 #include "../../../include/linux/filter.h"
 
 #define MAX_INSNS	BPF_MAXINSNS
+#define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
 #define MAX_NR_MAPS	14
 #define MAX_TEST_RUNS	8
@@ -66,6 +67,7 @@ static int skips;
 struct bpf_test {
 	const char *descr;
 	struct bpf_insn	insns[MAX_INSNS];
+	struct bpf_insn	*fill_insns;
 	int fixup_map_hash_8b[MAX_FIXUPS];
 	int fixup_map_hash_48b[MAX_FIXUPS];
 	int fixup_map_hash_16b[MAX_FIXUPS];
@@ -83,6 +85,7 @@ struct bpf_test {
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval, retval_unpriv, insn_processed;
+	int prog_len;
 	enum {
 		UNDEF,
 		ACCEPT,
@@ -119,10 +122,11 @@ struct other_val {
 
 static void bpf_fill_ld_abs_vlan_push_pop(struct bpf_test *self)
 {
-	/* test: {skb->data[0], vlan_push} x 68 + {skb->data[0], vlan_pop} x 68 */
+	/* test: {skb->data[0], vlan_push} x 51 + {skb->data[0], vlan_pop} x 51 */
 #define PUSH_CNT 51
-	unsigned int len = BPF_MAXINSNS;
-	struct bpf_insn *insn = self->insns;
+	/* jump range is limited to 16 bit. PUSH_CNT of ld_abs needs room */
+	unsigned int len = (1 << 15) - PUSH_CNT * 2 * 5 * 6;
+	struct bpf_insn *insn = self->fill_insns;
 	int i = 0, j, k = 0;
 
 	insn[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
@@ -156,12 +160,14 @@ static void bpf_fill_ld_abs_vlan_push_pop(struct bpf_test *self)
 	for (; i < len - 1; i++)
 		insn[i] = BPF_ALU32_IMM(BPF_MOV, BPF_REG_0, 0xbef);
 	insn[len - 1] = BPF_EXIT_INSN();
+	self->prog_len = len;
 }
 
 static void bpf_fill_jump_around_ld_abs(struct bpf_test *self)
 {
-	struct bpf_insn *insn = self->insns;
-	unsigned int len = BPF_MAXINSNS;
+	struct bpf_insn *insn = self->fill_insns;
+	/* jump range is limited to 16 bit. every ld_abs is replaced by 6 insns */
+	unsigned int len = (1 << 15) / 6;
 	int i = 0;
 
 	insn[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
@@ -171,11 +177,12 @@ static void bpf_fill_jump_around_ld_abs(struct bpf_test *self)
 	while (i < len - 1)
 		insn[i++] = BPF_LD_ABS(BPF_B, 1);
 	insn[i] = BPF_EXIT_INSN();
+	self->prog_len = i + 1;
 }
 
 static void bpf_fill_rand_ld_dw(struct bpf_test *self)
 {
-	struct bpf_insn *insn = self->insns;
+	struct bpf_insn *insn = self->fill_insns;
 	uint64_t res = 0;
 	int i = 0;
 
@@ -193,6 +200,7 @@ static void bpf_fill_rand_ld_dw(struct bpf_test *self)
 	insn[i++] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32);
 	insn[i++] = BPF_ALU64_REG(BPF_XOR, BPF_REG_0, BPF_REG_1);
 	insn[i] = BPF_EXIT_INSN();
+	self->prog_len = i + 1;
 	res ^= (res >> 32);
 	self->retval = (uint32_t)res;
 }
@@ -520,8 +528,10 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_percpu_cgroup_storage = test->fixup_percpu_cgroup_storage;
 	int *fixup_map_spin_lock = test->fixup_map_spin_lock;
 
-	if (test->fill_helper)
+	if (test->fill_helper) {
+		test->fill_insns = calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
 		test->fill_helper(test);
+	}
 
 	/* Allocating HTs with 1 elem is fine here, since we only test
 	 * for verifier and not do a runtime lookup, so the only thing
@@ -718,12 +728,17 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
 	fixup_skips = skips;
 	do_test_fixup(test, prog_type, prog, map_fds);
+	if (test->fill_insns) {
+		prog = test->fill_insns;
+		prog_len = test->prog_len;
+	} else {
+		prog_len = probe_filter_length(prog);
+	}
 	/* If there were some map skips during fixup due to missing bpf
 	 * features, skip this test.
 	 */
 	if (fixup_skips != skips)
 		return;
-	prog_len = probe_filter_length(prog);
 
 	pflags = 0;
 	if (test->flags & F_LOAD_WITH_STRICT_ALIGNMENT)
@@ -731,7 +746,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	if (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS)
 		pflags |= BPF_F_ANY_ALIGNMENT;
 	fd_prog = bpf_verify_program(prog_type, prog, prog_len, pflags,
-				     "GPL", 0, bpf_vlog, sizeof(bpf_vlog), 1);
+				     "GPL", 0, bpf_vlog, sizeof(bpf_vlog), 4);
 	if (fd_prog < 0 && !bpf_probe_prog_type(prog_type, 0)) {
 		printf("SKIP (unsupported program type %d)\n", prog_type);
 		skips++;
@@ -830,6 +845,8 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		goto fail_log;
 	}
 close_fds:
+	if (test->fill_insns)
+		free(test->fill_insns);
 	close(fd_prog);
 	for (i = 0; i < MAX_NR_MAPS; i++)
 		close(map_fds[i]);
diff --git a/tools/testing/selftests/bpf/verifier/ld_dw.c b/tools/testing/selftests/bpf/verifier/ld_dw.c
index d2c75b889598..0f18e62f0099 100644
--- a/tools/testing/selftests/bpf/verifier/ld_dw.c
+++ b/tools/testing/selftests/bpf/verifier/ld_dw.c
@@ -34,3 +34,12 @@
 	.result = ACCEPT,
 	.retval = 5,
 },
+{
+	"ld_dw: xor semi-random 64 bit imms, test 5",
+	.insns = { },
+	.data = { },
+	.fill_helper = bpf_fill_rand_ld_dw,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+	.retval = 1000000 - 6,
+},
-- 
2.20.0

