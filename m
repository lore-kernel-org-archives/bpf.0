Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206836;
	b=5OfFNAPettBi/TvT8sCaAXFoYncneS8RjKZY9aGMsD7KQIqKASGIw7FPuxvB6RY0sw1I
	 LkI88bzl9WW83qKUUM3AM/YPlIWq573+PUI3+/q37aq+f/nOrBmSvDT4sMnYy2iHmHANp
	 g0UibZgP0SBR7smDA8IYs7RgpY89dyV0OvctdWegnG9BEq3DOvnCvYswV9g3T7zgcqVrH
	 RYsLL7StvksfgP9xHSxIA4gavdRF9DvVJuTYm1FuMJVBvnTnC+HOUYLTAsWqn8oe48Uad
	 5xRpSsYGuRZj94v/sb+/4623+9M2urfbS0b4bDLxWrnou8HzDbQBqrMT3ED80T3VAaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206836;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OHihYTgDAjgb7+Ul30k56sQg0Sp67zUezeBIIXN9HdA=;
	b=CVoxutJRsD9ahAw0CQTjr7XsaX15SniB5ilz8JLGPnTLy1U4WsffbW1cFRshE3ep3xDG
	 C3Qk/SCCwMlkRZc3IydJg/PluiNyiXsc5q+UnGHvkHfLu85Gm2rXoY4qH2Ny8rJ1iB0g4
	 WOPhIUstDIf66FMxBPBlfV6I2BQWmYhI/eOBxTWLPhEM9HF1hwjfNuVtvZpEYlo4Qd5cd
	 bQ/W6JGhysaqp4MslY9I5DZgpk+3ZssWSIzXt1TaDkXaywBu79gBrEjJ8Sr8bSKRYJ+I9
	 FMj7zdEevb+4cNHEFOTbgXKdI7wtK7vb8qc8W2XprGgcZBq/1V07iJiq/R/1vmkWlXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c86ulGuv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AA60A261A;
	Fri, 20 Nov 2026 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c86ulGuv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E881F000EB;
	Fri, 20 Nov 2026 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206835;
	bh=OHihYTgDAjgb7+Ul30k56sQg0Sp67zUezeBIIXN9HdA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c86ulGuv3YuJ9Km2WcBOBZinar/roFA/xyEdawFtFBRf8bE/+Z9uehWaCEvLcufu3
	 LQSNQle+QxAqufpC3fw9saI6Ab9dOKcn7sDqW2iqOx7u1ILO0fEbCA/UOXB6lyDVyC
	 797USenB1wymXRwMWd7yonGU+CSPtobNoM0/YsFaorNboZgpon6oyB58YPsa3D39zt
	 3tlookbmvRr6df09gaF0qYR6uwmykDVOd4e1RQlmx/MmjRpFGaSSBK99+aM1wP82lD
	 IvcKJK9W/FwsHeGu7tnY87lxpswFBnN3Kc6vsbPamzwOnbDZDVQJ2DWBzsmPjF4jSE
	 cc0K17wrBYqrg==
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 20 Nov 2026 15:33:19 -0500
Subject: [PATCH bpf-next v3 6/8] selftests/bpf: Refactor lifetimes and test
 wakeups
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-bpf-ringbuf-fixes-v3-6-ff7ca15d6c37@kernel.org>
References: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
In-Reply-To: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Andrea Righi <arighi@nvidia.com>, Xu Kuohai <xukuohai@huawei.com>, 
 Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=25787; i=tamird@kernel.org;
 h=from:subject:message-id; bh=KH6Gw6KzJ9YIA5YMqlLjYNuUeNEGb3l2prcidkhVWK4=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNkM62a5z2B/enamtfnxlm1aOyxaLISsDl828H2t92max
 2kJ/u8rOiayMIhxMViKKbIkih7am556e49s5rvjMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEz1FgNGhvUJm7q29ER6v/tx0aUjt8vq3Hr5/9PsygT/fH3ApvjyxjxGhjOhd0v
 3FodNFT1/7vKiKwzfvsxtVJy9ooy5sMUsVGaeHiMA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Use cleanup attributes for skeletons, managers, and file descriptors in
the ring buffer tests. Pass skeletons and managers explicitly, and stop
or cancel worker threads before joining them. Preserve the existing
zero-bound, NULL-callback, and overwrite-map regression cases.

Add edge-triggered readiness coverage that consumes one record per call
to exercise the wakeup handshake across bounded returns.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 465 +++++++++++++++--------
 1 file changed, 310 insertions(+), 155 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 29be2476c478..633e10aa5537 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -30,8 +30,6 @@ struct sample {
 	char comm[16];
 };
 
