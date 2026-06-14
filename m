Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0446A274B5F;
	Sun, 14 Jun 2026 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401749; cv=none; b=ZOlBoZMDz6PQxJ9rZ7tdeK0PhesACFP09csZR67FVHW0da7KjvPwwuReQt9To04+9vW4v3kXBfytdx+aGCJI86h6OaRai8awPVytyfX00V5D+aSkMcqliaBEWfnYbVd8qZWRkopsxxLDSI8p5Slhvix16GSuHH1dllciErHDKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401749; c=relaxed/simple;
	bh=70w+S8E5/6IT51LOadUdpL0w+w2j4GUdGJ5wkFnKqro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqO2XIr8LmUbYKq2LLD3ppL1Z1ITRqutQ+Z7XgMSlFBKQFI6NRdTcSsu0eyQTbrr4UgLqXPecDkKAq/xyrzLMjtqMC/GMKeWU0N8rEO472/0/BIutgETLQRpHmx41Eg2DH+F0IP0xRH55ffBtTn/Ev8PCWKy1g9HLzRh2MmxZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijmcExkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijmcExkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C531F000E9;
	Sun, 14 Jun 2026 01:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401747;
	bh=WDL4PYZGQ76TlMBt9EJjdhp6wT9s0gUkh9l0yKsgqJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ijmcExkpU8lElAnshq20NIDtLQsEUO+r2ZRS++VXQsYs2A+Qx/4l7p3XXOLqSDWx0
	 LHCEGPI4e5vfZ4tJ59kDsjRDMjC0LF9yUqQk69nV5DQjjTPZWHOZtSzsQJuxc/OZjK
	 nJNUQu/Sck2+j1r0tbCA1GhBhHkTsZKPOK0aoURlCf1rVyRVtlW6LdSNNrWdlPG3JK
	 zhV3lKw0/a0ThInQ+YRsxxT9+opSVcNoZQt1j6Nuf+EfAzzv6XfmLhvhh3JO9+l768
	 M9lAv+buAaJlM9+3PmWkyi+Y9+EzK43pxt0CUAqZrtH0L0R1XFktotz1ypYH/l0MOA
	 dglfWcVuRdzqA==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 13 Jun 2026 21:48:48 -0400
Subject: [PATCH bpf 5/6] libbpf: ringbuf: Prevent missed wakeups
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-bpf-ringbuf-fixes-v1-5-e623481cb724@kernel.org>
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8260; i=tamird@kernel.org;
 h=from:subject:message-id; bh=70w+S8E5/6IT51LOadUdpL0w+w2j4GUdGJ5wkFnKqro=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFl6HG0Ks/cfKxT6/s7iaOuMBUFZ/NzSXVcsVhe+zDA4/
 KdCa09Zx0QWBjEuBksxRZZE0UN701Nv75HNfHccZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx0DFm4OIUgKm2smJk6N7sEvQ9LrQ5afcCvQfT+dRbhULe3eRWVxX5tqw6+sxuW0aGa5mHnqv
 uTNdMkLx80fv6dlG+krClP9cH6KbFinm/0PHjBQA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

After consuming the last visible record, ringbuf_process_ring()
publishes the consumer position and checks the producer position. These
operations lack a full StoreLoad barrier. A producer can therefore
commit a new record but read the old consumer position while the
consumer reads the old producer position. The producer sends no
notification and the consumer waits despite a queued record.

Insert a full barrier before checking for new data, ensuring that either
the consumer observes the producer update or the producer observes the
consumer update and sends a notification. Apply the same handshake when
a busy record follows records whose consumer position was published.

Add an edge-triggered epoll test with a concurrent producer. Without the
barrier, a missed notification leaves the producer dropping records from
a full ring while the consumer times out. Document that bounded
consumers and callbacks that terminate consumption must drain before
waiting again.

Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
Reported-by: Andrew Werner <awerner32@gmail.com>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/libbpf.h                           | 22 +++++++
 tools/lib/bpf/ringbuf.c                          | 14 +++-
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 84 ++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9ba6b9ad3498..a3b8f606a91d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1439,6 +1439,10 @@ struct ring_buffer;
 struct ring;
 struct user_ring_buffer;
 
