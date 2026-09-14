Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16748AE00
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405418; cv=none; b=Zr1AJ286SGPl3zzqlaBjKEE44rILLlgtz107A62eykqya1xt81svGR6LB0DuggHkpYJO91+pX96rcQ4lVFekUglvC5BTQux6PL68r1z4F6lib5TV+/M06hQwqgYVBYt2mhjmMcE7w6NDYI7gkvX5oKmJeBIoVBBgtw0up8P+Ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405418; c=relaxed/simple;
	bh=Ohdq5QrS1dmBcNGQucepW3E/DmXMmwfahIM7ZEC+ZVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1Vsn74Rjg3qabIbI+/GS0D/QaHcVNdlhYqGxiUWCs9e+xJDBLZ9VkYRzMSAO6Rdqep8T5IsBnmDkORuxNOLeRZbEic+cFXjw/hmFQnhmS187+KUSN4eBx2h31jF+nbt4EXUapWjDcSVeXSHW1mo9pI4OhNHVNz9xPdgQmmPJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mLbgircC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mLbgircC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Neqox8eUdF+CHc+jcY+4rg6h0AHUrAXtJ8dj/FRC0Yo=; b=mLbgircCTLJMJSRfZVwYlkFp/r
	4xcq5BrU3GRbE/wUsR7n+MNjZEPZY71e0Z1Swz7CSupEVtVN2oeC8OKBaCXqjjh/JjGOqCeWqeZJx
	8uhB4NW/lo40pRjVAK65woQ3BSxDAPfNBm3r1b1wyrMUO2jEt5ZWF/00jjTL/e5tm+bDBaUxn4DIh
	ZjDRaS1fCHXV3nODyMBFcmUiN9bRvQzNzsGr/3bLAj8uZXVzypVNWgQeusYGCAaMMFAKvLcesg4K5
	Ll4EQU/Lw4kKJOZVjVwbNeEiVGFHm5DKEW9g7/xrzyHaCYcVUgKuoO0p1sLlEJzLB6hiKnouvNOwS
	IphaSuWw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6A5e-000C9h-1e;
	Mon, 14 Sep 2026 19:03:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 11/11] selftests/bpf: Add tests for gotox targets across prologue prepends
Date: Mon, 14 Sep 2026 19:03:26 +0200
Message-ID: <20260914170326.249953-12-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914170326.249953-1-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28123/Mon Sep 14 08:24:19 2026)

Add tests to the bpf_insn_array suite for a gotox whose jump table points
at the first instruction of a subprogram.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t bpf_insn_array
  [...]
  #24/23   bpf_insn_array/gotox-target-prologue-shift:OK
  #24/24   bpf_insn_array/gotox-target-ctx-prologue-shift:OK
  #24      bpf_insn_array:OK
  Summary: 1/24 PASSED, 0 SKIPPED, 0/0 FAILED

As small nit, cleanup the extra whitespaces between subtests.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 130 ++++++++++++++----
 1 file changed, 107 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 9908e538c022..f102435675c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -1376,77 +1376,161 @@ static void check_insn_array_stale_reuse(void)
 		close(jt_fd);
 }
 
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
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	struct bpf_insn_array_value val = {};
+	int prog_fd = -1, map_fd;
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
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, ARRAY_SIZE(insns), &opts);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &key, &val), 0, "bpf_map_lookup_elem"))
+		goto cleanup;
+	ASSERT_NEQ(val.xlated_off, 0, "gotox target retargeted past prepend");
+	ASSERT_NEQ(val.xlated_off, (__u32)-1, "gotox target not INSN_DELETED");
+	ASSERT_NEQ(val.jitted_off, 0, "gotox target has a jitted address");
+cleanup:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	close(map_fd);
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
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	struct bpf_insn_array_value val = {};
+	int prog_fd = -1, map_fd;
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
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SCHED_CLS, NULL, "GPL", insns,
+				ARRAY_SIZE(insns), &opts);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &key, &val), 0, "bpf_map_lookup_elem"))
+		goto cleanup;
+	ASSERT_NEQ(val.xlated_off, 0, "gotox target retargeted past prepend");
+	ASSERT_NEQ(val.xlated_off, (__u32)-1, "gotox target not INSN_DELETED");
+	ASSERT_NEQ(val.jitted_off, 0, "gotox target has a jitted address");
+cleanup:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	close(map_fd);
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
 	if (test__start_subtest("too-many-gotox-edges"))
 		check_too_many_gotox_edges();
-
 	if (test__start_subtest("gotox-edges-at-limit"))
 		check_gotox_edges_at_limit();
-
 	if (test__start_subtest("gotox-edges-across-subprogs"))
 		check_gotox_edges_across_subprogs();
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
-
 	if (test__start_subtest("gotox-target-nop"))
 		check_gotox_target_nop();
-
 	if (test__start_subtest("insn-array-stale-reuse"))
 		check_insn_array_stale_reuse();
+	if (test__start_subtest("gotox-target-prologue-shift"))
+		check_gotox_target_prologue_shift();
+	if (test__start_subtest("gotox-target-ctx-prologue-shift"))
+		check_gotox_target_ctx_prologue_shift();
 }
 #else
 static void __test_bpf_insn_array(void)
-- 
2.43.0