-static int sample_cnt;
-
 static void atomic_inc(int *cnt)
 {
 	__atomic_add_fetch(cnt, 1, __ATOMIC_SEQ_CST);
@@ -44,9 +42,10 @@ static int atomic_xchg(int *cnt, int val)
 
 static int process_sample(void *ctx, void *data, size_t len)
 {
+	int *sample_cnt = ctx;
 	struct sample *s = data;
 
-	atomic_inc(&sample_cnt);
+	atomic_inc(sample_cnt);
 
 	switch (s->seq) {
 	case 0:
@@ -63,11 +62,76 @@ static int process_sample(void *ctx, void *data, size_t len)
 	}
 }
 
-static struct test_ringbuf_map_key_lskel *skel_map_key;
-static struct test_ringbuf_lskel *skel;
-static struct ring_buffer *ringbuf;
+static void cleanup_ring_buffer(struct ring_buffer **rb)
+{
+	if (*rb)
+		ring_buffer__free(*rb);
+}
+
+static void cleanup_test_ringbuf_lskel(struct test_ringbuf_lskel **skel)
+{
+	if (*skel)
+		test_ringbuf_lskel__destroy(*skel);
+}
+
+static void cleanup_fd(int *fd)
+{
+	if (*fd >= 0)
+		close(*fd);
+}
+
+static void cleanup_test_ringbuf_n_lskel(struct test_ringbuf_n_lskel **skel)
+{
+	if (*skel)
+		test_ringbuf_n_lskel__destroy(*skel);
+}
+
+static void
+cleanup_test_ringbuf_map_key_lskel(struct test_ringbuf_map_key_lskel **skel)
+{
+	if (*skel)
+		test_ringbuf_map_key_lskel__destroy(*skel);
+}
+
+static void
+cleanup_test_ringbuf_write_lskel(struct test_ringbuf_write_lskel **skel)
+{
+	if (*skel)
+		test_ringbuf_write_lskel__destroy(*skel);
+}
+
+static void
+cleanup_test_ringbuf_overwrite_lskel(struct test_ringbuf_overwrite_lskel **skel)
+{
+	if (*skel)
+		test_ringbuf_overwrite_lskel__destroy(*skel);
+}
+
+struct poll_ctx {
+	struct ring_buffer *ringbuf;
+	long timeout;
+};
+
+struct thread_guard {
+	pthread_t thread;
+	bool *stop;
+	bool joined;
+};
+
+static void cleanup_thread(struct thread_guard *thread)
+{
+	if (thread->joined)
+		return;
+
+	if (thread->stop)
+		__atomic_store_n(thread->stop, true, __ATOMIC_RELAXED);
+	else
+		pthread_cancel(thread->thread);
+	pthread_join(thread->thread, NULL);
+	thread->joined = true;
+}
 
-static void trigger_samples()
+static void trigger_samples(struct test_ringbuf_lskel *skel)
 {
 	skel->bss->dropped = 0;
 	skel->bss->total = 0;
@@ -80,21 +144,25 @@ static void trigger_samples()
 	syscall(__NR_getpgid);
 }
 
-static void *poll_thread(void *input)
+static void *poll_thread(void *arg)
 {
-	long timeout = (long)input;
+	struct poll_ctx *ctx = arg;
 
-	return (void *)(long)ring_buffer__poll(ringbuf, timeout);
+	return (void *)(long)ring_buffer__poll(ctx->ringbuf, ctx->timeout);
 }
 
 static void ringbuf_write_subtest(void)
 {
-	struct test_ringbuf_write_lskel *skel;
+	struct test_ringbuf_write_lskel *skel
+		__attribute__((cleanup(cleanup_test_ringbuf_write_lskel))) =
+			test_ringbuf_write_lskel__open();
 	int page_size = getpagesize();
 	size_t *mmap_ptr;
 	int err, rb_fd;
+	struct ring_buffer *ringbuf
+		__attribute__((cleanup(cleanup_ring_buffer))) = NULL;
+	int sample_cnt = 0;
 
-	skel = test_ringbuf_write_lskel__open();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
@@ -102,25 +170,25 @@ static void ringbuf_write_subtest(void)
 
 	err = test_ringbuf_write_lskel__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
-		goto cleanup;
+		return;
 
 	rb_fd = skel->maps.ringbuf.map_fd;
 
 	mmap_ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, rb_fd, 0);
 	if (!ASSERT_OK_PTR(mmap_ptr, "rw_cons_pos"))
-		goto cleanup;
+		return;
 	*mmap_ptr = 0x30000;
 	ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_rw");
 
 	skel->bss->pid = getpid();
 
-	ringbuf = ring_buffer__new(rb_fd, process_sample, NULL, NULL);
+	ringbuf = ring_buffer__new(rb_fd, process_sample, &sample_cnt, NULL);
 	if (!ASSERT_OK_PTR(ringbuf, "ringbuf_new"))
-		goto cleanup;
+		return;
 
 	err = test_ringbuf_write_lskel__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
-		goto cleanup_ringbuf;
+		return;
 
 	skel->bss->discarded = 0;
 	skel->bss->passed = 0;
@@ -131,12 +199,6 @@ static void ringbuf_write_subtest(void)
 
 	ASSERT_EQ(skel->bss->discarded, 2, "discarded");
 	ASSERT_EQ(skel->bss->passed, 0, "passed");
-
-	test_ringbuf_write_lskel__detach(skel);
-cleanup_ringbuf:
-	ring_buffer__free(ringbuf);
-cleanup:
-	test_ringbuf_write_lskel__destroy(skel);
 }
 
 static void ringbuf_subtest(void)
