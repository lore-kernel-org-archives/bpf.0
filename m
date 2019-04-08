Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3AFC282CE
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A2A20663
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDHNyY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:54:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:46154 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfDHNyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 09:54:09 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDUin-0003iF-LB; Mon, 08 Apr 2019 15:54:01 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 14/16] bpf, selftest: test {rd, wr}only flags and direct value access
Date:   Mon,  8 Apr 2019 15:53:46 +0200
Message-Id: <3625c1c56ad024ac828a6dc6738711a9c0e82174.1554731339.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25413/Mon Apr  8 09:56:28 2019)
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
  #948/p XDP pkt read, pkt_meta' <= pkt_data, bad access 1 OK
  #949/p XDP pkt read, pkt_meta' <= pkt_data, bad access 2 OK
  #950/p XDP pkt read, pkt_data <= pkt_meta', good access OK
  #951/p XDP pkt read, pkt_data <= pkt_meta', bad access 1 OK
  #952/p XDP pkt read, pkt_data <= pkt_meta', bad access 2 OK
  Summary: 1410 PASSED, 1 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/include/linux/filter.h                       |  21 +-
 tools/testing/selftests/bpf/test_verifier.c        |  51 ++-
 .../testing/selftests/bpf/verifier/array_access.c  | 159 ++++++++++
 .../selftests/bpf/verifier/direct_value_access.c   | 347 +++++++++++++++++++++
 4 files changed, 573 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/direct_value_access.c

diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index cce0b02..ca28b6a 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -278,10 +278,29 @@
 		.off   = 0,					\
 		.imm   = ((__u64) (IMM)) >> 32 })
 
+#define BPF_LD_IMM64_RAW_FULL(DST, SRC, OFF1, OFF2, IMM1, IMM2)	\
+	((struct bpf_insn) {					\
+		.code  = BPF_LD | BPF_DW | BPF_IMM,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF1,					\
+		.imm   = IMM1 }),				\
+	((struct bpf_insn) {					\
+		.code  = 0, /* zero is reserved opcode */	\
+		.dst_reg = 0,					\
+		.src_reg = 0,					\
+		.off   = OFF2,					\
+		.imm   = IMM2 })
+
 /* pseudo BPF_LD_IMM64 insn used to refer to process-local map_fd */
 
 #define BPF_LD_MAP_FD(DST, MAP_FD)				\
