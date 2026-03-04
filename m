Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3137BE80
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658759; cv=none; b=NETmDZOtqoChrO1LVwbs1yAxwCELOhQ/zrjsAXjV46vcyJWkbmqxZzpckEUCKvdGtG13e9vOphAqPyLf0zaqOJnrcvMNApoiOBIYzxVyRHHDqfU8HG/03pStvPT3Dsepri5pM6UOWmxXg39QJcOEteWH29c40DrDGFC57pLSjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658759; c=relaxed/simple;
	bh=N7P2noziNQR7GL6ShTCQFobzyEsC8M1jlW0k69lAYdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGWUc53UREi4UCOuLEr11UDQSCsothnR/C/hbvdgxy7suQoRitwLooRpl86o6Fymvadmdnw0ugJyZREbon8W3s1B7/XPV7svxpZ85S2wS/zlSAtvrbi8ZRbrstXoMYaquD0NnUdt8M7OP1PzkNUupPsMX9Rv7skwCz4kBrwxeLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test LINK_DETACH for perf link
Date: Wed,  4 Mar 2026 22:02:12 +0100
Message-ID: <20260304210212.235096-3-dev@der-flo.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304210212.235096-1-dev@der-flo.net>
References: <20260304210212.235096-1-dev@der-flo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add serial_test_perf_link_detach() to verify that the new LINK_DETACH
support for BPF perf links works correctly.  The test creates a link
to a BPF program for a software perf event, confirms the program is
executed, calls bpf_link__detach() to exercise the BPF_LINK_DETACH syscall
path, and then verifies the program is no longer invoked after detach.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 .../selftests/bpf/prog_tests/perf_link.c      | 81 ++++++++++++++++---
 1 file changed, 68 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
index d940ff87fa08..40e2ad0f843e 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -27,30 +27,85 @@ static void burn_cpu(void)
 		++j;
 }
 
-/* TODO: often fails in concurrent mode */
-void serial_test_perf_link(void)
+static int perf_link_setup(struct test_perf_link **skel, int *pfd)
 {
-	struct test_perf_link *skel = NULL;
 	struct perf_event_attr attr;
-	int pfd = -1, link_fd = -1, err;
-	int run_cnt_before, run_cnt_after;
-	struct bpf_link_info info;
-	__u32 info_len = sizeof(info);
-	__u64 timeout_time_ns;
 
-	/* create perf event */
 	memset(&attr, 0, sizeof(attr));
 	attr.size = sizeof(attr);
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq = 1;
 	attr.sample_freq = 1000;
-	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
-	if (!ASSERT_GE(pfd, 0, "perf_fd"))
+	*pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+	if (!ASSERT_GE(*pfd, 0, "perf_fd"))
+		return -1;
+
+	*skel = test_perf_link__open_and_load();
+	if (!ASSERT_OK_PTR(*skel, "skel_load"))
+		return -1;
+
+	return 0;
+}
+
+void serial_test_perf_link_detach(void)
+{
+	struct test_perf_link *skel = NULL;
+	int pfd = -1, link_fd = -1, err;
+	int run_cnt_before, run_cnt_after;
+	__u64 timeout_time_ns;
+
+	if (perf_link_setup(&skel, &pfd))
+		goto cleanup;
+
+	link_fd = bpf_link_create(bpf_program__fd(skel->progs.handler), pfd,
+				  BPF_PERF_EVENT, NULL);
+	if (!ASSERT_GE(link_fd, 0, "link_fd"))
 		goto cleanup;
 
-	skel = test_perf_link__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_load"))
+	/* ensure we get at least one perf_event prog execution */
+	timeout_time_ns = get_time_ns() + BURN_TIMEOUT_NS;
+	while (true) {
+		burn_cpu();
+		if (skel->bss->run_cnt > 0)
+			break;
+		if (!ASSERT_LT(get_time_ns(), timeout_time_ns, "run_cnt_timeout"))
+			goto cleanup;
+	}
+
+	/* detach via BPF_LINK_DETACH - BPF program should no longer be executed */
+	err = bpf_link_detach(link_fd);
+	if (!ASSERT_OK(err, "link_detach"))
+		goto cleanup;
+
+	/* make sure there are no stragglers */
+	kern_sync_rcu();
+
+	run_cnt_before = skel->bss->run_cnt;
+	burn_cpu();
+	run_cnt_after = skel->bss->run_cnt;
+
+	ASSERT_EQ(run_cnt_before, run_cnt_after, "run_cnt_detached");
+
+cleanup:
+	if (link_fd >= 0)
+		close(link_fd);
+	if (pfd >= 0)
+		close(pfd);
+	test_perf_link__destroy(skel);
+}
+
+/* TODO: often fails in concurrent mode */
+void serial_test_perf_link(void)
+{
+	struct test_perf_link *skel = NULL;
+	int pfd = -1, link_fd = -1, err;
+	int run_cnt_before, run_cnt_after;
+	struct bpf_link_info info;
+	__u32 info_len = sizeof(info);
+	__u64 timeout_time_ns;
+
+	if (perf_link_setup(&skel, &pfd))
 		goto cleanup;
 
 	link_fd = bpf_link_create(bpf_program__fd(skel->progs.handler), pfd,
-- 
2.53.0

