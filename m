Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8B396D1A;
	Tue,  3 Feb 2026 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111628; cv=none; b=qy5qaGzbYs1KCJ3c7hh+Xln8ywf3SG3EQE0mhmkP/NayChKQaVOKkMfjlRFYhlg4/1/nhdX1jqq3ogdPjYL22h4lt+s/pyYkIF69oLMKlpNKVOEjDe2IyuncyzXhKJUZVJASv26pklIfB89YQ3UlRjt4qoFdUMxOcDIAKrd3NaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111628; c=relaxed/simple;
	bh=+ZHesEVykn1P+ElbgsTSF6eGQQlUSGfsuH/pTf8kNXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgRAcaLo3S0KUCSMOL7wrchVKA9K5a7g0pr+PGt5pm1LLs0iH4/K18rg4PDwva0Mu9n0MLs228m7+CVPP4NkQ6cDPn08mur198P2jHbASgkmf9RtbEKSHMKa9jeYgbUQIg05WFL04qz/G12Xvhz1sM1VyFqCWPzvWYbWefo/W0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmA/Hxd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmA/Hxd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F93C116D0;
	Tue,  3 Feb 2026 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111628;
	bh=+ZHesEVykn1P+ElbgsTSF6eGQQlUSGfsuH/pTf8kNXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmA/Hxd0zDwIeg6TQdNF6iscHIuB51nFAeoiZTpFRMk1GTTS6nZW0wM5d2eu7nyJ/
	 SoaSQY/NKIsE8CTJJ1YmV2bTHmLdlxGsPbfOACwZmkv1oJjpSf4meKKXGgihYBTrrL
	 0acHTAnhSvohwk8mInIRQKlvglcC1Lq3SNsTCIYyqt+QSrvR7VQMoexNxLI1Ifcv4d
	 P3Z/QtMh1C4fQgOyYc1n51YA/Cvgb4/+PfvCsBijCLJ7AEd4QpfLRoMDV3Gbxep0wB
	 wYG+agL1ktfBg2TEybOYmhNKkhS5B0TOFNxiZS7OanG9FodqphEzHy3pKSTHu6jxV7
	 bzH6nb99+VqMg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [RFC bpf-next 12/12] selftests/bpf: Add tracing multi benchmark test
Date: Tue,  3 Feb 2026 10:38:19 +0100
Message-ID: <20260203093819.2105105-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding benchmark for attaching 20k functions.

  # ./test_progs -t tracing_multi/fentry/bench -v
  bpf_testmod.ko is already unloaded.
  Loading bpf_testmod.ko...
  Successfully loaded bpf_testmod.ko.
  multi_fentry_bench_test:PASS:btf__load_vmlinux_btf 0 nsec
  multi_fentry_bench_test:PASS:fentry_multi_skel_load 0 nsec
  multi_fentry_bench_test:PASS:get_syms 0 nsec
  multi_fentry_bench_test:PASS:bpf_program__attach_tracing_multi 0 nsec
  multi_fentry_bench_test: found 20000 functions
  multi_fentry_bench_test: attached in   0.466s
  multi_fentry_bench_test: detached in   0.066s
  #500/3   tracing_multi_test/fentry/bench:OK
  #500     tracing_multi_test:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
  Successfully unloaded bpf_testmod.ko.

I tried also for 40k:

  multi_fentry_bench_test: found 40000 functions
  multi_fentry_bench_test: attached in   0.964s
  multi_fentry_bench_test: detached in   0.170s

and for 60k (50995 of attachable functions):

  multi_fentry_bench_test: found 50995 functions
  multi_fentry_bench_test: attached in   1.256s
  multi_fentry_bench_test: detached in   0.241s

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 186 ++++++++++++++++++
 .../bpf/progs/tracing_multi_fentry.c          |   6 +
 2 files changed, 192 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 3ccf0d4ed1af..575454e31bf6 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -6,6 +6,9 @@
 #include <bpf/btf.h>
 #include <linux/btf.h>
 #include <search.h>
+#include <bpf/btf.h>
+#include <linux/btf.h>
+#include <search.h>
 #include "tracing_multi_fentry_test.skel.h"
 #include "trace_helpers.h"
 #include "bpf/libbpf_internal.h"
@@ -157,12 +160,195 @@ static void multi_fentry_intersected_test(void)
 	tracing_multi_fentry_test__destroy(skel);
 }
 
