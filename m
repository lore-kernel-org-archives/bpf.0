Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B86388E6D
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673736; cv=none; b=gzmW/EbfhmhNR3/6xhZrxkT4QwrmqMArW8TwGKWwLx8Zui9J9oGa8D6y1D+b+uOfkpa/ZyTc/bSHPort5oBvC8qarbcnKF3T5h9CGqvWrljfh5VQqBCKRCKUurzA1ZoIJlZprJT++ngAQL5b6rDiMZ009ivFQvda+Pxvx8FFb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673736; c=relaxed/simple;
	bh=lqwv1bH8Jw1ECCA2rL1nMFEli2HTbp8f93hcHsXXRV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vl6yiI0vnSesfL3G4N6xCKEGvMIpF1c18XBKJF947lYrxqg/In3AbTaYVVOYYNXyvpSumH6iGIwQdOJLGGJmRR6nDRr8gvrMyVYTgn0ed4KcLZ0gOPUtU1u9OyYlvn6iXtfc7AqCY0ji8zo2R4YEQ+x2hCsi+sLQHFmUgbprrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye30wetU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye30wetU"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c7961d7bc09so928957a12.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 01:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673734; x=1777278534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGgn6dYRd9W8wi9ShyWx8cM0aKPHhjB6jSUkwtxx/s4=;
        b=Ye30wetUmZIh70TffW4tGcIubiknGWO8Zoby0nLsQlCEAr3m/FIiGevdJhWtwJnlD3
         Y1mIZxAULuURn5fnOYx6DAW416TQz+Ui+6zRJ8QsttUZEhuC2HnIoMoQzgxCJU2jyzUS
         HtOaQjLIzy3uZzT+otaXU3IHdD4Xm5KOP76Yqa3vP3pa+rqrUswvEj6QOALMUJ7W0TSv
         2L/Vjj+pa95rkcEfLvud1FRkP/wlfQGbvFMZVbaKtgkOO3JVbfNzxF0Cs7UTcP7zTWL+
         HBDHiIkB0naa8Jb4eOUlbRUPWfAp/WiKtD6xFWLRPzxUln2SJqsFNOWhRgWBLPuOCK54
         b6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673734; x=1777278534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AGgn6dYRd9W8wi9ShyWx8cM0aKPHhjB6jSUkwtxx/s4=;
        b=I0tkk0G7wQcrMNh1HTwp2NwUyB41TgucilKEeBWZ7D/Ky0JuSv2wawsfLfpIbNpzYq
         ATGBzemjtljXCQVH/ibsZvFt7ubjtKyLEvrVooaoKApb/CYuvavrytSDWKWKWNqUNGR/
         XdjjEwedfLJtETwk3IxPoMHUPkSUcV78iaJuHrjaB9METaatz9VS6jKGk/mNUhngFLMC
         274jV1uaxYkhVgI1DSLR6Nj06MMYJF1SRpJqI2Q2uZW4y1xWDpBVJs0Ba78GLEHYXB0Q
         +ZGSOXbSS6A5l0XBizw2F9Sg9UdhKFoCpYt0m12pqTLTQ3DxDI/vM2lsxvi6Tlc4o1MA
         koJA==
X-Gm-Message-State: AOJu0YxT0cCyWxJ67IX4+fV9qd754stS0F2Ch8GjIhRBpvQhUJ3Ir/kT
	ogIFMpL3HhtdgNlabCRx9c1n5WGj9ZHo5UWU1srk/XcAIgzIbWmUOLZS
X-Gm-Gg: AeBDieuARQ+O2JUU3lfDhxV73jWXnXdq73cdMI5seiCnF210hmMaJwgATO3SeBd722K
	RRLnraRoZpSV7TIeIlpOyCaSQbdby9A7eCHxnakLJBAtekA42h0VtiwbkRrfnYrvZmVVeWDJB3g
	FVKNyPmKxA4M+JsdaZfxDSDY2Y2dIuCVsYNQj0XJKRf1H+I/St/Lp5XTr5Rg30MA+yrKK51nvbw
	kb9Jqkz4MUCWj5TYOezvySt61KLxEvgHcPuB4xGhUzFveCvOUFpHtFePoZbAjrd/+xXKIh7MieC
	w+SfiIjaLmxGQMaeNh1ubrFDE8f9KV4qtbSByD6Qek24vziV9ZS+ARpwDWRhFWv1dW3qHQ7CK19
	APdNSfV8Z/+P4Tabk9J6lDjhfAoHCmPgxD7Klhdrccu/VULmlCJgHksyCtqyt4zkDBRFC4Cdw0W
	Dvd3NwO/kr0ahLmSrPrmWvX9eANcnZmQqlictH2wVzhuVlUFeBbrEqss09CTsTkIqVFlyXeEl+c
	wSzbbUA
