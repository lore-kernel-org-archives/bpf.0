Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F522FF669
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013071; cv=none; b=e4C32PvmqCaUpZmaUj62q6X4j2FJL2AbT113kimqKW89tK9se0r+yowUmyxdjvTGHAb6gT60ZfUC9X2kaonYFzIj3rrIEQtCtHWfLxoTbH10Vb874ZKf3DqXItlbVZJUqtH3piRWpCN+1D5rnRG7einHG97brj5SNOCoDOny9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013071; c=relaxed/simple;
	bh=PD9juSUsML20xVTwE8RCFOWj95oRmvJZgs05+pTq+Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+a6JuOWALflzr9cUSU4L4buZMtZzzIXVmad5twgAgjLAyaax2IvBI8CKp6mqUv9TGxN6DRZ5GrzaD0e7dygOHD9Lbd6PdqmSKfcN1l7xeOlqfsBD2S76pkazY7E6Y2PGE2yYXMr/nemM6yJB8fZl94kQL51JrIQHkIbmfn5NR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmn/wP1j; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmn/wP1j"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so18341505e9.3
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774013068; x=1774617868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLTuTnfwehV2L1dYdqxcXAxrjOVio+7F/VaVFTc7JYo=;
        b=Cmn/wP1jHQs7GgyundFrM00/EXxqNZfib9Jb1SRRIE7kmcsbd/9wG3YnssN0CoFegl
         Ea8nt6GXvErSqFHINtpMR3qUepQWlG2XAilwTgaWHKYFZOimEAy1y2hf4Rib1WyIrYUr
         BlS4M8bOZjf/1E/nDWUN7UJj2qJg2B4jIOcjsS6WEDhQsOzXYt5+TtFX9RT/+mOI9DrM
         2OQxEt2rtEXtBrHogUCBtOCJ1dVIiCKBEk7NGiWKdlqAkjG/0idlETfeFsGRQZXEw1er
         7BuN87uZTJJf6UAQE6JVpoBBiJJj15X9fbvQUOfbwvVOI7YniKmy1rEYPDPrJHR247dt
         RApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774013069; x=1774617869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLTuTnfwehV2L1dYdqxcXAxrjOVio+7F/VaVFTc7JYo=;
        b=fmcTTC9zIr0MSArjIGDry4cnOO8lR6+T5syTORvzwiDHTDpwpQHyxDkmekLGPaAmao
         zTKseTrWeIeRjNWLcScDlOjvUOXGLXBaad3MslNs7NTf6Akx/Pvf591s0xAAvtsGLVGV
         81ggPavYNNly2YsmiuxON9MylERrCPg9iB9PibFd/yGtSP+6sW1+UmhXY4zjJsrdCIR1
         7I3TeqeEFS6ZBFwE8rNtVCOfztiiX/Kf9zkcGHR8Q0sPMqoy9oFbDUASfjgo25oenOkY
         ukEvOn+egRwi6NJUiEaDXmWJNYT+nmdGBx2smexJRXW+o6/3o7ZbjtwteiSrc3+o0AYN
         jsEw==
X-Forwarded-Encrypted: i=1; AJvYcCUAf+3ls0+A68I7a3ZuyBWi1vGPgg+yJWxxon8Kk6Gw2V0t63D5ro2qy2RULxLNzb4VuJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9vXBiG0PoCYIpEPrachhOakmIXO0B8F/ZJX1rjW0SjxFIIZ8
	JRJHtRcY9VFfr6Up8ZJihC2vEuP9263Y6pPl3ULs12tNkDvBYvr/nsP6
