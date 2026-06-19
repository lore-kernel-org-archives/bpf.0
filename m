Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9AE13A244;
	Fri, 19 Jun 2026 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828834; cv=none; b=KFKqNBkmaPVWzDYfe6RPFw26Ga+/db+5fFdQR5TLWXTyQWtyNOxePP0ySESeHOFPbN0EE8VCV22x+PdHrClzZZGkWhCd3C627Tz6vKbVcTEfd08WEAZWYIkfuQkN2myyo9bh6WyBWyLbNhrNZu9Bo4jmilJRUiCULCtnTs5ATFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828834; c=relaxed/simple;
	bh=lkXS/Ay2a8uI/Qc/9n+bAeedL2jeqx8y2tybUPIvSe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7dmkpHa7yp42RXMuIS1dyCyUAWZEzSNSMQYABH2tyF7whM/YiSfZQHhuIDy8d2RD6+EtAUaGHQZkx/R3Qa6uXi+X7wPw/4idsEa5tWTTKNr8KhXngV3q90qdTNMwUQFWOUh9F6e/n6ycBJo5QVtVj2kaUVvXKeHyIjwc1bICZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5Qg0yM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5Qg0yM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502AE1F000E9;
	Fri, 19 Jun 2026 00:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828832;
	bh=uqzKIrTuF2hzFCVQaA4xOR2/mewSMcnO0p5U2mSH3h8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f5Qg0yM3QVfwGdPIlAjcDT5Sn03TwQQOqZmPCi5G6xAcqow+ZDPfUSQq9D0PHv2qa
	 IoRDCuF33Zgb4Ibd0XDot0wiCLTNM5XNsZW3a1QNlnOMeTwwcwwSlIQopzflj9ZoEC
	 oGLf5UMFbr4RcaNY0nxe23+i+rg/0mjob3xgbZbE2sFmTFv1HUIyaQ8oMtW07Djq4l
	 y6sYuASBrDPZsM7bDnOh3egjEVVJ0on9w1lWYbiCwtQdN2T+0JNdfUfrNyc64jmDid
	 xHCarzgJtOvQW9JYDPy5k5QNm4OjQEN9flzofY3mtcCmxh25lTo6Q8w5LeFPk+Kek8
	 +Bzaq03mSWQ1w==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 18 Jun 2026 20:26:40 -0400
Subject: [PATCH bpf v2 2/8] libbpf: ringbuf: Prevent NULL callback crash
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-bpf-ringbuf-fixes-v2-2-33fde039ddf3@kernel.org>
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
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8685; i=tamird@kernel.org;
 h=from:subject:message-id; bh=lkXS/Ay2a8uI/Qc/9n+bAeedL2jeqx8y2tybUPIvSe0=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFkmPVfP8Ozg403euuFL9+kzP1cwR3H0GTs3B92s3Zp6I
 97YL/Jqx0QWBjEuBksxRZZE0UN701Nv75HNfHccZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx0DFm4OIUgKm2mMrwV+L/g9CwRJNb6w64G0etVVx3kjFkiunNvPgV+3df942Z4M3IcNPettr
 Y1kdvOYPvh/U8oiGePkfNxHmzpqmr2CX4ns1gBAA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

ring_buffer__new() and ring_buffer__add() allow a NULL sample
callback. When callback-based consumption reaches such a ring, it calls
through the NULL function pointer and crashes.

Check every ring before manager polling or consumption so a missing
callback returns -EINVAL before the manager waits or consumes another
ring. Check the selected ring before direct per-ring consumption. Perform
both checks before honoring a zero record bound so invalid callback use
always reports the error.

Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/libbpf.h                           | 11 ++-
 tools/lib/bpf/ringbuf.c                          | 43 +++++++++--
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 93 ++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index bba4e8464396..9ba6b9ad3498 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1526,18 +1526,17 @@ LIBBPF_API int ring__map_fd(const struct ring *r);
  *
  * @param r A ringbuffer object.
  * @return The number of records consumed (or INT_MAX, whichever is less), or
