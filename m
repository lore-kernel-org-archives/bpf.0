Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744A3D75B1
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673675; cv=none; b=ccpYH+3BCSvjovI366FnhJi2lb2qfp5JhSxRqSFH8MjSTozybyAVDaobV9/wQJ2NL3XcUjXtNTlDUDXHtpa6Nqomsn7QmhUlP0RSsu9cPSJvEpoqb+PjMQIZkGsKDwKrw/OOiW+jABH3iB1i6HYFhNO4MVZbmmrKLnfiboJcx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673675; c=relaxed/simple;
	bh=NCpwjVPjlMPsM91T2QgrTjtP3BjIHnln4ovEjyabKBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nLkerhPxVrCJ8/S3ex0i8WmvrPYHFyQpK1F5cu0Jj2kph5rkasnG4EOP7lzE3yeqqHc3v8Qr/UoxCzWY+T9nTUyiV0bNtdQfXhg1lbzKSe4msiAeuL/yEam8f4lLsZy67sRRR4KejS0Z4yHYgOECmmcPdmP73uA86RpFU2+ZzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkkRYISp; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkkRYISp"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e1da97175so562780b3a.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673667; x=1787278467; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tCdOBT+BhSrkeNnE1ykogS5Jh+RjYtvRtAQGSluNWF4=;
        b=GkkRYISpx5n5HHilnKOe97al4nDrkLo5u57gbpZZC+7LtlW12KoSPW+u4Nw2/iyzig
         5MVKT/G7Ok1FIpIMOfuAOeRtC73jk1BiCKliauW1S3wBGek+61s7pLNuzL/v/ppn1GCI
         sUvMJLkISAhHlaTBI+xJKoRwz7oi/kRo9uyAFqftJRIwyUAClwO7hvfRNGtuToI8jaaA
         JRBonhtyABpkAZYQPQN7TFryDa/QWRWBfssMFcLTOKqHoXO9C25cLd+0qvAQL309n6R3
         CcO9TgBuVv4qjrPkCK6jKVKlsGV4L5r05DZ9ywVQeBp8lI4J4sH0onQgM43qtoUsW/8O
         rm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673667; x=1787278467;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCdOBT+BhSrkeNnE1ykogS5Jh+RjYtvRtAQGSluNWF4=;
        b=cBg4o6RLs83yom4OUE14t3hgYsw/4XL5/Tr/7vD8fefKpIZojVTDIkVll3vVlJ2jB4
         nuDwh2DtzRYBoZIAPHUX6yiURJGgrn2AofB7xytXTuc9niM+fOx/Q22G45qeXVJaz93J
         ED886ZaTtRiWNc8mtfGotwhOCFs5pvb0tQwbc6jDOmSqY9cyss7svHG5Qfhwfdb6bsS6
         bpyzNLC+gSh6sALni/wJ6AipH+lINM+dCQrXwlLFQrDbH79KRYPYQz+aIODNV3l0XBrV
         NzOAUz3yJ8iGNENKbv6v20u47VR4T7kw6xyuP/s6zryQpXspfmPSQwv+/F9L1MNGL4y0
         Zgfg==
X-Forwarded-Encrypted: i=1; AHgh+RolLcQ5XLAdmCD5aWGHda0Cu284jdhkG5lu2dSUAbeFmK0Gv7QGpnLJBgLP+uK+JBe1Edo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQ6vaf/VGprr2/9Uwf481ba3URhFUtH0qztakNhL1gPZLHtfm
	450hlqyAGmIWe2Xwkbxr28yfZz2754wTWICu1MlADThASEYhCPmRTLb6JJG4PQy1ihbNHljN5Ll
	nZH5jSuvApcLfle4F2TmLZPyPFA==
X-Received: from pfux38.prod.google.com ([2002:a05:6a00:be6:b0:847:878f:44f0])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2308:b0:84a:60a4:2651 with SMTP id d2e1a72fcca58-84fddfa84f0mr2283390b3a.6.1786673666613;
 Thu, 13 Aug 2026 19:14:26 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:13:59 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-10-hramamurthy@google.com>
