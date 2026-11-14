Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668868;
	b=ySVXMQGJYzmIRL9k06hFApeRSQPiaN3yCwSlpnaGbZLppvy2/Ni+FXSqqAacDPKDJjAW
	 Z8N8hS1QhOKoxSTwXhnNBTDK8jecL79li5ahj/TJydeEHYqbwZkAi5zFeD/5akuFtbesz
	 olmmiWfK5FeX5zJGWm9NhtSsBa/VrWD5xUIE3GDa8FXB/stRc+HVTBNhs6Qne6ktNcmOW
	 FJPbed30nLp0BSHJdyamISK4cYmOXTMdmM0q5sz97CiB/JRjevw1T9f1/UwaBGd4iQF8p
	 rnb+Dj4tlJ8VSaBqRqCuINfekNT8UFHKSYHevi3mK4uhqQsm9ZpNn9PO2n8tqUbHo+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668868;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OmPZUgt+py15CT8aehT7qnFQgx7RjbqNypkM7OmH+No=;
	b=Y5s1rmg3gvYOxZv+tIG9OO9IRQtp+0/zx4WafaGLOhB0djwnMXWKzcZ4/rjnQYXZxC9w
	 ebwrsWwqzfU45JWBrnhwqb0bS2G78k6HD8rwbIdpRO/WeKV81MO4wHScVG9s15djvEV4U
	 kpCD2Snvts5vuKZr4tYaBMhXRXfEe/PON8m/8yIIJBUhbYRNkasTp5SgA7CRQMi5+i/pf
	 7MkMXC0NOKXeOPDj6tYi58DTF/7nhxNiYqmM/2QoH8XupBBhpPGeEUVJ6jo6PPKv9e7ex
	 b/UEeILwEtxnUPk6yoExaDCZ86CyiBVOLbJbNI8NQa9j9+lo4yot31ekP/6H450g1qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HANvV2+3;
	arc=none smtp.remote-ip=95.215.58.61
Received: from mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C82606A338
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1C82606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HANvV2+3
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=We7VgYHnw9NhywvVPUAcVf+7e5SRu+JFh112Zj032lQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794668865; v=1; x=1795273665;
 b=HANvV2+3LFfQaa4G35u7kFbpVeTVUixMoAs/OkIBl2tb7lfiDNagNCc4IZn8HWx3PxVP92dR
 fFuiT0Omd1KMlqMRDimF30WHvkwW1b1T2umO7dl6R3MvwF2xTUlplkvSuhL7nDnXbHNEuIu2y/6
 AshayQZTUDdV71/hOON2yYJc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 808f5c65e072006d;
	Sat, 14 Nov 2026 15:07:45 +0000
X-Mizu-Trace-ID: 808f5c65e072006d
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
Subject: [PATCH bpf-next v2 7/9] selftests/bpf: Verify tracing_multi link_create logs
Date: Sat, 14 Nov 2026 23:06:08 +0800
Message-ID: <20261114150610.84507-8-leon.hwang@linux.dev>
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

Check the error code, log message, and reported log size for a zero or
excessive count, missing IDs, invalid flags, and a nonzero target FD.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_link.c   | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
index 28154fdd2f0c..49fd62478438 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
@@ -6,6 +6,7 @@
 #include "xdp_dummy.skel.h"
 #include "kprobe_write_ctx.skel.h"
 #include "tracing_link_ctx.skel.h"
+#include "tracing_multi_fail.skel.h"
 
 static void test_fentry_link_create_log(int target_fd, __u32 target_btf_id, int cookie,
 					enum bpf_attach_type attach_type,
@@ -325,3 +326,104 @@ void test_tracing_link_log(void)
 	if (test__start_subtest("freplace_ctx_size"))
 		test_log_freplace_ctx_size();
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

