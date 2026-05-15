Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484B42EEBD
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848248; cv=none; b=ZRMSBON4KNqG5HMoZdud70PQH41FvnMMIj355BjLAucr3F3a4jSWE7n3+lm+9/R8flcxTJbIkelc8m3CbBJuHFYVLBI0DRVB1KYj66JtzshCAWe5jCLr0nef6T2ooO5gWkS5OgxIBpZMbbWPqP9DlkGYW9njNA2AzYKx+lIC16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848248; c=relaxed/simple;
	bh=gPwswP3Fwr1pduNJIQcF701wAt3wtKnNxspydOPPvnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCdIROTvbJqHkVjKsmcJYRJmOUu5OcMfVfw88x+I2CoIbE+fwsZWNP8uUHXs6xMofawc0YElExrh8Wir3+Ya9ePIEPJVoi9noD2HuKpSygnCIhDuhRkxzmvSVWH28xnX7RmLLSMqSQr0yoJ9GCxjCX+m66lTYL1N1uxf5sr6E08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCwu2xX7; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCwu2xX7"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so4373683a12.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848246; x=1779453046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PrqFN1jchhR8NS/FIzneNTklXtpvp9FHj7tcy4Q19w=;
        b=oCwu2xX74J3Ym4RI88x4qWYFLJ/e7h3jFxBm6saCVpMNGbvVGDZjXWwoGRWPBfziJ5
         YAdSS9nuqLa3aZ2zwd5Xzn6RIGnrMdZt8wTU/z4O3AcwD6Zi+wnIYcvi69QxkQQNndCl
         VxhYY2M0z5ptg2WpYQdO7JhX13cCkmB9kimDqwfYbUTmTAXzZMjrjIWYj12LHHIXR+CR
         9Ydkhd2H2SZLzTEhjSDlBPE4F34dIA6/UEaK3GXBWLBjlbk/sSfzlB/wKM4Udt061I++
         RCk8MUMSH1qEPOhtwtRMRS6A8BElx0GIIwzXmx7bOkfQBXJQcIqWXpqdFuUbrIYxfldp
         bUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848246; x=1779453046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0PrqFN1jchhR8NS/FIzneNTklXtpvp9FHj7tcy4Q19w=;
        b=EGI7wbOdV1lMh+bf48jApt9G2hzZxOoryCn1/nsWKS8WML2A4CFmuoSOgt8QIiTK1x
         P6SLE1OI+TkDK4El8SMKr+6yKEA0Wx38shCR1HSa5yurdV0UbkebgC26RCYEzEMRyPkB
         0xtMxKgswnUvy7ETPX6hj2hG3idvENi253p5fEL7VkMbvCbipFmwtBknnGhS8ttLit68
         XGmjbxzIVlD7PLcNKxzfCNBESnu7t0fNilKg6u0R6s1pezfqPlPpyaVV56n48vtEOJsM
         l17ok936Nqs8FZ6MpmaCUMbGQzoni2bYOW5EnIHbzGx/HudFEfT3KgVA+rg+uuJTSAhy
         WzXQ==
X-Gm-Message-State: AOJu0YwMrgMd4c71sXoC7qfYyNOTHf0LZulFEOgqSW272L40wX6F3Q0/
	/VuHwUk9UULsaX9WCeWioaJemow+Vd7iMjkmFPEVONTIZrGUK/l1HNaP
X-Gm-Gg: Acq92OFXRpim0SJ8kv8B4TYw9GWI8bFSc/T0zR30v0LYbhmmlEPjowdCrd00f+Q5vKf
	MrOHyHsI2HlOvKcHwTTOq0lX+4f2rPFEAVzLiBR4UytQfayQYpSMVoU8mjIOOdByjCo+j3He+eR
	xYg30JlLSPKmRxAq4c2WK3CP8Dfid26aUABKcRc0h0Rhf8+GkBJjdZuTNYPjWiVbZ44016rq4mq
	KzblkWxSANyGeW48yHtxenoy+mMYMJObVR5g6uomDR7cj77aLb8H3Eq+3iqzSpl9/mph9yfsKwI
	jxluu4j0qpbEeae2UNpxhzpO/Id8zEYIpnjNT0Q7pKzYh6qfqQ/fc8UlsDNQhkTVYAAxSuyBVjz
	tHMHsJCNtZu9JCcTC1rM0b7C8FgFXePHU6RTZj4P3g2skdeggOMxmoZjt3VSp0rOrg0tPtsQroe
	zx7Txvj+5GukHILKztRrBZDY9p4ZopeyJrm1GwT+BJWQnFuASks5o6AvK5hwxHbd3WwrqqnL1yW
	ID2QrcXbbATGKNs542uZFpN6sC/9zg=
X-Received: by 2002:a17:903:2f4c:b0:2bd:3c1a:473e with SMTP id d9443c01a7336-2bd7e8a3c71mr50131175ad.14.1778848245999;
        Fri, 15 May 2026 05:30:45 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:30:45 -0700 (PDT)
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
Subject: [PATCH net v2 2/5] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
Date: Fri, 15 May 2026 20:30:15 +0800
Message-Id: <20260515123018.80147-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260515123018.80147-1-kerneljasonxing@gmail.com>
References: <20260515123018.80147-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch is inspired by the check[1] from sashiko. It says when
overflow happens, the address of cq to be published is invalid.
Actually the severer thing is the whole process of publishing the
address of cq in this particular case is not right: it should truely
publish the address and advance the cached_prod in cq as long as it
reads descriptors from txq.

The following is the full analysis.
xsk_drop_skb() is called in three places, which all discard a partially
built multi-buffer skb:
1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
   the TX ring prevents the partial packet from completing
3) xsk_release(): socket close while xs->skb holds an incomplete packet

In all three cases, the TX descriptors for the already-processed frags
have been consumed from the TX ring (xskq_cons_release), and CQ slots
have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
the buffer addresses never appear in the completion queue, userspace
permanently loses track of these buffers.

Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
destructor, which already submits buffer addresses to the CQ via
xsk_cq_submit_addr_locked().

Note that cancelling the descriptors back to the TX ring (via
xskq_cons_cancel_n) is not a appropriate option because an oversized
packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
which is an obviously deadlock bug in the TX path.

Also move the desc->addr assignment in xsk_build_skb() above the
overflow check so that the current descriptor's address is recorded
before a potential -EOVERFLOW jump to free_err, consistent with the
zerocopy path in xsk_build_skb_zerocopy().

[1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index adcec1d22e8b..1cc14cb415f3 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -713,8 +713,11 @@ static void xsk_consume_skb(struct sk_buff *skb)
 
 static void xsk_drop_skb(struct sk_buff *skb)
 {
-	xdp_sk(skb->sk)->tx->invalid_descs += xsk_get_num_desc(skb);
-	xsk_consume_skb(skb);
+	struct xdp_sock *xs = xdp_sk(skb->sk);
+
+	xs->tx->invalid_descs += xsk_get_num_desc(skb);
+	consume_skb(skb);
+	xs->skb = NULL;
 }
 
 static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
@@ -796,7 +799,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(-ENOMEM);
 
 		/* in case of -EOVERFLOW that could happen below,
-		 * xsk_consume_skb() will release this node as whole skb
+		 * xsk_drop_skb() will release this node as whole skb
 		 * would be dropped, which implies freeing all list elements
 		 */
 		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
@@ -888,6 +891,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
+			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
+
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
 				err = -EOVERFLOW;
 				goto free_err;
@@ -905,8 +910,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
-
-			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 		}
 	}
 
-- 
2.41.3

