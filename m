Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668855;
	b=yfJXq0nPUp0kgB8move2h9xKrOaIP+wqfxgVAJutZ8vJF/F2XpXYlgwmu3R9vq2AVSts
	 mTDhoLduecdM28ru/96LULG+uCWyGcEgryQHrcVpirugy3vqL0bFFfOtSCyDaZSkK8oKf
	 WMFNQCR1NZxEc8E15iCTt0LPFUNJ7bUKOZYc/ynUFYdbQTj4Nl6s0pvchHSZGIaBXvBwt
	 Tc64KEaDmii9kkE0wFw8I5nEkFQOB8EpLaWK3Uz0zrVVuXP9fmzAxEOME/amRSGpWQnqK
	 a5XX5Sy9cWFiEh8lB+hqbMHjTbTyGU/6dSd2oMczovcJBgU5znc5C1xvKVoKdbYtbTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668855;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lfuB0iAt4fsbkwUXrECmRSa5sibx9H8Mj3Q+0EdYXoo=;
	b=1dHtirqWAP4cx3Ja1wiDFfya8gWHdYQGyTqr4iE1kopwII+hupYgvD+Yk1cfH/+9id4v
	 CjlhpP3rnkDS8+rSCnc4OWvSTOPLLz3Y5sC93S+LYP1qUR8rpA8WsDzsc5s0puoT6pZTm
	 NwjT5ubvWvfk/0TwQH49BKOUcHnB3nl5/OMDbRNGGwNbllsQjl6t78pd3WfxdXOT5kYvH
	 1x8FXYc6prLsjbStUbR4UZlu0AdCtq86MPKGk7Unhg8EjzXXo9xF6enwQR2Bw8EA6iyxN
	 lv9hMcvVSQ/cwSpTMpHNxqX0IHdHTLftDFeRqG3sAHa0ohFtK4TbqII/b5T40fvUrJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="p1ep/FFw";
	arc=none smtp.remote-ip=91.218.175.51
Received: from mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098B8606A8B7
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 098B8606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p1ep/FFw
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4PLDyayOW4SUB8uP2Ok6WKtAL/3r/C5d8EOBKBMG5CU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794668853; v=1; x=1795273653;
 b=p1ep/FFwBFVPITYdhOD6wjEfmQ7wey/yW8LL31qXa3BRwXSemsZJCWT64ni6OcphJrEpGNpk
 CTPTgyzBhtp9hFXoRE/UlqYLPgAxv0/r4yeRrIba3fvA6MvnPYuqNxfpE/h5G4yd76EB7kgoaHS
 ATciVlfpxSk/7WVBjqiUNE3M=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id caacfbb81211073e;
	Sat, 14 Nov 2026 15:07:33 +0000
X-Mizu-Trace-ID: caacfbb81211073e
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
Subject: [PATCH bpf-next v2 6/9] selftests/bpf: Verify tracing link_create logs
Date: Sat, 14 Nov 2026 23:06:07 +0800
Message-ID: <20261114150610.84507-7-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114150610.84507-1-leon.hwang@linux.dev>
References: <20261114150610.84507-1-leon.hwang@linux.dev>
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

Check the error code, log message, and reported log size for invalid
tracing and freplace link creation parameters. Cover reattachment and
attach-target checks, including incompatible kprobe_write_ctx and
max_ctx_offset settings.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_link.c   | 327 ++++++++++++++++++
 .../selftests/bpf/progs/tracing_link_ctx.c    |  17 +
 2 files changed, 344 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_link.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_link_ctx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
