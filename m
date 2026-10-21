Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579234;
	b=1KayDxV5MklZAw/IgMsE0KNsDK9oSA3uyO3jWMLXzWGCNv0hR46hJhI27EscrCzxW2X6
	 JcCzJicv1Zk7/gmN0cQBL6mxrqQPXIswjYkBtaMzdpT1bZlN/zwJG/BKVLtuCSZQYVNj5
	 Yjnm2j7kXhsIrtyJ1v6jy60/FXnSZqbhuBITWXmVoM1w5TVUxsr1XKAUQof3E/hZXjScB
	 h/wzCe4nBfISkoebABY54bwTJY0Nkk5WZW9YEq2a/kK4TIPzVVj9fVXxoPYj8d8kLpv/b
	 NG66X2mjkS0XPFwfBX/4IyssUzL5yP2q336KQu9jUtkrtVbqp9ba/oCpaGHWG4+zKPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xoyujad1pnAtgsjpNYpF5h6AG9Uxc92FFpX4Fpj1onk=;
	b=uc55Y6WKDZMH/vrMap2OWUrGfkli9VZU+0WH08dq67J1OMe7xIswic72qUKnCH8zx5dH
	 UjFOC9BSBWdHHIZfzc4QIus1xkaGupNZ8Oe5niVsanVWhBoDkxw6O3NlYNfGPYQk2Ljfq
	 tdgNuxyJMbKX/RXV13xp8zne/TbRinE7ys3yGGTZdxuu+7vTb1bicwDgMgNMJLbv60avE
	 bhTYboLDVSSA7qhWYllJ417G/TXp7rAzrKJvJq48+42XKENqXHnZQzOJf9/4om7cA0MIk
	 THjy+MDQ6c7jdgTncZGEHV8SxNy9x/04yveMuxRjer5UmDMnnDL4yXUh+TQTvn0qpYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6ZKHQUB;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52463606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52463606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6ZKHQUB
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso1092973eec.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579233; x=1793184033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xoyujad1pnAtgsjpNYpF5h6AG9Uxc92FFpX4Fpj1onk=;
        b=g6ZKHQUBu2X6mfrG0PI64doqcpJVyn5zswlzh4Wn/wKt+qR5tZYZRw2DdCAkFrmy5D
         JhBW4SnGcTrrU73C7N5WBKrIlZMGdabXqri47yxoTefBdSF/RrFkTljs71b0kwJr8ws5
         inYITblh1DsVIST4KNdlqmTff4sjCGtpLI46Q3kQDMSByPMqnsD41R0LD39+vGni2oIH
         qlbESQky05tN3SqaOhjCjiVU9VICCwNOPrFEKtx+/YJusLn24sfmjuD7Nj8ZOMN6YM0u
         TsMz5A4o/NrJLyh1XHkMV/kBx6Sh2N6uVS6PkoHKGZMhVSfZhlU9U0rKSbwkBLt+ivEE
         E4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579233; x=1793184033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xoyujad1pnAtgsjpNYpF5h6AG9Uxc92FFpX4Fpj1onk=;
        b=WWQJz1NvvRdXIuOxNwRooYgSEwJo4x58Vbx6baV4958Q/H3Q+1Sb3O/WQ69vOC+3Z0
         cYcc+1X5qike9m4+P1b7bR2uv937Tzd2ADBeqJnmzjdGmjCV1SCiTSiiICxb3paCJtXu
         VoyErEsjSn+MwZJCK3QCvKfAYNNPtt92us+yPYOS0ztLk92xzkclpmOdsrVjpLVfQ43U
         rHKIn3hH8FCqYYChE4J7kGyzdEUcg7lpdQHyyad7HQ/N5dTAQgoHooi4NScHCBwBzfOg
         WHL+yhQQ3pQhtZfgXehp95/ZfqQpUiYqOW+ulqYeVk2iqWblnb0jnWraAjLC55hVR+GQ
         bMlA==
X-Gm-Message-State: AFq9FYLbzzqGFTi4VVEH5GL98DKgAqmXMeAqVJYr8CPCU6kVk/ghahBo
	O0mS3N5zF0IHbv5VbAhCrDXCdQnCjunm3Q3q69IDr6rldF+sjq/kT3jXd8up4MBx
