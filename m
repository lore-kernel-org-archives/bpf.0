Received: from out-161.mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0A3F9F47
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858538; cv=none; b=eLydu8wW52mRyg901gOBiw+RkpxI4RCPYZBifPDbSCpf/utSqtNJyl6CMBr4Rf/bXgt6Uc9mJMHM5toSdqtxwGe90DxCcYYR/KeusOvcVO3b+yS46bL04QmNe7fZlQ7DxGv9QLEHAF8k+G6rOgj015fg9giAPA1DqUNJCOopneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858538; c=relaxed/simple;
	bh=32A8xEKr+zqIAfCyJkQrNb+SZ2aAWrvydlIzb0zbTG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGkCnlT4kz33CO34qV5rv+x2vKrHBSMXarhN1ZU6pjY2BG2G5IGfykpVt5ZsX0qfPI0cDVe6ebl1TDfoEnJ6sacNm7IuHdojmrYTXqx28FeNC4qaycQpzTj/W4v6ksI6OyjY2O4ZeYii+nSp2tHQOlLt0exs5TY/8FAbjFGgyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jxYvMOGN; arc=none smtp.client-ip=95.215.58.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jxYvMOGN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785858534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dkzdAtAisiys2/EH9u88ln0pLuo2qppZ6QXDL8+5GZI=;
	b=jxYvMOGNCaIJs+fEfZhYc8zmiv5Yxo+G8jC6bVZh+fFHuHjMzMM2Lf6p8ZuPcZLp1L7qPs
	mXV/HpOzT8siUCsltGqPn/Y64kSoZOAehAa6DuITJP+9Zn0ypRJnTkxPziV8SohQQ/gwVQ
	Dm7TmyX1bvR4A3yW2crOeM/i5BSyWXM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Move tracing_multi_bench_attach to bench
Date: Tue,  4 Aug 2026 23:48:13 +0800
Message-ID: <20260804154813.90795-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In CI, the tracing_multi_bench_attach test could cost >10s, which should
be avoided in daily CI running.

 ./test_progs -t tracing_multi_bench_attach -v
 WATCHDOG: test case tracing_multi_bench_attach executes for 10 seconds...
 serial_test_tracing_multi_bench_attach: found 40163 functions
 serial_test_tracing_multi_bench_attach: attached in   9.367s
 serial_test_tracing_multi_bench_attach: detached in   1.798s
 #546     tracing_multi_bench_attach:OK

Since it is for benchmark attachment of tracing_multi link, move it to
the generic bench framework.

 ./bench tracing-multi-attach
 Setting up benchmark 'tracing-multi-attach'...
 tracing-multi-attach: found 40166 functions
 tracing-multi-attach: attached in   9.278s
 tracing-multi-attach: detached in   1.836s

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../bpf/benchs/bench_tracing_multi_attach.c   | 177 ++++++++++++++++++
 .../selftests/bpf/prog_tests/tracing_multi.c  | 125 -------------
 4 files changed, 181 insertions(+), 125 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 55d394438705..e4d8cbd51d71 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -966,6 +966,7 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
 $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
 $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
 $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
+$(OUTPUT)/bench_tracing_multi_attach.o: $(OUTPUT)/tracing_multi_bench.skel.h
 $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_update_bench.skel.h
 $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tasks_trace_bench.skel.h
@@ -991,6 +992,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bloom_filter_map.o \
 		 $(OUTPUT)/bench_bpf_loop.o \
 		 $(OUTPUT)/bench_strncmp.o \
+		 $(OUTPUT)/bench_tracing_multi_attach.o \
 		 $(OUTPUT)/bench_bpf_hashmap_full_update.o \
 		 $(OUTPUT)/bench_local_storage.o \
 		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 3d9d2cd7764b..5ce31459835c 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -545,6 +545,7 @@ extern const struct bench bench_trig_uprobe_multi_nop5;
 extern const struct bench bench_trig_uretprobe_multi_nop5;
 extern const struct bench bench_trig_usdt_nop;
 extern const struct bench bench_trig_usdt_nop5;
+extern const struct bench bench_tracing_multi_attach;
 #endif
 
 extern const struct bench bench_rb_libbpf;
