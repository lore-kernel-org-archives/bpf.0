Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9EB3CEBBF
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241711; cv=none; b=IEnPWj/ljeZxZhpJO0yi2+Tu6T5hZVsxhXbSHslyeH/V+xXnUiiKKNLr8SMyMulkDY4i36dcNd75SoSuIqfr0mRSo6jkFVzIsIHeid97fFGzVnKiYEFSTpI6uyVoCSj483WetTIgWetenxnc/jBP5BczPlQmL6jfzg6MuOlxiwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241711; c=relaxed/simple;
	bh=yKjoEqppyYmzufeDQqQZadeRBf6bIz2HEfWY/80KadI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Davxy86daOCcGdTmH3avB2MnzopZ4ntYdvFiuhHkrGRmoMKMZrBdvN04KE8jKgapi8ltSljfk1eCGLn/6G0qSwKh4bG+dwQMqcabl0zuq0XBlVAftKNayI4+IyjSOptUeIruAGkc2HGIVccGp3lb4k1TrD1MyupBbfVGIXvJ/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVflmWFG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVflmWFG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ab077e3f32so31012185ad.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241710; x=1776846510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBZ1nBfxkE7gobaFwOrpm+pnMw7cmpsG7NHvGmvrpYw=;
        b=aVflmWFGmaH/byY4swGrNnz7/9fSTyjV6Ca3VoZ0NDVPPbqcKSbe2/wl/FqQLM6qt3
         +Rp3QuJeDncMGV6fRK7YGPJb9TIbuXV4TRietsLgaABzzvhC2dsQbsZjRRxsPW3OrXd2
         1o8k4PVr0hkSyD1wwMCIrHV8mo6OqyYkI9RGIs+b5edRsowr3HzaKy8+noaGgibBQ6Df
         alHOpd/EAsOgHrh+UUdZsN1PVVWWqJANQgpWmsXIF+Q9Iof4OPZiIiagN412Lyx1LDKs
         8PORTX1uLJlsLU/a9tZzyM2CTuEF8VPMGRJdPuqJ2r3B6IQFKPQ7KCq8A8OZiJ/DR/37
         wb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241710; x=1776846510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TBZ1nBfxkE7gobaFwOrpm+pnMw7cmpsG7NHvGmvrpYw=;
        b=Y3nBrJ7dCYN4NElMeG1+tySQ+caT3JQ2cVkU/kICb5FktmgiQesQ0g3knXZ7OIlR7Q
         gvyHz5qZfpAX8pRGl6ZtTv7R7mpOfpcqhD72GKU8icCbrcfNYhavDy3P8XDzD0xS6uqE
         uAYyNYUsCkoz9EH2j3kmmRd0jjX6YiPSzVUMdXe7e0Wbihpnd0KoBvzmpxvaMyLMYqIK
         Wd/kqJ/bhYVpEhshNqp6zZGv7QNq8M13CFWc5NsB/tq/AYuPWQkIIizYLQYxYnUZbZWt
         l1+v7/DwCgx7ncZaIF6gYMZrCeHvuF3ymZulgbwc9T7SUJBRdKqnR7DI/wz8dapMbPzK
         et/g==
X-Gm-Message-State: AOJu0YwSAFsIGTIuN1w6nnUtNaxQQ/UzlYeVAfJnbWE9eErgITypZUgk
	kRuoTTaL3C9O5PMULLL3WrSB/Ylp02I/6I5wWNQaOwF+JPmjBdFMh4g2
X-Gm-Gg: AeBDies6R8uTzZE+f79Zi4wmNan0MWmpyfzp3w1Ohbhu/23P13ZITwUhDPRXUkhxY2R
	pQaEFSNZW2knf7zG+Tr+LaNmcz+vBUVzpvrvUumX9Uy1q75rzE5ZH77Q6eORyrK+gDXE8VyX69a
	EvGOe24SEIbxW33YmL+Hx2eojGiIh/AWp152OZRoIBHLU1tZnbweCbO95vJTw7pWh9wAqxT+ZA2
	xfY1BQZlNS7ABpIcJp+b2aPV/jblnGXsjA98SSl/No5kto8fJmQ+2Z693iYF9Fnr2wIrb3oVXwf
	Ji2MKQBSPBb6ACv4IvDP4MjhW5FKniRMDWN6otL0JEXwx1PLcE0QtUy9NqWYiGX0eR+GY6fiqSJ
	OeHbn4T3FrA1RqlYYYvYBwXw7YYqDYK60wUgBulZuHFwijKIhW7+AjWGxvaJbl1Wh7dK8H2aWZ7
	jQ/D3fQNN4qzLOQ2dh9tBUefvbDVAz0e4Ord710o4J5QAh3hj9/BXSCEtKAsPkCSp/xPty8B3rL
	lztczxC
X-Received: by 2002:a17:903:240b:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2b2d5a3be0emr216647015ad.35.1776241709619;
        Wed, 15 Apr 2026 01:28:29 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:28 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 13/14] xsk: retire old xmit path in copy mode
Date: Wed, 15 Apr 2026 16:26:53 +0800
Message-Id: <20260415082654.21026-14-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a new helper xsk_init_batch() used in xsk_create() with the default
value 1.

Obsolete __xsk_generic_xmit.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 151 +++++++++++++-------------------------------------
 1 file changed, 37 insertions(+), 114 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e1ad2ac2b39a..be341290e42c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1036,101 +1036,14 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
 	return err;
 }
 