@@ -150,8 +212,13 @@ static void ringbuf_subtest(void)
 	struct ring *ring;
 	int map_fd;
 	unsigned long avail_data, ring_size, cons_pos, prod_pos;
+	struct test_ringbuf_lskel *skel
+		__attribute__((cleanup(cleanup_test_ringbuf_lskel))) =
+			test_ringbuf_lskel__open();
+	struct ring_buffer *ringbuf
+		__attribute__((cleanup(cleanup_ring_buffer))) = NULL;
+	int sample_cnt = 0;
 
-	skel = test_ringbuf_lskel__open();
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
 		return;
 
@@ -159,7 +226,7 @@ static void ringbuf_subtest(void)
 
 	err = test_ringbuf_lskel__load(skel);
 	if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
-		goto cleanup;
+		return;
 
 	rb_fd = skel->maps.ringbuf.map_fd;
 	/* good read/write cons_pos */
@@ -167,7 +234,7 @@ static void ringbuf_subtest(void)
 	ASSERT_OK_PTR(mmap_ptr, "rw_cons_pos");
 	tmp_ptr = mremap(mmap_ptr, page_size, 2 * page_size, MREMAP_MAYMOVE);
 	if (!ASSERT_ERR_PTR(tmp_ptr, "rw_extend"))
-		goto cleanup;
+		return;
 	ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_EXEC), "exec_cons_pos_protect");
 	ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_rw");
 
@@ -190,7 +257,7 @@ static void ringbuf_subtest(void)
 	/* good read-only pages */
 	mmap_ptr = mmap(NULL, 4 * page_size, PROT_READ, MAP_SHARED, rb_fd, 0);
 	if (!ASSERT_OK_PTR(mmap_ptr, "ro_prod_pos"))
-		goto cleanup;
+		return;
 
 	ASSERT_ERR(mprotect(mmap_ptr, 4 * page_size, PROT_WRITE), "write_protect");
 	ASSERT_ERR(mprotect(mmap_ptr, 4 * page_size, PROT_EXEC), "exec_protect");
@@ -200,7 +267,7 @@ static void ringbuf_subtest(void)
 	/* good read-only pages with initial offset */
 	mmap_ptr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, rb_fd, page_size);
 	if (!ASSERT_OK_PTR(mmap_ptr, "ro_prod_pos"))
-		goto cleanup;
+		return;
 
 	ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_WRITE), "write_protect");
 	ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_EXEC), "exec_protect");
@@ -210,20 +277,20 @@ static void ringbuf_subtest(void)
 	/* only trigger BPF program for current process */
 	skel->bss->pid = getpid();
 
-	ringbuf = ring_buffer__new(skel->maps.ringbuf.map_fd,
-				   process_sample, NULL, NULL);
+	ringbuf = ring_buffer__new(skel->maps.ringbuf.map_fd, process_sample,
+				   &sample_cnt, NULL);
 	if (CHECK(!ringbuf, "ringbuf_create", "failed to create ringbuf\n"))
-		goto cleanup;
+		return;
 
 	err = test_ringbuf_lskel__attach(skel);
 	if (CHECK(err, "skel_attach", "skeleton attachment failed: %d\n", err))
-		goto cleanup;
+		return;
 
-	trigger_samples();
+	trigger_samples(skel);
 
 	ring = ring_buffer__ring(ringbuf, 0);
 	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring_idx_0"))
