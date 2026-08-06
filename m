Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64F3FB7C1
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049287; cv=none; b=rlyElE3B10YU7gmGhcVppkryJrk489ofZw7kbyMPvrPsqBqefkwGCiiO4r5hG+88BcnDWcJcUyiguf0OAaTyxwwvSCpbv2Dt61XcNmUXoEcrtZRk5am+vOIVQuWJSuPzD1UhswTBAh58KUqhVfH7D5KRPI793bGcsbhIuAuhSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049287; c=relaxed/simple;
	bh=Cio6GetQFOW2UKj3k0s78738zSt7LrvcNA7FummsTPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHEPUwW53zwqxX6xWBbZQCX61GBOzLEQ1tY7DPUfMpIOpli/dCR6DY51vR+eB2WiWDUNw9Z/lVyCalirrCeBC1jEUEIh9m9GO8qRuI1PLUy1bT2DqvHTAPsFWva1LAnaSh6SKvaSZfD3wWOfKMbQovB7FVKE49Fb51sLYD9Zxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfPACwyJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfPACwyJ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3310058b3a.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786049282; x=1786654082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rGTqHHC4NVA2KN0cBT420M4IXX0B7VIhrwI+H5nqUsI=;
        b=gfPACwyJqZWR4HCmQwIF1+/NZFjO4XdDZbXO/hGkP3u0rQ3Xze38uvaXUr/qj6xDON
         yosehAZGpt61hNLP9fccxSu1nPSZ87m7NQO0iUC0qKt2RY3+BbCRh6+v3T78OdHIExbB
         r2urTcCjaS6h4icP2XfoJw8XZ3x9TU/E2n2InTIH4Lgg/qdFEx3/IDUQn04ABPAvlcLf
         VraY+ZYWDbUqHXerWT/TZWoPjXJermX3VzAwTw8qVZq3x4agnpXi5S21NxDLd76wK1lf
         BJ77axXEHuSSnZOFVXMopFBmc4CFpdU620ombcOQ73T6HnzJndPuzzpjEHKGj4bZ7Xmd
         RAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786049282; x=1786654082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGTqHHC4NVA2KN0cBT420M4IXX0B7VIhrwI+H5nqUsI=;
        b=n+TBQLIx2UzA5kHaZtVVOq5UD8+BWEsxq5RK0QyQK5wMXnkrEARucoRbtssiEj++LW
         RehUj6opdmU69NEuhqkULqCrqOv3hp25QOGF7eT5AnMa0Ag8VBcrR1bxVoZIik8OgrCb
         0d3h53mj/xc0jNBNQ8XeSdBofljt5yln/8gRWRCjxwNgl2aM5qux6baxCXUQ8l65k1of
         6qIHxL/1jlxF0jXan3a0Cz0pTfrpH+MaBg3GsSzMwg6Y833o1d6mqNdmAYYmVi1cuFC6
         eH1CZWo5l5e45PiIeJl0hLHW2/o0Pft5E9FN25nK5lvBoWQVztINDRCVAOe+Ir3fnNuJ
         +ldQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXWjWxLLkf11EcJpACjkbmAunvyMl4/XJA74Bqeo1cPdl8ljwrWvaO3votDTbM6k5bsHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nf0egvSK4rLTrIS3ANF+aMQPXFUvKOZatGNHNBh76MlcrQTo
	ZHTt5WAdJnbD6ASuR66X+R8rbWnD4qyPkTFKRCkH8jAOHZnCm4vkIOyjwwEwpNlW
X-Gm-Gg: AR+sD121GnXOikzBEHR9SHFZacrKBJFJTI0FfMoKm+WvTGinG7nyOec8zxp+LLPj9fF
	ToSKSSpYNH+e3t7ssIVnzD8acx4i9BEAdkVjyp0xOaQt3GM43bHmStU/2KC6js8NtEr6fQSjAsQ
	jQncAUW6bSVLYSOZ8Uu64X7YlC6nJ1pxF1O5v/frnrJIW1bOTeaG4m3FpCl2czN1t3SxzsRe9dv
	/ozeIObmffKf5Z4SHWTaGQt6iR9INg4Son9g2QLmZ87yHSTPslTsQfGnkdrN8b7uk1TcHk2P/1o
	kLmlqglNsAGSYGYODkoGA1KidZ8R0FCu+/bZmCpg7KIWr0JF7Qp3y7t53INF79G1w64D6owkeJl
	EOFr8O7fgRwmfYLuYu7Slg1BA92wdYPD3rN1enhPSp1Ig+mW/VZNLHjpul5qENMrI+o+0OIRgmf
	M7Sed38EmYhXpYPRkLgO+qh6MpvirPwSYLLqFxYkYFj5cXsGMaQ9zl+v/H76rLFOK+EW4fuKbD0
	kP4Ts8=
