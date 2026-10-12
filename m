Received: from mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842094A3F3A
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819894; cv=none; b=C6YM9nVZ5dOu80ytDVDf0XY5dF2ZbNgmuDo/d14qBC4+FXK0HbA66/+wPaW1nEKNp8ecRxMv857Ps1KopQIiK1w5t+XAKbFK0J9OGjZavYXltrTNc+2vMSAsEdNxdMJn/unzbb+ep0qawEsRdYzRgY3O/QDzl2DjQG2LsIXKfds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819894; c=relaxed/simple;
	bh=x+tHv/JfxB67Xj0ZN2pC8aXjPVSjxniDbcnePWR5xGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxQor7a4GrJFqb9DVFR0vJs0u8KGu1OsyKQsSzgorAhxoK7s7jnkX/z1qt5X+z1JaVRGlkKRoCy2AypjTsoiIgb+V016awyAiRTTtBdZIb4kyHlJJiLQi41aBb9OtbTc5gnB6tiduwbT5JbWG3sXHVdB2IVCa6jYGP8rsdmslCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FaYwAf/z; arc=none smtp.client-ip=95.215.58.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FaYwAf/z"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x+tHv/JfxB67Xj0ZN2pC8aXjPVSjxniDbcnePWR5xGE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819890; v=1; x=1792424690;
 b=FaYwAf/zvGPj9qjT+BWNU+h28H9VFUizLm1Dvc3I7wdZ2c6yrByX61dSKO8yEttxbmBha1aQ
 HF4G8otlbJC08wBLiJ4RpdmdEJJSqmzQCCf0EVCmxYy7v6fUKliIYMs/gGf1I9+Mc+TAeU6hwkd
 646dW/Qd5DPFi9WIuZLV430k=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4d116a5b8422ca6e;
	Mon, 12 Oct 2026 15:44:50 +0000
X-Mizu-Trace-ID: 4d116a5b8422ca6e
X-Migadu-Flow: FLOW_OUT
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
Subject: [PATCH bpf-next v2 16/21] selftests/bpf: Add tracing_multi bpf prog attach failure tests
Date: Mon, 12 Oct 2026 23:40:18 +0800
Message-ID: <20261012154024.29423-17-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests against two libbpf failures and two kernel failures:

* libbpf: 'ids' + 'fds'.
* libbpf: 'pattern' + 'fds'.
* kernel: 'fds' + invalid 'ids'.
* kernel: duplicate targets via different fd for the same bpf prog + func.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/libbpf.c                        |   2 +-
 tools/lib/bpf/libbpf_internal.h               |   1 +
 .../selftests/bpf/prog_tests/tracing_multi.c  | 100 ++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index edc5e8e813f3..72e2459e9339 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11604,7 +11604,7 @@ int libbpf_find_vmlinux_btf_id(const char *name,
 	return libbpf_err(err);
 }
 
-static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int token_fd)
+int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int token_fd)
 {
 	struct bpf_prog_info info;
 	__u32 info_len = sizeof(info);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4e45dfacb548..d4e899181bdd 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -439,6 +439,7 @@ int btf_load_into_kernel(struct btf *btf,
 			 char *log_buf, size_t log_sz, __u32 log_level,
 			 int token_fd);
 struct btf *btf_load_from_kernel(__u32 id, struct btf *base_btf, int token_fd);
+int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int token_fd);
 
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 801136ca63f0..d428b5e2600c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -1195,8 +1195,108 @@ static void test_link_api_bpf_prog(void)
 	tracing_multi_bpf__destroy(skel);
 }
 
+static void test_attach_api_bpf_prog_fails(void)
+{
+	static const char * const kfuncs[] = {
+		"bpf_fentry_test1",
+	};
+	const char *bpf_funcs[] = { "target_1" };
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	struct tracing_multi_bpf *skel = NULL;
+	int fd, target_id, token_fd;
+	int fds[2], dup_fd = -1;
+	struct bpf_link *link;
+	__u32 target_ids[2];
+	__u32 *ids = NULL;
+	long err;
+
+	skel = tracing_multi_bpf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_bpf__open_and_load"))
+		return;
+
+	ids = get_ids(kfuncs, ARRAY_SIZE(kfuncs), NULL);
+	if (!ASSERT_OK_PTR(ids, "get_ids"))
+		goto cleanup;
+
+	fds[0] = bpf_program__fd(skel->progs.target_1);
+
+	/* fail#1 (libbpf) kernel ids and BPF prog fds */
+	LIBBPF_OPTS_RESET(opts,
+		.ids = ids,
+		.fds = fds,
+		.funcs = bpf_funcs,
+		.cnt = ARRAY_SIZE(bpf_funcs),
+	);
+
+	link = bpf_program__attach_tracing_multi(skel->progs.test_fentry, NULL, &opts);
+	err = libbpf_get_error(link);
+	if (!ASSERT_EQ(err, -EINVAL, "libbpf_ids_fds")) {
+		if (!err)
+			bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	/* fail#2 (libbpf) kernel pattern and BPF prog fds */
+	LIBBPF_OPTS_RESET(opts,
+		.fds = fds,
+		.funcs = bpf_funcs,
+		.cnt = ARRAY_SIZE(bpf_funcs),
+	);
+
+	link = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_fentry_test*", &opts);
+	err = libbpf_get_error(link);
+	if (!ASSERT_EQ(err, -EINVAL, "libbpf_pattern_fds")) {
+		if (!err)
+			bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	/* fail#3 (kernel) kernel id with BPF prog fd */
+	lopts.tracing_multi.ids = ids;
+	lopts.tracing_multi.fds = fds;
+	lopts.tracing_multi.cnt = ARRAY_SIZE(bpf_funcs);
+	fd = bpf_link_create(bpf_program__fd(skel->progs.test_fentry), 0,
+			     BPF_TRACE_FENTRY_MULTI, &lopts);
+	ASSERT_EQ(fd, -EINVAL, "kernel_id_bpf_fd");
+	if (fd >= 0)
+		close(fd);
+
+	/* fail#4 (kernel) duplicate target through different fds */
+	token_fd = bpf_object__token_fd(skel->obj);
+	token_fd = token_fd < 0 ? 0 : token_fd;
+	target_id = libbpf_find_prog_btf_id("target_1", fds[0], token_fd);
+	if (!ASSERT_GT(target_id, 0, "target_1_btf_id"))
+		goto cleanup;
+
+	dup_fd = dup(fds[0]);
+	if (!ASSERT_GE(dup_fd, 0, "dup_target_fd"))
+		goto cleanup;
+
+	fds[1] = dup_fd;
+	target_ids[0] = target_id;
+	target_ids[1] = target_id;
+	lopts.tracing_multi.ids = target_ids;
+	lopts.tracing_multi.fds = fds;
+	lopts.tracing_multi.cnt = ARRAY_SIZE(fds);
+	fd = bpf_link_create(bpf_program__fd(skel->progs.test_fentry), 0,
+			     BPF_TRACE_FENTRY_MULTI, &lopts);
+	ASSERT_EQ(fd, -EINVAL, "duplicate_bpf_target");
+	if (fd >= 0)
+		close(fd);
+
+cleanup:
+	if (dup_fd >= 0)
+		close(dup_fd);
+	tracing_multi_bpf__destroy(skel);
+	free(ids);
+}
+
 void test_tracing_multi_prog_test(void)
 {
 	if (test__start_subtest("link_api"))
 		test_link_api_bpf_prog();
+	if (test__start_subtest("attach_api_fails"))
+		test_attach_api_bpf_prog_fails();
 }
-- 
2.55.0

