Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34FC3EA97B
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930398; cv=none; b=GI8OeLTmAo1Y0F9ccqkj2glI7T76q16azB2hF8YANECRi/SjrvA4m8Nh5Istj57MCEaU66IJWab3K8jDP1hsaqAQGho69gZrd762eZAKxAkB6PTZ1eEEoIA7E8tKRJWFtGcpFiBSzjuhcNOx0c9EadanY/1N12UkmPVZNFoXR/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930398; c=relaxed/simple;
	bh=sUWAQdDYB4RLlYYpJ8g4dqr7vT803ERTT/npRw5OlZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb5mulICy154DdnP+FMKUMczJFkgRQiCdZVjKeqoRmHAM4BhLvxHcewq0h0A2FKqKEZkxWn/Fuq7PDBDdB1Tm7zO0kffaOIX1ZXalqOGEi8DGRbWlTHle7Hyt/iwjymbgdrxr8nYlyBU/G9qM3B7cZKkou8bC17co6l1t5a/e5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P1SBXK8K; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P1SBXK8K"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780930394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6P8l47YQRap6fZECDng/I7tmxe0tKrTBnAtBZsq6qc=;
	b=P1SBXK8KbLnyNvbPryzf3oSjmTFGzfHtP56ki/tDojs9o9lYhn3Nr1Cm2PSmKPi27+8brs
	n/DsbqQPjMfZUMGASeIWjf4+gN73xl4dstgFWUsdaZzOEJW0JafmrxDTKux7I03xhUlcy5
	cxpotWObDUlh8X6MSbqXf/2jxsP0gAY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v5 8/9] selftests/bpf: Add test to verify xlated insns for global percpu data
Date: Mon,  8 Jun 2026 22:51:12 +0800
Message-ID: <20260608145113.65857-9-leon.hwang@linux.dev>
In-Reply-To: <20260608145113.65857-1-leon.hwang@linux.dev>
References: <20260608145113.65857-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a test to verify global percpu data related xlated insns:

1. ld_imm64: compare xlated one with the one in ELF object file.
2. mov64_percpu_reg: it is added by verifier.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         | 86 +++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       | 11 +++
 2 files changed, 97 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 729878d5d3b3..c3b9423246b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -249,6 +249,90 @@ static void test_global_percpu_data_verifier_log(void)
 	RUN_TESTS(test_global_percpu_data);
 }
 
+static int find_ld_imm64(const struct bpf_insn *insns, size_t insn_cnt, struct bpf_insn *ld_imm64)
+{
+	size_t i;
+
+	for (i = 0; i < insn_cnt; i++) {
+		if (insns[i].code == (BPF_LD | BPF_IMM | BPF_DW)) {
+			ld_imm64[0] = insns[i];
+			ld_imm64[1] = insns[i + 1];
+			return i;
+		}
+	}
+
+	return -ENOENT;
+}
+
+/*
+ * Special (internal-only) form of mov, used to resolve per-CPU addrs:
+ * dst_reg = src_reg + <percpu_base_off>
+ * BPF_ADDR_PERCPU is used as a special insn->off value.
+ */
+#define BPF_ADDR_PERCPU	(-1)
+
+#define BPF_MOV64_PERCPU_REG(DST, SRC)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = BPF_ADDR_PERCPU,			\
+		.imm   = 0 })
+
+static __u64 ld_imm64_to_u64(const struct bpf_insn *insn)
+{
+	return ((__u64) insn[1].imm << 32) | (__u64) insn[0].imm;
+}
+
+static void test_global_percpu_data_xlated(void)
+{
+	struct bpf_insn ld_imm64_raw[2], ld_imm64_xlated[2], mov64_percpu_reg, *insns = NULL;
+	size_t insn_sz = sizeof(struct bpf_insn);
+	struct test_global_percpu_data *skel;
+	struct bpf_program *prog;
+	int idx, err;
+	__u32 cnt;
+
+	skel = test_global_percpu_data__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
+		return;
+
+	prog = skel->progs.verifier_percpu_read;
+	idx = find_ld_imm64(bpf_program__insns(prog), bpf_program__insn_cnt(prog), ld_imm64_raw);
+	if (!ASSERT_GE(idx, 0, "find_ld_imm64 raw"))
+		goto out;
+
+	err = test_global_percpu_data__load(skel);
+	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
+		goto out;
+
+	err = get_xlated_program(bpf_program__fd(prog), &insns, &cnt);
+	if (!ASSERT_OK(err, "get_xlated_program"))
+		goto out;
+	if (!ASSERT_GT(cnt, idx + 2, "xlated insn count"))
+		goto out;
+
+	idx = find_ld_imm64(insns, cnt, ld_imm64_xlated);
+	if (!ASSERT_GE(idx, 0, "find_ld_imm64 xlated"))
+		goto out;
+
+	ASSERT_EQ(ld_imm64_xlated[0].code, ld_imm64_raw[0].code, "ld_imm64 opcode");
+	ASSERT_TRUE(ld_imm64_xlated[0].dst_reg == ld_imm64_raw[0].dst_reg, "ld_imm64 dst_reg");
+	/*
+	 * The xlated instruction has the map ID in imm and the offset
+	 * in the next instruction's imm. The raw instruction just has
+	 * the offset in its imm.
+	 */
+	ASSERT_EQ(ld_imm64_xlated[1].imm, ld_imm64_to_u64(ld_imm64_raw), "ld_imm64 off");
+
+	mov64_percpu_reg = BPF_MOV64_PERCPU_REG(ld_imm64_raw[0].dst_reg, ld_imm64_raw[0].dst_reg);
+	ASSERT_MEMEQ(&insns[idx + 2], &mov64_percpu_reg, insn_sz, "mov64_percpu_reg");
+
+out:
+	test_global_percpu_data__destroy(skel);
+	free(insns);
+}
+
 void test_global_percpu_data(void)
 {
 	if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
@@ -262,4 +346,6 @@ void test_global_percpu_data(void)
 		test_global_percpu_data_lskel();
 	if (test__start_subtest("verifier_log"))
 		test_global_percpu_data_verifier_log();
+	if (test__start_subtest("xlated"))
+		test_global_percpu_data_xlated();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index 2222ad3a49bd..9a1b1a314c2f 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -51,4 +51,15 @@ int verifier_snprintf(void *ctx)
 	return 0;
 }
 
+static volatile const char fmt2[] SEC(".percpu.fmt") = "data %d\n";
+
+SEC("kprobe")
+__auxiliary
+int verifier_percpu_read(void *ctx)
+{
+	char c = fmt2[4];
+
+	return c == ' ';
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

