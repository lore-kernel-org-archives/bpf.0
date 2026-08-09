Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5B3CF041;
	Sun,  9 Aug 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287828; cv=none; b=BRnj3zyALKuYofm54OfG1Ydzu1ok2cZTJPk1vd72CjjRSvsqbikFcMYfNBE0BDTLKxGG+H23nanzkXVgmlbtZhgHdEKsTOf94iVuM533yOnES0d3+qlBv+DBB/9khlX/SQrEVqB8+VGdS/Lrkvzhm2BFwFMon1spdItmfQA9VgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287828; c=relaxed/simple;
	bh=1vOP+z2LX9aSUYzy+aDrDhpFgod+obE8Z0hNEUWLF3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucfmmXDVGPjMBuFWPDSXO1MtnwJgiD+bRsnzqpCJdXkDPxdxcblJQQx+GScLaelCQuTQksLCryqQjIWK8CnoJR5NtrR2SR7HszMfbQERSkhf1UV+qpAHSUVc6qpy8RTW+5oqIbscATrnZqAhgeOoc3uJ9TuPGaP5uUNp4vqEcl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CT6KeBkw; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CT6KeBkw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGjoJlDAtsVtLGlFyV0FUEW111v48ECa1+dfAaHklbM=;
	b=CT6KeBkwBubhCRTMC61yUG9TaQC42aKx+6FSlHk/mhYlK/eeQXamhyhYgRrm7bUxTVyVpO
	xIjYjpO2Q4Cqm0vRe/E+gTQkdmwGr4/GRD/PC2DojhokvA7Za9e66SDkD3zCTul/xqU00M
	86hKkZPE72MHfXWHd0Kqjqj5qx4MZHs=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 11/13] selftests/bpf: Add tracing_multi bpf prog rollback test
Date: Sun,  9 Aug 2026 23:01:09 +0800
Message-ID: <20260809150111.45000-12-leon.hwang@linux.dev>
In-Reply-To: <20260809150111.45000-1-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When rollbacking, the prepared trampolines should be reverted.

In this test, the first bpf prog will be attached with the trampoline, and
the second bpf prog won't be attached because the bpf prog has been
attached by a fentry.multi prog, that causes the rollback procedure.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/libbpf.c                        |  2 +-
 tools/lib/bpf/libbpf_internal.h               |  1 +
 .../selftests/bpf/prog_tests/tracing_multi.c  | 61 +++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d698a64ff800..705f50a44410 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10629,7 +10629,7 @@ int libbpf_find_vmlinux_btf_id(const char *name,
 	return libbpf_err(err);
 }
 
-static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int token_fd)
+int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int token_fd)
 {
 	struct bpf_prog_info info;
 	__u32 info_len = sizeof(info);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 7a74abb904f8..87a3828e9b8a 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -436,6 +436,7 @@ int btf_load_into_kernel(struct btf *btf,
 			 char *log_buf, size_t log_sz, __u32 log_level,
 			 int token_fd);
 struct btf *btf_load_from_kernel(__u32 id, struct btf *base_btf, int token_fd);
+int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int token_fd);
 
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 070266a864d4..a4d9934ad1dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -377,6 +377,65 @@ static void test_cookies_bpf_prog(void)
 	__test_link_api_bpf_prog(true);
 }
 
+static void test_rollback_bpf_prog(void)
+{
+	int token_fd, prog_fd, fd = -1, pre_fd = -1;
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	struct tracing_multi_bpf *skel = NULL;
+	__u32 target_ids[2], ids[2];
+	int target_fds[2], fds[2];
+	int first, second;
+
+	skel = tracing_multi_bpf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_bpf__open_and_load"))
+		return;
+
+	token_fd = bpf_object__token_fd(skel->obj);
+	token_fd = token_fd < 0 ? 0 : token_fd;
+	target_fds[0] = bpf_program__fd(skel->progs.target_1);
+	target_fds[1] = bpf_program__fd(skel->progs.target_2);
+	target_ids[0] = libbpf_find_prog_btf_id("target_1", target_fds[0], token_fd);
+	if (!ASSERT_GT(target_ids[0], 0, "target_1_btf_id"))
+		goto cleanup;
+	target_ids[1] = libbpf_find_prog_btf_id("target_2", target_fds[1], token_fd);
+	if (!ASSERT_GT(target_ids[1], 0, "target_2_btf_id"))
+		goto cleanup;
+
+	first = target_fds[0] < target_fds[1] ? 0 : 1;
+	second = 1 - first;
+	fds[0] = target_fds[first];
+	fds[1] = target_fds[second];
+	ids[0] = target_ids[first];
+	ids[1] = target_ids[second];
+
+	prog_fd = bpf_program__fd(skel->progs.test_fentry);
+	lopts.tracing_multi.ids = &ids[1];
+	lopts.tracing_multi.fds = &fds[1];
+	lopts.tracing_multi.cnt = 1;
+	pre_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY_MULTI, &lopts);
+	if (!ASSERT_GE(pre_fd, 0, "pre_attach"))
+		goto cleanup;
+
+	lopts.tracing_multi.ids = ids;
+	lopts.tracing_multi.fds = fds;
+	lopts.tracing_multi.cnt = ARRAY_SIZE(ids);
+
+	fd = bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY_MULTI, &lopts);
+	if (!ASSERT_EQ(fd, -EBUSY, "bpf_link_create"))
+		goto cleanup;
+
+	if (run_bpf_target(skel->progs.target_1, first + 1, "rollback_target"))
+		goto cleanup;
+	ASSERT_EQ(skel->bss->test_result_fentry, 0, "test_result_fentry");
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	if (pre_fd >= 0)
+		close(pre_fd);
+	tracing_multi_bpf__destroy(skel);
+}
+
 static void test_module_skel_api(void)
 {
 	struct tracing_multi_module *skel = NULL;
@@ -1219,4 +1278,6 @@ void test_tracing_multi_test(void)
 		test_attach_api_bpf_prog_fails();
 	if (test__start_subtest("cookies_bpf_prog"))
 		test_cookies_bpf_prog();
+	if (test__start_subtest("rollback_bpf_prog"))
+		test_rollback_bpf_prog();
 }
-- 
2.55.0

