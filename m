Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4E32E128
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296552; cv=none; b=QY1QQwGDdQofk7r2HmQAJOaAfFSCyt/KIXj3QF7FjnyueWERdIGLv+LWB6bQnAUeMfm6tIS1viegpW+0FqQ3NNwdhMYvEPipLl3afRVBfv3PeP1C3nmpetnurw+8TTYpe5zKeKOb/A7UHnQ89Wemq+rPFsICxhS8NLHQfsU170E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296552; c=relaxed/simple;
	bh=HwALT8qXc7FwJZvy6mt5DSl7its4/vyWNZbWuvUfZqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usR7zIcJFmhJzTljBhLSJEYLJr9bIz6ef1RI1r8bUrw+P6Lo73/MGy8vopWP8xpwEgW8Va0DlkatBrU+t2xBetujXlhDPhnIccXjTNU6X0Mpg8OagDRUUn7KUVvsZxgGgR9Gf2IGKmkNkTaF84pgrBojXRRzrtpAq8qocLWGF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emVywgRw; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emVywgRw"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae7166edso262257eaf.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790296547; x=1790901347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cuEN7tDoNXsSaZOpFmWV+DEzr0+vXzgSL1rqiaC1QpQ=;
        b=emVywgRwHzN2PyUFZ1DOfjNEPl/vOAuLnhgqIb8OBtYWWdtPBsnIDUkY7e7wyOVefA
         Q9lZY8Qtdg8RcKYoA2xjQrXDG+ekxbyJhiJqaHE0qixao+z4hJ4VcCF4Ir+jEuVWfSSi
         cZc3d2sUotnvYkVd7jeYiw31ofSKqSAfosHtJdvg7FkiiFoZaMmCWXUWbPGGyyEXxWjX
         mxF4Qq2YcOccAsfIHtKU8DdFXz1lECzR9VuzSsstwSlk4zpzhjDoidDim6yKsVmHOtNv
         8QzsYXIHO083urtVQLrWCyD2fsybLOeN19sZzU2p4igtCp0wLYIw/k87bYfjvBGVDSJJ
         OadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296547; x=1790901347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cuEN7tDoNXsSaZOpFmWV+DEzr0+vXzgSL1rqiaC1QpQ=;
        b=dwjBOYtBXEC3X59qSCjrkQN+xL+vfx37C0PO08wIP7EUB6MPOwjMBdEg+2mXbAY0EM
         ouRpvWazSJdhyR7e/BldE2I8YX4fsULcpVfgrY6R3qalq4RTBqFPgsXid9Y84HtuEbAP
         9K/4auGAriLq5CExhjWQstJyPzP/5TL6Kmwd7h8R3IExf+Y6hCAnwUA+LeKq/tJCMajO
         5LH8wguXS8egSweVlP2LT7r6pKoXaEgRgQbwX4X0S6yJUUQyEvW1RqMPLYBMQjl95Coi
         5qvT1HLK/cnhU3RT6ULqtVOnKqtk9SO56B8hx1hPcwsRzspdX/lWKsj5D5vLS56heC10
         QWCg==
X-Forwarded-Encrypted: i=1; AKwUvBwubgTR4AQyL3RwkZbfK3skKYwusKVNe052cjHIA2tEliA4FV1eAsb/oylXNcwRghR/i9M=@vger.kernel.org
X-Gm-Message-State: AFuF++nW1K/AIp7982xgVDErSzqFM1vzlM9h84iW7sGE5iaCDG3FXbv0
	x9jc+7y/156F+OVVv2izg1xn/CcA8wWjDV7HpBW9bJwxo7RQ4JdlFLmO
X-Gm-Gg: AYBFou1ndVOLdSGK25JYMY3DgdsDK53TRJz1tFfYGZYY8WHUOsetuNfBS4B8+nLcsXD
	rKvISpz1kTx28dcPh9Re+28GwsdCh1mEkbH+BDsBV7zK/nxzxTrjPOgQQVf6Xskrh685djmTRaK
	55SRcIuwZlt//uqBMQ9Xk2WFeRegs7rK59i4pilDAoF8pkWwecKJBB0n+JNcRXjAmCZ78BoDK8z
	+13EC/0igRRAchg6HZzqUlaGWMsbahxcAj3+f4QvyE7qcFBafLKVIfMEu2wAwOibjeWPAmrwFb1
	H4I4GVK1mG2LK8cf/vAeL4O4ICpBASSdrdbnUm8Baj+o22Vvg8/VbBW9pAQZyQYR/zghhHcDSwF
	cDCrNf2N0ShpD3xlFzcpHrfLey/unupg3t0N7FZrLK2BgFcAkKe4Z/XsuhI3+Uv0MJ/B3XCghl4
	fbfS8wmaefMD8U6mxyXPk+pDxQkAdiGVDofIouEzYFNt4WAEw+tMXuJEK9q4o3vnt2U5+gT0dp1
	c/m7qc=
X-Received: by 2002:a05:6820:4b06:b0:6cc:d532:4825 with SMTP id 006d021491bc7-6d43f2cb79bmr4104088eaf.6.1790296546980;
        Thu, 24 Sep 2026 17:35:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d581dc77b5sm1447833eaf.3.2026.09.24.17.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:35:46 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 24 Sep 2026 17:35:20 -0700
Subject: [PATCH net-next v2 7/8] eth: mpnic: implement Rx queue allocation
 and cleanup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-linux-mpnic-v2-7-4badc9b58b9e@gmail.com>
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

The Rx side of a queue triad is a header queue, a payload queue and a
completion queue. With HDS not active yet, frames are split between the
two buffer queues at a fixed header boundary: everything up to 1536
bytes lands in the header page, the rest goes to the payload page. Small
frames therefore never touch the payload queue, and several of them
share one header page.

