Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F43E9C2B
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336494; cv=none; b=kDOtrkhbSeuXhEA2JSWJuhYNXzaKuwPYU5qSZk02Myev9MHVi7c+jc40v3Bfra6PHXkHtpiU3w4rH6/RPAjHPaCD9NA6GfIDXJBL9eGS265DdGSyyt1X+IXjB1e6xt6q5IhNtEPpvtHbJbZwFCkKncs4XxDB9JAl9bw1o64T3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336494; c=relaxed/simple;
	bh=h3KWSxMN/qgHst94bYY4WUtCFjOCMGganwOkBkt8sGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n7fcQcc1dhiIH/WXnz1H/P6iT4uRKigFbZmwihV+l7HW6NJXsMbtW1fMiKveuSmX1Dq5NeFvkUX5AqGo/aEKwriYL6Yya/x15+qlSxHT1Wsrh0Yxj4Q2bxnktyfWnzAGwsizhzBKCyvIXTOJyPe5HXKl4zYWoUz+Oafn4kHGKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4FtoiOb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4FtoiOb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c272e532so18926745ad.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336492; x=1780941292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rz53fEfSGvhiqDn6NlNiGo55xLa79XIY0IpZD8TlaYs=;
        b=a4FtoiObBB4fcO+3EvnsgAmY4mD7dw+aExcht0rrEs5c7GUOPKruar5KCqh2cpVszu
         YUr25qsTDMkWiwbFmIdhVAp3146rlsCrfcaPDmr0GFJCQIzLl3p9NhsgdmhH1iBBX+Ot
         S9cE76fCDOGkC+B1S14XEO0xpPnG1PXsiR6SQ0Rpdlk7/K5uP4wLSnMy+yEZxVJuJDk9
         0jtVrT1PUf0Wx+Ofd/b/2l0B17r4Ylnbj0+yNkNx8liDz7PVIbkv3ukhNuR7GyDFJhnc
         2yhE6OAy0p759J30XcE7LyMYXFmw7XkDUAp5f+B+odeftw7WWheObmjp9UJdup6/BYMM
         +8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336492; x=1780941292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rz53fEfSGvhiqDn6NlNiGo55xLa79XIY0IpZD8TlaYs=;
        b=EUbdkkMapUCuUWOuewlRajlMDgG3rGXh8gsWUu5l/69IJ6fjtOu0T7tUIYf4iArRgv
         bfZ7FZwkFVdTG1vM6/vBNDNF6extnLcd4vV+xA9UpIBQ10H1MKWLXuGsBaZYxHbPvO89
         kyPFECtghyb7TLDOSYIIlOOGeISFz7arHWM/yVeksmSmiOX0kuGxPWx8fy+uJ5zl34XR
         AxVrGN4Eh/q0qWvuAFwYOHR8aZNtQewa72u3ZeUFwsDWYlNwSB+/9MjpNP7MmzW6skg4
         77dDrBULC7YmH9lhgv+PWfCi4tISixqGRUZN/nlpNaUJ/Ng+7zcTgWDPRH3IE5q5P89o
         /XCw==
X-Forwarded-Encrypted: i=1; AFNElJ8rmVyi8b2RaVCEvGbsn+6UqPUzAOzbqxkF6qhFVPba2E5l1jOZKVSG/NRQ/DoXfahNUTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoUnE6yfFGWP76t1E3nSrDSBTlgRfZRQeANwXxW3vL1IQNFiBF
	Io/IccqWRLPBTl+TPeK58O7pbyaq3/j+YQcDZ+ZLUEh5swIJUF/OLrP26Tf0lik+cIzNn7sl6o7
	i/P/UGPomBg3ucDuAgJCgQp1NSg==
X-Received: from plgy12.prod.google.com ([2002:a17:903:22cc:b0:2bf:21c9:7d27])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf01:b0:2c0:a959:8677 with SMTP id d9443c01a7336-2c0a95987dcmr125550505ad.14.1780336491643;
 Mon, 01 Jun 2026 10:54:51 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:37 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-16-hramamurthy@google.com>
Subject: [PATCH net-next 15/15] gve: add link status/speed ctrl ops
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

Refactor link status check to use a control plane op. Introduce
new op for retrieving the link status in AQ mode. This op reads
the link status from the device status register and stores the
value in priv.

