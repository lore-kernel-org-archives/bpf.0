Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA32874E3;
	Fri, 12 Jun 2026 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781238312; cv=none; b=VO74JHEXqG21uzlCldWK56TMBJGAumKS7jiY+7A/1AYOiaQPk9nu+SomdHQcGQDesZyu16AV05rfeM39M7Dd++a4K1JT3sHaB3NrxCXCj0dK9GXoG8LLUSi1pxPCEnFidd5dAfxqRv6vl5KTGCOYy5SnVVVv7G0pOr/waUTnaDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781238312; c=relaxed/simple;
	bh=T2PF+t85iMoF7sFJNquTi+ZMBsFknJzFcn4A2oeWFbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MOP3xUYOv3I5Fzi5NQODSwfa9fA4d2w/9lQFkshjqkrsd1Ni76XqNTCwBIww9s7ObeJDbxEla4tFxRuqhIkPb93HEoGEenlWRNDG3j1iyfHAgup5f1RKPYEnYibYh1M7CNDswlAb+AFZGvMV7PnjJWWbzGJo1detsYWFdKLymjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6etd6Pr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6etd6Pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E6C1F000E9;
	Fri, 12 Jun 2026 04:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781238310;
	bh=+8iYByppu0RgXa8UtLNDXM+NRbiN0aKxoRZB48ZPyfM=;
	h=From:Date:Subject:To:Cc;
	b=d6etd6Prtf1UoGICxGDcw8gGrNRH/uqiP92nyTQi57w7sYzuPer0kLXZEfGxa8kCo
	 9jJNBhH5R13X2Z6QCN43XuV0uB2wpVX27faAVo13Zw77v40afDXKNxpnmqKS8Oxdgz
	 lSoUeuoYRda8gOIIyiXvtBpXusZAT0wcr6AhpkGn1yie0OUsLOWM8vJJtyKNd3pcWd
	 nQoCzliI4YA9+12Dvjqs4MbqhgH+t6NBwPa6ECoFKuSRKOoz75nxFwPccKfZgx2HJZ
	 wRbWlVPRdL0X1Mbf4OooC4kTPKoSMIy81e3w96EIl4Ij3lJ6EN4GM+GbGirFQQ60q/
	 F1+R+UEGqm9VQ==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 11 Jun 2026 21:24:59 -0700
Subject: [PATCH] libbpf: Allow callbacks at consumption time
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-bpf-ringbuf-callback-v1-1-c32b6cb6ce40@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB0wQ9HQqxQXmXRip5VUEhVBv
 LuxXb7F/ztkSSoZ7tUOSVbN+o0Fpq7Av1wcBPVZDNRQ27TGIE8Bk8aBl4DejSM7/8GboY6tdGQ
 tQUmnJEG33/bR/50XfoufrxccxwkPDRYheAAAAA==
X-Change-ID: 20260611-bpf-ringbuf-callback-4127b8e72882
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14110; i=tamird@kernel.org;
 h=from:subject:message-id; bh=T2PF+t85iMoF7sFJNquTi+ZMBsFknJzFcn4A2oeWFbo=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFnaXXLTeSLD9p4qc+6NkNbItXpv4LHBoTUu7HzeT84jy
 1Jzvid0TGRhEONisBRTZEkUPbQ3PfX2HtnMd8dh5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix0DHWMGLk4BmOopjgx/eJT+cL86Jlp6m++3j8kS1a2xH62Ohs44cPTW5+bft0UXizMytDL7nY6
 LUp6gFvV1B1eyrv+uGZsKjHrOXb9hc8/5l2IbJwA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Ring buffer callbacks and contexts are fixed when each ring is added to
a manager. Callers that drain records into per-operation state, such as
a bounded destination buffer, must therefore keep mutable dispatch state
alive for the lifetime of the manager or rebuild it for each operation.

Add bounded manager and per-ring consumption APIs that take a callback
and context for one operation. The supplied callback overrides the
configured callback without changing it. This also allows managers used
only through the new APIs to be created without a setup-time callback.

Make zero-record requests return without invoking callbacks so all
bounded consumption APIs preserve their bound.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
I discussed the desire for this API with Andrii during my time at Meta
and more recently with Alexei during Rust Week 2026.
---
 tools/lib/bpf/libbpf.h                             | 56 +++++++++++--
 tools/lib/bpf/libbpf.map                           |  2 +
 tools/lib/bpf/ringbuf.c                            | 51 ++++++++++--
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   | 25 ++++++
 .../selftests/bpf/prog_tests/ringbuf_multi.c       | 92 ++++++++++++++++++++++
 5 files changed, 214 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..5a87c12bab0b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1471,6 +1471,29 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
 LIBBPF_API int ring_buffer__consume_n(struct ring_buffer *rb, size_t n);
