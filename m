Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9B293C4E
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940882; cv=none; b=GtNZWtaQq05xejBL3GhxI5JIAzSmQwSIP75A5oS1bgUx/bedRg4ZkDZ7g7dzkZq8B0gRskw6XrkYe0TyKfH3Kk1ebz7CVY9W/eR32OBCt76E8vQA8oSDPnBMuoccxF54fWnbXfKyTtVy+h8eT4duBx1zTZEtVizkaTe2jfDKBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940882; c=relaxed/simple;
	bh=Kkf0AyrAiAu8KXaMTqsQTVqF0XMvHUSH4oj+GyiNFY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B95jPo5YeD4flOxytORPEufuM6XdQzGYpRtPTuAiTFIEo4n2tx5HWXjCgKcwOxbk4rdkIlptrE4tUZXzEAlIUvcUh2yn9ac3y2pHpn7+ut6lBDEpyIZQyFXT7/tia8BbeQ1a+B669GyE0sR3Vr6ayS8aAHaqAMs78HLYftIWeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6G+M6Lm; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6G+M6Lm"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d736211595so318915285a.0
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777940879; x=1778545679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWJwbEllN4ZJKVX+XZselB2Kwac+OZX7uznK7jh7ztA=;
        b=N6G+M6Lmzy8wx3P4xSH/bnBmuYrJqA3jDRgXnZFZC7PcmAi8uzGo6fgodVCFrzqEbs
         HDuxOvt+nAtvRegeqPwB6fRwzeAvAt0YONiTI+UrvYG44dPlQDfPknCxtxhun4oaKe5l
         Tbh73f2oU6u98lZp+Dydzs8hQ8eKMKOtciZi8jP5YKwGXsIau6s6nWXKZoy8kHlUqVl6
         E2AD+sB2bqOVv1ghPJHLZEaoglYL9wkPKRj2y0fTT3Zr/0TMp1lr2keRWYtk0zuCVsU5
         Pekp/IlLtlyel0gs/6sgNcTVC7nwgzVb1tZs9eRVBmMirFN17a0kCaqy8XL8G3LagQmN
         2i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940879; x=1778545679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MWJwbEllN4ZJKVX+XZselB2Kwac+OZX7uznK7jh7ztA=;
        b=awZEyLDZmZTwL2JOKzTnSu2DUpSkPGnmrH7fxwdVve10MlmOpNzt0g/kh+QDSWjnkn
         +lsv1YOif/PYlNVi25VW6znpsqSGKZ6a6CGMxQmFg7RmhbwscjQy5Zv+z+ckTntrkcjd
         94YVPe2jvftvAZ55/aa6GqTRJRqJsNAtWIiqyvOrPtW/B/hldT9MopWMHoVmh2Qle65l
         wkdPqtYGZ1EMJFN7uk0b9X837CuSvNiwV/M7UGtcMH04zxuM6i6XCf3aDAo3yImFqExA
         Wf5ey27sEKT+N2R/4if1t2nrVlVUuNGdVxlq24mkNIkstNShs0QylYGe3ZrOlE5xpLXF
         hbrA==
X-Forwarded-Encrypted: i=1; AFNElJ+yHH7dSIxadrnZO1Y862fWCvLZSQwxXqu4sfKRjaoLh+FhHvEj97hPh7j+n84Jd3eDbC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3wyBdZaM0SPYPVZWu4zDpv96wZNr5gc9DXf+c7pAr3TcF0R76
	p1Sjs3+qKFX3HeD7z0j4g4T+oaT71geiHQJk+DhvtJurwyYfWg6rWCw2
X-Gm-Gg: AeBDiev9z/HrQIQBGtCHYRuq84az/Fq1oVCYO10l429hvHimY8FKp6pV0sGDNcFgtsA
	XKpS6GT2fMfDokG1ZAU1jqN7RmAQsZgh64vNax6OaXwOSWc9N955EyCWdiDklhLlzpw4aZG1Fgk
	6qLDDsfm+OmXjFhpP6dZiT19d+4OAu8EUo4he/f3D050N5eYip6cFcWM3ci0j2WnzSVElXpMCRP
	lx034ap/g1TeoV2BMtykfOwVpZyoz3zfQHpaEVgYuo9gNntO+Utlljji5YLDG55PgS2u+HhXOu1
	TcqWnghJBTwyhJ2CEzb9D0ble/dSft77hjCH+e7JR6bHPUimK6g/OkCP7KN5U4DgTiJymvUqG1D
	WzPgz/7pQSWh/GIt38UKmuPrrR11iK5/4BCxHO5VZHefRvzD1ir8dTsOSOoMcI1cKKGoBhQbdVh
	gztwtx9s3Z6RkOgYj6fxkSOkhMgtqS0pey
X-Received: by 2002:a05:620a:3188:b0:8d8:ba4a:596c with SMTP id af79cd13be357-8fd1864a0famr1905610985a.51.1777940878605;
        Mon, 04 May 2026 17:27:58 -0700 (PDT)
