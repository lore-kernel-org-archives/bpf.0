Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7812563FBB
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577756; cv=none; b=HSBe2P3CFkf6jhw+hLR5VWAyjh3fm3yetL7v+E7tc1pbK8BwVXa0oVhxvVITtFWtj1Kf9uCMBAZPg1rNtI4QBm9fMsWiu1Q5TcFD774vhrKCKAKAG3ShIiZ89K7eXFN4bb1MvG8/QeU4ZLJDMqxkRFVGFc/oFOkj703je3LhD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577756; c=relaxed/simple;
	bh=n7NC6VfOs7P8djXoYFv2AKaHgOTW0oGGOdrcZ+SyaOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ovPVK1zBNEa23JFjhUR/qGwnrWIcnS+p8v5xYvfxWmHaZEEhbtR0rNzP/wfyTWZOSSA9dAjZQSHOQq/+SnER1hTWwq+ZOF5S7aVsJWYhPG3/LZcX7BrLBfJRr6jrcVxDxi2j9XGSWaaBZU3C5AcaD+ta3IUqxlF1wB4jvbhmSO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UsYvdDop; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UsYvdDop"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39af92138f9so4252296a91.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789577741; x=1790182541; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kvW80pnkDgaH8w8EBy/btGukD57MlasDA+32on+QBMA=;
        b=UsYvdDopF0IJe90Qsakvq39VLwHBscGmt7gKk+MEe6iQvYSEZ7LeBgV8QsbyU0Dlf8
         TdQvm98Q44hNq6QUPumJ4WjM/DMv55T5Jzti4d0yAA9B2/T33KDLako9ZCQ86Xtw2ODK
         lsKx2TGRDVV1BB5/3fzUhfUGB29esZxiMtT/+x82ame7INPpSLx3WQcDWJOhuGBS6lwe
         M0Z+B+L8odyOBsCQJw3mgZgnoI/ku6MuI/53SiDMyFkX5ZSMxjTpmqASUVAnW11x3SN7
         wiyUPbiQ5CnexkG/SeHdYXfLkuA2H/83mm4fs5+YU+pVwWj5ZiK4dzWrK3I7REsauLbd
         mlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577741; x=1790182541;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvW80pnkDgaH8w8EBy/btGukD57MlasDA+32on+QBMA=;
        b=G6gZdC87yPcD2U97jLHuGaodm0SEUePOs+PL62zlnTJK1nn6Lxv7DAnpORSuAqenah
         KMvP7ibBu+GrIFCYgySNl6+hoQH7oVCgtT2L19RpWwHT/Yw/coekn0UnO/IsxDttG1qM
         f3CMrGQDHJYtLz8/IDottS5BbYnRhXcYJUjyjIdmsH6cneOdts4hJ5lQpNEFvCmzs8Sl
         x6Nh85zbwrHgQ4ILXdirHBA1Y6oHtHfS8fjvxeAU4318DBrT4V5qPAKw4S8fIn+7cefC
         GVWuOnmmwU4rp5LvAOUe3mBM9pQxMT3pA/seLw3y93GH9vdQOOfKG8DnStFatrKWm1em
         XHdQ==
X-Forwarded-Encrypted: i=1; AKwUvByIu6QGEBzHNNvrDjaCKQEjE4lu1q7iG8MVLSjPZ7j+WkUrbbZo9Awf+fVYcyVjKHzlMwM=@vger.kernel.org
X-Gm-Message-State: AFuF++k50tCgdm0oz44LZvOXoZg+ht2ivUlJbeYk99poL6DRqIVG3IBg
	q1zGI297Oo2ShDKQjjH6zwKw4d80Krl2bBEliAocaP7DHPTO2gtw+UhIJsn3H2S2kwG5JeVSXZq
	Mwk784lEeMytFHMmVeZKKETY+9w==
X-Received: from pjbcz12.prod.google.com ([2002:a17:90a:d44c:b0:39d:ff1c:bcbe])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f87:b0:39e:252b:86c5 with SMTP id 98e67ed59e1d1-39e35daaabdmr405995a91.1.1789577740975;
 Wed, 16 Sep 2026 09:55:40 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:55:24 +0000
In-Reply-To: <20260916165533.2187434-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916165533.2187434-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916165533.2187434-4-hramamurthy@google.com>
Subject: [PATCH net-next v7 03/12] gve: introduce ctrl ops to set vectors and Qs
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
2.55.0.1032.g73a4cd73de-goog

