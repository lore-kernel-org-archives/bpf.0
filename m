Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391373CB54E
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795077; cv=none; b=diHUOdRXju570vxfHM460vkI3tLEcZ1Vyy1+eCpYdMnCH/nvrLmT0zGFIGAup5N9GknBUEZ9iY4XeQAhNEUUwyJOA51oALBf16qmos7Dlr+BVd2RZYj/9B3q3KKDI+6lyFqbzvKuAQqj7lAc2uXUCWrXWJPli8dTrokHYdki3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795077; c=relaxed/simple;
	bh=ndaxyJELO1wx/IxvjzMEVBoIj/b4FAKd8jjn+4mmvXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lJFwbM5wlEosQE8ep+uii3zlSI2mpzlXva4zZutfPhJXp42uENXoXWZ/LM/u0Iha5yOo0QEImfWFS6tt0iqMUM7GNfvmCQ1qKebAvLHNV/rlX3th07r1FGj8F+GUYfthVNnAPlCEjnMdJ0ZZJRhsXQgQTQ1i7EtnUxN0ZWPjv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuutfrEr; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuutfrEr"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so4350852a91.3
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790795074; x=1791399874; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l6K8IVlhn+AmfkAUmpzKqB3EV5XVKpktqFcpp5Us8BY=;
        b=XuutfrErA9smITjK4e4EkSFHjsCUbckbTtTzab41A58FUHDYZwGNb8nGfWGnlRJDqf
         DNp7e19dOaqhiaKUL4h/L0bfpD0Q3XDoY8l2+OE+sVh7thXVofMTS6r01xpeCKdbxm/Q
         tdzLOyELx/RHM9dHpmGQiTDZ38ilnemFksDfPY8vmY1mvxgLc51zuPq4pCftC9gWJIXT
         ecnjd0acjCm+j8pAKSUqr0JMfHgOE5o+4fJiABmcIBCtMSFY8kdLhVQxOFJtQ3NMvJn+
         IWlRrZjulBewCEWkIiP46UDpfT/D8CCfHmUPQcgHAwbyyKjqyzb/mh954sruCHB/XvtN
         xmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795074; x=1791399874;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6K8IVlhn+AmfkAUmpzKqB3EV5XVKpktqFcpp5Us8BY=;
        b=bI9scDCplKvtjU8MsDbMTE7gh/p/07zahhdhbaG13B+C6j0bBgubNIZhaOiGkxDpCu
         lfQsujshfyPJgIAWMuGoHzdhPpBlO2zgA55JrSxzFjC/F5k3yoGKhhzJ96x6UwvLzqyy
         ug+5NFLewFLsF76dolUsqGhQqh6f9WSJ0Zb6KpnHEjt6nLICmJU6kYYBeH55P+PNFqXA
         C9CKZyCkY4ojkXXJUVmKPysQDQmfs6vnu2dr5bbAF0N+mrniVLCPZb1IE7eg9W8CcVT9
         j4h+hLOud1XwjXvCIwLknUZ8A6sTJpIW0fGAu1ItvjDM5NL31JQTZDzQcAKl/9RMpc4x
         DnFA==
X-Forwarded-Encrypted: i=1; AKwUvBxhBLlgEDvLLjhMrZv7Pr31wbV1i4RoAXKUUdfVkJSXC15i7lYjVWozHzlLaK+uiFWvf3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjYjjeX7Y2PJk0iQTx1Jf++KAcsVQfrExVkNnvZJHM7A1y1rhJ
	jM21HeuGar1EvlgnJhrN4qMaDUzjmOEMLCmW+wymmMKQPXpszGptztEhPoF8LbX0IqyG8C4SBdQ
	jYsDinXAuBObvj31bgIcCGuSEeQ==
X-Received: from pgc2.prod.google.com ([2002:a05:6a02:2f82:b0:cc7:8224:dcaa])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d446:b0:39e:6a81:5a98 with SMTP id 98e67ed59e1d1-3a4d1b45841mr1850400a91.44.1790795074149;
 Wed, 30 Sep 2026 12:04:34 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:04:19 +0000
In-Reply-To: <20260930190428.1130007-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930190428.1130007-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930190428.1130007-4-hramamurthy@google.com>
Subject: [PATCH net-next v9 03/12] gve: introduce ctrl ops to set vectors and Qs
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
@@ -1592,7 +1592,7 @@ int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param
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
2.56.0.rc1.315.gc6ed9934b7-goog

