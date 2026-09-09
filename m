Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC23DE45B
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986460; cv=none; b=ZaL4rq+wSaPJOdeJD00Db/MJRbiD5Jx3CtaYWNW+vG7x0oywb/GPjcKs9cdiTW6fLSWJBTMamLAkm+Kx1kuD4/kxq47rfxAnEwnrzTXjdxG1tIU19eRcz8tzM8qoRLrkQ+73OfH0UO5VRX+NUk1YnWc5l5simhINCxKpCu+CG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986460; c=relaxed/simple;
	bh=wn1yPGxkCWwAx7pn7MlBIzUMAmWrUYt8M3D9jS9mu00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dr/fM8ORvw1NdnIjWTuLwCEctyDQDMVTVieTA2/G4Bz1kEwgRwra3U0Uwu+KsoxeVdoWsUN0hK3+e3LtcOKG5c0+pO1KXu+enwRkdA29bd+pMR4E1rLcyYP1uHX9uFUiF4nvfuNFK1dOziq+MlxcedXXtN6jdaM6BKF5QMgHKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ZU2UxDcn; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZU2UxDcn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=htCQWLqCdoLeBnSyKUlNY/U5DD1c3nCtL6wVpBJe99U=; b=ZU2UxDcnLNyYQZ/K9jMixTjsgN
	bqSWtcppY8ZNMxo2suJQ2KzXxNS0kojboKOrdlmQSE0cEMX19NDZ/EiXTuD10SqeUeAFEh+3wuGlk
	sWjgDPLIPS1DQmTPfomAmBCZuq8UZSPAdfyZfwvadY9HoKWVQ7+qGTwuyz2owQALAs1jNykQU6vTt
	QvAbI0KlrE1G7kz5PYbFUV8kIZZ/vhU+IGsY09iZa8Hc9qjh9q0VdN/aEZr1dSBzeSX7ARnFEiykb
	59m6x8LV6T4m8BzXDOjQlVrq0VSsSiwEIkGUd0gibXM6b6ctgoR+dNDCjj2RmnPuNYKKK9hZ4b6Dy
	Q4YURylA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4P60-000F7r-25;
	Wed, 09 Sep 2026 22:40:40 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf 6/6] selftests/bpf: Add tests for indirect jumps across subprograms
Date: Wed,  9 Sep 2026 22:40:35 +0200
Message-ID: <20260909204035.24289-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909204035.24289-1-daniel@iogearbox.net>
References: <20260909204035.24289-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28118/Wed Sep  9 08:24:03 2026)

Add various gotox corner case tests to improve corner case coverage.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- \
      ./test_progs -t bpf_insn_array,verifier_gotox,signed_loader
  [...]
  #24/13   bpf_insn_array/gotox-tracker-map:OK
  #24/14   bpf_insn_array/gotox-jt-spans-subprogs:OK
  #24/15   bpf_insn_array/gotox-jt-spans-with-own-table:OK
  #24/16   bpf_insn_array/gotox-target-without-cfg-edge:OK
  #24/17   bpf_insn_array/gotox-target-other-subprog:OK
  #24/18   bpf_insn_array/gotox-jt-per-subprog:OK
  #24/19   bpf_insn_array/gotox-span-unreached-entry:OK
  #24/20   bpf_insn_array/gotox-target-subprog-from-main:OK
  #24/21   bpf_insn_array/gotox-index-slice-other-subprog:OK
  #24/22   bpf_insn_array/gotox-target-other-global-subprog:OK
  #24/23   bpf_insn_array/gotox-callback-leaves-subprog:OK
  #24      bpf_insn_array:OK
  [...]
  #616     verifier_gotox:OK
  Summary: 3/79 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 715 +++++++++++++++++-
 1 file changed, 713 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index c69d44cd4607..d5a831a75d82 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <test_progs.h>
 
 #if defined(__x86_64__) || defined(__powerpc__) || defined(__aarch64__)
