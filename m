Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253662;
	b=o2K4b11s/t+o18corquGAq5+lOyHYHfkF5eNgNmYEwzEit044IyCvsidhHQlnpIwgT1I
	 R2ocIg1V76fMUXeWHyxBrn3ic5Vb0Q+Jne9GypgbpspnsLl9279qhJFla5YWyKwe+9KlO
	 CTuM1AsHVOL3Z3KLDBRH16H0xycdYDhWt4EMvNUtgD8PmJJiHu5fkQkX+c9GLddRpEfHW
	 jgFYrO5NN/XTApsdoSu5nUaFpsPuKNLd9Mz480gzHAuuujflJbIaast53Ik8GS7aujLv2
	 6W2wYR9FLqZgtAjK1evUL4SiTNCADJrBCai4Ru39NNkkHfiyRpJTHe/7rVSy3pZoJbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=Zz76mvN+Tv2Jmj7BtsNuclzYBEGFZAKIm4AEoMX+Ohw=;
	b=AE248ts7wz4G27CZDWzg/L4euoDicJBrFPqd1Ukw21ZuVTfMg6fDAgQFFogN+QB3ggXz
	 dEnRCscs1bY4qz0fFTiyhYrwj7RulMiB0Vx3WvS2qEoo1JOPMUoBAfsbqcr5CP8wPcZ/t
	 5Qw5xtPpz34hu7JSDPIR7q8KsZn8xOaa4KQt+YfJoEodMVS5ma7i2sB81Oc9MQdm76GK0
	 JwambzddFVmXun/U42s4D92vAXQpjsrhDjokEdwhpN4T/Mk9P8LEP9DSEjC6v/AQdQymC
	 uvs49T85flK6XQYEMsrjaDUgn87PIMPC73jz2LyU4EXrYFHa0K6TN9yg5fwFyOqX9qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WqKezyji;
	arc=none smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58A606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C58A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WqKezyji
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48fdea35dafso548112f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253661; x=1794858461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zz76mvN+Tv2Jmj7BtsNuclzYBEGFZAKIm4AEoMX+Ohw=;
        b=WqKezyjiffKialkYemyqyJ1dI+mlSeNKKCNLgTdjAzInl/YOtW/1nF2xidVBbys5dy
         YSxmQTJrdWBbuwdbOMHNNAlDyYGXIdaGDukpuAjkhIyQS8GUWjFC4+E3hk41CQ/20s4/
         W5/aXC/BhaY15lTCNkSQfnfg2BSrm6PehrnZGu/iXYT7w9iSqfP4o3fnmCpPttEXsJiK
         HASxMazpV1Mmxl8HB/iOiqkkjijolTdhCrthbGv79NggFDrH/CeiUeLnhFVZDdHeB9bN
         GPAtM8D1Kg/kGNR1XxM8INI2xNAXrOhmjxIqX+2k1X09MMgZgpCqNbscH6u4P9txGnBr
         hHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253661; x=1794858461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zz76mvN+Tv2Jmj7BtsNuclzYBEGFZAKIm4AEoMX+Ohw=;
        b=Xtrj7oWGCdrkwoD5pnlKBGOkhxpK/3sC4ZJhRCxacjnZ+Pyn8jTu/KDFCHdNpvBwkl
         eihT5Ch2X7t3HBaCY8F1vLOearYJ6rFJkQrZIJzhXoZNQ+Uhhl7FaeJllAei7bu/pRmb
         BBRarPZJI6mv2rSIdOHi9tacsFBP+zFVOWaAjENW/EfHUj1QzTpxe3k32EDwVVoyVyoi
         0R+FL+/FoZnknuZjVtihWt/LeHCXLnYIarzqjvYIt47N6MhXl5Z9iku6ZuLSIzjMwPAK
         9YZASZWD7B/UH0i70W2SO/3/+VSZuhN54QwW7WHGmVKXZU87k7oRZgXq2hb3xJHd0xt/
         SaAQ==
X-Gm-Message-State: APuU4Z/HFadGhFAsSqhuALUi0LAeogGf2Sy0/2cCB/bYnvrNneskS+Ya
	j87DjWN4a+Jch7BCFIz0bDsIBA78wm0Gipp1OEX1hYv72m1VKJyuQ7kNgMRfBPpm
X-Gm-Gg: AYBFou2+ex51X0BLHRLqLBcBqZalFETW1DWCeE/Lhqea2G84PicQ5pQEKl2nUtZZzlP
	vV/y8Gy62T0sSjxaybtQK0N9EtXZuoaesnD5v7LUq4KW0+Q5cW7lGM0HOD/o7W08TgZvrsdpIYr
	B8Y/gVbP5yRlHo9ja31dMpl5JV3y1Ze/MnVWvtvK4l8hreQsqWoFcUSmNpsVyz25Sy35ynIMzwG
	LDNsvfXUZpwrVov9dT/CKYTLVrjZNo/IMvsI3ciAng3CX02fgPsysHgmvDU9Xd0V6OIsgOfJN5Z
	+HIKkaedA066hoq/U1FrpbXIdwfUvQmwDHHHzeshkIey+RxmDXDhI2yCuJyWAQOH/cyL3MMTrXA
	uApI/DLy8MhTC3kR93lJg+vFQvrYtLRYl/XscirnzJXlpy5r8MwbA6/3rvnVUCEbi1A4cn6NnIL
	8yfFZni7oC6gJk70cE1h3pAD1w3ckTH30c4PkTa25YtEygh0Oy2PsvdfAv4svpEdEyHXkuuzIXU
	XRsZUZNNEjBPlAnrVQMJ82A5mXLY4lRQ54G2r8xj/7N2mjcgcPnWODNruJbQk31fP4fxWh1SJGq
	CLnjj9lKMT+eMMbJdbStGvsW4LLBx4wHxEbkjhKDLwpKtXN/567eNiwGKwQCljemq1+xnpsORn3
	/6m8THX5hwF4oxdZSp262PGN/bdTGVL0iue+4Dc+SSEUHXhHQbDB/gN6gkcn3Z/AkfRye
X-Received: by 2002:a05:6000:1625:b0:48e:2bf4:e7f1 with SMTP id ffacd0b85a97d-498309ae344mr650693f8f.39.1794253660964;
        Mon, 09 Nov 2026 11:47:40 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2c05dsm765845f8f.25.2026.11.09.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:47:40 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 4/6] selftests/bpf: Test ring buffer consumption with a zero bound
Date: Mon,  9 Nov 2026 20:47:30 +0100
Message-ID: <0136ea50ce01d6b66eb86ee4d8c5b32e9381d595.1794253561.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847; i=memxor@gmail.com; h=from:subject:message-id; bh=gJW0I/IODsOuWxevtbvb/bvwn67240CXi+jo5QmarMk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuT0u+Z1y8cvCen88WvLft/6EbW/SHrM00FFBaukY3KC WY2fe/VUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlskGRkuLE3u2viY8mWk5IN HrzJDXsVhbJ99/FN3nqq49rf5tQHQBWv1mbWsFxsa9QqL2TTmDHD8lDp+m2N1sJuhfZtrn25K/k B
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tamir Duberstein <tamird@kernel.org>

Extend the ringbuf_n subtest. With all samples queued,
ring_buffer__consume_n() and ring__consume_n() with a zero bound must
return 0, and the batched consumption that follows must still find
N_SAMPLES records in every batch, so neither call may consume a record.

[kkd: split out of "libbpf: Honor zero consume bounds" (Eduard)]
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

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
2.53.0