+static bool skip_entry(char *name)
+{
+	/*
+	 * We attach to almost all kernel functions and some of them
+	 * will cause 'suspicious RCU usage' when fprobe is attached
+	 * to them. Filter out the current culprits - arch_cpu_idle
+	 * default_idle and rcu_* functions.
+	 */
+	if (!strcmp(name, "arch_cpu_idle"))
+		return true;
+	if (!strcmp(name, "default_idle"))
+		return true;
+	if (!strncmp(name, "rcu_", 4))
+		return true;
+	if (!strcmp(name, "bpf_dispatcher_xdp_func"))
+		return true;
+	if (!strncmp(name, "__ftrace_invalid_address__",
+		     sizeof("__ftrace_invalid_address__") - 1))
+		return true;
+	return false;
+}
+
+#define MAX_BPF_FUNC_ARGS 12
+
+static bool btf_type_is_modifier(const struct btf_type *t)
+{
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPE_TAG:
+		return true;
+	}
+	return false;
+}
+
+static bool is_allowed_func(const struct btf *btf, const struct btf_type *t)
+{
+	const struct btf_type *proto;
+	const struct btf_param *args;
+	__u32 i, nargs;
+	__s64 ret;
+
+	proto = btf_type_by_id(btf, t->type);
+	if (BTF_INFO_KIND(proto->info) != BTF_KIND_FUNC_PROTO)
+		return false;
+
+	args = (const struct btf_param *)(proto + 1);
+	nargs = btf_vlen(proto);
+	if (nargs > MAX_BPF_FUNC_ARGS)
+		return false;
+
+	t = btf__type_by_id(btf, proto->type);
+        while (t && btf_type_is_modifier(t))
+		t = btf__type_by_id(btf, t->type);
+
+	if (btf_is_struct(t))
+		return false;
+
+	for (i = 0; i < nargs; i++) {
+		/* No support for variable args */
+		if (i == nargs - 1 && args[i].type == 0)
+			return false;
+
+		/* No support of struct argument size greater than 16 bytes */
+		ret = btf__resolve_size(btf, args[i].type);
+		if (ret < 0 || ret > 16)
+			return false;
+	}
+
+	return true;
+}
+
+static void multi_fentry_bench_test(void)
+{
+	struct tracing_multi_fentry_test *skel = NULL;
+	long attach_start_ns, attach_end_ns;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+	struct bpf_link *link = NULL;
+	size_t i, syms_cnt;
+	char **syms;
+	void *root = NULL;
+	__u32 nr, type_id;
+	struct btf *btf;
+	__u32 *ids = NULL;
+	size_t cap = 0, cnt = 0;
+	int err;
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return;
+
+	skel = tracing_multi_fentry_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_multi_skel_load"))
+		goto cleanup;
+
+	if (!ASSERT_OK(bpf_get_ksyms(&syms, &syms_cnt, true), "get_syms"))
+		goto cleanup;
+
+	for (i = 0; i < syms_cnt; i++) {
+		if (strstr(syms[i], "rcu"))
+			continue;
+		if (strstr(syms[i], "trace"))
+			continue;
+		if (strstr(syms[i], "irq"))
+			continue;
+		if (strstr(syms[i], "bpf_lsm_"))
+			continue;
+		if (!strcmp("migrate_enable", syms[i]))
+			continue;
+		if (!strcmp("migrate_disable", syms[i]))
+			continue;
+		if (!strcmp("__bpf_prog_enter_recur", syms[i]))
+			continue;
+		if (!strcmp("__bpf_prog_exit_recur", syms[i]))
+			continue;
+		if (!strcmp("preempt_count_sub", syms[i]))
+			continue;
+		if (!strcmp("preempt_count_add", syms[i]))
+			continue;
+		if (skip_entry(syms[i]))
+			continue;
+		tsearch(syms[i], &root, compare);
+	}
+
+	nr = btf__type_cnt(btf);
+	for (type_id = 1; type_id < nr && cnt < 20000; type_id++) {
+		const struct btf_type *type;
+		const char *str;
+
+		type = btf__type_by_id(btf, type_id);
+		if (!type)
+			break;
+
+		if (BTF_INFO_KIND(type->info) != BTF_KIND_FUNC)
+			continue;
+
+		str = btf__name_by_offset(btf, type->name_off);
+		if (!str)
+			break;
+
+		if (!tfind(str, &root, compare))
+			continue;
+
+		if (!is_allowed_func(btf, type))
+			continue;
+
+		err = libbpf_ensure_mem((void **) &ids, &cap, sizeof(*ids), cnt + 1);
+		if (err)
+			break;
+
+		ids[cnt++] = type_id;
+	}
+
+	opts.btf_ids = ids;
+	opts.cnt = cnt;
+
+	attach_start_ns = get_time_ns();
+	link = bpf_program__attach_tracing_multi(skel->progs.bench, NULL, &opts);
+	attach_end_ns = get_time_ns();
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	detach_start_ns = get_time_ns();
+	bpf_link__destroy(link);
+	detach_end_ns = get_time_ns();
+
+	attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
+	detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
+
+	printf("%s: found %lu functions\n", __func__, cnt);
+	printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
+	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
+
+cleanup:
+	tracing_multi_fentry_test__destroy(skel);
+}
+
 void __test_tracing_multi_test(void)
 {
 	if (test__start_subtest("fentry/simple"))
 		multi_fentry_test();
 	if (test__start_subtest("fentry/intersected"))
 		multi_fentry_intersected_test();
+	if (test__start_subtest("fentry/bench"))
+		multi_fentry_bench_test();
 }
 #else
 void __test_tracing_multi_test(void)
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c b/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
index 47857209bf9f..0f39c446792d 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
@@ -31,3 +31,9 @@ int BPF_PROG(test_2, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
 	multi_arg_check(ctx, &test_result_3);
 	return 0;
 }
+
+SEC("fentry.multi")
+int BPF_PROG(bench, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
+{
+	return 0;
+}
-- 
2.52.0

