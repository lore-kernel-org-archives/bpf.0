Received: from mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5F4BA1C0
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819910; cv=none; b=tg3YSTpET06Bj7CimOyf3xPIpHHG7lcjnOtl5sUf+vLL85aiaeZuT5MiAQ0aOMFR6IAm9ajd9FQlYSeRMh1VLUDrwqT8bmssjSj3F1EMg5PCa3sEpfGZwKtyynU/v8wExr+vfTvjwOgW837943bWOScLoi4oTkl7OtpIhpFx2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819910; c=relaxed/simple;
	bh=iYGND2Phovkpnc8NFgXX6BxxlEoo3t8U7wl1IZgzMRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJvolF/dj9f9DKIYcRLFkXWwcSuD1JObFJA8pFLDvQUKAP6QRoTgE0RyPxj8zavu2quE+3lndMybi21jRkkB/K1iFkvR7tbI3E38KMIM2ITF6qW+aztRp6EC2juEVKMEh+EzgFB5JTwBERDA+zzM2+KVzIZ3xxqCw8+/P6L8olc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hD0HnCYd; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hD0HnCYd"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iYGND2Phovkpnc8NFgXX6BxxlEoo3t8U7wl1IZgzMRA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819907; v=1; x=1792424707;
 b=hD0HnCYdXuJkvFmAt1Zu6hPQ6qAWaGXym2+IfKUM9HZeO3VXONws6N5wvg+zPxaNWUWsxWtM
 PzyprMREOHfkpoBGZ1sJuH1pzl+IGR69a8Un6cqKZWVvwVX4Ska+ABoDr+1IB3o6fat9dvDxVdD
 InXW1Z3Yt3i9tKz6KG697N50=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 79b25d8d11a8d0a4;
	Mon, 12 Oct 2026 15:45:07 +0000
X-Mizu-Trace-ID: 79b25d8d11a8d0a4
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
Subject: [PATCH bpf-next v2 18/21] selftests/bpf: Add tracing_multi bpf prog rollback test
Date: Mon, 12 Oct 2026 23:40:20 +0800
Message-ID: <20261012154024.29423-19-leon.hwang@linux.dev>
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

When rollbacking, the prepared trampolines should be reverted.

In this test, the first bpf prog will be attached with the trampoline, and
the second bpf prog won't be attached because the bpf prog has been
attached by a fentry.multi prog, that causes the rollback procedure.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index bcf933760bc5..dfa24e229ff7 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -1308,6 +1308,67 @@ static void test_attach_api_bpf_prog_fails(void)
 	free(ids);
 }
 
+static void test_rollback_bpf_prog(void)
+{
+	int token_fd, prog_fd, fd = -1, pre_fd = -1;
+	LIBBPF_OPTS(bpf_link_create_opts, lopts);
+	struct tracing_multi_bpf *skel = NULL;
+	__u32 target_ids[2], ids[2];
+	int target_fds[2], fds[2];
+	struct bpf_program *prog;
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
+	prog = first == 0 ? skel->progs.target_1 : skel->progs.target_2;
+	if (run_bpf_target(prog, first + 1, "rollback_target"))
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
 void test_tracing_multi_prog_test(void)
 {
 	if (test__start_subtest("link_api"))
@@ -1316,4 +1377,6 @@ void test_tracing_multi_prog_test(void)
 		test_attach_api_bpf_prog_fails();
 	if (test__start_subtest("cookies"))
 		test_link_api_bpf_prog(true);
+	if (test__start_subtest("rollback"))
+		test_rollback_bpf_prog();
 }
-- 
2.55.0

