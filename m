Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007638AC7B
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752474; cv=none; b=OgHtFeg5ivky2+zINZm2Aqwgq85aQp82L4Xjpl7K5CAIrnUzDeVdkr8PowsI9LzNuqrEe1S9TzbI45MG3ues8U3Mgtb1MeP4sEX4/MlfRkfmr80aEVgPrEG8NTE2HpWpLEGtn8YneO2xrur/2dOrJSZ8e580GAA5WU/CUlXHi7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752474; c=relaxed/simple;
	bh=6fhkORwl0WrQrAiPU/4A7EcUc7TS9dUQQwqIH2J989g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjhslyjN5pMQSC4nYmIsrQnu7cVSJoRYKxpByq2OKgV8yeKD4Way4MnN/lEco8LaPPFvY5l/VXiSJE11f2qYN0FurfWJYqw0W20MeUr2Kxqye4JKUAjuGM4VNyzuYY02qpM9SsRrUhX9pi6e6ECLwdiCH22PJZ2neL5lAQSoQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnInySpq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnInySpq"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so1993832a12.0
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752471; x=1778357271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sQZWwyOri3Uo6Ueex9Gln19C5muTCApAI1lF9cmGDg=;
        b=bnInySpq5gQwjAMbakO7kt/QFc8Gv+RRFaOrpWoMqguafrg/O445AajLMdRE+f/JO+
         Isvyb9GF5vTk/TEMUzywLx6W1A81sbVMnrQ5dNdGRa7YGcnmlOYbblZUK5xV1gzrDd9v
         ctLEQaAoqU07PsqFixT1+cCBmxISfZjgHa/RgPiRFxt6M7xcHsIDSvxU4lWYC39HTsss
         +tkKGXkJpWVBb6VRG4SaACJdUrSK3202+1l7/Ck+NpfT/0tSihJ9Nc/v7M+R65QD8ssL
         m/u9JhfsHUeS2dpi4PX4uOrVCiA9iijEcaWmKyuEWe1e050czC8cXYDCOQc6eKvAqrFX
         wPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752471; x=1778357271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sQZWwyOri3Uo6Ueex9Gln19C5muTCApAI1lF9cmGDg=;
        b=SKThPP2UQKVo5eGKFvKe0f52seH5zGwA4D0YHuWbzxWQ1JvmcJa2KY33rx4OChEnun
         R+9WJkDcHki+DC9j59AJ99cHRropKzCtsDqdiKI0KGEOr73spQHFgL2VMGIlFLXzSniF
         un8RCeoaaUfb806UzmMM3yuV4916taNCLGd6lQifCITv+Gp/vHQj/HsfsO8hQfKo4TYW
         BNolaWyn72qaOSHcsqRPQi5blihiPLz+DtLnAhgRTjVgby+EfevSYyUxyDZJGHK7jtVJ
         NN4mrX37IjCqsEqNM95oLAOn13oz/yDUYIg0iXYWxQdC8OoD4zeIbdQiMzaojIpSqWEy
         8l8Q==
X-Gm-Message-State: AOJu0Ywa76DGnEU3AfNBVZ6/tDylxS+Z/r6b2pY9y7g8dfoIdP8y2mQE
	TKfX1DSUNcCApHxS2JG33StvJekVb6hSMp8MNqVgddJg2HRca/nUsXHS
X-Gm-Gg: AeBDieunWysa9+xnWeOG+S0c7BVh0aQrYSSCZz5qnG+W160h4XIVW3Uiq1lBSNaU8V0
	v3zooKX1PdvlHe2LNkotenDYlu11vOoR/xjHUXInmOFmPFlVw55O0CR440AT+X2m/ae3gKW5eKE
	S7DGgri/M4QnKEUXsRd8sTw2ry/KWYaMPPqtGt7Ts1Ec6Qegnnk7mZnMIGywasWffdl3x5ieFEJ
	exlrU6Lr1DqDYocFRvQVUgQr63e8xuIIc6OERmeQZkgMzS08bcXYgKqBNm36lLDS41FpSGbOQkJ
	PPj9EdH7sdxJhf6BxAe70oMy5XkSpHpuqrNOdK9r2F1J3z8GlkNlhANbR1y3mVSzWM4hvP4dNgz
	PSdKz9S0DVmc2Brg3dFD2w9vpu8wo4fM/DlxlmiErgD4NNE2HtfOW0/15TuvbbgmD+E1Z3a5gB2
	ksAinZjGcfMsYM5y9mVOarP58fLztP2kGtiX0+xbXk69Yyi3kufjbL2gaZaiDZvp3ODJc1pVXNc
	tLAGLH2VKd6xrV509giG68UFpWI
X-Received: by 2002:aa7:ce01:0:b0:678:9826:b758 with SMTP id 4fb4d7f45d1cf-67c19b2d42emr1153618a12.6.1777752471075;
        Sat, 02 May 2026 13:07:51 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:50 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5 8/8] xsk: fix u64 descriptor address truncation on 32-bit architectures
