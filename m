Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9D3B0599
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981104; cv=none; b=ssAW3QS5j4ma9Nd7CPGok1k+uPBQWDVcjbppSsmekomFYjHBoFEXGmcUrBW7KMRCaS4L/oRfXw30Ld091q/16B0uDAz29Um4ThkwgsXJe7a9rOHqS1OP5YxOL8UIApnTIQPj+3gNZ45Dka07mMtE+/OMGedycS/S58PACzqPBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981104; c=relaxed/simple;
	bh=4cl2VM1Gb0PxKI+BhSYZQE8isU6lbP+m/ciD5MPCRZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KkPoK8xGJ7kooP5J71UJvoRAfFjMOPOS3yflBX6ZDd2i/IWR51f32IGnJURWQg3K4cOEb8Cu8gkLB0/9w2ais8Xq95TCybnIe+erHh3jE+ZMRqna/0Sm5cqwWNsILcnPPZWVRC4/FnsR2SeussyzZVAf1H8WutRMUpUlQCwVPzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHZWMMmU; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHZWMMmU"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so7940416a91.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788981100; x=1789585900; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AcO81dRZAl8vXBv9U9RzYMgfWn1QTLYhmyLktJ0Iemk=;
        b=PHZWMMmUyRS039XjVGaovBW+n31qMM5K3zirsus3Gc+40MAnYPaL2w4NyKUOCWHkyr
         3ULwBlOpWj+2TQv7q9vPbjAqlj3DPDyteqIid4voUWW/Wh1AJdSV+eI2V6usDn3UKQ4/
         DrbQFkORtKBmSkwRhDIQox8D2ioiWvpIxgPDFLb7dFqMFqRM7vAHRWY1/KiMOfwPFGu1
         xP84DzxuADclnWWNUblf0905/dI1oqm2HyfPLxO2GjloPEUMFsde6r5lfMN3N+rPo+ws
         lpOugcsYcfmtZGASGX2XpcDSlowJC5tHw4X9w4FYKciMPs27+1f3QX8ndU7bk07vGc/a
         9dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981100; x=1789585900;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AcO81dRZAl8vXBv9U9RzYMgfWn1QTLYhmyLktJ0Iemk=;
        b=TlF9llLaD5floFt27uZCOKG1OifYzkn5CpKadNgNQOo7T5NFY2+fe6CKefQC/seYkv
         4uqTQzbfKPHDIavkoXAqZua+MNqOIrRNw/+2lkK2kDreisallUbHg3fIIIc+GOqV3waJ
         Lah737s87JH5ds7ETqgyuTWzS5VGPTMshOgEN9YUmMx0bc8V5UbwGZBwlZiNKDUp/spu
         vb61uJ3odNV2eD16rzYr0FBbhu4rgV2xWxeOaDgbk102MBBulXxYqnIvsuzvpkuRjTjf
         0JpFk39WyMqmN18/Ht/+IOeJfwV+ITiL13pr9K2o1lX1rKoloXAcdAtMB5TN3mPbY+1h
         A6lw==
X-Forwarded-Encrypted: i=1; AKwUvBzR0JfaX50SSqmEkR4dmLVTXdqGLePzNcgQ3kuS6eQ/vooc7/fIfSs7lPNuITO33y6jxoE=@vger.kernel.org
X-Gm-Message-State: AFuF++mFVildRUKlZ3xTDSS8j9aWsysuITbvSrwmaM7harHHtkEdu8cQ
	OPFT1E94IV0HNObWgA8U6JRTyLieBHiQM9zykxM1g9x9i7gL5i/9Vyd8XLA4uAO9TFzXNHN1YjE
	Rx2sLL7TuNWf/1gWCQcwlmonB1Q==
X-Received: from pjyo21.prod.google.com ([2002:a17:90a:eb95:b0:39b:a02e:b51f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b4e:b0:398:9be9:ab8f with SMTP id 98e67ed59e1d1-39b2622b9ecmr54951568a91.20.1788981099875;
 Wed, 09 Sep 2026 12:11:39 -0700 (PDT)
Date: Wed,  9 Sep 2026 19:11:26 +0000
In-Reply-To: <20260909191136.3811892-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909191136.3811892-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909191136.3811892-4-hramamurthy@google.com>
Subject: [PATCH net-next v6 03/12] gve: introduce ctrl ops to set vectors and Qs
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
2.55.0.979.g7e5102b832-goog