-		goto cleanup;
+		return;
 
 	map_fd = ring__map_fd(ring);
 	ASSERT_EQ(map_fd, skel->maps.ringbuf.map_fd, "ring_map_fd");
@@ -259,14 +326,14 @@ static void ringbuf_subtest(void)
 
 	/* -EDONE is used as an indicator that we are done */
 	if (CHECK(err != -EDONE, "err_done", "done err: %d\n", err))
-		goto cleanup;
+		return;
 	cnt = atomic_xchg(&sample_cnt, 0);
 	CHECK(cnt != 2, "cnt", "exp %d samples, got %d\n", 2, cnt);
 
 	/* we expect extra polling to return nothing */
 	err = ring_buffer__poll(ringbuf, 0);
 	if (CHECK(err != 0, "extra_samples", "poll result: %d\n", err))
-		goto cleanup;
+		return;
 	cnt = atomic_xchg(&sample_cnt, 0);
 	CHECK(cnt != 0, "cnt", "exp %d samples, got %d\n", 0, cnt);
 
@@ -278,7 +345,7 @@ static void ringbuf_subtest(void)
 	      1L, skel->bss->discarded);
 
 	/* now validate consumer position is updated and returned */
-	trigger_samples();
+	trigger_samples(skel);
 	CHECK(skel->bss->cons_pos != 3 * rec_sz,
 	      "err_cons_pos", "exp %ld, got %ld\n",
 	      3L * rec_sz, skel->bss->cons_pos);
@@ -288,24 +355,35 @@ static void ringbuf_subtest(void)
 	CHECK(cnt != 2, "cnt", "exp %d samples, got %d\n", 2, cnt);
 
 	/* start poll in background w/ long timeout */
-	err = pthread_create(&thread, NULL, poll_thread, (void *)(long)10000);
+	struct poll_ctx poll_ctx = {
+		.ringbuf = ringbuf,
+		.timeout = 10000,
+	};
+	err = pthread_create(&thread, NULL, poll_thread, &poll_ctx);
 	if (CHECK(err, "bg_poll", "pthread_create failed: %d\n", err))
-		goto cleanup;
+		return;
+	struct thread_guard thread_guard
+		__attribute__((cleanup(cleanup_thread))) = {
+			.thread = thread,
+			.joined = false,
+		};
 
 	/* turn off notifications now */
 	skel->bss->flags = BPF_RB_NO_WAKEUP;
 
 	/* give background thread a bit of a time */
 	usleep(50000);
-	trigger_samples();
+	trigger_samples(skel);
 	/* sleeping arbitrarily is bad, but no better way to know that
 	 * epoll_wait() **DID NOT** unblock in background thread
 	 */
 	usleep(50000);
 	/* background poll should still be blocked */
 	err = pthread_tryjoin_np(thread, (void **)&bg_ret);
+	if (!err)
+		thread_guard.joined = true;
 	if (CHECK(err != EBUSY, "try_join", "err %d\n", err))
