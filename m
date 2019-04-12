Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762DAC10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 21:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEC120850
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 21:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555105299;
	bh=wWuDfUmc35Nvz/zunKJ9BIH+iDjKJGnNlkNWRuVCQpI=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=o076ZzAx9kWzj7fXxeRPWPzrnzR39qLWbeayK3Czdb/6JB8KpIaZvXMSIFeCt9UA9
	 gz9o9fjkkEkewpPjgdsSpo8w9vyWNuM6qY4kIU57Xpo7e0wIJKpKextWHS17UaBZaM
	 Fdgd8FpewG/AVhrkurmSt2PquJNz7oxwvY91sSLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfDLVlj convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 12 Apr 2019 17:41:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33508 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbfDLVli (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Apr 2019 17:41:38 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CLYdSR005125
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 14:41:37 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rtw0ws6y3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 14:41:37 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 12 Apr 2019 14:41:36 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 9803F7609DB; Fri, 12 Apr 2019 14:41:32 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] selftests/bpf: two scale tests
Date:   Fri, 12 Apr 2019 14:41:32 -0700
Message-ID: <20190412214132.2726285-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two tests to check that sequence of 1024 jumps is verifiable.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c  | 70 ++++++++++++++++++++
 tools/testing/selftests/bpf/verifier/scale.c | 18 +++++
 2 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/scale.c

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index e2ebcaddbe78..6cb6a1074fd1 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -208,6 +208,76 @@ static void bpf_fill_rand_ld_dw(struct bpf_test *self)
 	self->retval = (uint32_t)res;
 }
 
+/* test the sequence of 1k jumps */
+static void bpf_fill_scale1(struct bpf_test *self)
+{
+	struct bpf_insn *insn = self->fill_insns;
+	int i = 0, k = 0;
+
+	insn[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	/* test to check that the sequence of 1024 jumps is acceptable */
+	while (k++ < 1024) {
+		insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+					 BPF_FUNC_get_prandom_u32);
+		insn[i++] = BPF_JMP_IMM(BPF_JGT, BPF_REG_0, bpf_semi_rand_get(), 2);
+		insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
+		insn[i++] = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6,
+					-8 * (k % 64 + 1));
+	}
+	/* every jump adds 1024 steps to insn_processed, so to stay exactly
+	 * within 1m limit add MAX_TEST_INSNS - 1025 MOVs and 1 EXIT
+	 */
+	while (i < MAX_TEST_INSNS - 1025)
+		insn[i++] = BPF_ALU32_IMM(BPF_MOV, BPF_REG_0, 42);
+	insn[i] = BPF_EXIT_INSN();
+	self->prog_len = i + 1;
+	self->retval = 42;
+}
+
+/* test the sequence of 1k jumps in inner most function (function depth 8)*/
+static void bpf_fill_scale2(struct bpf_test *self)
+{
+	struct bpf_insn *insn = self->fill_insns;
+	int i = 0, k = 0;
+
+#define FUNC_NEST 7
+	for (k = 0; k < FUNC_NEST; k++) {
+		insn[i++] = BPF_CALL_REL(1);
+		insn[i++] = BPF_EXIT_INSN();
+	}
+	insn[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	/* test to check that the sequence of 1024 jumps is acceptable */
+	while (k++ < 1024) {
+		insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+					 BPF_FUNC_get_prandom_u32);
+		insn[i++] = BPF_JMP_IMM(BPF_JGT, BPF_REG_0, bpf_semi_rand_get(), 2);
+		insn[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
+		insn[i++] = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6,
+					-8 * (k % (64 - 4 * FUNC_NEST) + 1));
+	}
+	/* every jump adds 1024 steps to insn_processed, so to stay exactly
+	 * within 1m limit add MAX_TEST_INSNS - 1025 MOVs and 1 EXIT
+	 */
+	while (i < MAX_TEST_INSNS - 1025)
+		insn[i++] = BPF_ALU32_IMM(BPF_MOV, BPF_REG_0, 42);
+	insn[i] = BPF_EXIT_INSN();
+	self->prog_len = i + 1;
+	self->retval = 42;
+}
+
+static void bpf_fill_scale(struct bpf_test *self)
+{
+	switch (self->retval) {
+	case 1:
+		return bpf_fill_scale1(self);
+	case 2:
+		return bpf_fill_scale2(self);
+	default:
+		self->prog_len = 0;
+		break;
+	}
+}
+
 /* BPF_SK_LOOKUP contains 13 instructions, if you need to fix up maps */
 #define BPF_SK_LOOKUP(func)						\
 	/* struct bpf_sock_tuple tuple = {} */				\
diff --git a/tools/testing/selftests/bpf/verifier/scale.c b/tools/testing/selftests/bpf/verifier/scale.c
new file mode 100644
index 000000000000..7f868d4802e0
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/scale.c
@@ -0,0 +1,18 @@
+{
+	"scale: scale test 1",
+	.insns = { },
+	.data = { },
+	.fill_helper = bpf_fill_scale,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"scale: scale test 2",
+	.insns = { },
+	.data = { },
+	.fill_helper = bpf_fill_scale,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+	.retval = 2,
+},
-- 
2.20.0

