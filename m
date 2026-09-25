Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D54C6516
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358782; cv=none; b=ndAUVIqv2YVlYWiT9/q8nA/vgP2GhdGrL96rH8or1lAehjY3bexMosS7CD3suCKjRkt3cfbf8/3flruXvBE+xyjxrNoS2fhXN03ue+yQMId/Ih/8qL+mDanJVLRAv78c2vp7pqeb9Zt1DxVy1gIcBRwWQG5K0FQ0t9mCJHRgt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358782; c=relaxed/simple;
	bh=loik/wF+PJf/fLrAr8AcTKBDqM3/xT0Z/c6ysc4VQos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSw4fp3xVYqv+MJoryPMsdbn2K1lll49E3n8PfQD7j3ksZSRvEuYpHkbKt3dRTIvBGz3hMUodFDYdyYNNhlwwCugvHnKgWHf9WvAKZAw5NvYERHuiKQ05NAPkCnEYM/ruQezAct+UdBcdkmCEIr3F8glCG8QRkHt7R2BsZViVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Kem1XjwZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Kem1XjwZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=36tZmrhtLQVF4SA2v4AF9NZhn/KSuuPsMq1B2uW82BM=; b=Kem1XjwZfZRNO6Wpgusv4+DpZ7
	rx7AzqmmTPbcM7sS1y2Z5PorvZqbH5aY3hu74szGC1eaPiOdVZlqz1zTy4tg9zZIUUCooV9/Ko2Rx
	TwB2VDD6W8Mmhp8UrWP4E2gu2eGvwukBtUCYfSA1hr1Jtv+FEqzpKuqnChLGqMC/RTJd6YT6l8apw
	Dvqdf7xV7znfa5XDOzsqFGvYARAxXYWW7gfXc+WZRnoBQkIPpovtdp9SiNFpiR6q6lVvqJEKiJPm3
	8i+LJdYw9XU0iuUaLRRcgNJG6qbA/ApMAzSGy57T/Zr1iiWg8a+wQWu2pTcJJ/dmOfTRNReRPxGH+
	hnM9Pahg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6Q-000JlV-2E;
	Fri, 25 Sep 2026 19:52:54 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v3 15/16] selftests/bpf: Add tests for gotox targets across prologue prepends
Date: Fri, 25 Sep 2026 19:52:42 +0200
Message-ID: <20260925175244.1136329-16-daniel@iogearbox.net>
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

Add tests to the bpf_insn_array suite for a gotox whose jump table points
at the first instruction of a subprogram.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t bpf_insn_array
  [...]
  #27/19   bpf_insn_array/gotox-target-prologue-shift:OK
  #27/20   bpf_insn_array/gotox-target-ctx-prologue-shift:OK
  #27      bpf_insn_array:OK
  Summary: 1/20 PASSED, 0 SKIPPED, 0/0 FAILED

As small nit, cleanup the extra whitespaces between subtests.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 127 +++++++++++++++---
 1 file changed, 108 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 40e183269fb6..bfedeed24ac5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -972,65 +972,154 @@ static void check_bpf_side(void)
 	check_bpf_no_lookup();
 }
 
