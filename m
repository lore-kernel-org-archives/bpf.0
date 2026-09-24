Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE44BA1D3
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276009; cv=none; b=nRB6FlIe4Wnvz1ujeMheyR0JhzzM0D6fJSlGYSWaotr198ClvT8pp0Zi/z9OuUrm8O142+wzGZJJoTThVBskSBR0u8UzYjrRaMcqiNKQh4q+wGGDCpcc8xcyvIXdq5arGixOAsjDibG2h21NMWfKCnBic7NGfv6F1iC08oV5HlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276009; c=relaxed/simple;
	bh=cZ8SeDM22yqk7dKw9w1+U2wmRPMQ3mR5PchuED+iusU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dYHtLYM9J6VmYaeJCMilVfR9ZiHxl7e+9avhn7AR1zBYTus5R6XTX2RIpBNvl0cUkYCd+2+43BtpI1R8JZ3MK7Lg8au8pHTbJRZg1Z3YQNNk8DSReM8JvI/4WqSCe0swtf6Is7rDsG89z+NgCjdobd2S2/5+Pw0PacSlLnCIHBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CEDmDG8v; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEDmDG8v"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d001671a54so859675ad.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790276001; x=1790880801; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wt0D/bnDvGO9yknDK0nOdesl+4rl5H29eel7pguvOk0=;
        b=CEDmDG8vycJKA7AL26ZSJrICQPg+uUNiyq7FfGqNEFgqY+ocyLLhFuxCLuJ8cx34Ld
         xx97Jz93XePgT04kN4WeZJ2qIg78N8lVSfY9nafivAWTKLsYQyPUrhOuRC+4S+YjMRK8
         /BOq9uVsozLyWD9D/VSe0RqcCtQFrrcxn+vFIDf2qEBFwJtzEoxcS/a8YSGqtiadINNR
         SC8VsNXdOopu4tCKU+4LBPERK1sZ3ZfIcg6WXKGNcp+I//px4vJ5wTNLOIQ7MODm/+qO
         UQD0J8i3QEkGlB3igbcuDWBVFHRWbd3bDw8vWQndUvLaaqfZVFcVsKs+2AFUcpW8W7jP
         wB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276001; x=1790880801;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wt0D/bnDvGO9yknDK0nOdesl+4rl5H29eel7pguvOk0=;
        b=ZC8m8lhTbBvioJUkQHA6DklUAphEw32J7BlDjLD80HZcXKZTHBhct3WrJB3Ic8A9QT
         g8rj8ds38k8TaTvyUlJElOn9iYQBVr5WQ/csd06zQeFUP9+3M2fIqArDe0SbzoXPlMxo
         Zb4Wk1sGTJ36Hxm28DpyazpUJxqG++ST+e4O7dfZlZNWrqc6kKgpWUrqF5Vl79u3Hd4a
         M6qeUzcdKp8kITMKn+TSestSoB1M5rmKoTRPQKGkPBVd/L1NIkJ0sVvly823zWZ8EIfM
         X+nqRKfI5hW/JuK0XlUxxO1HDF3EYjo7zb2HEOUH0gZAyO9rPbZ2VrcmKJZqUuiq/XpN
         Vp6Q==
X-Forwarded-Encrypted: i=1; AKwUvBx7c5xhYM0aLdcYnIoQt+6TnHiksGtVaI+M8ZJAcT5u/BS9oi9YLiFbmR6eZ++G1F2yJic=@vger.kernel.org
X-Gm-Message-State: AFuF++mb9tXfGV2+5HojuK32Q4e0X6Oaodvb/dHJk3nqC5HYrWQAFD3N
	us0z/OxHvFvDwRHgjQn8i5hYtQXwBDO/zQKqLMXwUfEgu3JInGtcOOpGFOknCMXyBZ8xSbMlFB4
	rB7geczvv9P3DftCwj83rByGh4Q==