+/* A negative return stops consumption; non-negative values continue. Stopping
+ * can leave records queued without a new readiness notification. Before
+ * waiting for readiness again, consume until no records remain.
+ */
 typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
 
 struct ring_buffer_opts {
@@ -1455,6 +1459,20 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
+
+/**
+ * @brief **ring_buffer__consume_n()** consumes up to a requested number of
+ * records from a ring buffer manager without event polling.
+ *
+ * @param rb A ring buffer manager object.
+ * @param n Maximum number of records to consume.
+ * @return The number of records consumed, or a negative error code on failure.
+ *
+ * Reaching the requested bound does not establish that every ring is empty.
+ * Records can remain queued without a new readiness notification. Before
+ * waiting on ring_buffer__epoll_fd(), call ring_buffer__consume() until it
+ * returns 0.
+ */
 LIBBPF_API int ring_buffer__consume_n(struct ring_buffer *rb, size_t n);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
@@ -1537,6 +1555,10 @@ LIBBPF_API int ring__consume(struct ring *r);
  * @param r A ringbuffer object.
  * @param n Maximum number of records to consume.
  * @return The number of records consumed, or a negative error code on failure.
+ *
+ * Reaching the requested bound does not establish that the ring is empty.
+ * Records can remain queued without a new readiness notification. Before
+ * waiting on ring__map_fd(), call ring__consume() until it returns 0.
  */
 LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
 
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 1c24a83f59d5..ea8909fec4e9 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -255,7 +255,7 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	/* 64-bit to avoid overflow in case of extreme application behavior */
 	int64_t cnt = 0;
 	unsigned long cons_pos, prod_pos;
-	bool got_new_data;
+	bool got_new_data, needs_wakeup = false;
 	void *sample;
 
 	err = ringbuf_validate(r);
@@ -267,14 +267,21 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
 	do {
 		got_new_data = false;
+		if (needs_wakeup) {
+			/* Ensure either this sees a new record or its producer sees
+			 * the updated consumer position and sends a notification.
+			 */
+			__atomic_thread_fence(__ATOMIC_SEQ_CST);
+			needs_wakeup = false;
+		}
 		prod_pos = __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
 		while (cons_pos != prod_pos) {
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
 
-			/* sample not committed yet, bail out for now */
+			/* Retry a busy record once after publishing prior records. */
 			if (len & BPF_RINGBUF_BUSY_BIT)
-				goto done;
+				break;
 
 			got_new_data = true;
 			cons_pos += roundup_len(len);
@@ -294,6 +301,7 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 
 			__atomic_store_n(r->consumer_pos, cons_pos,
 					 __ATOMIC_RELEASE);
+			needs_wakeup = true;
 
 			if (cnt >= n)
 				goto done;
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 9ce996bcea8c..5f0c679bf9a6 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -492,6 +492,88 @@ static void ringbuf_null_cb_subtest(void)
 	test_ringbuf_n_lskel__destroy(skel_n);
 }
 
+#define N_WAKEUP_SAMPLES 20000
+
+struct wakeup_ctx {
+	bool stop;
+};
+
+static void *wakeup_producer(void *arg)
+{
+	struct wakeup_ctx *ctx = arg;
+
+	while (!__atomic_load_n(&ctx->stop, __ATOMIC_RELAXED))
+		syscall(__NR_getpgid);
+	return NULL;
+}
+
+static void ringbuf_wakeup_subtest(void)
+{
+	struct test_ringbuf_n_lskel *skel_n;
+	struct ring_buffer *ringbuf = NULL;
+	struct epoll_event event = {
+		.events = EPOLLIN | EPOLLET,
+	};
+	struct wakeup_ctx ctx = {};
+	pthread_t producer;
+	int epoll_fd = -1;
+	int err, total = 0;
+
+	skel_n = test_ringbuf_n_lskel__open();
+	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
+		return;
+
+	skel_n->maps.ringbuf.max_entries = getpagesize();
+	skel_n->bss->pid = getpid();
+	skel_n->bss->value = SAMPLE_VALUE;
+
+	err = test_ringbuf_n_lskel__load(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
+		goto cleanup;
+
+	err = test_ringbuf_n_lskel__attach(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
+		goto cleanup;
+
+	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
+				   process_noop_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup;
+
+	epoll_fd = epoll_create1(EPOLL_CLOEXEC);
+	if (!ASSERT_OK_FD(epoll_fd, "epoll_create1"))
+		goto cleanup_ringbuf;
+
+	err = epoll_ctl(epoll_fd, EPOLL_CTL_ADD, skel_n->maps.ringbuf.map_fd,
+			&event);
+	if (!ASSERT_OK(err, "epoll_ctl"))
+		goto cleanup_epoll;
+
+	err = pthread_create(&producer, NULL, wakeup_producer, &ctx);
+	if (!ASSERT_OK(err, "pthread_create"))
+		goto cleanup_epoll;
+
+	while (total < N_WAKEUP_SAMPLES) {
+		err = epoll_wait(epoll_fd, &event, 1, 1000);
+		if (!ASSERT_EQ(err, 1, "epoll_wait"))
+			goto cleanup_thread;
+		while ((err = ring_buffer__consume(ringbuf)) > 0)
+			total += err;
+		if (!ASSERT_OK(err, "ring_buffer__consume"))
+			goto cleanup_thread;
+	}
+
+cleanup_thread:
+	__atomic_store_n(&ctx.stop, true, __ATOMIC_RELAXED);
+	pthread_join(producer, NULL);
+cleanup_epoll:
+	close(epoll_fd);
+cleanup_ringbuf:
+	ring_buffer__free(ringbuf);
+cleanup:
+	test_ringbuf_n_lskel__destroy(skel_n);
+}
+
 static void ringbuf_n_subtest(void)
 {
 	struct test_ringbuf_n_lskel *skel_n;
@@ -672,6 +754,8 @@ void test_ringbuf(void)
 		ringbuf_n_subtest();
 	if (test__start_subtest("ringbuf_null_cb"))
 		ringbuf_null_cb_subtest();
+	if (test__start_subtest("ringbuf_wakeup"))
+		ringbuf_wakeup_subtest();
 	if (test__start_subtest("ringbuf_map_key"))
 		ringbuf_map_key_subtest();
 	if (test__start_subtest("ringbuf_write"))

-- 
2.55.0.rc0.96.gc050c23164

