Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B70453A56
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335796; cv=none; b=sdrbe9fIQJ3vJGfoPaM+6qdB6z9fYGBcZ+7MtnhRT/he/eyUaQcDCHqYArJcZkYZVkJ463YYjlmWYQMFrJzChXbQxlwzGTSmEmYg/JjDXGgHB/H+JGbCuaCHO0UVTQ3zY42UOOeDhxwEW4fE4WNZB1PLIdCSyHnM4tiHIKI3o1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335796; c=relaxed/simple;
	bh=fycSYVa9DMHyEgwRT3MI5Yp7QQJN3GI7CbJQjeefYRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt42+1Yzk1L4COYmoESOyKgca/EEvyeOUOjhJVKhefzPV+n3Y4VXBwQFwOZdlSFTrO/NZWb0jiVvikBKA6a7S8EE52IQHKiU3iCVEFGP7t/XUC0F72tx/fWce7Ml41fvIfLfLxmeZoHkU111/AZKEvHxWrWbSg2Kwy/m4afqjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=cZXmvone; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="cZXmvone"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8484f229529so760642b3a.2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785335795; x=1785940595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRAIQWJBExocz0PLzX+sgUtteu2dNtbB6CEn0ss5Muk=;
        b=cZXmvoneTWvlLF3vOwwWvUlHM8KmGJJIRmkUOxPa1bqll2lTmNHWmwis+I5JaVPGaU
         KEzjb3BcXPEsoCqDiXOcsSd0xelIL2pBuaslU1kvR1pPnyRDAFeUCU7MIBW/jnsjIJQ9
         daGRkHNuNplyyYO0M6NYOF+cv/VSQKxxq0hfEwxbfbVHY9NwnUE4lSkDdNafk/twe9EP
         TxE5VrnD5InB8wn2x3KRlVJLX2f3k1CSm/27KfvejEwA4R8ZoVYYGGL1aSCNlOv8VzR/
         i7TyXJaP2UT0WwaMDM2NRyan3xrKN1wn3ak/6waON9zttcZp4+T3C0TCK2ORTPbdsU39
         QyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785335795; x=1785940595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LRAIQWJBExocz0PLzX+sgUtteu2dNtbB6CEn0ss5Muk=;
        b=FVop5wgq4QvA98GE34gNE7+x2BktDV3fVr5E0QgXSF3IzQ7VyA+VRZzicX/YJ9imS2
         C0yD7nU7KfO1PukxbortBS4PTAOXQ4pKUlX0MywJ4RxTnuzKORl7qGO38J1qAdwhi7VL
         IbOmABEkyxQ2vvqlT6+2ePBfiWi1hffBsG7rG+dHtztTHyDSmIrsO+zSnE8yiL5iOKZA
         xLVqgV4fpY8wMcGSqUlrpRmOKZyLyfZksNFATtNzTbLvIJz+6sLOwc5DA36+FDIBGtl5
         QnRcuyETfXR+s7jfzMiHzIzGeX9moGxWHt1yb8t2QYfd2NDThtbo7KPkHqv1tJ+XDVzh
         2V/A==
X-Forwarded-Encrypted: i=1; AHgh+Rov9HUKEAoAe/GRU8d0AzqzJHXzVRVJW7sCwEpvY5gqtIN/EEt7/RTjnCBq5ZFHAd8hQkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhBBIu+uLsEFch1OlUblVqb02pEkOxdc4DK2G6C2MhoIF0aY4
	yLXXnmWr/nFw8jm6oDTzVeTk4/BPU1CKCcjTjrb3/aIJyxSvkAvaZFs8Wi1eaEqILHC2
X-Gm-Gg: AR+sD138dnLk9FhobzLlIrxUao6h9/VkN+RBT5h+86XleuToB2z3XKET52Dc5N4bhz6
	2O0n1sAZ9sbD5LOZ9Z+C+tM7y1CE3iE5AogoEN7+/QBzyiHG47/bdNYd+uaLSlFxOJ3SXvoTXCx
	+d2ArA6fuhmmmNS/mjTEIT6zBpGG7mVaYlf4zugx0Ug7OIorzTQ3wmFJxoMYJRt09XIXt1AkXzh
	A9/p7uGuAMryaiKG8Z8NOwIk9YMhgNx4MXPx+s14dYJbooZCvNRjW+CqzUt9Cpanpc8rBWb5igT
	YmwQqecTOHSxzAg6/kUix+WXqwg3nanV/EJkQea5SHh944/medjUXC64EeIOsEujGiUraZvv0VN
	JIFdIIp+hID55LZkP+8GsDvzQQMDm0CStltpiupB3Sr8UIU1/Cz2B1iF2r7d31rDnof1t3dfTiU
	wpJaimzBJ0h3NPeaAJ7Hf/CZ1rNLRDMWgC2PYEotPFzCF6AIY8R8A7cK6p1ERl5GF+jMgtRed3e
	vAlmfzFAA==
