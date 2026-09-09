Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47C3D1CA8
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986460; cv=none; b=ld4XpnYi0+CYkAxGhAOn6yZgeLNTV17e50ngWLRi4DjU4Q3MbSvgDKiFkADUA6WWCd7TWUQdoxSh7WcOmfHBMcrN9SiKPxEpihYjI/kqlknTVSqXt3zWA9eS7oXLQVQZRAy1iXviBDbd78FTm0ZeEXcpqVKtGLp7TySwELhlx5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986460; c=relaxed/simple;
	bh=68kBzWyQWuMB5jidM/DrAdsSit4Xg4Qx3Ehyw1jwLWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaRVfi7ZAP03see+xzLd51pzKb9DO0XWNvHFjknBJ8dWi8mOVHOL5xl6x3UD1IFS0KiXcVR65C8MOt7rhISfIAWBWcTTgjuvX3LOTSNqmlEEqDdJALTr4W0CAQLRAqhMe3nahrLvMnv6HOEcpWT/cinm8yLAuc31vEcAKRaHSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XklB3REc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XklB3REc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fzTuYxDsDj7PRnFA2pWrFxKHMASyaNAjz8TVgnwre7o=; b=XklB3REc8D+Axk2IWOFIpj76MV
	lv0NO3eJHmyibrNxfItMgmDVcb0jlfZWcE6moEFhl2S9jcuILcLGj2WI9KcQlku24UDK3LGx/R3mh
	nAl8vq/RRVvD7bg7URzMtPw/b6dlpp94jSNt/W/NowlEjsnIyuw1zkYztXRK/QpEkQ6SeOBZarbgP
	6E5uknnPpQV3mACqTWtNpROdnByqPxCayHVGyn+/lNdTBUh37ZCnyLANCyzMhHRozLVHd2RS4TchO
	QUb+Fmv9ltQXNpqwKA8r3Crz3Uu9lB7SLGDqDoOGCfZIbOL1WWhDt6Mek7cAgTwn4UkZlLkSpJXze
	QOGoGgWA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4P60-000F7b-0G;
	Wed, 09 Sep 2026 22:40:40 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf 5/6] selftests/bpf: Add tests for the indirect jump edge limit
Date: Wed,  9 Sep 2026 22:40:34 +0200
Message-ID: <20260909204035.24289-5-daniel@iogearbox.net>
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

Build programs whose gotox instructions are their own jump table targets,
which makes the edge count quadratic.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t bpf_insn_array
  [...]
  #24/10   bpf_insn_array/too-many-gotox-edges:OK
  #24/11   bpf_insn_array/gotox-edges-at-limit:OK
  #24/12   bpf_insn_array/gotox-edges-across-subprogs:OK
  #24      bpf_insn_array:OK
  Summary: 1/12 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 266 ++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 0222a9a5d076..c69d44cd4607 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -453,6 +453,263 @@ static void check_bpf_no_lookup(void)
 	close(map_fd);
 }
 
