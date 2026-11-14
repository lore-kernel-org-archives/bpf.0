Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668879;
	b=tIern69syfYXVzcfvEwD1l5242mEWa+hsllq9gj+DLgPrgXhXbXx1bo3pE5CMfZAIx+f
	 lLV4WSix6Ph0rfmuuOKGdeSMHbjrD8qICrCXEsAxic5pUlu3UMCkHQaL65e9Phe7YRR4w
	 YbxuRV/l8hAHgTHMXG9byvaQTDo0JSgxYG+SsDCigvC6M5p7izy/eor7EPGutgqXUPs9b
	 hbYeWwoC/5QE1UUQ+SngKDaKoIztxRHtI825OiT/DFIcJs43nlacM6bJyQGFDz5uH7hm7
	 JXB5FJhSRUlRk/vzo+sIdX0UGwyG8oOM+hTY7w28/FvwrjuX94Lhpub6h9kXqaok2HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668879;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Uk64wFp7pPgEKa5YPAhY1PUZRgl5m7ofqmvbexSEZz0=;
	b=Frvjq6a3CtPCQITvSb9Gy1pgB9DMyKiK8HSvZ6KxsGSmtQvbiw64hzi7hNf0gU18CG09
	 B88q2YuOgfjZ8e/zg7p8KSwSqI5l7mkBtNIBI5nGNiM29k+X2j/DJooYf+7pqCoZYI749
	 PjZzQKhciuvd45mKI8O5jRyZ+P+/8q1F+bE9/sNgx/Cuut0SFGsKPMLd/2pXEy8ti+uny
	 Exz5ziKXVsB9d+zYYAROW5S6WZzrQyOl3vpcHsKC0zdqwYSqRJ2WGzAc3TqUee6SbPOGY
	 M3l0uv7ebtDIYMIaMZatm7ZLnCUB6YY3Hfmpx1uzv4/cEUQStr/E50oDNsEgH8xQqzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tyvTnv2o;
	arc=none smtp.remote-ip=95.215.58.74
Received: from mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75350606A32E
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75350606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tyvTnv2o
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rzlaMxPU8kAE4A/3f5vu23JkjxTU6YRrGbrFnA3m0xE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794668876; v=1; x=1795273676;
 b=tyvTnv2ojEpI2MGUyQbaiPlEHL8Ow9HRchTQ5vALuQgSdnlhP1JanssWKjCADeViuRkqjUkV
 2LCXeXwzjRqt7BApHQkGfZ9b7XW6m3Hwtqbr7nWBEZuW2Mp9lGCc3/OtpNgXoIrrM2k90zOi7tn
 c2+y+lpH8BpnZoqFJb4TO+cc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 44dc21937f954fd7;
	Sat, 14 Nov 2026 15:07:56 +0000
X-Mizu-Trace-ID: 44dc21937f954fd7
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
Subject: [PATCH bpf-next v2 8/9] selftests/bpf: Verify iter link_create logs
Date: Sat, 14 Nov 2026 23:06:09 +0800
Message-ID: <20261114150610.84507-9-leon.hwang@linux.dev>
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