X-Gm-Gg: AYBFou3VAIw/f3wHDx/WrAMVigh9ntA12CJiJVFH9R93CtunDBYGRzGj3g/KwAQiAbU
	pUGYG0xVWoPDdtS36nHHnafnlAVITNIxdnIm44ehl/y738EtPZmpu9QB+oqsWd/tGNRkEmu4ePP
	iMOKq/Ou+cJUNYB5o4tAgXPjX7dHN8k6B3Wji0LexcxofjRPwnZRgSysQG8nQwB0EMb5nRtn3HX
	P2DDXSGDVHj5KhMbOBcZfrvSxwpoC4XciBIj/GBVgIKa7zHSWrSy+gW3pSZ3EWjwVYJHCxobwDK
	9tXrSRkcT0CjYY1ofdg+bPK+DRMhWwfEXmraRIqTtHy8X4e+UWvsEsjJpAqXZCSLVCEWVxbJSk6
	PXBjV3ChL+Naz+24FNJ4+YGXfFGbCt6gzgfB+tyVqq9B1h2tjriAtO6xnXYoX3RD0t3SuIQJDq4
	LhtWNeue/z42a9hcCtEetkwErSaFfk7UZ2qE5Pge8k8kUV294xqGudiyIWsQyDl/sX9ZaUS+SVv
	9UoSWhYDtAJX899Myu+Z0oK4c4Vo0Ubsepl1iSLx+mA7US3Tq0dgXnDjXrX0gnpM06wDge/Q8nF
	ABh2tt06OqjAPEI63B5T+nUbBPR12aVZTeP2yfQSO40upsKaq5tgy5NwU/vWaGT/qjqaypZj
X-Received: by 2002:a05:7301:da06:b0:351:8cc4:e18b with SMTP id 5a478bee46e88-3674df50b8dmr2692342eec.20.1792579233319;
        Wed, 21 Oct 2026 03:40:33 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:5209:19f3:3930:87a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e24933csm6096611eec.1.2026.10.21.03.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:40:32 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	hawk@kernel.org,
	drosen@google.com,
	netdev@vger.kernel.org,
	Ayushman Rout <ayushmanrout27@gmail.com>
Subject: [PATCH bpf-next] bpf: Use memmove() to load bytes from an skb and an xdp_buff
Date: Wed, 21 Oct 2026 16:09:57 +0530
Message-ID: <20261021103957.17532-1-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_dynptr_read() on an skb or xdp dynptr ends in bpf_skb_load_bytes()
or bpf_xdp_load_bytes(). The destination can be a slice of the same
packet, so it can overlap the source, which memcpy() does not allow.
On x86 with FSRM memcpy() copies forward, so a destination above the
source gets the first bytes repeated:

  p = bpf_dynptr_slice_rdwr(&ptr, 8, NULL, 64);
  bpf_dynptr_read(p, 64, &ptr, 0, 0);

leaves bytes 8-71 of the packet as bytes 0-7 repeated, not bytes 0-63.
Reproduced with BPF_PROG_TEST_RUN on both an xdp and a tc program.

Use memmove(), as the store side does since commit 1db084f42884
("bpf: Use memmove() to store bytes in an skb") and commit ab08863c58b1
("bpf: Use memmove() to store bytes in an xdp_buff"). A read that spans
xdp frags still goes through bpf_xdp_copy_buf() and is not changed
here.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Ayushman Rout <ayushmanrout27@gmail.com>
Assisted-by: LLM
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b7ac145b68b1..35d38e02fc1e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1789,7 +1789,7 @@ BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buff *, skb, u32, offset,
 	if (unlikely(!ptr))
 		goto err_clear;
 	if (ptr != to)
-		memcpy(to, ptr, len);
+		memmove(to, ptr, len);
 
 	return 0;
 err_clear:
@@ -4298,7 +4298,7 @@ BPF_CALL_4(bpf_xdp_load_bytes, struct xdp_buff *, xdp, u32, offset,
 	if (!ptr)
 		bpf_xdp_copy_buf(xdp, offset, buf, len, false);
 	else
-		memcpy(buf, ptr, len);
+		memmove(buf, ptr, len);
 
 	return 0;
 }
-- 
2.54.0