X-Received: by 2002:a05:6a20:3c90:b0:39f:acae:f12e with SMTP id adf61e73a8af0-3a08d748ad4mr13957846637.22.1776673734330;
        Mon, 20 Apr 2026 01:28:54 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:53 -0700 (PDT)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on 32-bit architectures
Date: Mon, 20 Apr 2026 16:28:05 +0800
Message-Id: <20260420082805.14844-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
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
xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an xsk_addrs
struct (the same path already used for multi-descriptor SKBs) to store
the full u64 address.

Extend xsk_drop_untrans_skb() to free the xsk_addrs allocation on 32-bit
when the skb is dropped before transmission. Note that here we don't use
0x1UL method to judge in this case.

Also extend xsk_skb_destructor_is_addr() to cover 32-bit case like above.

The overhead is one extra kmem_cache_zalloc per first descriptor on
32-bit only; 64-bit builds are completely unchanged.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6b17974ca825..bd49dbd9875b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -556,9 +556,23 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 	return ret;
 }
 
+/*
+ * On 64-bit, destructor_arg can store an inline address directly
+ * (tagged with bit 0 set). On 32-bit, all addresses go through an
+ * allocated xsk_addrs struct instead. In that case this function
+ * returns true only when destructor_arg is NULL (set_addr has not
+ * yet been called or has failed).
+ *
+ * For all callers:
+ *   return true: no xsk_addrs struct to handle
+ *   return false: destructor_arg points to an xsk_addrs struct
+ */
 static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
 {
-	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+	if (IS_ENABLED(CONFIG_64BIT))
+		return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+	else
+		return !skb_shinfo(skb)->destructor_arg;
 }
 
 static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
@@ -566,9 +580,21 @@ static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
 	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
 }
 
-static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
+static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
 {
+	if (!IS_ENABLED(CONFIG_64BIT)) {
+		struct xsk_addrs *xsk_addr;
+
+		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
+		if (!xsk_addr)
+			return -ENOMEM;
+		xsk_addr->addrs[0] = addr;
+		skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
+		return 0;
+	}
+
 	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
+	return 0;
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
@@ -644,14 +670,14 @@ void xsk_destruct_skb(struct sk_buff *skb)
 	sock_wfree(skb);
 }
 
-static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
-			      u64 addr)
+static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
+			     u64 addr)
 {
 	skb->dev = xs->dev;
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
-	xsk_skb_destructor_set_addr(skb, addr);
+	return xsk_skb_destructor_set_addr(skb, addr);
 }
 
 static void xsk_consume_skb(struct sk_buff *skb)
@@ -719,6 +745,12 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 
 static void xsk_drop_untrans_skb(struct sk_buff *skb)
 {
+	if (!IS_ENABLED(CONFIG_64BIT) && !xsk_skb_destructor_is_addr(skb)) {
+		struct xsk_addrs *xsk_addr;
+
+		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
+	}
 	skb->destructor = sock_wfree;
 	kfree_skb(skb);
 }
@@ -746,7 +778,12 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 		skb_reserve(skb, hr);
 
-		xsk_skb_init_misc(skb, xs, desc->addr);
+		err = xsk_skb_init_misc(skb, xs, desc->addr);
+		if (unlikely(err)) {
+			xsk_drop_untrans_skb(skb);
+			return ERR_PTR(err);
+		}
+
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err)) {
@@ -845,7 +882,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
+			err = xsk_skb_init_misc(skb, xs, desc->addr);
+			if (unlikely(err))
+				goto free_err;
+
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
-- 
2.41.3