Subject: [PATCH net-next v4 09/15] gve: simplify reset logic
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

From: Joshua Washington <joshwash@google.com>

Current GVE reset logic is quite complex, with a number of methods with
similar names and functionalities. This complexity has allowed a number
of bugs to enter the reset/recovery path, including the potential for
reset loops if an operation fails during teardown.

Simplify the reset path by doing the following:
1) Removing recursive resets. Recursive resets have two major issues.
   First, there is the potential for stack overflows if resets are
   invoked too many times in a row. Second, long recursive calls mean
   that GVE never gives up the RTNL lock, or at the very least holds it
   for too long. If a reset must occur anywhere during the
   reset/recovery path, it should be scheduled as a separate task.
2) Removing resets during teardown. This is partly covered by removing
   recursive resets, but the primary goal in this case is to ensure that
   the driver is capable of actually executing a hardware reset if
   something goes wrong with a control plane operation. As it stands, if
   `deconfigure_device_resources` fails, for example, GVE will preempt
   its reset with another reset without actually invoking a hardware
   reset, which could actually help with recovery.
3) Decompose allocation/de-allocation and setup/teardown. Performing
   allocation and setup for each control plane system (RSS, ptype map,
   etc) leaves many more error conditions to handle, causing teardown in
   the case of failures to be much more complex than they need to be.
   This will also be useful to better align a major behavioral change
   in mailbox mode, which will use separate response buffers instead to
   get data from the device instead of a pre-allocated shared memory
   region.

With the new reset functionality, shared resources between the device
and driver are not freed until after the hardware reset has completed
in the event that `deconfigure_device_resources` fails, meaning that the
device could potentially still be holding on to shared memory.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v4:
  - fix kdoc formatting for gve_teardown_control_plane_resources
  - ignore management interrupt if device is not okay

v3:
 - only reset when failing to program flow rules as ethtool op
 - don't attempt to teardown rings in reset path if AQ is not allocated
 - fix work queue semantics related to management IRQ handler

v2:
  - Fixed typos in commit message (recursive, preempt)
  - Fixed a kdoc warning
 drivers/net/ethernet/google/gve/gve.h         |   2 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  |   9 +-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   1 -
 drivers/net/ethernet/google/gve/gve_ethtool.c |   2 +-
 .../net/ethernet/google/gve/gve_flow_rule.c   |  15 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 359 +++++++++---------
 6 files changed, 204 insertions(+), 184 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 143c666fcebd..7d40267b0672 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1350,7 +1350,7 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
 
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
-int gve_reset(struct gve_priv *priv, bool attempt_teardown);
+int gve_reset(struct gve_priv *priv, bool skip_queue_setup);
 void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
 			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index fda752f09a66..7e5a6f4110db 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -363,7 +363,7 @@ int gve_adminq_init(struct gve_priv *priv)
 	return gve_adminq_alloc(priv);
 }
 
-void gve_adminq_release(struct gve_priv *priv)
+static void gve_adminq_release(struct gve_priv *priv)
 {
 	int i = 0;
 
@@ -392,7 +392,6 @@ void gve_adminq_release(struct gve_priv *priv)
 	}
 	gve_clear_device_rings_ok(priv);
 	gve_clear_device_resources_ok(priv);
-	gve_clear_admin_queue_ok(priv);
 }
 
 void gve_adminq_free(struct gve_priv *priv)
@@ -1375,12 +1374,8 @@ gve_adminq_configure_flow_rule(struct gve_priv *priv,
 			sizeof(struct gve_adminq_configure_flow_rule),
 			flow_rule_cmd);
 
-	if (err == -ETIME) {
-		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
-		gve_reset(priv, true);
-	} else if (!err) {
+	if (!err)
 		priv->flow_rules_cache.rules_cache_synced = false;
-	}
 
 	return err;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 78eee3b5cb7f..fe1e8868cdfe 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -621,7 +621,6 @@ static_assert(sizeof(union gve_adminq_command) == 64);
 
 int gve_adminq_init(struct gve_priv *priv);
 void gve_adminq_free(struct gve_priv *priv);
