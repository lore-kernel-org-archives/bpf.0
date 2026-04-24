Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080018DB35
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009146; cv=none; b=Dh/31MPuMwp7dVIVDq6kuF3l670CY+R9Wyfqf0QZkmAoz/rlPNw7rYTBVGKzGEcKXB8CQ/26x3udH+tzkaML7EomGXe5fkSSJ7pW1Ba8CdHh2ZjFg9Yz/JSzOBv1u2NRJPgKbNJV/6V26urDs7DDV8GzhSIbiJqA32biyEkVDsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009146; c=relaxed/simple;
	bh=lQ+U1tcVbyeZug+eKSTDL0bawb7D1nNd0QN1i0sAakY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XssGZXAn0Uotidp/3NxLn1XkaBa0PO7XHdTvYfzTbXFkXdwpjpCg0q971adpLEd6rPjN4fGgjIWJ3m2NreS308L5fzTmvrehJkwW3ho26M+JnKBN+hzlkhWcYWBEQn9PwHe2aQpdlfvoTUCc0Urgawik1ozvSHnDviLQTreTNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjkMf7c6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjkMf7c6"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so4853831a91.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009144; x=1777613944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qr4OV8WE431vBkkMubZJHNjOwEiMdfOPU9mrOywPhc=;
        b=fjkMf7c6gdXsvn04WFGKMkIYnZ00K7eI7ak3jQb42afGkQOnzHBGl92ZEE1daN8Tzs
         JjRMZWFPpLxyaoHVtROp96OUMInMRU8FVShcSyMxgIiCpHzKUP+6WXyyzISVhTwZjyLg
         5OlBw0iJp6WwtwuFLh/b1JpB2SBexihyNJvHySEmcsRtlUdIybft6CIGKt7RsnDyCagW
         CrWbCWqXDQNqXw0KWPqF1epMhEdsrjwTvd5iaLJ29+NlErLkPh8bSgvqgtaN5l2acRNd
         sHDJc+si9zPp0kuUcT6eFWgZzNdBbHrlZTj/+ENtMeeRKK3s0YGHyzylPqOLSSobw4er
         G1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009144; x=1777613944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qr4OV8WE431vBkkMubZJHNjOwEiMdfOPU9mrOywPhc=;
        b=CelJW4kvX3e4JGduB0RxjEoKg8b4MlQ7X5RofolaeCYLI0ZcrhMW+NAGGzD+bLfjqn
         fnaA03LlmDjdNa9k2KneKOWqS5alo9Vbq5lLRLHAUAJKqDiCSM4TGA0flyx9BeHeMIBx
         lz2iCjYd1QDQsJhN87v4KxhY05Y95DzUDPxF9zOziF28qmowGF9Qvnc3lF5bzIcUCDom
         QF+JyKuc57niSZWqN1aj4oTfaJ3wBZokKe8gBTUQ3iQW3PjAuQlkEmxkSUHQKYPa9Ygp
         wQidtawA7DtXH1NqFdct5kkmyMJzcPhS5t0PLLVIGDW+geas14VyPBGR2WznTtqFwB7U
         0iSA==
X-Gm-Message-State: AOJu0YxcaQayYi6r2r9tlmOqEKy9HFdGhADQtib1qTL3UOLgpcl88gwe
	dxTFbkzUNa04pWWST4khaEIo+MZRpD0bOQDyqmvwbs13qnCOL/6VtdNN
X-Gm-Gg: AeBDietmlzBzRpqNCRo8uDHzT8wkR66iThFgxy1mRauZ/kmJsI3aaTe0yJFg+JothcB
	mu9wmqR87lBJjiRwT/NJt4BO3cfsDH2WlXoJz8LS96twe6hCA3dbqphjjypsFuvVEKQN7UXc0su
	QK2+puKxKuXj1M2Id2y+ez6YiRkHfRS6XyHAo1PUw3am+ni7gezWszVFjiMPdkUjJU0Umrb3vpA
	nuLl8eGWKISQndQi1UeOfbj/DRCiCl4Pq7Sgm2JYDkr1W+yRTJ5I6eB1j6S0mo43QrOmZLoyzCq
	dJxCwd3aDp65bL2Ts5CYzBFxLFOLByBwJAgKB0KlrgeN9R3xYNb/ym9fDnwj7ynHLDB4bv5/Q09
	Ih3SqgKjBaHXiZ4Rw+qA+Cft7jUWCnZAABD0mHCbmmJsG3OoIkPr3MTZjqGa0pqCtkPawrjQHxD
	gMmSUl+dcSxhyrJ0b2mIzLUlYlK2Adc0s7h1msqGZXDBM/A2UBfXI0GMhA7uYb1hJpUal/DI53L
	dQ2gXaq1q78Oh1XMiWvOHShOhZLpUEExqBdLSsU
X-Received: by 2002:a17:903:1450:b0:2b7:a350:463f with SMTP id d9443c01a7336-2b7a3505063mr59745865ad.10.1777009144366;
        Thu, 23 Apr 2026 22:39:04 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:39:03 -0700 (PDT)
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
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 8/8] xsk: fix u64 descriptor address truncation on 32-bit architectures
Date: Fri, 24 Apr 2026 13:38:16 +0800
Message-Id: <20260424053816.27965-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
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
the descriptor address are silently dropped. In unaligned mode the chunk
offset is encoded in bits 48-63 of the descriptor address
(XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is lost
entirely. The completion queue then returns a truncated address to
userspace, making buffer recycling impossible.

Fix this by handling the 32-bit case in the destructor_arg helpers:

- xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
  xsk_addrs struct via kmem_cache_zalloc() to store the full u64
  address. Leave num_descs as 0 (zalloc) so that the subsequent
  xsk_inc_num_desc() brings it to the correct count of 1.

- xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
  when destructor_arg is NULL (not yet set), false when it points to
  an xsk_addrs struct.

- xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
  before touching any other skb fields; on failure return early so
  the skb destructor is never changed from sock_wfree.

The existing xsk_consume_skb() already handles 32-bit correctly after
these changes: xsk_skb_destructor_is_addr() returns false for any
allocated xsk_addrs, so the kmem_cache_free path is always taken.

The overhead is one extra kmem_cache_zalloc per first descriptor on
32-bit only; 64-bit builds are completely unchanged.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ed96f6ec8ff2..fe88f47741b5 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -558,7 +558,10 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 
 static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
 {
-	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+	if (IS_ENABLED(CONFIG_64BIT))
+		return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
+	else
+		return !skb_shinfo(skb)->destructor_arg;
 }
 
 static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
@@ -566,9 +569,21 @@ static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
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
@@ -644,14 +659,20 @@ void xsk_destruct_skb(struct sk_buff *skb)
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
+	if (err)
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

