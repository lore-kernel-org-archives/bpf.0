Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C34C67F3
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358778; cv=none; b=uj+E7k2V9xeOq1ElcG+47ku5XuUjWzY6s8wMJ0IxV69V5+LBd57YtZAWtXZ5K3dVvqqw2pasGFzmYdd2YJwUH28p89Egwmppr3lWjYKyBXDWxYde4grTvFJmWgKR4HjaBvycR6CNW/GWcuDIrlOkdSaTVn5tlEM3tXE6ilVnk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358778; c=relaxed/simple;
	bh=wAwLmQuiDzh4bT4B9NhQNQdHnfBl6X6eq1Ga/7/yPms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpyLsliSLOcCQe1bUgsv6mYsutlYu7gieXLxHVJvgBA4dnxIfm90qwq6YSDjsS+YZ+ckT+KOiggyAFHwE0xfZw6YdCzTEfB4xx/7iNqSkNEOU0fi/yLzXC6xyAvcQ5X1OqmBN8ClLrJMn2lzOU0nXwP3Vl68gXmFNXChYsf3VHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NR4GmGAQ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NR4GmGAQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8rNIBsIncixX00QD+a6N6GgBMhgzm8zh17nZR7OmtRA=; b=NR4GmGAQ+bwRkYm3udTN69AbCj
	Jsr9gsES6bOcJm8Iod/gxSD004GaonlYjFWmK8hmVQDitmWQGuqXgLgAk0C45gOsEwUyYZCaokWJf
	dZSUrz5nUKi/VaoVHELznCPlEolhp+Ij4VUGMHMcNwmE9yITe/kzKK1PLR6DWAiTL+uHsS5lV1GNg
	7t4ZY8nyZ+lxcwE+R6/BHbwHetah5vX1s1VPUDsnc5JbPEvedfgbGvqXazZKxjoRAGoxGqkTyiGv6
	jvD46dHMIb0ciIqCTm4pxCuYw0jF04hnJsq/Ph3ZYLMaO4Z5oAhlqGFcusUiM4vgz+rcfNzVHJOVh
	yZfjiWQg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6P-000JlB-1m;
	Fri, 25 Sep 2026 19:52:53 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 13/16] selftests/bpf: Add tests for indirect jumps across subprograms
Date: Fri, 25 Sep 2026 19:52:40 +0200
Message-ID: <20260925175244.1136329-14-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

Add various gotox corner case tests for indirect jumps across subprograms,
and one where two subprograms only called from dead code sit in front of
the one owning a jump table, so that their removal compacts subprog_info[]
along with the tables.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t bpf_insn_array,verifier_gotox
  [...]
  #27/10   bpf_insn_array/gotox-jt-spans-subprogs:OK
  #27/11   bpf_insn_array/gotox-jt-spans-with-own-table:OK
  #27/12   bpf_insn_array/gotox-target-other-subprog:OK
  #27/13   bpf_insn_array/gotox-jt-per-subprog:OK
  #27/14   bpf_insn_array/gotox-jt-dead-subprogs:OK
  #27/15   bpf_insn_array/gotox-target-subprog-from-main:OK
  #27/16   bpf_insn_array/gotox-index-slice-other-subprog:OK
  #27/17   bpf_insn_array/gotox-target-other-global-subprog:OK
  #27/18   bpf_insn_array/gotox-callback-leaves-subprog:OK
  #27      bpf_insn_array:OK
  [...]
  #644     verifier_gotox:OK
  Summary: 2/50 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 541 ++++++++++++++++++
 1 file changed, 541 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 0222a9a5d076..40e183269fb6 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <test_progs.h>
 
 #if defined(__x86_64__) || defined(__powerpc__) || defined(__aarch64__)
@@ -453,6 +454,519 @@ static void check_bpf_no_lookup(void)
 	close(map_fd);
 }
 
