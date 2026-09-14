Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560A493D32
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405417; cv=none; b=HavcxoFxOTCch8rF0edVJ5Os/1sU/GDLy6kxT3SrhBSoNyQbNY9TSzNCLv3fEF8sKuGEJPYfPZq8EhHH9t05xsVmkXyf0ibD7O/bg1DE5m1De/t9XYq/Q6l2sq30mPzjt+MIprluS2hKB3UIrBgOU+VOpqd1UIHlVJgUCb+luMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405417; c=relaxed/simple;
	bh=tC6o85osCV/9ho35jaSStuE3WLrapGq0FAxnX5yHOpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fze4zP4tVyEDJ+FrpFlOPos2C+4AIirp+J6yZ2MTgwlYyOS4JORNfF1O1d6ZbxFTmv+TZOkikZsFCGXGN3+iZ7nQmV8Jrd/3AJDPpDFtDODV6MJRJnvoGcdnfdu4FX1plbDJMUmOOKtgDevEuPs1ZJZeYLFuYaoyecUVmcQO75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=EFlk5LPC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="EFlk5LPC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PyyK7eMwV0Y7NejrBr4bCtI+1TuIR+b5UCWq69doDcg=; b=EFlk5LPCABAC9I/beQXYR3C2Ps
	dUPYRp0dJh3l7KPqFxA16y+atiJCNbDnFvXmzY4aEC19KPDW6bbJ5RnyNTxsUH+gGN3Ezl9Cm4GBd
	2a3wUOI+q1iGfmrlkufw+kprVFLAbM2EHiHUUixv/uboTuztbOyGBdR8PDvgKyQtY87A5AzAlBghG
	kVBo7iPpJv383dsz2owN5x24AM+cN+LxLY395BEn425+NRuSlZRi1qURLgZs22QH4wB+Asqym1OWU
	Yxuor6QBPPl130MvtbrbRDQwZpRSBImguWMLXOPAy7zCQliZadtEZN7BZJtcOrR77wTyuGFqAndn3
	/fBZUf0g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6A5d-000C9c-35;
	Mon, 14 Sep 2026 19:03:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 10/11] selftests/bpf: Add tests for gotox nop targets and insn array reuse
Date: Mon, 14 Sep 2026 19:03:25 +0200
Message-ID: <20260914170326.249953-11-daniel@iogearbox.net>
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

Add two tests to the bpf_insn_array suite which excercise gotox target
which is a ja +0, and the insn array reuse which initially fails the
post-JIT stage.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t bpf_insn_array
  [...]
  #24/21   bpf_insn_array/gotox-target-nop:OK
  #24/22   bpf_insn_array/insn-array-stale-reuse:OK
  #24      bpf_insn_array:OK
  Summary: 1/22 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index d6ebb4c37aea..9908e538c022 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -1242,6 +1242,140 @@ static void check_bpf_side(void)
 	check_bpf_no_lookup();
 }
 