-		goto cleanup;
+		return;
 
 	/* BPF side did everything right */
 	CHECK(skel->bss->dropped != 0, "err_dropped", "exp %ld, got %ld\n",
@@ -323,12 +401,14 @@ static void ringbuf_subtest(void)
 	/* produce new samples, no notification should be triggered, because
 	 * consumer is now behind
 	 */
-	trigger_samples();
+	trigger_samples(skel);
 
 	/* background poll should still be blocked */
 	err = pthread_tryjoin_np(thread, (void **)&bg_ret);
+	if (!err)
+		thread_guard.joined = true;
 	if (CHECK(err != EBUSY, "try_join", "err %d\n", err))
-		goto cleanup;
+		return;
 
 	/* still no samples, because consumer is behind */
 	cnt = atomic_xchg(&sample_cnt, 0);
@@ -348,11 +428,13 @@ static void ringbuf_subtest(void)
 	/* now we should get a pending notification */
 	usleep(50000);
 	err = pthread_tryjoin_np(thread, (void **)&bg_ret);
+	if (!err)
+		thread_guard.joined = true;
 	if (CHECK(err, "join_bg", "err %d\n", err))
-		goto cleanup;
+		return;
 
 	if (CHECK(bg_ret <= 0, "bg_ret", "epoll_wait result: %ld", bg_ret))
-		goto cleanup;
+		return;
 
 	/* due to timing variations, there could still be non-notified
 	 * samples, so consume them here to collect all the samples
@@ -375,11 +457,6 @@ static void ringbuf_subtest(void)
 	      2L, skel->bss->total);
 	CHECK(skel->bss->discarded != 1, "err_discarded", "exp %ld, got %ld\n",
 	      1L, skel->bss->discarded);
-
-	test_ringbuf_lskel__detach(skel);
-cleanup:
-	ring_buffer__free(ringbuf);
-	test_ringbuf_lskel__destroy(skel);
 }
 
 /*
@@ -408,14 +485,10 @@ static int process_noop_sample(void *ctx, void *data, size_t len)
 
 static void ringbuf_null_cb_subtest(void)
 {
-	struct test_ringbuf_n_lskel *skel_n;
-	struct ring_buffer *ringbuf = NULL;
-	struct ring *ring;
-	unsigned long consumer_pos;
-	int no_cb_map_fd = -1;
 	int err;
-
-	skel_n = test_ringbuf_n_lskel__open();
+	struct test_ringbuf_n_lskel *skel_n
+		__attribute__((cleanup(cleanup_test_ringbuf_n_lskel))) =
+			test_ringbuf_n_lskel__open();
 	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
 		return;
 
@@ -425,80 +498,170 @@ static void ringbuf_null_cb_subtest(void)
 
 	err = test_ringbuf_n_lskel__load(skel_n);
 	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
-		goto cleanup;
+		return;
 
 	err = test_ringbuf_n_lskel__attach(skel_n);
 	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
-		goto cleanup;
+		return;
 
 	syscall(__NR_getpgid);
 
-	no_cb_map_fd = bpf_map_create(BPF_MAP_TYPE_RINGBUF, NULL, 0, 0,
-				      getpagesize(), NULL);
+	__attribute__((cleanup(cleanup_fd))) int no_cb_map_fd = bpf_map_create(
+		BPF_MAP_TYPE_RINGBUF, NULL, 0, 0, getpagesize(), NULL);
 	if (!ASSERT_OK_FD(no_cb_map_fd, "bpf_map_create"))
-		goto cleanup;
+		return;
 
 	/* Manager APIs must validate all rings before consuming any of them. */
-	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
-				   process_noop_sample, NULL, NULL);
-	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
-		goto cleanup_fd;
+	{
+		struct ring_buffer *ringbuf
+			__attribute__((cleanup(cleanup_ring_buffer))) =
+				ring_buffer__new(skel_n->maps.ringbuf.map_fd,
+						 process_noop_sample, NULL,
+						 NULL);
+		if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+			return;
+
+		struct ring *ring = ring_buffer__ring(ringbuf, 0);
+
+		if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
+			return;
+
+		err = ring_buffer__add(ringbuf, no_cb_map_fd, NULL, NULL);
+		if (!ASSERT_OK(err, "ring_buffer__add_no_cb"))
+			return;
+
+		unsigned long consumer_pos = ring__consumer_pos(ring);
+
+		ASSERT_GT(ring__producer_pos(ring), consumer_pos,
+			  "producer_pos_mixed_cb");
+
+		err = ring_buffer__consume_n(ringbuf, 0);
+		ASSERT_EQ(err, -EINVAL, "ringbuf_consume_zero_mixed_cb");
+		err = ring_buffer__consume(ringbuf);
+		ASSERT_EQ(err, -EINVAL, "ringbuf_consume_mixed_cb");
+		err = ring_buffer__poll(ringbuf, 0);
+		ASSERT_EQ(err, -EINVAL, "ringbuf_poll_mixed_cb");
+		ASSERT_EQ(ring__consumer_pos(ring), consumer_pos,
+			  "consumer_pos_mixed_cb");
+	}
 
-	ring = ring_buffer__ring(ringbuf, 0);
-	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
-		goto cleanup_ringbuf;
+	/* Direct consumption must reject a ring without a callback. */
+	{
+		struct ring_buffer *ringbuf
+			__attribute__((cleanup(cleanup_ring_buffer))) =
+				ring_buffer__new(skel_n->maps.ringbuf.map_fd,
+						 NULL, NULL, NULL);
+		if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new_no_cb"))
+			return;
+
+		struct ring *ring = ring_buffer__ring(ringbuf, 0);
+
+		if (!ASSERT_OK_PTR(ring, "ring_buffer__ring_no_cb"))
+			return;
+		unsigned long consumer_pos = ring__consumer_pos(ring);
+
+		err = ring_buffer__consume_n(ringbuf, 0);
+		ASSERT_EQ(err, -EINVAL, "ringbuf_consume_zero_no_cb");
+		err = ring__consume_n(ring, 0);
+		ASSERT_EQ(err, -EINVAL, "ring_consume_zero_no_cb");
+		err = ring__consume(ring);
+		ASSERT_EQ(err, -EINVAL, "ring_consume_no_cb");
+		ASSERT_EQ(ring__consumer_pos(ring), consumer_pos,
+			  "consumer_pos_no_cb");
+	}
+}
 
