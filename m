Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE42C08D0
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287798; cv=none; b=WzVnZDUWGNtWFDoOsSBH4PGvAd7WpmfJWaEC+4QaQRzyTmwicbJ5aEZE8YvVnDi1m8jBy3zrdEhq29BWC2yjHiQOHGGS58U8pcl+pHfK9PU2mC6FKWlHRIc491V40JMKHF/a14Fnl7Xk+ypWS1WxZ8OW8EoJfpb+H6trw1c2vFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287798; c=relaxed/simple;
	bh=pbHf0D/yxYYzwp2ghuYK3J09LjXB6a1N7iXNw2hCyM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffXYCNwckyJ9snlPEj0IOwI30PuOB512W2a7qr/tDu5eT+iC043nuvF+iwMzxuydpuLB196hVnqF/o/6seH8uxMjQJt7oCC6rnO4zZoYf6AMMskkwKGxtrjtb+sNc6UXE+yzJzpu8Nwb1y77kV7vXroy8annrNoIV6KiZHAKDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bsAD89zh; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bsAD89zh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5mOx5lt73FP0tlgvSP29wgB7UHvAV6W77wkgAeURVo=;
	b=bsAD89zhSA45J5+Zn50gFy+SH4eep1b9V9sv5utbiA0a4Rt3gtt/+dItjs7q88LBcYnBvS
	+yRBv9ulRtucXmcL0/9C2n8uLej/UffNfdVAlQl/TQee+857Ym6ON2zHUt4q948s0WvtMg
	bOno5/CA/jkNcvDdiITNzYM9vISBECU=
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
Subject: [PATCH bpf-next 09/13] selftests/bpf: Add tracing_multi bpf prog attach failure tests
Date: Sun,  9 Aug 2026 23:01:07 +0800
Message-ID: <20260809150111.45000-10-leon.hwang@linux.dev>
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

Tests against two libbpf failures and two kernel failures:

* libbpf: 'ids' + 'fds'.
* libbpf: 'pattern' + 'fds'.
* kernel: 'fds' + invalid 'ids'.
* kernel: duplicate targets via different fd for the same bpf prog + func.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 5ecb751af9be..5cf11707eaf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -730,6 +730,104 @@ static void test_attach_api_fails(void)
 	free(ids2);
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
 void serial_test_tracing_multi_bench_attach(void)
 {
 	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
@@ -1096,4 +1194,6 @@ void test_tracing_multi_test(void)
 		test_fentry_after_multi();
 	if (test__start_subtest("link_api_bpf_prog"))
 		test_link_api_bpf_prog();
+	if (test__start_subtest("attach_api_bpf_prog_fails"))
+		test_attach_api_bpf_prog_fails();
 }
-- 
2.55.0

