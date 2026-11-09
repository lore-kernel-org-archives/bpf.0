Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233372;
	b=KOFzcTr+6Uy4zgL2ppxR/hP5uD/Pbpoiif5Fdkv/VCn/sXY+INWleSL8NmVrMyXAbWy7
	 u2i/0ffuDdsIYrggTYSiGKUMLiLIBGxrBLybVcXy33PB5nTbinSH9nWgckZOn8GHsYmRN
	 F+qNDT+b0k0hhWkND5Q4dWy8WFp24pHAe4dST2ajks90MzNL58+ODpstDZpDbqNivhrJV
	 QFhyZpH3MimMAfWqGU9jua+xzanR0OjXK+PXt+3eMiReXqw+31S5ovS3m1pt378CfqSSv
	 K7i3fLgXzZn58sgg/6raueSnRRaKaxsh/9ptKIawL77Y9VBEupasaEXUlneehSY3ccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233372;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/awfiZZk7QPGufy8TRdN1/JQqHmSNpfJagJzHwdZqbY=;
	b=hJEK0sW2baDSmjNZwI01pUeHjFPlVdhIlsSNq0j/AbaKi1VOvjSatIjCttITUie1qO28
	 /v8UsYiOpLmiKkzuOaoc1rSvAXjRLeDNR8yAC9Tm3B2uPIubLya6j1hEl/SL8UH5rJOta
	 r6TEyzAqpGkrZ2wmfwF1wq3SbgpfkSJjA5NNRXVqxC9qgMJFStnsb3WEicKVtaZ+IfIi3
	 Sji5C8rQ8Zts7LN2rdvDkU1bLNg/3J1g3N5WDBkMkWl0eYq81iTcKAeM9SVbIDNrwESTJ
	 3CN4L3GF5WJNCO0FYII/4i1IduOldeGfB/vAoijBnyECgs/PatE6lfK/JvzVhQYBfFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oRczrJXs;
	arc=none smtp.remote-ip=95.215.58.140
Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C2606D82B
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 14:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495C2606D82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oRczrJXs
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i9yHM4eoQyP1lSutaH5lL/yiuOISfz8NsblbFKDkohI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794233369; v=1; x=1794838169;
 b=oRczrJXs2W37oRRvJJFJIhizM9UNScQreK1xGJA+ezjA40mb8CcXdZsCq7/Re5xFXtfPDpn4
 qcWmxULuvqZlP6gYc0BlolQZsyDfUI22mzWBXJ0+kN9Ywv0qX6PnVbzWfujRiOFYmpRqcEX21fI
 IAsz8Ja8GWZpET6HUAePF6Yo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d5b5477812c6c27f;
	Mon, 09 Nov 2026 14:09:29 +0000
X-Mizu-Trace-ID: d5b5477812c6c27f
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
Subject: [PATCH bpf-next 7/9] selftests/bpf: Verify tracing_multi link_create logs
Date: Mon,  9 Nov 2026 22:08:14 +0800
Message-ID: <20261109140816.5196-8-leon.hwang@linux.dev>
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

Check the error code, log message, and reported log size for a zero or
excessive count, missing IDs, invalid flags, and a nonzero target FD.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_link.c   | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
index 1b64cb3e9983..6f22a21be946 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
@@ -5,6 +5,7 @@
 #include "priv_freplace_prog.skel.h"
 #include "xdp_dummy.skel.h"
 #include "kprobe_write_ctx.skel.h"
+#include "tracing_multi_fail.skel.h"
 
 static void test_fentry_link_create_log(int target_fd, __u32 target_btf_id, int cookie,
 					enum bpf_attach_type attach_type,
@@ -273,3 +274,104 @@ void test_tracing_link_log(void)
 	if (test__start_subtest("invalid_kprobe_write_ctx"))
 		test_log_invalid_kprobe_write_ctx();
 }
+
+static void test_tracing_multi_link_create_log(int target_fd, __u32 flags, const __u32 *ids,
+					       __u32 cnt, int err_exp, const char *msg)
+{
+	struct tracing_multi_fail *skel;
+	char log_buf[128] = {};
+	int err, fd, prog_fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .log_opts = &log_opts,
+		    .flags = flags,
+		    .tracing_multi.ids = ids,
+		    .tracing_multi.cnt = cnt,
+	);
+
+	skel = tracing_multi_fail__open();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_fail__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.test_fentry_s, false);
+	err = tracing_multi_fail__load(skel);
+	if (!ASSERT_OK(err, "tracing_multi_fail__load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.test_fentry);
+	fd = bpf_link_create(prog_fd, target_fd, BPF_TRACE_FENTRY_MULTI, &opts);
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
+	tracing_multi_fail__destroy(skel);
+}
+
+static void test_multi_log_zero_count(void)
+{
+	const char *msg = "tracing_multi.cnt cannot be zero.\n";
+	__u32 id = 0;
+
+	test_tracing_multi_link_create_log(0, 0, &id, 0, -EINVAL, msg);
+}
+
+static void test_multi_log_missing_ids(void)
+{
+	const char *msg = "tracing_multi.ids must be set.\n";
+
+	test_tracing_multi_link_create_log(0, 0, NULL, 1, -EINVAL, msg);
+}
+
+static void test_multi_log_excessive_count(void)
+{
+	const char *msg = "tracing_multi.cnt is too large.\n";
+	__u32 id = 0;
+
+	test_tracing_multi_link_create_log(0, 0, &id, INT_MAX, -E2BIG, msg);
+}
+
+static void test_multi_log_invalid_flags(void)
+{
+	const char *msg = "Invalid flags.\n";
+	__u32 id = 0;
+
+	test_tracing_multi_link_create_log(0, 1, &id, 1, -EINVAL, msg);
+}
+
+static void test_multi_log_invalid_target_fd(void)
+{
+	const char *msg = "Invalid target_fd.\n";
+	__u32 id = 0;
+
+	test_tracing_multi_link_create_log(-1, 0, &id, 1, -EINVAL, msg);
+}
+
+void test_tracing_multi_link_log(void)
+{
+#ifndef __x86_64__
+	test__skip();
+	return;
+#endif
+
+	if (test__start_subtest("zero_count"))
+		test_multi_log_zero_count();
+	if (test__start_subtest("missing_ids"))
+		test_multi_log_missing_ids();
+	if (test__start_subtest("excessive_count"))
+		test_multi_log_excessive_count();
+	if (test__start_subtest("invalid_flags"))
+		test_multi_log_invalid_flags();
+	if (test__start_subtest("invalid_target_fd"))
+		test_multi_log_invalid_target_fd();
+}
+
-- 
2.55.0

