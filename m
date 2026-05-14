Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7CE38E8B4
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779364; cv=none; b=F9IWYRxkxnfQSxTsjHAxn0xTIuhJFwXCfUdI7Rg1LfwbtfU8qsGCRC89hr/uOkacfHUvosmvbJs3WDhpgmopCw1iQRs3TucqCoPYBGmxw+RvTKb6u3SpTW2KfkgenhQf9GDM94O0RvmrwS7yz85txFJ7SOd2t5Pe2EE6Iy4IY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779364; c=relaxed/simple;
	bh=Axn+PNJbdQIKENviBaH16X9CGQ2qXERThK3Y3nrH0mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2wo5cT9Io2Q1gO1zZj76dazPgzjJK2DgW9dzwGhhj3sQCy3GbQR6w9Udisb9PGDAyAbwyo30Gp+9I8zaN9pdIQDn/ViFqif/TZnk/kRTTcdkFpalGBcT/2Mgb7K/fCmuQdHPsfj0xmCS7dGpvDpusziKCG1Kn+z+aOYUwUnLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWjQQI6V; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWjQQI6V"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c396d3b36so10306105d50.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779361; x=1779384161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYjurhmeiuV8Nqd+zpLe/ERTdzqtmQMlSYyDiJ3WcRE=;
        b=JWjQQI6V5hwGZZbg4VB9y1teFLjXB8IT/LPZ6fAsm8/kKChhRsLXEdZvKktEqUkUd7
         rdWd0G+8NlueDBPbL5CktiOrh1wOKGE/D4tcv9OfpBqZkFIFJ5tDL1YX5C0CTAy4f5m1
         3cWmtGgXzmY2CmGVG+3eEHtTeuAE0wfMBnZwWakP1U4WCl2K+V8D2GzUttOucAPiRCE/
         NZOBHtaWxuBMr1TguS4dH5PEGrylNJJAuYxe387xSJ+N4hIA0oyjKBklHGNosPMXtJpi
         8BSsXk6o6+4eCGj0VkH9GkuDBK9MIotx/oiA3LABouEMku6/FBGrabNkXcgcDRBkCQTn
         us0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779361; x=1779384161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYjurhmeiuV8Nqd+zpLe/ERTdzqtmQMlSYyDiJ3WcRE=;
        b=pacWQZ9tyCZCTj2eaY58ae9/Sn4pNrI1K1GwHIu6rPynPj3zgmWAoZBzS/OKJljLN5
         W0Hs+XvQ2NKzKLYjHvnX3m79R8CxovVqwfrPWB08FkkiBr/xMQ9FcXb0K7VH4qdf+KAt
         cD0+BcGAfEtgepMd4V0CuoWILqJqQ75q/Efg2wqD0EBFbBWk1NU51ODWQp5cXzWXw030
         w1NWngqAowuFNwa6pU/OxzjRw5WEWwS7oFzeIezH/I/j9T9gXhDFoPMDKSkZheIrgE29
         fFOCgryI4InDklBsgG1jrGJOMHvdTJinb4eZnSD0HO0yckVGezCfwSn7yXB3KS+r60VT
         FuyA==
X-Forwarded-Encrypted: i=1; AFNElJ/2mrF4Nl7V5z0etF5S3rw4KHYo+2BUyb8kJFG9FySKWSeFVRh1nh7NLiYSrgRrFK3xmCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1GktdDiMtWv/c4Oy5EyV4umatH/at+SY48sBC77MscrhkJ0PO
	bdxCemt7bpRDoNLdVCqA0dDOSFOEFxCv43hEEhA3+yFDqV1Hbir8OJef
X-Gm-Gg: Acq92OFDIVpDsHxnluBqpDPBQBBLSHTmXuoES+2qKXp9VjMy9e2BoFIJjVkKHI5BD69
	wqQTjzgKk+3H8kT75rYkNX8nNd8efWLIG+wIOq0QvajWRQV+RGTsvlmndIUpgPCWKskxhJS1bDk
	rt10wFOo7GKTJUZOFaUdH2Mr42+2Frgf/aPqLb8MRsfdDqdyjF4PQ2s9kh9ExYs1g/b+OT7sufz
	D5EQYCv0TmS/a63H76/kfqAn0W72Lto0FmsSejdCzlI80BNueL6wb+ELbnO8ekABqUMyBeas8/P
	4NKWIE1jRrgXaasiKm3CAud5dnGIP8eUmmdpn/lq5aiVFzUy3f5XMlFTJ4gZvQ+1qcgVLmdvo8c
	5036JGlXi2C2Ig3oaJVrPkfDIw3RkhgzZxK2mwaZDOiaaoQ4fJYIW/R3Qt8VTYhnoZ5oLzOSX8v
	j+fdlz8chCDNHIEYDlx7oSiA==
X-Received: by 2002:a05:690c:6e86:b0:7bd:8d1b:b2d9 with SMTP id 00721157ae682-7c95c5ef58dmr2296487b3.47.1778779361418;
        Thu, 14 May 2026 10:22:41 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:3b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f2ba567csm16544767b3.18.2026.05.14.10.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:22:41 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 14 May 2026 10:22:28 -0700
Subject: [PATCH net-next v5 1/8] net: convert netmem_tx flag to enum
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-tcp-dm-netkit-v5-1-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
In-Reply-To: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Devices that support netmem TX previously set dev->netmem_tx = true.
This was checked in validate_xmit_unreadable_skb() to drop unreadable
skbs (skbs with dmabuf-backed frags) before they reach drivers that
would mishandle them or devices that would not have the iommu mappings
for them.