- * a negative number if any of the callbacks return an error.
+ * a negative error code on failure.
  */
 LIBBPF_API int ring__consume(struct ring *r);
 
 /**
- * @brief **ring__consume_n()** consumes up to a requested amount of items from
- * a ringbuffer without event polling.
+ * @brief **ring__consume_n()** consumes up to a requested number of records
+ * from a ringbuffer without event polling.
  *
  * @param r A ringbuffer object.
- * @param n Maximum amount of items to consume.
- * @return The number of items consumed, or a negative number if any of the
- * callbacks return an error.
+ * @param n Maximum number of records to consume.
+ * @return The number of records consumed, or a negative error code on failure.
  */
 LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
 
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index f2bb619d5a75..0dae4d95d309 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -231,6 +231,26 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
+static int ringbuf_validate(const struct ring *r)
+{
+	if (unlikely(!r->sample_cb))
+		return -EINVAL;
+	return 0;
+}
+
+static int ringbuf_validate_callbacks(const struct ring_buffer *rb)
+{
+	int i, err;
+
+	for (i = 0; i < rb->ring_cnt; i++) {
+		err = ringbuf_validate(rb->rings[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 {
 	int *len_ptr, len, err;
@@ -240,6 +260,9 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	bool got_new_data;
 	void *sample;
 
+	err = ringbuf_validate(r);
+	if (err)
+		return err;
 	if (n == 0)
 		return 0;
 
@@ -284,14 +307,17 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
  * records.
  *
  * Returns number of records consumed across all registered ring buffers (or
- * n, whichever is less), or negative number if any of the callbacks return
- * error.
+ * n, whichever is less), or a negative error code on failure.
  */
 int ring_buffer__consume_n(struct ring_buffer *rb, size_t n)
 {
 	int64_t err, res = 0;
 	int i;
 
+	err = ringbuf_validate_callbacks(rb);
+	if (err)
+		return libbpf_err(err);
+
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
@@ -309,14 +335,17 @@ int ring_buffer__consume_n(struct ring_buffer *rb, size_t n)
 
 /* Consume available ring buffer(s) data without event polling.
  * Returns number of records consumed across all registered ring buffers (or
- * INT_MAX, whichever is less), or negative number if any of the callbacks
- * return error.
+ * INT_MAX, whichever is less), or a negative error code on failure.
  */
 int ring_buffer__consume(struct ring_buffer *rb)
 {
 	int64_t err, res = 0;
 	int i;
 
+	err = ringbuf_validate_callbacks(rb);
+	if (err)
+		return libbpf_err(err);
+
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
@@ -334,13 +363,17 @@ int ring_buffer__consume(struct ring_buffer *rb)
 
 /* Poll for available data and consume records, if any are available.
  * Returns number of records consumed (or INT_MAX, whichever is less), or
- * negative number, if any of the registered callbacks returned error.
+ * a negative error code on failure.
  */
 int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 {
 	int i, cnt;
 	int64_t err, res = 0;
 
+	err = ringbuf_validate_callbacks(rb);
+	if (err)
+		return libbpf_err(err);
+
 	cnt = epoll_wait(rb->epoll_fd, rb->events, rb->ring_cnt, timeout_ms);
 	if (cnt < 0)
 		return libbpf_err(-errno);
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 4f0558f14847..9ce996bcea8c 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -401,6 +401,97 @@ static int process_n_sample(void *ctx, void *data, size_t len)
 	return 0;
 }
 
+static int process_noop_sample(void *ctx, void *data, size_t len)
+{
+	return 0;
+}
+
+static void ringbuf_null_cb_subtest(void)
+{
+	struct test_ringbuf_n_lskel *skel_n;
+	struct ring_buffer *ringbuf = NULL;
+	struct ring *ring;
+	unsigned long consumer_pos;
+	int no_cb_map_fd = -1;
+	int err;
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
+	syscall(__NR_getpgid);
+
+	no_cb_map_fd = bpf_map_create(BPF_MAP_TYPE_RINGBUF, NULL, 0, 0,
+				      getpagesize(), NULL);
+	if (!ASSERT_OK_FD(no_cb_map_fd, "bpf_map_create"))
+		goto cleanup;
+
+	/* Manager APIs must validate all rings before consuming any of them. */
+	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
+				   process_noop_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup_fd;
+
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
+		goto cleanup_ringbuf;
+
+	err = ring_buffer__add(ringbuf, no_cb_map_fd, NULL, NULL);
+	if (!ASSERT_OK(err, "ring_buffer__add_no_cb"))
+		goto cleanup_ringbuf;
+
+	consumer_pos = ring__consumer_pos(ring);
+	ASSERT_GT(ring__producer_pos(ring), consumer_pos,
+		  "producer_pos_mixed_cb");
+
+	err = ring_buffer__consume_n(ringbuf, 0);
+	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_zero_mixed_cb");
+	err = ring_buffer__consume(ringbuf);
+	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_mixed_cb");
+	err = ring_buffer__poll(ringbuf, 0);
+	ASSERT_EQ(err, -EINVAL, "ringbuf_poll_mixed_cb");
+	ASSERT_EQ(ring__consumer_pos(ring), consumer_pos,
+		  "consumer_pos_mixed_cb");
+
+	ring_buffer__free(ringbuf);
+	ringbuf =
+		ring_buffer__new(skel_n->maps.ringbuf.map_fd, NULL, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new_no_cb"))
+		goto cleanup_fd;
+
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring_no_cb"))
+		goto cleanup_ringbuf;
+	consumer_pos = ring__consumer_pos(ring);
+
+	err = ring_buffer__consume_n(ringbuf, 0);
+	ASSERT_EQ(err, -EINVAL, "ringbuf_consume_zero_no_cb");
+	err = ring__consume_n(ring, 0);
+	ASSERT_EQ(err, -EINVAL, "ring_consume_zero_no_cb");
+	err = ring__consume(ring);
+	ASSERT_EQ(err, -EINVAL, "ring_consume_no_cb");
+	ASSERT_EQ(ring__consumer_pos(ring), consumer_pos, "consumer_pos_no_cb");
+
+cleanup_ringbuf:
+	ring_buffer__free(ringbuf);
+cleanup_fd:
+	close(no_cb_map_fd);
+cleanup:
+	test_ringbuf_n_lskel__destroy(skel_n);
+}
+
 static void ringbuf_n_subtest(void)
 {
 	struct test_ringbuf_n_lskel *skel_n;
@@ -579,6 +670,8 @@ void test_ringbuf(void)
 		ringbuf_subtest();
 	if (test__start_subtest("ringbuf_n"))
 		ringbuf_n_subtest();
+	if (test__start_subtest("ringbuf_null_cb"))
+		ringbuf_null_cb_subtest();
 	if (test__start_subtest("ringbuf_map_key"))
 		ringbuf_map_key_subtest();
 	if (test__start_subtest("ringbuf_write"))

-- 
2.55.0.rc0.159.gbe5d7338c2

