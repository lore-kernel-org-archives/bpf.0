Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206839;
	b=Vu8qhhtCc2igvmzSKiEft6EP9oPG//Wpe+1wV0zcCxJRkc1FClwDag5koPSIwBbb5Jpe
	 Xj4wAZSp7wx41AkpkcS6NtBGF1RBs26GqNSnF9lY1qB3SnVxm+1/V2kr5CgLfkzsC7lUi
	 Fy3K00urJ4cwycUszf+iP0d8lTmzh1/bhevWbCtvQK0Osdhb2hHR3uMu0QMhv3MXmKFK8
	 WOKlM5TLXIATEQTqYNakHkHmFAb9PdZsv22FkKo5rwpyV4dOLiihNiKRPV/LnVycYBvGS
	 wZOlqQHaaDrZxiorzsL+enCN379EkTUIg/aqBxx4Utdki/S/9AKGiz4ZeY/5WhTTSgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206839;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MjrqIdNX7StjZJhUA/DYS8Or01NsiyBte4+gE31NDRQ=;
	b=QRPwK8fzPvhSSRp/sIhB+leIjHLhQ4yZyKpU4XZ8f5005Qu7G/fdkWbjy4pXDZ3kdrbS
	 Ua/stignDngE4Yk4s0DcGcOdubFuHWE1ZEZdgCxona3eXdFqnq4I2aJxoSgqjpezpkTQu
	 WbVrE0uQkDYt77SoO8WHWX+0JlKVScOwRsRylOBFTDoIwyckJ83d3rMnUn1Xx+J+QA3t9
	 eA8937W4BWRdtaymFpZk03dfORCHuZhJ7bW/fdhluLDS97IyBP03YRQRyyacV0YZsgvsw
	 10/JMB4Clh7FF6idsreu7aX13G9lftsIoxiLjQGlTypo5cfzp4o/beR5C3ZRKdcQIrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZrKHpJl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F81606A32A;
	Fri, 20 Nov 2026 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZrKHpJl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773811F000EB;
	Fri, 20 Nov 2026 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206838;
	bh=MjrqIdNX7StjZJhUA/DYS8Or01NsiyBte4+gE31NDRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LZrKHpJlOCAt1P6/dLRTI7Oe6qxOKjNA0w/XRpXX5OHJp8DprIBKEdp8MbEXKbqru
	 j5cMN/CtTIYmKvRXWcjGyY4/+mI43bYbDRAftAVC9VqKCzxz1ZGZzaGmxqy2sfw/vg
	 gaaxPOO6gNIHWhM4CYRXbZR1XvDgemK+E7l7dGyJAFjwyRP9A3c1IQaJ/m6sqbfPiY
	 0hmjtiP0/rBs0Q8S70fg8Olwkz+zAueZ7OtYilHxhg5t0UBxcaJpeo6TNAbOxHKHLe
	 SZlHQSzuaDexcRqBsiOF6Pkp+9vaiKGvw/5xgmTT1UTPnAtkvVTDOLLJbu6L6r/ZJl
	 CGscmrXD47njg==
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 20 Nov 2026 15:33:20 -0500
Subject: [PATCH bpf-next v3 7/8] selftests/bpf: Verify ringbuf callback
 semantics
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
Message-Id: <20261120-bpf-ringbuf-fixes-v3-7-ff7ca15d6c37@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3319; i=tamird@kernel.org;
 h=from:subject:message-id; bh=f9LC4n/hgHFtdTkqcIzv09Ns0YgNUTmqk5CIkMYCsJ8=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNkM62Y1Jy54xmvxnZ8v+HlRw8mb5uEXJXe+m6etlreHh
 6OT8TRTx0QWBjEuBksxRZZE0UN701Nv75HNfHccZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx0DFm4OIUgKk+w8zI0PdEeb37RZkFE19+/mKoLNBrLXGD02hBf/QUHyGdtY4Xyxj+V/yfxny
 yMepH86NL93R38N9ZXC9gYSercGDef/EKmcQjnAA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Callback consumption ignores positive return values and publishes each
record's consumer position before invoking the next callback. Both
behaviors must survive changes to the consumption core.

Record these behaviors in ringbuf_n. Use an explicitly padded userspace
sample and a fixed-width BPF global value to match the BPF target's
64-bit layout on 32-bit systems.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   | 34 +++++++++++++++++++---
 tools/testing/selftests/bpf/progs/test_ringbuf_n.c |  2 +-
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 633e10aa5537..cfc357dfd1e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -469,13 +469,35 @@ static void ringbuf_subtest(void)
 /* Sample value to verify the callback validity */
 #define SAMPLE_VALUE	42L
 
+/* Match the BPF target's 64-bit long and padding. */
+struct sample_n {
+	int pid;
+	int pad;
+	__s64 value;
+	char comm[16];
+};
+
+struct process_n_ctx {
+	struct ring *ring;
+	unsigned long consumer_pos;
+	int callback_count;
+};
+
 static int process_n_sample(void *ctx, void *data, size_t len)
 {
-	struct sample *s = data;
+	struct process_n_ctx *callback_ctx = ctx;
+	struct sample_n *s = data;
+	unsigned long consumer_pos;
 
 	ASSERT_EQ(s->value, SAMPLE_VALUE, "sample_value");
-
-	return 0;
+	consumer_pos = ring__consumer_pos(callback_ctx->ring);
+	if (callback_ctx->callback_count)
+		ASSERT_GT(consumer_pos, callback_ctx->consumer_pos,
+			  "callback_consumer_pos");
+	callback_ctx->consumer_pos = consumer_pos;
+	callback_ctx->callback_count++;
+
+	return 1;
 }
 
 static int process_noop_sample(void *ctx, void *data, size_t len)
@@ -672,8 +694,9 @@ static void ringbuf_n_subtest(void)
 	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
 		return;
 
+	struct process_n_ctx callback_ctx = {};
 	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
-				   process_n_sample, NULL, NULL);
+				   process_n_sample, &callback_ctx, NULL);
 	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
 		return;
 
@@ -690,6 +713,7 @@ static void ringbuf_n_subtest(void)
 
 	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
 		return;
+	callback_ctx.ring = ring;
 
 	err = ring_buffer__consume_n(ringbuf, 0);
 	if (!ASSERT_EQ(err, 0, "ringbuf_consume_zero"))
@@ -705,6 +729,8 @@ static void ringbuf_n_subtest(void)
 		if (!ASSERT_EQ(err, N_SAMPLES, "rb_consume"))
 			return;
 	}
+	ASSERT_EQ(callback_ctx.callback_count, N_TOT_SAMPLES,
+		  "positive_callback");
 }
 
 static int process_map_key_sample(void *ctx, void *data, size_t len)
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
index 8669eb42dbe0..a95d4f597175 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
@@ -22,7 +22,7 @@ struct {
 } ringbuf SEC(".maps");
 
 int pid = 0;
-long value = 0;
+__s64 value = 0;
 
 SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int test_ringbuf_n(void *ctx)

-- 
2.56.1

