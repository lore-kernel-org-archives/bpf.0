Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233378;
	b=WDF+kygBibBPUplC5sZ9q5ae44hrBxURX8Xtrz+OhYw6xftWvrHFdA57aCvbstLQ+XRG
	 eKegnPMdDNqM12jyIFQnMHnJ7RprN3UNCQ7NseGCUQHWhDB7hj0XPfRBR0p48D1Pi5NEg
	 TsSJc2xJE8kwdGgWfLnc9NznBJ/zfjC26aJxn6xuTWp18h2dI/1xuULU1hAdqhQgYm7dN
	 Y4D+qVIJ7R9ly4FX6J27wttF11nIuY/x0my2Ohtr9w7BOUNtoWtXe7okA+BBGeSsLmd6x
	 sWrpXUAWE3JlTlAzGSj1F8osf7+Ocvql5BUyest1WQHY2lNFy6VMe5OjXK2K11mCWIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233378;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hIbh6EbfhDOncQjZvGHUe6etv0nEZkX8eOE42PTaiP4=;
	b=3An4EX88z4T1WS0XiK2knybG37UME3+HRuD1JbCdaPhZOtphDDJmCQCpvx+y8lNgv6xm
	 2qOtv8IAA+FpdjXfw91LpD1vb5OthR9vqiglL1BopMFxigl5IoQY5HoscG988gtBhIqZ/
	 xhQ8k6GaoCoYeu4lyHotTFOI1v8GCU7/DgmISwzMjBTpXYy7oxwBgNPmc1CahRRcPi3P+
	 C3Sp3yvLgkkXKXqxY7Pf0+p2OyNDK9swdvDTXLWq3h9u7MT6xpHjtuz/iJJBzGHLqKLhZ
	 tS5rxpI3d5AbjtOjxfwi8/G7hGPDBpIHz797/fU6em4Id/bzRJIdvi8QWFAqopnOAAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u1lfTtpc;
	arc=none smtp.remote-ip=91.218.175.236
Received: from mta0.migadu.com (out-236.mta0.migadu.com [91.218.175.236])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A3606D82E
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 14:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687A3606D82E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u1lfTtpc
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j4YuKKOawnaz1xc9cWV5lDbUelCd51dMJdfYALRo3So=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794233375; v=1; x=1794838175;
 b=u1lfTtpcQ6A3guqyElUO6mUrGw9iVxp5czQctA0rOMuHljl15WgOK6bY6GjsOtHzwfzh0K0N
 Xh6SCfmT3rBXYybYJJ35cFeR4cAJa8S0mvDquVP0NaAu0kGCSjZrFXahNt1i136EJjYsZPd9u4V
 SDQpxQ5bqE5zm4nvgi5M87BY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 85ad056a3d11807c;
	Mon, 09 Nov 2026 14:09:35 +0000
X-Mizu-Trace-ID: 85ad056a3d11807c
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
Subject: [PATCH bpf-next 8/9] selftests/bpf: Verify iter link_create logs
Date: Mon,  9 Nov 2026 22:08:15 +0800
Message-ID: <20261109140816.5196-9-leon.hwang@linux.dev>
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

Check the error code, log message, and reported log size for invalid target
FDs, flags, and iterator information. Also cover attaching a sleepable
program to an iterator that does not support it.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/iter_link.c      | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iter_link.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iter_link.c b/tools/testing/selftests/bpf/prog_tests/iter_link.c
new file mode 100644
index 000000000000..c684a109091a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/iter_link.c
@@ -0,0 +1,132 @@
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
+		.buf = log_buf,
+		.size = sizeof(log_buf),
+		.level = 1,
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
+	const char *msg = "Invalid iter_info.\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .iter.info = (union bpf_iter_link_info *)info,
+		    .iter.len = sizeof(info),
+	);
+
+	info[sizeof(info) - 1] = 1;
+	test_iter_link_create_log(0, &opts, 0, -E2BIG, msg);
+}
+
+static void test_log_invalid_iter_info_len(void)
+{
+	const char *msg = "Invalid iter_info_len.\n";
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