+#define GOTOX_CNT_AT_LIMIT	1000
+#define GOTOX_LOG_SZ		(256 * 1024)
+
+static const char gotox_limit_msg[] =
+	"number of indirect jump edges in the program exceeds";
+
+static int gotox_jt_create(__u32 first_gotox, __u32 gotox_cnt)
+{
+	/* the run of gotox itself, plus the exit block right after it */
+	const __u32 jt_cnt = gotox_cnt + 1;
+	struct bpf_insn_array_value val = {};
+	int map_fd;
+	__u32 i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, jt_cnt);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return map_fd;
+
+	for (i = 0; i < jt_cnt; i++) {
+		val.orig_off = first_gotox + i;
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
+static int gotox_prog_load(struct bpf_insn *insns, __u32 insn_cnt,
+			   int *fd_array, __u32 fd_array_cnt, char *log)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	int prog_fd;
+
+	log[0] = 0;
+	opts.fd_array = fd_array;
+	opts.fd_array_cnt = fd_array_cnt;
+	opts.log_buf = log;
+	opts.log_size = GOTOX_LOG_SZ;
+	opts.log_level = 1;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, &opts);
+	if (prog_fd >= 0) {
+		close(prog_fd);
+		return 0;
+	}
+	return prog_fd;
+}
+
+/* Fill in 'r1 = 0; gotox_cnt x gotox r1' at 'insns'. */
+static void gotox_run_fill(struct bpf_insn *insns, __u32 gotox_cnt)
+{
+	__u32 i;
+
+	insns[0] = BPF_MOV64_IMM(BPF_REG_1, 0);
+	for (i = 1; i <= gotox_cnt; i++)
+		insns[i] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
+}
+
+static void check_gotox_limit_hit(const char *log, int err)
+{
+	ASSERT_EQ(err, -E2BIG, "program should have been rejected");
+	ASSERT_HAS_SUBSTR(log, gotox_limit_msg, "verifier log");
+}
+
+static bool try_load_gotox_prog(__u32 gotox_cnt, char *log, int *err)
+{
+	const __u32 insn_cnt = gotox_cnt + 3;
+	struct bpf_insn *insns;
+	bool attempted = false;
+	int map_fd;
+
+	insns = calloc(insn_cnt, sizeof(*insns));
+	if (!ASSERT_OK_PTR(insns, "calloc insns"))
+		return false;
+
+	gotox_run_fill(insns, gotox_cnt);
+	insns[gotox_cnt + 1] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[gotox_cnt + 2] = BPF_EXIT_INSN();
+
+	map_fd = gotox_jt_create(1, gotox_cnt);
+	if (map_fd < 0)
+		goto free_insns;
+
+	*err = gotox_prog_load(insns, insn_cnt, &map_fd, 1, log);
+	close(map_fd);
+	attempted = true;
+free_insns:
+	free(insns);
+	return attempted;
+}
+
+/*
+ * The extra exit target in the jump table makes for gotox_cnt * (gotox_cnt
+ * + 1) edges, hence the program is over the limit by gotox_cnt edges.
+ */
+static void check_too_many_gotox_edges(void)
+{
+	const __u32 gotox_cnt = GOTOX_CNT_AT_LIMIT;
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	if (try_load_gotox_prog(gotox_cnt, log, &err))
+		check_gotox_limit_hit(log, err);
+
+	free(log);
+}
+
+/*
+ * A chain of blocks, where block k loads jt[k] and jumps to it. The jump
+ * table holds the starts of the blocks that follow plus the exit block,
+ * which is gotox_cnt targets for gotox_cnt gotox, so the program sits
+ * exactly at the limit and must still load.
+ */
+#define GOTOX_BLOCK_SZ		4
+
+static void gotox_chain_fill(struct bpf_insn *insns, __u32 gotox_cnt)
+{
+	struct bpf_insn *at;
+	__u32 k;
+
+	for (k = 0; k < gotox_cnt; k++) {
+		at = insns + k * GOTOX_BLOCK_SZ;
+
+		/* r1 = &jt[0], by index 0 into fd_array */
+		at[0] = (struct bpf_insn) {
+			.code = BPF_LD | BPF_DW | BPF_IMM,
+			.dst_reg = BPF_REG_1,
+			.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
+			.imm = 0,
+		};
+		at[1] = (struct bpf_insn) { .imm = 0 };
+		at[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, k * 8);
+		at[3] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
+	}
+
+	insns[gotox_cnt * GOTOX_BLOCK_SZ] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[gotox_cnt * GOTOX_BLOCK_SZ + 1] = BPF_EXIT_INSN();
+}
+
+static int gotox_chain_jt_create(__u32 gotox_cnt)
+{
+	struct bpf_insn_array_value val = {};
+	int map_fd;
+	__u32 i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, gotox_cnt);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return map_fd;
+
+	for (i = 0; i < gotox_cnt; i++) {
+		val.orig_off = (i + 1) * GOTOX_BLOCK_SZ;
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
+static void check_gotox_edges_at_limit(void)
+{
+	const __u32 gotox_cnt = GOTOX_CNT_AT_LIMIT;
+	const __u32 insn_cnt = gotox_cnt * GOTOX_BLOCK_SZ + 2;
+	struct bpf_insn *insns;
+	char *log;
+	int map_fd, err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	insns = calloc(insn_cnt, sizeof(*insns));
+	if (!ASSERT_OK_PTR(insns, "calloc insns"))
+		goto free_log;
+
+	gotox_chain_fill(insns, gotox_cnt);
+
+	map_fd = gotox_chain_jt_create(gotox_cnt);
+	if (map_fd < 0)
+		goto free_insns;
+
+	err = gotox_prog_load(insns, insn_cnt, &map_fd, 1, log);
+	close(map_fd);
+
+	if (!ASSERT_OK(err, "program at the edge limit should load"))
+		fprintf(stderr, "verifier log: %s\n", log);
+
+free_insns:
+	free(insns);
+free_log:
+	free(log);
+}
+
+static void check_gotox_edges_across_subprogs(void)
+{
+	const __u32 gotox_cnt = GOTOX_CNT_AT_LIMIT * 3 / 4;
+	const __u32 sub_start = gotox_cnt + 3;
+	const __u32 insn_cnt = 2 * (gotox_cnt + 3);
+	int map_fd[2] = { -1, -1 };
+	struct bpf_insn *insns;
+	char *log;
+	int err;
+
+	log = calloc(1, GOTOX_LOG_SZ);
+	if (!ASSERT_OK_PTR(log, "calloc log"))
+		return;
+
+	insns = calloc(insn_cnt, sizeof(*insns));
+	if (!ASSERT_OK_PTR(insns, "calloc insns"))
+		goto free_log;
+
+	gotox_run_fill(insns, gotox_cnt);
+	insns[gotox_cnt + 1] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0,
+					    BPF_PSEUDO_CALL, 0,
+					    sub_start - (gotox_cnt + 1) - 1);
+	insns[gotox_cnt + 2] = BPF_EXIT_INSN();
+
+	gotox_run_fill(insns + sub_start, gotox_cnt);
+	insns[sub_start + gotox_cnt + 1] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[sub_start + gotox_cnt + 2] = BPF_EXIT_INSN();
+
+	map_fd[0] = gotox_jt_create(1, gotox_cnt);
+	if (map_fd[0] < 0)
+		goto free_insns;
+	map_fd[1] = gotox_jt_create(sub_start + 1, gotox_cnt);
+	if (map_fd[1] < 0)
+		goto close_maps;
+
+	err = gotox_prog_load(insns, insn_cnt, map_fd, 2, log);
+	check_gotox_limit_hit(log, err);
+
+close_maps:
+	close(map_fd[0]);
+	close(map_fd[1]);
+free_insns:
+	free(insns);
+free_log:
+	free(log);
+}
+
 static void check_bpf_side(void)
 {
 	check_bpf_no_lookup();
@@ -490,6 +747,15 @@ static void __test_bpf_insn_array(void)
 
 	if (test__start_subtest("bpf-side-ops"))
 		check_bpf_side();
+
+	if (test__start_subtest("too-many-gotox-edges"))
+		check_too_many_gotox_edges();
+
+	if (test__start_subtest("gotox-edges-at-limit"))
+		check_gotox_edges_at_limit();
+
+	if (test__start_subtest("gotox-edges-across-subprogs"))
+		check_gotox_edges_across_subprogs();
 }
 #else
 static void __test_bpf_insn_array(void)
-- 
2.43.0