-void gve_adminq_release(struct gve_priv *priv);
 int gve_adminq_describe_device(struct gve_priv *priv);
 int gve_adminq_configure_device_resources(struct gve_priv *priv,
 					  dma_addr_t counter_array_bus_addr,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 8199738ba979..dd1c44fedc77 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -651,7 +651,7 @@ static int gve_user_reset(struct net_device *netdev, u32 *flags)
 
 	if (*flags == ETH_RESET_ALL) {
 		*flags = 0;
-		return gve_reset(priv, true);
+		return gve_reset(priv, false);
 	}
 
 	return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/google/gve/gve_flow_rule.c b/drivers/net/ethernet/google/gve/gve_flow_rule.c
index 2c80cda28ef3..fae552f4ad6f 100644
--- a/drivers/net/ethernet/google/gve/gve_flow_rule.c
+++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
@@ -278,6 +278,11 @@ int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
 		goto out;
 
 	err = gve_adminq_add_flow_rule(priv, rule, fsp->location);
+	if (err == -ETIME) {
+		dev_err(&priv->pdev->dev,
+			"Timeout to add flow rule, trigger reset.");
+		gve_reset(priv, false);
+	}
 
 out:
 	kvfree(rule);
@@ -290,9 +295,17 @@ int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
 int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
 {
 	struct ethtool_rx_flow_spec *fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
+	int err;
 
 	if (!priv->max_flow_rules)
 		return -EOPNOTSUPP;
 
-	return gve_adminq_del_flow_rule(priv, fsp->location);
+	err = gve_adminq_del_flow_rule(priv, fsp->location);
+	if (err == -ETIME) {
+		dev_err(&priv->pdev->dev,
+			"Timeout to delete flow rule, trigger reset.");
+		gve_reset(priv, false);
+	}
+
+	return err;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index eab5e9cf990a..9fba76059a8f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -271,6 +271,10 @@ static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
 {
 	struct gve_priv *priv = arg;
 
+	/* Device resources are not okay; consider the interrupt spurious. */
+	if (!gve_get_device_resources_ok(priv))
+		return IRQ_NONE;
+
 	queue_work(priv->gve_wq, &priv->service_task);
 	return IRQ_HANDLED;
 }
@@ -591,7 +595,22 @@ static void gve_free_notify_blocks(struct gve_priv *priv)
 	priv->msix_vectors = NULL;
 }
 
-static int gve_setup_device_resources(struct gve_priv *priv)
+static void gve_free_control_plane_resources(struct gve_priv *priv)
+{
+	bitmap_free(priv->xsk_pools);
+	priv->xsk_pools = NULL;
+
+	kvfree(priv->ptype_lut_dqo);
+	priv->ptype_lut_dqo = NULL;
+
+	gve_free_stats_report(priv);
+	gve_free_notify_blocks(priv);
+	gve_free_counter_array(priv);
+	gve_free_rss_config_cache(priv);
+	gve_free_flow_rule_caches(priv);
+}
+
+static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 {
 	int err;
 
@@ -600,16 +619,42 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		return err;
 	err = gve_alloc_rss_config_cache(priv);
 	if (err)
-		goto abort_with_flow_rule_caches;
+		goto abort;
 	err = gve_alloc_counter_array(priv);
 	if (err)
-		goto abort_with_rss_config_cache;
+		goto abort;
 	err = gve_alloc_notify_blocks(priv);
 	if (err)
-		goto abort_with_counter;
+		goto abort;
 	err = gve_alloc_stats_report(priv);
 	if (err)
-		goto abort_with_ntfy_blocks;
+		goto abort;
+
+	if (!gve_is_gqi(priv)) {
+		priv->ptype_lut_dqo = kvzalloc_obj(*priv->ptype_lut_dqo,
+						   GFP_KERNEL);
+		if (!priv->ptype_lut_dqo) {
+			err = -ENOMEM;
+			goto abort;
+		}
+	}
+
+	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
+	if (!priv->xsk_pools) {
+		err = -ENOMEM;
+		goto abort;
+	}
+
+	return 0;
+abort:
+	gve_free_control_plane_resources(priv);
+	return err;
+}
+
+static int gve_setup_control_plane_resources(struct gve_priv *priv)
+{
+	int err = 0;
+
 	err = gve_adminq_configure_device_resources(priv,
 						    priv->counter_array_bus,
 						    priv->num_event_counters,
@@ -619,20 +664,15 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		dev_err(&priv->pdev->dev,
 			"could not setup device_resources: err=%d\n", err);
 		err = -ENXIO;
-		goto abort_with_stats_report;
+		return err;
 	}
 
 	if (!gve_is_gqi(priv)) {
-		priv->ptype_lut_dqo = kvzalloc_obj(*priv->ptype_lut_dqo);
-		if (!priv->ptype_lut_dqo) {
-			err = -ENOMEM;
-			goto abort_with_stats_report;
-		}
 		err = gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lut_dqo);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
-			goto abort_with_ptype_lut;
+			goto deconfigure_device;
 		}
 	}
 
