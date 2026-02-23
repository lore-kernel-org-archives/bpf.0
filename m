Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D336A03B
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873706; cv=none; b=dEyOQAxScCuMezraERptT0w1GC+qseaCPNHAbeE/LeRVz7yKSFrE/EgZplDBp/lp0eerdGg1V2pYEZ39pb0GPtsoCGhq3HqlW7wMwQT75R2jUCAOkuCK/7wmaogBIewVKvMmwiM7tOWcgit8T0tbjAf0hkG2xCjXYpMckkMgJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873706; c=relaxed/simple;
	bh=f0olX1HLohMdoDBpNwTJTJD4HwX/HbTAm9QCIGCNLLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMcVjR9B5P8H9yfA8x+fnVYQytmU81L7NSNTRFH/1Gkp26WhNLzLj933EibC4PumL/PI46EZzMR/Dfyy/kdocdvyIHjL78+EugnHpyaMf9JiS97vuoVCcM7bG4kz8uCmGmim2jfPvNwUbGsV0mB4QMOqFyp4Gu7TBxrAtERtdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=muR9gJ1m; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="muR9gJ1m"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQoMYze3DoKvqQ5P13/nXDg2u8X/q4xJEyhjtX/DYfw=;
	b=muR9gJ1msQn7Sd0qZkRAiEeONL67d7uz4r2Oz/Sh2S6age4irHq6d4SXDScRT8k+ph4yzx
	sWDtiusgZLvrF5db8sRx2YTks1MrAjcFsps81KzHhVFRizvs8IMIPsR0HYAJhINXbNNYaU
	NuTTX0F8YYmT22qHpCLl7jaHV677jF4=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v4 09/20] selftests/bpf: Refactor bpf_get_ksyms() trace helper
Date: Mon, 23 Feb 2026 11:07:25 -0800
Message-ID: <20260223190736.649171-10-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ASAN reported a memory leak in bpf_get_ksyms(): it allocates a struct
ksyms internally and never frees it.

Move struct ksyms to trace_helpers.h and return it from the
bpf_get_ksyms(), giving ownership to the caller. Add filtered_syms and
filtered_cnt fields to the ksyms to hold the filtered array of
symbols, previously returned by bpf_get_ksyms().

Fixup the call sites: kprobe_multi_test and bench_trigger.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/benchs/bench_trigger.c      | 14 ++++++-----
 .../bpf/prog_tests/kprobe_multi_test.c        | 12 ++++------
 tools/testing/selftests/bpf/trace_helpers.c   | 23 ++++++++++---------
 tools/testing/selftests/bpf/trace_helpers.h   | 11 +++++++--
 4 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index aeec9edd3851..f74b313d6ae4 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -230,8 +230,8 @@ static void trigger_fentry_setup(void)
 static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
-	char **syms = NULL;
-	size_t cnt = 0;
+	struct bpf_link *link = NULL;
+	struct ksyms *ksyms = NULL;
 
 	/* Some recursive functions will be skipped in
 	 * bpf_get_ksyms -> skip_entry, as they can introduce sufficient
@@ -241,16 +241,18 @@ static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
 	 * So, don't run the kprobe-multi-all and kretprobe-multi-all on
 	 * a debug kernel.
 	 */
