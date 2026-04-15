Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9F3A5435
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241698; cv=none; b=Od6RAtJbNvH8ejbgI34G66SJjV7YYT+iXc66ZGNrAbsGAbQsvp1pHjTqHpNrYccED2NNf4SEggoRQiDx/CB5S0BIeKNf35ne+iRRytpyw+2g44hv3UXhObHLF33ijhyI9XMkFMysIUbRzI4aYfFzdBMLQlod0feBe7FQ0iX4Vgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241698; c=relaxed/simple;
	bh=VFxn96JHNW5QH+1nLwEYppxJ0YIlpZL6X5l+KJFGafY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSxO1sa7IzGcdc1dUsadGSh/CROy28DcH1PMyJrl5gXuHbJshoADcAAJFvo857sefZhIGiI+VCXI3wcdhAj8ipTfzcALrhQTWObVYUY0OWnsTna28e6X+tABR2gx5RAYtU6b/NtgAL2NocurAIJDuRQYddunjf0OlQSEevI4VR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dStVBq0D; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dStVBq0D"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad617d5b80so35455325ad.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241695; x=1776846495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIyBdT4LGGdGx6wgDVyPUXcWl+JiGu8xkKVYACtK5gw=;
        b=dStVBq0D5Wq+ahbjERsatjlq35YuYAFEVBW5GBViy5lugYZxAmTcGM9pHk5bgcuX9w
         SKQliAlVzCl57V1b0Z4nRw33QW3foItyw6PZZQxHQ6N8qExg+iBcjs4dmbZoMATSbzvH
         GmXwntnRXhZNobkIGss8iMky9Cov69jeb9XLcMBg4s9EBuFsodg6fCI7ac3pShrTjhIE
         CnZ9z0JXRA7vGbrWfGCDnI9+3NhF+U1ZM70p6wOyRtsCLZPKX6xSaXtxv9WVpLCK2zI3
         vDIviXmYtFl0uC/7OLnWz7nn/K27LVGAAqx9NyqS5tD+UlvGYGa4VWSNX1xPG9KxZ2GM
         KpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241695; x=1776846495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIyBdT4LGGdGx6wgDVyPUXcWl+JiGu8xkKVYACtK5gw=;
        b=iRBlXn80Qtj05+drLHzEYTJgYzkReIYor8oLi7vaQzppTSsklB5tUTzAqJb+PB1PmV
         jaj58kgNuFVbaEuM8wgvOdxMdjuS4oKlJVRZ84RuZ6dtPZfvFFKbXZ4kbL15K2Ll/DM7
         jrij6vJEaSg5dvVcBnJNyMSo0QqKJaeWrjiq5kYcU6Vp1INox53urnnVbzGbBfyEfDlR
         fxaTpsdaBW4+aebPSOveIx7VljOKZO8y9P9WUFeXjHikABTk/XRhFli0jjqPvMQvEZjn
         D18xFjK/9dbYPD3tP1sbCZL9tspzGFdPsiCQNU1QmTJoXe4YEANlgTn/qa38OVBoX4v+
         tikA==
X-Gm-Message-State: AOJu0YzZpFV7LBubNFLeCufAfyIdTEJxLndvOTjERNuGaMVenACwbrJY
	mVNHN+C+NAjHjhYTga+qljpb5MDosvsLFlW3taxL8vCD1RKdcO72m4ZX
X-Gm-Gg: AeBDievHA/dlT5LzK5BIhHGrCJ2FS7SWmncpiBz6L3hn4GSuIPlm76eN/bLEXgNCRO4
	Zl2yOvSvb1ruBsjUThC2zghNkpSc/vM+fRxf0yGh/oZPbe9nhMnZzAfqW7c15KXfTzWtjngukrL
	KNwiuM+QvAwSEDgdCZ+ksN+N2dCNr0QrwkRA0x/ta+tI70O96ttqwtkFlg9NAhGMIF9PqoPI78h
	IDqddu1BFkeKsN/YDilLqxlqjciq64laaVpka7u8jKMkic0qOmY+Ft5If9OIZuukBOJfu5dvMAR
	7LusX2+fUETeog7oYcuUHDQIfIj9mCjrXiTar6FvQjyzjkEKC12GUvu8F/uk148sI6gymQtRR7f
	IQ9azt1a/U+6pju58Lzn0jRCWylgKEyXpsnxg7CiRvHN1EfrwA5kSbVdwjhOkqkSyEhfErmOUOk
	jsYs2LXgRXRYWcGWh3inyx0TgsPHnSGuHFiriub8T72FimKqC2fp4TLmnA/GLJm0C08yCTLiVTW
	LmE3wi8
X-Received: by 2002:a17:903:1207:b0:2b0:5ec1:97c1 with SMTP id d9443c01a7336-2b2d5939275mr213554065ad.7.1776241695479;
        Wed, 15 Apr 2026 01:28:15 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:14 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 11/14] xsk: support batch xmit main logic
Date: Wed, 15 Apr 2026 16:26:51 +0800
Message-Id: <20260415082654.21026-12-kerneljasonxing@gmail.com>
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

This function __xsk_generic_xmit_batch() is the core function in batches
xmit, implement a batch version of __xsk_generic_xmit().

