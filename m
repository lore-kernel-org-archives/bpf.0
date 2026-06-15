Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5C4048A7
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537340; cv=none; b=VhrzP4UaLppvyF7VoUGLV0PcIIBomWnXdmUZZthJizSM+jRhCGEp7n87hXlpGZao9exc8r3I8k55BqyswZMVRGWmCOli4r4w017k1oZNOSmOxBhSRxCcBUdI4ALqam2lu0oTVyQOi74j3qgmjxpUXSfOFdjoE6Qo/eCnXnwPMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537340; c=relaxed/simple;
	bh=BKSXzkY1YSs330iKp9iJwBmUStljZhN+1kGdwqC9m0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oG5SZhWg2FwZSxUpRUQ+T63rSEEQkU4oYkrfWvzfulYsWf2khrDFuzZZO38Qq9BW2BBlsiSUSO0YdSJeBPO74XpVxmV2JuH9/dbu2ffWIhnd5SJgcfephW/lks+na+2mPfbCnkzwoz9UUpfl8MCyhYFz9GoeL3C8jNw3KCro7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SALUjOwu; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SALUjOwu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781537337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqydxvlgxwDnudODwf/CASCAcYw35QA6V1K1PJ6UTmI=;
	b=SALUjOwuPqTj8qH3aKmTsx3okUPuKTisGcHB4KOX7lnrnW9eITYmsqcup0/UfJxjkYYij2
	9KqhkfNF9Ihwam5JwtvjDkiaxNx3wKMu7vtUJonmMpEAKtIxN0BALJ95TE9LaxYfYY4saS
	AMvKwSIcQFcgSxBhCM+yGhB4r9RMf60=
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
Subject: [PATCH bpf-next v6 11/12] selftests/bpf: Add test to verify xlated insns for global percpu data
Date: Mon, 15 Jun 2026 23:26:45 +0800
Message-ID: <20260615152646.27639-12-leon.hwang@linux.dev>
In-Reply-To: <20260615152646.27639-1-leon.hwang@linux.dev>
References: <20260615152646.27639-1-leon.hwang@linux.dev>
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
 .../bpf/prog_tests/global_data_init.c         | 87 +++++++++++++++++++
 .../bpf/progs/test_global_percpu_data.c       | 11 +++
 2 files changed, 98 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index e4c290492ff8..fcc2c4ec8644 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -279,6 +279,91 @@ static void test_global_percpu_data_verifier_log(void)
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
+	return ((__u64)(__u32) insn[1].imm << 32) | (__u32) insn[0].imm;
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
+
+	idx = find_ld_imm64(insns, cnt, ld_imm64_xlated);
+	if (!ASSERT_GE(idx, 0, "find_ld_imm64 xlated"))
+		goto out;
+
+	if (!ASSERT_GT(cnt, idx + 2, "xlated insn count"))
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
@@ -293,4 +378,6 @@ void test_global_percpu_data(void)
 	if (test__start_subtest("rdonly_direct_read"))
 		test_global_percpu_data_rdonly_direct_read();
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

