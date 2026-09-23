Received: from mail-oi2-f31.google.com (mail-oi2-f31.google.com [74.125.231.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B505B368D55
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127863; cv=none; b=hXvhfKklAbMkW9xI8wCJGA9UBsfDnQQuwOEnVFTRbRZtUzskAcTC86KFxKMgQHrHFBHrc5IDZS1magaT7XMDnT5K+Bv7aRV//4hwhbGtobPu+nBdn1ORPtip8ChJkMTymVOKsOpYWmu7RZEul8jfzQoGDcT4NJbt4SxRPbKgHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127863; c=relaxed/simple;
	bh=arZ0JmcmqjRA3PSHgHbocDF4UPmH5TcQirEW4s9ekeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGB4DTIawhPHGvvONHLyzYAhbbsrNaSCC6bcmnjByGxMley3apvBCnqpG59GGhRvKNk+NxVuFVOoKmR09lESnLbsJUmS/eI6fGcQx3AGAB1iQ83W2SAJBuFmJcqkeoXcwPHH8eQXaeXziHFUPwA95g58q2M/eI8XBMzOWDxpCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esbriPC3; arc=none smtp.client-ip=74.125.231.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esbriPC3"
Received: by mail-oi2-f31.google.com with SMTP id 46e09a7af769-8144632e066so332709a34.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790127858; x=1790732658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SyZJoUyrlSl1/6SsfQ3YuWvmPYYk4jJTS8vAeISQEe8=;
        b=esbriPC39yvOjlwEHAa2i4xx17ziAsN/ffzMUBLInCop71dDSZolX4xtD+UhSpptNM
         +aDeG24hKBmIi08ONT3lTVq9S8F0kir+rbEyxcp2xp5wgmBdL6Q0p1+ZX3CZhp7re5Mw
         ok4okYvdTeqQ+Cra4mKE++sw72xSIeWEbwQVfTxtIgWXS0JT/HjUKleoe6TrNRcfpjx4
         SyOcUX583CJV4eUaXipUGjkgUSFehWd1MUV9tEenPi5XABHr9zJKqtORny5QvwD9zfhN
         BsmHi5lE4uHtVPcKVNyplQFQOHBKXzDDQDmNPvFLZlMa5Zh0UMCjcY/h9baKhcA9vpar
         9J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790127858; x=1790732658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyZJoUyrlSl1/6SsfQ3YuWvmPYYk4jJTS8vAeISQEe8=;
        b=cD5JiwiBh4O81xv6N/0suBS5WmT3rUuk1FKaF8XY+zHEeBAO7ierdAFpxeLp344zO5
         mD00AJkZUBHeWoZh3d1zib6VCxRkDeb+8jwilnVGMkS+Y/8M/yBg0uITiQzga0uy38UC
         /aJIMbYf7JsGt8eGDqKkm/8bDpJnwsWJD5Daq+MlwlEIJ4z5K0ZLLQhi6F+p4ON+wm/u
         lUvm7N7e7Z9RvMjYABGjnryDztepTVH+0thn3xKKbsRTBRkdm1frd/hOhms27BCSRh3b
         jqGS/qT1QWEcFCwS+3Xwt8EwCf1JsyYSkyiko/po68gj87pljcMzfkEYLfLPlp9N3n16
         YHqg==
X-Forwarded-Encrypted: i=1; AKwUvBzFDNIIyVHJUhl4jW+5wZHgo+cR1yOkDzRsv3547sLbrU3fd49YJRaJgKnD1YbTgWzrkvY=@vger.kernel.org
X-Gm-Message-State: AFuF++kaHGalbnbd9ijxiTY9SglUdHjb7StKitX8fME8Q4bZ0Vcr7XvY
	c3FQPrrHfugBBdJdSE9TBY9FThhHft9a6mxFRDUzO3wWZuZAF4G+n9hE
X-Gm-Gg: AYBFou1yMUytH6fbQh3tHoDZ31myurRAtkqvQAF6ZQ5/23ZhRtG4qNrCGNE9PpalR5Q
	vBz8kkgUYcqBkrrKx91PQDOxxluwi2dO9sAHexMJqNMpW1v6Bjb5yc4hP0MwsyUIcphGKrXO8G6
	JhnODJjiaUuYI23PZ9et26wBAchcydIP0WHEugodV4EqwAko7+fbp5Mdg5QGFgNU6hu4E95+jQM
	EcBRvuP+PpPWd0pR6iggyi8REYzckrkTLhJrCMbuzVgNnNcZdBnwFs2foNW3v6FFbsyAdotlKdS
	GBS1At9zXuMaIrSkPLflhCivtF16Uz/9LhWFJ+GzBI08VBLZzW/qKR+PHL2JJDWFHa2SG3u98DA
	F7dU3B9UX5JDOZQgWKfkesjvn9Igg8cofL3DlUWYcS8FPi3+v5ETenVKhTnoKVlKsUE9wU+WJyu
	AWfZDio5oWXVHPeu99rNjEdvYBpDdKUgAoOmVtX6AkMj0iewpg7+1M0AFD14amcEmg/gd3TAeIc
	l2M6gw=
X-Received: by 2002:a05:6830:83b6:b0:7f4:effa:a5c4 with SMTP id 46e09a7af769-815ee4a5d74mr1416800a34.1.1790127858381;
        Tue, 22 Sep 2026 18:44:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-816044c858bsm1806570a34.19.2026.09.22.18.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:44:16 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 22 Sep 2026 18:43:44 -0700
Subject: [PATCH net-next 6/8] eth: mpnic: add a netdevice and basic Tx
 handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-linux-mpnic-v1-6-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
In-Reply-To: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Register the network interface and let it transmit skbs.

The typical TWQ descriptor sequence for an skb is: 1 primary metadata,
followed by 0 or more non-last address + length (A/L) descriptors,
terminated by an always present last A/L descriptor.

The device does not write a Tx completion unless it is requested in the
primary metadata desc. The xmit path sets this bit when the stack does
not report netdev_xmit_more(). This can create a problem if the last
packet in a burst is dropped by the driver. To deal with that case, the
driver latches the last metadata for which a completion was not
requested, and uses this to request a completion and flush queued
packets when one is dropped.

There is no link state yet, so carrier follows the administrative
state.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/Makefile       |   1 +
 drivers/net/ethernet/meta/mpnic/mpnic.h        |   2 +
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |   7 +
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 176 +++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |   4 +
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c    |  25 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 157 ++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |   5 +
 8 files changed, 377 insertions(+)

diff --git a/drivers/net/ethernet/meta/mpnic/Makefile b/drivers/net/ethernet/meta/mpnic/Makefile
index 67d617f49a8a..d5bdbd5bd1c7 100644
--- a/drivers/net/ethernet/meta/mpnic/Makefile
+++ b/drivers/net/ethernet/meta/mpnic/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MPNIC) += mpnic.o
 mpnic-y := \
 	mpnic_init.o \
 	mpnic_irq.o \
+	mpnic_netdev.o \
 	mpnic_pci.o \
 	mpnic_txrx.o \
 # End of mpnic-y
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic.h b/drivers/net/ethernet/meta/mpnic/mpnic.h
index 628fd48c997d..78359ab6abb1 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic.h
@@ -23,11 +23,13 @@ enum {
 
 struct mpnic_dev {
 	struct device *dev;
+	struct net_device *netdev;
 
 	u32 __iomem *uc_addr0;
 
 	u16 num_irqs;
 
+	u64 dsn;
 	u32 mps;
 	u32 readrq;
 	u8 relaxed_ord;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index a2133024b2cf..f7c50bc70d8a 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -15,6 +15,13 @@
 /* Transmit Work Descriptor Format */
 #define MPNIC_TWD_L2_HLEN		DESC_GENMASK(5, 0)
 #define MPNIC_TWD_FLAG_REQ_COMPLETION	DESC_BIT(37)
+#define MPNIC_TWD_FLAG_DEST_MAC		DESC_BIT(43)
+#define MPNIC_TWD_TYPE			DESC_GENMASK(47, 46)
+enum {
+	MPNIC_TWD_TYPE_META	= 0,
+	MPNIC_TWD_TYPE_AL	= 2,
+	MPNIC_TWD_TYPE_LAST_AL	= 3,
+};
 
 #define MPNIC_TWD_ADDR			DESC_GENMASK(45, 0)
 #define MPNIC_TWD_LEN			DESC_GENMASK(63, 48)
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
new file mode 100644
index 000000000000..62dc9018f2f8
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/etherdevice.h>
+#include <linux/ipv6.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "mpnic.h"
+#include "mpnic_netdev.h"
+#include "mpnic_txrx.h"
+
+static int mpnic_open(struct net_device *netdev)
+{
+	struct mpnic_net *mpn = netdev_priv(netdev);
+	int err;
+
+	err = mpnic_alloc_napi_vectors(mpn);
+	if (err)
+		return err;
+
+	err = mpnic_alloc_resources(mpn);
+	if (err)
+		goto err_free_napi_vectors;
+
+	err = mpnic_set_netif_queues(mpn);
+	if (err)
+		goto err_free_resources;
+
+	mpnic_enable(mpn);
+	mpnic_napi_enable(mpn);
+
+	netif_tx_wake_all_queues(netdev);
+	netif_carrier_on(netdev);
+
+	return 0;
+
+err_free_resources:
+	mpnic_free_resources(mpn);
+err_free_napi_vectors:
+	mpnic_free_napi_vectors(mpn);
+	return err;
+}
+
+static int mpnic_stop(struct net_device *netdev)
+{
+	struct mpnic_net *mpn = netdev_priv(netdev);
+
+	netif_carrier_off(netdev);
+
+	mpnic_napi_disable(mpn);
+	netif_tx_disable(netdev);
+
+	mpnic_disable(mpn);
+	mpnic_wait_all_queues_idle(mpn->mpd);
+	mpnic_flush(mpn);
+
+	mpnic_reset_netif_queues(mpn);
+	mpnic_free_resources(mpn);
+	mpnic_free_napi_vectors(mpn);
+
+	return 0;
+}
+
+static const struct net_device_ops mpnic_netdev_ops = {
+	.ndo_open		= mpnic_open,
+	.ndo_stop		= mpnic_stop,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_start_xmit		= mpnic_xmit_frame,
+};
+
+/**
+ * mpnic_netdev_free - Free the netdev associated with mpnic
+ * @mpd: Driver specific structure to free netdev from
+ **/
+void mpnic_netdev_free(struct mpnic_dev *mpd)
+{
+	free_netdev(mpd->netdev);
+	mpd->netdev = NULL;
+}
+
+/**
+ * mpnic_netdev_alloc - Allocate a netdev and associate it with mpnic
+ * @mpd: Driver specific structure to associate the netdev with
+ *
+ * Return: NULL on failure.
+ **/
+struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
+{
+	struct net_device *netdev;
+	struct mpnic_net *mpn;
+	unsigned int queues;
+
+	netdev = alloc_etherdev_mq(sizeof(*mpn), MPNIC_MAX_RXQS);
+	if (!netdev)
+		return NULL;
+
+	SET_NETDEV_DEV(netdev, mpd->dev);
+	mpd->netdev = netdev;
+
+	netdev->netdev_ops = &mpnic_netdev_ops;
+	netdev->request_ops_lock = true;
+
+	mpn = netdev_priv(netdev);
+	mpn->netdev = netdev;
+	mpn->mpd = mpd;
+
+	mpn->txq_size = MPNIC_TXQ_SIZE_DEFAULT;
+
+	queues = min(netif_get_num_default_rss_queues(),
+		     mpd->num_irqs - MPNIC_NON_NAPI_VECTORS);
+	mpn->num_tx_queues = queues;
+	mpn->num_napi = queues;
+
+	netdev->features |= NETIF_F_SG;
+	netdev->hw_features |= netdev->features;
+	netdev->vlan_features |= netdev->features;
+
+	netdev->min_mtu = IPV6_MIN_MTU;
+	netdev->max_mtu = MPNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
+
+	netif_carrier_off(netdev);
+	netif_tx_stop_all_queues(netdev);
+
+	return netdev;
+}
+
+static int mpnic_dsn_to_mac_addr(u64 dsn, char *addr)
+{
+	addr[0] = (dsn >> 56) & 0xFF;
+	addr[1] = (dsn >> 48) & 0xFF;
+	addr[2] = (dsn >> 40) & 0xFF;
+	addr[3] = (dsn >> 16) & 0xFF;
+	addr[4] = (dsn >> 8) & 0xFF;
+	addr[5] = dsn & 0xFF;
+
+	return is_valid_ether_addr(addr) ? 0 : -EINVAL;
+}
+
+/**
+ * mpnic_netdev_register - Assign the MAC address and register the netdev
+ * @netdev: Netdev to register
+ *
+ * The permanent address is derived from the PCIe device serial number, the
+ * same way the firmware and the BMC derive it. A random address would break
+ * provisioning, so refuse to spawn the interface if the serial number does
+ * not yield a valid one.
+ *
+ * Return: non-zero on failure.
+ **/
+int mpnic_netdev_register(struct net_device *netdev)
+{
+	struct mpnic_net *mpn = netdev_priv(netdev);
+	struct mpnic_dev *mpd = mpn->mpd;
+	u8 addr[ETH_ALEN];
+	int err;
+
+	err = mpnic_dsn_to_mac_addr(mpd->dsn, addr);
+	if (err) {
+		dev_err(mpd->dev, "MAC addr %pM invalid\n", addr);
+		return err;
+	}
+
+	ether_addr_copy(netdev->perm_addr, addr);
+	eth_hw_addr_set(netdev, addr);
+
+	/* Abort if MMIO has failed. This has to be the last check before
+	 * registration, the register accessors can only detach the device
+	 * once it has been registered.
+	 */
+	if (!mpnic_present(mpd))
+		return -EIO;
+
+	return register_netdev(netdev);
+}
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
index f98adf209b45..df682d194826 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
@@ -23,4 +23,8 @@ struct mpnic_net {
 	u16 num_tx_queues;
 };
 
+struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd);
+void mpnic_netdev_free(struct mpnic_dev *mpd);
+int mpnic_netdev_register(struct net_device *netdev);
+
 #endif /* _MPNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
index 127b71b44b0f..968cd611b8ea 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
@@ -4,11 +4,13 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
 #include "mpnic.h"
+#include "mpnic_netdev.h"
 
 #define PCI_DEVICE_ID_META_MPNIC	0x0014
 
@@ -20,6 +22,10 @@ static void mpnic_mmio_err(struct mpnic_dev *mpd, u32 reg)
 	dev_err(mpd->dev,
 		"Failed read (idx 0x%x AKA addr 0x%x), disabled CSR access, awaiting reset\n",
 		reg, reg << 2);
+
+	/* Tell the stack the device has lost its PCIe link */
+	if (mpd->netdev)
+		netif_device_detach(mpd->netdev);
 }
 
 u64 mpnic_rd64(struct mpnic_dev *mpd, u32 reg)
@@ -58,6 +64,7 @@ static struct mpnic_dev *mpnic_alloc(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, mpd);
 	mpd->dev = &pdev->dev;
 
+	mpd->dsn = pci_get_dsn(pdev);
 	mpd->mps = pcie_get_mps(pdev);
 	mpd->readrq = pcie_get_readrq(pdev);
 	mpd->relaxed_ord = pcie_relaxed_ordering_enabled(pdev);
@@ -74,6 +81,7 @@ static struct mpnic_dev *mpnic_alloc(struct pci_dev *pdev)
  **/
 static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	struct net_device *netdev;
 	void __iomem *uc_addr0;
 	struct mpnic_dev *mpd;
 	int err;
@@ -120,8 +128,23 @@ static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_free_irqs;
 
+	netdev = mpnic_netdev_alloc(mpd);
+	if (!netdev) {
+		dev_err(&pdev->dev, "Netdev allocation failed\n");
+		err = -ENOMEM;
+		goto err_free_irqs;
+	}
+
+	err = mpnic_netdev_register(netdev);
+	if (err) {
+		dev_err(&pdev->dev, "Netdev registration failed: %d\n", err);
+		goto err_free_netdev;
+	}
+
 	return 0;
 
+err_free_netdev:
+	mpnic_netdev_free(mpd);
 err_free_irqs:
 	mpnic_free_irqs(mpd);
 err_free_mpd:
@@ -138,6 +161,8 @@ static void mpnic_remove(struct pci_dev *pdev)
 {
 	struct mpnic_dev *mpd = pci_get_drvdata(pdev);
 
+	unregister_netdev(mpd->netdev);
+	mpnic_netdev_free(mpd);
 	mpnic_free_irqs(mpd);
 	kfree(mpd);
 }
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index cb4d1427434c..f4ad8caf6ce6 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -17,6 +17,8 @@ struct mpnic_xmit_cb {
 };
 
 #define MPNIC_XMIT_CB(__skb) ((struct mpnic_xmit_cb *)((__skb)->cb))
+#define MPNIC_TWD_TYPE_MASK(_type) \
+	cpu_to_le64(FIELD_PREP(MPNIC_TWD_TYPE, MPNIC_TWD_TYPE_##_type))
 
 /* Leave the interrupt moderation counters alone when arming or masking */
 #define MPNIC_TIM_PARAM_CFG_PRESERVE_MASK \
@@ -51,6 +53,29 @@ static struct netdev_queue *mpnic_txring_txq(const struct net_device *dev,
 	return netdev_get_tx_queue(dev, ring->q_idx);
 }
 
+static void mpnic_tx_doorbell(struct mpnic_ring *ring, __le64 *meta)
+{
+	*meta |= cpu_to_le64(MPNIC_TWD_FLAG_REQ_COMPLETION);
+	ring->deferred_meta = -1;
+
+	/* Force DMA writes to flush before writing to tail */
+	dma_wmb();
+
+	writeq(ring->tail, ring->doorbell);
+}
+
+/* Packets handed to us with xmit_more set are left in the ring without a
+ * doorbell, and without a completion request, in the expectation that the
+ * packet ending the burst will ring for all of them. If that packet gets
+ * dropped instead we have to ring here, otherwise the descriptors sit in
+ * the ring until the next transmit, which may never come.
+ */
+static void mpnic_tx_flush_doorbell(struct mpnic_ring *ring)
+{
+	if (ring->deferred_meta >= 0)
+		mpnic_tx_doorbell(ring, &ring->desc[ring->deferred_meta]);
+}
+
 static void mpnic_unmap_single_twd(struct device *dev, __le64 *twd)
 {
 	u64 raw_twd = le64_to_cpu(*twd);
@@ -67,6 +92,138 @@ static void mpnic_unmap_page_twd(struct device *dev, __le64 *twd)
 		       FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
 }
 
+static bool
+mpnic_tx_map(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
+{
+	struct device *dev = skb->dev->dev.parent;
+	unsigned int tail = ring->tail, first;
+	unsigned int size, data_len;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+	__le64 *twd;
+
+	tail++;
+	tail &= ring->size_mask;
+	first = tail;
+
+	size = skb_headlen(skb);
+	data_len = skb->data_len;
+
+	if (size > FIELD_MAX(MPNIC_TWD_LEN))
+		goto err_dma;
+
+	dma = dma_map_single(dev, skb->data, size, DMA_TO_DEVICE);
+
+	for (frag = &skb_shinfo(skb)->frags[0];; frag++) {
+		twd = &ring->desc[tail];
+
+		if (dma_mapping_error(dev, dma))
+			goto err_dma;
+
+		*twd = cpu_to_le64(FIELD_PREP(MPNIC_TWD_ADDR, dma) |
+				   FIELD_PREP(MPNIC_TWD_LEN, size) |
+				   FIELD_PREP(MPNIC_TWD_TYPE,
+					      MPNIC_TWD_TYPE_AL));
+
+		tail++;
+		tail &= ring->size_mask;
+
+		if (!data_len)
+			break;
+
+		size = skb_frag_size(frag);
+		data_len -= size;
+
+		if (size > FIELD_MAX(MPNIC_TWD_LEN))
+			goto err_dma;
+
+		dma = skb_frag_dma_map(dev, frag, 0, size, DMA_TO_DEVICE);
+	}
+
+	*twd |= MPNIC_TWD_TYPE_MASK(LAST_AL);
+
+	MPNIC_XMIT_CB(skb)->desc_count = ((twd - meta) + 1) & ring->size_mask;
+
+	skb_tx_timestamp(skb);
+
+	ring->tail = tail;
+
+	/* Verify there is room for another packet */
+	netif_txq_maybe_stop(mpnic_txring_txq(skb->dev, ring),
+			     mpnic_desc_unused(ring), MPNIC_MAX_SKB_DESC,
+			     MPNIC_TX_DESC_WAKEUP);
+
+	if (__netdev_tx_sent_queue(mpnic_txring_txq(skb->dev, ring),
+				   MPNIC_XMIT_CB(skb)->bytecount,
+				   netdev_xmit_more()))
+		mpnic_tx_doorbell(ring, meta);
+	else
+		ring->deferred_meta = meta - ring->desc;
+
+	return false;
+err_dma:
+	if (net_ratelimit())
+		netdev_err(skb->dev, "TX DMA map failed\n");
+
+	while (tail != first) {
+		tail--;
+		tail &= ring->size_mask;
+		twd = &ring->desc[tail];
+		if (tail == first)
+			mpnic_unmap_single_twd(dev, twd);
+		else
+			mpnic_unmap_page_twd(dev, twd);
+	}
+
+	return true;
+}
+
+#define MPNIC_MIN_FRAME_LEN	60
+
+static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
+					 struct mpnic_ring *ring)
+{
+	__le64 *meta = &ring->desc[ring->tail];
+	u32 tail = ring->tail;
+
+	if (skb_put_padto(skb, MPNIC_MIN_FRAME_LEN))
+		goto err_drop;
+
+	if (!netif_txq_maybe_stop(mpnic_txring_txq(skb->dev, ring),
+				  mpnic_desc_unused(ring), MPNIC_MAX_SKB_DESC,
+				  MPNIC_TX_DESC_WAKEUP)) {
+		mpnic_tx_flush_doorbell(ring);
+		return NETDEV_TX_BUSY;
+	}
+
+	ring->tx_buf[tail] = skb;
+	*meta = cpu_to_le64(MPNIC_TWD_FLAG_DEST_MAC);
+
+	MPNIC_XMIT_CB(skb)->bytecount = skb->len;
+	MPNIC_XMIT_CB(skb)->desc_count = 0;
+
+	if (mpnic_tx_map(ring, skb, meta))
+		goto err_free;
+
+	return NETDEV_TX_OK;
+
+err_free:
+	dev_kfree_skb_any(skb);
+	ring->tx_buf[tail] = NULL;
+	ring->tail = tail;
+err_drop:
+	mpnic_tx_flush_doorbell(ring);
+
+	return NETDEV_TX_OK;
+}
+
+netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
+{
+	struct mpnic_net *mpn = netdev_priv(dev);
+
+	return mpnic_xmit_frame_ring(skb, mpn->tx[skb_get_queue_mapping(skb)]);
+}
+
 static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
 			     struct mpnic_ring *ring, bool discard,
 			     unsigned int hw_head)
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 68a773133fa2..2add4ad0d39a 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -26,6 +26,10 @@ struct mpnic_net;
 
 #define MPNIC_MAX_NAPI_VECTORS		1024u
 
+#define MPNIC_TXQ_SIZE_DEFAULT		1024
+
+#define MPNIC_MAX_JUMBO_FRAME_SIZE	9742
+
 struct mpnic_ring {
 	void **tx_buf;			/* Packets outstanding in a TWQ */
 
@@ -68,6 +72,7 @@ struct mpnic_napi_vector {
 	struct mpnic_q_triad qt[];
 };
 
+netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, struct net_device *dev);
 int mpnic_alloc_napi_vectors(struct mpnic_net *mpn);
 void mpnic_free_napi_vectors(struct mpnic_net *mpn);
 int mpnic_alloc_resources(struct mpnic_net *mpn);

-- 
2.52.0

