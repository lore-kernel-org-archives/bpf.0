Received: from mta1.migadu.com (out-89.mta1.migadu.com [95.215.58.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D73C4A205C
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819957; cv=none; b=Sif/hDsm0+BuUDR30WnfVYz0OePyHg/LcULZkxr1kfASSHZiOHMBddMSgraZUwTLJT6HIs6pC/QsqWvAPmUgfVeG9JW4p4O8WS041h5CLiNIKNH3xr6GiPPsFPf1deeIHQlCS+hbzlQnN432O9dmxpECoyAsW1MaGKak038AYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819957; c=relaxed/simple;
	bh=xr2q62gwuAr1TaH+xNK4Z7LHuLNXJWJUKTZkvVQhn/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOZTaLUpHzO/m6oy6LfA0UGQBeaOGtmGXcFs1l2hPn1Nh5lJrqyK1z8WziFS86FGE15mekYOU3VrqWBELNladKFcjoppLL/NQRjwldC9R4ZlGR0/gc5i/lc40v11rixBaibDQugONJOMhXtOSQrEwfGVa0gfp0xMNBowz/7A0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G2SSSg4j; arc=none smtp.client-ip=95.215.58.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G2SSSg4j"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xr2q62gwuAr1TaH+xNK4Z7LHuLNXJWJUKTZkvVQhn/Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819953; v=1; x=1792424753;
 b=G2SSSg4j4XjD07ysl/F+6cCAXuLlLqYvxnjKBjWXA7+Rq8KZ3WRVD38dOutoyOHQh5wi83LO
 iq0muec6JO8eKd/8IMlohPZ2uwS7m1IjdLZEw8UYsoS2j4sDeW+sHnIgYQczePzp48DXUF8sjJY
 px4PyHa0J9WysATMPjQs0CWE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f9a5a2d869978260;
	Mon, 12 Oct 2026 15:45:50 +0000
X-Mizu-Trace-ID: f9a5a2d869978260
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
Subject: [PATCH bpf-next v2 20/21] selftests/bpf: Test tailcall with fentry.multi
Date: Mon, 12 Oct 2026 23:40:22 +0800
Message-ID: <20261012154024.29423-21-leon.hwang@linux.dev>
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

Positively verify that a tail call from a BPF subprog works when the
subprog is traced by fentry.multi.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 88d223110ecd..3b122520711b 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -16,7 +16,9 @@
 #include "tailcall_sleepable.skel.h"
 #include "tailcall_callback.skel.h"
 #include "tailcall_bpf2bpf2.skel.h"
+#include "tailcall_bpf2bpf4.skel.h"
 #include "tailcall_bpf2bpf_fexit.skel.h"
+#include "tracing_multi_bpf.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -2065,6 +2067,66 @@ static void test_tailcall_large_stack(void)
 	tailcall_large_stack__destroy(skel);
 }
 
+/*
+ * Verify that a tail call from a BPF subprog works when the subprog is
+ * traced by fentry.multi.
+ */
+static void test_tailcall_bpf2bpf_fentry_multi(void)
+{
+	static const char *funcs[] = { "subprog_tail_2" };
+	struct tracing_multi_bpf *skel_tracing = NULL;
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tailcall_bpf2bpf4 *skel_tc;
+	struct bpf_link *link = NULL;
+	int fds[ARRAY_SIZE(funcs)];
+	char buff[128] = {};
+	int err, key;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = buff,
+		.data_size_in = sizeof(buff),
+		.repeat = 1,
+	);
+
+	skel_tc = tailcall_bpf2bpf4__open_and_load();
+	if (!ASSERT_OK_PTR(skel_tc, "tailcall_bpf2bpf4__open_and_load"))
+		return;
+
+	skel_tracing = tracing_multi_bpf__open_and_load();
+	if (!ASSERT_OK_PTR(skel_tracing, "tracing_multi_bpf__open_and_load"))
+		goto out;
+
+	key = 0;
+	fds[0] = bpf_program__fd(skel_tc->progs.classifier_2);
+	err = bpf_map_update_elem(bpf_map__fd(skel_tc->maps.jmp_table), &key, &fds[0], BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	key = 2;
+	err = bpf_map_update_elem(bpf_map__fd(skel_tc->maps.jmp_table), &key, &fds[0], BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem_loop"))
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
+	ASSERT_EQ(topts.retval, sizeof(buff) * 3, "retval");
+	ASSERT_EQ(skel_tc->bss->count, 33, "count");
+	ASSERT_EQ(skel_tracing->bss->test_result_fentry, 33, "fentry.multi count");
+
+out:
+	bpf_link__destroy(link);
+	tracing_multi_bpf__destroy(skel_tracing);
+	tailcall_bpf2bpf4__destroy(skel_tc);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -2138,4 +2200,6 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_fexit_links();
 	if (test__start_subtest("tailcall_large_stack"))
 		test_tailcall_large_stack();
+	if (test__start_subtest("tailcall_bpf2bpf_fentry_multi"))
+		test_tailcall_bpf2bpf_fentry_multi();
 }
-- 
2.55.0