+
+/**
+ * @brief **ring_buffer__consume_n_cb()** consumes up to a requested number of
+ * records across all registered ring buffer maps without event polling, using
+ * the provided callback and context for every ring buffer map.
+ *
+ * The provided callback and context override the callbacks configured for the
+ * manager's rings for the duration of this call without changing them.
+ * **ring_buffer__new()** and **ring_buffer__add()** may receive a NULL callback
+ * for rings consumed only through this function.
+ *
+ * @param rb A ring buffer manager object.
+ * @param sample_cb Non-NULL callback to invoke for each available record.
+ * @param ctx Context to pass to *sample_cb*.
+ * @param n Maximum number of records to consume across all registered ring
+ * buffer maps.
+ * @return The number of records consumed (or INT_MAX, whichever is less), or a
+ * negative error code on failure.
+ */
+LIBBPF_API int ring_buffer__consume_n_cb(struct ring_buffer *rb,
+					 ring_buffer_sample_fn sample_cb,
+					 void *ctx, size_t n);
+
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
 /**
@@ -1546,16 +1569,37 @@ LIBBPF_API int ring__map_fd(const struct ring *r);
 LIBBPF_API int ring__consume(struct ring *r);
 
 /**
- * @brief **ring__consume_n()** consumes up to a requested amount of items from
- * a ringbuffer without event polling.
+ * @brief **ring__consume_n()** consumes up to a requested number of records
+ * from a ring buffer without event polling.
  *
- * @param r A ringbuffer object.
- * @param n Maximum amount of items to consume.
- * @return The number of items consumed, or a negative number if any of the
- * callbacks return an error.
+ * @param r A ring buffer object.
+ * @param n Maximum number of records to consume.
+ * @return The number of records consumed (or INT_MAX, whichever is less), or a
+ * negative error code on failure.
  */
 LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
 
+/**
+ * @brief **ring__consume_n_cb()** consumes up to a requested number of records
+ * from a ring buffer without event polling, using the provided callback and
+ * context.
+ *
+ * The provided callback and context override the callback configured for the
+ * ring for the duration of this call without changing it.
+ * **ring_buffer__new()** and **ring_buffer__add()** may receive a NULL callback
+ * for rings consumed only through this function.
+ *
+ * @param r A ring buffer object.
+ * @param sample_cb Non-NULL callback to invoke for each available record.
+ * @param ctx Context to pass to *sample_cb*.
+ * @param n Maximum number of records to consume.
+ * @return The number of records consumed (or INT_MAX, whichever is less), or a
+ * negative error code on failure.
+ */
+LIBBPF_API int ring__consume_n_cb(struct ring *r,
+				  ring_buffer_sample_fn sample_cb, void *ctx,
+				  size_t n);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b731df19ae69..b6d84297fce7 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -461,4 +461,6 @@ LIBBPF_1.8.0 {
 		bpf_program__attach_tracing_multi;
 		bpf_program__clone;
 		btf__new_empty_opts;
+		ring__consume_n_cb;
+		ring_buffer__consume_n_cb;
 } LIBBPF_1.7.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 00ec4837a06d..efe5e396f1d2 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -231,7 +231,8 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