A subsequent patch will introduce a third state for virtual devices
that forward unreadable skbs without ever performing DMA on them. To
prepare for that, convert the boolean dev->netmem_tx into an enum:

NETMEM_TX_NONE   - no netmem TX support (drop unreadable skbs)
NETMEM_TX_DMA    - full support, device does DMA

Update the existing NIC drivers (bnxt, gve, mlx5, fbnic) and the
validators in net/core to use the new enum. No functional change.

Acked-by: Harshitha Ramamurthy <hramamurthy@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- netdevice.h: netmem_tx enum list -> only "device netmem TX mode" in
  comment (Stan)

Changes in v3:
- Split NO_DMA changes into subsequent commit (Jakub)
- Move !netdev->netmem_tx -> netdev->netmem_tx ==
  NETMEM_TX_NONE conversions to this patch (Jakub)

Changes in v2:
- Squash driver conversion patches (2-5) into patch 1 (Jakub)
---
 Documentation/networking/netmem.rst                    | 5 ++++-
 Documentation/translations/zh_CN/networking/netmem.rst | 4 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c              | 2 +-
 drivers/net/ethernet/google/gve/gve_main.c             | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c         | 2 +-
 include/linux/netdevice.h                              | 7 ++++++-
 net/core/dev.c                                         | 2 +-
 net/core/netdev-genl.c                                 | 2 +-
 9 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index b63aded46337..5ccadba4f373 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -95,4 +95,7 @@ Driver TX Requirements
    netdev@, or reach out to the maintainers and/or almasrymina@google.com for
    help adding the netmem API.
 
-2. Driver should declare support by setting `netdev->netmem_tx = true`
+2. Driver should declare support by setting `netdev->netmem_tx` to the
+   appropriate mode:
+
+   - `NETMEM_TX_DMA`: for physical devices that perform DMA.
diff --git a/Documentation/translations/zh_CN/networking/netmem.rst b/Documentation/translations/zh_CN/networking/netmem.rst
index fe351a240f02..9c84423b7528 100644
--- a/Documentation/translations/zh_CN/networking/netmem.rst
+++ b/Documentation/translations/zh_CN/networking/netmem.rst
@@ -89,4 +89,6 @@ dma-mapping API 去处理。
 使用某个还不存在的 netmem API，你可以自行添加并提交到 netdev@，也可以联系维护
 人员或者发送邮件至 almasrymina@google.com 寻求帮助。
 
-2. 驱动程序应通过设置 netdev->netmem_tx = true 来表明自身支持 netmem 功能。
+2. 驱动程序应将 `netdev->netmem_tx` 设置为适当的模式：
+
+   - `NETMEM_TX_DMA`：适用于执行 DMA 的物理设备。
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 945a86696f2f..d4f93e62f583 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17123,7 +17123,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
-	dev->netmem_tx = true;
+	dev->netmem_tx = NETMEM_TX_DMA;
 
 	rc = register_netdev(dev);
 	if (rc)
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 00750643e614..e4d78ae52daf 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2894,7 +2894,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto abort_with_wq;
 
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
-		dev->netmem_tx = true;
+		dev->netmem_tx = NETMEM_TX_DMA;
 
 	err = register_netdev(dev);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 85b1ccbd351f..90d2979f1a4f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5966,7 +5966,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
-	netdev->netmem_tx = true;
+	netdev->netmem_tx = NETMEM_TX_DMA;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(priv);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 4dea2bb58d2f..f99ca551c1ce 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -752,7 +752,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->netdev_ops = &fbnic_netdev_ops;
 	netdev->stat_ops = &fbnic_stat_ops;
 	netdev->queue_mgmt_ops = &fbnic_queue_mgmt_ops;
-	netdev->netmem_tx = true;
+	netdev->netmem_tx = NETMEM_TX_DMA;
 
 	fbnic_set_ethtool_ops(netdev);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e7af71491a47..b7a4503f7cdb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1794,6 +1794,11 @@ enum netdev_stat_type {
 	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
 };
 
+enum netmem_tx_mode {
+	NETMEM_TX_NONE,		/* no netmem TX support */
+	NETMEM_TX_DMA,		/* DMA-capable netmem TX (real HW) */
+};
+
 enum netdev_reg_state {
 	NETREG_UNINITIALIZED = 0,
 	NETREG_REGISTERED,	/* completed register_netdevice */
@@ -1815,7 +1820,7 @@ enum netdev_reg_state {
  *	@lltx:		device supports lockless Tx. Deprecated for real HW
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
- *	@netmem_tx:	device support netmem_tx.
+ *	@netmem_tx:	device netmem TX mode
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
diff --git a/net/core/dev.c b/net/core/dev.c
index b0691e03dd6b..2da2688fe490 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3996,7 +3996,7 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	if (likely(skb_frags_readable(skb)))
 		goto out;
 
-	if (!dev->netmem_tx)
+	if (dev->netmem_tx == NETMEM_TX_NONE)
 		goto out_free;
 
 	shinfo = skb_shinfo(skb);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b8f6076d8007..4d2c49371cdb 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1164,7 +1164,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
-	if (!netdev->netmem_tx) {
+	if (netdev->netmem_tx == NETMEM_TX_NONE) {
 		err = -EOPNOTSUPP;
 		NL_SET_ERR_MSG(info->extack,
 			       "Driver does not support netmem TX");

-- 
2.53.0-Meta

