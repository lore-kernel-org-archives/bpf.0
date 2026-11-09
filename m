Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253665;
	b=Ov7ZvsEfabNI1rvSIGpc7F1rZf7l2scJE9IBVnnrec1YGgAnzlxl22S5I8BdBH3Dufi3
	 49iBEnx7PytuIQQcc6EARZh5askGB5aWhxkpkgjVqY8/4A9YuCTf+t7hAY+2HZK9Wy90v
	 TTDkH6bTppeC4zFdba0RwsIYIxOW0RIFYMGDUhyb+60JD/JdN9m96FsZgfp4dU/9mEW39
	 HNeRnH5gGRUDCCJ4eYRvrMaFlJOwogE+BcK6mPG0LfnNYb2oOrHE5ZKCq6ZWG/RYPNsZ1
	 +bx8A5nTVPvqWRuB17o05pWqarmEOgLGRNSCQGqlSXziNWxms6FFrqcckXHxl14TZUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=szhiKSVTGigSpJnic+4qfStE+s8SRyKIbzohMOZJNHc=;
	b=XAk7tlwSzfMpkisO02gZtTFS49p35RGLKGmIsfoaD9HbT9kjbtcILyIOOq0GF5aWNzdd
	 QgctzsDkBmIvBdxE2TvtnZFowVYZ5bFqRhp8ivTisUEWCftIKSfEMAeUb9YuN1ROvu+hA
	 SVAkoaRA2JOVzPxmcn9t7mpsSwfOHekVODad943hIaWCrHJd+obmCuYwrOrxVVkS2DA7V
	 uj0guVqkj1LLF0o7iGy+a6JDg825deMpbZGfR1jldW9oQVFzfO5P+HzB4ZNdt6HcfCwB/
	 ZZA0FkvY68ZZtdbf2C5oe98EzbdznM9E8eBHd+nyYdcds8AuELWtsiKxvkfiub07RcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqT0hlJc;
	arc=none smtp.remote-ip=209.85.221.66
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96466606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96466606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqT0hlJc
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-490d59c3edaso973440f8f.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 11:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253664; x=1794858464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szhiKSVTGigSpJnic+4qfStE+s8SRyKIbzohMOZJNHc=;
        b=BqT0hlJc/SUXQF/e4BSteIDdQp9qrWIzjj/+y4nd660Ypvvu/ZMPCIFTN8ztMX/bag
         Gk5aPnl4tppl0l6wiRlA2q74y+m+7V5yD8QGLlv64fZU0PeOiRwoSqAJHqc0YgbfXgth
         +fk1FDx/nP7hxprYFZmKc2MHkxb7WeZlnkTrUtWFRnpbYET0N4Xq19hlzTQ1CGPi/aVb
         3SUGg6bzIRyu3fjwS3+AvACLM7L2BkSNtmPY7gIfwkJl6aKl/Lmqb26HOnvehBXvS0iH
         x4dZzUo78fKI1xzeLjAGBcyW4qHAnFy1pCbwuzW5mjBNkU6pxxfmzAAJHNKasQnybLa/
         9b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253664; x=1794858464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=szhiKSVTGigSpJnic+4qfStE+s8SRyKIbzohMOZJNHc=;
        b=skI6W/ngjvl/72h33rEKzsWitvdpTqcfHJ9bYUDGMpo/kRMC/SFYpyYCTkyk6dAPEi
         lTyQYZF395TDid+rjzoqMTJkpk+T+G4zsuWlvjsfzft+PaiIAzctrc5kwGbKzrCOh8KK
         VqAqXbn+vmw33w8iCmkHWTbK+NdoNS/II4cs6P8wqAFJFQ39Dk5VG6fxl1ZO0yD7niB1
         40NpL3AlFCWYFRZcfqNG+RMa0vyDhKull6lN/r/umStrOAbq9kfsvPs4/MEl6In/LH86
         wtMRVwFpNPWZ/w+t5jkPDMX27xwgLBuXC1yNadNpf6Z8baOTrqpi1yFflh+26HSV+Zeg
         hb9Q==
