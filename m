Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE59C43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 23:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228FA20869
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 23:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ud+9m749"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfDZXj5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 19:39:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45222 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727086AbfDZXj5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Apr 2019 19:39:57 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QNd3bj009647
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 16:39:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=yAdepoe+dD4+EfKVVaaO9aIg7hsF6QXKesu6mSthZBs=;
 b=Ud+9m749yU5+DXjZbxwmJK3zrpcXSrQfrxrXIIwMlEzKhiGNcZSwSfwCBiURICPlOYiV
 J2e36JWKc5mcbJ2tbclzTC3jwJ28z/FsGf43yqNKKS4RnWojH6JxAvwF+Ppg+1q+8KOH
 yG33k6fuD46dQiL0nfgI1+KgAitr32PWU7g= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s456usadb-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 16:39:56 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 26 Apr 2019 16:39:55 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id EF07429425A9; Fri, 26 Apr 2019 16:39:49 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Stanislav Fomichev <sdf@fomichev.me>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 5/7] bpf: Add verifier tests for the bpf_sk_storage
Date:   Fri, 26 Apr 2019 16:39:49 -0700
Message-ID: <20190426233949.1330827-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426233938.1330361-1-kafai@fb.com>
References: <20190426233938.1330361-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds verifier tests for the bpf_sk_storage:
1. ARG_PTR_TO_MAP_VALUE_OR_NULL
2. Map and helper compatibility (e.g. disallow bpf_map_loookup_elem)

It also takes this chance to remove the unused struct btf_raw_data
and uses the BTF encoding macros from "test_btf.h".

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/test_verifier.c |  55 ++++++----
 tools/testing/selftests/bpf/verifier/sock.c | 116 ++++++++++++++++++++
 2 files changed, 152 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index ed9e894afef3..ccd896b98cac 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -47,12 +47,13 @@
 #include "bpf_rlimit.h"
 #include "bpf_rand.h"
 #include "bpf_util.h"
+#include "test_btf.h"
 #include "../../../include/linux/filter.h"
 
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	17
+#define MAX_NR_MAPS	18
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
@@ -85,6 +86,7 @@ struct bpf_test {
 	int fixup_map_array_ro[MAX_FIXUPS];
 	int fixup_map_array_wo[MAX_FIXUPS];
 	int fixup_map_array_small[MAX_FIXUPS];
+	int fixup_sk_storage_map[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval, retval_unpriv, insn_processed;
@@ -497,24 +499,6 @@ static int create_cgroup_storage(bool percpu)
 	return fd;
 }
 
-#define BTF_INFO_ENC(kind, kind_flag, vlen) \
-	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
-#define BTF_TYPE_ENC(name, info, size_or_type) \
-	(name), (info), (size_or_type)
-#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
-	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
-#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz) \
-	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz), \
-	BTF_INT_ENC(encoding, bits_offset, bits)
-#define BTF_MEMBER_ENC(name, type, bits_offset) \
-	(name), (type), (bits_offset)
-
-struct btf_raw_data {
-	__u32 raw_types[64];
-	const char *str_sec;
-	__u32 str_sec_size;
-};
-
 /* struct bpf_spin_lock {
  *   int val;
  * };
@@ -589,6 +573,31 @@ static int create_map_spin_lock(void)
 	return fd;
 }
 
+static int create_sk_storage_map(void)
+{
+	struct bpf_create_map_attr attr = {
+		.name = "test_map",
+		.map_type = BPF_MAP_TYPE_SK_STORAGE,
+		.key_size = 4,
+		.value_size = 8,
+		.max_entries = 0,
+		.map_flags = BPF_F_NO_PREALLOC,
+		.btf_key_type_id = 1,
+		.btf_value_type_id = 3,
+	};
+	int fd, btf_fd;
+
+	btf_fd = load_btf();
+	if (btf_fd < 0)
+		return -1;
+	attr.btf_fd = btf_fd;
+	fd = bpf_create_map_xattr(&attr);
+	close(attr.btf_fd);
+	if (fd < 0)
+		printf("Failed to create sk_storage_map\n");
+	return fd;
+}
+
 static char bpf_vlog[UINT_MAX >> 8];
 
 static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
@@ -611,6 +620,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_map_array_ro = test->fixup_map_array_ro;
 	int *fixup_map_array_wo = test->fixup_map_array_wo;
 	int *fixup_map_array_small = test->fixup_map_array_small;
+	int *fixup_sk_storage_map = test->fixup_sk_storage_map;
 
 	if (test->fill_helper) {
 		test->fill_insns = calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
@@ -765,6 +775,13 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 			fixup_map_array_small++;
 		} while (*fixup_map_array_small);
 	}
+	if (*fixup_sk_storage_map) {
+		map_fds[17] = create_sk_storage_map();
+		do {
+			prog[*fixup_sk_storage_map].imm = map_fds[17];
+			fixup_sk_storage_map++;
+		} while (*fixup_sk_storage_map);
+	}
 }
 
 static int set_admin(bool admin)
diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
index 416436231fab..b31cd2cf50d0 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -382,3 +382,119 @@
 	.result = REJECT,
 	.errstr = "reference has not been acquired before",
 },
+{
+	"sk_storage_get(map, skb->sk, NULL, 0): value == NULL",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_EMIT_CALL(BPF_FUNC_sk_storage_get),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_sk_storage_map = { 11 },
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+},
+{
+	"sk_storage_get(map, skb->sk, 1, 1): value == 1",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_4, 1),
+	BPF_MOV64_IMM(BPF_REG_3, 1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_EMIT_CALL(BPF_FUNC_sk_storage_get),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_sk_storage_map = { 11 },
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = REJECT,
+	.errstr = "R3 type=inv expected=fp",
+},
+{
+	"sk_storage_get(map, skb->sk, &stack_value, 1): stack_value",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_4, 1),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -8),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_EMIT_CALL(BPF_FUNC_sk_storage_get),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_sk_storage_map = { 14 },
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+},
+{
+	"sk_storage_get(map, skb->sk, &stack_value, 1): partially init stack_value",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_2, -8),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_4, 1),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -8),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_EMIT_CALL(BPF_FUNC_sk_storage_get),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_sk_storage_map = { 14 },
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = REJECT,
+	.errstr = "invalid indirect read from stack",
+},
+{
+	"bpf_map_lookup_elem(smap, &key)",
+	.insns = {
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_sk_storage_map = { 3 },
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = REJECT,
+	.errstr = "cannot pass map_type 24 into func bpf_map_lookup_elem",
+},
-- 
2.17.1

