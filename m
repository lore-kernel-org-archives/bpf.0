Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D643175A68;
	Fri, 19 Jun 2026 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828836; cv=none; b=jLoMOhKe18AB1U8UT99eeiZhpi2pKSkhjja1v7Hh6fvQRVVvxw7/CR2VnJRx61gW7WzpapgdU5cCyDK4fdCxN6fOXz1SxqzHAZRcC8TyPlqMrGPlccD1VxJdvUpSIfRmsJqGsBp0tcdf0O1fUqfcPSFguu5a3/Jvy4NpwqmzUfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828836; c=relaxed/simple;
	bh=mhdZzvHL5ykL2JhdrScd0K95OxVN7fJGuuHbR115d1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgfY7wCxYMVH2kyFnxqHhMFORa5iDHoFnRvBFjn03gycBfMKg6QvRu3K5APjk9HAZbifPOR3BxxxyeJV4Hu2XfUHQrZk2mk4HANReStnY1igolNT6nvV8+6ajy+vtLb0ihcibmhAnoioRL/xRxVKnGZ6Dn4avTTxojEf94Nfzvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLBS+85D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLBS+85D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF111F00A3A;
	Fri, 19 Jun 2026 00:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828835;
	bh=sK7q69djDybjT02N/lp9cEddd7xHTYJ9nGDniWHBCZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iLBS+85DQWJnVtiRZXHEYaNdx92+/Ner2xvCvmGhvqGODCkCmaSmnzBhFkOnBkYRY
	 VhdSne9ZCSt4RB6Ojeoatsg7lwYdTc7WL3/bGa8QXk9OHRr2l8TuoP3mu2k1TzyGvl
	 Xm6w222dOrePFcLHd3BXJUsAtXQklE/zHgU0RTdfQc40TobT7a/pEg19ZiknGL2pV0
	 74nJp8BVBXWoRhYmfNvUK8Zj/jhmwE/Tpnlfxp49tYAZSxAbve4jeTBJ6VD90Du+4L
	 uAbxK6rV/avKxyo4ikSYIbH8/7IBglyNekbCua/irt8rENCeF+VnsTNJf22b6AbeUD
	 2pXYnG8LHzd7Q==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 18 Jun 2026 20:26:41 -0400
Subject: [PATCH bpf v2 3/8] libbpf: ringbuf: Reject overwrite callback use
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-bpf-ringbuf-fixes-v2-3-33fde039ddf3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4380; i=tamird@kernel.org;
 h=from:subject:message-id; bh=mhdZzvHL5ykL2JhdrScd0K95OxVN7fJGuuHbR115d1A=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFkmPVeTg190MZ1duYln2eHG030OasGv7dLe39B4+vllT
 1+J4elJHRNYGMS4GCzFFFkSRQ/tTU+9vUc2891xmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHQMeYgYtTAKb6cS7D9yDxMJal2t6T3Nsr5/2YON990zXfi/sOrSi+OsFv1S+vdYwMu1tnRIf
 6yZisMFz9Lvy+5MYyp9tO5YpXX71pvCG5KdSMGQA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

BPF_F_RB_OVERWRITE can advance overwrite_pos past consumer_pos.
Callback traversal does not read overwrite_pos, so after the producer
laps the consumer it can treat overwritten data as a record header.

An earlier proposal[0] copied the readable window before invoking
callbacks. Review concluded that callbacks are a poor fit because
copying penalizes zero-copy users and the API cannot report skipped
records.

Record the map flag and reject callback consumption with -EOPNOTSUPP.

Link: https://lore.kernel.org/bpf/CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=uByFSup31FMA7hw@mail.gmail.com/ [0]
Fixes: feeaf1346f80 ("bpf: Add overwrite mode for BPF ring buffer")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/libbpf.h                           |  1 +
 tools/lib/bpf/ringbuf.c                          |  4 +++
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 39 ++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9ba6b9ad3498..ae46b17feaa6 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1439,6 +1439,7 @@ struct ring_buffer;
 struct ring;
 struct user_ring_buffer;
 
+/* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps. */
 typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
 
 struct ring_buffer_opts {
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 0dae4d95d309..5737e02c1670 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -30,6 +30,7 @@ struct ring {
 	unsigned long *producer_pos;
 	unsigned long mask;
 	int map_fd;
+	bool overwrite;
 };
 
 struct ring_buffer {
@@ -118,6 +119,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	r->sample_cb = sample_cb;
 	r->ctx = ctx;
 	r->mask = info.max_entries - 1;
+	r->overwrite = info.map_flags & BPF_F_RB_OVERWRITE;
 
 	/* Map writable consumer page */
 	tmp = mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
@@ -233,6 +235,8 @@ static inline int roundup_len(__u32 len)
 
 static int ringbuf_validate(const struct ring *r)
 {
+	if (unlikely(r->overwrite))
+		return -EOPNOTSUPP;
 	if (unlikely(!r->sample_cb))
 		return -EINVAL;
 	return 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 9ce996bcea8c..29be2476c478 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -602,6 +602,43 @@ static void ringbuf_map_key_subtest(void)
 	test_ringbuf_map_key_lskel__destroy(skel_map_key);
 }
 
+static void ringbuf_overwrite_callback_subtest(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_RB_OVERWRITE);
+	struct ring_buffer *ringbuf;
+	struct ring *ring;
+	int map_fd, err;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_RINGBUF, NULL, 0, 0, getpagesize(),
+				&opts);
+	if (!ASSERT_OK_FD(map_fd, "bpf_map_create"))
+		return;
+
+	ringbuf = ring_buffer__new(map_fd, process_noop_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup_fd;
+
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
+		goto cleanup_ringbuf;
+
+	err = ring_buffer__consume_n(ringbuf, 0);
+	ASSERT_EQ(err, -EOPNOTSUPP, "ringbuf_consume_zero");
+	err = ring_buffer__consume(ringbuf);
+	ASSERT_EQ(err, -EOPNOTSUPP, "ringbuf_consume");
+	err = ring_buffer__poll(ringbuf, 0);
+	ASSERT_EQ(err, -EOPNOTSUPP, "ringbuf_poll");
+	err = ring__consume_n(ring, 0);
+	ASSERT_EQ(err, -EOPNOTSUPP, "ring_consume_zero");
+	err = ring__consume(ring);
+	ASSERT_EQ(err, -EOPNOTSUPP, "ring_consume");
+
+cleanup_ringbuf:
+	ring_buffer__free(ringbuf);
+cleanup_fd:
+	close(map_fd);
+}
+
 static void ringbuf_overwrite_mode_subtest(void)
 {
 	unsigned long size, len1, len2, len3, len4, len5;
@@ -676,6 +713,8 @@ void test_ringbuf(void)
 		ringbuf_map_key_subtest();
 	if (test__start_subtest("ringbuf_write"))
 		ringbuf_write_subtest();
+	if (test__start_subtest("ringbuf_overwrite_callback"))
+		ringbuf_overwrite_callback_subtest();
 	if (test__start_subtest("ringbuf_overwrite_mode"))
 		ringbuf_overwrite_mode_subtest();
 }

-- 
2.55.0.rc0.159.gbe5d7338c2