+#define GOTOX_LOG_SZ		(256 * 1024)
+
+/* Load and return the fd, which the caller owns. */
+static int gotox_prog_load_funcs_fd(struct bpf_insn *insns, __u32 insn_cnt,
+				    int *fd_array, __u32 fd_array_cnt, char *log,
+				    int btf_fd, struct bpf_func_info *fi, __u32 fi_cnt)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+
+	log[0] = 0;
+	opts.fd_array = fd_array;
+	opts.fd_array_cnt = fd_array_cnt;
+	opts.log_buf = log;
+	opts.log_size = GOTOX_LOG_SZ;
+	opts.log_level = 1;
+	if (fi_cnt) {
+		opts.prog_btf_fd = btf_fd;
+		opts.func_info = fi;
+		opts.func_info_cnt = fi_cnt;
+		opts.func_info_rec_size = sizeof(*fi);
+	}
+
+	return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, &opts);
+}
+
+/* Load for the outcome only: 0 or the negative errno. */
+static int gotox_prog_load_funcs(struct bpf_insn *insns, __u32 insn_cnt,
+				 int *fd_array, __u32 fd_array_cnt, char *log,
+				 int btf_fd, struct bpf_func_info *fi, __u32 fi_cnt)
+{
+	int prog_fd;
+
+	prog_fd = gotox_prog_load_funcs_fd(insns, insn_cnt, fd_array, fd_array_cnt, log,
+					   btf_fd, fi, fi_cnt);
+	if (prog_fd < 0)
+		return prog_fd;
+	close(prog_fd);
+	return 0;
+}
+
+static int gotox_prog_load(struct bpf_insn *insns, __u32 insn_cnt,
+			   int *fd_array, __u32 fd_array_cnt, char *log)
+{
+	return gotox_prog_load_funcs(insns, insn_cnt, fd_array, fd_array_cnt, log,
+				     -1, NULL, 0);
+}
+
+static int gotox_jt_create_offs(const __u32 *offs, __u32 cnt)
+{
+	struct bpf_insn_array_value val = {};
+	int map_fd;
+	__u32 i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, cnt);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return map_fd;
+
+	for (i = 0; i < cnt; i++) {
+		val.orig_off = offs[i];
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
+			       "bpf_map_update_elem"))
+			goto err;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto err;
+
+	return map_fd;
+err:
+	close(map_fd);
+	return -1;
+}
+
+#define GOTOX_SUB_START		4
+#define GOTOX_MAIN_TGT		2
+#define GOTOX_SUB_TGT		8
+#define GOTOX_TWO_INSN_CNT	10
+
+static void gotox_two_subprogs_fill(struct bpf_insn *insns, __u32 jt_idx, __u32 jt_off)
+{
+	insns[0] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[1] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0,
+				GOTOX_SUB_START - 1 - 1);
+	insns[GOTOX_MAIN_TGT] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[3] = BPF_EXIT_INSN();
+
+	/* r1 = &jt[0], by index 'jt_idx' into fd_array */
+	insns[GOTOX_SUB_START] = (struct bpf_insn) {
+		.code = BPF_LD | BPF_DW | BPF_IMM,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
+		.imm = jt_idx,
+	};
+	insns[GOTOX_SUB_START + 1] = (struct bpf_insn) { .imm = 0 };
+	insns[6] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, jt_off * 8);
+	insns[7] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
+	insns[GOTOX_SUB_TGT] = BPF_MOV64_IMM(BPF_REG_0, 1);
+	insns[9] = BPF_EXIT_INSN();
+}
+
+/*
+ * Load 'insns' with the two jump tables 'jt_a' and 'jt_b', in this order in
+ * fd_array, and check the outcome. 'fi' describes the subprograms when given.
+ */
+static void check_gotox_two_maps(struct bpf_insn *insns, __u32 insn_cnt,
+				 const __u32 *jt_a, __u32 a_cnt,
+				 const __u32 *jt_b, __u32 b_cnt,
+				 int btf_fd, struct bpf_func_info *fi, __u32 fi_cnt,
+				 int expect_err, const char *expect_msg)
+{
+	int map_fd[2] = { -1, -1 };
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	map_fd[0] = gotox_jt_create_offs(jt_a, a_cnt);
+	if (map_fd[0] < 0)
+		goto free_log;
+	map_fd[1] = gotox_jt_create_offs(jt_b, b_cnt);
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	if (fi)
+		err = gotox_prog_load_funcs(insns, insn_cnt, map_fd, 2, log,
+					    btf_fd, fi, fi_cnt);
+	else
+		err = gotox_prog_load(insns, insn_cnt, map_fd, 2, log);
+	if (expect_err)
+		ASSERT_EQ(err, expect_err, "program should have been rejected");
+	else
+		ASSERT_EQ(err, 0, "bpf(BPF_PROG_LOAD)");
+	if (expect_msg)
+		ASSERT_HAS_SUBSTR(log, expect_msg, "verifier log");
+
+close_maps:
+	close(map_fd[0]);
+	if (map_fd[1] >= 0)
+		close(map_fd[1]);
+free_log:
+	free(log);
+}
+
+static void check_gotox_target_other_subprog(void)
+{
+	const __u32 jt_main[] = { GOTOX_MAIN_TGT };
+	const __u32 jt_sub[] = { GOTOX_SUB_TGT };
+	struct bpf_insn insns[GOTOX_TWO_INSN_CNT];
+
+	gotox_two_subprogs_fill(insns, 0, 0);
+
+	check_gotox_two_maps(insns, ARRAY_SIZE(insns), jt_main, ARRAY_SIZE(jt_main),
+			     jt_sub, ARRAY_SIZE(jt_sub), -1, NULL, 0,
+			     -EINVAL, "indirect jump from insn 7 to 2 leaves the subprog [4,10)");
+}
+
+static void check_gotox_jt_per_subprog(void)
+{
+	const __u32 jt_main[] = { GOTOX_MAIN_TGT };
+	const __u32 jt_sub[] = { GOTOX_SUB_TGT };
+	struct bpf_insn insns[GOTOX_TWO_INSN_CNT];
+
+	gotox_two_subprogs_fill(insns, 1, 0);
+
+	check_gotox_two_maps(insns, ARRAY_SIZE(insns), jt_main, ARRAY_SIZE(jt_main),
+			     jt_sub, ARRAY_SIZE(jt_sub), -1, NULL, 0,
+			     0, NULL);
+}
+
+#define GOTOX_DEAD_MAIN_LEN	7
+#define GOTOX_DEAD_SUB_LEN	6
+#define GOTOX_DEAD_INSN_CNT	(GOTOX_DEAD_MAIN_LEN + 3 * GOTOX_DEAD_SUB_LEN)
+#define GOTOX_DEAD_LIVE_CNT	10
+
+/* r1 = &jt[0], by index 'jt_idx' into fd_array; r1 = *r1; gotox r1; r0 = 0; exit */
+static void gotox_sub_fill(struct bpf_insn *insns, __u32 start, __u32 jt_idx)
+{
+	insns[start] = (struct bpf_insn) {
+		.code = BPF_LD | BPF_DW | BPF_IMM,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
+		.imm = jt_idx,
+	};
+	insns[start + 1] = (struct bpf_insn) { .imm = 0 };
+	insns[start + 2] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+	insns[start + 3] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
+	insns[start + 4] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[start + 5] = BPF_EXIT_INSN();
+}
+
+/*
+ * Two subprograms which are only called from dead code sit in front of the
+ * live one, and all three own a jump table. Dead code removal drops both in
+ * one go, which compacts subprog_info[] along with the tables.
+ */
+static void check_gotox_jt_dead_subprogs(void)
+{
+	const __u32 sub_start[3] = { GOTOX_DEAD_MAIN_LEN,
+				     GOTOX_DEAD_MAIN_LEN + GOTOX_DEAD_SUB_LEN,
+				     GOTOX_DEAD_MAIN_LEN + 2 * GOTOX_DEAD_SUB_LEN };
+	struct bpf_insn insns[GOTOX_DEAD_INSN_CNT];
+	int map_fd[3] = { -1, -1, -1 };
+	struct bpf_prog_info info = {};
+	__u32 len = sizeof(info), tgt, i;
+	int prog_fd;
+	char *log;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	insns[0] = BPF_MOV64_IMM(BPF_REG_1, 0);
+	insns[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2);
+	insns[2] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0,
+				sub_start[0] - 2 - 1);
+	insns[3] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0,
+				sub_start[1] - 3 - 1);
+	insns[4] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0,
+				sub_start[2] - 4 - 1);
+	insns[5] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[6] = BPF_EXIT_INSN();
+
+	for (i = 0; i < ARRAY_SIZE(sub_start); i++) {
+		gotox_sub_fill(insns, sub_start[i], i);
+		tgt = sub_start[i] + 4;
+		map_fd[i] = gotox_jt_create_offs(&tgt, 1);
+		if (map_fd[i] < 0)
+			goto close_maps;
+	}
+
+	prog_fd = gotox_prog_load_funcs_fd(insns, ARRAY_SIZE(insns), map_fd,
+					   ARRAY_SIZE(map_fd), log, -1, NULL, 0);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto close_maps;
+
+	/* Both dead subprograms and the calls to them must be gone. */
+	if (ASSERT_OK(bpf_prog_get_info_by_fd(prog_fd, &info, &len),
+		      "bpf_prog_get_info_by_fd"))
+		ASSERT_EQ(info.xlated_prog_len / sizeof(struct bpf_insn),
+			  GOTOX_DEAD_LIVE_CNT, "xlated insn count");
+	close(prog_fd);
+close_maps:
+	for (i = 0; i < ARRAY_SIZE(map_fd); i++)
+		if (map_fd[i] >= 0)
+			close(map_fd[i]);
+	free(log);
+}
+
+#define GOTOX_FWD_GOTOX		11
+#define GOTOX_FWD_OWN_TGT	12
+#define GOTOX_FWD_SUB_START	14
+#define GOTOX_FWD_INSN_CNT	16
+
+static void gotox_from_main_fill(struct bpf_insn *insns)
+{
+	insns[0] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	insns[1] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0,
+				GOTOX_FWD_SUB_START - 1 - 1);
+	insns[2] = BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_6,
+			       offsetof(struct xdp_md, ingress_ifindex));
+	insns[3] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 4);
+
+	/* r1 = &jt_leaves[0], by index 1 into fd_array */
+	insns[4] = (struct bpf_insn) {
+		.code = BPF_LD | BPF_DW | BPF_IMM,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
+		.imm = 1,
+	};
+	insns[5] = (struct bpf_insn) { .imm = 0 };
+	insns[6] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+	insns[7] = BPF_JMP_A(3);
+
+	/* r1 = &jt_own[0], by index 0 into fd_array */
+	insns[8] = (struct bpf_insn) {
+		.code = BPF_LD | BPF_DW | BPF_IMM,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
+		.imm = 0,
+	};
+	insns[9] = (struct bpf_insn) { .imm = 0 };
+	insns[10] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+
+	insns[GOTOX_FWD_GOTOX] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
+	insns[GOTOX_FWD_OWN_TGT] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[13] = BPF_EXIT_INSN();
+	insns[GOTOX_FWD_SUB_START] = BPF_MOV64_IMM(BPF_REG_0, 1);
+	insns[15] = BPF_EXIT_INSN();
+}
+
+static void check_gotox_target_subprog_from_main(void)
+{
+	const __u32 jt_own[] = { GOTOX_FWD_OWN_TGT };
+	const __u32 jt_leaves[] = { GOTOX_FWD_SUB_START };
+	struct bpf_insn insns[GOTOX_FWD_INSN_CNT];
+
+	gotox_from_main_fill(insns);
+
+	check_gotox_two_maps(insns, ARRAY_SIZE(insns), jt_own, ARRAY_SIZE(jt_own),
+			     jt_leaves, ARRAY_SIZE(jt_leaves), -1, NULL, 0,
+			     -EINVAL, "indirect jump from insn 11 to 14 leaves the subprog [0,14)");
+}
+
+/*
+ * The only map of the subprog holding the gotox reaches past that subprog, so
+ * the subprog is left without a jump table at all.
+ */
+static void check_gotox_jt_spans_subprogs(void)
+{
+	const __u32 jt_span[] = { GOTOX_FWD_OWN_TGT, GOTOX_FWD_SUB_START };
+	const __u32 jt_leaves[] = { GOTOX_FWD_SUB_START };
+	struct bpf_insn insns[GOTOX_FWD_INSN_CNT];
+
+	gotox_from_main_fill(insns);
+
+	check_gotox_two_maps(insns, ARRAY_SIZE(insns), jt_span, ARRAY_SIZE(jt_span),
+			     jt_leaves, ARRAY_SIZE(jt_leaves), -1, NULL, 0,
+			     -EINVAL, "jump table of subprog starting at 0 spans multiple subprogs");
+}
+
+/*
+ * The subprog holding the gotox has a well formed jump table of its own and
+ * also collects a map that reaches past its end. The spanning map is still
+ * rejected, even though the subprog is not left without a table.
+ */
+static void check_gotox_jt_spans_with_own_table(void)
+{
+	const __u32 jt_own[] = { GOTOX_FWD_OWN_TGT };
+	const __u32 jt_span[] = { GOTOX_FWD_OWN_TGT, GOTOX_FWD_SUB_START };
+	struct bpf_insn insns[GOTOX_FWD_INSN_CNT];
+
+	gotox_from_main_fill(insns);
+
+	check_gotox_two_maps(insns, ARRAY_SIZE(insns), jt_own, ARRAY_SIZE(jt_own),
+			     jt_span, ARRAY_SIZE(jt_span), -1, NULL, 0,
+			     -EINVAL, "jump table of subprog starting at 0 spans multiple subprogs");
+}
+
+#define GOTOX_SLICE_SUB_START	6
+#define GOTOX_SLICE_GOTOX	14
+#define GOTOX_SLICE_SUB_TGT	15
+#define GOTOX_SLICE_INSN_CNT	17
+
+static void gotox_slice_fill(struct bpf_insn *insns)
+{
+	insns[0] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[1] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0,
+				GOTOX_SLICE_SUB_START - 1 - 1);
+	insns[2] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[3] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[4] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[5] = BPF_EXIT_INSN();
+
+	insns[GOTOX_SLICE_SUB_START] =
+		BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+			    offsetof(struct xdp_md, ingress_ifindex));
+	insns[7] = BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 1);
+	insns[8] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1);
+	insns[9] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
+
+	/* r1 = &jt_main[0], by index 0 into fd_array */
+	insns[10] = (struct bpf_insn) {
+		.code = BPF_LD | BPF_DW | BPF_IMM,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
+		.imm = 0,
+	};
+	insns[11] = (struct bpf_insn) { .imm = 0 };
+	insns[12] = BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2);
+	insns[13] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+
+	insns[GOTOX_SLICE_GOTOX] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
+	insns[GOTOX_SLICE_SUB_TGT] = BPF_MOV64_IMM(BPF_REG_0, 1);
+	insns[16] = BPF_EXIT_INSN();
+}
+
+static void check_gotox_index_slice_other_subprog(void)
+{
+	const __u32 jt_main[] = { 2, 3, 4 };
+	const __u32 jt_sub[] = { GOTOX_SLICE_SUB_TGT };
+	struct bpf_insn insns[GOTOX_SLICE_INSN_CNT];
+
+	gotox_slice_fill(insns);
+
+	check_gotox_two_maps(insns, ARRAY_SIZE(insns), jt_main, ARRAY_SIZE(jt_main),
+			     jt_sub, ARRAY_SIZE(jt_sub), -1, NULL, 0,
+			     -EINVAL, "indirect jump from insn 14 to 3 leaves the subprog [6,17)");
+}
+
+static int gotox_btf_create(const __u32 *starts, const __u8 *linkage, __u32 cnt,
+			    struct bpf_func_info *fi, struct btf **pbtf)
+{
+	int int_id, proto_id, id;
+	struct btf *btf;
+	char name[24];
+	__u32 i;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf__new_empty"))
+		return -1;
+
+	int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	if (!ASSERT_GT(int_id, 0, "btf__add_int"))
+		goto err;
+
+	proto_id = btf__add_func_proto(btf, int_id);
+	if (!ASSERT_GT(proto_id, 0, "btf__add_func_proto"))
+		goto err;
+
+	for (i = 0; i < cnt; i++) {
+		snprintf(name, sizeof(name), "gotox_f%u", i);
+		id = btf__add_func(btf, name, linkage[i], proto_id);
+		if (!ASSERT_GT(id, 0, "btf__add_func"))
+			goto err;
+		fi[i].insn_off = starts[i];
+		fi[i].type_id = id;
+	}
+
+	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf__load_into_kernel"))
+		goto err;
+
+	*pbtf = btf;
+	return btf__fd(btf);
+err:
+	btf__free(btf);
+	return -1;
+}
+
+static void check_gotox_target_other_global_subprog(void)
+{
+	const __u32 starts[] = { 0, GOTOX_SUB_START };
+	const __u8 linkage[] = { BTF_FUNC_GLOBAL, BTF_FUNC_GLOBAL };
+	const __u32 jt_main[] = { GOTOX_MAIN_TGT };
+	const __u32 jt_sub[] = { GOTOX_SUB_TGT };
+	struct bpf_insn insns[GOTOX_TWO_INSN_CNT];
+	struct bpf_func_info fi[2];
+	struct btf *btf = NULL;
+	int btf_fd;
+
+	gotox_two_subprogs_fill(insns, 0, 0);
+
+	btf_fd = gotox_btf_create(starts, linkage, ARRAY_SIZE(starts), fi, &btf);
+	if (btf_fd < 0)
+		return;
+
+	check_gotox_two_maps(insns, ARRAY_SIZE(insns), jt_main, ARRAY_SIZE(jt_main),
+			     jt_sub, ARRAY_SIZE(jt_sub), btf_fd, fi, ARRAY_SIZE(fi),
+			     -EINVAL, "indirect jump from insn 7 to 2 leaves the subprog [4,10)");
+	btf__free(btf);
+}
+
+#define GOTOX_CB_MAIN_TGT	6
+#define GOTOX_CB_START		8
+#define GOTOX_CB_GOTOX		11
+#define GOTOX_CB_TGT		12
+#define GOTOX_CB_INSN_CNT	14
+
+static void gotox_callback_fill(struct bpf_insn *insns)
+{
+	insns[0] = BPF_MOV64_IMM(BPF_REG_1, 1);
+	/* r2 = &callback */
+	insns[1] = (struct bpf_insn) {
+		.code = BPF_LD | BPF_DW | BPF_IMM,
+		.dst_reg = BPF_REG_2,
+		.src_reg = BPF_PSEUDO_FUNC,
+		.imm = GOTOX_CB_START - 1 - 1,
+	};
+	insns[2] = (struct bpf_insn) { .imm = 0 };
+	insns[3] = BPF_MOV64_IMM(BPF_REG_3, 0);
+	insns[4] = BPF_MOV64_IMM(BPF_REG_4, 0);
+	insns[5] = BPF_EMIT_CALL(BPF_FUNC_loop);
+	insns[GOTOX_CB_MAIN_TGT] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[7] = BPF_EXIT_INSN();
+
+	/* r1 = &jt_main[0], by index 0 into fd_array */
+	insns[GOTOX_CB_START] = (struct bpf_insn) {
+		.code = BPF_LD | BPF_DW | BPF_IMM,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
+		.imm = 0,
+	};
+	insns[9] = (struct bpf_insn) { .imm = 0 };
+	insns[10] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+	insns[GOTOX_CB_GOTOX] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
+	insns[GOTOX_CB_TGT] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[13] = BPF_EXIT_INSN();
+}
+
+static void check_gotox_callback_leaves_subprog(void)
+{
+	const __u32 starts[] = { 0, GOTOX_CB_START };
+	const __u8 linkage[] = { BTF_FUNC_GLOBAL, BTF_FUNC_STATIC };
+	const __u32 jt_main[] = { GOTOX_CB_MAIN_TGT };
+	const __u32 jt_cb[] = { GOTOX_CB_TGT };
+	struct bpf_insn insns[GOTOX_CB_INSN_CNT];
+	struct bpf_func_info fi[2];
+	struct btf *btf = NULL;
+	int btf_fd;
+
+	gotox_callback_fill(insns);
+
+	btf_fd = gotox_btf_create(starts, linkage, ARRAY_SIZE(starts), fi, &btf);
+	if (btf_fd < 0)
+		return;
+
+	check_gotox_two_maps(insns, ARRAY_SIZE(insns), jt_main, ARRAY_SIZE(jt_main),
+			     jt_cb, ARRAY_SIZE(jt_cb), btf_fd, fi, ARRAY_SIZE(fi),
+			     -EINVAL, "indirect jump from insn 11 to 6 leaves the subprog [8,14)");
+	btf__free(btf);
+}
+
 static void check_bpf_side(void)
 {
 	check_bpf_no_lookup();
@@ -490,6 +1004,33 @@ static void __test_bpf_insn_array(void)
 
 	if (test__start_subtest("bpf-side-ops"))
 		check_bpf_side();
+
+	if (test__start_subtest("gotox-jt-spans-subprogs"))
+		check_gotox_jt_spans_subprogs();
+
+	if (test__start_subtest("gotox-jt-spans-with-own-table"))
+		check_gotox_jt_spans_with_own_table();
+
+	if (test__start_subtest("gotox-target-other-subprog"))
+		check_gotox_target_other_subprog();
+
+	if (test__start_subtest("gotox-jt-per-subprog"))
+		check_gotox_jt_per_subprog();
+
+	if (test__start_subtest("gotox-jt-dead-subprogs"))
+		check_gotox_jt_dead_subprogs();
+
+	if (test__start_subtest("gotox-target-subprog-from-main"))
+		check_gotox_target_subprog_from_main();
+
+	if (test__start_subtest("gotox-index-slice-other-subprog"))
+		check_gotox_index_slice_other_subprog();
+
+	if (test__start_subtest("gotox-target-other-global-subprog"))
+		check_gotox_target_other_global_subprog();
+
+	if (test__start_subtest("gotox-callback-leaves-subprog"))
+		check_gotox_callback_leaves_subprog();
 }
 #else
 static void __test_bpf_insn_array(void)
-- 
2.43.0