X-Gm-Gg: ATEYQzy0rI9iv72FQ6OBh4gQnGuokj5S/wYZakkZRYiMD4qnAaB0iD1rdflCy4xdn/s
	DdaEoaxV0Ia31xpq5SRgiQH0I6x/dAFwgxEHT1H6lThi7mULFj5A7fwNRmhk0/LjcdkwpW6RWek
	6C/ZVT+8NDUZRsuQEQ4w8MPqeGteTioKw8sDblnqTZgamlG6DLd/l7TVuAWmTREZ0h83p40Jgrc
	sB53BVraJn41bhUge1055h6gu3DrT91eJ3zb8H+HOrhc59IGNnrgzeLkeFUB+rnjXIFWN+X/i3o
	88O+Ow0TAhd7PW0k0CmyJ/GUVnmFL4efrRvi89TuMy+ngpBM25PAOAbPmij2EIoDoaKQ2CInULz
	9//uln+JWv3VL5+78NDgcvE26L8ekKzNOgh524hpVhs90r5XjZaXxDSOqXJVE7MBbYRnTdS+Kis
	/8YTLLYtf24V9LoWWtCf9DUVZx6MghYUD8XBe7HjUfsueC5elGZfy1r9VEXLJGzv92o8jkT9Ub
X-Received: by 2002:a05:600c:1d1b:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-486febb5fefmr49625065e9.2.1774013068226;
        Fri, 20 Mar 2026 06:24:28 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-95-156-124.cust.vodafonedsl.it. [5.95.156.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487004e7bc4sm16427095e9.2.2026.03.20.06.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:24:27 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] e1000e: add XDP_REDIRECT support
Date: Fri, 20 Mar 2026 14:23:56 +0100
Message-ID: <20260320132356.63194-3-teknoraver@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320132356.63194-1-teknoraver@meta.com>
References: <20260320132356.63194-1-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ability to redirect packets to other devices via XDP_REDIRECT
and to receive redirected frames from other devices via ndo_xdp_xmit.

New functionality:
- XDP_REDIRECT case in e1000_run_xdp() using xdp_do_redirect()
- e1000_xdp_xmit() as the ndo_xdp_xmit callback for receiving
  redirected frames from other devices
- xdp_do_flush() in e1000_finalize_xdp() for REDIR completions
- xdp_features_set/clear_redirect_target() in e1000_xdp_setup()
- NETDEV_XDP_ACT_REDIRECT and NETDEV_XDP_ACT_NDO_XMIT advertised

Assisted-by: claude-opus-4-6
Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 85 +++++++++++++++++++++-
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3ee5246f0b84..83f188f9b510 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -41,6 +41,7 @@ char e1000e_driver_name[] = "e1000e";
 #define E1000_XDP_PASS		0
 #define E1000_XDP_CONSUMED	BIT(0)
 #define E1000_XDP_TX		BIT(1)
+#define E1000_XDP_REDIR		BIT(2)
 
 static int debug = -1;
 module_param(debug, int, 0);
