Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FAF568FB4
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577754; cv=none; b=t2jRWaxye+EnfATT/UeVu86iFeS0GRVw+bNj0aL+BzEcVvFIm/rgyHjweIV46G/nXQlQ0drSZGPrGW0+KbkTpWoE/juo97HoB/Hn/yMY7H65Xg4z2eE5sVoJWjy1jn0BbUemcvu4NUZx6D9GdhacagUJbPoMjno4PlYwMiJb2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577754; c=relaxed/simple;
	bh=z4MNQk1nuZNuMES1vu0jTgxi0dj/53DpyMPaABl0QB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fsm6qSXBwwXPX2pA4M2J7bv8pAIHuXeyPSL2sajxd3G/haZrTsGmrx7yn0DyLkVmU0JnnOqA5J7S6lQ4CTZB2TFLCAcCIVYM4zobGNc4FqfqjgxctSFl4wj4h7MSeMhoRYmJ1YsUi4BAcOsrgfd/L4aaV15iY9qZ1DF8G+ueU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpgtf+qU; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpgtf+qU"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e087a17dfso3155571a91.3
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789577744; x=1790182544; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrhIyYKafH+SLk1HGYmsmcC0rir+08lDLQHz4b3Fexo=;
        b=vpgtf+qUOvjGAOUBUdF1hSfisOvvKjtUtxab6CjJMIsn2Hi0iQVd+IaGGC2xvpArYz
         akoqlag9X68DjRfKVQJfDNYbA7PuH5Ayx9FaPgSYbWJ7qU19QSI/Xn06PttM2NUfBEUW
         R9KHCHGcAHcYlYRBiV1rJ3g7UpKhX5s8jgsHigW6JZxtLT9fCyF5a6lncZHtt1u0HVh0
         p+KsG5dQK2nbNp6ONgy5IXWB7kuP9uplRskbLE/H51QO9qMX0DHzKUyirzCcdsE8Tcho
         MMHMvpIc9NwkHg43nlZPWCJ5Qk68/8LomYdmaoc4zUxVNOroMdQSvYowNwpuW4W2POmK
         vKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577744; x=1790182544;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BrhIyYKafH+SLk1HGYmsmcC0rir+08lDLQHz4b3Fexo=;
        b=ZOnHNrFhrPP86HewL8qvTGSfcgHRH3kD6PIRxg7NohyMAa+lZddus5u24nNm29hI7M
         Q8UDUtGS63M7h7F12UQ09iPqTrzR019lJ/wuEFFtB85hohg9rg+iml6YRneRvXu781Tv
         sXbhgifffP9nkQ9+onkMOtCPMv5DxUrMJVhm78qjED4ooLHrfNiLnCLB57xOrccnVRus
         ud7rM12yF3UviVHanY9xwilc+PzSq/xlW/g7eZGPU7QChMMVmvNf88m/Hfof8TUKFobp
         /UbmCNTvh3A9Qk7C2kDlcuHCbtvfrxc6ZcEfuZY6t6ZGr0ZIXDUuKU9yoaD8oV3Jlbr7
         SxUw==
X-Forwarded-Encrypted: i=1; AKwUvBzn6svNgSHGbiem9FoTgWzcLL7kViDywU/9NXaBQNJKSgt1LQHGDYzw2FvDT09M9o4t9Ws=@vger.kernel.org
X-Gm-Message-State: AFuF++lfWhqA/kuxyJXupbe/Nd/WVji8dW5U1Cp+Xg+rPTkBVzmYdaj9
	pEwNqw+2c1TkPCU7djqdnzPDi5tr0gXaN3tTPhYBNBhf7gjbpOXuv/H868nc4TSJG4OkRvrkyNk
	Ccln1Dh8sLEAeO+t+qHiojRRYEA==
X-Received: from pjgw21.prod.google.com ([2002:a17:90a:4615:b0:39e:2b81:112b])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:274a:b0:39d:f2a1:31 with SMTP id 98e67ed59e1d1-39e1e489a60mr7671982a91.17.1789577743484;
 Wed, 16 Sep 2026 09:55:43 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:55:27 +0000
In-Reply-To: <20260916165533.2187434-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916165533.2187434-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916165533.2187434-7-hramamurthy@google.com>
Subject: [PATCH net-next v7 06/12] gve: simplify reset logic
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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v7:
- Return IRQ_HANDLED instead of IRQ_NONE in gve_mgmnt_intr()
- disable service task instead of stats report task for gve_probe() error
- cancel stats report in gve_free_stats_report()
- extract gve_teardown_control_plane_resouces() and gve_adminq_free() into
  new function gve_reset_device() to ensure the device reset is triggered before
  stopping queues