Check the error code, log message, and reported log size for invalid target
FDs, flags, and iterator information. Also cover attaching a sleepable
program to an iterator that does not support it.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/iter_link.c      | 156 ++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iter_link.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iter_link.c b/tools/testing/selftests/bpf/prog_tests/iter_link.c
new file mode 100644
index 000000000000..623a84ba612d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/iter_link.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "bpf_iter_bpf_map.skel.h"
+
+static void test_iter_link_create_log(int target_fd, struct bpf_link_create_opts *opts,
+				      __u64 flags, int err_exp, const char *msg)
+{
+	struct bpf_iter_bpf_map *skel;
+	char log_buf[128] = {};
+	int err, fd, prog_fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+
+	skel = bpf_iter_bpf_map__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_map__open"))
+		return;
+
+	err = bpf_program__set_flags(skel->progs.dump_bpf_map, flags);
+	if (!ASSERT_OK(err, "bpf_program__set_flags"))
+		goto out;
+
+	err = bpf_iter_bpf_map__load(skel);
+	if (!ASSERT_OK(err, "bpf_iter_bpf_map__load"))
+		goto out;
+
+	opts->log_opts = &log_opts;
+	prog_fd = bpf_program__fd(skel->progs.dump_bpf_map);
+	fd = bpf_link_create(prog_fd, target_fd, BPF_TRACE_ITER, opts);
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
+	bpf_iter_bpf_map__destroy(skel);
+}
+
+static void test_log_invalid_target_fd(void)
+{
+	const char *msg = "Invalid target_fd.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+
+	test_iter_link_create_log(-1, &opts, 0, -EINVAL, msg);
+}
+
+static void test_log_invalid_flags(void)
+{
+	const char *msg = "Invalid flags.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = 1,
+	);
+
+	test_iter_link_create_log(0, &opts, 0, -EINVAL, msg);
+}
+
+static void test_log_iter_info_only(void)
+{
+	const char *msg = "iter_info and iter_info_len must be both set or both unset.\n";
+	union bpf_iter_link_info info = {};
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .iter.info = &info,
+	);
+
+	test_iter_link_create_log(0, &opts, 0, -EINVAL, msg);
+}
+
+static void test_log_iter_info_len_only(void)
+{
+	const char *msg = "iter_info and iter_info_len must be both set or both unset.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .iter.len = sizeof(union bpf_iter_link_info),
+	);
+
+	test_iter_link_create_log(0, &opts, 0, -EINVAL, msg);
+}
+
+static void test_log_invalid_iter_info(void)
+{
+	unsigned char info[sizeof(union bpf_iter_link_info) + 1] = {};
+	const char *msg = "Invalid iter_info_len.\n";
+	struct bpf_iter_bpf_map *skel;
+	struct bpf_link *link;
+	char log_buf[128] = {};
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+	LIBBPF_OPTS(bpf_iter_attach_opts, opts,
+		    .link_info = (union bpf_iter_link_info *)info,
+		    .link_info_len = sizeof(info),
+		    .log_opts = &log_opts,
+	);
+
+	skel = bpf_iter_bpf_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_map__open_and_load"))
+		return;
+
+	info[sizeof(info) - 1] = 1;
+	link = bpf_program__attach_iter(skel->progs.dump_bpf_map, &opts);
+	if (!ASSERT_ERR_PTR(link, "bpf_program__attach_iter")) {
+		bpf_link__destroy(link);
+		goto out;
+	}
+
+	ASSERT_EQ(libbpf_get_error(link), -E2BIG, "err");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+
+out:
+	bpf_iter_bpf_map__destroy(skel);
+}
+
+static void test_log_invalid_iter_info_len(void)
+{
+	const char *msg = "Invalid iter_info.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .iter.info = (union bpf_iter_link_info *)1,
+		    .iter.len = sizeof(union bpf_iter_link_info),
+	);
+
+	test_iter_link_create_log(0, &opts, 0, -EFAULT, msg);
+}
+
+static void test_log_invalid_prog(void)
+{
+	const char *msg = "The iter target does not support the bpf prog.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+
+	test_iter_link_create_log(0, &opts, BPF_F_SLEEPABLE, -EINVAL, msg);
+}
+
+void test_iter_link_log(void)
+{
+	if (test__start_subtest("invalid_target_fd"))
+		test_log_invalid_target_fd();
+	if (test__start_subtest("invalid_flags"))
+		test_log_invalid_flags();
+	if (test__start_subtest("iter_info_only"))
+		test_log_iter_info_only();
+	if (test__start_subtest("iter_info_len_only"))
+		test_log_iter_info_len_only();
+	if (test__start_subtest("invalid_iter_info"))
+		test_log_invalid_iter_info();
+	if (test__start_subtest("invalid_iter_info_len"))
+		test_log_invalid_iter_info_len();
+	if (test__start_subtest("invalid_prog"))
+		test_log_invalid_prog();
+}
-- 
2.55.0