@@ -487,8 +488,9 @@ static int gotox_jt_create(__u32 first_gotox, __u32 gotox_cnt)
 	return -1;
 }
 
-static int gotox_prog_load(struct bpf_insn *insns, __u32 insn_cnt,
-			   int *fd_array, __u32 fd_array_cnt, char *log)
+static int gotox_prog_load_funcs(struct bpf_insn *insns, __u32 insn_cnt,
+				 int *fd_array, __u32 fd_array_cnt, char *log,
+				 int btf_fd, struct bpf_func_info *fi, __u32 fi_cnt)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	int prog_fd;
@@ -499,6 +501,12 @@ static int gotox_prog_load(struct bpf_insn *insns, __u32 insn_cnt,
 	opts.log_buf = log;
 	opts.log_size = GOTOX_LOG_SZ;
 	opts.log_level = 1;
+	if (fi_cnt) {
+		opts.prog_btf_fd = btf_fd;
+		opts.func_info = fi;
+		opts.func_info_cnt = fi_cnt;
+		opts.func_info_rec_size = sizeof(*fi);
+	}
 
 	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, &opts);
 	if (prog_fd >= 0) {
@@ -508,6 +516,13 @@ static int gotox_prog_load(struct bpf_insn *insns, __u32 insn_cnt,
 	return prog_fd;
 }
 
+static int gotox_prog_load(struct bpf_insn *insns, __u32 insn_cnt,
+			   int *fd_array, __u32 fd_array_cnt, char *log)
+{
+	return gotox_prog_load_funcs(insns, insn_cnt, fd_array, fd_array_cnt, log,
+				     -1, NULL, 0);
+}
+
 /* Fill in 'r1 = 0; gotox_cnt x gotox r1' at 'insns'. */
 static void gotox_run_fill(struct bpf_insn *insns, __u32 gotox_cnt)
 {
@@ -710,6 +725,669 @@ static void check_gotox_edges_across_subprogs(void)
 	free(log);
 }
 
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
+ * An insn_array map is not necessarily a jump table: one that tracks
+ * instruction offsets covers the whole program and is of no subprog. Such a
+ * map must not keep a program with a gotox elsewhere from loading.
+ */
+static void check_gotox_tracker_map(void)
+{
+	const __u32 jt_track[] = { 0, GOTOX_MAIN_TGT, GOTOX_SUB_TGT };
+	const __u32 jt_sub[] = { GOTOX_SUB_TGT };
+	struct bpf_insn insns[GOTOX_TWO_INSN_CNT];
+	int map_fd[2] = { -1, -1 };
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_two_subprogs_fill(insns, 1, 0);
+
+	map_fd[0] = gotox_jt_create_offs(jt_track, ARRAY_SIZE(jt_track));
+	if (map_fd[0] < 0)
+		goto free_log;
+	map_fd[1] = gotox_jt_create_offs(jt_sub, ARRAY_SIZE(jt_sub));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load(insns, ARRAY_SIZE(insns), map_fd, 2, log);
+	if (!ASSERT_OK(err, "program with a tracking map should load"))
+		fprintf(stderr, "verifier log: %s\n", log);
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_log:
+	free(log);
+}
+
+static void check_gotox_target_other_subprog(void)
+{
+	const __u32 jt_main[] = { GOTOX_MAIN_TGT };
+	const __u32 jt_sub[] = { GOTOX_SUB_TGT };
+	struct bpf_insn insns[GOTOX_TWO_INSN_CNT];
+	int map_fd[2] = { -1, -1 };
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_two_subprogs_fill(insns, 0, 0);
+
+	map_fd[0] = gotox_jt_create_offs(jt_main, ARRAY_SIZE(jt_main));
+	if (map_fd[0] < 0)
+		goto free_log;
+	map_fd[1] = gotox_jt_create_offs(jt_sub, ARRAY_SIZE(jt_sub));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load(insns, ARRAY_SIZE(insns), map_fd, 2, log);
+	ASSERT_EQ(err, -EINVAL, "program should have been rejected");
+	ASSERT_HAS_SUBSTR(log, "indirect jump from insn 7 to 2 leaves the subprog [4,10)",
+			  "verifier log");
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_log:
+	free(log);
+}
+
+static void check_gotox_jt_per_subprog(void)
+{
+	const __u32 jt_main[] = { GOTOX_MAIN_TGT };
+	const __u32 jt_sub[] = { GOTOX_SUB_TGT };
+	struct bpf_insn insns[GOTOX_TWO_INSN_CNT];
+	int map_fd[2] = { -1, -1 };
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_two_subprogs_fill(insns, 1, 0);
+
+	map_fd[0] = gotox_jt_create_offs(jt_main, ARRAY_SIZE(jt_main));
+	if (map_fd[0] < 0)
+		goto free_log;
+	map_fd[1] = gotox_jt_create_offs(jt_sub, ARRAY_SIZE(jt_sub));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load(insns, ARRAY_SIZE(insns), map_fd, 2, log);
+	ASSERT_EQ(err, 0, "bpf(BPF_PROG_LOAD)");
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_log:
+	free(log);
+}
+
+/*
+ * The spanning map is of no subprog and is dropped, and the entry the gotox
+ * register can reach is in the subprog of the gotox and in the jump table the
+ * CFG walked, so nothing unsafe is left and the program loads.
+ */
+static void check_gotox_span_unreached_entry(void)
+{
+	const __u32 jt_span[] = { GOTOX_MAIN_TGT, GOTOX_SUB_TGT };
+	const __u32 jt_sub[] = { GOTOX_SUB_TGT };
+	struct bpf_insn insns[GOTOX_TWO_INSN_CNT];
+	int map_fd[2] = { -1, -1 };
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_two_subprogs_fill(insns, 0, 1);
+
+	map_fd[0] = gotox_jt_create_offs(jt_span, ARRAY_SIZE(jt_span));
+	if (map_fd[0] < 0)
+		goto free_log;
+	map_fd[1] = gotox_jt_create_offs(jt_sub, ARRAY_SIZE(jt_sub));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load(insns, ARRAY_SIZE(insns), map_fd, 2, log);
+	if (!ASSERT_OK(err, "program with an unreachable spanning entry should load"))
+		fprintf(stderr, "verifier log: %s\n", log);
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_log:
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
+	int map_fd[2] = { -1, -1 };
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_from_main_fill(insns);
+
+	map_fd[0] = gotox_jt_create_offs(jt_own, ARRAY_SIZE(jt_own));
+	if (map_fd[0] < 0)
+		goto free_log;
+	map_fd[1] = gotox_jt_create_offs(jt_leaves, ARRAY_SIZE(jt_leaves));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load(insns, ARRAY_SIZE(insns), map_fd, 2, log);
+	ASSERT_EQ(err, -EINVAL, "program should have been rejected");
+	ASSERT_HAS_SUBSTR(log, "indirect jump from insn 11 to 14 leaves the subprog [0,14)",
+			  "verifier log");
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_log:
+	free(log);
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
+	int map_fd[2] = { -1, -1 };
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_from_main_fill(insns);
+
+	map_fd[0] = gotox_jt_create_offs(jt_span, ARRAY_SIZE(jt_span));
+	if (map_fd[0] < 0)
+		goto free_log;
+	map_fd[1] = gotox_jt_create_offs(jt_leaves, ARRAY_SIZE(jt_leaves));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load(insns, ARRAY_SIZE(insns), map_fd, 2, log);
+	ASSERT_EQ(err, -EINVAL, "program should have been rejected");
+	ASSERT_HAS_SUBSTR(log, "jump table of subprog starting at 0 spans multiple subprogs",
+			  "verifier log");
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_log:
+	free(log);
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
+	int map_fd[2] = { -1, -1 };
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_from_main_fill(insns);
+
+	map_fd[0] = gotox_jt_create_offs(jt_own, ARRAY_SIZE(jt_own));
+	if (map_fd[0] < 0)
+		goto free_log;
+	map_fd[1] = gotox_jt_create_offs(jt_span, ARRAY_SIZE(jt_span));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load(insns, ARRAY_SIZE(insns), map_fd, 2, log);
+	ASSERT_EQ(err, -EINVAL, "program should have been rejected");
+	ASSERT_HAS_SUBSTR(log, "jump table of subprog starting at 0 spans multiple subprogs",
+			  "verifier log");
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_log:
+	free(log);
+}
+
+#define GOTOX_EDGE_MAIN_TGT	2
+#define GOTOX_EDGE_SUB_START	4
+#define GOTOX_EDGE_GOTOX	9
+#define GOTOX_EDGE_BR_TGT	10
+#define GOTOX_EDGE_JT_TGT	11
+#define GOTOX_EDGE_INSN_CNT	12
+
+static void gotox_no_edge_fill(struct bpf_insn *insns)
+{
+	insns[0] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[1] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0,
+				GOTOX_EDGE_SUB_START - 1 - 1);
+	insns[GOTOX_EDGE_MAIN_TGT] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[3] = BPF_EXIT_INSN();
+
+	insns[GOTOX_EDGE_SUB_START] =
+		BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+			    offsetof(struct xdp_md, ingress_ifindex));
+	insns[5] = BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0, 4);
+
+	/* r1 = &jt_span[0], by index 0 into fd_array */
+	insns[6] = (struct bpf_insn) {
+		.code = BPF_LD | BPF_DW | BPF_IMM,
+		.dst_reg = BPF_REG_1,
+		.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
+		.imm = 0,
+	};
+	insns[7] = (struct bpf_insn) { .imm = 0 };
+	insns[8] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 8);
+
+	insns[GOTOX_EDGE_GOTOX] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
+	insns[GOTOX_EDGE_BR_TGT] = BPF_MOV64_IMM(BPF_REG_0, 1);
+	insns[GOTOX_EDGE_JT_TGT] = BPF_EXIT_INSN();
+}
+
+/*
+ * The gotox resolves a target inside its own subprog, but out of a map that
+ * spans subprogs and is therefore of no subprog. The CFG never walked that
+ * edge, so the jump has to be rejected even though it stays in the subprog.
+ */
+static void check_gotox_target_without_cfg_edge(void)
+{
+	const __u32 jt_span[] = { GOTOX_EDGE_MAIN_TGT, GOTOX_EDGE_BR_TGT };
+	const __u32 jt_sub[] = { GOTOX_EDGE_JT_TGT };
+	struct bpf_insn insns[GOTOX_EDGE_INSN_CNT];
+	int map_fd[2] = { -1, -1 };
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_no_edge_fill(insns);
+
+	map_fd[0] = gotox_jt_create_offs(jt_span, ARRAY_SIZE(jt_span));
+	if (map_fd[0] < 0)
+		goto free_log;
+	map_fd[1] = gotox_jt_create_offs(jt_sub, ARRAY_SIZE(jt_sub));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load(insns, ARRAY_SIZE(insns), map_fd, 2, log);
+	ASSERT_EQ(err, -EINVAL, "program should have been rejected");
+	ASSERT_HAS_SUBSTR(log,
+			  "indirect jump from insn 9 to 10 is not in the jump table of the subprog",
+			  "verifier log");
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_log:
+	free(log);
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
+	int map_fd[2] = { -1, -1 };
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_slice_fill(insns);
+
+	map_fd[0] = gotox_jt_create_offs(jt_main, ARRAY_SIZE(jt_main));
+	if (map_fd[0] < 0)
+		goto free_log;
+	map_fd[1] = gotox_jt_create_offs(jt_sub, ARRAY_SIZE(jt_sub));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load(insns, ARRAY_SIZE(insns), map_fd, 2, log);
+	ASSERT_EQ(err, -EINVAL, "program should have been rejected");
+	ASSERT_HAS_SUBSTR(log, "indirect jump from insn 14 to 3 leaves the subprog [6,17)",
+			  "verifier log");
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_log:
+	free(log);
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
+	int map_fd[2] = { -1, -1 };
+	struct bpf_func_info fi[2];
+	struct btf *btf = NULL;
+	int btf_fd;
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_two_subprogs_fill(insns, 0, 0);
+
+	btf_fd = gotox_btf_create(starts, linkage, ARRAY_SIZE(starts), fi, &btf);
+	if (btf_fd < 0)
+		goto free_log;
+
+	map_fd[0] = gotox_jt_create_offs(jt_main, ARRAY_SIZE(jt_main));
+	if (map_fd[0] < 0)
+		goto free_btf;
+	map_fd[1] = gotox_jt_create_offs(jt_sub, ARRAY_SIZE(jt_sub));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load_funcs(insns, ARRAY_SIZE(insns), map_fd, 2, log,
+				    btf_fd, fi, ARRAY_SIZE(fi));
+	ASSERT_EQ(err, -EINVAL, "program should have been rejected");
+	ASSERT_HAS_SUBSTR(log, "indirect jump from insn 7 to 2 leaves the subprog [4,10)",
+			  "verifier log");
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_btf:
+	btf__free(btf);
+free_log:
+	free(log);
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
+	int map_fd[2] = { -1, -1 };
+	struct bpf_func_info fi[2];
+	struct btf *btf = NULL;
+	int btf_fd;
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	gotox_callback_fill(insns);
+
+	btf_fd = gotox_btf_create(starts, linkage, ARRAY_SIZE(starts), fi, &btf);
+	if (btf_fd < 0)
+		goto free_log;
+
+	map_fd[0] = gotox_jt_create_offs(jt_main, ARRAY_SIZE(jt_main));
+	if (map_fd[0] < 0)
+		goto free_btf;
+	map_fd[1] = gotox_jt_create_offs(jt_cb, ARRAY_SIZE(jt_cb));
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load_funcs(insns, ARRAY_SIZE(insns), map_fd, 2, log,
+				    btf_fd, fi, ARRAY_SIZE(fi));
+	ASSERT_EQ(err, -EINVAL, "program should have been rejected");
+	ASSERT_HAS_SUBSTR(log, "indirect jump from insn 11 to 6 leaves the subprog [8,14)",
+			  "verifier log");
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_btf:
+	btf__free(btf);
+free_log:
+	free(log);
+}
+
 static void check_bpf_side(void)
 {
 	check_bpf_no_lookup();
@@ -756,6 +1434,39 @@ static void __test_bpf_insn_array(void)
 
 	if (test__start_subtest("gotox-edges-across-subprogs"))
 		check_gotox_edges_across_subprogs();
+
+	if (test__start_subtest("gotox-tracker-map"))
+		check_gotox_tracker_map();
+
+	if (test__start_subtest("gotox-jt-spans-subprogs"))
+		check_gotox_jt_spans_subprogs();
+
+	if (test__start_subtest("gotox-jt-spans-with-own-table"))
+		check_gotox_jt_spans_with_own_table();
+
+	if (test__start_subtest("gotox-target-without-cfg-edge"))
+		check_gotox_target_without_cfg_edge();
+
+	if (test__start_subtest("gotox-target-other-subprog"))
+		check_gotox_target_other_subprog();
+
+	if (test__start_subtest("gotox-jt-per-subprog"))
+		check_gotox_jt_per_subprog();
+
+	if (test__start_subtest("gotox-span-unreached-entry"))
+		check_gotox_span_unreached_entry();
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