-	if (bpf_get_ksyms(&syms, &cnt, true)) {
+	if (bpf_get_ksyms(&ksyms, true)) {
 		fprintf(stderr, "failed to get ksyms\n");
 		exit(1);
 	}
 
-	opts.syms = (const char **) syms;
-	opts.cnt = cnt;
+	opts.syms = (const char **)ksyms->filtered_syms;
+	opts.cnt = ksyms->filtered_cnt;
 	opts.retprobe = kretprobe;
 	/* attach empty to all the kernel functions except bpf_get_numa_node_id. */
-	if (!bpf_program__attach_kprobe_multi_opts(empty, NULL, &opts)) {
+	link = bpf_program__attach_kprobe_multi_opts(empty, NULL, &opts);
+	free_kallsyms_local(ksyms);
+	if (!link) {
 		fprintf(stderr, "failed to attach bpf_program__attach_kprobe_multi_opts to all\n");
 		exit(1);
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 9caef222e528..f81dcd609ee9 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -456,25 +456,23 @@ static void test_kprobe_multi_bench_attach(bool kernel)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
 	struct kprobe_multi_empty *skel = NULL;
-	char **syms = NULL;
-	size_t cnt = 0;
+	struct ksyms *ksyms = NULL;
 
-	if (!ASSERT_OK(bpf_get_ksyms(&syms, &cnt, kernel), "bpf_get_ksyms"))
+	if (!ASSERT_OK(bpf_get_ksyms(&ksyms, kernel), "bpf_get_ksyms"))
 		return;
 
 	skel = kprobe_multi_empty__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
 		goto cleanup;
 
-	opts.syms = (const char **) syms;
-	opts.cnt = cnt;
+	opts.syms = (const char **)ksyms->filtered_syms;
+	opts.cnt = ksyms->filtered_cnt;
 
 	do_bench_test(skel, &opts);
 
 cleanup:
 	kprobe_multi_empty__destroy(skel);
-	if (syms)
-		free(syms);
+	free_kallsyms_local(ksyms);
 }
 
 static void test_kprobe_multi_bench_attach_addr(bool kernel)
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index eeaab7013ca2..0e63daf83ed5 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -24,12 +24,6 @@
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
-struct ksyms {
-	struct ksym *syms;
-	size_t sym_cap;
-	size_t sym_cnt;
-};
-
 static struct ksyms *ksyms;
 static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
 
@@ -54,6 +48,8 @@ void free_kallsyms_local(struct ksyms *ksyms)
 	if (!ksyms)
 		return;
 
+	free(ksyms->filtered_syms);
+
 	if (!ksyms->syms) {
 		free(ksyms);
 		return;
@@ -610,7 +606,7 @@ static int search_kallsyms_compare(const void *p1, const struct ksym *p2)
 	return compare_name(p1, p2->name);
 }
 
-int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
+int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel)
 {
 	size_t cap = 0, cnt = 0;
 	char *name = NULL, *ksym_name, **syms = NULL;
@@ -637,8 +633,10 @@ int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
 	else
 		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
 
-	if (!f)
+	if (!f) {
+		free_kallsyms_local(ksyms);
 		return -EINVAL;
+	}
 
 	map = hashmap__new(symbol_hash, symbol_equal, NULL);
 	if (IS_ERR(map)) {
@@ -679,15 +677,18 @@ int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
 		syms[cnt++] = ksym_name;
 	}
 
-	*symsp = syms;
-	*cntp = cnt;
+	ksyms->filtered_syms = syms;
+	ksyms->filtered_cnt = cnt;
+	*ksymsp = ksyms;
 
 error:
 	free(name);
 	fclose(f);
 	hashmap__free(map);
-	if (err)
+	if (err) {
 		free(syms);
+		free_kallsyms_local(ksyms);
+	}
 	return err;
 }
 
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index a5576b2dfc26..d5bf1433675d 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -23,7 +23,14 @@ struct ksym {
 	long addr;
 	char *name;
 };
-struct ksyms;
+
+struct ksyms {
+	struct ksym *syms;
+	size_t sym_cap;
+	size_t sym_cnt;
+	char **filtered_syms;
+	size_t filtered_cnt;
+};
 
 typedef int (*ksym_cmp_t)(const void *p1, const void *p2);
 typedef int (*ksym_search_cmp_t)(const void *p1, const struct ksym *p2);
@@ -53,7 +60,7 @@ ssize_t get_rel_offset(uintptr_t addr);
 
 int read_build_id(const char *path, char *build_id, size_t size);
 
-int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel);
+int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel);
 int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel);
 
 #endif
-- 
2.53.0

