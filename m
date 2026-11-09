Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233365;
	b=T4ANpHWn+bFFEs+tRfc2LPHBJW71mJMblOt8WvdXQm+utW7hypJO1B3yrYPnTu/YoM9x
	 tLau8MmWs+TcHjAIGA8PISVAQDF4bOk/Tad48DQl1ZcH17pqocThPoEYoEcFoBGC2YTRS
	 kh5KpeYIVdRS0f6/cWD56/QBASvZBBzDqroZQxzje6hNOj6IivI7/F75yrkOZLrJxhcy3
	 YM8fYb1QPyg7nBvAnmzJ5Y4cFzptCOIPFsB3ioRuOz7zDV+CM8C21SEFTVneHiuzF6cTc
	 Ek+VW9ovsg+4aMsfw/UGpjqrr1bHnHcTO/LH4KS3EUby8+3HoBORyx1o/TFonVXVk6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233365;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u7TsLdtgk4LWC1lUXMsOMIYHtzQPWQQhl7MK38/q4Eo=;
	b=x2W0EIgKJTiw7H1ZViB9dseRTAdjp+knyDdYBj9xIPLiZXW7VWLIzLziGc552Yz1Xdsk
	 G9z2DHibvQA5SxiLe6wGMFlAuXKK1kskXbM7fMFaP9OykTQtHY9oyp/4tUEdnD5q+df57
	 HZyJHJm4F4ElbCqGO7YjBYYr9je5oclLXQFgYr3/tsTopVPoNCP2YGXBjz1cKT2xfhSev
	 xrJU8vvjA1+m8m6f3/PqHzuIIGu3OEz1CrysYJh+dT1xSDkiIIbpUk4SD5YpHHU21Ldsp
	 Nkhtc9hfZBYhWIhCTGMUTGpIqknwgqxGcK/K9++B3bV1LnL7VE65fhsaFBfjO0kKuQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SVYlI002;
	arc=none smtp.remote-ip=91.218.175.219
Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C6606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 14:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 131C6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SVYlI002
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uL34otuXneMNkgVk69W35A0N6pkFsqt9VsOR9HNVZqc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794233363; v=1; x=1794838163;
 b=SVYlI002bTQ07DrMfsb4BDht/ipXeF3/AhJdDqt7Y8C/uHhixdE96O/FJRNpjUrfSez4UwUC
 PkdX4KmuOe4H3HEuh54ToQTjToOXI4Fs05jgTbmhgoILSaRdDxEI+eV19YPE6RyOqq29LTn2+6+
 Nho8wIXu/e6KexndvbBQsVzs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 942069c1ecef47fb;
	Mon, 09 Nov 2026 14:09:23 +0000
X-Mizu-Trace-ID: 942069c1ecef47fb
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
Subject: [PATCH bpf-next 6/9] selftests/bpf: Verify tracing link_create logs
Date: Mon,  9 Nov 2026 22:08:13 +0800
Message-ID: <20261109140816.5196-7-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109140816.5196-1-leon.hwang@linux.dev>
References: <20261109140816.5196-1-leon.hwang@linux.dev>
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
attach-target checks, including incompatible kprobe_write_ctx settings.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_link.c   | 275 ++++++++++++++++++
 1 file changed, 275 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_link.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
new file mode 100644
index 000000000000..1b64cb3e9983
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "fentry_recursive.skel.h"
+#include "priv_freplace_prog.skel.h"
+#include "xdp_dummy.skel.h"
+#include "kprobe_write_ctx.skel.h"
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
+	const char *msg = "Invalid attach_type.\n";
+
+	test_fentry_link_create_log(0, 0, 0, BPF_XDP, false, msg);
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
+}
-- 
2.55.0

