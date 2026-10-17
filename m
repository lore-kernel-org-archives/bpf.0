Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67833914E1
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247296; cv=none; b=ah/hqPn+5n/6HOxlb1czwaqwv/rAxpWFdD8o2MdlHncc45i31eApHw0MUtxyzhqEr46c2tpU3eJQZK+LGi+8jz+gNaOmOgrHkXSRBTlInibhi8ERdsiPTTHOgVvW8uCWIUYoPOFqo2V2qTTH1oZbw2mv9UzQrkQuxaaLnz/+tOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247296; c=relaxed/simple;
	bh=B4+DK3TAUkpyUy4A8hasWuoVXKoQJkWC5KL9mi6LfCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozV5ILaVRCu+W/7QRw8XhX4f+Y3PmAvplxHWhFlyjXOqOW29jd3ynRh786TYKIGqh16tD03RHIebkv29Lc6gNJOAj4Zj4Epx3ZKdmF3ToeyhWEjASdvBVYpZWVJPJH3Gm2/ah1VkejAIbfBq+DePQWrxhtMaaJiFZqrQ1kHDUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ilsob+uT; arc=none smtp.client-ip=91.218.175.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ilsob+uT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B4+DK3TAUkpyUy4A8hasWuoVXKoQJkWC5KL9mi6LfCw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792247292; v=1; x=1792852092;
 b=Ilsob+uTF7HZ5GGHzzhUeQT9bS4OmBru1Kw5bBP83G0P4uy2StsqnfJCMc+JYXD/D/0dfbKo
 Sr01KtSRTF/1j7918lh+UzqL+VqpWqTzjnLbYEK+49jY8ygyRjMQV+DCz13tlSXtG7Th9pFfSMU
 1Iz8if9g71Uj3IcfRbKxPyGc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3c10375e1e1aac6d;
	Sat, 17 Oct 2026 14:28:12 +0000
X-Mizu-Trace-ID: 3c10375e1e1aac6d
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Masashi Honma <masashi.honma@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 6/6] selftests/bpf: Add tests to verify link_create logs
Date: Sat, 17 Oct 2026 22:26:49 +0800
Message-ID: <20261017142649.51047-7-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017142649.51047-1-leon.hwang@linux.dev>
References: <20261017142649.51047-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to verify the new logs in link_create and xdp link_create,
including a log reported via extack when fail to create an xdp link.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/xdp_link.c       | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
index e7e9f3c22edf..e2b2ec3cc4e3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
@@ -150,3 +150,135 @@ void serial_test_xdp_link(void)
 	test_xdp_link__destroy(skel1);
 	test_xdp_link__destroy(skel2);
 }
+
+static void test_link_create_invalid_prog_fd(void)
+{
+	const char *msg = "Invalid prog_fd.\n";
+	char log_buf[128] = {};
+	int fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+
+	fd = bpf_link_create_log(-1, IFINDEX_LO, BPF_XDP, NULL, &log_opts);
+	if (!ASSERT_LT(fd, 0, "bpf_link_create_log")) {
+		close(fd);
+		return;
+	}
+
+	ASSERT_EQ(fd, -EBADF, "fd");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+}
+
+static void test_link_create_invalid_attach_type(void)
+{
+	const char *msg = "Invalid attach_type.\n";
+	struct test_xdp_link *skel;
+	char log_buf[128] = {};
+	int fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+
+	skel = test_xdp_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_link__open_and_load"))
+		return;
+
+	log_opts.true_size = 0;
+	fd = bpf_link_create_log(bpf_program__fd(skel->progs.xdp_handler), IFINDEX_LO,
+				 BPF_CGROUP_INET_INGRESS, NULL, &log_opts);
+	if (!ASSERT_LT(fd, 0, "bpf_link_create_log")) {
+		close(fd);
+		goto cleanup;
+	}
+
+	ASSERT_EQ(fd, -EINVAL, "fd");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+
+cleanup:
+	test_xdp_link__destroy(skel);
+}
+
+static void test_link_create_xdp_invalid_target_ifindex(void)
+{
+	const char *msg = "Invalid target_ifindex.\n";
+	struct test_xdp_link *skel;
+	char log_buf[128] = {};
+	int fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+
+	skel = test_xdp_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_link__open_and_load"))
+		return;
+
+	/* Interface indices are positive; zero cannot identify a device. */
+	fd = bpf_link_create_log(bpf_program__fd(skel->progs.xdp_handler), 0,
+				 BPF_XDP, NULL, &log_opts);
+	if (!ASSERT_LT(fd, 0, "bpf_link_create_log")) {
+		close(fd);
+		goto cleanup;
+	}
+
+	ASSERT_EQ(fd, -EINVAL, "fd");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+
+cleanup:
+	test_xdp_link__destroy(skel);
+}
+
+static void test_link_create_xdp_extack(void)
+{
+	const char *msg = "Invalid XDP flags for BPF link attachment";
+	struct test_xdp_link *skel;
+	char log_buf[128] = {};
+	int fd;
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = XDP_FLAGS_REPLACE,
+	);
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+
+	skel = test_xdp_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_link__open_and_load"))
+		return;
+
+	fd = bpf_link_create_log(bpf_program__fd(skel->progs.xdp_handler), IFINDEX_LO,
+				 BPF_XDP, &opts, &log_opts);
+	if (!ASSERT_LT(fd, 0, "bpf_link_create_log")) {
+		close(fd);
+		goto cleanup;
+	}
+
+	ASSERT_EQ(fd, -EINVAL, "fd");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+
+cleanup:
+	test_xdp_link__destroy(skel);
+}
+
+void test_link_create_log(void)
+{
+	if (test__start_subtest("invalid_prog_fd"))
+		test_link_create_invalid_prog_fd();
+	if (test__start_subtest("invalid_attach_type"))
+		test_link_create_invalid_attach_type();
+	if (test__start_subtest("xdp/invalid_target_ifindex"))
+		test_link_create_xdp_invalid_target_ifindex();
+	if (test__start_subtest("xdp/extack"))
+		test_link_create_xdp_extack();
+}
-- 
2.55.0

