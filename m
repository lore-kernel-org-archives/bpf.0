Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85EE352C28
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296547; cv=none; b=jugWj4Q4hxslMz9z/+0mCCamNvz82L85aJzyo7KyEzx3gvFuiBDBpawlTsBW5/mJDsgELYjX0a0drVRHAsltgD47WHIscJQAyvfLLOTIbDB3YPBgvbQQkTQ6Kk0dghLQo4olITLvppFnQpBB4AFBJlx6KVjWXlLeCgp+SYn7nIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296547; c=relaxed/simple;
	bh=dHACLV7Lmedm6dmsQJOIMIU0/2cv0u/wBQaJMn1mBeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6X7hgR2tTnGI7ZFIyrRDGmBN2jrrscFsc+3V9cQAS365mkGa7u0bBwGPdWaKSszII0AMCy23Bwa9wdzWT8H02YvwNHGgTNhP1VyqM+EdLzqIpTGqVZxZemfvxDPu7nUrP9mhEH2bUiZwl9wPhKaq+lt4679FNBSgm1UiISgmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfAZZPOg; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfAZZPOg"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae7166edso262233eaf.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790296544; x=1790901344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5DPG/L5ZyzAMk0X6UHwEgsS2grG+WhkUqzd5N0LXg8M=;
        b=VfAZZPOgvVQbPhnSHLRQEwRUTkIh7C5jqvTR83pQda3OK2M5PGYy7kFaYe7SChOY7p
         su/Yv7VQJ1aoiQA/xMuoQ7c2J2bGRM0f0nwC0BCFQkGh8Z/caCpxGmE1pu6Xpm6iC4dZ
         EkHzzoS0ztcH84/6wu0BFdMmWKUicb00AxRs7tC/g8GqShLGrn5hV1s69GT8bwOaaVRC
         vaz4EPFwf3knc+H3qRf1B8FbxaN6ctw299Q194UYUN29zQ3fiOPHTDfSIMkvAB220zfP
         JE+6S4mgtcrCU7n7ZpABzfRxK5A2BBW18DWkqxXVFWm3m52bJNWftny21t811abVm4Qa
         IGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296544; x=1790901344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5DPG/L5ZyzAMk0X6UHwEgsS2grG+WhkUqzd5N0LXg8M=;
        b=BdxLnY1WPKxlx8MF/9dGAegXxSBR21/1c3kiGcI+S+zrrEcVQJsRVqymB5ZeNlJyJy
         7hvdzYcJOX0+MiCOPmfJ1E4WFrOZAXYkNNizwZxjnA9KiMqBQ9Foh/rRzxjAQRCgvpAJ
         FcF8w5oENCydrBrIHljqAMHW257GV9LtVkzg3glPFDTuv25auQaNNJfaIkvBQAwKM7g0
         kjWrTvoaiKkoFSFPYQGEQ+KS4O7XtUf7gwSTjsf+J3k9uPQx2qgH/OvZNmgahvJ8X8TB
         S5n5lRhU5cPg7+AC3Opfj8cH/Kle/5hfntEbIe5DQ9TkdIn/eJarpCQIBmV/hyYq+Ceu
         wDQw==
X-Forwarded-Encrypted: i=1; AKwUvBzmSeyh/cHi7cn6in9WPmb7SXt/eVHE01O6eHd8e1MRe+NVwz8xaBeeAzIzp0XORteTYoI=@vger.kernel.org
X-Gm-Message-State: AFuF++mzvGiq/amg4PKDeuqCSjnjJaOalhDF7ECPoXmYBPUDWONcwFC7
	juLpL/I8zanuuvC5t6ct7giV8ahSOeoFA+MO8WrO6u0HygIb7ioKS7Bo
X-Gm-Gg: AYBFou3DPHZeshpsNECcWdfAE91a0MFhf83cvjt7Xn1ZEmZ4aGVnknaBCJjqlOZtuid
	Zd2AxEOSfk5hMQFFYD2edxOU/7sXyu3zlykrKDeC2acVdTR4nlprguuuyVBsNM26XyyT4OpsICR
	gEZtd3Y057v5mVqFWDc3QJYps7jQQHXBy+nfhCAMF5dJuj4bpg+CWC0L8cGssYaPZrn/yM4UbM5
	fg7vOOX/eWQQrwl3Y1ZvNf0/WCmb3m9cP8L1M/mp1ixgptPX2sbxJJCBGYXPYGln9TkPr0x8ToC
	gPUlK4JXMTCxX2Prt62U3dZMWn3MTmqh3e6NWBNQFfiTIMzrVC83mdEmSJnGxiDVvRPh8917vNF
	K5guf4ko84FHcXaVMUen3uEPw0/2Z5X4vlEHSQO8G8HtLumLNECJspiiZxuGHMgqMx8pXXMGPwz
	U3YuPXwOhWozxG5uOoJDlduHGbWysZbhBZONErNUhCpLA8w+u0qpMgE1RmVV+U/Vt0
X-Received: by 2002:a05:6820:81cf:b0:6c0:6199:8274 with SMTP id 006d021491bc7-6d4417a054bmr4681259eaf.63.1790296543721;
        Thu, 24 Sep 2026 17:35:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d583062e77sm1402767eaf.13.2026.09.24.17.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:35:42 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 24 Sep 2026 17:35:19 -0700
Subject: [PATCH net-next v2 6/8] eth: mpnic: add a netdevice and basic Tx
 handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-linux-mpnic-v2-6-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
In-Reply-To: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
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
v2:
- trim the real Tx queue count before register_netdev()
---
 drivers/net/ethernet/meta/mpnic/Makefile       |   1 +
 drivers/net/ethernet/meta/mpnic/mpnic.h        |   2 +
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |   7 +
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 180 +++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |   4 +
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c    |  25 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 157 +++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |   5 +
 8 files changed, 381 insertions(+)

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
index 44ff664e3f3b..978622bf40c9 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -14,6 +14,13 @@
 
 /* Transmit Work Descriptor Format */
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
index 000000000000..6d5007be6cad
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -0,0 +1,180 @@
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
+static int mpnic_dsn_to_mac_addr(u64 dsn, u8 *addr)
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
+	err = netif_set_real_num_tx_queues(netdev, mpn->num_tx_queues);
+	if (err)
+		return err;
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
index aaa3a3e99a13..b1fb0d3902a7 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -17,6 +17,8 @@ struct mpnic_xmit_cb {
 };
 
 #define MPNIC_XMIT_CB(__skb) ((struct mpnic_xmit_cb *)((__skb)->cb))
+#define MPNIC_TWD_TYPE_MASK(_type) \
+	cpu_to_le64(FIELD_PREP(MPNIC_TWD_TYPE, MPNIC_TWD_TYPE_##_type))
 
 /* Leave the interrupt moderation counters alone when arming or masking */
 #define MPNIC_TIM_PARAM_CFG_PRESERVE_MASK \
@@ -58,6 +60,29 @@ static struct netdev_queue *mpnic_txring_txq(const struct net_device *dev,
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
@@ -74,6 +99,138 @@ static void mpnic_unmap_page_twd(struct device *dev, __le64 *twd)
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

