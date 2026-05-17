Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0D2853F8
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999617; cv=none; b=WibW/Bsx9Cnq1YDSkdY1exIdxeXp6rbuK6Ikv07TJ20vTuQCWzyBKrXCR2+rtVMoeCElAAUTvZIsvjnQBuuJGB445wH7S7qKYGRrG9oOpSGtbKQYiPVV05Zz5nkHWG03WNeJiVbMP8+54hR1ZjH2dHhw3liP8t/MDEYUF0V83lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999617; c=relaxed/simple;
	bh=a5UshyE/bkF5sH8kPnnlkA8aFTOAxuPpX+MUydmVDnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6jwuRL5Wyk+o+SgzUnWXyXnTFwECZxnogRx3Qm8njTO6WHuG/XXVY6NvLvuZIzfk2SJdUfbmEBbVU5drdg5uU63SSd/DnpKdYKYEOcx9Wz5KB9545lXbBEBQFK1FJwRHXg0EURfDr3H2s4b9g27dh77KO17V8JtW7/1WY7J3VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e20dNEUr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e20dNEUr"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36643b96b99so1141744a91.0
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999614; x=1779604414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZXYU5Yo6j5J7XOLRXMLLYjxyG0GpFZ6EWg+P+KiBs8=;
        b=e20dNEUryG9RVVPi81yJc+SztJsl6UdGI6lRLcX/AHODqwRiwd2xVEoO328qyJgnVD
         SCxMct+56piEx1JQc6Yi+gFBcHJfXv5xdTYG8NzqyOtWeU8u7KUdXqamspJrMf/+SVXz
         om4rPIrMTXSL7cmkc9Yhnk44L1OJqCbiOk+pblx670rlqTlESHXY/7ylVgJ9lu9CE6TG
         SzUTedb7YQhtbPM51FqH5Iif1pk4DO9LA5b8dk60hOittPjScDT2aQf4NAHKM+V2u7uh
         eQjwf24UkL0L0N7WaaPqqR2s43i17yHnkkdVvV06KptWR5TM+ukA8igpxJGaN5YbZBB2
         8YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999614; x=1779604414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZXYU5Yo6j5J7XOLRXMLLYjxyG0GpFZ6EWg+P+KiBs8=;
        b=WLcPoeQXhkSSEyKgwA6gSvaJoW3Coq8b57vZ4lNrmMfAmYWIRMFhvtD0MVqIXqwicZ
         0wV/Pa2T/3rAV186Gnmg1QodW0/0G6oMfFRLXZ6yPFNq6YcBe3naqVqKqQat55G7pJ8C
         qBIf8+zC30Ple2xQV34A7zhoI5Zv2Y+dgfnvJlCMjRATvS8CG4a+21mU1dDhD0xt2awR
         jNLsz66eEztbmmm/Y+QvaV1qRpOEePdxZqR5Ml5N1ESSef68hWvrM9n6pcizPsPo8BoS
         +TdtjN6hgP2zpqv5FQvV9GVFUzP9NUhD01jRcWlmKT1g8RDzBhajk/RzZB5rZHU8qsnQ
         gXsw==
X-Gm-Message-State: AOJu0YyQWg4mj2MHcNufSlBbrmdgGjMLOhcSbRab9dXrcwL6OXNmT5M6
	ozvTr1fVo8HCnND+DCkGnO/3fdmfaivoq1rhrffi01OF6hIHaaQoAK/A
X-Gm-Gg: Acq92OE3BgS5AZrL4fkl2fDfTM+XahVqaIGiovwSeLpE5CgjFLSQkMv30dheOLYcTax
	bkkILR3nl5ZkVBPTC+humA0Clv+MGum8dvhxhkWmw8E4Ljxc1uUDrE9nQr8UkKCkdozMbVCAf3f
	bL93Fv+BeluXpye2xsj+Eht6R/TgHCKQbkWVBqWtc77d7nuM4TqkzrHdwaQBmhoz+OS35C5aSvU
	zwyn9Mx9mEExJmdIvEzlCPJYgN2rjhC2JhkAnNxhSl+m9YscAdIalTZupmo5rKscUYBhZClpIH7
	GFi8txUug88TSrXHR7oYDdAX9Wajs0VbqjP3Hrz8Hxp2U7BokpPnvQ+Tu9rDQAKaK74Fwt1NJgo
	zm8By0tRDHRtUDO0WCkx9m0jdxOGZK3V257dBnBg/das9HjaOASX5QFyd5CvITJxsSMoyO0x6tx
	xCeKuIi5TcbfpaVqti8lXQwujS6VKlxoNIX4JNgruO4kTcpzjSyXBq3tnqr1ao904RWonzcszR9
	o+vzhdqT7DpKhhzqY9E3TnMY+9JoA8=
X-Received: by 2002:a17:902:d311:b0:2b0:a980:3687 with SMTP id d9443c01a7336-2bd7e7e4ddemr76343665ad.3.1778999614333;
        Sat, 16 May 2026 23:33:34 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:33 -0700 (PDT)
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
Subject: [PATCH net v3 2/5] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
Date: Sun, 17 May 2026 14:33:08 +0800
Message-Id: <20260517063311.28921-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260517063311.28921-1-kerneljasonxing@gmail.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
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
index f8c8a8c9dfba..0a6203c42576 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -793,8 +793,11 @@ static void xsk_consume_skb(struct sk_buff *skb)
 
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
@@ -876,7 +879,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(-ENOMEM);
 
 		/* in case of -EOVERFLOW that could happen below,
-		 * xsk_consume_skb() will release this node as whole skb
+		 * xsk_drop_skb() will release this node as whole skb
 		 * would be dropped, which implies freeing all list elements
 		 */
 		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
@@ -968,6 +971,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
+			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
+
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
 				err = -EOVERFLOW;
 				goto free_err;
@@ -985,8 +990,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
-
-			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 		}
 	}
 
-- 
2.43.7