-	err = ring_buffer__add(ringbuf, no_cb_map_fd, NULL, NULL);
-	if (!ASSERT_OK(err, "ring_buffer__add_no_cb"))
-		goto cleanup_ringbuf;
+#define N_WAKEUP_SAMPLES 20000
 
-	consumer_pos = ring__consumer_pos(ring);
-	ASSERT_GT(ring__producer_pos(ring), consumer_pos,
-		  "producer_pos_mixed_cb");
+struct wakeup_ctx {
+	bool stop;
+};
 
-	err = ring_buffer__consume_n(ringbuf, 0);
-	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_zero_mixed_cb");
-	err = ring_buffer__consume(ringbuf);
-	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_mixed_cb");
-	err = ring_buffer__poll(ringbuf, 0);
-	ASSERT_EQ(err, -EINVAL, "ringbuf_poll_mixed_cb");
-	ASSERT_EQ(ring__consumer_pos(ring), consumer_pos,
-		  "consumer_pos_mixed_cb");
+static void *wakeup_producer(void *arg)
+{
+	struct wakeup_ctx *ctx = arg;
 
-	ring_buffer__free(ringbuf);
-	ringbuf =
-		ring_buffer__new(skel_n->maps.ringbuf.map_fd, NULL, NULL, NULL);
-	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new_no_cb"))
-		goto cleanup_fd;
+	while (!__atomic_load_n(&ctx->stop, __ATOMIC_RELAXED))
+		syscall(__NR_getpgid);
+	return NULL;
+}
 
