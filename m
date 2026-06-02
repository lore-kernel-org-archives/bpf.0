Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D43CCFCA
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444748; cv=none; b=B072LvU7CIXBDt9ZZNYXEvjns0N9UaPNN9MwT0/cjLa1SPZ85S+CkwnATez5qhtolCrEs+tyJBxcNKC/phniHHhLa1zmOadMqMFjgvqCmPaD4rWLgQHoz3Z3aaB9VKEDSzHbY+T6pEW2jhZ2e1wTFRFZ4Xt1vpo210rzQdr3RJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444748; c=relaxed/simple;
	bh=jwyRvZ/+qHHJpwn/eKpo09IX4NL3rKOUxSltYeKc8n0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JiJkfRUdsFoLpgN6bXn8gaSSgd4rBzaa/nZlyFzbGkoGNEVaL16sEnxjrMPAQvEXV1vx71akE6/zA/MyV3iWrcfUdTfA42/r1ECw+gunht9dhXqcjjAkwbxyik4enDBqFhSbqUWGzsRKwZQSEwmgYTcLNZDyFJIjJPx7MS7qHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FV/IDnpc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FV/IDnpc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf11699875so1057075ad.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444745; x=1781049545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1UNzlhiTlzST26pj+RRE5Kxk1lz3fpGKLNeH2a+Ysk=;
        b=FV/IDnpcrE6ljFI9irhaDWrlHUQtlr5V/JTM/AVojKKnbG+oQGCTIzBfBiaUyI1GIU
         Xtz+MjzEmOiTab/gFgSnjIqmHrVNpHCV0vciK3ze9Ac/iUwtMg3VjvUCGwnNeWbs6QU/
         X3jqD3ySGHXD8H2DBxEa5I+UC8JC3dhByzUZXXZlimFAh8/H7WPjF9fp+pbY5rFrC2Sk
         t8jo3TInPDkh5whHxoCScoT2AlEJs1OJ3myEbgkX/7GemzxrGVxycKrKfNgJE2pE5Ego
         Io65FxF3O+iEIKLUwfCRMBbbOERX3p3Okb3AAlGGPZBwDoD2TUdf1HAh3XHy6FO+wYKs
         AIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444745; x=1781049545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1UNzlhiTlzST26pj+RRE5Kxk1lz3fpGKLNeH2a+Ysk=;
        b=XykwQjCXburjZ/9EYi3vtgXVFzNPcOuPvns7KsnAnbrJypNg0RGYgtJLplFE759I82
         2NCedAhtsxdSfywwi+5xjmV0k5F9zKvofgPSI3zBj4+R5FxkfJkbq+3E3N/zDWNVhkf2
         x9OQo21sR9cym32+NFmCoA+AWQDtjEB/uhgYx26QjoV4ly/iVa5lKEVnEz/7qN0QYXF+
         9jK0jRRids2gsrDge4bzGinfpuM5Dgjffv3Jn4PUkgmpT9u3zn5DMsuypSC+TyOz8T6v
         b7B/+NHReLKxBT5HQFbEDokMpmjfyuB9GM0Y+v0nV3Y0Hdi0dq5O0CHCk2KD3FsalQ4S
         HInA==
X-Forwarded-Encrypted: i=1; AFNElJ9P+lYenLnhXVpG9D8bERIPTIqOtpFZNyHyz3/nQ8wbDTSwCb8LK4hPPkThkCh1aE4t1Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2GF+N0+WPFDTPhl4H3YmvgupFHBAqEN9cjtr0FUFj54hc6Ou
	WRA+THrj6Zp8r7A03GgHp/Bz2OulS+y1TWCKLk/IVPAcmDySWxy3gbRe6PNUKCJipLb4wyFzRB7
	TAGFhCB/m/Ca28eSBIsINrcqc5w==
X-Received: from plss9.prod.google.com ([2002:a17:902:c649:b0:2bf:1316:821e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2409:b0:2c0:a858:8128 with SMTP id d9443c01a7336-2c1640b37bemr7670815ad.1.1780444744546;
 Tue, 02 Jun 2026 16:59:04 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:47 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-4-hramamurthy@google.com>
Subject: [PATCH net-next v2 03/15] gve: introduce gve_adminq_get_device_properties()
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce gve_adminq_get_device_properties() which executes the first
two Adminq commands: VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE
so that this can be called during initialization.

Move these to Adminq specific files. This is just code movement, no
functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  2 +
 drivers/net/ethernet/google/gve/gve_adminq.c | 66 ++++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h |  5 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 59 +----------------
 4 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 1d66d3834f7e..645175a5dfae 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -15,6 +15,8 @@
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index dfeabddfb396..860d43650c6a 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1144,6 +1144,27 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	return err;
 }
 
+int gve_adminq_get_device_properties(struct gve_priv *priv)
+{
+	int err;
+
+	err = gve_adminq_verify_driver_compatibility(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not verify driver compatibility: err=%d\n", err);
+		return err;
+	}
+
+	/* Get the initial information we need from the device */
+	err = gve_adminq_describe_device(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not get device information: err=%d\n", err);
+		return err;
+	}
+	return 0;
+}
+
 int gve_adminq_register_page_list(struct gve_priv *priv,
 				  struct gve_queue_page_list *qpl)
 {
@@ -1206,20 +1227,53 @@ int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
-int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
-					   u64 driver_info_len,
-					   dma_addr_t driver_info_addr)
+int gve_adminq_verify_driver_compatibility(struct gve_priv *priv)
 {
+	struct gve_driver_info *driver_info;
 	union gve_adminq_command cmd;
+	dma_addr_t driver_info_bus;
+	int err;
+
+	driver_info = dma_alloc_coherent(&priv->pdev->dev,
+					 sizeof(struct gve_driver_info),
+					 &driver_info_bus, GFP_KERNEL);
+	if (!driver_info)
+		return -ENOMEM;
+
+	*driver_info = (struct gve_driver_info) {
+		.os_type = 1, /* Linux */
+		.os_version_major = cpu_to_be32(LINUX_VERSION_MAJOR),
+		.os_version_minor = cpu_to_be32(LINUX_VERSION_SUBLEVEL),
+		.os_version_sub = cpu_to_be32(LINUX_VERSION_PATCHLEVEL),
+		.driver_capability_flags = {
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS1),
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS2),
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS3),
+			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS4),
+		},
+	};
+	strscpy(driver_info->os_version_str1, utsname()->release,
+		sizeof(driver_info->os_version_str1));
+	strscpy(driver_info->os_version_str2, utsname()->version,
+		sizeof(driver_info->os_version_str2));
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode = cpu_to_be32(GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY);
 	cmd.verify_driver_compatibility = (struct gve_adminq_verify_driver_compatibility) {
-		.driver_info_len = cpu_to_be64(driver_info_len),
-		.driver_info_addr = cpu_to_be64(driver_info_addr),
+		.driver_info_len = cpu_to_be64(sizeof(struct gve_driver_info)),
+		.driver_info_addr = cpu_to_be64(driver_info_bus),
 	};
 
