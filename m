Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252791DA62E;
	Sun, 14 Jun 2026 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401751; cv=none; b=Wk6d3jW+33iFs/kv1QBbjsjUYf6p6rV7qLBk2RqFsWnyiB9DeOZIXxW1t3L3PNMRun0q2PS0FQuZVaDBOd0K8XbMXt7lvEHMI7S5OjicQtB+d0jcB3QxvX4YRRQLuqx1hbx7JlRPTzUtq9GNNJCSyLTQ358si1YBX2QB3V5sNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401751; c=relaxed/simple;
	bh=6i5k0UBlMUt12SCBmIur8jGAs+CBWD1Z12+vLx8ocyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G34zFcTLIEBw7EqFMx8h2y+GoLHmzBlPOwdZpcMKLm0t9v5FvYtINJUZrXropckS/KAHsmHG2FI94+1DcU43k8+4jL4L3QLE5wHhlnLqUV1nkO9ikr6zocsoFFAdhSzuXJNSh1J8y/dOHIJx++FqpatrtN9FqiesgMMIzPrawBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp/OzQps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp/OzQps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF1F1F00A3E;
	Sun, 14 Jun 2026 01:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401750;
	bh=DFSqeE5tj30m25zsXyPJzG7hsA72SXLztYslV+9vHZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Mp/OzQps8B20Q+x9vuY52Y+a1iwanS7jk9TsSNHgsYMyAQa+qMKjS0EZn3ZF1FHRE
	 l1ZRT16iD3FkQXBJj1AU4DjyMV8Qll3jT+9n//iMG74XW7vQVL4wEoyh1y9zHymNIn
	 HFUJvHN9v1TXss0RTr++Ozt0kGLJNtslmUzLa7l5P4nRqAxHSjqtDuIg8ID9BZfuRO
	 wZMEkWgv8ubkmrsLa3/VI9dATopAmGtNDmqSbtLbkvzUFPzNx77egjSe/RqFW3gS/2
	 km2i/g/AGPG3sdj4+WsLLeNC4nblHeUrHwbJvO+i1Ydc2uwMIAgVDN5bMaflZlG96i
	 Sl8hivaApEViQ==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 13 Jun 2026 21:48:49 -0400
Subject: [PATCH bpf 6/6] libbpf: ringbuf: Reject overwrite callback use
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-bpf-ringbuf-fixes-v1-6-e623481cb724@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4465; i=tamird@kernel.org;
 h=from:subject:message-id; bh=6i5k0UBlMUt12SCBmIur8jGAs+CBWD1Z12+vLx8ocyI=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFl6HO1hgjen3oj0eSGewqdwZamwaa9/5/dI8Ucx8SsLv
 Ca7qk3umMjCIMbFYCmmyJIoemhveurtPbKZ747DzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 RjoGOsYMXJwCMNVTHRn+F9RkCebP+6hgvFjz3eYvLctZeqvv79LnvG5+0DF0+oqJoQz/lCeL7bH
 ViZW+7b7z20Wrn7HabIrP37lzbbQ7XZER5WfFCQA=
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
index a3b8f606a91d..899457d5d536 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1439,6 +1439,7 @@ struct ring_buffer;
 struct ring;
 struct user_ring_buffer;
 
+/* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps. */
 /* A negative return stops consumption; non-negative values continue. Stopping
  * can leave records queued without a new readiness notification. Before
  * waiting for readiness again, consume until no records remain.
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index ea8909fec4e9..f7972eae05ba 100644
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
+	if (r->overwrite)
+		return -EOPNOTSUPP;
 	return r->sample_cb ? 0 : -EINVAL;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 5f0c679bf9a6..a6c707af1134 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -684,6 +684,43 @@ static void ringbuf_map_key_subtest(void)
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
@@ -760,6 +797,8 @@ void test_ringbuf(void)
 		ringbuf_map_key_subtest();
 	if (test__start_subtest("ringbuf_write"))
 		ringbuf_write_subtest();
+	if (test__start_subtest("ringbuf_overwrite_callback"))
+		ringbuf_overwrite_callback_subtest();
 	if (test__start_subtest("ringbuf_overwrite_mode"))
 		ringbuf_overwrite_mode_subtest();
 }

-- 
2.55.0.rc0.96.gc050c23164

