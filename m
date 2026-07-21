Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903343E9C9
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673505; cv=none; b=kLgq7fmnl4aYWl3+UTeGR/RuTHl2DUxyVaU92r+McQtVzHT2tOHrYGFNA62NHIsVEDZjuqXXblbUCM+5zhx51rej7ziJ6oAIp1p0YUyiisQ+FQEKNlDmuzeyFvY2l1+duuXL+ZIGKKLlJXXuFWeUSiQa7wUhAefLu0Oi3A1WOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673505; c=relaxed/simple;
	bh=vYRv8k58w2CyhMVmSqDuCi/hXQhCUhaEV1xMDAbbB8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sn2yYi2NjiHUYDtffnE4jkO8rHROp29ctMJoCvotQbLhspIoBXkE23QzlPx2xH4TeUROFhdytxIjtmD5Wvh5RMpJvczBFNGHyiv469EBNi5q6ySJVgXCbMtA84qsNV0HnzX9z9uiLUy8Q2YOi1IvJJg5l4DpB5BjXF/UHh+DZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtSaAyw3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtSaAyw3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4956869750eso7558215e9.2
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784673493; x=1785278293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0WJnnhXlTqHAzSRlQQl5c6vDIzceJyXSF5sIOHpwqM=;
        b=rtSaAyw3kKIeLt3wil6o5gPokwp3DTcvn7mO2PemfJ3jtWaFuHigKAG7/aidr83WzC
         4c8ukyY1l7J2IWagMmTA2e2z3aSk2914hXkc/IzIchWzdAWvADe57/pH3xhFs8eggL1O
         TAZcCriNE63qvX8STfV3jD5kgmwBmezvkN4wiSceJnTjndfwHkYTJRhxU849Cm51bSWS
         w9a3KNp2wdv+wkGkfGXm8BiHXnWiniMWga1IdHnqNgKZsZBhAX/4aOgRD8tM1hGBM7YQ
         69k/UO/LNYzHaXyWsjff5y94HIckayRcR7Ao5LVZ9CE8LhsVDqfArJZR8qzStHq+Umw+
         L+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784673493; x=1785278293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z0WJnnhXlTqHAzSRlQQl5c6vDIzceJyXSF5sIOHpwqM=;
        b=oneuzpgU0Ro/gZe2ZfKOkLkl1JQrdRk+nrQYH3yX9a/NvGIMa40zwdPXBA4+ynRjeq
         W5hYFxzRwDY/9OrdOW9tyis9nsC54aBX3VKRFMMU17Bg6r9JDFqDayZPWno3bYSvvyfz
         3AcCrI75NV5QH7xrCZ+CNWTQgzI8sug/XQL2kYfbiOxyW826v6ohG5zPFbg+nYqDmd16
         BhlL1DHn2OC7pZ5BN8wPLSeJyKRT+GLkeo77pte9QYpploRUYbHjiY++4xG5NmQfrwfe
         Kv7GGmS8gUTclGuG9tHh0oJ1TnczEHjJF1Fcexoo3K8LDDVzekuaiT4IjlAh0z8UxNex
         JDqQ==
X-Gm-Message-State: AOJu0YyWbGLnv+t66cn8qmGucBFI+IaQdEREZZgwshIM+b+WuQuW4Abh
	+WZfZ8qDpHeCyeP+evnvuws+8NfTdFvPR9q4WOjkKW1daY7zhoT0t6sK
X-Gm-Gg: AfdE7cmDwjKCE07S5jGcjac8ioa1LP94z9p/t1ZtjK0xJle9hszZ+k/0xd7TAZqAzJ1
	HH37P4zwN7VJN94LK8e9C3LDHmyoH7z6d/z0Qi8Q+Aw0ZLThNFegKYpGcqkIimqUqvz1SqLaIuJ
	G8t5IHOk5ix211jB/OvZIdag7TP2hdsJBPscVphiNSqiEyA53/Dlo3AUnunkJLEsTMLH88CYVl0
	OYnpr+oNvddsK2XVOTyEFGtMpqqWwBcCEeJfxLAjt/Vnb/t6JuJygYOpahmq3tna0sxGZtjIpqd
	9F+pl2uKLXoxE7mnBK34kW/iQPraajxnRmKuzoV0Du0QYAZhVtjLKUci/kGJ147GmAIOvj7kXHu
	QdZ2IUDxFLMIrwxdHb3BhE9weCAQNhIIMqSp/M9mXgduSTA5TGvI4cLlLfHXArACufpqBzzxf2f
	49s5H7wL5gqb2YlKaoAZOIeaCXGLWqH7K6yReiZdYLsmzWBECrOGQ6Dv8mDT9KwhmonSq3go7Gr
	vI1
X-Received: by 2002:a05:600c:1396:b0:493:b150:c607 with SMTP id 5b1f17b1804b1-4954a3f36a9mr223998835e9.12.1784673493285;
        Tue, 21 Jul 2026 15:38:13 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c9d99sm101290455e9.12.2026.07.21.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:38:12 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: nnamdio@gmail.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashiko-reviews@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	emil@etsalapatis.com
