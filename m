Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D86408614
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759368; cv=none; b=dJ+if4E1+E52d6TgaIY55j0qaUVKEp2YCcD5q7cliNDua4PMN7/LVQxJSOebAdP2aFzVOeuuE9LN2dH8fRdRc2TU60wO5IcF4BSCdO9bnSq/aDIm/akBfdeAYUEbX3ZgDr8ewXjo2y9AMlfqFfR/2XwOTnTvloyFJdN3hD70sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759368; c=relaxed/simple;
	bh=eGJP5JpZ7NVynKsatncjx+ngzI7UgZglI/sW87qWUfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKeuRj34zItNi9MXBl51WVO531ojB0ExK8vG0s7ZQcQFBfhPoGe9fDtADPoVRzj/0GgaLrPn0U29vD9yX2jzYnhdT7THD0d3FJo734zUCST4yt+nV24JkZeMkHBo9iVvptTcPjPNa9a1qG7DoVS9z8o6+Z+x014ief3lsPPOU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=I77Pdct3; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="I77Pdct3"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c16ac21acso19757841cf.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785759363; x=1786364163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GkOKniZRC1idBdL8qT7wVf89hPYa4Ml27SMbxT6diJc=;
        b=I77Pdct3f4tQxu56Y/eY5BIuQKuNzGEL5CH1Ue//hEXgY9fpFRzFPNCd/HjDuMtbTt
         L4ugulpFm//iDU+ixP6HLQ2I5qPWGeZcex6AlLF22ZZNIXIk9jVAlDIaNsp6r+qqdLK1
         nBk+h93shiGk2Jst1/p1HWB2TfGn4xomWyFvblaAwjP52UNmEscsnFN7sujEU17DPAL/
         0/VNcwtFTJTprCJOMc8lpIPwXUO0hs1bcQ8VjZi3QsqiRYrfyGPI8JuvsSyJDeQEkae1
         0BqrhMibSs4HMUjwQGi7lsJxpzLXlNej81Ztk0hJgM2+3uNxNULfe+lnuK7yUswJuaQa
         w5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759363; x=1786364163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GkOKniZRC1idBdL8qT7wVf89hPYa4Ml27SMbxT6diJc=;
        b=qFkb3PVD6v/SibAdbKFtrGKwt+OkgjDpRBs1BAdSxPV30PoAAt1MvpWkfeZDhHOm3j
         a3aCVPgoJaYsxvwlQJMJZRig2UIctzGOKBGAIwcLyipMOa9OlKnbuVOdgKtbiOdOhICD
         3wKEV3PC9HkiYrVQSGugc77FuwE71JSgOgplSiuxegbv7bXWX6ayrHE7N8L1A8klr2u1
         eIcMjjFtJ5jan/E1t8zLWzpN1cNL73ZNBfxA+1IARoIizFIK4a0K/aKznVWIq13pqrSA
         ZXPzc7Witl1Hd0ToQWemhracNcR+FrdsSBakEQ2ZTyhCta94+irEsqlDROfkKEBXj9YU
         fN2A==
X-Forwarded-Encrypted: i=1; AHgh+Rrcrik4pJXTU+YqgKYfCLj1drniUNGDOFIaSVfggOjFwv202iJojBaUmY64cYmtg0z8shc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Qofn/gQZWh0xq0sEpumZv677bEIJy5XvF5+kaby5MO+GsBFM
	mxFTwNOLWSvsRDrAaZPUqrMyCIve4Gd3caqpHZdlXEssNALVe0VUv9mR/cHJ8Zal6+gohiAS50o
	ad1+ryhK/3Wd5zg==
X-Gm-Gg: AR+sD10cc+/TtXwW/z8yohMj6mX0RSzlTm6LHTAwwSUK5IQw/HlA2GvvSlsKPmmVlaD
	iE9kbsJXAYW+yZ7RBzNh9KNyxVbfmfRpbA9F89BLegPauoApd+3tRshaH9vokMlUWi+/SXkJxrl
	6KOHgPKo/8yHqMGY1yW2GbUIbTi+KHgkxVzmmYrLmSp8SgZfaiB5IVclYpVi9kXB+7vdjGgq+TY
	38nOQUlr9LSKcvrC8RO1zqAYA1idGj4TA8peeXQZ6LQ3lhVngqTRBx7gZJPUD8UXBSL4gev9gKQ
	J/cQjkykoneYfqs6sWTOz4M8enq4cPNOUGEoDZKnIyA2ZHwMbpcP6nd/vom0h0Qlm0k98NNk0a3
	/DbtX+3OIM74+1dbJTPtprfIjpdLX/VWPLkUNAr0IlH6C4KkYsaXt0aPgURa16JBnofg2L0CRzh
	95GML1XIqqdRodugnVh0gcBMxuEs2kHrYKRLrNW/phwqorkrOtsjWgJwY7bVGB/bYoUkTuxpwT6
	09+bxLVdXKzRCU=
X-Received: by 2002:a05:622a:1e0e:b0:528:3c2c:5c72 with SMTP id d75a77b69052e-52b5679527amr193003071cf.32.1785759362991;
        Mon, 03 Aug 2026 05:16:02 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e7ee1b7sm59323971cf.5.2026.08.03.05.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:16:02 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	liuhangbin@gmail.com,
	kafai@fb.com,
	toke@redhat.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] xdp: reject clones that overrun skb_shared_info tailroom
Date: Mon,  3 Aug 2026 20:15:32 +0800
Message-ID: <6b2afef5d1738763c6965e8e466eb16e43e4f956.1785757386.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785757386.git.zhilinz@nebusec.ai>
References: <cover.1785757386.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdpf_clone() clones broadcast copies into a single page and sets
frame_sz to PAGE_SIZE. __xdp_build_skb_from_frame() later treats that
page like a normal XDP frame and expects the usual skb_shared_info
tailroom at the end of the buffer.

The current check only rejects frames whose linear xdp_frame header,
headroom, and packet data exceed PAGE_SIZE. A source frame backed by a
larger allocation can still satisfy that check while extending into the
clone's required shared-info area. When such a clone is converted back
into an skb, build_skb_around() places skb_shared_info over live packet
bytes and later writes can corrupt XDP return metadata.

Reject clones unless their linear area fits inside
SKB_WITH_OVERHEAD(PAGE_SIZE), matching the tailroom requirement already
enforced by the XDP-to-skb conversion path.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba7..0194e69da339a 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -871,7 +871,7 @@ struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf)
 	headroom = xdpf->headroom + sizeof(*xdpf);
 	totalsize = headroom + xdpf->len;
 
-	if (unlikely(totalsize > PAGE_SIZE))
+	if (unlikely(totalsize > SKB_WITH_OVERHEAD(PAGE_SIZE)))
 		return NULL;
 	page = dev_alloc_page();
 	if (!page)
-- 
2.43.0

