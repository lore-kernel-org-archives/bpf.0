Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6AB3CF689
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165863; cv=none; b=t5g8IaT2kbEY5vE10f9bhE1+HGPOvvZuPdGeV63Q/5/oF3Yrps6/OqIdtTqFOKns8Go+ZOYqXFICWTaTXEsYTrg3/h7dEMClI0hUYXIIBge9SwWqJuJWcsKV7Fm9GJafGVVCux/C84GPV+PY9MqN7kMS4dIKfFMTVWLEYdM8HtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165863; c=relaxed/simple;
	bh=0XKwPrVsLYqMkdidCVFKYLqUJ4c4EfyJ1ob1+L0+szc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3bK0jHTI7X790rwfrKwF95Od9vPMhSA7S4y8b3htX5Z/Sxvu7V1hAWG3hJIFrGK2QndEL1sZZxRpqui6qzIxkQMNlIWzHJR7cKIuh9qaELGg7aU7+jCiZeX3tf62zET3jbate2mzo3G0xDqmKmL4zXfduUxPE0gl+wN4q7QNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xI+6m4mw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xI+6m4mw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776165859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yPm78UqHyZkm1QqrS3WLRW2slYckpyvj6iqSa7dJaU=;
	b=xI+6m4mw4iR24mWikEbqUbtnMYM5+ZpcfMM5M6FbhOQ4Uufl8H2/De2LPdo8YObnMU+8Ud
	8Z2Ami6lZae5H3ObtR+5Ex8+w/cyMVqW7NSK4cZ7tjfp+iKINoDXYnJqAchxvk38DA+ZxR
	9EAsw2MiFlpnwzkFoGHnYiv6jAeT5rI=
From: KaFai Wan <kafai.wan@linux.dev>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover TCP_NODELAY in hdr opt callback
Date: Tue, 14 Apr 2026 19:23:10 +0800
Message-ID: <20260414112310.1285783-3-kafai.wan@linux.dev>
In-Reply-To: <20260414112310.1285783-1-kafai.wan@linux.dev>
References: <20260414112310.1285783-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a sockops test program that enables
BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG on connection setup and calls
bpf_setsockopt(TCP_NODELAY) from BPF_SOCK_OPS_HDR_OPT_LEN_CB.

Exercise the connection by sending data after the socket is
established. Before the fix, this setup can recurse through
tcp_push_pending_frames() and bpf_skops_hdr_opt_len() until the
kernel hits a stack guard page. After the fix, the connection
continues to make forward progress and the data exchange completes.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../bpf/prog_tests/tcp_hdr_options.c          | 34 +++++++++++++++++++
 .../bpf/progs/test_misc_tcp_hdr_options.c     | 18 ++++++++++
 2 files changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 56685fc03c7e..f361f9c7bf59 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -513,6 +513,39 @@ static void misc(void)
 	bpf_link__destroy(link);
 }
 
+static void hdr_sockopt(void)
+{
+	const char send_msg[] = "MISC!!!";
+	char recv_msg[sizeof(send_msg)];
+	const unsigned int nr_data = 2;
+	struct bpf_link *link;
+	struct sk_fds sk_fds;
+	int i, ret;
+
+	link = bpf_program__attach_cgroup(misc_skel->progs.misc_hdr_sockopt, cg_fd);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup(misc_hdr_sockopt)"))
+		return;
+
+	if (sk_fds_connect(&sk_fds, false)) {
+		bpf_link__destroy(link);
+		return;
+	}
+
+	for (i = 0; i < nr_data; i++) {
+		ret = send(sk_fds.active_fd, send_msg, sizeof(send_msg), 0);
+		if (!ASSERT_EQ(ret, sizeof(send_msg), "send(msg)"))
+			goto check_linum;
+
+		ret = read(sk_fds.passive_fd, recv_msg, sizeof(recv_msg));
+		if (!ASSERT_EQ(ret, sizeof(send_msg), "read(msg)"))
+			goto check_linum;
+	}
+
+check_linum:
+	sk_fds_close(&sk_fds);
+	bpf_link__destroy(link);
+}
+
 struct test {
 	const char *desc;
 	void (*run)(void);
@@ -526,6 +559,7 @@ static struct test tests[] = {
 	DEF_TEST(fastopen_estab),
 	DEF_TEST(fin),
 	DEF_TEST(misc),
+	DEF_TEST(hdr_sockopt),
 };
 
 void test_tcp_hdr_options(void)
diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
index d487153a839d..e1dc7246193e 100644
--- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
@@ -326,4 +326,22 @@ int misc_estab(struct bpf_sock_ops *skops)
 	return CG_OK;
 }
 
+SEC("sockops")
+int misc_hdr_sockopt(struct bpf_sock_ops *skops)
+{
+	int true_val = 1;
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+		set_hdr_cb_flags(skops, 0);
+		break;
+	case BPF_SOCK_OPS_HDR_OPT_LEN_CB:
+		bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+		break;
+	}
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

