Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447769;
	b=qY9u9t1JGn8inCDak6wpWoBFOXhcbaILWNV/w7Gau29yGz5eiFPeSXISqCM3bcrHYpVL
	 r4S00dD8rTIgLYVGHpj6atqONEjuPxLounSA2DY899T5TVglzetGTiWOrR7+EDT2JKjHC
	 dFSHa7kwtbaeERpM4iJB+oOtnNEwEHpJOKXGOFnnv/NLMQKdgxjtdvY9qGHFD2aUzwX2g
	 iQZOU5vgSnWl+WcexZapD39EDx+zEON8SPXR9ylwSOzNumQsHfMd6PBJYasMNDoF2Xiu2
	 +WEtEseasDcg3vT0L7d7jGx+uj1VSBhykrqipr10hmAthbhrdGomDgXjn+W/NAM/r2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447769;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H6PziSLqPTzS9HBPfg5QQ/gEygKMc5DzRkKWa0XTeR0=;
	b=oRTXszo9c4hHB5a6Q/eXl6whFqvtU/ej/CdgQupX57qtHBDb+nwfTzE5RmOq84IH6A6+
	 sMvVXLhTfOHTdh+MnYje8MQp0bgEI/8Www6/IRMUplrr6HpnYHKV1k8cvHylYhAeU+QUJ
	 GLnVKMSukDYguxCHcLueeJw4fHEWJ057CsFeY1Y8WWH7we9oVoIzMPWZ611xiZoNIhduC
	 xrufNQqLkgTOxKBqwlR296Dp9Y6zw3Albyy0JGudF+BtXAEP5rPIqnmKDq+dUvW7zj5y+
	 9Ty6BCKZmN+NYL8wpKhtcJwSWlbKLPvaMwo5R42vhKvkfyq+oGgc1sW0hffcAhxrLmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Bw9P6O5h;
	arc=none smtp.remote-ip=91.218.175.235
Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA7606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDEA7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Bw9P6O5h
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jdK8DOtnkkfscOqrQ68q/uc2xuxHiXyMXu2IRA4cCmA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795447766; v=1; x=1796052566;
 b=Bw9P6O5hengPhRymQOHtU+m4nLS1toQz36sXhnWEm0Qg2XuwZ/w5jkML3BR0SnvJaFpCshQA
 DhnKODywpKL2VWKeJZvjNchrw2HNM0yNIoGuUrofLqVlC0uDF8wXZdnCDZ4vVeWJ0iHvH6fvC1J
 oVHwHWajjzdbW5/gZ1vfeL2o=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 007334bf78bc86a7;
	Mon, 23 Nov 2026 15:29:26 +0000
X-Mizu-Trace-ID: 007334bf78bc86a7
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 7/9] selftests/bpf: Test tracing_multi link_create logs
Date: Mon, 23 Nov 2026 23:27:41 +0800
Message-ID: <20261123152743.19629-8-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123152743.19629-1-leon.hwang@linux.dev>
References: <20261123152743.19629-1-leon.hwang@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the errno, log message and reported log size when tracing_multi
link creation rejects invalid parameters, duplicate IDs or a target.

Cover invalid BTF IDs and types, unsupported prototypes, noreturn
FEXIT_MULTI targets, targets whose addresses cannot be resolved, targets
without an ftrace location, and sleepable attachment restrictions. Check
the diagnostic when tracing_multi is unavailable.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_link.c   | 349 ++++++++++++++++++
 .../selftests/bpf/progs/tracing_link_multi.c  |  36 ++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   5 +
 3 files changed, 390 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_link_multi.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
index 9e582b2fae54..f958f084c6f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
@@ -6,6 +6,7 @@
 #include "xdp_dummy.skel.h"
 #include "kprobe_write_ctx.skel.h"
 #include "tracing_link_ctx.skel.h"
+#include "tracing_link_multi.skel.h"
 
 static void test_fentry_link_create_log(int target_fd, __u32 target_btf_id, int cookie,
 					enum bpf_attach_type attach_type,
@@ -390,3 +391,351 @@ void test_tracing_link_log(void)
 	if (test__start_subtest("freplace_ctx_size"))
 		test_log_freplace_ctx_size();
 }
