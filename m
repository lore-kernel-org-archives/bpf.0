Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49624E4AF;
	Mon, 16 Mar 2026 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647751; cv=none; b=GfyWDf6mkFZUqkEzAST58+QQhFddSo7HFehWPeMy2e8mKG0w7G8Mq6CI1CbSV+Nq0EcCSI4mqQXgN48IUl2klVeRVJ49t6H4v6A5AgHYoygv5by906a+i5F4ej9AqB29b/PGw7ojyTU7KINeeXACb+LFf4L3ZA30Iz6/Ck9B8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647751; c=relaxed/simple;
	bh=AwWBniNqpSfO+DQWGXbsROCxdQOi0bapmhK+7DMp3f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj5TDR2LMKVkCssz46FeVaq6qq/Okvtx2+sXu1kf++jnVbzFq+6PSnh44c34xDWz4fP9oSB5XGuhhlB/BqXEyu1+61A/M4Vs38CosqyR+QxYTYKVg4fX08pz8b5nqO9qJCWDsVjKaP7mbXyb1EZwjISaUpfEIvea/gfP201/kcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt23J+Mw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt23J+Mw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51325C19421;
	Mon, 16 Mar 2026 07:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647751;
	bh=AwWBniNqpSfO+DQWGXbsROCxdQOi0bapmhK+7DMp3f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gt23J+Mws/PshWqF8YJdWUQTNUcKruzn55SrD9DYjO2FpnglsYaVFCQA68HzubSHa
	 Xl4cPTgz2yv09pq4se0UR7QkxeyvCp4embQoPfdaNNpQiYeAqk2dRAxSF68MAcsNhF
	 9AZJnv9mf0x9Y9r6AzDhATgtRE3Ybaztep/Fa2PmIJUcYU6LyS3IGrKTq2GBTJeDz+
	 w4ZodhG74Eftqbfj4KCzE7k1bo8glfwfij/np9PWj/0iYYLb8gBul8bXZvQDXPQ1pr
	 fkS4TIKnJop7mYxP6+9PXoyBtg7+erQU2PyhMNKaAj986ldmhd01ecUPlfw6oWIjgF
	 ChJMY/PaK86OA==
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
Subject: [PATCHv3 bpf-next 23/24] selftests/bpf: Add tracing multi attach benchmark test
Date: Mon, 16 Mar 2026 08:51:37 +0100
Message-ID: <20260316075138.465430-24-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316075138.465430-1-jolsa@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding benchmark test that attaches to (almost) all allowed tracing
functions and display attach/detach times.

  # ./test_progs -t tracing_multi_bench_attach -v
  bpf_testmod.ko is already unloaded.
  Loading bpf_testmod.ko...
  Successfully loaded bpf_testmod.ko.
  serial_test_tracing_multi_bench_attach:PASS:btf__load_vmlinux_btf 0 nsec
  serial_test_tracing_multi_bench_attach:PASS:tracing_multi_bench__open_and_load 0 nsec
  serial_test_tracing_multi_bench_attach:PASS:get_syms 0 nsec
  serial_test_tracing_multi_bench_attach:PASS:bpf_program__attach_tracing_multi 0 nsec
  serial_test_tracing_multi_bench_attach: found 51186 functions
  serial_test_tracing_multi_bench_attach: attached in   1.295s
  serial_test_tracing_multi_bench_attach: detached in   0.243s
  #507     tracing_multi_bench_attach:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
  Successfully unloaded bpf_testmod.ko.

Exporting skip_entry as is_unsafe_function and usign it in the test.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 97 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_bench.c | 13 +++
 tools/testing/selftests/bpf/trace_helpers.c   |  6 +-
 tools/testing/selftests/bpf/trace_helpers.h   |  1 +
 4 files changed, 114 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 9f4c5af88e21..a0fcda51bb6c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -9,6 +9,7 @@
 #include "tracing_multi_intersect.skel.h"
 #include "tracing_multi_session.skel.h"
 #include "tracing_multi_fail.skel.h"
+#include "tracing_multi_bench.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -552,6 +553,102 @@ static void test_attach_api_fails(void)
 	tracing_multi_fail__destroy(skel);
 }
 
+void serial_test_tracing_multi_bench_attach(void)
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
+	__u32 *ids = NULL;
+	__u32 nr, type_id;
+	struct btf *btf;
+	int err;
+
+#ifndef __x86_64__
+	test__skip();
+	return;
+#endif
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return;
+
+	skel = tracing_multi_bench__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_bench__open_and_load"))
+		goto cleanup;
+
+	if (!ASSERT_OK(bpf_get_ksyms(&ksyms, true), "get_syms"))
+		goto cleanup;
+
+	/* Get all ftrace 'safe' symbols.. */
+	for (i = 0; i < ksyms->filtered_cnt; i++) {
+		if (is_unsafe_function(ksyms->filtered_syms[i]))
+			continue;
+		tsearch(&ksyms->filtered_syms[i], &root, compare);
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
+		if (!btf_type_is_traceable_func(btf, type))
+			continue;
+
+		err = libbpf_ensure_mem((void **) &ids, &cap, sizeof(*ids), cnt + 1);
+		if (err)
+			goto cleanup;
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
+	tracing_multi_bench__destroy(skel);
+	free_kallsyms_local(ksyms);
+	free(ids);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_bench.c b/tools/testing/selftests/bpf/progs/tracing_multi_bench.c
new file mode 100644
index 000000000000..067ba668489b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_bench.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fentry.multi")
+int BPF_PROG(bench)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 0e63daf83ed5..3bf600f3271b 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -548,7 +548,7 @@ static const char * const trace_blacklist[] = {
 	"bpf_get_numa_node_id",
 };
 
-static bool skip_entry(char *name)
+bool is_unsafe_function(char *name)
 {
 	int i;
 
@@ -651,7 +651,7 @@ int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel)
 		free(name);
 		if (sscanf(buf, "%ms$*[^\n]\n", &name) != 1)
 			continue;
-		if (skip_entry(name))
+		if (is_unsafe_function(name))
 			continue;
 
 		ks = search_kallsyms_custom_local(ksyms, name, search_kallsyms_compare);
@@ -728,7 +728,7 @@ int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
 		free(name);
 		if (sscanf(buf, "%p %ms$*[^\n]\n", &addr, &name) != 2)
 			continue;
-		if (skip_entry(name))
+		if (is_unsafe_function(name))
 			continue;
 
 		if (cnt == max_cnt) {
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index d5bf1433675d..d93be322675d 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -63,4 +63,5 @@ int read_build_id(const char *path, char *build_id, size_t size);
 int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel);
 int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel);
 
+bool is_unsafe_function(char *name);
 #endif
-- 
2.53.0

