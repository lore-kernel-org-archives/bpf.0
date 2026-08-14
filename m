Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB53DA7D9
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673676; cv=none; b=rW2mUB43Oxb3sMfFhR6rgUQ4PVyFwvexCVapr8o4BfsArs08Ij+6qhPhEqy0Fym/N7pusFSdaoTosMHGFKBPSAJ+ORnu/bq30djscHUv54tauGVyvaowq7qt9kta3MAW+xeM6GogwARXN7m+sBRR1MsogC1X8jUp0T+rcxbKmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673676; c=relaxed/simple;
	bh=rxHDWoJ/J/jHHO5UcuO/N3XuvB6KVzLUbrpaWEBfapU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HozDjbTKTpTO71QGdoYQolr+CwUqfKbOtElzrRRmew9XrG20VAW7cf7lCQt+nNDZ6keGPVH069+BYlK2q0wzJQhOt4Lfc0kwSGz++EUe2NvfkYBvN/I7i4LAaZlSv6aQse39Ar7RSUlfw705SOFL3seWkmuaNBx9U+XsP7EkhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xpwq9apY; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xpwq9apY"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848568a6f62so545775b3a.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673664; x=1787278464; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AnP3Zij7UDXmnWAiL7aCjjarDXFUb7Nwv3dv2t0tbVY=;
        b=Xpwq9apYxweg8+OGBTaPljEwcpggFn0Gbr7PXHo/XxvgdrkZSMckTHlaelyZE4XUE4
         D3fPCNTxlcmuBmrgHPhUmH9BIavinX5C4mFGUb/0ea3Eo1e7K8hLQ4FurjzEl7VGixmY
         ypgC0wClkLKAR+UXq2TnWSvnzCCmc3ZdXHEfwYrG5yEx5XpqCt0cb4SVtToj1PrhU3C3
         o6Yv45gopPSGInz2suE3JcvdQobX9mnSIgFUDw/6oNDnHo9hNUqriblk0bQVCx5t+W5c
         XVPwuYGaBANtYIfJvmjRiDGjH4GFzhZWPSoVf3Gr2ML7zM2S2DHIst+XepzYBZIG/S4f
         y45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673664; x=1787278464;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AnP3Zij7UDXmnWAiL7aCjjarDXFUb7Nwv3dv2t0tbVY=;
        b=tX2r5yH8QVJA7SAXEWTjNfSIsXVmn6xXdyf8DlswVQFnUPweLBOdZH/RdQOXZ+Tx+S
         sPOGy37ME31L6MOZOz0QlJJJDC2ZVlUFHY8AtYh4q1siMlywM1P2Aom2GGPf5jS79mn1
         HjVlLZU4v37oG5/KwCCBRMQoJUyU7mYgmv/DeDlwBwIlerqrKaagrNK5OYZPpOXSLwpQ
         E3vnHLlpg9sj1gl2ZhooRvOCoRmjT05t6fQCge5oSSImaaUQwMQbVl4QIASyOLvsUnSL
         XmqWp8YsXvJRsZq03OtUhta8Q16cBEQ9oS5pVseSVa6TbsAlQcFPaDLrJOUhBlLPMHok
         BT5g==
X-Forwarded-Encrypted: i=1; AHgh+RpgavZ5g1GvbkEB1iK+4+kRGZShquGlvjPPlAh/PhF7Kpc0Jmu0MrXzpo/lCxi/zqAFkM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4CHWLpVKOwlze/mxElRqY+fMibWfsyqoU8Bj4+S3oms6hFKX
	GjnzRSH1cqg9dWfKdm4+LQIk92W/TaHnwPy1ZI9EKEGV9JFf2RWebmAQRcCBvMJad0qs7OtDkdF
	NLiiqhoYH6Z36NtSBAO8uUPsXmw==
X-Received: from pfbem22.prod.google.com ([2002:a05:6a00:3756:b0:848:5740:db83])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:f04:b0:848:3fe2:c88b with SMTP id d2e1a72fcca58-84fddf89359mr2947638b3a.6.1786673663512;
 Thu, 13 Aug 2026 19:14:23 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:13:57 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-8-hramamurthy@google.com>
Subject: [PATCH net-next v4 07/15] gve: introduce gve_adminq_get_device_properties()
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

Introduce gve_adminq_get_device_properties() which executes the first
two Adminq commands: VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE
so that this can be called during initialization.

Move these to Adminq specific files. This is just code movement, no
functional change.

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
index 1782a2d4b746..bdac2dd9b86a 100644
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
index ed3504853908..2ab68c822e22 100644
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
index 37eed00c4ed1..5cb22575fd93 100644
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
@@ -2480,7 +2436,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		return err;
 	}
 
-	err = gve_verify_driver_compatibility(priv);
+	err = gve_adminq_verify_driver_compatibility(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not verify driver compatibility: err=%d\n", err);
-- 
2.55.0.691.gc56d675ccc-goog