-static int __xsk_generic_xmit(struct sock *sk)
-{
-	struct xdp_sock *xs = xdp_sk(sk);
-	bool sent_frame = false;
-	struct xdp_desc desc;
-	struct sk_buff *skb;
-	u32 max_batch;
-	int err = 0;
-
-	mutex_lock(&xs->mutex);
-
-	/* Since we dropped the RCU read lock, the socket state might have changed. */
-	if (unlikely(!xsk_is_bound(xs))) {
-		err = -ENXIO;
-		goto out;
-	}
-
-	if (xs->queue_id >= xs->dev->real_num_tx_queues)
-		goto out;
-
-	max_batch = READ_ONCE(xs->max_tx_budget);
-	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
-		if (max_batch-- == 0) {
-			err = -EAGAIN;
-			goto out;
-		}
-
-		/* This is the backpressure mechanism for the Tx path.
-		 * Reserve space in the completion queue and only proceed
-		 * if there is space in it. This avoids having to implement
-		 * any buffering in the Tx path.
-		 */
-		if (!xsk_cq_reserve_locked(xs->pool, 1)) {
-			err = -EAGAIN;
-			goto out;
-		}
-
-		skb = xsk_build_skb(xs, NULL, &desc);
-		if (IS_ERR(skb)) {
-			err = PTR_ERR(skb);
-			if (err != -EOVERFLOW)
-				goto out;
-			err = 0;
-			continue;
-		}
-
-		xskq_cons_release(xs->tx);
-
-		if (xp_mb_desc(&desc)) {
-			xs->skb = skb;
-			continue;
-		}
-
-		err = __dev_direct_xmit(skb, xs->queue_id);
-		if  (err == NETDEV_TX_BUSY) {
-			/* Tell user-space to retry the send */
-			xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
-			xsk_consume_skb(skb);
-			err = -EAGAIN;
-			goto out;
-		}
-
-		/* Ignore NET_XMIT_CN as packet might have been sent */
-		if (err == NET_XMIT_DROP) {
-			/* SKB completed but not sent */
-			err = -EBUSY;
-			xs->skb = NULL;
-			goto out;
-		}
-
-		sent_frame = true;
-		xs->skb = NULL;
-	}
-
-	if (xskq_has_descs(xs->tx)) {
-		if (xs->skb)
-			xsk_drop_skb(xs->skb);
-		xskq_cons_release(xs->tx);
-	}
-
-out:
-	if (sent_frame)
-		__xsk_tx_release(xs);
-
-	mutex_unlock(&xs->mutex);
-	return err;
-}
-
 static int xsk_generic_xmit(struct sock *sk)
 {
+	struct xdp_sock *xs = xdp_sk(sk);
 	int ret;
 
 	/* Drop the RCU lock since the SKB path might sleep. */
 	rcu_read_unlock();
-	ret = __xsk_generic_xmit(sk);
+	ret = __xsk_generic_xmit_batch(xs);
 	/* Reaquire RCU lock before going into common code. */
 	rcu_read_lock();
 
@@ -1626,6 +1539,34 @@ struct xdp_umem_reg_v1 {
 	__u32 headroom;
 };
 
+static int xsk_init_batch(struct xsk_batch *batch, unsigned int size)
+{
+	struct xdp_desc *descs;
+	struct sk_buff **skbs;
+	void **data;
+
+	skbs = kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);
+	if (!skbs)
+		return -ENOMEM;
+
+	data = kmalloc_array(size, sizeof(void *), GFP_KERNEL);
+	if (!data) {
+		kfree(skbs);
+		return -ENOMEM;
+	}
+
+	descs = kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
+	if (!descs) {
+		kfree(data);
+		kfree(skbs);
+		return -ENOMEM;
+	}
+
+	xsk_batch_reset(batch, skbs, descs, data, size);
+
+	return 0;
+}
+
 static int xsk_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
@@ -1746,9 +1687,6 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 	{
 		struct xsk_buff_pool *pool = xs->pool;
 		struct xsk_batch *batch = &xs->batch;
-		struct xdp_desc *descs;
-		struct sk_buff **skbs;
-		void **data;
 		unsigned int size;
 		int ret = 0;
 
@@ -1762,27 +1700,7 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 			return -EACCES;
 
 		mutex_lock(&xs->mutex);
-		skbs = kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);
-		if (!skbs) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		data = kmalloc_array(size, sizeof(void *), GFP_KERNEL);
-		if (!data) {
-			kfree(skbs);
-			ret = -ENOMEM;
-			goto out;
-		}
-		descs = kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
-		if (!descs) {
-			kfree(data);
-			kfree(skbs);
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		xsk_batch_reset(batch, skbs, descs, data, size);
-out:
+		ret = xsk_init_batch(batch, size);
 		mutex_unlock(&xs->mutex);
 		return ret;
 	}
@@ -2056,6 +1974,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 {
 	struct xdp_sock *xs;
 	struct sock *sk;
+	int ret;
 
 	if (!ns_capable(net->user_ns, CAP_NET_RAW))
 		return -EPERM;
@@ -2071,6 +1990,11 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 	if (!sk)
 		return -ENOBUFS;
 
+	xs = xdp_sk(sk);
+	ret = xsk_init_batch(&xs->batch, 1);
+	if (ret)
+		return ret;
+
 	sock->ops = &xsk_proto_ops;
 
 	sock_init_data(sock, sk);
@@ -2081,7 +2005,6 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
-	xs = xdp_sk(sk);
 	xs->state = XSK_READY;
 	xs->max_tx_budget = TX_BATCH_SIZE;
 	mutex_init(&xs->mutex);
-- 
2.41.3

