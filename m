Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E70256C84;
	Sun, 14 Jun 2026 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401744; cv=none; b=KNZEVWMov9tPKv1klFL1ss8WlV0rJS0Z0Uq1yazExZCZ/Sbv5/aKBSmRWT4zwc/iTgEovgbYcS25NiUWt9jSt2Dwq8i35CXkRz9oGf7PxPAWNeakByXgT8Iztl0cJ4UJFWuF8lipQimtb2P6NjBgiNwEyLyIsnPwrilgvsJ6F0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401744; c=relaxed/simple;
	bh=AOvN9883FW2AcWqo3Au3hgAYPUBGaNt9Xi3gSk/IUBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZ6KuwSEC+aLMWRdOltHyZtPj7gLTOvXEE4YWZgrsuSGZzULewpwKcSVsA+/CeqcWlQRWTJO53uV0YZM58SzVHwBQ0mBrZ4oe2gzpp2/1GpRUSx+3p9mW3QwsYoUN8YKP48kBn9l/N+rOjYiqGv6dxl645Jdkw7jSKAxbRXW0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3yZDnsB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3yZDnsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486A71F00A3D;
	Sun, 14 Jun 2026 01:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401741;
	bh=rJOP2M7t0dzdxG6hNyOdsGvTTmPtTFTd+1ISRg/ZbKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=P3yZDnsBETUZ9bXHegu7cVs2l0E2SX9B0SzGNPUg62IsETq7at/JfGG52WJTsivOd
	 VvJcmqWAxNl8kfYw0e7JK5iZ3huQsU3VZ5sNkNcLIupP/KGKuy2VakJu06ihkBuxeY
	 zt9jLjmMp01Yh1JpuFDilVoK239f4Bt38i/ELWUD7hM504LXsVURYMx1FEQDMBiAy/
	 P/PlCRxGEKtpiWJRgF5jvJZbq1Mjnm5m7DnTDtDMDuXFu5TaUXy3i/IxQX5RhuasXG
	 Gxce0qa6ZTKfCsD1vheQDI6gOyHma0n1Dm4xdqhE8HSXJqUD9vD0+xHtir3eTCsiVY
	 gXm2ArkiylWRQ==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 13 Jun 2026 21:48:45 -0400
Subject: [PATCH bpf 2/6] libbpf: ringbuf: Prevent NULL callback crash
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-bpf-ringbuf-fixes-v1-2-e623481cb724@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8624; i=tamird@kernel.org;
 h=from:subject:message-id; bh=AOvN9883FW2AcWqo3Au3hgAYPUBGaNt9Xi3gSk/IUBg=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFl6HG0dOct4NY/OytHfP3Xu57VB1Y4rtPrX+HRr39V2+
 F8/YZtGx0QWBjEuBksxRZZE0UN701Nv75HNfHccZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx0DFm4OIUgKm2CWdk6FnWvsN06eQ71Vvk2/57MCm5XQn8VfyRP7fV/URmVnVeBCPD+Y53v9R
 6dm9xMpF8eps3RSZab5JC58cNVls25BsqH1rDDgA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

ring_buffer__new() and ring_buffer__add() allow a NULL sample
callback. When callback-based consumption reaches such a ring, it calls
through the NULL function pointer and crashes.

Validate every ring in a manager before polling or consuming. Return
-EINVAL without consuming records from an earlier valid ring or waiting
for an event. Perform the same check before honoring a zero record bound
so invalid callback consumption consistently reports the error.

Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/libbpf.h                           | 11 ++-
 tools/lib/bpf/ringbuf.c                          | 41 +++++++++--
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 93 ++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 11 deletions(-)

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
index f2bb619d5a75..ae7fa79b6217 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -231,6 +231,24 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
+static int ringbuf_validate(const struct ring *r)
+{
+	return r->sample_cb ? 0 : -EINVAL;
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
@@ -240,6 +258,9 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	bool got_new_data;
 	void *sample;
 
+	err = ringbuf_validate(r);
+	if (err)
+		return err;
 	if (n == 0)
 		return 0;
 
@@ -284,14 +305,17 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
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
 
@@ -309,14 +333,17 @@ int ring_buffer__consume_n(struct ring_buffer *rb, size_t n)
 
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
 
@@ -334,13 +361,17 @@ int ring_buffer__consume(struct ring_buffer *rb)
 
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
2.55.0.rc0.96.gc050c23164