@@ -647,7 +687,7 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
 	if (err) {
 		dev_err(&priv->pdev->dev, "Failed to init RSS config");
-		goto abort_with_clock;
+		goto teardown_clock;
 	}
 
 	err = gve_adminq_report_stats(priv, priv->stats_report_len,
@@ -659,67 +699,64 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	gve_set_device_resources_ok(priv);
 	return 0;
 
-abort_with_clock:
+teardown_clock:
 	gve_teardown_clock(priv);
-abort_with_ptype_lut:
-	kvfree(priv->ptype_lut_dqo);
-	priv->ptype_lut_dqo = NULL;
-abort_with_stats_report:
-	gve_free_stats_report(priv);
-abort_with_ntfy_blocks:
-	gve_free_notify_blocks(priv);
-abort_with_counter:
-	gve_free_counter_array(priv);
-abort_with_rss_config_cache:
-	gve_free_rss_config_cache(priv);
-abort_with_flow_rule_caches:
-	gve_free_flow_rule_caches(priv);
-
+deconfigure_device:
+	gve_adminq_deconfigure_device_resources(priv);
 	return err;
 }
 
-static void gve_trigger_reset(struct gve_priv *priv);
-
-static void gve_teardown_device_resources(struct gve_priv *priv)
+/**
+ * gve_teardown_control_plane_resources() - Request the device to release any
+ * shared allocated resources.
+ *
+ * @priv: Pointer to the GVE private device data structure.
+ *
+ * If any part of the teardown step fails, the failure is documented, but is
+ * otherwise ignored. It is expected that a device reset is triggered
+ * immediately after tearing down device resources, which would clear any
+ * lingering state on the device.
+ */
+static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 {
 	int err;
 
 	/* Tell device its resources are being freed */
 	if (gve_get_device_resources_ok(priv)) {
 		err = gve_flow_rules_reset(priv);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to reset flow rules: err=%d\n", err);
-			gve_trigger_reset(priv);
-		}
 		/* detach the stats report */
 		err = gve_adminq_report_stats(priv, 0, 0x0, GVE_STATS_REPORT_TIMER_PERIOD);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
-			gve_trigger_reset(priv);
-		}
+		gve_teardown_clock(priv);
 		err = gve_adminq_deconfigure_device_resources(priv);
-		if (err) {
+		if (err)
 			dev_err(&priv->pdev->dev,
 				"Could not deconfigure device resources: err=%d\n",
 				err);
-			gve_trigger_reset(priv);
-		}
 	}
 
-	kvfree(priv->ptype_lut_dqo);
-	priv->ptype_lut_dqo = NULL;
-
-	gve_free_flow_rule_caches(priv);
-	gve_free_rss_config_cache(priv);
-	gve_free_counter_array(priv);
-	gve_free_notify_blocks(priv);
-	gve_free_stats_report(priv);
-	gve_teardown_clock(priv);
 	gve_clear_device_resources_ok(priv);
 }
 
