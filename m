Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E68BC3E8A3
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F031A2133D
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDCSXe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:23:34 -0400
Received: from www62.your-server.de ([213.133.104.62]:55464 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDCSXe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 14:23:34 -0400
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBkXn-0006EO-SA; Wed, 03 Apr 2019 20:23:27 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, joe@wand.net.nz, yhs@fb.com,
        andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 13/15] bpf, selftest: test {rd,wr}only flags and direct value access
Date:   Wed,  3 Apr 2019 20:23:04 +0200
Message-Id: <2ef25fc55a3a2f9a2e4b3b7c78720608323c485d.1554314902.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554314902.git.daniel@iogearbox.net>
References: <cover.1554314902.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554314902.git.daniel@iogearbox.net>
References: <cover.1554314902.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25408/Wed Apr  3 09:53:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend test_verifier with various test cases around the two kernel
extensions, that is, {rd,wr}only map support as well as direct map
value access. All passing, one skipped due to xskmap not present
on test machine:

  # ./test_verifier
  [...]
  #920/p XDP pkt read, pkt_data <= pkt_meta', bad access 1 OK
  #921/p XDP pkt read, pkt_data <= pkt_meta', bad access 2 OK
  Summary: 1366 PASSED, 1 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/include/linux/filter.h                       |  14 ++
 tools/testing/selftests/bpf/test_verifier.c        |  53 ++++-
 .../testing/selftests/bpf/verifier/array_access.c  | 159 +++++++++++++
 .../selftests/bpf/verifier/direct_value_access.c   | 262 +++++++++++++++++++++
 4 files changed, 483 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/direct_value_access.c

diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index cce0b02..d288576 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -283,6 +283,20 @@
 #define BPF_LD_MAP_FD(DST, MAP_FD)				\
 	BPF_LD_IMM64_RAW(DST, BPF_PSEUDO_MAP_FD, MAP_FD)
 
