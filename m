Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5770337B8B;
	Fri, 20 Feb 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582246; cv=none; b=tx4LXqyOyVmVWlrhUnKtA9e0bZDH9VJb4UhVqX/3pdQ6piLmwQneXK88fpRDRz6KCfxzt07vk3exoEmm2Z7XaKAiV8S42hR0z7Ogiafg3z62FwQW2U0lNL+aKhXhJxL7xiGk8n6Uxc4Gm0c10nVRSgjwxJBFguzrG37ACdk542w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582246; c=relaxed/simple;
	bh=5kZxLUUsK+4byot9lXEsgov8GWOKciSu7L2n8dBdT4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtRmSGA8fC5eZRHuUbxFv7gz8ewfJgmb7VHsgS7fZ0wIb4UAFt2yXrR/AfSEJwvOzSKR51EJQ5bXSBys+3Ahd7WDPZ5mYCec4vrIIgrmPkG+98pFamLlsZtTmh911OVCH/B9Din/JQdphTU1HVFsAn12XMNONImLU6Kwu8RIuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKwR5HrW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKwR5HrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A3DC116C6;
	Fri, 20 Feb 2026 10:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582246;
	bh=5kZxLUUsK+4byot9lXEsgov8GWOKciSu7L2n8dBdT4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKwR5HrWwIuYkVCUXHcSoevSFLD3a3wF/0GnfiOfwb3X4CApkYpAjB8eX8jGeVfqH
	 Q+8QDuGwNQMI6Bnl1E43zqYswpWMRocfhiPJL2vtfZyb95g4K+3RF2mCAEe7xZEId7
	 siTplfGr7pUilQEIkr7umUc5EwyIifIcf4aJBdy23dy1/M3J9mq/xybUV05AFUlGh1
	 2t1iU/DZCZj2+vEFKtQa9uskkgqRFqo3fVIrWPfpXvgJf8dth4SqZnGW8G0G4ZS2sz
	 HpM6GcGqtcOmdpas7Xsq5XeNVGXkLHAekdsgA+AWR/BervTCf/atMR2nweyeSHiPhU
	 qaWfUpIPlyXig==
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
Subject: [PATCH bpf-next 17/17] selftests/bpf: Add tracing multi attach benchmark test
Date: Fri, 20 Feb 2026 11:06:49 +0100
Message-ID: <20260220100649.628307-18-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220100649.628307-1-jolsa@kernel.org>
References: <20260220100649.628307-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 177 ++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_bench.c |  13 ++
 2 files changed, 190 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index ba86a88844e6..ac8ef41586f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -7,6 +7,7 @@
 #include "tracing_multi.skel.h"
 #include "tracing_multi_intersect.skel.h"
 #include "tracing_multi_session.skel.h"
+#include "tracing_multi_bench.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -394,6 +395,182 @@ static void test_attach_api_fails(void)
 	tracing_multi__destroy(skel);
 }
 
+/*
+ * Skip several kernel symbols that might not be safe or could cause delays.
+ */
+static bool skip_symbol(char *name)
+{
+	if (!strcmp(name, "arch_cpu_idle"))
+		return true;
+	if (!strcmp(name, "default_idle"))
+		return true;
+	if (!strncmp(name, "rcu_", 4))
+		return true;
+	if (!strcmp(name, "bpf_dispatcher_xdp_func"))
+		return true;
+	if (strstr(name, "rcu"))
+		return true;
+	if (strstr(name, "trace"))
+		return true;
+	if (strstr(name, "irq"))
+		return true;
+	if (strstr(name, "bpf_lsm_"))
+		return true;
+	if (!strcmp(name, "migrate_enable"))
+		return true;
+	if (!strcmp(name, "migrate_disable"))
+		return true;
+	if (!strcmp(name, "preempt_count_sub"))
+		return true;
+	if (!strcmp(name, "preempt_count_add"))
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
+	while (t && btf_type_is_modifier(t))
+		t = btf__type_by_id(btf, t->type);
+
+	if (btf_is_struct(t) || btf_is_union(t))
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
+void serial_test_tracing_multi_bench_attach(void)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tracing_multi_bench *skel = NULL;
+	size_t i, syms_cnt, cap = 0, cnt = 0;
+	long attach_start_ns, attach_end_ns;
+	long detach_start_ns, detach_end_ns;
+	double attach_delta, detach_delta;
+	struct bpf_link *link = NULL;
+	void *root = NULL;
+	__u32 *ids = NULL;
+	__u32 nr, type_id;
+	struct btf *btf;
+	char **syms;
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
+	if (!ASSERT_OK(bpf_get_ksyms(&syms, &syms_cnt, true), "get_syms"))
+		goto cleanup;
+
+	for (i = 0; i < syms_cnt; i++) {
+		if (skip_symbol(syms[i]))
+			continue;
+		tsearch(&syms[i], &root, compare);
+	}
+
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
-- 
2.52.0