@@ -805,6 +806,9 @@ static void e1000_finalize_xdp(struct e1000_adapter *adapter,
 {
 	struct e1000_ring *tx_ring = adapter->tx_ring;
 
+	if (xdp_xmit & E1000_XDP_REDIR)
+		xdp_do_flush();
+
 	if (xdp_xmit & E1000_XDP_TX) {
 		/* Force memory writes to complete before letting h/w
 		 * know there are new descriptors to fetch.
@@ -823,13 +827,14 @@ static void e1000_finalize_xdp(struct e1000_adapter *adapter,
  * @adapter: board private structure
  * @xdp: XDP buffer containing packet data
  *
- * Returns E1000_XDP_PASS, E1000_XDP_TX, or E1000_XDP_CONSUMED
+ * Returns E1000_XDP_PASS, E1000_XDP_TX, E1000_XDP_REDIR, or E1000_XDP_CONSUMED
  **/
 static int e1000_run_xdp(struct e1000_adapter *adapter, struct xdp_buff *xdp)
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(adapter->xdp_prog);
 	struct net_device *netdev = adapter->netdev;
 	int result = E1000_XDP_PASS;
+	int err;
 	u32 act;
 
 	if (!xdp_prog)
@@ -846,6 +851,12 @@ static int e1000_run_xdp(struct e1000_adapter *adapter, struct xdp_buff *xdp)
 		if (result == E1000_XDP_CONSUMED)
 			goto out_failure;
 		break;
+	case XDP_REDIRECT:
+		err = xdp_do_redirect(netdev, xdp, xdp_prog);
+		if (err)
+			goto out_failure;
+		result = E1000_XDP_REDIR;
+		break;
 	default:
 		bpf_warn_invalid_xdp_action(netdev, xdp_prog, act);
 		fallthrough;
@@ -1040,11 +1051,11 @@ static bool e1000_clean_rx_irq_xdp(struct e1000_ring *rx_ring, int *work_done,
 
 			/* page consumed by skb */
 			buffer_info->page = NULL;
-		} else if (xdp_res & E1000_XDP_TX) {
+		} else if (xdp_res & (E1000_XDP_TX | E1000_XDP_REDIR)) {
 			xdp_xmit |= xdp_res;
 			total_rx_bytes += length;
 			total_rx_packets++;
-			/* page consumed by XDP TX */
+			/* page consumed by XDP TX/redirect */
 			buffer_info->page = NULL;
 		} else {
 			/* XDP_DROP / XDP_ABORTED - recycle page */
@@ -7811,6 +7822,11 @@ static int e1000_xdp_setup(struct net_device *netdev, struct netdev_bpf *bpf)
 	if (!need_reset)
 		return 0;
 
+	if (prog)
+		xdp_features_set_redirect_target(netdev, true);
+	else
+		xdp_features_clear_redirect_target(netdev);
+
 	if (running)
 		e1000e_open(netdev);
 
@@ -7827,6 +7843,64 @@ static int e1000_xdp(struct net_device *netdev, struct netdev_bpf *xdp)
 	}
 }
 
+/**
+ * e1000_xdp_xmit - transmit XDP frames from another device
+ * @netdev: network interface device structure
+ * @n: number of frames to transmit
+ * @frames: array of XDP frame pointers
+ * @flags: XDP transmit flags
+ *
+ * This is the ndo_xdp_xmit callback, called when other devices redirect
+ * frames to this device.
+ **/
+static int e1000_xdp_xmit(struct net_device *netdev, int n,
+			  struct xdp_frame **frames, u32 flags)
+{
+	struct e1000_adapter *adapter = netdev_priv(netdev);
+	struct e1000_ring *tx_ring = adapter->tx_ring;
+	struct netdev_queue *nq = netdev_get_tx_queue(netdev, 0);
+	int cpu = smp_processor_id();
+	int nxmit = 0;
+	int i;
+
+	if (unlikely(test_bit(__E1000_DOWN, &adapter->state)))
+		return -ENETDOWN;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	if (!adapter->xdp_prog)
+		return -ENXIO;
+
+	__netif_tx_lock(nq, cpu);
+	txq_trans_cond_update(nq);
+
+	for (i = 0; i < n; i++) {
+		int err;
+
+		err = e1000_xdp_xmit_ring(adapter, tx_ring, frames[i]);
+		if (err != E1000_XDP_TX)
+			break;
+		nxmit++;
+	}
+
+	if (unlikely(flags & XDP_XMIT_FLUSH)) {
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.
+		 */
+		wmb();
+		if (adapter->flags2 & FLAG2_PCIM2PCI_ARBITER_WA)
+			e1000e_update_tdt_wa(tx_ring,
+					     tx_ring->next_to_use);
+		else
+			writel(tx_ring->next_to_use, tx_ring->tail);
+	}
+
+	__netif_tx_unlock(nq);
+
+	return nxmit;
+}
+
 static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_open		= e1000e_open,
 	.ndo_stop		= e1000e_close,
@@ -7850,6 +7924,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
 	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
 	.ndo_bpf		= e1000_xdp,
+	.ndo_xdp_xmit		= e1000_xdp_xmit,
 };
 
 /**
@@ -8060,7 +8135,9 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->max_mtu = adapter->max_hw_frame_size -
 			  (VLAN_ETH_HLEN + ETH_FCS_LEN);
 
-	netdev->xdp_features = NETDEV_XDP_ACT_BASIC;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC |
+			       NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_NDO_XMIT;
 
 	if (e1000e_enable_mng_pass_thru(&adapter->hw))
 		adapter->flags |= FLAG_MNG_PT_ENABLED;
-- 
2.53.0