Subject: [PATCH v7 2/2] selftests/bpf: add sockmap recvfrom EAGAIN selftest
Date: Tue, 21 Jul 2026 23:38:07 +0100
Message-ID: <20260721223807.75101-3-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721223807.75101-1-nnamdio@gmail.com>
References: <20260721223807.75101-1-nnamdio@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These selftests exercise the tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser()
functions, to ensure that they are properly handling spurious wakeups in
tcp_msg_wait_data().

The expected behaviour is that recvfrom() does not return an EAGAIN
error.  If the spurious wakeups are incorrectly handled, this assertion
will fail.

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..afda4d90e573 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1373,6 +1373,138 @@ static void test_sockmap_multi_channels(int sotype)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+static void *test_sockmap_recvfrom_eagain_thread(void *arg)
+{
+	int fd = *(int *)arg;
+	char buf[1024];
+	void *result = NULL;
+
+	while (true) {
+		ssize_t len = recvfrom(fd, buf, sizeof(buf), 0, NULL, NULL);
+
+		if (len == -1) {
+			if (errno == EINTR)
+				continue;
+			result = (void *)1;
+			break;
+		}
+
+		if (!len || buf[len - 1] == 'e')
+			break;
+	}
+
+	send(fd, "test", 4, MSG_NOSIGNAL);
+
+	close(fd);
+
+	return result;
+}
+
+static void test_sockmap_recvfrom_eagain(bool with_verdict)
+{
+	struct test_sockmap_pass_prog *skel = NULL;
+	struct bpf_program *prog = NULL;
+	char *buf = NULL;
+	int map, err;
+
+	/*
+	 * the size of the buffer to send.  completion of the sending can trigger a spurious wake
+	 * up.  larger values make the issue more likely, but make successful test runs longer.
+	 */
+	const size_t buflen = 1024 * 1024 * 25;
+
+	/*
+	 * maximum number of attempts to reproduce EAGAIN on spurious wake up.  more attempts
+	 * increases the chances of triggering the issue, and the test ends as soon as we do.
+	 * however, successful runs would take longer to complete.
+	 */
+	const int max_attempts = 300;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	if (with_verdict) {
+		prog = skel->progs.prog_skb_verdict;
+		err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
+		if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
+			goto cleanup;
+	}
+
+	buf = malloc(buflen);
+	if (!ASSERT_OK_PTR(buf, "malloc buf"))
+		goto cleanup;
+	memset(buf, 0, buflen);
+	buf[buflen - 1] = 'e';
+
+	for (int i = 0; i < max_attempts; ++i) {
+		ssize_t len;
+		char ignored[128];
+		pthread_t thread;
+		bool thread_created = false;
+		size_t rem = buflen;
+		int c = -1, p = -1, zero = 0;
+		bool success = false;
+
+		err = create_pair(AF_INET, SOCK_STREAM, &c, &p);
+		if (!ASSERT_OK(err, "create_pair"))
+			goto end_attempt;
+
+		err = pthread_create(&thread, NULL, &test_sockmap_recvfrom_eagain_thread, &p);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto end_attempt;
+		thread_created = true;
+
+		err = bpf_map_update_elem(map, &zero, &c, BPF_ANY);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto end_attempt;
+
+		while (rem) {
+			len = xsend(c, buf + (buflen - rem), rem, 0);
+			if (len == -1)
+				goto end_attempt;
+			rem -= len;
+		}
+
+		/* we cannot use recv_timeout(), otherwise EAGAIN would be an expected errno. */
+		len = recvfrom(c, ignored, sizeof(ignored), 0, NULL, NULL);
+
+		/*
+		 * we are checking for the invalid return of EAGAIN, any other return is considered
+		 * successful for the purposes of this test.
+		 */
+		if (len < 0 && !ASSERT_NEQ(errno, EAGAIN, "recvfrom eagain"))
+			goto end_attempt;
+
+		success = true;
+
+end_attempt:
+		if (c >= 0)
+			close(c);
+
+		if (thread_created) {
+			void *retval = NULL;
+
+			pthread_join(thread, &retval);
+			if (!ASSERT_NULL(retval, "retval"))
+				success = false;
+		}
+
+		if (!thread_created && p >= 0)
+			close(p);
+		if (!success)
+			break;
+	}
+
+cleanup:
+	if (buf)
+		free(buf);
+
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1451,4 +1583,8 @@ void test_sockmap_basic(void)
 		test_sockmap_multi_channels(SOCK_STREAM);
 	if (test__start_subtest("sockmap udp multi channels"))
 		test_sockmap_multi_channels(SOCK_DGRAM);
+	if (test__start_subtest("sockmap recvfrom eagain"))
+		test_sockmap_recvfrom_eagain(false);
+	if (test__start_subtest("sockmap recvfrom eagain with verdict"))
+		test_sockmap_recvfrom_eagain(true);
 }
-- 
2.52.0

