Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A81A682C;
	Fri, 19 Jun 2026 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828850; cv=none; b=GWLhT7i9WqJttCccKFBRwK/NhKvzBXm0xBm7xG2R5xvvYv3zEh4XvgQQwZ8FMtlhy+aVRQbBNgi1JCuytsZhmcu1bQX7+QzJp2Tad99W+4GBii3Pb2dHNw+r1lUCgYJXbeFdM2Xup8Ap90H4pv14buDUaUzBCnQY6z7ASUYKrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828850; c=relaxed/simple;
	bh=IQqMtj+0tkNvloP1wo8INky2RsOLX/3ERjhIbJyQHus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2tSq8dr5zBZDxKLHqBjJ1Ld3SKsq0wANm7inpL0HLsL17N1B7rg9wvxMEQ0WIYt9EFRSZb0siWiZibBG4mhp6Cind1ZodNm5yZlc8d8/fZEzkj0VERN8p1iNl29EMem8RpkSAk7WtXzIXOx3B5Ke+ami8v9xIPKRBbcJ7AXbOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9ng2JQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9ng2JQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D301F00A3D;
	Fri, 19 Jun 2026 00:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828848;
	bh=wwgNra8ZWXx7MyTBtEjU3Z5zx5WL2Q8njHt2oI3mv5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=M9ng2JQYHepVDDXbNgrcGxYYacz60rDGQL/Oz37s35sZZ5OAZbxiKBz5LHX3bo61H
	 VCVBKKF5f2JTyCcpFsYMggNSFs+sdFCXGypobT3B/EHq6ZewS7K0n/zvp3kltGpDfc
	 drEq+2enojEiuD84KGEY0q7Sj40obdWLfUXgyIxODYbdGUSiPeTKfCKsstHGJS5Fa/
	 OrFXU1vrBhV8QTS91PMGsWQCDSDm1EKM9BvafRUgC8cf26hqx1bHBXlKxrH9pXsrzK
	 xUF3gchsPRBreG6JBIa9TW9JhqkGXdNvCSkAdmecSfgK4u7VsBi0ZxP9FbBuN45R+u
	 oKUndCdI34X4g==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 18 Jun 2026 20:26:46 -0400
Subject: [PATCH bpf v2 8/8] libbpf: ringbuf: Prevent missed wakeups
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-bpf-ringbuf-fixes-v2-8-33fde039ddf3@kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Tamir Duberstein <tamird@kernel.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8584; i=tamird@kernel.org;
 h=from:subject:message-id; bh=IQqMtj+0tkNvloP1wo8INky2RsOLX/3ERjhIbJyQHus=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFkmPTf29VoVzOPWvJC1tIvr0YmzLP8NDj15xarfIZPF5
 dLxYLFux0QWBjEuBksxRZZE0UN701Nv75HNfHccZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx0DFm4OIUgKme/ILhf6HN76BbQSXR3wJV15enmZ/SbAgusbjxIvnEIyX3o9PbrjAyzP3KfH3
 tv78vBd++qWiSuxGtLRvipzP5dULDbMFLXl9buAE=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

After consuming the last visible record, ringbuf_process_ring()
publishes the consumer position and checks the producer position. These
operations lack a full StoreLoad barrier. A producer can therefore
commit a new record but read the old consumer position while the
consumer reads the old producer position. The producer sends no
notification and the consumer waits despite a queued record.

Insert a full barrier between publishing a consumer position and the
next producer position load. When a record bound or callback ends the
current invocation first, execute the barrier before returning so the
load in a later invocation completes the same handshake.

Add an edge-triggered epoll test that drains one record per call while a
concurrent producer fills the ring. Without the barrier, a missed
notification leaves the producer dropping records from a full ring while
the consumer times out. Document that bounded consumers and callbacks
that terminate consumption must drain before waiting again.

Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
Reported-by: Andrew Werner <awerner32@gmail.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/bpf/20260614015716.945AF1F000E9@smtp.kernel.org/
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/libbpf.h                           | 23 +++++++
 tools/lib/bpf/ringbuf.c                          | 24 +++++--
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 83 ++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index ae46b17feaa6..3a649ed87034 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1440,6 +1440,11 @@ struct ring;
 struct user_ring_buffer;
 
 /* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps. */
+/*
+ * A negative return stops consumption; non-negative values continue. Stopping
+ * can leave records queued without a new readiness notification. Before
+ * waiting for readiness again, consume until no records remain.
+ */
 typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
 
 struct ring_buffer_opts {
@@ -1456,6 +1461,20 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
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
+ * calling ring_buffer__poll() or waiting on ring_buffer__epoll_fd(), call
+ * ring_buffer__consume() until it returns 0.
+ */
 LIBBPF_API int ring_buffer__consume_n(struct ring_buffer *rb, size_t n);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
@@ -1538,6 +1557,10 @@ LIBBPF_API int ring__consume(struct ring *r);
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
index 141f2cbe56eb..0598f6c2f7da 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -271,7 +271,7 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 		return 0;
 
 	cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
-	do {
+	for (;;) {
 		got_new_data = false;
 		prod_pos = __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
 		/* Positions wrap; the consumer cannot logically pass the producer. */
@@ -279,9 +279,9 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
 
-			/* sample not committed yet, bail out for now */
+			/* Retry a busy record once after publishing prior records. */
 			if (len & BPF_RINGBUF_BUSY_BIT)
-				goto done;
+				break;
 
 			got_new_data = true;
 			cons_pos += roundup_len(len);
@@ -294,7 +294,8 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 					__atomic_store_n(r->consumer_pos,
 							 cons_pos,
 							 __ATOMIC_RELEASE);
-					return err;
+					cnt = err;
+					break;
 				}
 				cnt++;
 			}
@@ -303,10 +304,19 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 					 __ATOMIC_RELEASE);
 
 			if (cnt >= n)
-				goto done;
+				break;
 		}
-	} while (got_new_data);
-done:
+		if (!got_new_data)
+			break;
+
+		/*
+		 * Order the published consumer position before the next
+		 * producer-position load, whether below or in a later invocation.
+		 */
+		__atomic_thread_fence(__ATOMIC_SEQ_CST);
+		if (cnt < 0 || cnt >= n)
+			break;
+	}
 	return cnt;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 29be2476c478..0d45a766a580 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -492,6 +492,87 @@ static void ringbuf_null_cb_subtest(void)
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
+			break;
+		while ((err = ring_buffer__consume_n(ringbuf, 1)) > 0)
+			total += err;
+		if (!ASSERT_OK(err, "ring_buffer__consume_n"))
+			break;
+	}
+
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
@@ -709,6 +790,8 @@ void test_ringbuf(void)
 		ringbuf_n_subtest();
 	if (test__start_subtest("ringbuf_null_cb"))
 		ringbuf_null_cb_subtest();
+	if (test__start_subtest("ringbuf_wakeup"))
+		ringbuf_wakeup_subtest();
 	if (test__start_subtest("ringbuf_map_key"))
 		ringbuf_map_key_subtest();
 	if (test__start_subtest("ringbuf_write"))

-- 
2.55.0.rc0.159.gbe5d7338c2