+static void check_gotox_target_nop(void)
+{
+	struct bpf_insn insns[] = {
+		/* r1 = &jt[0] */
+		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE, 0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0), /* gotox r1 */
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0),		/* insn 4: the nop target */
+		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
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
+	val.orig_off = 4;
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
+	ASSERT_NEQ(val.xlated_off, (__u32)-1, "gotox target must not be INSN_DELETED");
+	ASSERT_NEQ(val.jitted_off, 0, "gotox target must have a jitted address");
+cleanup:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	close(map_fd);
+}
+
+static void check_insn_array_stale_reuse(void)
+{
+	/* helper of a different prog type, to set the prog array's owner */
+	struct bpf_insn sf[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	/*
+	 * prog1 binds the insn array (entry points at a real insn, so the JIT
+	 * fills it in) and tail calls a prog array whose owner is now a
+	 * different type, which fails in the post-JIT compatibility check.
+	 */
+	struct bpf_insn prog1[] = {
+		BPF_LD_IMM64_RAW(BPF_REG_2, BPF_PSEUDO_MAP_IDX, 1), /* r2 = prog array */
+		BPF_MOV64_IMM(BPF_REG_3, 0),			   /* r3 = index */
+		BPF_EMIT_CALL(BPF_FUNC_tail_call),
+		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),		   /* insn 4: real entry */
+		BPF_EXIT_INSN(),
+	};
+	/*
+	 * prog2 reuses the insn array as a tracker. Its entry points at a nop
+	 * that the nop pass removes, so the entry becomes INSN_DELETED and the
+	 * JIT skips it -- exactly the slot a stale pointer would linger in.
+	 */
+	struct bpf_insn prog2[] = {
+		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0),		/* nop */
+		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0),		/* nop */
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0),		/* insn 4: tracked nop */
+		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	int jt_fd = -1, pa_fd = -1, sf_fd = -1, prog_fd = -1;
+	struct bpf_insn_array_value val = {};
+	int fd_array[2];
+	__u32 key = 0;
+
+	jt_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
+	if (!ASSERT_GE(jt_fd, 0, "insn_array create"))
+		return;
+	val.orig_off = 4;
+	if (!ASSERT_EQ(bpf_map_update_elem(jt_fd, &key, &val, 0), 0, "insn_array update"))
+		goto cleanup;
+	if (!ASSERT_EQ(bpf_map_freeze(jt_fd), 0, "insn_array freeze"))
+		goto cleanup;
+
+	pa_fd = bpf_map_create(BPF_MAP_TYPE_PROG_ARRAY, "pa", 4, 4, 1, NULL);
+	if (!ASSERT_GE(pa_fd, 0, "prog_array create"))
+		goto cleanup;
+	sf_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", sf, ARRAY_SIZE(sf), NULL);
+	if (!ASSERT_GE(sf_fd, 0, "owner prog load"))
+		goto cleanup;
+	/* insert a non-XDP prog to pin the prog array owner to another type */
+	if (!ASSERT_EQ(bpf_map_update_elem(pa_fd, &key, &sf_fd, 0), 0, "prog_array update"))
+		goto cleanup;
+
+	fd_array[0] = jt_fd;
+	fd_array[1] = pa_fd;
+	opts.fd_array = fd_array;
+	opts.fd_array_cnt = 2;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", prog1, ARRAY_SIZE(prog1), &opts);
+	if (!ASSERT_LT(prog_fd, 0, "prog1 must fail the post-JIT tail call check"))
+		goto cleanup;
+
+	/* prog1 reached the JIT before failing, so the entry is now populated */
+	if (!ASSERT_EQ(bpf_map_lookup_elem(jt_fd, &key, &val), 0, "lookup after prog1"))
+		goto cleanup;
+	if (!ASSERT_NEQ(val.jitted_off, 0, "prog1 should have filled the jitted address"))
+		goto cleanup;
+
+	opts.fd_array_cnt = 1;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", prog2, ARRAY_SIZE(prog2), &opts);
+	if (!ASSERT_GE(prog_fd, 0, "prog2 reuse load"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_lookup_elem(jt_fd, &key, &val), 0, "lookup after prog2"))
+		goto cleanup;
+	ASSERT_EQ(val.xlated_off, (__u32)-1, "reused entry should be INSN_DELETED");
+	ASSERT_EQ(val.jitted_off, 0, "stale jitted address must be cleared on reuse");
+cleanup:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	if (sf_fd >= 0)
+		close(sf_fd);
+	if (pa_fd >= 0)
+		close(pa_fd);
+	if (jt_fd >= 0)
+		close(jt_fd);
+}
+
 static void __test_bpf_insn_array(void)
 {
 	/* Test if offsets are adjusted properly */
@@ -1307,6 +1441,12 @@ static void __test_bpf_insn_array(void)
 
 	if (test__start_subtest("gotox-callback-leaves-subprog"))
 		check_gotox_callback_leaves_subprog();
+
+	if (test__start_subtest("gotox-target-nop"))
+		check_gotox_target_nop();
+
+	if (test__start_subtest("insn-array-stale-reuse"))
+		check_insn_array_stale_reuse();
 }
 #else
 static void __test_bpf_insn_array(void)
-- 
2.43.0