- don't call gve_queues_stop() in the gve_close() error path since the
  gve_reset() takes care of that.

v5:
- fix workqueue disable count imbalance in reset and suspend path (Sashiko)
- destroy rings before stopping queues (Sashiko)
- ensure to call gve_queues_stop in error path in gve_close()
- pull out gve_turndown out of gve_queues_stop so the ordering of
  gve_turndown(stop NAPIs) -> gve_destroy_rings -> gve_queues_stop(free rings) can be preserved

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
 drivers/net/ethernet/google/gve/gve_main.c    | 364 +++++++++---------
 6 files changed, 210 insertions(+), 183 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 48cc8a6be186..026d685ecaee 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1348,7 +1348,7 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
 
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
-int gve_reset(struct gve_priv *priv, bool attempt_teardown);
+int gve_reset(struct gve_priv *priv, bool skip_queue_setup);
 void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
 			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index a62cb7a921d0..901673d2e264 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -365,7 +365,7 @@ int gve_adminq_init(struct gve_priv *priv)
 	return gve_adminq_alloc(priv);
 }
 
-void gve_adminq_release(struct gve_priv *priv)
+static void gve_adminq_release(struct gve_priv *priv)
 {
 	int i = 0;
 
@@ -394,7 +394,6 @@ void gve_adminq_release(struct gve_priv *priv)
 	}
 	gve_clear_device_rings_ok(priv);
 	gve_clear_device_resources_ok(priv);
-	gve_clear_admin_queue_ok(priv);
 }
 
 void gve_adminq_free(struct gve_priv *priv)