X-Received: from plbd9.prod.google.com ([2002:a17:902:f149:b0:2df:521d:9b56])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2a8f:b0:2dd:c100:b2cf with SMTP id d9443c01a7336-2df7dd71bc4mr28509135ad.58.1790276001123;
 Thu, 24 Sep 2026 11:53:21 -0700 (PDT)
Date: Thu, 24 Sep 2026 18:53:07 +0000
In-Reply-To: <20260924185316.2831077-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924185316.2831077-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924185316.2831077-4-hramamurthy@google.com>
Subject: [PATCH net-next v8 03/12] gve: introduce ctrl ops to set vectors and Qs
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"

Introduce following ctrl ops for Adminq mode.

- set_num_queues to set maximum and default TX/RX queues in the
  alloc structures used in the initialization flow.
- set_num_ntfy_blks op to set number of vectors(ntfy_blks) in the
  initialization flow.

This is done by attaching the adminq_ prefix to the existing
functions placed in the gve_adminq.c file.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v4: Attach 'adminq_' prefix in the function names for gve_set_num_queues
    and gve_set_num_ntfy_blks and set them as ops (Przemek Kitszel)

 drivers/net/ethernet/google/gve/gve.h        | 6 ++++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 ++--
 drivers/net/ethernet/google/gve/gve_adminq.h | 4 ++--
 drivers/net/ethernet/google/gve/gve_main.c   | 6 ++++--
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 56148ea3cfbf..1bc5e32b6618 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -829,10 +829,16 @@ struct gve_device_info {
  * struct gve_ctrl_ops - Control plane operations structure
  * @map_db_bar: Maps the doorbell BAR for the device and store in @priv.
  * @unmap_db_bar: Unmaps the doorbell BAR previously mapped by @map_db_bar.
+ * @set_num_queues: Sets default and max TX/RX queues into allocation
+ *                  structures stored in @priv to be used during initialization.
+ * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
+ *                     initialization.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
 	void (*unmap_db_bar)(struct gve_priv *priv);
+	void (*set_num_queues)(struct gve_priv *priv);
+	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 08d8e49d563e..046155ae7d66 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1592,7 +1592,7 @@ out:
 	return err;
 }
 
-int gve_set_num_ntfy_blks(struct gve_priv *priv)
+int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv)
 {
 	int num_ntfy;
 
@@ -1616,7 +1616,7 @@ int gve_set_num_ntfy_blks(struct gve_priv *priv)
 	return 0;
 }
 
-void gve_set_num_queues(struct gve_priv *priv)
+void gve_adminq_set_num_queues(struct gve_priv *priv)
 {
 	struct gve_device_info *device_info = &priv->device_info;
 
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 93d3cabb67f1..ed3504853908 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -656,8 +656,8 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
-int gve_set_num_ntfy_blks(struct gve_priv *priv);
-void gve_set_num_queues(struct gve_priv *priv);
+int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
+void gve_adminq_set_num_queues(struct gve_priv *priv);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index d721347e54b4..da53c1fb6afb 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2463,6 +2463,8 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
 static const struct gve_ctrl_ops gve_adminq_ops = {
 	.map_db_bar		= gve_adminq_map_db_bar,
 	.unmap_db_bar		= gve_adminq_unmap_db_bar,
+	.set_num_queues		= gve_adminq_set_num_queues,
+	.set_num_ntfy_blks	= gve_adminq_set_num_ntfy_blks,
 };
 
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
@@ -2501,14 +2503,14 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 
 	priv->queue_format = priv->device_info.queue_format;
 
-	err = gve_set_num_ntfy_blks(priv);
+	err = priv->ctrl_ops->set_num_ntfy_blks(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup notify blocks: err=%d\n", err);
 		goto err;
 	}
 
-	gve_set_num_queues(priv);
+	priv->ctrl_ops->set_num_queues(priv);
 	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
 		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
 	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
-- 
2.56.0.rc1.310.g51773c2048-goog