Also add an op for retrieving link speed in AQ mode which calls into
gve_adminq_report_link_speed.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  5 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c  |  9 ++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h  |  1 +
 drivers/net/ethernet/google/gve/gve_ethtool.c |  3 +--
 drivers/net/ethernet/google/gve/gve_main.c    | 23 +++++++++++--------
 5 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 6cd993221488..67f0633e4b89 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -846,6 +846,8 @@ struct gve_device_info {
  * @reset_flow_rules: Flush all flow rules from device
  * @create_queues: Sends commands to the device to create TX/RX queues.
  * @destroy_queues: Sends commands to the device to destroy TX/RX queues.
+ * @report_link_status: Set link status into @priv->link_up
+ * @report_link_speed: Set link status into @priv->link_speed
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
@@ -866,6 +868,8 @@ struct gve_ctrl_ops {
 	int (*reset_flow_rules)(struct gve_priv *priv);
 	int (*create_queues)(struct gve_priv *priv);
 	int (*destroy_queues)(struct gve_priv *priv);
+	int (*report_link_status)(struct gve_priv *priv);
+	int (*report_link_speed)(struct gve_priv *priv);
 };
 
 struct gve_priv {
@@ -975,6 +979,7 @@ struct gve_priv {
 
 	/* Gvnic device link speed from hypervisor. */
 	u64 link_speed;
+	bool link_up;
 	bool up_before_suspend; /* True if dev was up before suspend */
 
 	bool mgmt_irq_requested;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index c4932a258244..81c81bf1fd5f 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1897,3 +1897,12 @@ int gve_adminq_create_queues(struct gve_priv *priv)
 
 	return err;
 }
+
+int gve_adminq_report_link_status(struct gve_priv *priv)
+{
+	u32 status;
+
+	status = ioread32be(&priv->reg_bar0->device_status);
+	priv->link_up = !!(GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	return 0;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 8c72295bfc15..979ffe693229 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -643,6 +643,7 @@ int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 			    dma_addr_t stats_report_addr, u64 interval);
 int gve_adminq_verify_driver_compatibility(struct gve_priv *priv);
 int gve_adminq_get_device_properties(struct gve_priv *priv);
+int gve_adminq_report_link_status(struct gve_priv *priv);
 int gve_adminq_report_link_speed(struct gve_priv *priv);
 int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule *rule, u32 loc);
 int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 1a54bbd2cbf6..71ed62fb1d71 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -752,12 +752,11 @@ static int gve_get_link_ksettings(struct net_device *netdev,
 	int err = 0;
 
 	if (priv->link_speed == 0)
-		err = gve_adminq_report_link_speed(priv);
+		err = priv->ctrl_ops->report_link_speed(priv);
 
 	cmd->base.speed = priv->link_speed;
 
 	cmd->base.duplex = DUPLEX_FULL;
-
 	return err;
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index dfc734d8bec9..181ec6919051 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1475,15 +1475,15 @@ static int gve_close(struct net_device *dev)
 	return err;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
+static void gve_handle_link_status(struct gve_priv *priv)
 {
 	if (!gve_get_napi_enabled(priv))
 		return;
 
-	if (link_status == netif_carrier_ok(priv->dev))
+	if (priv->link_up == netif_carrier_ok(priv->dev))
 		return;
 
-	if (link_status) {
+	if (priv->link_up) {
 		netdev_info(priv->dev, "Device link is up.\n");
 		netif_carrier_on(priv->dev);
 	} else {
@@ -1510,7 +1510,6 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 {
 	struct bpf_prog *old_prog;
 	int err = 0;
-	u32 status;
 
 	old_prog = READ_ONCE(priv->xdp_prog);
 	if (!netif_running(priv->dev)) {
@@ -1537,8 +1536,8 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 		bpf_prog_put(old_prog);
 
 out:
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	priv->ctrl_ops->report_link_status(priv);
+	gve_handle_link_status(priv);
 	return err;
 }
 
@@ -1971,11 +1970,11 @@ static void gve_turnup(struct gve_priv *priv)
 
 static void gve_turnup_and_check_status(struct gve_priv *priv)
 {
-	u32 status;
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 
 	gve_turnup(priv);
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	ops->report_link_status(priv);
+	gve_handle_link_status(priv);
 }
 
 static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
@@ -2299,12 +2298,14 @@ static void gve_service_task(struct work_struct *work)
 {
 	struct gve_priv *priv = container_of(work, struct gve_priv,
 					     service_task);
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	u32 status = ioread32be(&priv->reg_bar0->device_status);
 
 	gve_handle_status(priv, status);
 
 	gve_handle_reset(priv);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	ops->report_link_status(priv);
+	gve_handle_link_status(priv);
 }
 
 static void gve_set_netdev_xdp_features(struct gve_priv *priv)
@@ -2427,6 +2428,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
 	.create_queues		= gve_adminq_create_queues,
 	.destroy_queues		= gve_adminq_destroy_queues,
+	.report_link_status	= gve_adminq_report_link_status,
+	.report_link_speed	= gve_adminq_report_link_speed,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.54.0.669.g59709faab0-goog

