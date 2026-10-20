Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510169;
	b=ZwG0Iojlk6RtpkLcJaQKEcRn1xSuFGBaOiDbH+Wi88EZTUcq5N8XhgZ/wD5pfNKzJyC0
	 4SKr8V63ZVPati6pT3LLlinB5oUDsni6pZUvK0GZhaxSaGJe9QCdiYkUUw/rpzuFaBuBy
	 QAqm8j7JCcB8a1xKftMuUNIg7WSEsyKdjcAd4qNoNYrLxor/0W4HcmqCPj1kRCqat/gjo
	 s9/ySrunTfA0VuQcUyJ12d4t883ejxryayJKAxy87gyOiMSOG5skMlCmT7z19GgnOlp+t
	 YEAVb047Ly5GK9w871/t6i/slyIxASLT9yGVvLdyzaqnpcKyD+xIlE432Oc98pgkQpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510169;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9GDFV35RrSVf5yP47jS+7rs1H7n+XBgiZq3zykV+XtQ=;
	b=fElMfecwp0gSLDPs9bKEaHfXN9vRg0IVr0ylKSx4j0VmYj/gw97fMgQbjaWnwpVZafd/
	 o+p53Sk6Rk322gYB/FY99QDQvPfKZrITE4XnpRdbSrLTtAsYDCQ27fTpHl6zRP1bDeXwm
	 QEbkvAucJv4aFH0qJ6YrNakW4xj247+6KF1GgtZ+n9jpnDXYjcFuvmckWsGTucM68Tl3I
	 vctayytgAdZUEpMzEbW5EU3wRtK+hZerNaoZwEks3m59AfIv2LN/VmCZYj7z9kRbENKMp
	 Ib7WRhpLOiVoEH2VWBOt+3S8CvEsq8nxefW9SU4R7WIHwk0tVK0CQMLNJUA7sm71FmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p92AzfhW;
	arc=none smtp.remote-ip=95.215.58.165
Received: from mta1.migadu.com (out-165.mta1.migadu.com [95.215.58.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4873606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 15:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4873606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p92AzfhW
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qDoOdKi6oKQdzWjw9ttiqe9bR4kfbpGeSoHF507AHt0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792510166; v=1; x=1793114966;
 b=p92AzfhWed4SyYzF49MR++ac8jKwi80XZSID3tvwg8/O0Mplg2Ajaj9K66S/IOXdNs4eyymr
 QgJbWWwiOa1QWBxdQFbUJZxFw5iymDOps+oJsRwKMqbJmHtfL4dlWgY0m58xM7/2NSsnLvAXg+g
 te54vjopRcRCbsDE0xj/pC6c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4a298b9aecc1ef70;
	Tue, 20 Oct 2026 15:29:26 +0000
X-Mizu-Trace-ID: 4a298b9aecc1ef70
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
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: Add tests to verify link_create logs
Date: Tue, 20 Oct 2026 23:28:04 +0800
Message-ID: <20261020152804.39863-7-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020152804.39863-1-leon.hwang@linux.dev>
References: <20261020152804.39863-1-leon.hwang@linux.dev>
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

Add tests to verify the new logs in link_create and xdp link_create,
including a log reported via extack when fail to create an xdp link.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/xdp_link.c       | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
index e7e9f3c22edf..18c1f1039d4e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
@@ -150,3 +150,104 @@ void serial_test_xdp_link(void)
 	test_xdp_link__destroy(skel1);
 	test_xdp_link__destroy(skel2);
 }
+
+static void test_link_create(int prog_fd, int ifindex, enum bpf_attach_type attach_type,
+			     struct bpf_link_create_opts *opts, int exp_err, const char *msg)
+{
+	char log_buf[128] = {};
+	int fd;
+	LIBBPF_OPTS(bpf_log_opts, log_opts,
+		    .buf = log_buf,
+		    .size = sizeof(log_buf),
+		    .level = 1,
+	);
+
+	fd = bpf_link_create_log(prog_fd, ifindex, attach_type, opts, &log_opts);
+	if (!ASSERT_LT(fd, 0, "bpf_link_create_log")) {
+		close(fd);
+		return;
+	}
+
+	ASSERT_EQ(fd, exp_err, "fd");
+	ASSERT_STREQ(log_buf, msg, "log_buf");
+	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
+}
+
+static void test_link_create_invalid_prog_fd(void)
+{
+	const char *msg = "Invalid prog_fd.\n";
+
+	test_link_create(-1, IFINDEX_LO, BPF_XDP, NULL, -EBADF, msg);
+}
+
+static void test_link_create_invalid_prog_type(void)
+{
+	const struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	const char *msg = "Invalid prog type.\n";
+	int prog_fd;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_LIRC_MODE2, NULL, "GPL", insns,
+				ARRAY_SIZE(insns), NULL);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_prog_load"))
+		return;
+
+	test_link_create(prog_fd, 0, BPF_LIRC_MODE2, NULL, -EINVAL, msg);
+
+	close(prog_fd);
+}
+
+static void test_link_create_attach(int ifindex, enum bpf_attach_type attach_type,
+				    struct bpf_link_create_opts *opts, const char *msg)
+{
+	struct test_xdp_link *skel;
+
+	skel = test_xdp_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_link__open_and_load"))
+		return;
+
+	test_link_create(bpf_program__fd(skel->progs.xdp_handler), ifindex, attach_type, opts,
+			 -EINVAL, msg);
+
+	test_xdp_link__destroy(skel);
+}
+
+static void test_link_create_invalid_attach_type(void)
+{
+	const char *msg = "Invalid attach_type.\n";
+
+	test_link_create_attach(IFINDEX_LO, BPF_CGROUP_INET_INGRESS, NULL, msg);
+}
+
+static void test_link_create_xdp_invalid_target_ifindex(void)
+{
+	const char *msg = "Invalid target_ifindex.\n";
+
+	test_link_create_attach(0, BPF_XDP, NULL, msg);
+}
+
+static void test_link_create_xdp_extack(void)
+{
+	const char *msg = "Invalid XDP flags for BPF link attachment\n";
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = XDP_FLAGS_REPLACE,
+	);
+
+	test_link_create_attach(IFINDEX_LO, BPF_XDP, &opts, msg);
+}
+
+void test_link_create_log(void)
+{
+	if (test__start_subtest("invalid_prog_fd"))
+		test_link_create_invalid_prog_fd();
+	if (test__start_subtest("invalid_prog_type"))
+		test_link_create_invalid_prog_type();
+	if (test__start_subtest("invalid_attach_type"))
+		test_link_create_invalid_attach_type();
+	if (test__start_subtest("xdp/invalid_target_ifindex"))
+		test_link_create_xdp_invalid_target_ifindex();
+	if (test__start_subtest("xdp/extack"))
+		test_link_create_xdp_extack();
+}
-- 
2.55.0

