Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E114A60F;
	Fri, 19 Jun 2026 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828831; cv=none; b=I7T8AMqg9PDc3RN+4QoBL77xwh1bVcq7sMBOhQbqd18zom6sjK7rgV4btT1p+V0vGdwM7yOR5TTjeSnRnIrUHVuI9z4j/6XpGoK8PiqBNsc6P+GDBWSUfB3UfyOAGYdD/VRaX6YDLXVk/ZD1HQdmDLpVLKE2q6pQVKc+VnWzEzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828831; c=relaxed/simple;
	bh=CGCb9qRFDcGc9e7ZQq52eEFE9DKiwifqHqT601ICGc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbPuA5Dhq4gnxqvEyRbWOjCm6IlrGWTl/QCjY9l4/VxPzYkUtt6ybX7J2V/vMfwxFaIzVThikV5EpA3BIZjfz58HXcZFB7CMSfOlZqEdwdEqDRTyZg+1CyYjiSHT2bNVCOSbo+3tH6rS7ouKFlmdCRKzbsl1uRp+hQJQkCD57ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxaDVUf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxaDVUf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A061F00A3E;
	Fri, 19 Jun 2026 00:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828830;
	bh=xfz0GJo0N1HOrcsNX3l2q7OqvtWMOnwlcylei6NnLCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BxaDVUf6FAuywyUSm3odWFJQPGCNYCb1W2/sBKqMTSN4nZD/YYiDkRQGa+7pdbRqN
	 3xd1Anh6rmJrPTYlbicHOdX2qp4qn+3BWrEUHSls5FKqvkKScGXQWdZg55cQFxWXko
	 0ry39VAtKm5aJWIgQbbvKFXSsYXlDTC1nuqDt3d9KI0riucRsAcHgDZZuok0cCDCyy
	 Uj3H4vkWs4lKmMvoaVDN1LZQhT/78MMLJw0uxMqD85NM5AurCh1FGBTedmpIMcAfXU
	 KKl685LLoUh4LVpbXDdU7WIRNRGtVfdC7zw/DK8GGqFvJae6DcuyREy/o4hA//X58u
	 5THWdq/ZNOIOQ==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 18 Jun 2026 20:26:39 -0400
Subject: [PATCH bpf v2 1/8] libbpf: ringbuf: Honor zero consume bounds
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-bpf-ringbuf-fixes-v2-1-33fde039ddf3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2326; i=tamird@kernel.org;
 h=from:subject:message-id; bh=CGCb9qRFDcGc9e7ZQq52eEFE9DKiwifqHqT601ICGc0=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFkmPVc3Xrz2WOBYZ/3lR6d9eLg3nLhqVecnG/dAOjWCd
 3Lp2++TOiayMIhxMViKKbIkih7am556e49s5rvjMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEz1sVSG/5XzvgaYffZhES7JdraxZLVVeNFTLHVHOuBP1i4R+ymTLBkZOiY36c7
 wtV8tu+Pn563cldsDbxgeCuXiOhdt596uWpbOBgA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

ringbuf_process_ring() checks the record bound only after advancing the
consumer position and invoking the callback. A zero bound therefore
consumes the first available record.

Return before reading the ring positions when the bound is zero so
ring_buffer__consume_n() and ring__consume_n() leave all records queued.

Fixes: 4d22ea94ea33 ("libbpf: Add ring__consume_n / ring_buffer__consume_n")
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
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
2.55.0.rc0.159.gbe5d7338c2