X-Received: by 2002:a05:6a00:2e24:b0:848:438d:3665 with SMTP id d2e1a72fcca58-84e933e8291mr7432527b3a.41.1785335794544;
        Wed, 29 Jul 2026 07:36:34 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02f8473sm1498306b3a.31.2026.07.29.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:36:34 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 1/1] xsk: charge ring allocations to socket optmem
Date: Wed, 29 Jul 2026 14:35:56 +0000
Message-ID: <8bdeff3a669003d9573ef097069c71c26da46e1d.1785313095.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785313094.git.zihanx@nebusec.ai>
References: <cover.1785313094.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_XDP lets user space create RX, TX, fill and completion rings via
setsockopt().  xskq_create() validates that the requested number of
entries is non-zero and a power of two, but the resulting ring size is
not charged to any socket memory limit before vmalloc_user() is called.

A process with CAP_NET_RAW in a network namespace can therefore request
very large rings and pin a large amount of vmalloc memory through an
AF_XDP socket.  This can exhaust memory before bind or any packet I/O is
required.

Charge the page-aligned ring size to sk_omem_alloc and bound the charge
by the namespace optmem limit.  Use an atomic cmpxchg loop so concurrent
ring allocations cannot race past the limit or overflow the signed
sk_omem_alloc counter.

Keep a socket reference with the queue, because UMEM fill and completion
queues can be moved to the buffer pool and destroyed after socket
release.  Drop the socket reference to the pool and UMEM from
xsk_release() before the final socket put, so pool destruction no longer
depends on the socket destructor and the queue reference does not form a
release cycle.

Fixes: 423f38329d26 ("xsk: add umem fill queue support and mmap")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/xdp/xsk.c       | 26 +++++++++++++++++++-------
 net/xdp/xsk_queue.c | 35 ++++++++++++++++++++++++++++++++++-
 net/xdp/xsk_queue.h |  7 +++++--
 3 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f906d51b6699..7d6df8b6b43d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1446,15 +1446,15 @@ static __poll_t xsk_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
-static int xsk_init_queue(u32 entries, struct xsk_queue **queue,
-			  bool umem_queue)
+static int xsk_init_queue(struct sock *sk, u32 entries,
+			  struct xsk_queue **queue, bool umem_queue)
 {
 	struct xsk_queue *q;
 
 	if (entries == 0 || *queue || !is_power_of_2(entries))
 		return -EINVAL;
 
-	q = xskq_create(entries, umem_queue);
+	q = xskq_create(sk, entries, umem_queue);
 	if (!q)
 		return -ENOMEM;
 
@@ -1498,6 +1498,18 @@ static struct xsk_map *xsk_get_map_list_entry(struct xdp_sock *xs,
 	return map;
 }
 
+static void xsk_put_pool_and_umem(struct xdp_sock *xs)
+{
+	struct xsk_buff_pool *pool = xs->pool;
+	struct xdp_umem *umem = xs->umem;
+
+	xs->pool = NULL;
+	xs->umem = NULL;
+
+	if (!xp_put_pool(pool))
+		xdp_put_umem(umem, !pool);
+}
+
 static void xsk_delete_from_maps(struct xdp_sock *xs)
 {
 	/* This function removes the current XDP socket from all the
@@ -1553,6 +1565,7 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
+	xsk_put_pool_and_umem(xs);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1810,7 +1823,7 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 			return -EBUSY;
 		}
 		q = (optname == XDP_TX_RING) ? &xs->tx : &xs->rx;
-		err = xsk_init_queue(entries, q, false);
+		err = xsk_init_queue(sock->sk, entries, q, false);
 		if (!err && optname == XDP_TX_RING)
 			/* Tx needs to be explicitly woken up the first time */
 			xs->tx->ring->flags |= XDP_RING_NEED_WAKEUP;
@@ -1879,7 +1892,7 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 
 		q = (optname == XDP_UMEM_FILL_RING) ? &xs->fq_tmp :
 			&xs->cq_tmp;
-		err = xsk_init_queue(entries, q, true);
+		err = xsk_init_queue(sock->sk, entries, q, true);
 		mutex_unlock(&xs->mutex);
 		return err;
 	}
@@ -2156,8 +2169,7 @@ static void xsk_destruct(struct sock *sk)
 	if (!sock_flag(sk, SOCK_DEAD))
 		return;
 
-	if (!xp_put_pool(xs->pool))
-		xdp_put_umem(xs->umem, !xs->pool);
+	xsk_put_pool_and_umem(xs);
 }
 
 static int xsk_create(struct net *net, struct socket *sock, int protocol,
diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
index 4dd01b7d858e..edc2ba97cc0f 100644
--- a/net/xdp/xsk_queue.c
+++ b/net/xdp/xsk_queue.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/overflow.h>
 #include <linux/vmalloc.h>
+#include <net/sock.h>
 #include <net/xdp_sock_drv.h>
 
 #include "xsk_queue.h"
@@ -21,7 +22,25 @@ static size_t xskq_get_ring_size(struct xsk_queue *q, bool umem_queue)
 	return struct_size(rxtx_ring, desc, q->nentries);
 }
 
-struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
+static bool xskq_charge(struct sock *sk, size_t size)
+{
+	int optmem_max = READ_ONCE(sock_net(sk)->core.sysctl_optmem_max);
+	int old, new;
+
+	if (optmem_max <= 0 || size > optmem_max)
+		return false;
+
+	do {
+		old = atomic_read(&sk->sk_omem_alloc);
+		if (old < 0 || old > optmem_max - (int)size)
+			return false;
+		new = old + (int)size;
+	} while (atomic_cmpxchg(&sk->sk_omem_alloc, old, new) != old);
+
+	return true;
+}
+
+struct xsk_queue *xskq_create(struct sock *sk, u32 nentries, bool umem_queue)
 {
 	struct xsk_queue *q;
 	size_t size;
@@ -45,9 +64,18 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 	}
 
 	size = PAGE_ALIGN(size);
+	if (!xskq_charge(sk, size)) {
+		kfree(q);
+		return NULL;
+	}
+
+	sock_hold(sk);
+	q->sk = sk;
 
 	q->ring = vmalloc_user(size);
 	if (!q->ring) {
+		atomic_sub((int)size, &sk->sk_omem_alloc);
+		sock_put(sk);
 		kfree(q);
 		return NULL;
 	}
@@ -61,6 +89,11 @@ void xskq_destroy(struct xsk_queue *q)
 	if (!q)
 		return;
 
+	if (q->sk) {
+		atomic_sub((int)q->ring_vmalloc_size, &q->sk->sk_omem_alloc);
+		sock_put(q->sk);
+	}
+
 	vfree(q->ring);
 	kfree(q);
 }
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1bc42c8902f4..61744e4c1ca2 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -37,6 +37,8 @@ struct xdp_umem_ring {
 	u64 desc[] ____cacheline_aligned_in_smp;
 };
 
+struct sock;
+
 struct xsk_queue {
 	u32 ring_mask;
 	u32 nentries;
@@ -46,6 +48,7 @@ struct xsk_queue {
 	u64 invalid_descs;
 	u64 queue_empty_descs;
 	size_t ring_vmalloc_size;
+	struct sock *sk;
 	/* Mutual exclusion of the completion ring in the SKB mode.
 	 * Protect: when sockets share a single cq when the same netdev
 	 * and queue id is shared.
@@ -531,7 +534,7 @@ static inline u64 xskq_nb_queue_empty_descs(struct xsk_queue *q)
 	return q ? q->queue_empty_descs : 0;
 }
 
-struct xsk_queue *xskq_create(u32 nentries, bool umem_queue);
-void xskq_destroy(struct xsk_queue *q_ops);
+struct xsk_queue *xskq_create(struct sock *sk, u32 nentries, bool umem_queue);
+void xskq_destroy(struct xsk_queue *q);
 
 #endif /* _LINUX_XSK_QUEUE_H */
-- 
2.43.0

