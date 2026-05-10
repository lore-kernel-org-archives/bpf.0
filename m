Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122854768
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376217; cv=none; b=JbURIcZhGZHgJyk4DN/qQiKhbKBlu5Yz5v805fMuw97YifVIwSadeJh9bTkQ/UrudiHy6kOaA1lYly7AkK4SfR+7b2YKyBJYClxIAn/hYnDw42uQiDSFmWxGNoAx1zAUpWQIQ5N6C7JCOdRmQbVJnI0a4bHhVj2NjQ2OHydvoX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376217; c=relaxed/simple;
	bh=Mmnxkt/huX78uh7tKYY1i/H91VG/dAugVGiAKIyeHPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9OvBWEixnzcRMrHhPc34ykmAwnomLWlWtYN00Cw2Q5tMgliRoVsDmtcVWlXMphkkpXG0tYRMMOQl/eA0SujLEUKfyKWINzOnEY20B2EVZmHuvK5d4b8BJnnqrALmCF4Ltht7QD3HBerh5qBzhiiVgm2QrZUywATrPu6paC1MEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3PeSoSN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3PeSoSN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bab2548e8bso14709605ad.0
        for <bpf@vger.kernel.org>; Sat, 09 May 2026 18:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376216; x=1778981016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfLHYpz6a8kmz0gxJdexnUrNhs8k934R3FDQzWuV/SM=;
        b=E3PeSoSNSU939Tlcbx2mHWBuGXFZA0hFGqcV0s3NRJIibZ01mt1Ae4laohd9ixuI/D
         0SGArv59jfoIH7cktanVsyV5q/P1oqxSyfaifxQ8pt+tPcmjdLrjTRdf1VLLYDCQx+6t
         eqFWAkP5sZ/DAp1Mx3HFUY4G80XME6mTaD+azMVD19u6k+hYF8I5JHxyPH0VtZbTkyI5
         dwa0mkaQ+un0W65o9vjJy+tNbN8BNYKeGiF0OrfRfDOZbNvJEXX+TiiRqTXQA8x2wzqC
         Dmpzdk+vAOfAfq61n+9UBLqY29Hmhlk0eGAbjbSAs34BAWbuBZwLi9dI/+dFBe5QDS4j
         KR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376216; x=1778981016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfLHYpz6a8kmz0gxJdexnUrNhs8k934R3FDQzWuV/SM=;
        b=gKAAANjZm2Q8gILRQMVLcO6F3hF2Yx/Xs821wLuTs3EsIKDOU+V957NTV3yjSol9K1
         ZSdl3D39PPb8VJRyB+YiP8bc/5nB/TKvVhIzlo8tBX1Q4n8z50yYo3fBF7S/eKmYy0Pq
         5kaQICj6cMkzXRX9NcKmEIkDiEejoCPqhTGmLUuu7USRUDHkJiS1aPNCqbcng2eE5fTU
         V/LBXt2YhAZXNyIf64ASEDXl82gXIspl9/E5IH6LOUoi7+y6G53pSPuqA1Z4s6szkQc7
         uF/sTZBD68NGo4XM79gp+U8PZ4mX27AkM+1ZXmGx340rXvJUeIDP5XSYDGxHH1aJihR3
         M9iQ==
X-Gm-Message-State: AOJu0YzDhl+bg+EG9x/BMcN/fgUI+Rw/5AagAoF0IAREQtxVI74IPnt8
	IAPzqY8K6+aeyS7sBZ3OGVojDoIAhS5LNkwmw84KJCftkp5uHsIRUzTm
X-Gm-Gg: Acq92OE8qsKgRdh8uQu8IQ0nwQlRWdrpadupNhyRb3ju+wozXOyezpPszNDQN1ap2k1
	5ijdkevpV41uAEc8XIwTAJSEifgmTWcyjRj8sXm63QiyTkX9OiWLlNdTJVFzAnxZBPnICZsJlXa
	7ZmA7uryGt/Jsaf6URH72Z5+pSVBKQDxCLgOb2WcmrBE7BWxvCdAI9APVDyj0nF0siNzF8WX4mx
	mFLNzagk+wrKhpt6nR5+s3fTc/yGr2srH9oHdbNPKH1R6m6AV1pVLbAdSowm7Vu9P8F6ifjafpu
	vLdfsDYco7E5cveOp43A0YbQIh74cJd+FWUN4m5ZuLhT5rP2DnS+WZsEG+OxtcOgJgt4z47aJpS
	rS8QDebvuxpTCWriOFB3ib6lx4YJAhJlrJp/o7GtF1q5ztg7td/HQY+/JgxPpYYokc2T8NpXYW9
	Qh9MwFZ7wwX+aqeIXmnsJujxXtjfXUtF4MuvzJsNKyfywX7AejPwK9Q/bRS9FnYMi3x5kX0fFJ0
	N4sdZX8jKQq+cLjHOsy2O41FySfWpM=
X-Received: by 2002:a17:903:38cd:b0:2bc:679c:316f with SMTP id d9443c01a7336-2bc679c34afmr69876195ad.35.1778376215701;
        Sat, 09 May 2026 18:23:35 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:1949:c5e0:289c:ab19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm64648875ad.15.2026.05.09.18.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 18:23:35 -0700 (PDT)
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
Subject: [PATCH net 2/4] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
Date: Sun, 10 May 2026 09:23:08 +0800
Message-Id: <20260510012310.88570-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260510012310.88570-1-kerneljasonxing@gmail.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
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
index cd039e397018..3f1e590c855d 100644
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