X-Gm-Message-State: APuU4Z/sKvp0ye6WCyCfQux4qJY6g7IL+g1q5BpD02SF4mmDG00VMjkd
	njPofDwqYJ515WZizrG50MiXHhF/RE9eY6IdBAuuJlu2XltqN8a11Creur6a8Eti
X-Gm-Gg: AYBFou2YA3/f9wTYIjQ8LKBxhkkVrcAZmKJuMKeLFblPpfpEwB9TS689XUGnc6HbHGG
	G31vc+9vR3XnMTqtHizn2NonGQ4R64DPMbhD+i/hsYPqqUwo5+F13zyeyXx+DMk6h+tGL/f/+C8
	HHaG0xTzlXe7olZq69NViWxbbuX4biTXhA94TzJzfG+6NJKphbpBts7pb9FUdJA7tr3SC5gUrVh
	tgwqgGpNlLzHVjdi+hrDX7Xpq0BNOH+IMEKcBMv+Oj16knBmiapZUbIrnmJGEJWEzjB6kEwT4Yk
	4BqSFJpuJ2lQi8CbTcJj5JVDm+GGGfGH7u0QU1Qr2sqgmaeSTAwlhUgnPoSaS6qPOs0sRuWRsvQ
	7CwNBCiEAFwhI0/pnYIWNAYaS0LSFGOcgmGt3AMObsDD73d1JsLjBqoUDdX6Bq8477glFjqqRgn
	0p/s++fXW8hRETNxpOzbE0VkOQuF/4vLomKx6gKsZXrKr/74iJ/dCF6Sr7V1p2wlxV/lYB0uoVG
	PCwV++NclUWr2lqniInLa6ikRVi5Wid2DT9idHjiwWMIPLS9yYEQ12u7Rt8NDEDSCY9CeWbdS96
	rlRbzVtoiAdsFB0X1S9Ab5UldSGAtI4gDT5ffTTSXFk01VDMC1waLm8KohtliBOXScD68M1pZgi
	ALiFcIY3Xmw/KtSGdq7jvSrf4uGlbiEKzdEeaUL2Yl2+OP2xPMbWd3Ta8Y936meCKMKVG
X-Received: by 2002:a05:6000:468b:b0:48d:f1b3:7e67 with SMTP id ffacd0b85a97d-4982efd5e8emr638366f8f.18.1794253663962;
        Mon, 09 Nov 2026 11:47:43 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2c05dsm766021f8f.25.2026.11.09.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:47:43 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 6/6] selftests/bpf: Test that callbacks reject an overwritable ring buffer
Date: Mon,  9 Nov 2026 20:47:32 +0100
Message-ID: <8d7e337a92d78115ccabe9dbc1d9da892e66eab8.1794253561.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794253561.git.memxor@gmail.com>
References: <cover.1794253561.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2574; i=memxor@gmail.com; h=from:subject:message-id; bh=WS+mc41YZIoq1tu7twECfAXmPWO7ugaTTmbVHskcHoo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuT0p9Hv67+/12e48A6+U9Xwfpve6at+irnKZhbtEZqv e2HoPcKHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhIvyTD/8S+aUxLj1xtXcF/ Y8nr5Xb3lVtS6qd5uTtVPin15P6TP5mRYfkzB7nTK2ILwhcuDni296Hs+2drTy+pTqyqvHpt4eO KTxwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tamir Duberstein <tamird@kernel.org>

Add the ringbuf_overwrite_callback subtest: on a BPF_F_RB_OVERWRITE map,
creating the manager succeeds, and ring_buffer__consume_n(),
ring_buffer__consume(), ring_buffer__poll(), ring__consume_n() and
ring__consume() all return -EOPNOTSUPP.

[kkd: split out of "libbpf: Reject overwrite callback use" (Eduard)]
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/ringbuf.c        | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

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
2.53.0

