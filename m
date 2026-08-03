Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0F43C05D
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782814; cv=none; b=XOyBFPeCvS3WOaJiq1oogTncpmLC4xncVuWAA2SUX1LEJVI0wwk3e4LkqvWNj45R+4G0pjZTV9kloYbyZ/vsqEaTNy0ZsRKK/FLJl8Oyw8AVriXafAPUjL0sZqAk2ZZqsTUgYwe1YeV86BWYhA1driR0kTkBJwpuZklcarusb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782814; c=relaxed/simple;
	bh=+5keIfq+ahGjGb23E34eAMBpGZbIe+0PkejsdNponjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cOcaVQLOxKuLeNebOE/bvbec7UoSMNtIoIIzmlZUmYE5dN+Nz3E1OLkjOMq+hqd+fF9YsQF26klxNtuk3mxuB4X12fHRY1Xg/PAHyuqo5zSBe+wVodzjFTOimI766KtyBfYRH7b+WGjPmLD7KxfJ3iL+U6oDno6aJz6Ox/lZh7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjgFgxM2; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjgFgxM2"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so6512741a91.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782809; x=1786387609; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cw3abLLZFYPMN/Q20aJiudIzDZfANzTR+tzIkHl7qzg=;
        b=gjgFgxM2dDXovNc7p/JLjANNzHnbt/S/yh0aBLdV6Z2R8XI477HASIx6ygntorMrjw
         d3/8IghTkyEA0hVHMjXYXjGnsrMvHPTuJy0STUTBAs0Y4fSsI2i0mJM3IS7mgOqKjFa2
         VTHxQegL3aSnU8H+9fbGvAwz7wMeuj2f7urDaqmJtNrFtJ4zCsUN5wzfZnY41n+7d8PN
         ot/w2v8qRf43oRCSMq7gFRN14INCScc5XSTSWatDf/ZddFtwZiZ4TouAqZ1Q9Jwi1fF4
         uaUcT4yAHjI/en4I3OAVf45ofCyHhkLYAZCgWKHe9+AnzRYbnOGZ+0VF+AN80igkMvsq
         HS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782809; x=1786387609;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cw3abLLZFYPMN/Q20aJiudIzDZfANzTR+tzIkHl7qzg=;
        b=ASMBSqMwIAK/X4E+ARLRP3ODEo2hgtdO9WzDecGfhytTs3cOfRt02XVELCtiV492/o
         ZVEh/pVXKGBQtCmQjDz5+ZH3EGsbYNHfcomHX96AsK43UgkFWm2+0M2KZIidpMFNPOCY
         AxEqKle0ZFWtbUy8/x/MJnurSWzF46j5q9C9l9TQlUFZP1HLVsNjtwZ2Ds+YS3R4XI1y
         mu/wA31LsR+YzCboPM5coBHhOfWN7DzitiCAUg8lPJK95iwjpVkAKdfoH7OupoIfn/K1
         Aqs+MwYcCED8PFfYiTJr5G+leU8+MtyohKQUKVewKmr+XM6cxZ3FdqaJn8vAFxmUl1vS
         qMTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQgI29XnpkGk39nOAzjQNNxJxSSCPUDbQbq18EKbbzi5XU2AHxls1EmXuSDJkDWSPfeYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nhCzSuAlo9x63dNdW9p36m5nsk1JJwFmYdsyHDyZjTiZsDn3
	LHBbbcsV3+NfF0o7/PG06d6C+XdFBjk3DzxrKvYJPtKqV2WIQRpzUUhq1cCCfcRtRA25sJTQngq
	GOnlsjJb2n2YSNAttykz2+s7F7A==
X-Received: from pjuu7.prod.google.com ([2002:a17:90b:5867:b0:38d:f003:cd24])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57e6:b0:38d:e658:5959 with SMTP id 98e67ed59e1d1-38fbc3e596cmr10248328a91.5.1785782805278;
 Mon, 03 Aug 2026 11:46:45 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:30 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-16-hramamurthy@google.com>