The device is set to leave headroom and tailroom for XDP and
skb_shared_info respectively.

Both queues draw from one page pool per triad and post buffer
descriptors to the device in batches.

Even though we do not support XDP yet, use the XDP APIs for tracking
pre-skb buffers. The XDP buffer handling helpers save us from
reimplementing the same logic in the driver.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v2:
- drop an inaccurate comment on mpnic_bdq_desc_unused()
- drop the unused data_truesize field from struct mpnic_pkt_ctxt
- trim the real Rx queue count before register_netdev() too
---
 drivers/net/ethernet/meta/Kconfig              |   1 +
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  67 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |   8 +-
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |   5 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 447 +++++++++++++++++++++++--
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  71 +++-
 6 files changed, 554 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index f940048a5e37..f8b5fe7e31b7 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -40,6 +40,7 @@ config MPNIC
 	depends on 64BIT || COMPILE_TEST
 	depends on !S390
 	depends on PCI_MSI
+	select PAGE_POOL
 	help
 	  This driver supports the Meta Platforms Network Interface
 	  Controller.
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index 978622bf40c9..6455ec23b6c7 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -29,6 +29,38 @@ enum {
 #define MPNIC_TCD_TYPE0_HEAD0		DESC_GENMASK(15, 0)
 #define MPNIC_TCD_DONE			DESC_BIT(63)
 
+/* Rx Buffer Descriptor Format */
+#define MPNIC_BD_DESC_ADDR		DESC_GENMASK(39, 2)
+#define MPNIC_BD_DESC_ID		DESC_GENMASK(57, 40)
+#define MPNIC_BD_DESC_BUF_SZ_LOG2	DESC_GENMASK(62, 58)
+
+/* Rx Completion Queue Descriptors */
+#define MPNIC_RCD_TYPE			DESC_GENMASK(62, 61)
+enum {
+	MPNIC_RCD_TYPE_HDR_AL	= 0,
+	MPNIC_RCD_TYPE_PAY_AL	= 1,
+	MPNIC_RCD_TYPE_META	= 3,
+};
+
+#define MPNIC_RCD_DONE			DESC_BIT(63)
+
+#define MPNIC_RCD_HDR_SUBTYPE		DESC_GENMASK(60, 59)
+enum {
+	MPNIC_RCD_HDR_SUBTYPE_HDR	= 2,
+};
+
+/* Address/Length Completion Descriptors */
+#define MPNIC_RCD_AL_BUFF_OFF		DESC_GENMASK(15, 0)
+#define MPNIC_RCD_AL_BUFF_ID		DESC_GENMASK(33, 16)
+#define MPNIC_RCD_AL_BUFF_LEN		DESC_GENMASK(47, 34)
+#define MPNIC_RCD_AL_PAGE_FIN		DESC_BIT(53)
+
+/* Metadata Completion Descriptors */
+#define MPNIC_RCD_META_ERR_MAC_EOP		DESC_BIT(53)
+#define MPNIC_RCD_META_ERR_TRUNCATED_FRAME	DESC_BIT(54)
+#define MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK	\
+	(MPNIC_RCD_META_ERR_MAC_EOP | MPNIC_RCD_META_ERR_TRUNCATED_FRAME)
+
 /* Common fields for all DESC_CFG CSRs */
 #define MPNIC_DESC_CFG_NUM_DESCS	CSR_GENMASK(2, 0)
 #define MPNIC_DESC_CFG_START_ADDR	CSR_GENMASK(19, 8)
@@ -75,10 +107,43 @@ enum {
 #define MPNIC_TIM_INTR_MASK(i)		(0xc8 + 1024 * (i))	/* 0x320 */
 #define MPNIC_TIM_INTR_MASK_MASK		CSR_BIT(0)
 
+/* NIC_CORE_RBP */
+#define MPNIC_BDQ_CTL(i)		(0x200 + 1024 * (i))	/* 0x800 */
+#define MPNIC_BDQ_CTL_RESET			CSR_BIT(0)
+#define MPNIC_BDQ_CTL_ENABLE			CSR_BIT(1)
+#define MPNIC_BDQ_CTL_ENABLE_PPQ		CSR_BIT(3)
+#define MPNIC_HPQ_TAIL(i)		(0x202 + 1024 * (i))	/* 0x808 */
+#define MPNIC_PPQ_TAIL(i)		(0x204 + 1024 * (i))	/* 0x810 */
+#define MPNIC_HPQ_SIZE(i)		(0x20a + 1024 * (i))	/* 0x828 */
+#define MPNIC_HPQ_SIZE_SIZE			CSR_GENMASK(4, 0)
+#define MPNIC_PPQ_SIZE(i)		(0x20c + 1024 * (i))	/* 0x830 */
+#define MPNIC_PPQ_SIZE_SIZE			CSR_GENMASK(4, 0)
+#define MPNIC_HPQ_BASE_ADDR(i)		(0x216 + 1024 * (i))	/* 0x858 */
+#define MPNIC_PPQ_BASE_ADDR(i)		(0x218 + 1024 * (i))	/* 0x860 */
+
+/* NIC_CORE_RCM */
+#define MPNIC_RCQ_CTL(i)		(0x280 + 1024 * (i))	/* 0xa00 */
+#define MPNIC_RCQ_CTL_RESET			CSR_BIT(0)
+#define MPNIC_RCQ_CTL_ENABLE			CSR_BIT(1)
+#define MPNIC_RCQ_BASE_ADDR(i)		(0x286 + 1024 * (i))	/* 0xa18 */
+#define MPNIC_RCQ_HEAD(i)		(0x28e + 1024 * (i))	/* 0xa38 */
+#define MPNIC_RCQ_SIZE(i)		(0x294 + 1024 * (i))	/* 0xa50 */
+#define MPNIC_RCQ_SIZE_SIZE			CSR_GENMASK(4, 0)
+
 /* NIC_CORE_TIM_PRV */
 #define MPNIC_TIM_CTL(i)		(0x100100 + 1024 * (i))	/* 0x400400 */
 
+/* NIC_CORE_RDE */
+#define MPNIC_RDE_CFG(i)		(0x10021c + 1024 * (i))	/* 0x400870 */
+#define MPNIC_RDE_CFG_MIN_TAIL_ROOM		CSR_GENMASK(9, 0)
+#define MPNIC_RDE_CFG_MIN_HEAD_ROOM		CSR_GENMASK(18, 10)
+#define MPNIC_RDE_CFG_MAX_HEADER_BYTES		CSR_GENMASK(45, 32)
+
 /* NIC_CORE_RBP_HP_GLBL */
+#define MPNIC_HPQ_IDLE(i)		(0x420000 + 2 * (i))	/* 0x1080000 */
+#define MPNIC_HPQ_IDLE_CNT		16
+#define MPNIC_PPQ_IDLE(i)		(0x420060 + 2 * (i))	/* 0x1080180 */
+#define MPNIC_PPQ_IDLE_CNT		16
 #define MPNIC_BDQ_GLBL_CTL0		0x420080		/* 0x1080200 */
 #define MPNIC_BDQ_GLBL_CTL0_MAX_REQ_SIZE	CSR_GENMASK(26, 18)
 #define MPNIC_BDQ_GLBL_CTL0_PREFETCH_SPACE_THRESH \
@@ -99,6 +164,8 @@ enum {
 #define MPNIC_RDE_MEM_INIT_DONE		0x4240e8		/* 0x10903a0 */
 
 /* NIC_CORE_RCM_GLBL */
+#define MPNIC_RCQ_IDLE(i)		(0x42505e + 2 * (i))	/* 0x1094178 */
+#define MPNIC_RCQ_IDLE_CNT		16
 #define MPNIC_RCM_MEM_INIT_REQ		0x42507e		/* 0x10941f8 */
 #define MPNIC_RCM_MEM_INIT_DONE		0x425080		/* 0x1094200 */
 
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index 6d5007be6cad..2c0309d0c221 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -29,6 +29,7 @@ static int mpnic_open(struct net_device *netdev)
 		goto err_free_resources;
 
 	mpnic_enable(mpn);
+	mpnic_fill(mpn);
 	mpnic_napi_enable(mpn);
 
 	netif_tx_wake_all_queues(netdev);
@@ -107,10 +108,14 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 	mpn->mpd = mpd;
 
 	mpn->txq_size = MPNIC_TXQ_SIZE_DEFAULT;
+	mpn->hpq_size = MPNIC_HPQ_SIZE_DEFAULT;
+	mpn->ppq_size = MPNIC_PPQ_SIZE_DEFAULT;
+	mpn->rcq_size = MPNIC_RCQ_SIZE_DEFAULT;
 
 	queues = min(netif_get_num_default_rss_queues(),
 		     mpd->num_irqs - MPNIC_NON_NAPI_VECTORS);
 	mpn->num_tx_queues = queues;
+	mpn->num_rx_queues = queues;
 	mpn->num_napi = queues;
 
 	netdev->features |= NETIF_F_SG;
@@ -165,7 +170,8 @@ int mpnic_netdev_register(struct net_device *netdev)
 	ether_addr_copy(netdev->perm_addr, addr);
 	eth_hw_addr_set(netdev, addr);
 
-	err = netif_set_real_num_tx_queues(netdev, mpn->num_tx_queues);
+	err = netif_set_real_num_queues(netdev, mpn->num_tx_queues,
+					mpn->num_rx_queues);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
index df682d194826..ccb0929f9180 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
@@ -11,6 +11,7 @@
 
 struct mpnic_net {
 	struct mpnic_ring *tx[MPNIC_MAX_TXQS];
+	struct mpnic_ring *rx[MPNIC_MAX_RXQS];
 
 	struct mpnic_napi_vector *napi[MPNIC_MAX_NAPI_VECTORS];
 
@@ -18,9 +19,13 @@ struct mpnic_net {
 	struct mpnic_dev *mpd;
 
 	u32 txq_size;
+	u32 hpq_size;
+	u32 ppq_size;
+	u32 rcq_size;
 
 	u16 num_napi;
 	u16 num_tx_queues;
+	u16 num_rx_queues;
 };
 
 struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd);
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index b1fb0d3902a7..389a9e5476c6 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -6,6 +6,7 @@
 #include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <net/page_pool/helpers.h>
 
 #include "mpnic.h"
 #include "mpnic_netdev.h"
@@ -342,6 +343,105 @@ static void mpnic_clean_tcq(struct mpnic_napi_vector *nv,
 		mpnic_clean_twq0(nv, napi_budget, &qt->sub0, false, head0);
 }
 
+static void mpnic_bd_prep(struct mpnic_ring *bdq, u32 idx, struct page *page)
+{
+	dma_addr_t dma = page_pool_get_dma_addr(page);
+
+	bdq->desc[idx] = cpu_to_le64(FIELD_PREP(MPNIC_BD_DESC_ADDR, dma >> 10) |
+				     FIELD_PREP(MPNIC_BD_DESC_ID, idx) |
+				     FIELD_PREP(MPNIC_BD_DESC_BUF_SZ_LOG2,
+						page_shift(page) - 10));
+}
+
+static unsigned int mpnic_bdq_desc_unused(struct mpnic_ring *bdq)
+{
+	return (ALIGN_DOWN(bdq->head - 1, MPNIC_BDQ_BATCH_SIZE) - bdq->tail) &
+	       bdq->size_mask;
+}
+
+static unsigned int __mpnic_fill_bdq(struct mpnic_ring *bdq)
+{
+	unsigned int i = bdq->tail;
+	unsigned int count;
+
+	for (count = mpnic_bdq_desc_unused(bdq); count; count--) {
+		struct page *page;
+
+		page = page_pool_dev_alloc_pages(bdq->page_pool);
+		if (!page)
+			break;
+
+		bdq->rx_buf[i] = page;
+		mpnic_bd_prep(bdq, i, page);
+
+		i++;
+		i &= bdq->size_mask;
+	}
+
+	return i;
+}
+
+static void __mpnic_bdq_commit_tail(struct mpnic_ring *bdq, unsigned int tail)
+{
+	if (bdq->tail != tail) {
+		bdq->tail = tail;
+
+		writeq(tail, bdq->doorbell);
+	}
+}
+
+static void mpnic_fill_qt_bdqs(struct mpnic_q_triad *qt)
+{
+	unsigned int ppq_i = __mpnic_fill_bdq(&qt->sub1);
+	unsigned int hpq_i = __mpnic_fill_bdq(&qt->sub0);
+
+	/* Force DMA writes to flush before writing to tail(s) */
+	dma_wmb();
+
+	/* Flush out the completions we are done with */
+	mpnic_commit_cq_head(&qt->cmpl);
+
+	__mpnic_bdq_commit_tail(&qt->sub0, hpq_i);
+	__mpnic_bdq_commit_tail(&qt->sub1, ppq_i);
+}
+
+static void mpnic_flush_pg_ctxt(struct mpnic_pg_ctxt *ctxt, bool napi)
+{
+	long pagecnt_bias = ctxt->pagecnt_bias;
+
+	if (pagecnt_bias) {
+		struct page *page = ctxt->page;
+
+		if (!page_pool_unref_page(page, pagecnt_bias))
+			page_pool_put_unrefed_page(page->pp, page, -1, napi);
+	}
+}
+
+static void mpnic_put_pkt_buff(struct mpnic_pkt_ctxt *ctxt, bool napi)
+{
+	struct xdp_buff *buff = &ctxt->buff;
+	struct page *page;
+
+	if (!buff->data_hard_start)
+		return;
+
+	if (unlikely(xdp_buff_has_frags(buff))) {
+		struct skb_shared_info *shinfo;
+		int nr_frags;
+
+		shinfo = xdp_get_shared_info_from_buff(buff);
+		nr_frags = shinfo->nr_frags;
+
+		while (nr_frags--) {
+			page = skb_frag_page(&shinfo->frags[nr_frags]);
+			page_pool_put_full_page(page->pp, page, napi);
+		}
+	}
+
+	page = virt_to_head_page(buff->data_hard_start);
+	page_pool_put_full_page(page->pp, page, napi);
+}
+
 static int mpnic_poll(struct napi_struct *napi, int budget)
 {
 	struct mpnic_napi_vector *nv = container_of(napi,
@@ -373,11 +473,14 @@ static irqreturn_t mpnic_msix_clean_rings(int __always_unused irq, void *data)
 static void mpnic_free_napi_vector(struct mpnic_net *mpn,
 				   struct mpnic_napi_vector *nv)
 {
-	int i;
+	int i, j;
 
 	for (i = 0; i < nv->txt_count; i++)
 		mpn->tx[nv->qt[i].sub0.q_idx] = NULL;
 
+	for (j = 0; j < nv->rxt_count; j++, i++)
+		mpn->rx[nv->qt[i].cmpl.q_idx] = NULL;
+
 	mpnic_free_irq(nv->mpd, nv->v_idx, nv);
 	netif_napi_del_locked(&nv->napi);
 	mpn->napi[nv->v_idx - MPNIC_NON_NAPI_VECTORS] = NULL;
@@ -413,11 +516,12 @@ static int mpnic_alloc_napi_vector(struct mpnic_dev *mpd,
 	if (!uc_addr)
 		return -EIO;
 
-	nv = kzalloc_flex(*nv, qt, 1);
+	nv = kzalloc_flex(*nv, qt, 2);
 	if (!nv)
 		return -ENOMEM;
 
 	nv->txt_count = 1;
+	nv->rxt_count = 1;
 	nv->mpd = mpd;
 	nv->dev = mpd->dev;
 	nv->v_idx = idx + MPNIC_NON_NAPI_VECTORS;
@@ -440,6 +544,11 @@ static int mpnic_alloc_napi_vector(struct mpnic_dev *mpd,
 	mpnic_ring_init(&nv->qt[0].cmpl, &uc_addr[MPNIC_TCQ_HEAD(idx)], idx);
 	mpn->tx[idx] = &nv->qt[0].sub0;
 
+	mpnic_ring_init(&nv->qt[1].sub0, &uc_addr[MPNIC_HPQ_TAIL(idx)], idx);
+	mpnic_ring_init(&nv->qt[1].sub1, &uc_addr[MPNIC_PPQ_TAIL(idx)], idx);
+	mpnic_ring_init(&nv->qt[1].cmpl, &uc_addr[MPNIC_RCQ_HEAD(idx)], idx);
+	mpn->rx[idx] = &nv->qt[1].cmpl;
+
 	return 0;
 
 err_napi_del:
@@ -471,8 +580,8 @@ int mpnic_alloc_napi_vectors(struct mpnic_net *mpn)
 static void mpnic_free_ring_resources(struct device *dev,
 				      struct mpnic_ring *ring)
 {
-	kvfree(ring->tx_buf);
-	ring->tx_buf = NULL;
+	kvfree(ring->buffer);
+	ring->buffer = NULL;
 
 	/* If size is not set there are no descriptors present */
 	if (!ring->size)
@@ -538,19 +647,134 @@ static int mpnic_alloc_tx_qt_resources(struct mpnic_net *mpn,
 	return err;
 }
 
+static int
+mpnic_alloc_qt_page_pool(struct mpnic_net *mpn, struct mpnic_napi_vector *nv,
+			 struct mpnic_q_triad *qt)
+{
+	struct page_pool_params pp_params = {
+		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size	= min(mpn->hpq_size + mpn->ppq_size, 32768u),
+		.nid		= NUMA_NO_NODE,
+		.dev		= nv->dev,
+		.dma_dir	= DMA_FROM_DEVICE,
+		.max_len	= PAGE_SIZE,
+		.napi		= &nv->napi,
+		.netdev		= mpn->netdev,
+		.queue_idx	= qt->cmpl.q_idx,
+	};
+	struct page_pool *pp;
+
+	pp = page_pool_create(&pp_params);
+	if (IS_ERR(pp))
+		return PTR_ERR(pp);
+
+	qt->sub0.page_pool = pp;
+	page_pool_get(pp);
+	qt->sub1.page_pool = pp;
+
+	return 0;
+}
+
+static void mpnic_free_rx_qt_resources(struct mpnic_net *mpn,
+				       struct mpnic_q_triad *qt)
+{
+	struct device *dev = mpn->netdev->dev.parent;
+
+	mpnic_free_ring_resources(dev, &qt->cmpl);
+	mpnic_free_ring_resources(dev, &qt->sub1);
+	mpnic_free_ring_resources(dev, &qt->sub0);
+
+	if (xdp_rxq_info_is_reg(&qt->xdp_rxq)) {
+		xdp_rxq_info_unreg(&qt->xdp_rxq);
+		page_pool_destroy(qt->sub1.page_pool);
+		page_pool_destroy(qt->sub0.page_pool);
+	}
+}
+
+static int mpnic_alloc_rx_qt_resources(struct mpnic_net *mpn,
+				       struct mpnic_napi_vector *nv,
+				       struct mpnic_q_triad *qt)
+{
+	int err;
+
+	err = mpnic_alloc_qt_page_pool(mpn, nv, qt);
+	if (err)
+		return err;
+
+	err = xdp_rxq_info_reg(&qt->xdp_rxq, mpn->netdev, qt->cmpl.q_idx,
+			       nv->napi.napi_id);
+	if (err)
+		goto err_free_page_pool;
+
+	err = xdp_rxq_info_reg_mem_model(&qt->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 qt->sub0.page_pool);
+	if (err)
+		goto err_unreg_rxq;
+
+	err = mpnic_alloc_ring_desc(mpn, &qt->sub0, mpn->hpq_size);
+	if (err)
+		goto err_unreg_mm;
+
+	qt->sub0.rx_buf = kvzalloc_objs(*qt->sub0.rx_buf, mpn->hpq_size,
+					GFP_KERNEL | __GFP_NOWARN);
+	if (!qt->sub0.rx_buf) {
+		err = -ENOMEM;
+		goto err_free_qt;
+	}
+
+	err = mpnic_alloc_ring_desc(mpn, &qt->sub1, mpn->ppq_size);
+	if (err)
+		goto err_free_qt;
+
+	qt->sub1.rx_buf = kvzalloc_objs(*qt->sub1.rx_buf, mpn->ppq_size,
+					GFP_KERNEL | __GFP_NOWARN);
+	if (!qt->sub1.rx_buf) {
+		err = -ENOMEM;
+		goto err_free_qt;
+	}
+
+	err = mpnic_alloc_ring_desc(mpn, &qt->cmpl, mpn->rcq_size);
+	if (err)
+		goto err_free_qt;
+
+	qt->cmpl.state = kvzalloc_obj(*qt->cmpl.state,
+				      GFP_KERNEL | __GFP_NOWARN);
+	if (!qt->cmpl.state) {
+		err = -ENOMEM;
+		goto err_free_qt;
+	}
+
+	return 0;
+
+err_free_qt:
+	mpnic_free_rx_qt_resources(mpn, qt);
+	return err;
+err_unreg_mm:
+	xdp_rxq_info_unreg_mem_model(&qt->xdp_rxq);
+err_unreg_rxq:
+	xdp_rxq_info_unreg(&qt->xdp_rxq);
+err_free_page_pool:
+	page_pool_destroy(qt->sub1.page_pool);
+	page_pool_destroy(qt->sub0.page_pool);
+	return err;
+}
+
 static void mpnic_free_nv_resources(struct mpnic_net *mpn,
 				    struct mpnic_napi_vector *nv)
 {
-	int i;
+	int i, j;
 
 	for (i = 0; i < nv->txt_count; i++)
 		mpnic_free_tx_qt_resources(mpn, &nv->qt[i]);
+
+	for (j = 0; j < nv->rxt_count; j++, i++)
+		mpnic_free_rx_qt_resources(mpn, &nv->qt[i]);
 }
 
 static int mpnic_alloc_nv_resources(struct mpnic_net *mpn,
 				    struct mpnic_napi_vector *nv)
 {
-	int i, err;
+	int i, j, err;
 
 	for (i = 0; i < nv->txt_count; i++) {
 		err = mpnic_alloc_tx_qt_resources(mpn, &nv->qt[i]);
@@ -558,11 +782,21 @@ static int mpnic_alloc_nv_resources(struct mpnic_net *mpn,
 			goto err_free_qt_resources;
 	}
 
+	for (j = 0; j < nv->rxt_count; j++, i++) {
+		err = mpnic_alloc_rx_qt_resources(mpn, nv, &nv->qt[i]);
+		if (err)
+			goto err_free_qt_resources;
+	}
+
 	return 0;
 
 err_free_qt_resources:
-	while (i--)
-		mpnic_free_tx_qt_resources(mpn, &nv->qt[i]);
+	while (i--) {
+		if (i < nv->txt_count)
+			mpnic_free_tx_qt_resources(mpn, &nv->qt[i]);
+		else
+			mpnic_free_rx_qt_resources(mpn, &nv->qt[i]);
+	}
 	return err;
 }
 
@@ -593,36 +827,41 @@ int mpnic_alloc_resources(struct mpnic_net *mpn)
 	return err;
 }
 
+static void mpnic_set_netif_napi(struct mpnic_napi_vector *nv,
+				 struct napi_struct *napi)
+{
+	int i, j;
+
+	for (i = 0; i < nv->txt_count; i++)
+		netif_queue_set_napi(nv->napi.dev, nv->qt[i].sub0.q_idx,
+				     NETDEV_QUEUE_TYPE_TX, napi);
+
+	for (j = 0; j < nv->rxt_count; j++, i++)
+		netif_queue_set_napi(nv->napi.dev, nv->qt[i].cmpl.q_idx,
+				     NETDEV_QUEUE_TYPE_RX, napi);
+}
+
 int mpnic_set_netif_queues(struct mpnic_net *mpn)
 {
-	int i, j, err;
+	int i, err;
 
-	err = netif_set_real_num_tx_queues(mpn->netdev, mpn->num_tx_queues);
+	err = netif_set_real_num_queues(mpn->netdev, mpn->num_tx_queues,
+					mpn->num_rx_queues);
 	if (err)
 		return err;
 
-	for (i = 0; i < mpn->num_napi; i++) {
-		struct mpnic_napi_vector *nv = mpn->napi[i];
-
-		for (j = 0; j < nv->txt_count; j++)
-			netif_queue_set_napi(mpn->netdev, nv->qt[j].sub0.q_idx,
-					     NETDEV_QUEUE_TYPE_TX, &nv->napi);
-	}
+	for (i = 0; i < mpn->num_napi; i++)
+		mpnic_set_netif_napi(mpn->napi[i], &mpn->napi[i]->napi);
 
 	return 0;
 }
 
 void mpnic_reset_netif_queues(struct mpnic_net *mpn)
 {
-	int i, j;
-
-	for (i = 0; i < mpn->num_napi; i++) {
-		struct mpnic_napi_vector *nv = mpn->napi[i];
+	int i;
 
-		for (j = 0; j < nv->txt_count; j++)
-			netif_queue_set_napi(mpn->netdev, nv->qt[j].sub0.q_idx,
-					     NETDEV_QUEUE_TYPE_TX, NULL);
-	}
+	for (i = 0; i < mpn->num_napi; i++)
+		mpnic_set_netif_napi(mpn->napi[i], NULL);
 }
 
 static void mpnic_enable_twq(struct mpnic_dev *mpd, struct mpnic_ring *twq)
@@ -666,17 +905,77 @@ static void mpnic_enable_tcq(struct mpnic_dev *mpd,
 	mpnic_wr64(mpd, MPNIC_TCQ_CTL(i), MPNIC_TCQ_CTL_ENABLE);
 }
 
+static void mpnic_enable_bdq(struct mpnic_dev *mpd, struct mpnic_ring *hpq,
+			     struct mpnic_ring *ppq)
+{
+	u32 hpq_log_size = fls(hpq->size_mask);
+	u32 ppq_log_size = fls(ppq->size_mask);
+	u32 i = hpq->q_idx;
+
+	/* Reset head/tail */
+	mpnic_wr64(mpd, MPNIC_BDQ_CTL(i), MPNIC_BDQ_CTL_RESET);
+	hpq->tail = 0;
+	hpq->head = 0;
+	ppq->tail = 0;
+	ppq->head = 0;
+
+	/* Store descriptor ring addresses and sizes */
+	mpnic_wr64(mpd, MPNIC_HPQ_BASE_ADDR(i), hpq->dma);
+	mpnic_wr64(mpd, MPNIC_HPQ_SIZE(i), hpq_log_size & MPNIC_HPQ_SIZE_SIZE);
+	mpnic_wr64(mpd, MPNIC_PPQ_BASE_ADDR(i), ppq->dma);
+	mpnic_wr64(mpd, MPNIC_PPQ_SIZE(i), ppq_log_size & MPNIC_PPQ_SIZE_SIZE);
+
+	mpnic_wr64(mpd, MPNIC_BDQ_CTL(i),
+		   MPNIC_BDQ_CTL_ENABLE | MPNIC_BDQ_CTL_ENABLE_PPQ);
+}
+
+static void mpnic_set_rde_cfg(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
+{
+	BUILD_BUG_ON(FIELD_MAX(MPNIC_RDE_CFG_MIN_HEAD_ROOM) < MPNIC_RX_HROOM);
+	BUILD_BUG_ON(FIELD_MAX(MPNIC_RDE_CFG_MIN_TAIL_ROOM) < MPNIC_RX_TROOM);
+
+	mpnic_wr64(mpd, MPNIC_RDE_CFG(rcq->q_idx),
+		   FIELD_PREP(MPNIC_RDE_CFG_MIN_HEAD_ROOM, MPNIC_RX_HROOM) |
+		   FIELD_PREP(MPNIC_RDE_CFG_MIN_TAIL_ROOM, MPNIC_RX_TROOM) |
+		   FIELD_PREP(MPNIC_RDE_CFG_MAX_HEADER_BYTES,
+			      MPNIC_RX_MAX_HDR));
+}
+
+static void mpnic_enable_rcq(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
+{
+	u32 log_size = fls(rcq->size_mask);
+	u32 i = rcq->q_idx;
+
+	mpnic_set_rde_cfg(mpd, rcq);
+
+	/* Reset head/tail */
+	mpnic_wr64(mpd, MPNIC_RCQ_CTL(i), MPNIC_RCQ_CTL_RESET);
+	rcq->head = 0;
+	rcq->tail = 0;
+
+	/* Store descriptor ring address and size */
+	mpnic_wr64(mpd, MPNIC_RCQ_BASE_ADDR(i), rcq->dma);
+	mpnic_wr64(mpd, MPNIC_RCQ_SIZE(i), log_size & MPNIC_RCQ_SIZE_SIZE);
+
+	mpnic_wr64(mpd, MPNIC_RCQ_CTL(i), MPNIC_RCQ_CTL_ENABLE);
+}
+
 void mpnic_enable(struct mpnic_net *mpn)
 {
 	struct mpnic_dev *mpd = mpn->mpd;
-	int i, j;
+	int i, j, t;
 
 	for (i = 0; i < mpn->num_napi; i++) {
 		struct mpnic_napi_vector *nv = mpn->napi[i];
 
-		for (j = 0; j < nv->txt_count; j++) {
-			mpnic_enable_twq(mpd, &nv->qt[j].sub0);
-			mpnic_enable_tcq(mpd, nv, &nv->qt[j].cmpl);
+		for (t = 0; t < nv->txt_count; t++) {
+			mpnic_enable_twq(mpd, &nv->qt[t].sub0);
+			mpnic_enable_tcq(mpd, nv, &nv->qt[t].cmpl);
+		}
+
+		for (j = 0; j < nv->rxt_count; j++, t++) {
+			mpnic_enable_bdq(mpd, &nv->qt[t].sub0, &nv->qt[t].sub1);
+			mpnic_enable_rcq(mpd, &nv->qt[t].cmpl);
 		}
 	}
 
@@ -698,17 +997,35 @@ static void mpnic_disable_tcq(struct mpnic_dev *mpd, struct mpnic_ring *txr)
 		   MPNIC_TIM_INTR_MASK_MASK);
 }
 
+static void mpnic_disable_bdq(struct mpnic_dev *mpd, struct mpnic_ring *hpq)
+{
+	u64 bdq_ctl = mpnic_rd64(mpd, MPNIC_BDQ_CTL(hpq->q_idx));
+
+	bdq_ctl &= ~(MPNIC_BDQ_CTL_ENABLE | MPNIC_BDQ_CTL_ENABLE_PPQ);
+	mpnic_wr64(mpd, MPNIC_BDQ_CTL(hpq->q_idx), bdq_ctl);
+}
+
+static void mpnic_disable_rcq(struct mpnic_dev *mpd, struct mpnic_ring *rcq)
+{
+	mpnic_wr64(mpd, MPNIC_RCQ_CTL(rcq->q_idx), 0);
+}
+
 void mpnic_disable(struct mpnic_net *mpn)
 {
 	struct mpnic_dev *mpd = mpn->mpd;
-	int i, j;
+	int i, j, t;
 
 	for (i = 0; i < mpn->num_napi; i++) {
 		struct mpnic_napi_vector *nv = mpn->napi[i];
 
-		for (j = 0; j < nv->txt_count; j++) {
-			mpnic_disable_twq(mpd, &nv->qt[j].sub0);
-			mpnic_disable_tcq(mpd, &nv->qt[j].cmpl);
+		for (t = 0; t < nv->txt_count; t++) {
+			mpnic_disable_twq(mpd, &nv->qt[t].sub0);
+			mpnic_disable_tcq(mpd, &nv->qt[t].cmpl);
+		}
+
+		for (j = 0; j < nv->rxt_count; j++, t++) {
+			mpnic_disable_bdq(mpd, &nv->qt[t].sub0);
+			mpnic_disable_rcq(mpd, &nv->qt[t].cmpl);
 		}
 	}
 
@@ -767,6 +1084,9 @@ void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
 		{ MPNIC_TQS_IDLE(0), MPNIC_TQS_IDLE_CNT, "TQS" },
 		{ MPNIC_TDE_IDLE(0), MPNIC_TDE_IDLE_CNT, "TDE" },
 		{ MPNIC_TCQ_IDLE(0), MPNIC_TCQ_IDLE_CNT, "TCQ" },
+		{ MPNIC_HPQ_IDLE(0), MPNIC_HPQ_IDLE_CNT, "HPQ" },
+		{ MPNIC_PPQ_IDLE(0), MPNIC_PPQ_IDLE_CNT, "PPQ" },
+		{ MPNIC_RCQ_IDLE(0), MPNIC_RCQ_IDLE_CNT, "RCQ" },
 	};
 	u32 non_idle_bitmap;
 	int err;
@@ -779,15 +1099,31 @@ void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
 				non_idle_bitmap, err);
 }
 
+static void mpnic_clean_bdq(struct mpnic_ring *bdq)
+{
+	unsigned int head = bdq->head;
+
+	while (head != bdq->tail) {
+		struct page *page = bdq->rx_buf[head];
+
+		page_pool_put_full_page(page->pp, page, false);
+
+		head++;
+		head &= bdq->size_mask;
+	}
+
+	bdq->head = head;
+}
+
 void mpnic_flush(struct mpnic_net *mpn)
 {
-	int i, j;
+	int i, j, t;
 
 	for (i = 0; i < mpn->num_napi; i++) {
 		struct mpnic_napi_vector *nv = mpn->napi[i];
 
-		for (j = 0; j < nv->txt_count; j++) {
-			struct mpnic_q_triad *qt = &nv->qt[j];
+		for (t = 0; t < nv->txt_count; t++) {
+			struct mpnic_q_triad *qt = &nv->qt[t];
 			struct netdev_queue *txq;
 
 			/* Clean the work queue of unprocessed work */
@@ -796,6 +1132,45 @@ void mpnic_flush(struct mpnic_net *mpn)
 			txq = netdev_get_tx_queue(mpn->netdev, qt->sub0.q_idx);
 			netdev_tx_reset_queue(txq);
 		}
+
+		for (j = 0; j < nv->rxt_count; j++, t++) {
+			struct mpnic_q_triad *qt = &nv->qt[t];
+			struct mpnic_rcq_state *state = qt->cmpl.state;
+
+			/* Release the partially assembled frame and the
+			 * pages the queues are still handing out.
+			 */
+			mpnic_put_pkt_buff(&state->pkt, false);
+			mpnic_flush_pg_ctxt(&state->hdr, false);
+			mpnic_flush_pg_ctxt(&state->payld, false);
+			memset(state, 0, sizeof(*state));
+
+			mpnic_clean_bdq(&qt->sub0);
+			mpnic_clean_bdq(&qt->sub1);
+		}
+	}
+}
+
+void mpnic_fill(struct mpnic_net *mpn)
+{
+	int i, j, t;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		struct mpnic_napi_vector *nv = mpn->napi[i];
+
+		for (j = 0, t = nv->txt_count; j < nv->rxt_count; j++, t++) {
+			struct mpnic_q_triad *qt = &nv->qt[t];
+			struct mpnic_rcq_state *state = qt->cmpl.state;
+
+			/* Point the page contexts at an index the device
+			 * cannot report, so the first buffer coming out of
+			 * either queue is not taken for a page we hold.
+			 */
+			state->hdr.idx = UINT_MAX;
+			state->payld.idx = UINT_MAX;
+
+			mpnic_fill_qt_bdqs(qt);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 2add4ad0d39a..5e592dfd9f81 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -9,6 +9,7 @@
 #include <linux/skbuff.h>
 #include <linux/types.h>
 #include <net/netdev_queues.h>
+#include <net/xdp.h>
 
 #include "mpnic.h"
 
@@ -26,12 +27,57 @@ struct mpnic_net;
 
 #define MPNIC_MAX_NAPI_VECTORS		1024u
 
+/* Number of buffer descriptors the driver posts before ringing the
+ * doorbell. The device consumes whatever the doorbell points at, this is
+ * purely to keep the driver from writing the CSR for every descriptor.
+ */
+#define MPNIC_BDQ_BATCH_SIZE		64u
+
 #define MPNIC_TXQ_SIZE_DEFAULT		1024
+#define MPNIC_HPQ_SIZE_DEFAULT		256
+#define MPNIC_PPQ_SIZE_DEFAULT		256
+#define MPNIC_RCQ_SIZE_DEFAULT		1024
+
+/* Room the device has to leave in front of and behind every header so the
+ * driver can build an skb around it in place. The headroom is padded out
+ * so that consecutive headers in one page start 128 B aligned.
+ */
+#define MPNIC_RX_TROOM \
+	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
+#define MPNIC_RX_HROOM \
+	(ALIGN(MPNIC_RX_TROOM + XDP_PACKET_HEADROOM, 128) - MPNIC_RX_TROOM)
+
+/* Headers longer than this are split off into the payload queue */
+#define MPNIC_RX_MAX_HDR		1536
 
 #define MPNIC_MAX_JUMBO_FRAME_SIZE	9742
 
+/* The page a buffer descriptor queue is currently handing out. Records
+ * how many of the references taken on it are still unused.
+ */
+struct mpnic_pg_ctxt {
+	struct page	*page;
+	long		pagecnt_bias;
+	u32		idx;
+};
+
+struct mpnic_pkt_ctxt {
+	struct xdp_buff buff;
+};
+
+struct mpnic_rcq_state {
+	struct mpnic_pkt_ctxt pkt;
+	struct mpnic_pg_ctxt hdr;
+	struct mpnic_pg_ctxt payld;
+};
+
 struct mpnic_ring {
-	void **tx_buf;			/* Packets outstanding in a TWQ */
+	union {
+		struct mpnic_rcq_state *state;	/* RCQ */
+		struct page **rx_buf;		/* BDQ */
+		void **tx_buf;			/* TWQ */
+		void *buffer;			/* Generic pointer */
+	};
 
 	u32 __iomem *doorbell;		/* Pointer to CSR space for ring */
 	__le64 *desc;			/* Descriptor ring memory */
@@ -40,22 +86,29 @@ struct mpnic_ring {
 
 	u32 head, tail;			/* Head/Tail of ring */
 
-	/* TWQ only, index of the metadata descriptor of the last packet
-	 * placed in the ring without ringing the doorbell, -1 if the
-	 * doorbell is in sync with the tail.
-	 */
-	s32 deferred_meta;
+	union {
+		/* BDQ only */
+		struct page_pool *page_pool;
+
+		/* TWQ only, index of the metadata descriptor of the last
+		 * packet placed in the ring without ringing the doorbell,
+		 * -1 if the doorbell is in sync with the tail.
+		 */
+		s32 deferred_meta;
+	};
 
 	/* Slow path fields follow */
 	dma_addr_t dma;			/* Phys addr of descriptor memory */
 	size_t size;			/* Size of descriptor ring in memory */
 };
 
-/* The device pairs two work queues with one completion queue. On the Tx
- * side only the first work queue is used for now, the second one becomes
+/* The device pairs two work queues with one completion queue. On the Rx
+ * side they are the header and the payload buffer descriptor queues; on
+ * the Tx side only the first one is used for now, the second one becomes
  * the XDP ring.
  */
 struct mpnic_q_triad {
+	struct xdp_rxq_info xdp_rxq;
 	struct mpnic_ring sub0, sub1, cmpl;
 };
 
@@ -66,6 +119,7 @@ struct mpnic_napi_vector {
 
 	u16 v_idx;
 	u16 txt_count;
+	u16 rxt_count;
 
 	char name[IFNAMSIZ + 11];
 
@@ -85,5 +139,6 @@ void mpnic_enable(struct mpnic_net *mpn);
 void mpnic_disable(struct mpnic_net *mpn);
 void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd);
 void mpnic_flush(struct mpnic_net *mpn);
+void mpnic_fill(struct mpnic_net *mpn);
 
 #endif /* _MPNIC_TXRX_H_ */

-- 
2.52.0

