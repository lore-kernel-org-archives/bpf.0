Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703A3D9DD3
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673672; cv=none; b=YRkqZ6yKzCnQFXt8pwJYhGl/vVGXzy/+FNjpKqfjy8CWTiRd8ce7lR/hcNjw3i5K2aa+KLo4OFBE2fU+zKK1Gbg4gQgd7/mF4YGSw/qQDsv3FLE0pKTykzukLsw3oaRtyQCNaqkVQ7/zQTSzlUSjX0yyEKysUq4GWZ87CXxNLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673672; c=relaxed/simple;
	bh=+m2UeT9LyGMFFRpz7I9eZ2RZNUM5QxKXV8kZOd8zm8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=orkwuGqLACllqegWQgqGDBeydIGfQoPDNLRySHyvUIbXCWfRpA+3a5PGoh7/YF9QEiGZtY0YI/PSCuwCyEGFHGP6AxXeHka67UpM7t7Mx4AzD1mkMjfps3Kh+E3r0FjiXLC9GVVp5SLyVKAnrFwBvg0qR1V8C/qU/apjDqMtxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QpwlqZ8L; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QpwlqZ8L"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc5faecf01so11083505ad.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673663; x=1787278463; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPOjyBQRGCczAdWZmxygXUpPv0szQHv9gt92kjdg6Go=;
        b=QpwlqZ8LsO2QjV06N+TGqkSf9QwmLYQ6tHcUtt7H929zc5u4VdJyGr1kqcgKUG94T0
         EgDmwfLZ5I+Lvnllt1SgmBAcCLOeMcRbOMash3n3wJ4xVPXTddpgzZ6l9kh5o/IGMr4T
         Nj44vETfy6X79evH63sZp7zqVoCACMbW1l9PPo7/Sx+CaBfizRONFmiMYF7VFcFvu2YG
         J/05iyA7/K93lBFaRWCcidDSlTpoMZ2C6K/jU4uR9H0PuSj4mm10o3Ctkkwdb44F937r
         V8p5HkgzydOwaS603xx72a6wS9tI/GkiQx+n/2xUETIPrTfjkZZlkTgeeU0KlTnXFv3w
         EedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673663; x=1787278463;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jPOjyBQRGCczAdWZmxygXUpPv0szQHv9gt92kjdg6Go=;
        b=eNsm7zmFq2Br06tNnn2ETW/vPgds5kJtsvI6ditExzD/JL7QBv3eNCgAKPCz1Ra4FA
         9nfaFcD+Z+vWOU65iE9VbIjgAGVqIsfcV6vCELTrSKp+W/h9TqRTbiKeJdetYcfNdM3x
         9I2JfhtnTXJRXdG3kddGkoTO1B3cCy+KCyu+V5w3Kq86MRN/D1yHAJzjh3BTDZjm/H4N
         X91yfUk9Z1wDljNGnMlX0LDWfpBbLj1NVF4DAQ8yFdM9XwLvPdAej6IfwDlmROu07xJ5
         wRsDE8jmr/5RZBhvIV3kk74DfeWLKXym1QNSliEclYA8wVdNOqwXRmPwmh0ij99FNnKa
         17Wg==
X-Forwarded-Encrypted: i=1; AHgh+RpA48BD7xAHVGOwhVkfnUBIH4+l85d6Iy5jtHQHMRSavysampDCMPI64RfzqyOU+AQ81Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5PESyB8ekv3EnpzhiH4lGtDiFRbP5Lq0+nHrwEfQfpOLrIKn
	lx0d9Sq90aLKCteFABHgvp8g70nPVFOyojd8CYKLxIgFb8dDpooVHcaOeed64/mEFhAwuMN0gIp
	nmk750cxPn4L4quANyLY+rzP9Fg==
X-Received: from plko11.prod.google.com ([2002:a17:902:6b0b:b0:2ca:d820:b697])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d552:b0:2ca:caa5:9c04 with SMTP id d9443c01a7336-2d3b0d2c159mr30818095ad.23.1786673654855;
 Thu, 13 Aug 2026 19:14:14 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:13:56 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-7-hramamurthy@google.com>
Subject: [PATCH net-next v4 06/15] gve: introduce ctrl ops to set vectors and Qs
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com, debarghyak@google.com, 
	kees@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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
index fc5482215588..d0b7ce8ff4c5 100644
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
 	priv->tx_cfg.max_queues =
 		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
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
index 27da5e1284ce..37eed00c4ed1 100644
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
2.55.0.691.gc56d675ccc-goog