-	ring = ring_buffer__ring(ringbuf, 0);
-	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring_no_cb"))
-		goto cleanup_ringbuf;
-	consumer_pos = ring__consumer_pos(ring);
+static void ringbuf_wakeup_subtest(void)
+{
+	int err;
+	struct test_ringbuf_n_lskel *skel_n
+		__attribute__((cleanup(cleanup_test_ringbuf_n_lskel))) =
+			test_ringbuf_n_lskel__open();
+	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
+		return;
 
-	err = ring_buffer__consume_n(ringbuf, 0);
-	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_zero_no_cb");
-	err = ring__consume_n(ring, 0);
-	ASSERT_EQ(err, -EINVAL, "ring_consume_zero_no_cb");
-	err = ring__consume(ring);
-	ASSERT_EQ(err, -EINVAL, "ring_consume_no_cb");
-	ASSERT_EQ(ring__consumer_pos(ring), consumer_pos, "consumer_pos_no_cb");
-
-cleanup_ringbuf:
-	ring_buffer__free(ringbuf);
-cleanup_fd:
-	close(no_cb_map_fd);
-cleanup:
-	test_ringbuf_n_lskel__destroy(skel_n);
+	skel_n->maps.ringbuf.max_entries = getpagesize();
+	skel_n->bss->pid = getpid();
+	skel_n->bss->value = SAMPLE_VALUE;
+
+	err = test_ringbuf_n_lskel__load(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
+		return;
+
+	err = test_ringbuf_n_lskel__attach(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
+		return;
+
+	struct ring_buffer *ringbuf
+		__attribute__((cleanup(cleanup_ring_buffer))) =
+			ring_buffer__new(skel_n->maps.ringbuf.map_fd,
+					 process_noop_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		return;
+
+	struct epoll_event event = {
+		.events = EPOLLIN | EPOLLET,
+	};
+	int epoll_fd __attribute__((cleanup(cleanup_fd))) =
+		epoll_create1(EPOLL_CLOEXEC);
+	if (!ASSERT_OK_FD(epoll_fd, "epoll_create1"))
+		return;
+
+	err = epoll_ctl(epoll_fd, EPOLL_CTL_ADD, skel_n->maps.ringbuf.map_fd,
+			&event);
+	if (!ASSERT_OK(err, "epoll_ctl"))
+		return;
+
+	pthread_t producer;
+	struct wakeup_ctx ctx = {};
+
+	err = pthread_create(&producer, NULL, wakeup_producer, &ctx);
+	if (!ASSERT_OK(err, "pthread_create"))
+		return;
+	struct thread_guard producer_guard
+		__attribute__((cleanup(cleanup_thread))) = {
+			.thread = producer,
+			.stop = &ctx.stop,
+			.joined = false,
+		};
+
+	int total = 0;
+
+	while (total < N_WAKEUP_SAMPLES) {
+		err = epoll_wait(epoll_fd, &event, 1, 1000);
+		if (!ASSERT_EQ(err, 1, "epoll_wait"))
+			return;
+		while ((err = ring_buffer__consume_n(ringbuf, 1)) > 0)
+			total += err;
+		if (!ASSERT_OK(err, "ring_buffer__consume_n"))
+			return;
+	}
 }
 
 static void ringbuf_n_subtest(void)
 {
-	struct test_ringbuf_n_lskel *skel_n;
-	struct ring *ring;
+	struct test_ringbuf_n_lskel *skel_n
+		__attribute__((cleanup(cleanup_test_ringbuf_n_lskel))) =
+			test_ringbuf_n_lskel__open();
 	int err, i;
+	struct ring_buffer *ringbuf
+		__attribute__((cleanup(cleanup_ring_buffer))) = NULL;
 
-	skel_n = test_ringbuf_n_lskel__open();
 	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
 		return;
 
@@ -507,49 +670,46 @@ static void ringbuf_n_subtest(void)
 
 	err = test_ringbuf_n_lskel__load(skel_n);
 	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
-		goto cleanup;
+		return;
 
 	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
 				   process_n_sample, NULL, NULL);
 	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
-		goto cleanup;
+		return;
 
 	err = test_ringbuf_n_lskel__attach(skel_n);
 	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
-		goto cleanup_ringbuf;
+		return;
 
 	/* Produce N_TOT_SAMPLES samples in the ring buffer by calling getpid() */
 	skel_n->bss->value = SAMPLE_VALUE;
 	for (i = 0; i < N_TOT_SAMPLES; i++)
 		syscall(__NR_getpgid);
 
-	ring = ring_buffer__ring(ringbuf, 0);
+	struct ring *ring = ring_buffer__ring(ringbuf, 0);
+
 	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
-		goto cleanup_ringbuf;
+		return;
 
 	err = ring_buffer__consume_n(ringbuf, 0);
 	if (!ASSERT_EQ(err, 0, "ringbuf_consume_zero"))
-		goto cleanup_ringbuf;
+		return;
 
 	err = ring__consume_n(ring, 0);
 	if (!ASSERT_EQ(err, 0, "ring_consume_zero"))
-		goto cleanup_ringbuf;
+		return;
 
 	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
 	for (i = 0; i < N_TOT_SAMPLES; i += err) {
 		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
 		if (!ASSERT_EQ(err, N_SAMPLES, "rb_consume"))
-			goto cleanup_ringbuf;
+			return;
 	}
-
-cleanup_ringbuf:
-	ring_buffer__free(ringbuf);
-cleanup:
-	test_ringbuf_n_lskel__destroy(skel_n);
 }
 
 static int process_map_key_sample(void *ctx, void *data, size_t len)
 {
+	struct test_ringbuf_map_key_lskel *skel_map_key = ctx;
 	struct sample *s;
 	int err, val;
 
@@ -570,8 +730,12 @@ static int process_map_key_sample(void *ctx, void *data, size_t len)
 static void ringbuf_map_key_subtest(void)
 {
 	int err;
+	struct test_ringbuf_map_key_lskel *skel_map_key
+		__attribute__((cleanup(cleanup_test_ringbuf_map_key_lskel))) =
+			test_ringbuf_map_key_lskel__open();
+	struct ring_buffer *ringbuf
+		__attribute__((cleanup(cleanup_ring_buffer))) = NULL;
 
-	skel_map_key = test_ringbuf_map_key_lskel__open();
 	if (!ASSERT_OK_PTR(skel_map_key, "test_ringbuf_map_key_lskel__open"))
 		return;
 
@@ -580,47 +744,44 @@ static void ringbuf_map_key_subtest(void)
 
 	err = test_ringbuf_map_key_lskel__load(skel_map_key);
 	if (!ASSERT_OK(err, "test_ringbuf_map_key_lskel__load"))
-		goto cleanup;
+		return;
 
 	ringbuf = ring_buffer__new(skel_map_key->maps.ringbuf.map_fd,
-				   process_map_key_sample, NULL, NULL);
+				   process_map_key_sample, skel_map_key, NULL);
 	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
-		goto cleanup;
+		return;
 
 	err = test_ringbuf_map_key_lskel__attach(skel_map_key);
 	if (!ASSERT_OK(err, "test_ringbuf_map_key_lskel__attach"))
-		goto cleanup_ringbuf;
+		return;
 
 	syscall(__NR_getpgid);
 	ASSERT_EQ(skel_map_key->bss->seq, 1, "skel_map_key->bss->seq");
 	err = ring_buffer__poll(ringbuf, -1);
 	ASSERT_EQ(err, -EDONE, "ring_buffer__poll");
-
-cleanup_ringbuf:
-	ring_buffer__free(ringbuf);
-cleanup:
-	test_ringbuf_map_key_lskel__destroy(skel_map_key);
 }
 
 static void ringbuf_overwrite_callback_subtest(void)
 {
-	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_RB_OVERWRITE);
-	struct ring_buffer *ringbuf;
-	struct ring *ring;
-	int map_fd, err;
+	int err;
 
-	map_fd = bpf_map_create(BPF_MAP_TYPE_RINGBUF, NULL, 0, 0, getpagesize(),
-				&opts);
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_RB_OVERWRITE);
+	__attribute__((cleanup(cleanup_fd))) int map_fd = bpf_map_create(
+		BPF_MAP_TYPE_RINGBUF, NULL, 0, 0, getpagesize(), &opts);
 	if (!ASSERT_OK_FD(map_fd, "bpf_map_create"))
 		return;
 
-	ringbuf = ring_buffer__new(map_fd, process_noop_sample, NULL, NULL);
+	struct ring_buffer *ringbuf
+		__attribute__((cleanup(cleanup_ring_buffer))) =
+			ring_buffer__new(map_fd, process_noop_sample, NULL,
+					 NULL);
 	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
-		goto cleanup_fd;
+		return;
+
+	struct ring *ring = ring_buffer__ring(ringbuf, 0);
 
-	ring = ring_buffer__ring(ringbuf, 0);
 	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
-		goto cleanup_ringbuf;
+		return;
 
 	err = ring_buffer__consume_n(ringbuf, 0);
 	ASSERT_EQ(err, -EOPNOTSUPP, "ringbuf_consume_zero");
@@ -632,22 +793,18 @@ static void ringbuf_overwrite_callback_subtest(void)
 	ASSERT_EQ(err, -EOPNOTSUPP, "ring_consume_zero");
 	err = ring__consume(ring);
 	ASSERT_EQ(err, -EOPNOTSUPP, "ring_consume");
-
-cleanup_ringbuf:
-	ring_buffer__free(ringbuf);
-cleanup_fd:
-	close(map_fd);
 }
 
 static void ringbuf_overwrite_mode_subtest(void)
 {
 	unsigned long size, len1, len2, len3, len4, len5;
 	unsigned long expect_avail_data, expect_prod_pos, expect_over_pos;
-	struct test_ringbuf_overwrite_lskel *skel;
+	struct test_ringbuf_overwrite_lskel *skel
+		__attribute__((cleanup(cleanup_test_ringbuf_overwrite_lskel))) =
+			test_ringbuf_overwrite_lskel__open();
 	int page_size = getpagesize();
 	int err;
 
-	skel = test_ringbuf_overwrite_lskel__open();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
@@ -669,11 +826,11 @@ static void ringbuf_overwrite_mode_subtest(void)
 
 	err = test_ringbuf_overwrite_lskel__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
-		goto cleanup;
+		return;
 
 	err = test_ringbuf_overwrite_lskel__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
-		goto cleanup;
+		return;
 
 	syscall(__NR_getpgid);
 
@@ -695,10 +852,6 @@ static void ringbuf_overwrite_mode_subtest(void)
 
 	expect_over_pos = len1 + BPF_RINGBUF_HDR_SZ;
 	ASSERT_EQ(skel->bss->over_pos, expect_over_pos, "check_over_pos");
-
-	test_ringbuf_overwrite_lskel__detach(skel);
-cleanup:
-	test_ringbuf_overwrite_lskel__destroy(skel);
 }
 
 void test_ringbuf(void)
@@ -709,6 +862,8 @@ void test_ringbuf(void)
 		ringbuf_n_subtest();
 	if (test__start_subtest("ringbuf_null_cb"))
 		ringbuf_null_cb_subtest();
+	if (test__start_subtest("ringbuf_wakeup"))
+		ringbuf_wakeup_subtest();
 	if (test__start_subtest("ringbuf_map_key"))
 		ringbuf_map_key_subtest();
 	if (test__start_subtest("ringbuf_write"))

-- 
2.56.1