+static void gve_teardown_device(struct gve_priv *priv)
+{
+	gve_teardown_control_plane_resources(priv);
+	gve_adminq_free(priv);
+	/*
+	 * Free any resources shared with the device only after we have a
+	 * guarantee that the device will not try to access such resources.
+	 * Device commands in gve_teardown_control_plane_resources can fail, in
+	 * which case, device resources won't be relinquished until
+	 * gve_adminq_free is called to trigger a device reset.
+	 */
+	gve_free_control_plane_resources(priv);
+}
+
 static int gve_unregister_qpl(struct gve_priv *priv,
 			      struct gve_queue_page_list *qpl)
 {
@@ -1158,8 +1195,6 @@ void gve_schedule_reset(struct gve_priv *priv)
 	queue_work(priv->gve_wq, &priv->service_task);
 }
 
-static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up);
-static int gve_reset_recovery(struct gve_priv *priv, bool was_up);
 static void gve_turndown(struct gve_priv *priv);
 static void gve_turnup(struct gve_priv *priv);
 
@@ -1270,11 +1305,12 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 	return err;
 }
 
-
 static void gve_drain_page_cache(struct gve_priv *priv)
 {
 	int i;
 
+	if (!priv->rx)
+		return;
 	for (i = 0; i < priv->rx_cfg.num_queues; i++)
 		page_frag_cache_drain(&priv->rx[i].page_cache);
 }
@@ -1417,10 +1453,11 @@ static int gve_queues_start(struct gve_priv *priv,
 reset:
 	if (gve_get_reset_in_progress(priv))
 		goto stop_and_free_rings;
-	gve_reset_and_teardown(priv, true);
-	/* if this fails there is nothing we can do so just ignore the return */
-	gve_reset_recovery(priv, false);
-	/* return the original error */
+
+	/* Attempt to reset. If reset is successful, gve_queues_start was
+	 * successful.
+	 */
+	err = gve_reset(priv, false);
 	return err;
 stop_and_free_rings:
 	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
@@ -1436,6 +1473,12 @@ static int gve_open(struct net_device *dev)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
+	if (!gve_get_device_resources_ok(priv)) {
+		dev_err(&priv->pdev->dev,
+			"Attempting to open netdev without resources. Device must be reset.");
+		return -ENODEV;
+	}
+
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
 	err = gve_queues_mem_alloc(priv, &tx_alloc_cfg, &rx_alloc_cfg);
@@ -1452,41 +1495,18 @@ static int gve_open(struct net_device *dev)
 	return 0;
 }
 
-static int gve_queues_stop(struct gve_priv *priv)
+static void gve_queues_stop(struct gve_priv *priv)
 {
-	int err;
-
-	netif_carrier_off(priv->dev);
-	if (gve_get_device_rings_ok(priv)) {
-		gve_turndown(priv);
-		gve_drain_page_cache(priv);
-		err = gve_destroy_rings(priv);
-		if (err)
-			goto err;
-		err = gve_unregister_qpls(priv);
-		if (err)
-			goto err;
-		gve_clear_device_rings_ok(priv);
-	}
-	timer_delete_sync(&priv->stats_report_timer);
+	gve_turndown(priv);
 
 	gve_unreg_xdp_info(priv);
+	gve_drain_page_cache(priv);
+
+	timer_delete_sync(&priv->stats_report_timer);
+	cancel_work_sync(&priv->stats_report_task);
 
 	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
 	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
-
-	priv->interface_down_cnt++;
-	return 0;
-
-err:
-	/* This must have been called from a reset due to the rtnl lock
-	 * so just return at this point.
-	 */
-	if (gve_get_reset_in_progress(priv))
-		return err;
-	/* Otherwise reset before returning */
-	gve_reset_and_teardown(priv, true);
-	return gve_reset_recovery(priv, false);
 }
 
 static int gve_close(struct net_device *dev)
@@ -1494,12 +1514,28 @@ static int gve_close(struct net_device *dev)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
-	err = gve_queues_stop(priv);
-	if (err)
-		return err;
+	gve_queues_stop(priv);
+
+	/* Surrender to reset if the queue destroying adminq cmds fail. Reset
+	 * will not re-enable the interface.
+	 */
+	if (gve_get_device_rings_ok(priv)) {
+		gve_clear_device_rings_ok(priv);
+		err = gve_destroy_rings(priv);
+		if (err)
+			goto reset;
+		err = gve_unregister_qpls(priv);
+		if (err)
+			goto reset;
+	}
 
 	gve_queues_mem_remove(priv);
