Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3EE26E706
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207298; cv=none; b=otqSWxC1PapgeRrOxBuIb1MDswlfETwe6zIBW2NDaeYIVxVeqbPwOgR+ughDZ2oKaH5VKNCTJF/O8t/zlq1a9kf143CZ6pp53wdMn/Kt6YSlOpFH9G4UnRP6vAYbYVHbHAz+yjlTZXf1SUytL8o+ZDNfad+tx8c12WgVb084HKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207298; c=relaxed/simple;
	bh=YOPO3l7uxW+eRzLl3iossMvHREitWAyJ18Lz0CZa9ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cDRQCzeU77SF6wVVedO6cG5F/M5MUCuZlIGqlAcXGDDfrtuWKYmgH2ZcM4XvDX+cQTin+TukR14Yso60r6cFzv9uNhoD9QvrL+SSIfbgR2Gwgd15lfwfDDxf0TcHLRtl4JDvFfrUQV0LBmC4aJ75+cwxNVScwafRGWuEZd0RsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR9TECKg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR9TECKg"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5148cbdea08so2280481cf.2
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 19:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778207295; x=1778812095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXhCyJ6Uqead6+Tw4IHtY2XSZdsbutwm7LNjDaKgNY0=;
        b=NR9TECKgCDvnBDSdVryQaDyHyk6WntnhwJ1VFHRUxmIgoAkslbJDP1XVn05Sb9B7sx
         KLEVR+R75YybhRUVPUKXEWFnrM8JgxuzDLF5UAy59/XIuAD/jhiKOOzVVrfTSeS3Nrve
         AvxK4s+plJfjDR93LUCFXygoO9hpAKyVd2vS1xDt77xR3B/z6Q6yZzhhuq2drBEQMES3
         CuMggd0DUJiXiYd113sfULSzcpt5Wt5OH9XCaCibULoL+FYdw+GpiFngC76Aa7LmFNxW
         8LsuLIG9ghf7qBbXq/D7fQXNef45gHblLUChnmq3uZNe/fM73KrGQ//Ma7lUUppUF9SK
         WigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778207295; x=1778812095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oXhCyJ6Uqead6+Tw4IHtY2XSZdsbutwm7LNjDaKgNY0=;
        b=YWdw41wx/nZgWUbYItBMtPKVy61gSHzsfN2ttcTZ+fNRg/39yaicZ+jhpiuFCBGAxt
         RI6/NRWJieDm4bPyDx4p55VCf2oWPNhZK+08fMHRqdsykLGm3c3t/PvuHcK10rEOUp0B
         WVK+rl7lUeC78+Rt0IfZMql1Yyc2T9uj6NXSYCPLa9gHHW/qgmSGXaxwUERUCYr41AEQ
         yoBf0PfYNglcYH24cIfDpSkbyEm6fQa7CP4FqivzyUP/pd7jpHbrmIoWXd9Wy9b79GNN
         ik3slWMYXsheAfqd5NrmEF2J4/a1cqdhEyxiQ9dhpbYC23OdbeAHXeTkNHtOHQyKf3sk
         qAxw==
X-Forwarded-Encrypted: i=1; AFNElJ9QnhERitAxFy46JmxOeEGMyDJ3PYyi7iA/Ew/hZRVdPphj/MfdVgFEdaZ0GniX2qlZSg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmHkuYxf11tCj+h3sysUOFN8iJFUYSE71c6wA+uR+7VDXvcm/
	9ycln0qvz+O18u5xYjp6ux+CVd7ZEA8CqFkbh9sNjP58lVCFxq6qUv2V
X-Gm-Gg: AeBDieuJE7Qip4h3KL6sj+4bCI+gNKO42P5QwpV/wRlYPG5Qrn+7S9HzNFzFhKN85Ni
	z/9cssLhBXZOktL2knatBsJdcXUJHeUEIMTJLCv+sFbQ58DaYmz8jmRCEiR9iq9iVs2M9tLSKEf
	WDHkeeb9VoWwwutxgLpTCo/vzM9wTT589thC/lrOMdppOkLj0mB4zN+48qjPHCqAHMYdwC2a7TE
	AGJCG57zPP42az7D2m5OwaRI3O5dmiB3kxNzuVd2fvaQ+Z81nDw5sIAdaaw2YUiphDMw5PDx6Tc
	wu3VZNFcbCrv5kahw5xg0BJCGlOT9bUYW35CmWAcFA7MtWxn3EIMRJb8TNBeZFLHp1MCq6ZDoMv
	z35iqlfphZcCJFxC5UqSZ9LkTIP0FA2M++jcv6dY++hgj4F5B05arMIiMuxwV5I/b4YqcxH0Pjz
	i6ljTetDV0S0Dv8SNP2bQ=
X-Received: by 2002:ac8:594f:0:b0:512:e827:d844 with SMTP id d75a77b69052e-514621cea4emr152315561cf.58.1778207294723;
        Thu, 07 May 2026 19:28:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7c0289sm5423071cf.18.2026.05.07.19.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:28:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 07 May 2026 19:27:46 -0700
Subject: [PATCH net-next v3 1/8] net: convert netmem_tx flag to enum
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260507-tcp-dm-netkit-v3-1-52821445867c@meta.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
In-Reply-To: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
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
X-Mailer: b4 0.14.3

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
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
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
 include/linux/netdevice.h                              | 8 +++++++-
 net/core/dev.c                                         | 2 +-
 net/core/netdev-genl.c                                 | 2 +-
 9 files changed, 20 insertions(+), 9 deletions(-)

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
index 8c55874f44ca..ed9c22dc4a5a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17120,7 +17120,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
-	dev->netmem_tx = true;
+	dev->netmem_tx = NETMEM_TX_DMA;
 
 	rc = register_netdev(dev);
 	if (rc)
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 424d973c97f2..dd2b8f087163 100644
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
index 5a46870c4b74..fc49aae38807 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5924,7 +5924,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
-	netdev->netmem_tx = true;
+	netdev->netmem_tx = NETMEM_TX_DMA;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(priv);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index c406a3b56b37..138e522ef9b9 100644
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
index 0e1e581efc5a..580bccb118a0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1788,6 +1788,11 @@ enum netdev_stat_type {
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
@@ -1809,7 +1814,8 @@ enum netdev_reg_state {
  *	@lltx:		device supports lockless Tx. Deprecated for real HW
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
- *	@netmem_tx:	device support netmem_tx.
+ *	@netmem_tx:	device netmem TX mode (NETMEM_TX_NONE or
+ *			NETMEM_TX_DMA).
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
diff --git a/net/core/dev.c b/net/core/dev.c
index 06c195906231..fbe4c328a367 100644
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