+#define BPF_LD_MAP_VALUE(DST, MAP_FD, VALUE_IDX, VALUE_OFF)	\
+	((struct bpf_insn) {					\
+		.code  = BPF_LD | BPF_DW | BPF_IMM,		\
+		.dst_reg = DST,					\
+		.src_reg = BPF_PSEUDO_MAP_VALUE,		\
+		.off   = (__u16)(VALUE_IDX),			\
+		.imm   = MAP_FD }),				\
+	((struct bpf_insn) {					\
+		.code  = 0, /* zero is reserved opcode */	\
+		.dst_reg = 0,					\
+		.src_reg = 0,					\
+		.off   = ((__u32)(VALUE_IDX)) >> 16,		\
+		.imm   = VALUE_OFF })
+
 /* Relative call */
 
 #define BPF_CALL_REL(TGT)					\
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 19b5d03..cc32a36 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -51,7 +51,7 @@
 
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	14
+#define MAX_NR_MAPS	16
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
@@ -80,6 +80,9 @@ struct bpf_test {
 	int fixup_cgroup_storage[MAX_FIXUPS];
 	int fixup_percpu_cgroup_storage[MAX_FIXUPS];
 	int fixup_map_spin_lock[MAX_FIXUPS];
+	int fixup_map_array_ro[MAX_FIXUPS];
+	int fixup_map_array_wo[MAX_FIXUPS];
+	int fixup_map_array_small[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval, retval_unpriv, insn_processed;
@@ -277,13 +280,15 @@ static bool skip_unsupported_map(enum bpf_map_type map_type)
 	return false;
 }
 
-static int create_map(uint32_t type, uint32_t size_key,
-		      uint32_t size_value, uint32_t max_elem)
+static int __create_map(uint32_t type, uint32_t size_key,
+			uint32_t size_value, uint32_t max_elem,
+			uint32_t extra_flags)
 {
 	int fd;
 
 	fd = bpf_create_map(type, size_key, size_value, max_elem,
-			    type == BPF_MAP_TYPE_HASH ? BPF_F_NO_PREALLOC : 0);
+			    (type == BPF_MAP_TYPE_HASH ?
+			     BPF_F_NO_PREALLOC : 0) | extra_flags);
 	if (fd < 0) {
 		if (skip_unsupported_map(type))
 			return -1;
@@ -293,6 +298,12 @@ static int create_map(uint32_t type, uint32_t size_key,
 	return fd;
 }
 
+static int create_map(uint32_t type, uint32_t size_key,
+		      uint32_t size_value, uint32_t max_elem)
+{
+	return __create_map(type, size_key, size_value, max_elem, 0);
+}
+
 static void update_map(int fd, int index)
 {
 	struct test_val value = {
@@ -519,6 +530,9 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_cgroup_storage = test->fixup_cgroup_storage;
 	int *fixup_percpu_cgroup_storage = test->fixup_percpu_cgroup_storage;
 	int *fixup_map_spin_lock = test->fixup_map_spin_lock;
+	int *fixup_map_array_ro = test->fixup_map_array_ro;
+	int *fixup_map_array_wo = test->fixup_map_array_wo;
+	int *fixup_map_array_small = test->fixup_map_array_small;
 
 	if (test->fill_helper)
 		test->fill_helper(test);
@@ -556,7 +570,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 
 	if (*fixup_map_array_48b) {
 		map_fds[3] = create_map(BPF_MAP_TYPE_ARRAY, sizeof(int),
-					sizeof(struct test_val), 1);
+					sizeof(struct test_val), 2);
 		update_map(map_fds[3], 0);
 		do {
 			prog[*fixup_map_array_48b].imm = map_fds[3];
@@ -642,6 +656,35 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 			fixup_map_spin_lock++;
 		} while (*fixup_map_spin_lock);
 	}
+	if (*fixup_map_array_ro) {
+		map_fds[14] = __create_map(BPF_MAP_TYPE_ARRAY, sizeof(int),
+					   sizeof(struct test_val), 1,
+					   BPF_F_RDONLY_PROG);
+		update_map(map_fds[14], 0);
+		do {
+			prog[*fixup_map_array_ro].imm = map_fds[14];
+			fixup_map_array_ro++;
+		} while (*fixup_map_array_ro);
+	}
+	if (*fixup_map_array_wo) {
+		map_fds[15] = __create_map(BPF_MAP_TYPE_ARRAY, sizeof(int),
+					   sizeof(struct test_val), 1,
+					   BPF_F_WRONLY_PROG);
+		update_map(map_fds[15], 0);
+		do {
+			prog[*fixup_map_array_wo].imm = map_fds[15];
+			fixup_map_array_wo++;
+		} while (*fixup_map_array_wo);
+	}
+	if (*fixup_map_array_small) {
+		map_fds[16] = __create_map(BPF_MAP_TYPE_ARRAY, sizeof(int),
+					   1, 1, 0);
+		update_map(map_fds[16], 0);
+		do {
+			prog[*fixup_map_array_small].imm = map_fds[16];
+			fixup_map_array_small++;
+		} while (*fixup_map_array_small);
+	}
 }
 
 static int set_admin(bool admin)
diff --git a/tools/testing/selftests/bpf/verifier/array_access.c b/tools/testing/selftests/bpf/verifier/array_access.c
index 0dcecaf..9a2b6f9 100644
--- a/tools/testing/selftests/bpf/verifier/array_access.c
+++ b/tools/testing/selftests/bpf/verifier/array_access.c
@@ -217,3 +217,162 @@
 	.result = REJECT,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
+{
+	"valid read map access into a read-only array 1",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_ro = { 3 },
+	.result = ACCEPT,
+	.retval = 28,
+},
+{
+	"valid read map access into a read-only array 2",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_2, 4),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	BPF_MOV64_IMM(BPF_REG_5, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		     BPF_FUNC_csum_diff),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_array_ro = { 3 },
+	.result = ACCEPT,
+	.retval = -29,
+},
+{
+	"invalid write map access into a read-only array 1",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_ro = { 3 },
+	.result = REJECT,
+	.errstr = "write into map forbidden",
+},
+{
+	"invalid write map access into a read-only array 2",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_4, 8),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		     BPF_FUNC_skb_load_bytes),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_array_ro = { 4 },
+	.result = REJECT,
+	.errstr = "write into map forbidden",
+},
+{
+	"valid write map access into a write-only array 1",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 42),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_wo = { 3 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"valid write map access into a write-only array 2",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_4, 8),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		     BPF_FUNC_skb_load_bytes),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_array_wo = { 4 },
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"invalid read map access into a write-only array 1",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_wo = { 3 },
+	.result = REJECT,
+	.errstr = "read into map forbidden",
+},
+{
+	"invalid read map access into a write-only array 2",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_2, 4),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	BPF_MOV64_IMM(BPF_REG_5, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+		     BPF_FUNC_csum_diff),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_array_wo = { 3 },
+	.result = REJECT,
+	.errstr = "read into map forbidden",
+},
diff --git a/tools/testing/selftests/bpf/verifier/direct_value_access.c b/tools/testing/selftests/bpf/verifier/direct_value_access.c
new file mode 100644
index 0000000..99f4ee6
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/direct_value_access.c
@@ -0,0 +1,262 @@
+{
+	"direct map access, write test 1",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 0),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 4242),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"direct map access, write test 2",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 4242),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"direct map access, write test 3",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 8, 4242),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"direct map access, write test 4",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 40),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 4242),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"direct map access, write test 5",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 32),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 8, 4242),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"direct map access, write test 6",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 40),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 4, 4242),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "R1 min value is outside of the array range",
+},
+{
+	"direct map access, write test 7",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, -1),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 4, 4242),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "direct value offset of 4294967295 is not allowed",
+},
+{
+	"direct map access, write test 8",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 1),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, -1, 4242),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"direct map access, write test 9",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 48),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 4242),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "invalid access to map value pointer",
+},
+{
+	"direct map access, write test 10",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 47),
+	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 4),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"direct map access, write test 11",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 48),
+	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 4),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "invalid access to map value pointer",
+},
+{
+	"direct map access, write test 12",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, (1<<29)),
+	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 4),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "direct value offset of 536870912 is not allowed",
+},
+{
+	"direct map access, write test 13",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, (1<<29)-1),
+	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 4),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "invalid access to map value pointer, value_size=48 index=0 off=536870911",
+},
+{
+	"direct map access, write test 14",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 47),
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 0, 46),
+	BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
+	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1, 3 },
+	.result = ACCEPT,
+	.retval = 0xff,
+},
+{
+	"direct map access, write test 15",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1, 47),
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 1, 46),
+	BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
+	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1, 3 },
+	.result = ACCEPT,
+	.retval = 0xff,
+},
+{
+	"direct map access, write test 16",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1, 46),
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 0, 46),
+	BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
+	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1, 3 },
+	.result = ACCEPT,
+	.retval = 0,
+},
+{
+	"direct map access, write test 17",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1, 46),
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 2, 46),
+	BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
+	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1, 3 },
+	.result = REJECT,
+	.errstr = "invalid access to map value pointer, value_size=48 index=2 off=46",
+},
+{
+	"direct map access, write test 18",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, ~0, 46),
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, ~0, 46),
+	BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
+	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1, 3 },
+	.result = REJECT,
+	.errstr = "invalid access to map value pointer, value_size=48 index=4294967295 off=46",
+},
+{
+	"direct map access, write test 19",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 0),
+	BPF_ST_MEM(BPF_H, BPF_REG_1, 0, 42),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_small = { 1 },
+	.result = REJECT,
+	.errstr = "R1 min value is outside of the array range",
+},
+{
+	"direct map access, write test 20",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 0),
+	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_small = { 1 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"direct map access, write test 21",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0, 1),
+	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_small = { 1 },
+	.result = REJECT,
+	.errstr = "invalid access to map value pointer",
+},
-- 
2.9.5

