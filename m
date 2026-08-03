Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F7437457
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782803; cv=none; b=sbHM5b0O29HZ1N9kHIpxeYkZI8BpZzXertps8wE9tAmzGC370zy2yoVQquJSGxZ/w0aUXCOKbJhd0Tmgc14hVZlnJRYHmBJVLhwa01TgLwwqlH0Y5tSDh+uzNw9X61pWDK03P/6tdkPHaUj0yuWqfaCIAjgrJyPzokkKLYX5Sr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782803; c=relaxed/simple;
	bh=Fr7yMztMPLMzV9SRayKnLmgYz+q/JGWMiHCgsnQkIXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HlUopmctYESpcHSuXIyC/1XU2dB9LpYaWk7ZEWy9V+RERaL0vDkSyyFXmtxLKUSVOCEysrJ8cMtlwJDRunK3rtdgVdnmQTGtil1sUY52ViUYARqBch5VqwG6rDUXDdWaTPoQX7U/eb+z/+032nywgZ5Om/VWsXUBjFp/0TjjImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v8h8RJqj; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v8h8RJqj"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cd01a14e81so47049445ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782799; x=1786387599; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hN3o/DHJskmjhwULiSmrO1hn115gEBds8zafSVyGpbM=;
        b=v8h8RJqjEVIMXncD8x+cTrKnLO2/CpoWs9F/UH0tz5dWT2w0PkYd8C8oNNJHruhNMj
         pWkIE1UlhMblu1rEzkJ+2RN/NVy8g+lccSw6ltuKHTIRzy3hFqvO5oQykl7FM0RvB6Ve
         OS5hUeaBzvUt9pI1MviHB5eVmW6jxEF11Q6rTdgQSSWfpmKnwbCq5rFw5hrLAil7+GMM
         5WdbjADOqlDZ7w/16q1znz0ZBOQzIHEHkFFmfOL0/se3WhH0VeVzp/6O+8d//bglYyg1
         BC1OPcw1OYsi2Q6/DWFFoH1/MhkIP5t0TVRU/SYzUgn2z1brSbBepjtIlvOcZWwhAL4x
         VjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782799; x=1786387599;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hN3o/DHJskmjhwULiSmrO1hn115gEBds8zafSVyGpbM=;
        b=bdpOjAeK1LJu16xbL7olrbjF+9AJDQn52nfNd/oQkLXlEXY0FFez6ZMWSagU+stIGp
         rpz+zz148DLl49omNpUH70eXqvVF3xIdpj3hGTnGe5PpWL+Uoa1bslpTiqpJHeTZ/HlL
         BD0XkalqOkiyBQ30sdtNad3egtk6Eg+sjrE/A20W7fmIsmE+NS3Q6vM8Bzez858QYWCu
         eEnGeL2nZ113JkPtKiLZGTGFSV80PXQY1FuBIs/YvOEZAw19e3UNkoX+0xjPmQuPBSJz
         LGuahEsrb0yXKtPcdOlqMsXqYlz6AEYwaEKOUwgilzxYzC2ERAUCmkxCdGxoNbTERBa7
         dXeg==
X-Forwarded-Encrypted: i=1; AHgh+Roj35sH3YZ3/82hgtNzOHoPZ1J/Nx7ThmFR3gTbz5ItC4EWvGGrZxSdjyN3FOKCowY5v9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CU8FaocgXhMhouA8VIohD+XntTgboxW127UNZHX2B0K3takt
	zjOloC/EJy9ZwPEmFHcTPN9Ok1wzctqWaCD1QBoYJ26Kov7XLV+z/iIorVlprat+SUCguZ6oULA
	8V7ka7G6jmEQnowVovKGU0KI/3A==
X-Received: from plbjw2.prod.google.com ([2002:a17:903:2782:b0:2c7:702a:36a4])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e888:b0:2ca:d818:61e5 with SMTP id d9443c01a7336-2d0523e147amr110305635ad.26.1785782798541;
 Mon, 03 Aug 2026 11:46:38 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:22 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-8-hramamurthy@google.com>
Subject: [PATCH net-next v3 07/15] gve: introduce gve_adminq_get_device_properties()
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

Move driver compatibility verification from gve_main.c to gve_adminq.c as
gve_adminq_verify_driver_compatibility() and update gve_init_priv() to
call it.

Introduce gve_adminq_get_device_properties() which executes the first
two Adminq commands: VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE
so that this can be called during initialization. Mark it as unused
since it's going to be hooked into initialization in the following
patch.

This is just code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes v3:
- move patch down so that the function is introduced just before usage
- mark function as maybe_unused
- update commit message

 drivers/net/ethernet/google/gve/gve.h        |  2 +
 drivers/net/ethernet/google/gve/gve_adminq.c | 66 ++++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h |  5 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 46 +-------------
 4 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 1bc5e32b6618..d6e7ab0649ac 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -16,6 +16,8 @@
 #include <linux/timer.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 1d9ae601cdeb..66a3e774b7c4 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1143,6 +1143,27 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	return err;
 }
 
+int __maybe_unused gve_adminq_get_device_properties(struct gve_priv *priv)
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
@@ -1205,20 +1226,53 @@ int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
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
index 52fe4a9f7b87..ac3ef9fd8d24 100644
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
index ce55f845a6f9..0d308bde52c8 100644
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
@@ -2478,7 +2434,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		return err;
 	}
 
-	err = gve_verify_driver_compatibility(priv);
+	err = gve_adminq_verify_driver_compatibility(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not verify driver compatibility: err=%d\n", err);
-- 
2.55.0.571.g244d577d93-goog