-	return gve_adminq_execute_cmd(priv, &cmd);
+	err = gve_adminq_execute_cmd(priv, &cmd);
+
+	/* It's ok if the device doesn't support this */
+	if (err == -EOPNOTSUPP)
+		err = 0;
+
+	dma_free_coherent(&priv->pdev->dev,
+			  sizeof(struct gve_driver_info),
+			  driver_info, driver_info_bus);
+	return err;
 }
 
 int gve_adminq_report_link_speed(struct gve_priv *priv)
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 8e80f36116ec..831759d30f44 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -640,9 +640,8 @@ int gve_adminq_register_page_list(struct gve_priv *priv,
 int gve_adminq_unregister_page_list(struct gve_priv *priv, u32 page_list_id);
 int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 			    dma_addr_t stats_report_addr, u64 interval);
-int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
-					   u64 driver_info_len,
-					   dma_addr_t driver_info_addr);
+int gve_adminq_verify_driver_compatibility(struct gve_priv *priv);
+int gve_adminq_get_device_properties(struct gve_priv *priv);
 int gve_adminq_report_link_speed(struct gve_priv *priv);
 int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule *rule, u32 loc);
 int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index b9542ef36b29..eb2d768e5881 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -17,7 +17,6 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
-#include <linux/utsname.h>
 #include <linux/version.h>
 #include <net/netdev_queues.h>
 #include <net/sch_generic.h>
@@ -41,49 +40,6 @@ char gve_driver_name[] = "gve";
 const char gve_version_str[] = GVE_VERSION;
 static const char gve_version_prefix[] = GVE_VERSION_PREFIX;
 
-static int gve_verify_driver_compatibility(struct gve_priv *priv)
-{
-	int err;
-	struct gve_driver_info *driver_info;
-	dma_addr_t driver_info_bus;
-
-	driver_info = dma_alloc_coherent(&priv->pdev->dev,
-					 sizeof(struct gve_driver_info),
-					 &driver_info_bus, GFP_KERNEL);
-	if (!driver_info)
-		return -ENOMEM;
-
-	*driver_info = (struct gve_driver_info) {
-		.os_type = 1, /* Linux */
-		.os_version_major = cpu_to_be32(LINUX_VERSION_MAJOR),
-		.os_version_minor = cpu_to_be32(LINUX_VERSION_SUBLEVEL),
-		.os_version_sub = cpu_to_be32(LINUX_VERSION_PATCHLEVEL),
-		.driver_capability_flags = {
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS1),
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS2),
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS3),
-			cpu_to_be64(GVE_DRIVER_CAPABILITY_FLAGS4),
-		},
-	};
-	strscpy(driver_info->os_version_str1, utsname()->release,
-		sizeof(driver_info->os_version_str1));
-	strscpy(driver_info->os_version_str2, utsname()->version,
-		sizeof(driver_info->os_version_str2));
-
-	err = gve_adminq_verify_driver_compatibility(priv,
-						     sizeof(struct gve_driver_info),
-						     driver_info_bus);
-
-	/* It's ok if the device doesn't support this */
-	if (err == -EOPNOTSUPP)
-		err = 0;
-
-	dma_free_coherent(&priv->pdev->dev,
-			  sizeof(struct gve_driver_info),
-			  driver_info, driver_info_bus);
-	return err;
-}
-
 static netdev_features_t gve_features_check(struct sk_buff *skb,
 					    struct net_device *dev,
 					    netdev_features_t features)
@@ -2461,21 +2417,10 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	if (skip_describe_device)
 		goto setup_device;
 
-	err = gve_verify_driver_compatibility(priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Could not verify driver compatibility: err=%d\n", err);
-		goto err;
-	}
-
-	/* Get the initial information we need from the device */
 	priv->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
-	err = gve_adminq_describe_device(priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Could not get device information: err=%d\n", err);
+	err = gve_adminq_get_device_properties(priv);
+	if (err)
 		goto err;
-	}
 
 	err = gve_set_num_ntfy_blks(priv);
 	if (err) {
-- 
2.54.0.1013.g208068f2d8-goog