-	BPF_LD_IMM64_RAW(DST, BPF_PSEUDO_MAP_FD, MAP_FD)
+	BPF_LD_IMM64_RAW_FULL(DST, BPF_PSEUDO_MAP_FD, 0, 0,	\
+			      MAP_FD, 0)
+
+#define BPF_LD_MAP_VALUE(DST, MAP_FD, VALUE_OFF)		\
+	BPF_LD_IMM64_RAW_FULL(DST, BPF_PSEUDO_MAP_VALUE, 0, 0,	\
+			      MAP_FD, VALUE_OFF)
 
 /* Relative call */
 
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 75ef63b..e2ebcad 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -52,7 +52,7 @@
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	14
+#define MAX_NR_MAPS	16
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
@@ -82,6 +82,9 @@ struct bpf_test {
 	int fixup_cgroup_storage[MAX_FIXUPS];
 	int fixup_percpu_cgroup_storage[MAX_FIXUPS];
 	int fixup_map_spin_lock[MAX_FIXUPS];
+	int fixup_map_array_ro[MAX_FIXUPS];
+	int fixup_map_array_wo[MAX_FIXUPS];
+	int fixup_map_array_small[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval, retval_unpriv, insn_processed;
@@ -285,13 +288,15 @@ static bool skip_unsupported_map(enum bpf_map_type map_type)
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
@@ -301,6 +306,12 @@ static int create_map(uint32_t type, uint32_t size_key,
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
@@ -527,6 +538,9 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_cgroup_storage = test->fixup_cgroup_storage;
 	int *fixup_percpu_cgroup_storage = test->fixup_percpu_cgroup_storage;
 	int *fixup_map_spin_lock = test->fixup_map_spin_lock;
+	int *fixup_map_array_ro = test->fixup_map_array_ro;
+	int *fixup_map_array_wo = test->fixup_map_array_wo;
+	int *fixup_map_array_small = test->fixup_map_array_small;
 
 	if (test->fill_helper) {
 		test->fill_insns = calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
@@ -652,6 +666,35 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
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
index 0dcecaf..bcb8319 100644
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
+	.errstr = "read from map forbidden",
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
+	.errstr = "read from map forbidden",
+},
diff --git a/tools/testing/selftests/bpf/verifier/direct_value_access.c b/tools/testing/selftests/bpf/verifier/direct_value_access.c
new file mode 100644
index 0000000..b9fb28e
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/direct_value_access.c
@@ -0,0 +1,347 @@
+{
+	"direct map access, write test 1",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 8),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 8),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 40),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 32),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 40),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, -1),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 48),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 47),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 48),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, (1<<29)),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, (1<<29)-1),
+	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 4),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "invalid access to map value pointer, value_size=48 off=536870911",
+},
+{
+	"direct map access, write test 14",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 47),
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 46),
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
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 46),
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 46),
+	BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
+	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1, 3 },
+	.result = ACCEPT,
+	.retval = 0xffff,
+},
+{
+	"direct map access, write test 16",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 46),
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 47),
+	BPF_ST_MEM(BPF_H, BPF_REG_2, 0, 0xffff),
+	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1, 3 },
+	.result = REJECT,
+	.errstr = "invalid access to map value, value_size=48 off=47 size=2",
+},
+{
+	"direct map access, write test 17",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 46),
+	BPF_LD_MAP_VALUE(BPF_REG_2, 0, 46),
+	BPF_ST_MEM(BPF_H, BPF_REG_2, 1, 0xffff),
+	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1, 3 },
+	.result = REJECT,
+	.errstr = "invalid access to map value, value_size=48 off=47 size=2",
+},
+{
+	"direct map access, write test 18",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
+	BPF_ST_MEM(BPF_H, BPF_REG_1, 0, 42),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_small = { 1 },
+	.result = REJECT,
+	.errstr = "R1 min value is outside of the array range",
+},
+{
+	"direct map access, write test 19",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
+	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_small = { 1 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"direct map access, write test 20",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1),
+	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 42),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_small = { 1 },
+	.result = REJECT,
+	.errstr = "invalid access to map value pointer",
+},
+{
+	"direct map access, invalid insn test 1",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, 0, 1, 0, 47),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "invalid bpf_ld_imm64 insn",
+},
+{
+	"direct map access, invalid insn test 2",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, 1, 0, 0, 47),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "BPF_LD_IMM64 uses reserved fields",
+},
+{
+	"direct map access, invalid insn test 3",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, ~0, 0, 0, 47),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "BPF_LD_IMM64 uses reserved fields",
+},
+{
+	"direct map access, invalid insn test 4",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, 0, ~0, 0, 47),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "invalid bpf_ld_imm64 insn",
+},
+{
+	"direct map access, invalid insn test 5",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, ~0, ~0, 0, 47),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "invalid bpf_ld_imm64 insn",
+},
+{
+	"direct map access, invalid insn test 6",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_FD, ~0, 0, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "BPF_LD_IMM64 uses reserved fields",
+},
+{
+	"direct map access, invalid insn test 7",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_FD, 0, ~0, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "invalid bpf_ld_imm64 insn",
+},
+{
+	"direct map access, invalid insn test 8",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_FD, ~0, ~0, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "invalid bpf_ld_imm64 insn",
+},
+{
+	"direct map access, invalid insn test 9",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_FD, 0, 0, 0, 47),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_array_48b = { 1 },
+	.result = REJECT,
+	.errstr = "unrecognized bpf_ld_imm64 insn",
+},
-- 
2.9.5