+/* Return the xlated index of the first insn equal to 'insn', or -1. */
+static int xlated_insn_index(int prog_fd, const struct bpf_insn *insn)
+{
+	struct bpf_insn *xlated;
+	int idx = -1;
+	__u32 cnt, i;
+
+	if (!ASSERT_OK(get_xlated_program(prog_fd, &xlated, &cnt), "get_xlated_program"))
+		return -1;
+	for (i = 0; i < cnt; i++)
+		if (!memcmp(&xlated[i], insn, sizeof(*insn))) {
+			idx = i;
+			break;
+		}
+	free(xlated);
+	return idx;
+}
+
+/*
+ * Load 'insns' with a jump table naming insn 0, which a prologue prepend
+ * pushes down, and check that the slot followed it.
+ */
+static void check_gotox_target_prepend(enum bpf_prog_type prog_type,
+				       struct bpf_insn *insns, __u32 insn_cnt)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	struct bpf_insn_array_value val = {};
+	int prog_fd = -1, map_fd, idx;
+	__u32 key = 0;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	val.orig_off = 0;
+	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
+		goto cleanup;
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	opts.fd_array = &map_fd;
+	opts.fd_array_cnt = 1;
+	prog_fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insn_cnt, &opts);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	idx = xlated_insn_index(prog_fd, &insns[0]);
+	if (!ASSERT_GT(idx, 0, "insn 0 was prepended to"))
+		goto cleanup;
+	if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &key, &val), 0, "bpf_map_lookup_elem"))
+		goto cleanup;
+	ASSERT_EQ(val.xlated_off, (__u32)idx, "gotox target followed insn 0 past the prepend");
+cleanup:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	close(map_fd);
+}
+
+static void check_gotox_target_prologue_shift(void)
+{
+	struct bpf_insn insns[] = {
+		/* insn 0: gotox target and subprog start */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* may_goto +4 -> exit block, bounds the loop */
+		BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 4, 0),
+		/* r1 = &jt[0] (insns 2 and 3) */
+		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0), /* r1 = ips[0] */
+		/* insn 5: gotox r1 -> insn 0 */
+		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0),
+		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS), /* insn 6: exit block */
+		BPF_EXIT_INSN(),
+	};
+
+	check_gotox_target_prepend(BPF_PROG_TYPE_XDP, insns, ARRAY_SIZE(insns));
+}
+
+static void check_gotox_target_ctx_prologue_shift(void)
+{
+	struct bpf_insn insns[] = {
+		/* insn 0: gotox target and subprog start */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_7, 0x5a5a, 12), /* second visit exits */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0x5a5a),
+		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1), /* r6 = ctx */
+		BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_6, offsetof(struct __sk_buff, data)),
+		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_6, offsetof(struct __sk_buff, data_end)),
+		BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 1),
+		BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 5),
+		/* insn 9: direct packet write -> tc unclone prologue prepended at insn 0 */
+		BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0),
+		/* r5 = &jt[0] (insns 10 and 11) */
+		BPF_LD_IMM64_RAW(BPF_REG_5, BPF_PSEUDO_MAP_IDX_VALUE, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_5, 0), /* r5 = ips[0] */
+		/* insn 13: gotox r5 -> insn 0 */
+		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_5, 0, 0, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 0), /* insn 14: exit block */
+		BPF_EXIT_INSN(),
+	};
+
+	check_gotox_target_prepend(BPF_PROG_TYPE_SCHED_CLS, insns, ARRAY_SIZE(insns));
+}
+
 static void __test_bpf_insn_array(void)
 {
 	/* Test if offsets are adjusted properly */
-
 	if (test__start_subtest("one2one"))
 		check_one_to_one_mapping();
-
 	if (test__start_subtest("simple"))
 		check_simple();
-
 	if (test__start_subtest("deletions"))
 		check_deletions();
-
 	if (test__start_subtest("deletions-with-functions"))
 		check_deletions_with_functions();
-
 	if (test__start_subtest("blindness"))
 		check_blindness();
-
 	/* Check all kinds of operations and related restrictions */
-
 	if (test__start_subtest("incorrect-index"))
 		check_incorrect_index();
-
 	if (test__start_subtest("load-unfrozen-map"))
 		check_load_unfrozen_map();
-
 	if (test__start_subtest("no-map-reuse"))
 		check_no_map_reuse();
-
 	if (test__start_subtest("bpf-side-ops"))
 		check_bpf_side();
-
 	if (test__start_subtest("gotox-jt-spans-subprogs"))
 		check_gotox_jt_spans_subprogs();
-
 	if (test__start_subtest("gotox-jt-spans-with-own-table"))
 		check_gotox_jt_spans_with_own_table();
-
 	if (test__start_subtest("gotox-target-other-subprog"))
 		check_gotox_target_other_subprog();
-
 	if (test__start_subtest("gotox-jt-per-subprog"))
 		check_gotox_jt_per_subprog();
-
 	if (test__start_subtest("gotox-jt-dead-subprogs"))
 		check_gotox_jt_dead_subprogs();
-
 	if (test__start_subtest("gotox-target-subprog-from-main"))
 		check_gotox_target_subprog_from_main();
-
 	if (test__start_subtest("gotox-index-slice-other-subprog"))
 		check_gotox_index_slice_other_subprog();
-
 	if (test__start_subtest("gotox-target-other-global-subprog"))
 		check_gotox_target_other_global_subprog();
-
 	if (test__start_subtest("gotox-callback-leaves-subprog"))
 		check_gotox_callback_leaves_subprog();
+	if (test__start_subtest("gotox-target-prologue-shift"))
+		check_gotox_target_prologue_shift();
+	if (test__start_subtest("gotox-target-ctx-prologue-shift"))
+		check_gotox_target_ctx_prologue_shift();
 }
 #else
 static void __test_bpf_insn_array(void)
-- 
2.43.0