+	priv->interface_down_cnt++;
 	return 0;
+
+reset:
+	err = gve_reset(priv, true);
+	return err;
 }
 
 static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
@@ -2422,25 +2458,17 @@ static int gve_setup_device(struct gve_priv *priv)
 
 	priv->num_registered_pages = 0;
 
-	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
-	if (!priv->xsk_pools) {
-		err = -ENOMEM;
-		goto err;
-	}
-
 	gve_set_netdev_xdp_features(priv);
 	if (!gve_is_gqi(priv))
 		priv->dev->xdp_metadata_ops = &gve_xdp_metadata_ops;
 
-	err = gve_setup_device_resources(priv);
+	err = gve_alloc_control_plane_resources(priv);
 	if (err)
-		goto err_free_xsk_bitmap;
-
+		goto err;
+	err = gve_setup_control_plane_resources(priv);
+	if (err)
+		goto err;
 	return 0;
-
-err_free_xsk_bitmap:
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
 err:
 	return err;
 }
@@ -2515,93 +2543,81 @@ static int gve_init_priv(struct gve_priv *priv)
 	return 0;
 }
 
-static void gve_teardown_priv_resources(struct gve_priv *priv)
-{
-	gve_teardown_device_resources(priv);
-	gve_adminq_free(priv);
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
-}
-
-static void gve_trigger_reset(struct gve_priv *priv)
-{
-	/* Reset the device by releasing the AQ */
-	gve_adminq_release(priv);
-}
-
-static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up)
-{
-	gve_trigger_reset(priv);
-	/* With the reset having already happened, close cannot fail */
-	if (was_up)
-		gve_close(priv->dev);
-	gve_teardown_priv_resources(priv);
-}
-
-static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
+static int gve_recover(struct gve_priv *priv, bool setup_queues)
 {
+	bool service_task_enabled = false;
 	int err;
 
 	err = gve_adminq_init(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Failed to alloc admin queue: err=%d\n", err);
-		goto err;
+		goto teardown_device;
 	}
 
 	err = gve_adminq_verify_driver_compatibility(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not verify driver compatibility: err=%d\n", err);
-		goto err_free_adminq;
+		goto teardown_device;
 	}
 
 	err = gve_setup_device(priv);
 	if (err)
-		goto err_free_adminq;
-	if (was_up) {
+		goto teardown_device;
+
+	/* In the case of cascading failures, the disable count could be greater
+	 * than 1. The service task must be enabled before starting queues.
+	 */
+	while (!service_task_enabled)
+		service_task_enabled = enable_work(&priv->service_task);
+
+	if (setup_queues) {
 		err = gve_open(priv->dev);
 		if (err)
-			return err;
+			goto disable_work;
 	}
+
 	return 0;
 
-err_free_adminq:
-	gve_adminq_free(priv);
-err:
-	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
-	gve_turndown(priv);
+disable_work:
+	disable_work(&priv->service_task);
+teardown_device:
+	dev_err(&priv->pdev->dev, "Recover failed! !!! DISABLING ALL QUEUES !!!\n");
+	gve_teardown_device(priv);
 	return err;
 }
 
-int gve_reset(struct gve_priv *priv, bool attempt_teardown)
+int gve_reset(struct gve_priv *priv, bool skip_queue_setup)
 {
 	bool was_up = netif_running(priv->dev);
 	int err;
 
+	if (gve_get_reset_in_progress(priv))
+		return 0;
+
 	dev_info(&priv->pdev->dev, "Performing reset\n");
 	gve_clear_do_reset(priv);
 	gve_set_reset_in_progress(priv);
-	/* If we aren't attempting to teardown normally, just go turndown and
-	 * reset right away.
-	 */
-	if (!attempt_teardown) {
-		gve_turndown(priv);
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* Otherwise attempt to close normally */
-		if (was_up) {
-			err = gve_close(priv->dev);
-			/* If that fails reset as we did above */
-			if (err)
-				gve_reset_and_teardown(priv, was_up);
+
+	if (was_up) {
+		gve_queues_stop(priv);
+		if (gve_get_device_rings_ok(priv)) {
+			gve_clear_device_rings_ok(priv);
+			gve_destroy_rings(priv);
+			gve_unregister_qpls(priv);
 		}
-		/* Clean up any remaining resources */
-		gve_teardown_priv_resources(priv);
 	}
 
-	/* Set it all back up */
-	err = gve_reset_recovery(priv, was_up);
+	disable_work(&priv->service_task);
+	gve_teardown_device(priv);
+	gve_queues_mem_remove(priv);
+
+	err = gve_recover(priv, was_up && !skip_queue_setup);
+	if (err)
+		dev_info(&priv->pdev->dev,
+			 "Failed to recover in reset: %d\n", err);
+
 	gve_clear_reset_in_progress(priv);
 	priv->reset_cnt++;
 	priv->interface_up_cnt = 0;
@@ -2933,7 +2949,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup device: err=%d\n", err);
-		goto abort_with_wq;
+		goto abort_teardown_device;
 	}
 
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
@@ -2941,7 +2957,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = register_netdev(dev);
 	if (err)
-		goto abort_with_gve_init;
+		goto abort_teardown_device;
 
 	dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
 	dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_format);
@@ -2949,8 +2965,9 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	queue_work(priv->gve_wq, &priv->service_task);
 	return 0;
 
-abort_with_gve_init:
-	gve_teardown_priv_resources(priv);
+abort_teardown_device:
+	disable_work(&priv->stats_report_task);
+	gve_teardown_device(priv);
 
 abort_with_wq:
 	destroy_workqueue(priv->gve_wq);
@@ -2982,7 +2999,8 @@ static void gve_remove(struct pci_dev *pdev)
 	void __iomem *reg_bar = priv->reg_bar0;
 
 	unregister_netdev(netdev);
-	gve_teardown_priv_resources(priv);
+	disable_work_sync(&priv->service_task);
+	gve_teardown_device(priv);
 	destroy_workqueue(priv->gve_wq);
 	priv->ctrl_ops->unmap_db_bar(priv);
 	free_netdev(netdev);
@@ -2998,16 +3016,13 @@ static void gve_shutdown(struct pci_dev *pdev)
 	bool was_up = netif_running(priv->dev);
 
 	netif_device_detach(netdev);
+	disable_work_sync(&priv->service_task);
 
 	rtnl_lock();
 	netdev_lock(netdev);
-	if (was_up && gve_close(priv->dev)) {
-		/* If the dev was up, attempt to close, if close fails, reset */
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* If the dev wasn't up or close worked, finish tearing down */
-		gve_teardown_priv_resources(priv);
-	}
+	if (was_up)
+		gve_close(priv->dev);
+	gve_teardown_device(priv);
 	netdev_unlock(netdev);
 	rtnl_unlock();
 }
@@ -3019,16 +3034,14 @@ static int gve_suspend(struct device *dev)
 	struct gve_priv *priv = netdev_priv(netdev);
 	bool was_up = netif_running(priv->dev);
 
+	disable_work_sync(&priv->service_task);
+
 	priv->suspend_cnt++;
 	rtnl_lock();
 	netdev_lock(netdev);
-	if (was_up && gve_close(priv->dev)) {
-		/* If the dev was up, attempt to close, if close fails, reset */
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* If the dev wasn't up or close worked, finish tearing down */
-		gve_teardown_priv_resources(priv);
-	}
+	if (was_up)
+		gve_close(priv->dev);
+	gve_teardown_device(priv);
 	priv->up_before_suspend = was_up;
 	netdev_unlock(netdev);
 	rtnl_unlock();
@@ -3045,7 +3058,7 @@ static int gve_resume(struct device *dev)
 	priv->resume_cnt++;
 	rtnl_lock();
 	netdev_lock(netdev);
-	err = gve_reset_recovery(priv, priv->up_before_suspend);
+	err = gve_recover(priv, priv->up_before_suspend);
 	netdev_unlock(netdev);
 	rtnl_unlock();
 	return err;
-- 
2.55.0.691.gc56d675ccc-goog