new file mode 100644
index 000000000000..28154fdd2f0c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "fentry_recursive.skel.h"
+#include "priv_freplace_prog.skel.h"
+#include "xdp_dummy.skel.h"
+#include "kprobe_write_ctx.skel.h"
+#include "tracing_link_ctx.skel.h"
+
+static void test_fentry_link_create_log(int target_fd, __u32 target_btf_id, int cookie,
+					enum bpf_attach_type attach_type,
+					bool reattach, const char *msg)
+{
+	struct fentry_recursive *skel = NULL;
+	struct xdp_dummy *target;
+	char log_buf[128] = {};
+	int err, fd, prog_fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .log_opts = &log_opts,
+		    .target_btf_id = target_btf_id,
+		    .tracing.cookie = cookie,
+	);
+
+	target = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(target, "xdp_dummy__open_and_load"))
+		return;
+
+	skel = fentry_recursive__open();
+	if (!ASSERT_OK_PTR(skel, "fentry_recursive__open"))
+		goto out;
+
+	err = bpf_program__set_attach_target(skel->progs.recursive_attach,
+					     bpf_program__fd(target->progs.xdp_dummy_prog),
+					     "xdp_dummy_prog");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto out;
+
+	err = fentry_recursive__load(skel);
+	if (!ASSERT_OK(err, "fentry_recursive__load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.recursive_attach);
+	if (reattach) {
+		/* Consume the initial target saved when the program was loaded. */
+		fd = bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY, &opts);
+		if (!ASSERT_GE(fd, 0, "bpf_link_create first"))
+			goto out;
+
+		close(fd);
+		memset(log_buf, 0, sizeof(log_buf));
+		log_opts.true_size = 0;
+	}
+
+	fd = bpf_link_create(prog_fd, target_fd, attach_type, &opts);
+	if (!ASSERT_LT(fd, 0, "bpf_link_create")) {
+		close(fd);
+		goto out;
+	}
+
+	ASSERT_EQ(fd, -EINVAL, "err");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+
+out:
+	fentry_recursive__destroy(skel);
+	xdp_dummy__destroy(target);
+}
+
+static void test_log_invalid_attach_type(void)
+{
+	const char *msg = "Invalid tracing attach_type.\n";
+
+	test_fentry_link_create_log(0, 0, 0, BPF_TRACE_FEXIT, false, msg);
+}
+
+static void test_log_tgt_prog_fd_only(void)
+{
+	const char *msg = "tgt_prog_fd and btf_id must be both set or both unset.\n";
+
+	test_fentry_link_create_log(-1, 0, 1, BPF_TRACE_FENTRY, false, msg);
+}
+
+static void test_log_tgt_prog_fd_disallowed(void)
+{
+	const char *msg = "tgt_prog_fd is only allowed for freplace prog.\n";
+
+	test_fentry_link_create_log(-1, 1, 0, BPF_TRACE_FENTRY, false, msg);
+}
+
+static void test_log_invalid_attach_btf(void)
+{
+	const char *msg = "Invalid attach_btf.\n";
+
+	test_fentry_link_create_log(0, 0, 1, BPF_TRACE_FENTRY, true, msg);
+}
+
+static void test_freplace_link_create_log(int target_fd, __u32 target_btf_id, int err_exp,
+					  bool reattach, const char *msg)
+{
+	struct priv_freplace_prog *skel = NULL;
+	char log_buf[256] = {};
+	struct xdp_dummy *xdp;
+	int err, fd, prog_fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .log_opts = &log_opts,
+		    .target_btf_id = target_btf_id,
+	);
+
+	xdp = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(xdp, "xdp_dummy__open_and_load"))
+		return;
+
+	skel = priv_freplace_prog__open();
+	if (!ASSERT_OK_PTR(skel, "priv_freplace_prog__open"))
+		goto out;
+
+	err = bpf_program__set_attach_target(skel->progs.new_xdp_prog2,
+					     bpf_program__fd(xdp->progs.xdp_dummy_prog),
+					     "xdp_dummy_prog");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto out;
+
+	err = priv_freplace_prog__load(skel);
+	if (!ASSERT_OK(err, "priv_freplace_prog__load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.new_xdp_prog2);
+	if (reattach) {
+		/* Consume the initial target saved when the program was loaded. */
+		fd = bpf_link_create(prog_fd, 0, 0, &opts);
+		if (!ASSERT_GE(fd, 0, "bpf_link_create first"))
+			goto out;
+
+		close(fd);
+		memset(log_buf, 0, sizeof(log_buf));
+		log_opts.true_size = 0;
+	}
+
+	if (!target_fd && target_btf_id)
+		target_fd = bpf_program__fd(xdp->progs.xdp_dummy_prog);
+
+	fd = bpf_link_create(prog_fd, target_fd, 0, &opts);
+	if (!ASSERT_LT(fd, 0, "bpf_link_create")) {
+		close(fd);
+		goto out;
+	}
+
+	ASSERT_EQ(fd, err_exp, "err");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+
+out:
+	priv_freplace_prog__destroy(skel);
+	xdp_dummy__destroy(xdp);
+}
+
+static void test_log_invalid_target_fd(void)
+{
+	const char *msg = "Invalid tgt_prog_fd.\n";
+
+	test_freplace_link_create_log(-1, 1, -EBADF, false, msg);
+}
+
+static void test_log_reattach_without_target(void)
+{
+	const char *msg = "Only allow re-attach for tracing and lsm progs.\n";
+
+	test_freplace_link_create_log(0, 0, -EINVAL, true, msg);
+}
+
+static void test_log_invalid_target_btf_id(void)
+{
+	const char *msg = "attach_btf_id 4294967295 is invalid\n";
+
+	test_freplace_link_create_log(0, ~0U, -EINVAL, false, msg);
+}
+
+#ifdef __x86_64__
+static void test_log_invalid_kprobe_write_ctx(void)
+{
+	struct kprobe_write_ctx *skel_kprobe, *skel_freplace = NULL;
+	struct bpf_program *prog_kprobe, *prog_freplace;
+	const char *msg = "Invalid kprobe_write_ctx.\n";
+	int err, prog_fd, btf_id, fd;
+	char log_buf[128] = {};
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts,
+		    .log_opts = &log_opts,
+	);
+
+	skel_kprobe = kprobe_write_ctx__open();
+	if (!ASSERT_OK_PTR(skel_kprobe, "kprobe_write_ctx__open kprobe"))
+		return;
+
+	prog_kprobe = skel_kprobe->progs.kprobe_dummy;
+	bpf_program__set_autoload(prog_kprobe, true);
+
+	err = kprobe_write_ctx__load(skel_kprobe);
+	if (!ASSERT_OK(err, "kprobe_write_ctx__load kprobe"))
+		goto out;
+
+	skel_freplace = kprobe_write_ctx__open();
+	if (!ASSERT_OK_PTR(skel_freplace, "kprobe_write_ctx__open freplace"))
+		goto out;
+
+	prog_freplace = skel_freplace->progs.freplace_kprobe;
+	bpf_program__set_autoload(prog_freplace, true);
+
+	prog_fd = bpf_program__fd(skel_kprobe->progs.kprobe_write_ctx);
+	bpf_program__set_attach_target(prog_freplace, prog_fd, "kprobe_write_ctx");
+
+	err = kprobe_write_ctx__load(skel_freplace);
+	if (!ASSERT_OK(err, "kprobe_write_ctx__load freplace"))
+		goto out;
+
+	prog_fd = bpf_program__fd(prog_kprobe);
+	btf_id = btf__find_by_name_kind(bpf_object__btf(skel_kprobe->obj), "kprobe_dummy",
+					BTF_KIND_FUNC);
+	if (!ASSERT_GT(btf_id, 0, "btf__find_by_name_kind"))
+		goto out;
+
+	link_opts.target_btf_id = btf_id;
+	fd = bpf_link_create(bpf_program__fd(prog_freplace), prog_fd, 0, &link_opts);
+	if (!ASSERT_LT(fd, 0, "bpf_link_create")) {
+		close(fd);
+		goto out;
+	}
+
+	ASSERT_EQ(fd, -EINVAL, "err");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+
+out:
+	kprobe_write_ctx__destroy(skel_freplace);
+	kprobe_write_ctx__destroy(skel_kprobe);
+}
+#else
+static void test_log_invalid_kprobe_write_ctx(void)
+{
+	test__skip();
+}
+#endif
+
+static void test_log_freplace_ctx_size(void)
+{
+	const char *msg = "Freplace prog accesses more ctx than its target.\n";
+	struct tracing_link_ctx *target, *skel = NULL;
+	char log_buf[128] = {};
+	int err, fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .log_opts = &log_opts,
+	);
+
+	target = tracing_link_ctx__open_and_load();
+	if (!ASSERT_OK_PTR(target, "tracing_link_ctx__open_and_load"))
+		return;
+
+	skel = tracing_link_ctx__open();
+	if (!ASSERT_OK_PTR(skel, "tracing_link_ctx__open"))
+		goto out;
+
+	bpf_program__set_autoload(skel->progs.target, false);
+	bpf_program__set_autoload(skel->progs.replacement, true);
+	err = bpf_program__set_attach_target(skel->progs.replacement,
+					     bpf_program__fd(target->progs.target), "target");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto out;
+
+	err = tracing_link_ctx__load(skel);
+	if (!ASSERT_OK(err, "tracing_link_ctx__load"))
+		goto out;
+
+	fd = bpf_link_create(bpf_program__fd(skel->progs.replacement), 0, 0, &opts);
+	if (!ASSERT_LT(fd, 0, "bpf_link_create")) {
+		close(fd);
+		goto out;
+	}
+
+	ASSERT_EQ(fd, -EINVAL, "err");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+
+out:
+	tracing_link_ctx__destroy(skel);
+	tracing_link_ctx__destroy(target);
+}
+
+void test_tracing_link_log(void)
+{
+	if (test__start_subtest("invalid_attach_type"))
+		test_log_invalid_attach_type();
+	if (test__start_subtest("tgt_prog_fd_only"))
+		test_log_tgt_prog_fd_only();
+	if (test__start_subtest("tgt_prog_fd_disallowed"))
+		test_log_tgt_prog_fd_disallowed();
+	if (test__start_subtest("invalid_attach_btf"))
+		test_log_invalid_attach_btf();
+	if (test__start_subtest("invalid_target_fd"))
+		test_log_invalid_target_fd();
+	if (test__start_subtest("reattach_without_target"))
+		test_log_reattach_without_target();
+	if (test__start_subtest("invalid_target_btf_id"))
+		test_log_invalid_target_btf_id();
+	if (test__start_subtest("invalid_kprobe_write_ctx"))
+		test_log_invalid_kprobe_write_ctx();
+	if (test__start_subtest("freplace_ctx_size"))
+		test_log_freplace_ctx_size();
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_link_ctx.c b/tools/testing/selftests/bpf/progs/tracing_link_ctx.c
new file mode 100644
index 000000000000..940a7d74b7e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_link_ctx.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("tracepoint")
+int target(struct trace_event_raw_sys_enter *ctx __arg_ctx)
+{
+	return 0;
+}
+
+SEC("?freplace")
+int replacement(struct trace_event_raw_sys_enter *ctx __arg_ctx)
+{
+	return ctx->id;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.55.0

