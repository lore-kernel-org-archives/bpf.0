Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66476423158;
	Wed,  3 Jun 2026 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485063; cv=none; b=HGPw9b/uBMpLu1zhg0j9pjxE5ec1wtRbpJClFFAEI2JEC01s/iPldqq5Hm1XaNzRs8lkq0Ija3GmbrNXOrafcwFUKsRWeB0XgFB6R01NW+5cmZxBm5Fsou0cWbfgpwUi0MEud5jJNvnj3B+dbsdZFVtr9LPaduu0O9a9o4wE8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485063; c=relaxed/simple;
	bh=RE4kpG7pIDJe9s8knqCPYJRzG2REtbtlwyZQ0uwXTqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvGlxQjU6Yv3EA/ljZKXXTA1713RHD2x90FKDtZmoZIxxCVxp8H4dFaC/SRgAZ4v7wJYNuJ4prsRnDOX0tnu1o1BH3+dny7V/bk6gLbeGKD+eWhrTGudMsSmp5eOdmQ6cJm2DBnP7QSxu0F4m/HDRcxW87Y4kT53aVInv3j0XVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V08PA0Sy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V08PA0Sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823391F00893;
	Wed,  3 Jun 2026 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780485062;
	bh=sBpeSa1BLbrEWZW/Hj+6risZM28vNgatp6hCEdfwVdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V08PA0SymIp2mihKe9P0P7aWb9pIhAGBL0UkQZ/gfTt3NCmLQ5yihtotOlb8TNU/s
	 Kb0Un2j0R4j0fgV1UuxBcvwiqO3UMX4XbEBB1Z/oCyTmXofETXmqMSVAArTSig3EYV
	 aUT8Gmvl31FJg7vLWDwejzBzDJwQEO0RANDqbBV2yWpVhV8si9WR9ryb0opoZx33os
	 0FwuqtHx7SU2T/ZqZNmGOy4RMF+GMvYLTF9TYDQoJZBluDhV8BBJLdZe5PDFUeYW9N
	 4RcRIpj5OsNuVq2HpVoyEcbbIAlEwDJpBgcZa4KzEqAh6KaK7PbSglx6IEOEXfo5iu
	 uK2ET7OUoGTIA==
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
Subject: [PATCHv7 bpf-next 28/29] selftests/bpf: Add tracing multi attach benchmark test
Date: Wed,  3 Jun 2026 13:05:52 +0200
Message-ID: <20260603110554.29590-29-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
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

Exporting skip_entry as is_unsafe_function and using it in the test.

Also updating trace_blacklist with ___migrate_enable to be in sync
with kernel functions deny list.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 100 ++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_bench.c |  12 +++
 tools/testing/selftests/bpf/trace_helpers.c   |   7 +-
 tools/testing/selftests/bpf/trace_helpers.h   |   1 +
 4 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 9e026f2b254d..909dd0705b15 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -10,6 +10,7 @@
 #include "tracing_multi_session.skel.h"
 #include "tracing_multi_fail.skel.h"
 #include "tracing_multi_verifier.skel.h"
+#include "tracing_multi_bench.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -593,6 +594,105 @@ static void test_attach_api_fails(void)
 	free(ids2);
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
+		if (!tsearch(&ksyms->filtered_syms[i], &root, compare)) {
+			ASSERT_FAIL("tsearch failed");
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
+	tdestroy(root, tdestroy_free_nop);
+	free_kallsyms_local(ksyms);
+	free(ids);
+	btf__free(btf);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_bench.c b/tools/testing/selftests/bpf/progs/tracing_multi_bench.c
new file mode 100644
index 000000000000..beae946cb8c4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_bench.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
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
index 0e63daf83ed5..679008b310d9 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -546,9 +546,10 @@ static const char * const trace_blacklist[] = {
 	"__rcu_read_lock",
 	"__rcu_read_unlock",
 	"bpf_get_numa_node_id",
+	"___migrate_enable",
 };
 
-static bool skip_entry(char *name)
+bool is_unsafe_function(const char *name)
 {
 	int i;
 
@@ -651,7 +652,7 @@ int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel)
 		free(name);
 		if (sscanf(buf, "%ms$*[^\n]\n", &name) != 1)
 			continue;
-		if (skip_entry(name))
+		if (is_unsafe_function(name))
 			continue;
 
 		ks = search_kallsyms_custom_local(ksyms, name, search_kallsyms_compare);
@@ -728,7 +729,7 @@ int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
 		free(name);
 		if (sscanf(buf, "%p %ms$*[^\n]\n", &addr, &name) != 2)
 			continue;
-		if (skip_entry(name))
+		if (is_unsafe_function(name))
 			continue;
 
 		if (cnt == max_cnt) {
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index d5bf1433675d..01c8ecc45627 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -63,4 +63,5 @@ int read_build_id(const char *path, char *build_id, size_t size);
 int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel);
 int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel);
 
+bool is_unsafe_function(const char *name);
 #endif
-- 
2.54.0