@@ -1377,12 +1376,8 @@ gve_adminq_configure_flow_rule(struct gve_priv *priv,
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
index 2fe280cf7e68..82bf2c5fed3f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -261,6 +261,7 @@ static void gve_free_stats_report(struct gve_priv *priv)
 		return;
 
 	timer_delete_sync(&priv->stats_report_timer);
+	cancel_work_sync(&priv->stats_report_task);
 	dma_free_coherent(&priv->pdev->dev, priv->stats_report_len,
 			  priv->stats_report, priv->stats_report_bus);
 	priv->stats_report = NULL;
@@ -270,6 +271,10 @@ static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
 {
 	struct gve_priv *priv = arg;
 
+	/* Device resources are not okay; consider the interrupt spurious. */
+	if (!gve_get_device_resources_ok(priv))
+		return IRQ_HANDLED;
+
 	queue_work(priv->gve_wq, &priv->service_task);
 	return IRQ_HANDLED;
 }
@@ -590,7 +595,22 @@ static void gve_free_notify_blocks(struct gve_priv *priv)
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
 
@@ -599,16 +619,42 @@ static int gve_setup_device_resources(struct gve_priv *priv)
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
@@ -618,20 +664,15 @@ static int gve_setup_device_resources(struct gve_priv *priv)
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
 
@@ -646,7 +687,7 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
 	if (err) {
 		dev_err(&priv->pdev->dev, "Failed to init RSS config");
-		goto abort_with_clock;
+		goto teardown_clock;
 	}
 
 	err = gve_adminq_report_stats(priv, priv->stats_report_len,
@@ -658,67 +699,76 @@ static int gve_setup_device_resources(struct gve_priv *priv)
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
 
+/**
+ * gve_reset_device() - Reset the device
+ *
+ * @priv: Pointer to the GVE private device data structure.
+ *
+ * Once this returns, the device is guaranteed not to access any memory it
+ * shares with the driver, so it is safe for the caller to recycle it. Device
+ * commands in gve_teardown_control_plane_resources() can fail, in which case
+ * the hardware reset triggered by gve_adminq_free() is the only such
+ * guarantee.
+ */
+static void gve_reset_device(struct gve_priv *priv)
+{
+	gve_teardown_control_plane_resources(priv);
+	gve_adminq_free(priv);
+}
+
+static void gve_teardown_device(struct gve_priv *priv)
+{
+	gve_reset_device(priv);
+	/* Free any resources shared with the device only after we have a
+	 * guarantee that the device will not try to access such resources.
+	 */
+	gve_free_control_plane_resources(priv);
+}
+
 static int gve_unregister_qpl(struct gve_priv *priv,
 			      struct gve_queue_page_list *qpl)
 {
@@ -1157,8 +1207,6 @@ void gve_schedule_reset(struct gve_priv *priv)
 	queue_work(priv->gve_wq, &priv->service_task);
 }
 
-static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up);
-static int gve_reset_recovery(struct gve_priv *priv, bool was_up);
 static void gve_turndown(struct gve_priv *priv);
 static void gve_turnup(struct gve_priv *priv);
 
@@ -1269,11 +1317,12 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
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
@@ -1416,10 +1465,11 @@ static int gve_queues_start(struct gve_priv *priv,
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
@@ -1435,6 +1485,12 @@ static int gve_open(struct net_device *dev)
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
@@ -1451,41 +1507,16 @@ static int gve_open(struct net_device *dev)
 	return 0;
 }
 
-static int gve_queues_stop(struct gve_priv *priv)
+static void gve_queues_stop(struct gve_priv *priv)
 {
-	int err;
+	gve_unreg_xdp_info(priv);
+	gve_drain_page_cache(priv);
 
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
 	timer_delete_sync(&priv->stats_report_timer);
-
-	gve_unreg_xdp_info(priv);
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
@@ -1493,12 +1524,29 @@ static int gve_close(struct net_device *dev)
 	struct gve_priv *priv = netdev_priv(dev);
 	int err;
 
-	err = gve_queues_stop(priv);
-	if (err)
-		return err;
+	gve_turndown(priv);
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
 
+	gve_queues_stop(priv);
 	gve_queues_mem_remove(priv);
+	priv->interface_down_cnt++;
 	return 0;
+
+reset:
+	err = gve_reset(priv, true);
+	return err;
 }
 
 static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
@@ -2421,25 +2469,17 @@ static int gve_setup_device(struct gve_priv *priv)
 
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
@@ -2514,30 +2554,7 @@ static int gve_init_priv(struct gve_priv *priv)
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
 	int err;
 
@@ -2545,62 +2562,67 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
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
+	if (setup_queues) {
 		err = gve_open(priv->dev);
 		if (err)
-			return err;
+			goto teardown_device;
 	}
+
 	return 0;
 
-err_free_adminq:
-	gve_adminq_free(priv);
-err:
-	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
-	gve_turndown(priv);
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
+
+	if (was_up) {
 		gve_turndown(priv);
-		gve_reset_and_teardown(priv, was_up);
-	} else {
-		/* Otherwise attempt to close normally */
-		if (was_up) {
-			err = gve_close(priv->dev);
-			/* If that fails reset as we did above */
-			if (err)
-				gve_reset_and_teardown(priv, was_up);
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
+	gve_reset_device(priv);
+	gve_queues_stop(priv);
+	gve_queues_mem_remove(priv);
+	gve_free_control_plane_resources(priv);
+
+	enable_work(&priv->service_task);
+	err = gve_recover(priv, was_up && !skip_queue_setup);
+	if (err)
+		dev_info(&priv->pdev->dev,
+			 "Failed to recover in reset: %d\n", err);
+
 	gve_clear_reset_in_progress(priv);
 	priv->reset_cnt++;
 	priv->interface_up_cnt = 0;
@@ -2927,7 +2949,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup device: err=%d\n", err);
-		goto abort_with_wq;
+		goto abort_teardown_device;
 	}
 
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
@@ -2935,7 +2957,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = register_netdev(dev);
 	if (err)
-		goto abort_with_gve_init;
+		goto abort_teardown_device;
 
 	dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
 	dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_format);
@@ -2943,8 +2965,9 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	queue_work(priv->gve_wq, &priv->service_task);
 	return 0;
 
-abort_with_gve_init:
-	gve_teardown_priv_resources(priv);
+abort_teardown_device:
+	disable_work_sync(&priv->service_task);
+	gve_teardown_device(priv);
 
 abort_with_wq:
 	destroy_workqueue(priv->gve_wq);
@@ -2976,7 +2999,8 @@ static void gve_remove(struct pci_dev *pdev)
 	void __iomem *reg_bar = priv->reg_bar0;
 
 	unregister_netdev(netdev);
-	gve_teardown_priv_resources(priv);
+	disable_work_sync(&priv->service_task);
+	gve_teardown_device(priv);
 	destroy_workqueue(priv->gve_wq);
 	priv->ctrl_ops->unmap_db_bar(priv);
 	free_netdev(netdev);
@@ -2992,16 +3016,13 @@ static void gve_shutdown(struct pci_dev *pdev)
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
@@ -3013,16 +3034,14 @@ static int gve_suspend(struct device *dev)
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
@@ -3039,7 +3058,8 @@ static int gve_resume(struct device *dev)
 	priv->resume_cnt++;
 	rtnl_lock();
 	netdev_lock(netdev);
-	err = gve_reset_recovery(priv, priv->up_before_suspend);
+	enable_work(&priv->service_task);
+	err = gve_recover(priv, priv->up_before_suspend);
 	netdev_unlock(netdev);
 	rtnl_unlock();
 	return err;
-- 
2.55.0.1032.g73a4cd73de-goog

