Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2602BEC52;
	Sun, 14 Jun 2026 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401740; cv=none; b=pZX7mcjjrmH6N2IIBg8hjTIPfw5JiaQSbeRE/fpI8Gg4xt03kSHV5snMzf5WrqPSEduXMPCp2BfMikhvxGUhJzv5ck7inOTCx/T6hmBXGBHZohOoz+cqpLGIAqaSmv7m1hKZZ5nry5vHulzabPNCUz0grlw76m7/G+OnOpz2v9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401740; c=relaxed/simple;
	bh=DBKNUZdAMj6bSagYPwgcWaJ8WF0PnxyB91wcw00di0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7iLwZ0bNC3SCZNFAPOF6mlYv/MTCfKYkr+v92VONkY2dgyU2jG24NMaC5kdBtxcyNZFzhPlmlOuuU3WN/VDgeTG9dtnpuSJvQPEt/2Gm30g2DQtcQFIIcEyxe6zUG6IOtkkINWLK3X/b6UUI8h4nkPGPxI5xVPSqyswyREAN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWExeDoL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWExeDoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0511F00A3A;
	Sun, 14 Jun 2026 01:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401739;
	bh=MFd6UnDGSXM+qG6L2BjjQmo8dJcwdDLPi/S1mLV0gyc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GWExeDoL4ydV/IpeRrQSSDPxy04gfiMUKDaitO2lZ3OymTT2MU2nW2p/t1HUQtXZU
	 /gZ9S1lKkCcf7iyTi2AMWVihPzAnKf5DB2LNMCln+Dlp+EDpzIwz1dDpqe1AX84RIL
	 UKk3ocFPHAcHcmGIZmWv3YCUHVxkEuKIUQOPdjqy9caQEGSRvpIt5mnQXhc+R88NW/
	 JBUqqm2lmw6lWJFNBvA7RPTvGLygg10XFiOnhHQwLu+UYRUvqRtQz/lL+StL2G9GXZ
	 5YDv4E/xGf3YOUQkC0WcHdxLsJNqKija0PCCXBEtT2UN5xgYk7QW77en35nPFEb6iN
	 ImfA9OvMTyg6g==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 13 Jun 2026 21:48:44 -0400
Subject: [PATCH bpf 1/6] libbpf: ringbuf: Honor zero consume bounds
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-bpf-ringbuf-fixes-v1-1-e623481cb724@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=tamird@kernel.org;
 h=from:subject:message-id; bh=DBKNUZdAMj6bSagYPwgcWaJ8WF0PnxyB91wcw00di0U=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFl6HK08Vw0uT7mXusT06M7S9aFzXH04lT7JLF/yWySk4
 IvxZGO1joksDGJcDJZiiiyJoof2pqfe3iOb+e44zBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjoGPMwMUpAFP9zJuRodE8OWONxW6mgy7PY1dprfG5UNe398DGrpLNhy3T9riqzWD4X/XvVJh
 S+7cJmSvWNOo/r3zEqvIgqOPPaq6PpjN/MFz9wgIA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

ringbuf_process_ring() checks the record bound only after advancing the
consumer position and invoking the callback. A zero bound therefore
consumes the first available record.

Return before reading the ring positions when the bound is zero so
ring_buffer__consume_n() and ring__consume_n() leave all records queued.

Fixes: 4d22ea94ea33 ("libbpf: Add ring__consume_n / ring_buffer__consume_n")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/ringbuf.c                          |  3 +++
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 00ec4837a06d..f2bb619d5a75 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -240,6 +240,9 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	bool got_new_data;
 	void *sample;
 
+	if (n == 0)
+		return 0;
+
 	cons_pos = smp_load_acquire(r->consumer_pos);
 	do {
 		got_new_data = false;
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 64520684d2cb..4f0558f14847 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -404,6 +404,7 @@ static int process_n_sample(void *ctx, void *data, size_t len)
 static void ringbuf_n_subtest(void)
 {
 	struct test_ringbuf_n_lskel *skel_n;
+	struct ring *ring;
 	int err, i;
 
 	skel_n = test_ringbuf_n_lskel__open();
@@ -431,6 +432,18 @@ static void ringbuf_n_subtest(void)
 	for (i = 0; i < N_TOT_SAMPLES; i++)
 		syscall(__NR_getpgid);
 
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring"))
+		goto cleanup_ringbuf;
+
+	err = ring_buffer__consume_n(ringbuf, 0);
+	if (!ASSERT_EQ(err, 0, "ringbuf_consume_zero"))
+		goto cleanup_ringbuf;
+
+	err = ring__consume_n(ring, 0);
+	if (!ASSERT_EQ(err, 0, "ring_consume_zero"))
+		goto cleanup_ringbuf;
+
 	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
 	for (i = 0; i < N_TOT_SAMPLES; i += err) {
 		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);

-- 
2.55.0.rc0.96.gc050c23164