Received: from localhost ([2a03:2880:f804:1f::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc293816e8sm1158075985a.8.2026.05.04.17.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:27:58 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 04 May 2026 17:27:48 -0700
Subject: [PATCH net-next v2 1/6] net: add netmem_tx modes that indicate dma
 capability
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-tcp-dm-netkit-v2-1-56d52ac72fd4@meta.com>
References: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
In-Reply-To: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
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
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Devices that support netmem TX previously set dev->netmem_tx = true.
This was checked in validate_xmit_unreadable_skb() to drop unreadable
skbs (skbs with dmabuf-backed frags) before they reach drivers that
would mishandle them or devices that would not have the iommu mappings
for them.

Some virtual devices like netkit (or ifb) never DMA and never touch frag
contents, as they essentially just forward the skb to another device.
They are unable to forward unreadable skbs, however, because they fail
to pass TX validation checks on dev->netmem_tx. This single bit flag
doesn't give the TX validator enough information to differentiate
devices that will attempt DMA on the unreadable skb and those that will
simply route it untouched.

This patch fixes this issue by adding an additional bit to netmem_tx, so
that drivers can indicate 1) if they have netmem support, and 2) if they
do, are they DMA-capable or not?

Replace the boolean with a 2-bit enum:

NETMEM_TX_NONE   - no netmem TX support (drop unreadable skbs)
NETMEM_TX_DMA    - full support, device does DMA
NETMEM_TX_NO_DMA - pass-through, device never DMAs

Update drivers to reflect these definitions. NIC drivers use
NETMEM_TX_DMA, and netkit uses NETMEM_TX_NO_DMA.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Squash driver conversion patches (2-5) into patch 1 (Jakub)
---
 Documentation/networking/net_cachelines/net_device.rst |  2 +-
 Documentation/networking/netmem.rst                    |  8 +++++++-
 Documentation/translations/zh_CN/networking/netmem.rst |  7 ++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c              |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c             |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c         |  2 +-
 drivers/net/netkit.c                                   |  1 +
 include/linux/netdevice.h                              | 11 +++++++++--
 9 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 1c19bb7705df..c85784259544 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -10,7 +10,7 @@ Type                                Name                        fastpath_tx_acce
 =================================== =========================== =================== =================== ===================================================================================
 unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
 unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
-unsigned long:1                     netmem_tx:1;                read_mostly
+unsigned long:2                     netmem_tx:2;                read_mostly
 char                                name[16]
 struct netdev_name_node*            name_node
 struct dev_ifalias*                 ifalias
diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index b63aded46337..217869d1108d 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -95,4 +95,10 @@ Driver TX Requirements
    netdev@, or reach out to the maintainers and/or almasrymina@google.com for
    help adding the netmem API.
 
-2. Driver should declare support by setting `netdev->netmem_tx = true`
+2. Driver should declare support by setting `netdev->netmem_tx` to the
+   appropriate mode:
+
+   - `NETMEM_TX_DMA`: for physical devices that perform DMA.
+
+   - `NETMEM_TX_NO_DMA`: for virtual or passthrough devices that do
+     not DMA, but still support handling of netmem-backed skbs.
diff --git a/Documentation/translations/zh_CN/networking/netmem.rst b/Documentation/translations/zh_CN/networking/netmem.rst
index fe351a240f02..320f3eacf51b 100644
--- a/Documentation/translations/zh_CN/networking/netmem.rst
+++ b/Documentation/translations/zh_CN/networking/netmem.rst
@@ -89,4 +89,9 @@ dma-mapping API 去处理。
 使用某个还不存在的 netmem API，你可以自行添加并提交到 netdev@，也可以联系维护
 人员或者发送邮件至 almasrymina@google.com 寻求帮助。
 
-2. 驱动程序应通过设置 netdev->netmem_tx = true 来表明自身支持 netmem 功能。
+2. 驱动程序应将 `netdev->netmem_tx` 设置为适当的模式：
+
+   - `NETMEM_TX_DMA`：适用于执行 DMA 的物理设备。
+
+   - `NETMEM_TX_NO_DMA`：适用于不执行 DMA 的虚拟或透传设备，但仍支持
+     处理 netmem 支持的 skb。
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
 
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5e2eecc3165d..0ad6a806d7d5 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -466,6 +466,7 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
+	dev->netmem_tx = NETMEM_TX_NO_DMA;
 
 	dev->netdev_ops     = &netkit_netdev_ops;
 	dev->ethtool_ops    = &netkit_ethtool_ops;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e1e581efc5a..11d68e75eb4f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1788,6 +1788,12 @@ enum netdev_stat_type {
 	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
 };
 
+enum netmem_tx_mode {
+	NETMEM_TX_NONE,		/* no netmem TX support */
+	NETMEM_TX_DMA,		/* DMA-capable netmem TX (real HW) */
+	NETMEM_TX_NO_DMA,	/* no DMA, e.g. passthrough for virtual devs */
+};
+
 enum netdev_reg_state {
 	NETREG_UNINITIALIZED = 0,
 	NETREG_REGISTERED,	/* completed register_netdevice */
@@ -1809,7 +1815,8 @@ enum netdev_reg_state {
  *	@lltx:		device supports lockless Tx. Deprecated for real HW
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
- *	@netmem_tx:	device support netmem_tx.
+ *	@netmem_tx:	device netmem TX mode (NETMEM_TX_NONE, NETMEM_TX_DMA,
+ *			or NETMEM_TX_NO_DMA).
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
@@ -2132,7 +2139,7 @@ struct net_device {
 	struct_group(priv_flags_fast,
 		unsigned long		priv_flags:32;
 		unsigned long		lltx:1;
-		unsigned long		netmem_tx:1;
+		unsigned long		netmem_tx:2;
 	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;

-- 
2.52.0

