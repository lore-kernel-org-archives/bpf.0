Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69E4AA419
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106366; cv=none; b=cCuDPbWCzDYWfpbcAKFUFTwAGwZgcQXz1jBWUEMU0qSNEnNkelPSyN2lBFlJ58YH+pssouoUo/g8xiUjBgJjRmCOHvjEgDzt3M/ksRKloRN8VjHlByzVV/d28bnRX1FmLuaMhIoDXI2BB8epwbpMfOvA+I/+EIqVQN1uPoIg9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106366; c=relaxed/simple;
	bh=1EJkBF60HcU/pLER8OktBdGOFBFfB6U9QISFMdwHHNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l67/J+6vpxw4IuMAecSjQ6L2Nezx0/IEz2h6gSYFZtEMjLXsl4Ye934V0DvL2H9CRknOvSAtP/APIuO9fdv4a3z99El0EnsEQvZhcxW6apwAhl6+Lif4sO+rBjmrx7welOqXLpaJ5sB5Bxv85o7Mo7xd23hGosWxbXcwp/w0s0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GF2W7ZMe; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GF2W7ZMe"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8679cfe5019so350937b3a.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106351; x=1790711151; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lE/2nZUBQE5y8bltkgjlYIgZWN2LasehNWmZI4UlYBI=;
        b=GF2W7ZMeAwEiZhP3ksEcJ62yH4pS4zP1EEIK0gf8m4g04RRqZIVM/71EkmeGSYDXzn
         JpfybL+tDDEYlk82YRhhijL4zqQPD+H7i2pjrJ+BVGu77P2Ho32cdToYBFF1FOsbCVoZ
         46tutafUzUNry0eudlN+6E3LP8sSMIP94cJmddekjYQ0q1V5us2cdgtMoQxQW5AlLUvk
         FNDDQhxt4EXWDsq41yJMd7+bv7LT1Dmd0LE+/j76/+Rk1zoDWZHPkP6uH9C8CdpWK3qB
         jOCMFpOJ0p89eiv7l8Y0Jcj/Pxn0lFIJ85asdFImCLxVgytiNtO24ylqVL6INSwsAbm6
         yzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106351; x=1790711151;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lE/2nZUBQE5y8bltkgjlYIgZWN2LasehNWmZI4UlYBI=;
        b=lhbpuxAOFvtlRsV/cboC5Jinaln0hKixkvwUDenL7hzCx/+NgXsMLbyHG/XoaH7dtC
         aiWOpP+WNoX8yHhsYFPsgt9PjDgB2dkXN/Qz8nBb4HSEOL2BqdYlkGflC7iPFGjg8okq
         z+GrcbQmlddcLEKV+T6CtlOkwh6FR1vILBlS2k/V1CjD9pyQ1yGwhlvCxpaVGcR1T0nZ
         LlTp2b8Rz0aWg7NHUWw+v9WPpxfvDOiJ+MAAZqTCRv73GKaaQWCjh4RjUQbs3KYQcklT
         yWDLffaFWMex7Lsfgoosl6CDxeR656vfTGrogHo/cLul38M0QANea9KD56F//t0HEpU4
         RJ2w==
X-Forwarded-Encrypted: i=1; AKwUvBxpMDzIt+1wuM2eu+7ohhoVpJXEME0Uz95ZomstOLDyQ8tPi7TiUR/5KYeyfD7v8KP88Rs=@vger.kernel.org
X-Gm-Message-State: AFuF++lNS0c8xKqI+u6KOZPSHnSLbZbJTgFakMeXO+xn8uv0+fysSpUk
	Se42x5WmLkpFjip+SQQEGp4Pi0aavSAQoVKLDnjl3e/RFgg7+XgnA9EBZM+/8Y6g9iHAbKaL+em
	c5KVxPexezGSdXg==
X-Received: from pfqy13.prod.google.com ([2002:aa7:9e0d:0:b0:848:5540:2ad5])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1911:b0:87d:430:1578 with SMTP id d2e1a72fcca58-87d1b8a0852mr683603b3a.29.1790106351015;
 Tue, 22 Sep 2026 12:45:51 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:31 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-8-joshwash@google.com>
Subject: [PATCH net v2 7/9] gve: disable NAPI when registering XSK pools in
 QPL mode
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As a result of QPL modes not posting XSK buffers directly to the NIC,
they do not need to recreate queues or re-post DMA buffers.

However, traffic should still be quiesced because both the driver and
the XDP redirect stack must have the same knowledge about whether a
given packet is being processed with AF_XDP zero-copy enabled or not.
GVE in QPL mode does not current respect this, which could lead to a
race condition between packet processing and the XSK_BUFF_POOL memory
model registration.

Quiesce traffic by disabling the NAPI while the XSK_BUFF_POOL memory
model is being registered with the kernel.

Fixes: fd8e40321a12 ("gve: Add AF_XDP zero-copy support for GQI-QPL format")
Cc: stable@vger.kernel.org
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v2:
- newly introduced
---
 drivers/net/ethernet/google/gve/gve_main.c | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 49ae2b8c6a27..f2bd4011de23 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1626,6 +1626,40 @@ static int gve_xdp_xmit(struct net_device *dev, int n,
 	return -EOPNOTSUPP;
 }
 
+static void gve_disable_xsk_napis(struct gve_priv *priv, u16 qid)
+{
+	struct napi_struct *napi_rx, *napi_tx;
+	u16 tx_qid;
+
+	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
+	napi_disable_locked(napi_rx);
+
+	tx_qid = gve_xdp_tx_queue_id(priv, qid);
+	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
+	napi_disable_locked(napi_tx);
+}
+
+static void gve_enable_xsk_napis(struct gve_priv *priv, u16 qid)
+{
+	struct napi_struct *napi_rx, *napi_tx;
+	u16 tx_qid;
+
+	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
+	napi_enable_locked(napi_rx);
+
+	tx_qid = gve_xdp_tx_queue_id(priv, qid);
+	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
+	napi_enable_locked(napi_tx);
+
+	if (gve_is_gqi(priv)) {
+		if (gve_rx_work_pending(&priv->rx[qid]))
+			napi_schedule(napi_rx);
+
+		if (gve_tx_clean_pending(priv, &priv->tx[tx_qid]))
+			napi_schedule(napi_tx);
+	}
+}
+
 static int gve_xsk_pool_enable(struct net_device *dev,
 			       struct xsk_buff_pool *pool,
 			       u16 qid)
@@ -1655,7 +1689,14 @@ static int gve_xsk_pool_enable(struct net_device *dev,
 		return 0;
 
 	if (gve_is_qpl(priv)) {
+		gve_disable_xsk_napis(priv, qid);
+
 		err = gve_reg_xsk_pool(priv, dev, pool, qid);
+		/* Make sure it is visible to the workers on datapath */
+		smp_mb();
+
+		gve_enable_xsk_napis(priv, qid);
+
 		if (err)
 			goto err_xsk_pool_dma_mapped;
 	} else {
-- 
2.55.0.1082.g2b9226bbc0-goog