+
+static void test_tracing_multi_link_create_log(const char *prog_name, int target_fd,
+					       struct bpf_link_create_opts *opts,
+					       int err_exp, const char *msg)
+{
+	struct tracing_link_multi *skel;
+	struct bpf_program *prog;
+	char log_buf[128] = {};
+	int err, fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+
+	skel = tracing_link_multi__open();
+	if (!ASSERT_OK_PTR(skel, "tracing_link_multi__open"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto out;
+
+	bpf_program__set_autoload(prog, true);
+	err = tracing_link_multi__load(skel);
+	if (!ASSERT_OK(err, "tracing_link_multi__load"))
+		goto out;
+
+	opts->log_opts = &log_opts;
+	fd = bpf_link_create(bpf_program__fd(prog), target_fd,
+			     bpf_program__expected_attach_type(prog), opts);
+	opts->log_opts = NULL;
+	if (!ASSERT_LT(fd, 0, "bpf_link_create")) {
+		close(fd);
+		goto out;
+	}
+
+	ASSERT_EQ(fd, err_exp, "err");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, msg[0] ? strlen(msg) + 1 : 0, "log_size");
+
+out:
+	tracing_link_multi__destroy(skel);
+}
+
+static void test_multi_log_excessive_count(void)
+{
+	const char *msg = "tracing_multi.cnt 2147483647 is above the limit 1048576.\n";
+	__u32 id = 0;
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .tracing_multi.ids = &id,
+		    .tracing_multi.cnt = INT_MAX,
+	);
+
+	test_tracing_multi_link_create_log("fentry", 0, &opts, -E2BIG, msg);
+}
+
+static void test_multi_log_invalid_flags(void)
+{
+	const char *msg = "flags must be zero.\n";
+	__u32 id = 0;
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = 1,
+		    .tracing_multi.ids = &id,
+		    .tracing_multi.cnt = 1,
+	);
+
+	test_tracing_multi_link_create_log("fentry", 0, &opts, -EINVAL, msg);
+}
+
+static void test_multi_log_invalid_target_fd(void)
+{
+	const char *msg = "target_fd must be zero.\n";
+	__u32 id = 0;
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .tracing_multi.ids = &id,
+		    .tracing_multi.cnt = 1,
+	);
+
+	test_tracing_multi_link_create_log("fentry", -1, &opts, -EINVAL, msg);
+}
+
+static void test_multi_log_duplicate_ids(void)
+{
+	struct btf *btf;
+	char msg[128];
+	__u32 ids[2];
+	int id;
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .tracing_multi.ids = ids,
+		    .tracing_multi.cnt = ARRAY_SIZE(ids),
+	);
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return;
+
+	id = btf__find_by_name_kind(btf, "bpf_fentry_test1", BTF_KIND_FUNC);
+	if (!ASSERT_GT(id, 0, "target_btf_id"))
+		goto out;
+
+	ids[0] = ids[1] = id;
+
+	snprintf(msg, sizeof(msg), "id %u is in tracing_multi.ids more than once.\n", id);
+	test_tracing_multi_link_create_log("fentry", 0, &opts, -EINVAL, msg);
+
+out:
+	btf__free(btf);
+}
+
+static void test_multi_log_target(struct btf *btf, const char *prog_name, const char *target,
+				  int err_exp, const char *format)
+{
+	char msg[128];
+	__u32 id;
+	int ret;
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .tracing_multi.ids = &id,
+		    .tracing_multi.cnt = 1,
+	);
+
+	ret = btf__find_by_name_kind(btf, target, BTF_KIND_FUNC);
+	if (!ASSERT_GT(ret, 0, "target_btf_id"))
+		return;
+
+	id = ret;
+	snprintf(msg, sizeof(msg), format, id, target);
+	test_tracing_multi_link_create_log(prog_name, 0, &opts, err_exp, msg);
+}
+
+static void test_multi_log_vmlinux_target(const char *prog_name, const char *target,
+					  int err_exp, const char *format)
+{
+	struct btf *btf;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return;
+
+	test_multi_log_target(btf, prog_name, target, err_exp, format);
+	btf__free(btf);
+}
+
+static void test_multi_log_module_target(const char *prog_name, const char *target,
+					 int err_exp, const char *format)
+{
+	struct btf *vmlinux, *btf;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	vmlinux = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux, "btf__load_vmlinux_btf"))
+		return;
+
+	btf = btf__load_module_btf("bpf_testmod", vmlinux);
+	if (!ASSERT_OK_PTR(btf, "btf__load_module_btf"))
+		goto out;
+
+	test_multi_log_target(btf, prog_name, target, err_exp, format);
+	btf__free(btf);
+
+out:
+	btf__free(vmlinux);
+}
+
+static void test_multi_log_noreturn_fexit(void)
+{
+	const char *msg = "Cannot attach fexit/fsession_multi prog to noreturn btf id %u.\n";
+
+	test_multi_log_vmlinux_target("fexit", "do_exit", -EINVAL, msg);
+}
+
+static void test_multi_log_denylist(void)
+{
+	const char *msg = "Cannot attach to denylist btf id %u.\n";
+	const char *target = "migrate_disable";
+	struct btf *btf;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return;
+
+	/* migrate_disable is only in the denylist on SMP kernels. */
+	if (btf__find_by_name_kind(btf, target, BTF_KIND_FUNC) == -ENOENT)
+		test__skip();
+	else
+		test_multi_log_target(btf, "fentry", target, -EINVAL, msg);
+
+	btf__free(btf);
+}
+
+static void test_multi_log_invalid_btf_id(void)
+{
+	const char *msg = "Cannot resolve type of btf id 4294967295.\n";
+	__u32 id = ~0U;
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .tracing_multi.ids = &id,
+		    .tracing_multi.cnt = 1,
+	);
+
+	test_tracing_multi_link_create_log("fentry", 0, &opts, -EINVAL, msg);
+}
+
+static void test_multi_log_non_function(void)
+{
+	const char *target = "bpf_fentry_test_t";
+	struct btf *btf;
+	char msg[128];
+	__u32 id;
+	int ret;
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .tracing_multi.ids = &id,
+		    .tracing_multi.cnt = 1,
+	);
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return;
+
+	ret = btf__find_by_name_kind(btf, target, BTF_KIND_STRUCT);
+	if (!ASSERT_GT(ret, 0, "target_btf_id"))
+		goto out;
+
+	id = ret;
+	snprintf(msg, sizeof(msg), "Type of id %u is not function.\n", id);
+	test_tracing_multi_link_create_log("fentry", 0, &opts, -EINVAL, msg);
+
+out:
+	btf__free(btf);
+}
+
+static void test_multi_log_too_many_args(void)
+{
+	const char *msg = "The function bpf_trace_run12 has 13 arguments. Too many.\n";
+
+	test_multi_log_vmlinux_target("fentry", "bpf_trace_run12", -EINVAL, msg);
+}
+
+static void test_multi_log_varargs(void)
+{
+	const char *msg = "The function _printk with variable args is unsupported.\n";
+
+	test_multi_log_vmlinux_target("fentry", "_printk", -EINVAL, msg);
+}
+
+static void test_multi_log_large_return(void)
+{
+	const char *msg = "The function bpf_kfunc_call_test_ret_big return type STRUCT is unsupported.\n";
+
+	test_multi_log_module_target("module_fentry", "bpf_kfunc_call_test_ret_big", -EINVAL, msg);
+}
+
+static void test_multi_log_large_arg(void)
+{
+	const char *msg = "The function bpf_testmod_large_arg arg0 type STRUCT is unsupported.\n";
+
+	test_multi_log_module_target("module_fentry", "bpf_testmod_large_arg", -EINVAL, msg);
+}
+
+static void test_multi_log_large_return_fexit(void)
+{
+	const char *msg = "Attach to target %u:%s with a >8 byte return value is not supported for this attach type.\n";
+
+	test_multi_log_module_target("module_fexit", "bpf_kfunc_call_test_ret_pair",
+				     -EOPNOTSUPP, msg);
+}
+
+static void test_multi_log_missing_address(void)
+{
+	const char *msg = "Cannot resolve address of target %u:%s.\n";
+
+	/* The type is visible through base BTF, but the symbol is in vmlinux. */
+	test_multi_log_module_target("module_fentry", "bpf_fentry_test1", -ENOENT, msg);
+}
+
+static void test_multi_log_notrace(void)
+{
+	const char *msg = "Target %u:%s is not ftrace attachable.\n";
+
+	test_multi_log_vmlinux_target("fentry", "__bpf_tramp_enter", -ENOENT, msg);
+}
+
+static void test_multi_log_not_sleepable(void)
+{
+	const char *msg = "Target %u:%s is not sleepable.\n";
+
+	test_multi_log_vmlinux_target("fentry_sleepable", "bpf_fentry_test2", -EINVAL, msg);
+}
+
+#ifndef __x86_64__
+static void test_multi_log_kernel_unsupported(void)
+{
+	const char *msg = "This kernel does not support tracing_multi.\n";
+	__u32 id = 0;
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = 1,
+		    .tracing_multi.ids = &id,
+		    .tracing_multi.cnt = 1,
+	);
+
+	test_tracing_multi_link_create_log("fentry", 0, &opts, -EOPNOTSUPP, msg);
+}
+#endif
+
+void test_tracing_multi_link_log(void)
+{
+#ifndef __x86_64__
+	if (test__start_subtest("kernel_unsupported"))
+		test_multi_log_kernel_unsupported();
+	return;
+#endif
+
+	if (test__start_subtest("excessive_count"))
+		test_multi_log_excessive_count();
+	if (test__start_subtest("invalid_flags"))
+		test_multi_log_invalid_flags();
+	if (test__start_subtest("invalid_target_fd"))
+		test_multi_log_invalid_target_fd();
+	if (test__start_subtest("duplicate_ids"))
+		test_multi_log_duplicate_ids();
+	if (test__start_subtest("noreturn_fexit"))
+		test_multi_log_noreturn_fexit();
+	if (test__start_subtest("denylist"))
+		test_multi_log_denylist();
+	if (test__start_subtest("invalid_btf_id"))
+		test_multi_log_invalid_btf_id();
+	if (test__start_subtest("non_function"))
+		test_multi_log_non_function();
+	if (test__start_subtest("too_many_args"))
+		test_multi_log_too_many_args();
+	if (test__start_subtest("varargs"))
+		test_multi_log_varargs();
+	if (test__start_subtest("large_return"))
+		test_multi_log_large_return();
+	if (test__start_subtest("large_arg"))
+		test_multi_log_large_arg();
+	if (test__start_subtest("large_return_fexit"))
+		test_multi_log_large_return_fexit();
+	if (test__start_subtest("missing_address"))
+		test_multi_log_missing_address();
+	if (test__start_subtest("notrace"))
+		test_multi_log_notrace();
+	if (test__start_subtest("not_sleepable"))
+		test_multi_log_not_sleepable();
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_link_multi.c b/tools/testing/selftests/bpf/progs/tracing_link_multi.c
new file mode 100644
index 000000000000..11380c004da0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_link_multi.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("?fentry.multi")
+int BPF_PROG(fentry)
+{
+	return 0;
+}
+
+SEC("?fexit.multi")
+int BPF_PROG(fexit)
+{
+	return 0;
+}
+
+SEC("?fentry.multi.s")
+int BPF_PROG(fentry_sleepable)
+{
+	return 0;
+}
+
+SEC("?fentry.multi/bpf_testmod:*")
+int BPF_PROG(module_fentry)
+{
+	return 0;
+}
+
+SEC("?fexit.multi/bpf_testmod:*")
+int BPF_PROG(module_fexit)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1fbc0061cc24..4b011330a5a1 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -88,6 +88,11 @@ struct bpf_testmod_oob {
 
 __bpf_hook_start();
 
+noinline int bpf_testmod_large_arg(struct prog_test_ret_big a)
+{
+	return a.a + a.b + a.c;
+}
+
 noinline int
 bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int b, int c) {
 	bpf_testmod_test_struct_arg_result = a.a + a.b  + b + c;
-- 
2.55.0