@@ -628,6 +629,7 @@ static const struct bench *benchs[] = {
 	&bench_trig_uretprobe_multi_nop5,
 	&bench_trig_usdt_nop,
 	&bench_trig_usdt_nop5,
+	&bench_tracing_multi_attach,
 #endif
 	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
diff --git a/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach.c b/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach.c
new file mode 100644
index 000000000000..7389d1742ddc
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <search.h>
+#include <stdio.h>
+#include <string.h>
+#include <bpf/btf.h>
+#include "bench.h"
+#include "testing_helpers.h"
+#include "trace_helpers.h"
+#include "tracing_multi_bench.skel.h"
+#include "bpf/libbpf_internal.h"
+
+static int compare(const void *ppa, const void *ppb)
+{
+	const char *pa = *(const char **)ppa;
+	const char *pb = *(const char **)ppb;
+
+	return strcmp(pa, pb);
+}
+
+static void tdestroy_free_nop(void *ptr)
+{
+}
+
+static void tracing_multi_attach_setup(void)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tracing_multi_bench *skel = NULL;
+	long attach_start_ns, attach_end_ns;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+	struct bpf_link *link = NULL;
+	size_t i, cap = 0, cnt = 0;
+	struct ksyms *ksyms = NULL;
+	void *root = NULL;
+	void *dups = NULL;
+	__u32 *ids = NULL;
+	__u32 nr, type_id;
+	struct btf *btf;
+	int err;
+
+	setup_libbpf();
+
+	btf = btf__load_vmlinux_btf();
+	err = libbpf_get_error(btf);
+	if (err) {
+		btf = NULL;
+		fprintf(stderr, "failed to load vmlinux BTF: %s\n", strerror(-err));
+		goto cleanup;
+	}
+
+	skel = tracing_multi_bench__open_and_load();
+	err = libbpf_get_error(skel);
+	if (!skel) {
+		fprintf(stderr, "failed to open and load skeleton: %s\n", strerror(-err));
+		goto cleanup;
+	}
+
+	err = bpf_get_ksyms(&ksyms, true);
+	if (err) {
+		fprintf(stderr, "failed to get kernel symbols: %s\n", strerror(-err));
+		goto cleanup;
+	}
+
+	/* Get all ftrace 'safe' symbols.. */
+	for (i = 0; i < ksyms->filtered_cnt; i++) {
+		if (!tsearch(&ksyms->filtered_syms[i], &root, compare)) {
+			err = -ENOMEM;
+			fprintf(stderr, "failed to index ftrace symbols\n");
+			goto cleanup;
+		}
+	}
+
+	/*
+	 * Collect names that are not unique in kallsyms. The kernel resolves a
+	 * tracing-multi BTF id to an address with kallsyms_lookup_name(), which
+	 * returns the first symbol of that name. For a duplicate name that may
+	 * be a different (non-ftrace-able) instance than the ftrace-able one in
+	 * available_filter_functions, so attaching to it by BTF id fails with
+	 * -ENOENT (e.g. t_start/t_next/t_stop). ksyms->syms is sorted by name,
+	 * so equal names are adjacent.
+	 */
+	for (i = 1; i < ksyms->sym_cnt; i++) {
+		if (strcmp(ksyms->syms[i].name, ksyms->syms[i - 1].name))
+			continue;
+		if (!tsearch(&ksyms->syms[i].name, &dups, compare)) {
+			err = -ENOMEM;
+			fprintf(stderr, "failed to index duplicate kernel symbols\n");
+			goto cleanup;
+		}
+	}
+
+	/* ..and filter them through BTF and btf_type_is_traceable_func. */
+	nr = btf__type_cnt(btf);
+	for (type_id = 1; type_id < nr; type_id++) {
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
+		if (!tfind(&str, &root, compare))
+			continue;
+
+		/* Skip names that are not unique in kallsyms, see above. */
+		if (tfind(&str, &dups, compare))
+			continue;
+
+		if (!btf_type_is_traceable_func(btf, type))
+			continue;
+
+		err = libbpf_ensure_mem((void **)&ids, &cap, sizeof(*ids), cnt + 1);
+		if (err) {
+			fprintf(stderr, "failed to allocate BTF ID array: %s\n",
+				strerror(-err));
+			goto cleanup;
+		}
+
+		ids[cnt++] = type_id;
+	}
+
+	opts.ids = ids;
+	opts.cnt = cnt;
+
+	attach_start_ns = get_time_ns();
+	link = bpf_program__attach_tracing_multi(skel->progs.bench, NULL, &opts);
+	attach_end_ns = get_time_ns();
+
+	err = libbpf_get_error(link);
+	if (err) {
+		link = NULL;
+		fprintf(stderr, "failed to attach tracing multi link: %s\n",
+			strerror(-err));
+		goto cleanup;
+	}
+
+	detach_start_ns = get_time_ns();
+	err = bpf_link__destroy(link);
+	detach_end_ns = get_time_ns();
+	link = NULL;
+	if (err) {
+		fprintf(stderr, "failed to detach tracing multi link: %s\n",
+			strerror(-err));
+		goto cleanup;
+	}
+
+	attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
+	detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
+
+	printf("%s: found %zu functions\n", bench->name, cnt);
+	printf("%s: attached in %7.3lfs\n", bench->name, attach_delta);
+	printf("%s: detached in %7.3lfs\n", bench->name, detach_delta);
+
+cleanup:
+	bpf_link__destroy(link);
+	tracing_multi_bench__destroy(skel);
+	tdestroy(root, tdestroy_free_nop);
+	tdestroy(dups, tdestroy_free_nop);
+	free_kallsyms_local(ksyms);
+	free(ids);
+	btf__free(btf);
+
+	exit(err ? 1 : 0);
+}
+
+const struct bench bench_tracing_multi_attach = {
+	.name = "tracing-multi-attach",
+	.setup = tracing_multi_attach_setup,
+};
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 0aa9532a05cf..fd4f256d2e0a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -3,14 +3,12 @@
 #include <test_progs.h>
 #include <bpf/btf.h>
 #include <search.h>
