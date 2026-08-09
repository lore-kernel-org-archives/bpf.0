Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6483D1CB4;
	Sun,  9 Aug 2026 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287844; cv=none; b=RYPVirbxqDJVkSE9ObJLACn6xWQmV1RESaCr9VgqCxFR0nIoGovOYH9DkzBhVq0zQHO9F/Mop+d4ecyHbbbrEyXkQbYbi+eh6Ewi7i0x0xHzqcMmDRzNo2V4LNCT6EFtXKNqr0Ep9ercruLAFGVWmVaY7f6juGzA8pOx9p5i2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287844; c=relaxed/simple;
	bh=WKKvuwqoUsuRf/1ptLanZYpkM3g1G8lKnGH2y/JGobM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK7Ks8URkyLMcMyf0o0dWo3egOZ6UulP9s1WuOGko/sF+fnHDgFWOj837DbIyHjB2P7Wnk+jZZvLkLqJHrWdxHoj9eOPZA2bCEnz3eJUr/lAjToFk3Xvi0u6OqXchB/h+JWxecdpkbvE3NBXH2XZpwcEtELsVQCNw+GDjdtb3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UFhC1ofg; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UFhC1ofg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCHhS6KjGvWcXPjdrezwj/YbVHHb8dwo6y09eVtwJRc=;
	b=UFhC1ofgv6ab4Bqjcjd1QnD6gQndJKsitOYd1byDyN6bIt4ao96G1fBNhA44TqiaHOKJSx
	4U39mt7Zb34KKExceAOT8TsclRoN/9ylHwLzabBLBE6s3EC81VGfZrC3ult8dlgUlNzhdQ
	TfGacCpHbGcAiy1jsSa+kLgjF2xD3vw=
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
Subject: [PATCH bpf-next 13/13] selftests/bpf: Test tailcall with fentry.multi
Date: Sun,  9 Aug 2026 23:01:11 +0800
Message-ID: <20260809150111.45000-14-leon.hwang@linux.dev>
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

Positively verify that a tail call from a BPF subprog works when the
subprog is traced by fentry.multi.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index c5c9d6c359bb..1bef6b290f3a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -15,6 +15,7 @@
 #include "tailcall_callback.skel.h"
 #include "tailcall_bpf2bpf2.skel.h"
 #include "tailcall_bpf2bpf_fexit.skel.h"
+#include "tracing_multi_bpf.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1953,6 +1954,65 @@ static void test_tailcall_bpf2bpf_fexit_links(void)
 	tailcall_bpf2bpf2__destroy(skel_tc);
 }
 
+/*
+ * Verify that a tail call from a BPF subprog works when the subprog is
+ * traced by fentry.multi.
+ */
+static void test_tailcall_bpf2bpf_fentry_multi(void)
+{
+	struct tracing_multi_bpf *skel_tracing = NULL;
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	const char *funcs[] = { "subprog_tail" };
+	struct tailcall_bpf2bpf2 *skel_tc;
+	struct bpf_link *link = NULL;
+	int fds[ARRAY_SIZE(funcs)];
+	char buff[128] = {};
+	int err, key = 0;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = buff,
+		.data_size_in = sizeof(buff),
+		.repeat = 1,
+	);
+
+#ifndef __x86_64__
+	test__skip();
+	return;
+#endif
+
+	skel_tc = tailcall_bpf2bpf2__open_and_load();
+	if (!ASSERT_OK_PTR(skel_tc, "tailcall_bpf2bpf2__open_and_load"))
+		return;
+
+	skel_tracing = tracing_multi_bpf__open_and_load();
+	if (!ASSERT_OK_PTR(skel_tracing, "tracing_multi_bpf__open_and_load"))
+		goto out;
+
+	fds[0] = bpf_program__fd(skel_tc->progs.classifier_0);
+	err = bpf_map_update_elem(bpf_map__fd(skel_tc->maps.jmp_table), &key, &fds[0], BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	opts.fds = fds;
+	opts.funcs = funcs;
+	opts.cnt = ARRAY_SIZE(fds);
+	link = bpf_program__attach_tracing_multi(skel_tracing->progs.test_fentry, NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_tracing_multi"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel_tc->progs.entry), &topts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+		goto out;
+
+	ASSERT_EQ(topts.retval, 1, "retval");
+	ASSERT_EQ(skel_tc->bss->count, 33, "count");
+	ASSERT_EQ(skel_tracing->bss->test_result_fentry, 33, "fentry.multi count");
+
+out:
+	bpf_link__destroy(link);
+	tracing_multi_bpf__destroy(skel_tracing);
+	tailcall_bpf2bpf2__destroy(skel_tc);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -2022,4 +2082,6 @@ void test_tailcalls(void)
 	test_tailcall_callback();
 	if (test__start_subtest("tailcall_bpf2bpf_fexit_links"))
 		test_tailcall_bpf2bpf_fexit_links();
+	if (test__start_subtest("tailcall_bpf2bpf_fentry_multi"))
+		test_tailcall_bpf2bpf_fentry_multi();
 }
-- 
2.55.0