X-Received: by 2002:a05:6a00:4b05:b0:848:56ff:6ced with SMTP id d2e1a72fcca58-84f2e0148a8mr18752552b3a.8.1786049281819;
        Thu, 06 Aug 2026 13:48:01 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.149.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc9cffsm2073686b3a.59.2026.08.06.13.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 13:48:01 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: magnus.karlsson@intel.com,
	kerneljasonxing@gmail.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v3] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Thu,  6 Aug 2026 16:47:57 -0400
Message-ID: <20260806204757.47817-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
loop without checking its return value. xsk_buff_can_alloc() only
counts fill queue entries without validating their addresses, so it
can succeed while xsk_buff_alloc() rejects all remaining entries and
returns NULL.

  Oops: general protection fault, probably for non-canonical address
   0xdffffc0000000000
  KASAN: null-ptr-deref in range
   [0x0000000000000000-0x0000000000000007]
  RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
  Call Trace:
   xsk_generic_rcv+0x26d/0x5f0
   xdp_do_generic_redirect+0x3c5/0xcf0
   do_xdp_generic+0x92f/0xe70
   __netif_receive_skb_core.constprop.0+0xf7e/0x2b30

Fix this with a two-stage transaction. First allocate and stage all
buffers required for the packet using the pool's xskb_list, recycling
them with xsk_buff_free() if any allocation fails. Only after the
allocation stage succeeds, copy the data, reserve the RX descriptors,
and release the buffers in an error-free loop using
xsk_buff_get_frag().

Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v3:
 - Use pool's xskb_list and xsk_buff_get_frag() instead of a local
   staging list, per Maciej and Jason's review.
 - Set frags flag on head so xsk_buff_free() recycles the entire
   staged group in one call.
 - Guard against duplicate aligned Fill Ring addresses.
v2:
 - Allocate all packet buffers before reserving RX descriptors.
 - Recycle partially allocated buffers instead of only cancelling the
  RX producer reservations.
Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gmail.com

 net/xdp/xsk.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7855ee09c4b6..02ff3ad97410 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -297,10 +297,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	u32 frame_size = __xsk_pool_get_rx_frame_size(xs->pool);
 	void *copy_from = xsk_copy_xdp_start(xdp), *copy_to;
+	struct xdp_buff *first, *next, *xsk_xdp;
 	u32 from_len, meta_len, rem, num_desc;
 	struct xdp_buff_xsk *xskb;
-	struct xdp_buff *xsk_xdp;
 	skb_frag_t *frag;
+	u32 i;
 
 	from_len = xdp->data_end - copy_from;
 	meta_len = xdp->data - copy_from;
@@ -343,11 +344,34 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		frag =  &sinfo->frags[0];
 	}
 
+	if (WARN_ON_ONCE(!list_empty(&xs->pool->xskb_list)))
+		goto err_alloc;
+
+	first = xsk_buff_alloc(xs->pool);
+	if (!first)
+		goto err_alloc;
+
+	xdp_buff_set_frags_flag(first);
+	for (i = 1; i < num_desc; i++) {
+		xsk_xdp = xsk_buff_alloc(xs->pool);
+		if (!xsk_xdp)
+			goto err_free;
+
+		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
+		if (unlikely(xsk_xdp == first ||
+			     !list_empty(&xskb->list_node)))
+			goto err_free;
+
+		list_add_tail(&xskb->list_node, &xs->pool->xskb_list);
+	}
+
+	xdp_buff_clear_frags_flag(first);
+	xsk_xdp = first;
 	do {
 		u32 to_len = frame_size + meta_len;
 		u32 copied;
 
-		xsk_xdp = xsk_buff_alloc(xs->pool);
+		next = xsk_buff_get_frag(xsk_xdp);
 		copy_to = xsk_xdp->data - meta_len;
 
 		copied = xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag, rem);
@@ -356,10 +380,21 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
 		__xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
 				  rem ? XDP_PKT_CONTD : 0);
+		xsk_xdp = next;
 		meta_len = 0;
 	} while (rem);
 
 	return 0;
+
+err_free:
+	/* Re-set frags flag; xsk_buff_alloc() may have cleared first->flags
+	 * if the same Fill Ring address aliased back to first.
+	 */
+	xdp_buff_set_frags_flag(first);
+	xsk_buff_free(first);
+err_alloc:
+	xs->rx_dropped++;
+	return -ENOMEM;
 }
 
 static bool xsk_tx_writeable(struct xdp_sock *xs)
-- 
2.53.0