Date: Sat,  2 May 2026 23:07:22 +0300
Message-Id: <20260502200722.53960-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
uintptr_t cast:

    skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);

On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
mode the chunk offset is encoded in bits 48-63 of the descriptor
address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
lost entirely. The completion queue then returns a truncated address to
userspace, making buffer recycling impossible.

Fix this by handling the 32-bit case directly in
xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an
xsk_addrs struct (the same path already used for multi-descriptor
SKBs) to store the full u64 address. The existing tagged-pointer logic
in xsk_skb_destructor_is_addr() stays unchanged: slab pointers returned
from kmem_cache_zalloc() are always word-aligned and therefore have
bit 0 clear, which correctly identifies them as a struct pointer
rather than an inline tagged address on every architecture.

Factor the shared kmem_cache_zalloc + destructor_arg assignment into
__xsk_addrs_alloc() and add a wrapper xsk_addrs_alloc() that handles
the inline-to-list upgrade (is_addr check + get_addr + num_descs = 1).
The three former open-coded kmem_cache_zalloc call sites now reduce to
a single call each.

Propagate the -ENOMEM from xsk_skb_destructor_set_addr() through
xsk_skb_init_misc() so the caller can clean up the skb via kfree_skb()
before skb->destructor is installed.

The overhead is one extra kmem_cache_zalloc per first descriptor on
32-bit only; 64-bit builds are completely unchanged.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 88 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ed96f6ec8ff2..6bcd77068e52 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -566,9 +566,42 @@ static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
 	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
 }
 
-static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
+static struct xsk_addrs *__xsk_addrs_alloc(struct sk_buff *skb, u64 addr)
 {
-	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
+	struct xsk_addrs *xsk_addr;
+
+	xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+	if (unlikely(!xsk_addr))
+		return NULL;
+
+	xsk_addr->addrs[0] = addr;
+	skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
+	return xsk_addr;
+}
+
+static struct xsk_addrs *xsk_addrs_alloc(struct sk_buff *skb)
+{
+	struct xsk_addrs *xsk_addr;
+
+	if (!xsk_skb_destructor_is_addr(skb))
+		return (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+
+	xsk_addr = __xsk_addrs_alloc(skb, xsk_skb_destructor_get_addr(skb));
+	if (likely(xsk_addr))
+		xsk_addr->num_descs = 1;
+	return xsk_addr;
+}
+
+static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
+{
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
+		return 0;
+	}
+
+	if (unlikely(!__xsk_addrs_alloc(skb, addr)))
+		return -ENOMEM;
+	return 0;
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
@@ -644,14 +677,20 @@ void xsk_destruct_skb(struct sk_buff *skb)
 	sock_wfree(skb);
 }
 
-static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
-			      u64 addr)
+static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
+			     u64 addr)
 {
+	int err;
+
+	err = xsk_skb_destructor_set_addr(skb, addr);
+	if (unlikely(err))
+		return err;
+
 	skb->dev = xs->dev;
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
-	xsk_skb_destructor_set_addr(skb, addr);
+	return 0;
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
@@ -749,18 +788,9 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	} else {
 		struct xsk_addrs *xsk_addr;
 
-		if (xsk_skb_destructor_is_addr(skb)) {
-			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
-						     GFP_KERNEL);
-			if (!xsk_addr)
-				return ERR_PTR(-ENOMEM);
-
-			xsk_addr->num_descs = 1;
-			xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
-			skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
-		} else {
-			xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
-		}
+		xsk_addr = xsk_addrs_alloc(skb);
+		if (!xsk_addr)
+			return ERR_PTR(-ENOMEM);
 
 		/* in case of -EOVERFLOW that could happen below,
 		 * xsk_consume_skb() will release this node as whole skb
@@ -849,19 +879,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			struct page *page;
 			u8 *vaddr;
 
-			if (xsk_skb_destructor_is_addr(skb)) {
-				xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
-							     GFP_KERNEL);
-				if (!xsk_addr) {
-					err = -ENOMEM;
-					goto free_err;
-				}
-
-				xsk_addr->num_descs = 1;
-				xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
-				skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
-			} else {
-				xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+			xsk_addr = xsk_addrs_alloc(skb);
+			if (!xsk_addr) {
+				err = -ENOMEM;
+				goto free_err;
 			}
 
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
@@ -886,8 +907,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		}
 	}
 
-	if (!xs->skb)
-		xsk_skb_init_misc(skb, xs, desc->addr);
+	if (!xs->skb) {
+		err = xsk_skb_init_misc(skb, xs, desc->addr);
+		if (unlikely(err))
+			goto free_err;
+	}
 	xsk_inc_num_desc(skb);
 
 	return skb;
-- 
2.41.3

