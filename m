Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714D3624AB;
	Tue, 21 Apr 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787186; cv=none; b=lTmBtMAz0qaRqT3vM3P2nr6Cq26g9gLowj/a/T93uWdcPxBju3G4pHpePYi27vDiehjVL2VwDuCULCQ0EgMaTmkLAac8GAKUeTmRNuh3S/B7MPBph2kvTjU6RPUW0Muk/QxZNd/W1BKbkvgG+RI7PkF6bc1OaStpz2eYjZsEg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787186; c=relaxed/simple;
	bh=jmlhbGs2XEQ0YVEdPg2DhM9HBiM8Cev4qjA75thKJbc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsoN0b6zFdlz9CcN9d3IsRv2Q2X221JcBhZagAQik4R6/O+6wQ5NysldqqmV2rmoXGc6V6JGdkSTy2S/+dsbt3rHUcSG9j1642Cxi4vtxMAB/Vaq6FplgrJyBSvfGbotAjBDjav4n6jNfWs7HLQcX2dy3yGmBqgT2yW/cNEswcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LtHsRblZ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LtHsRblZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776787183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMeS4rzJcZIOSoAT809/HlFM/RGvuB7M1xVMHKcnJ/Y=;
	b=LtHsRblZ2tpH4N7M8BgjS7cr3iaOjnftJcbVtEQU++kDe3Ox+eE9tuZ6yPoVbSIfmE5P52
	TQ0bVLvkYFNblETFFQ8BOhavCoF2T8LNC71MmUlDhZo99OuGDKaKIKt7EUFimh2IPh8MB8
	SP6LN4PYAf57bWmD9FJu8EnTJ4PZzSo=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	ihor.solodrai@linux.dev,
	kafai.wan@linux.dev,
	jiayuan.chen@linux.dev,
	hoyeon.lee@suse.com,
	ameryhung@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 3/4] selftests/bpf: Test TCP_NODELAY in TCP hdr opt callbacks
Date: Tue, 21 Apr 2026 23:58:03 +0800
Message-ID: <20260421155804.135786-4-kafai.wan@linux.dev>
In-Reply-To: <20260421155804.135786-1-kafai.wan@linux.dev>
References: <20260421155804.135786-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a sockops selftest for the TCP_NODELAY restriction in
BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB.

With BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG enabled,
bpf_setsockopt(TCP_NODELAY) returns -EOPNOTSUPP from
BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB, avoiding
unbounded recursion and kernel stack overflow.

Other cases continue to work as before, including
BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/tcp_hdr_options.c    |  6 ++++++
 .../bpf/progs/test_misc_tcp_hdr_options.c         | 15 ++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 56685fc03c7e..21632e0946c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -507,6 +507,12 @@ static void misc(void)
 
 	ASSERT_EQ(misc_skel->bss->nr_hwtstamp, 0, "nr_hwtstamp");
 
+	ASSERT_TRUE(misc_skel->data->nodelay_est_ok, "nodelay_est_ok");
+
+	ASSERT_TRUE(misc_skel->data->nodelay_hdr_len_reject, "nodelay_hdr_len_reject");
+
+	ASSERT_TRUE(misc_skel->data->nodelay_write_hdr_reject, "nodelay_write_hdr_reject");
+
 check_linum:
 	ASSERT_FALSE(check_error_linum(&sk_fds), "check_error_linum");
 	sk_fds_close(&sk_fds);
diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
index d487153a839d..e77ec6791092 100644
--- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
@@ -29,6 +29,10 @@ unsigned int nr_syn = 0;
 unsigned int nr_fin = 0;
 unsigned int nr_hwtstamp = 0;
 
+bool nodelay_est_ok = true;
+bool nodelay_hdr_len_reject = true;
+bool nodelay_write_hdr_reject = true;
+
 /* Check the header received from the active side */
 static int __check_active_hdr_in(struct bpf_sock_ops *skops, bool check_syn)
 {
@@ -300,7 +304,7 @@ static int handle_passive_estab(struct bpf_sock_ops *skops)
 SEC("sockops")
 int misc_estab(struct bpf_sock_ops *skops)
 {
-	int true_val = 1;
+	int true_val = 1, false_val = 0, ret;
 
 	switch (skops->op) {
 	case BPF_SOCK_OPS_TCP_LISTEN_CB:
@@ -316,10 +320,19 @@ int misc_estab(struct bpf_sock_ops *skops)
 	case BPF_SOCK_OPS_PARSE_HDR_OPT_CB:
 		return handle_parse_hdr(skops);
 	case BPF_SOCK_OPS_HDR_OPT_LEN_CB:
+		ret = bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+		nodelay_hdr_len_reject &= ret == -EOPNOTSUPP;
+
 		return handle_hdr_opt_len(skops);
 	case BPF_SOCK_OPS_WRITE_HDR_OPT_CB:
+		ret = bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+		nodelay_write_hdr_reject &= ret == -EOPNOTSUPP;
+
 		return handle_write_hdr_opt(skops);
 	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+		ret = bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &false_val, sizeof(false_val));
+		nodelay_est_ok &= ret == 0;
+
 		return handle_passive_estab(skops);
 	}
 
-- 
2.43.0