-static int64_t ringbuf_process_ring(struct ring *r, size_t n)
+static int64_t ringbuf_process_ring(struct ring *r, size_t n,
+				    ring_buffer_sample_fn sample_cb, void *ctx)
 {
 	int *len_ptr, len, err;
 	/* 64-bit to avoid overflow in case of extreme application behavior */
@@ -240,6 +241,11 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	bool got_new_data;
 	void *sample;
 
+	if (!sample_cb)
+		return -EINVAL;
+	if (n == 0)
+		return 0;
+
 	cons_pos = smp_load_acquire(r->consumer_pos);
 	do {
 		got_new_data = false;
@@ -257,7 +263,7 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 
 			if ((len & BPF_RINGBUF_DISCARD_BIT) == 0) {
 				sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
-				err = r->sample_cb(r->ctx, sample, len);
+				err = sample_cb(ctx, sample, len);
 				if (err < 0) {
 					/* update consumer pos and bail out */
 					smp_store_release(r->consumer_pos,
@@ -292,7 +298,32 @@ int ring_buffer__consume_n(struct ring_buffer *rb, size_t n)
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
-		err = ringbuf_process_ring(ring, n);
+		err = ringbuf_process_ring(ring, n, ring->sample_cb, ring->ctx);
+		if (err < 0)
+			return libbpf_err(err);
+		res += err;
+		n -= err;
+
+		if (n == 0)
+			break;
+	}
+	return res > INT_MAX ? INT_MAX : res;
+}
+
+int ring_buffer__consume_n_cb(struct ring_buffer *rb,
+			      ring_buffer_sample_fn sample_cb, void *ctx,
+			      size_t n)
+{
+	int64_t err, res = 0;
+	int i;
+
+	if (!sample_cb)
+		return libbpf_err(-EINVAL);
+	if (n == 0)
+		return 0;
+
+	for (i = 0; i < rb->ring_cnt; i++) {
+		err = ringbuf_process_ring(rb->rings[i], n, sample_cb, ctx);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
@@ -317,7 +348,8 @@ int ring_buffer__consume(struct ring_buffer *rb)
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
-		err = ringbuf_process_ring(ring, INT_MAX);
+		err = ringbuf_process_ring(ring, INT_MAX, ring->sample_cb,
+					   ring->ctx);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
@@ -346,7 +378,8 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 		__u32 ring_id = rb->events[i].data.fd;
 		struct ring *ring = rb->rings[ring_id];
 
-		err = ringbuf_process_ring(ring, INT_MAX);
+		err = ringbuf_process_ring(ring, INT_MAX, ring->sample_cb,
+					   ring->ctx);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
@@ -404,10 +437,16 @@ int ring__map_fd(const struct ring *r)
 }
 
 int ring__consume_n(struct ring *r, size_t n)
+{
+	return ring__consume_n_cb(r, r->sample_cb, r->ctx, n);
+}
+
+int ring__consume_n_cb(struct ring *r, ring_buffer_sample_fn sample_cb,
+		       void *ctx, size_t n)
 {
 	int64_t res;
 
-	res = ringbuf_process_ring(r, n);
+	res = ringbuf_process_ring(r, n, sample_cb, ctx);
 	if (res < 0)
 		return libbpf_err(res);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 64520684d2cb..df3af61af2e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -397,6 +397,8 @@ static int process_n_sample(void *ctx, void *data, size_t len)
 	struct sample *s = data;
 
 	ASSERT_EQ(s->value, SAMPLE_VALUE, "sample_value");
+	if (ctx)
+		(*(int *)ctx)++;
 
 	return 0;
 }
@@ -404,6 +406,8 @@ static int process_n_sample(void *ctx, void *data, size_t len)
 static void ringbuf_n_subtest(void)
 {
 	struct test_ringbuf_n_lskel *skel_n;
+	struct ring *ring;
+	int cb_cnt = 0;
 	int err, i;
 
 	skel_n = test_ringbuf_n_lskel__open();
@@ -438,6 +442,27 @@ static void ringbuf_n_subtest(void)
 			goto cleanup_ringbuf;
 	}
 
+	ring_buffer__free(ringbuf);
+	ringbuf =
+		ring_buffer__new(skel_n->maps.ringbuf.map_fd, NULL, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new_without_cb"))
+		goto cleanup;
+
+	for (i = 0; i < N_TOT_SAMPLES; i++)
+		syscall(__NR_getpgid);
+
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
+		goto cleanup_ringbuf;
+
+	for (i = 0; i < N_TOT_SAMPLES; i += err) {
+		err = ring__consume_n_cb(ring, process_n_sample, &cb_cnt,
+					 N_SAMPLES);
+		if (!ASSERT_EQ(err, N_SAMPLES, "ring_consume_cb"))
+			goto cleanup_ringbuf;
+	}
+	ASSERT_EQ(cb_cnt, N_TOT_SAMPLES, "callback_count");
+
 cleanup_ringbuf:
 	ring_buffer__free(ringbuf);
 cleanup:
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index 58522195081b..c499e46fe831 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -38,12 +38,37 @@ static int process_sample(void *ctx, void *data, size_t len)
 	return 0;
 }
 
+static int process_sample_override(void *ctx, void *data, size_t len)
+{
+	struct sample *s = data;
+	int *cnt = ctx;
+
+	if (!ASSERT_LT(s->seq, 2, "override_sample_seq"))
+		return -EINVAL;
+	ASSERT_EQ(s->value, s->seq ? 777L : 333L, "override_sample_value");
+	(*cnt)++;
+
+	return 0;
+}
+
+static void trigger_samples(struct test_ringbuf_multi *skel)
+{
+	skel->bss->total = 0;
+	skel->bss->target_ring = 0;
+	skel->bss->value = 333;
+	syscall(__NR_getpgid);
+	skel->bss->target_ring = 2;
+	skel->bss->value = 777;
+	syscall(__NR_getpgid);
+}
+
 void test_ringbuf_multi(void)
 {
 	struct test_ringbuf_multi *skel;
 	struct ring_buffer *ringbuf = NULL;
 	struct ring *ring_old;
 	struct ring *ring;
+	int override_cnt = 0;
 	int err;
 	int page_size = getpagesize();
 	int proto_fd = -1;
@@ -139,6 +164,73 @@ void test_ringbuf_multi(void)
 	CHECK(skel->bss->total != 2, "err_total", "exp %ld, got %ld\n",
 	      2L, skel->bss->total);
 
+	trigger_samples(skel);
+	err = ring_buffer__consume_n(ringbuf, 0);
+	if (!ASSERT_EQ(err, 0, "ringbuf_consume_zero_stored_cb"))
+		goto cleanup;
+	err = ring_buffer__consume_n_cb(ringbuf, NULL, NULL, 0);
+	if (!ASSERT_EQ(err, -EINVAL, "ringbuf_consume_null_cb"))
+		goto cleanup;
+	err = ring_buffer__consume_n_cb(ringbuf, process_sample_override,
+					&override_cnt, 0);
+	if (!ASSERT_EQ(err, 0, "ringbuf_consume_zero"))
+		goto cleanup;
+	if (!ASSERT_EQ(override_cnt, 0, "ringbuf_zero_callback_count"))
+		goto cleanup;
+	err = ring_buffer__consume_n_cb(ringbuf, process_sample_override,
+					&override_cnt, 1);
+	if (!ASSERT_EQ(err, 1, "ringbuf_consume_n_cb_1"))
+		goto cleanup;
+	err = ring_buffer__consume_n_cb(ringbuf, process_sample_override,
+					&override_cnt, 1);
+	if (!ASSERT_EQ(err, 1, "ringbuf_consume_n_cb_2"))
+		goto cleanup;
+	if (!ASSERT_EQ(override_cnt, 2, "ringbuf_callback_count"))
+		goto cleanup;
+
+	trigger_samples(skel);
+	err = ring_buffer__consume_n(ringbuf, 2);
+	if (!ASSERT_EQ(err, 2, "ringbuf_consume_stored_cb"))
+		goto cleanup;
+	if (!ASSERT_EQ(override_cnt, 2, "ringbuf_override_not_stored"))
+		goto cleanup;
+
+	trigger_samples(skel);
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring_idx_0_cb"))
+		goto cleanup;
+	err = ring__consume_n(ring, 0);
+	if (!ASSERT_EQ(err, 0, "ring1_consume_zero_stored_cb"))
+		goto cleanup;
+	err = ring__consume_n_cb(ring, NULL, NULL, 0);
+	if (!ASSERT_EQ(err, -EINVAL, "ring1_consume_null_cb"))
+		goto cleanup;
+	err = ring__consume_n_cb(ring, process_sample_override, &override_cnt,
+				 0);
+	if (!ASSERT_EQ(err, 0, "ring1_consume_zero"))
+		goto cleanup;
+	if (!ASSERT_EQ(override_cnt, 2, "ring1_zero_callback_count"))
+		goto cleanup;
+	err = ring__consume_n_cb(ring, process_sample_override, &override_cnt,
+				 1);
+	if (!ASSERT_EQ(err, 1, "ring1_consume_n_cb"))
+		goto cleanup;
+
+	ring = ring_buffer__ring(ringbuf, 1);
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring_idx_1_cb"))
+		goto cleanup;
+	err = ring__consume_n_cb(ring, process_sample_override, &override_cnt,
+				 1);
+	if (!ASSERT_EQ(err, 1, "ring2_consume_n_cb"))
+		goto cleanup;
+	if (!ASSERT_EQ(override_cnt, 4, "ring_callback_count"))
+		goto cleanup;
+
+	trigger_samples(skel);
+	err = ring_buffer__consume_n(ringbuf, 2);
+	ASSERT_EQ(err, 2, "ring_consume_stored_cb");
+	ASSERT_EQ(override_cnt, 4, "ring_override_not_stored");
+
 cleanup:
 	if (proto_fd >= 0)
 		close(proto_fd);

---
base-commit: 30dee2c176e7954f63d1fa3e52d172f30beb9bfb
change-id: 20260611-bpf-ringbuf-callback-4127b8e72882

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>