-#include "bpf/libbpf_internal.h"
 #include "tracing_multi.skel.h"
 #include "tracing_multi_module.skel.h"
 #include "tracing_multi_intersect.skel.h"
 #include "tracing_multi_session.skel.h"
 #include "tracing_multi_fail.skel.h"
 #include "tracing_multi_verifier.skel.h"
-#include "tracing_multi_bench.skel.h"
 #include "tracing_multi_rollback.skel.h"
 #include "trace_helpers.h"
 
@@ -662,129 +660,6 @@ static void test_attach_api_fails(void)
 	free(ids2);
 }
 
-void serial_test_tracing_multi_bench_attach(void)
-{
-	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
-	struct tracing_multi_bench *skel = NULL;
-	long attach_start_ns, attach_end_ns;
-	long detach_start_ns, detach_end_ns;
-	double attach_delta, detach_delta;
-	struct bpf_link *link = NULL;
-	size_t i, cap = 0, cnt = 0;
-	struct ksyms *ksyms = NULL;
-	void *root = NULL;
-	void *dups = NULL;
-	__u32 *ids = NULL;
-	__u32 nr, type_id;
-	struct btf *btf;
-	int err;
-
-#ifndef __x86_64__
-	test__skip();
-	return;
-#endif
-
-	btf = btf__load_vmlinux_btf();
-	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
-		return;
-
-	skel = tracing_multi_bench__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "tracing_multi_bench__open_and_load"))
-		goto cleanup;
-
-	if (!ASSERT_OK(bpf_get_ksyms(&ksyms, true), "get_syms"))
-		goto cleanup;
-
-	/* Get all ftrace 'safe' symbols.. */
-	for (i = 0; i < ksyms->filtered_cnt; i++) {
-		if (!tsearch(&ksyms->filtered_syms[i], &root, compare)) {
-			ASSERT_FAIL("tsearch failed");
-			goto cleanup;
-		}
-	}
-
-	/*
-	 * Collect names that are not unique in kallsyms. The kernel resolves a
-	 * tracing-multi BTF id to an address with kallsyms_lookup_name(), which
-	 * returns the first symbol of that name. For a duplicate name that may
-	 * be a different (non-ftrace-able) instance than the ftrace-able one in
-	 * available_filter_functions, so attaching to it by BTF id fails with
-	 * -ENOENT (e.g. t_start/t_next/t_stop). ksyms->syms is sorted by name,
-	 * so equal names are adjacent.
-	 */
-	for (i = 1; i < ksyms->sym_cnt; i++) {
-		if (strcmp(ksyms->syms[i].name, ksyms->syms[i - 1].name))
-			continue;
-		if (!tsearch(&ksyms->syms[i].name, &dups, compare)) {
-			ASSERT_FAIL("tsearch failed");
-			goto cleanup;
-		}
-	}
-
-	/* ..and filter them through BTF and btf_type_is_traceable_func. */
-	nr = btf__type_cnt(btf);
-	for (type_id = 1; type_id < nr; type_id++) {
-		const struct btf_type *type;
-		const char *str;
-
-		type = btf__type_by_id(btf, type_id);
-		if (!type)
-			break;
-
-		if (BTF_INFO_KIND(type->info) != BTF_KIND_FUNC)
-			continue;
-
-		str = btf__name_by_offset(btf, type->name_off);
-		if (!str)
-			break;
-
-		if (!tfind(&str, &root, compare))
-			continue;
-
-		/* Skip names that are not unique in kallsyms, see above. */
-		if (tfind(&str, &dups, compare))
-			continue;
-
-		if (!btf_type_is_traceable_func(btf, type))
-			continue;
-
-		err = libbpf_ensure_mem((void **) &ids, &cap, sizeof(*ids), cnt + 1);
-		if (err)
-			goto cleanup;
-
-		ids[cnt++] = type_id;
-	}
-
-	opts.ids = ids;
-	opts.cnt = cnt;
-
-	attach_start_ns = get_time_ns();
-	link = bpf_program__attach_tracing_multi(skel->progs.bench, NULL, &opts);
-	attach_end_ns = get_time_ns();
-
-	if (!ASSERT_OK_PTR(link, "bpf_program__attach_tracing_multi"))
-		goto cleanup;
-
-	detach_start_ns = get_time_ns();
-	bpf_link__destroy(link);
-	detach_end_ns = get_time_ns();
-
-	attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
-	detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
-
-	printf("%s: found %lu functions\n", __func__, cnt);
-	printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
-	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
-
-cleanup:
-	tracing_multi_bench__destroy(skel);
-	tdestroy(root, tdestroy_free_nop);
-	tdestroy(dups, tdestroy_free_nop);
-	free_kallsyms_local(ksyms);
-	free(ids);
-	btf__free(btf);
-}
-
 static void tracing_multi_rollback_run(struct tracing_multi_rollback *skel)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
-- 
2.55.0