The whole logic is divided into sections:
1. check if we have enough available slots in tx ring and completion
   ring.
2. read descriptors from tx ring into pool->tx_descs in batches
3. reserve enough slots in completion ring to avoid backpressure
4. allocate and build skbs in batches
5. send all the possible packets in batches at one time

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c       | 116 ++++++++++++++++++++++++++++++++++++++++++++
 net/xdp/xsk_queue.h |   8 +++
 2 files changed, 124 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c26e26cb4dda..e1ad2ac2b39a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -920,6 +920,122 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return ERR_PTR(err);
 }
 
+static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
+{
+	struct xsk_buff_pool *pool = xs->pool;
+	struct xsk_batch *batch = &xs->batch;
+	struct xdp_desc *descs = batch->desc_cache;
+	struct net_device *dev = xs->dev;
+	u32 max_batch, max_budget;
+	bool sent_frame = false;
+	struct sk_buff *skb;
+	u32 cons_descs;
+	int err = 0;
+	u32 i = 0;
+
+	mutex_lock(&xs->mutex);
+
+	/* Since we dropped the RCU read lock, the socket state might have changed. */
+	if (unlikely(!xsk_is_bound(xs))) {
+		err = -ENXIO;
+		goto out;
+	}
+
+	if (xs->queue_id >= dev->real_num_tx_queues) {
+		err = -ENXIO;
+		goto out;
+	}
+
+	if (unlikely(!netif_running(dev) || !netif_carrier_ok(dev))) {
+		err = -ENETDOWN;
+		goto out;
+	}
+
+	max_budget = READ_ONCE(xs->max_tx_budget);
+	max_batch = batch->generic_xmit_batch;
+
+	for (i = 0; i < max_budget; i += cons_descs) {
+		u32 nb_pkts = 0;
+		u32 nb_descs;
+
+		nb_descs = min(max_batch, max_budget - i);
+		nb_descs = xskq_cons_nb_entries(xs->tx, nb_descs);
+		if (!nb_descs)
+			goto out;
+
+		/* This is the backpressure mechanism for the Tx path. Try to
+		 * reserve space in the completion queue for all packets, but
+		 * if there are fewer slots available, just process that many
+		 * packets. This avoids having to implement any buffering in
+		 * the Tx path.
+		 */
+		nb_descs = xsk_cq_reserve_locked(pool, nb_descs);
+		if (!nb_descs) {
+			err = -EAGAIN;
+			goto out;
+		}
+
+		cons_descs = xskq_cons_read_desc_batch_copy(xs->tx, pool, descs,
+							    nb_descs, &nb_pkts);
+		if (cons_descs < nb_descs) {
+			u32 delta = nb_descs - cons_descs;
+
+			xsk_cq_cancel_locked(pool, delta);
+			xs->tx->queue_empty_descs += delta;
+			if (!cons_descs) {
+				err = -EAGAIN;
+				goto out;
+			}
+			nb_descs = cons_descs;
+		}
+
+		cons_descs = xsk_alloc_batch_skb(xs, nb_pkts, nb_descs, &err);
+		/* Return 'nb_descs - cons_descs' number of descs to the
+		 * pool if the batch allocation partially fails
+		 */
+		if (cons_descs < nb_descs) {
+			xskq_cons_cancel_n(xs->tx, nb_descs - cons_descs);
+			xsk_cq_cancel_locked(pool, nb_descs - cons_descs);
+		}
+
+		if (!skb_queue_empty(&batch->send_queue)) {
+			int err_xmit;
+
+			err_xmit = xsk_direct_xmit_batch(xs, dev);
+			if (err_xmit == NETDEV_TX_BUSY)
+				err = -EAGAIN;
+			else if (err_xmit == NET_XMIT_DROP)
+				err = -EBUSY;
+
+			sent_frame = true;
+		}
+
+		if (err)
+			goto out;
+	}
+
+	/* Maximum budget of descriptors have been consumed */
+	if (xskq_has_descs(xs->tx))
+		err = -EAGAIN;
+
+out:
+	if (xs->skb)
+		xsk_drop_skb(xs->skb);
+
+	/* If send_queue has more pending skbs, we must to clear
+	 * the rest of them.
+	 */
+	while ((skb = __skb_dequeue(&batch->send_queue)) != NULL) {
+		xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
+		xsk_consume_skb(skb);
+	}
+	if (sent_frame)
+		__xsk_tx_release(xs);
+
+	mutex_unlock(&xs->mutex);
+	return err;
+}
+
 static int __xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 34cc07d6115e..c3b97c6f2910 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -314,6 +314,14 @@ xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 					   NULL, pool->xdp_zc_max_segs);
 }
 
+static inline u32
+xskq_cons_read_desc_batch_copy(struct xsk_queue *q, struct xsk_buff_pool *pool,
+			       struct xdp_desc *descs, u32 max, u32 *nb_pkts)
+{
+	return __xskq_cons_read_desc_batch(q, pool, descs, max,
+					   nb_pkts, MAX_SKB_FRAGS);
+}
+
 /* Functions for consumers */
 
 static inline void __xskq_cons_release(struct xsk_queue *q)
-- 
2.41.3