Subject: [PATCH net-next v3 15/15] gve: add link status/speed ctrl ops
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
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
Changes in v3:
  - Fix kdoc typo ("set link status" -> "set link speed")
  - Copy link speed into local variable instead of reading twice to
    prevent TOCTOU issue.

 drivers/net/ethernet/google/gve/gve.h         |  5 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c  | 10 +++++++
 drivers/net/ethernet/google/gve/gve_adminq.h  |  1 +
 drivers/net/ethernet/google/gve/gve_ethtool.c |  3 +--
 drivers/net/ethernet/google/gve/gve_main.c    | 26 ++++++++++++-------
 5 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 38b93238e2ca..8e34e9f75006 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -846,6 +846,8 @@ struct gve_device_info {
  * @reset_flow_rules: Flush all flow rules from device
  * @create_queues: Sends commands to the device to create TX/RX queues.
  * @destroy_queues: Sends commands to the device to destroy TX/RX queues.
+ * @report_link_status: Set link status into @priv->link_up
+ * @report_link_speed: Set link speed into @priv->link_speed
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
@@ -967,6 +971,7 @@ struct gve_priv {
 
 	/* Gvnic device link speed from hypervisor. */
 	u64 link_speed;
+	bool link_up;
 	bool up_before_suspend; /* True if dev was up before suspend */
 
 	bool mgmt_irq_requested;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b04968257355..fe975d1547b2 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1834,3 +1834,13 @@ int gve_adminq_create_queues(struct gve_priv *priv)
 
 	return err;
 }
+
+int gve_adminq_report_link_status(struct gve_priv *priv)
+{
+	u32 status;
+
+	status = ioread32be(&priv->reg_bar0->device_status);
+	WRITE_ONCE(priv->link_up,
+		   !!(GVE_DEVICE_STATUS_LINK_STATUS_MASK & status));
+	return 0;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 03e8318f7327..82413369dec9 100644
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
index dd1c44fedc77..a3220c651438 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -749,12 +749,11 @@ static int gve_get_link_ksettings(struct net_device *netdev,
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
index 484f5a54a408..19e4b56238a0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1502,15 +1502,18 @@ static int gve_close(struct net_device *dev)
 	return err;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
+static void gve_handle_link_status(struct gve_priv *priv)
 {
+	bool link_up;
+
 	if (!gve_get_napi_enabled(priv))
 		return;
 
-	if (link_status == netif_carrier_ok(priv->dev))
+	link_up = READ_ONCE(priv->link_up);
+	if (link_up == netif_carrier_ok(priv->dev))
 		return;
 
-	if (link_status) {
+	if (link_up) {
 		netdev_info(priv->dev, "Device link is up.\n");
 		netif_carrier_on(priv->dev);
 	} else {
@@ -1537,7 +1540,6 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 {
 	struct bpf_prog *old_prog;
 	int err = 0;
-	u32 status;
 
 	old_prog = READ_ONCE(priv->xdp_prog);
 	if (!netif_running(priv->dev)) {
@@ -1564,8 +1566,8 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 		bpf_prog_put(old_prog);
 
 out:
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	priv->ctrl_ops->report_link_status(priv);
+	gve_handle_link_status(priv);
 	return err;
 }
 
@@ -1998,11 +2000,11 @@ static void gve_turnup(struct gve_priv *priv)
 
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
@@ -2326,12 +2328,14 @@ static void gve_service_task(struct work_struct *work)
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
@@ -2456,6 +2460,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
 	.create_queues		= gve_adminq_create_queues,
 	.destroy_queues		= gve_adminq_destroy_queues,
+	.report_link_status	= gve_adminq_report_link_status,
+	.report_link_speed	= gve_adminq_report_link_speed,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.571.g244d577d93-goog

