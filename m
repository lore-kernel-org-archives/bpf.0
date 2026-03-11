Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E92DC32C
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256516; cv=none; b=Mbnrz0+Bn9zCMzVEeJMEWtYf1da21H71zEgKexX3tjaGKaN0k6A6b4TUXts5DOg4yp1kkm43/TFx1ZkixOaNBiBqfsu6AiAa7DSzgj4CcN0m0C8iLH8SYDQuMgFINV3jpl6Ap9uFm061akYEfFRlNBSPr3Rc+PkawiG73K/KWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256516; c=relaxed/simple;
	bh=3UxO3hGZusgNn8ofIA0kPIescWqHZiqa7lRiRs+eqWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdtm3z0TrccAV/PYT5VK0af3Fv91VQI1dHY1LpKCKRb0F+Lc+tAknpYgQ5RdOF7kRU7iKPEm5JkTsc3OWRtH6RrffprToL7a5ItUol40PTnuY6NyaNaK7rKSkxNBdXvKqbK4IeKTdBmFLLZDBN7PP7B2NBUv8TGBAjvxcxZXa1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btcR4DC9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btcR4DC9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so1617415e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773256513; x=1773861313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSKBN+Tb2XKCGJildwBJPH5bXGsZAUeul85uzs2xixU=;
        b=btcR4DC92c7ENtPGFtL6K6PjPiSggCJDLTnoR59jmfVcCUNWWUu3lwZlt5p/cBKM0Y
         mdbpbYEV6N9rEsLMPnDfpRJOoUt4hz4aQsywwLv8HOnzpbkiLerw1AI+QS64+ylRafTJ
         eU2OgovjlxxFAcpdbslms/Eq8O9Nm5TYKN9z67S1sPrEA8eEBVAytzo2aYCaOKBqAUwf
         SLpVyw05U5WHulSFYPW01iWBztRq8D3v246hUjBmFiLPWUh5rEn+L/Vpj80/bwdDMOKY
         UF5qKquYIhMAC1WpBwoD8/jwh1nppBzzVNRBoOBGLY8GqL+8KZ8pKYZPzLGRUz6XTyI2
         iSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256513; x=1773861313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jSKBN+Tb2XKCGJildwBJPH5bXGsZAUeul85uzs2xixU=;
        b=tmctz/+Sr3xB23x0Ikpk0ITGo6sWdUHsRwPzU9zOPdAtOj8dT0D1Rn5DsHdIoksbBb
         9pnkIQpzGVA8FZA4686CkTHRM9abFpRgr6zugzn3XvnnTbjvb/Lg4faMN5ACUL8ZowYs
         UpEPpV3rvo/4SkOTXSIwEoEVkixw+V/eUtK5FraPJWQqyp1pEuUIoMXm76Mldx1CTOmA
         zG9InIOvDtHMVBR9uEt44Ha9oOIOITKljugfzUfBBksLiv2Zn9Fc91M6OeFwZjJS/zMe
         gfOzA3tpvlHT8w2MpKEyA1agxZt3Zfewe6rehXXBPNeaWB4KtE68r8OhIA7H6ehY6xix
         vhRA==
X-Forwarded-Encrypted: i=1; AJvYcCUG1lOIpaMnLCSV3rQr1qVZfWGN/E0syDBbgj8VroaJNqvuGseKXE6w6j+a6+3ucpcCH/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZbHsIFH6BehoUdJFUJBHwDOjOrV844MkX/58CKVBF7CbI7ra
	IM7H5btAU8GYrDYezCFZNRU/nSUTFoWIxDnHEWh29uVgDCiV86brdIUu
X-Gm-Gg: ATEYQzxCe+iigcudYDsN3BST4rc5laW1GuzKtdMcnG05rxxzjDFBdYbpDoxDJQSvue8
	3e+pmNpNsJd8YkygtoSsRiqp8uD7mCbirISN2h5zUhQ54ZhWB3633H8WHZwZojem6MxTsVfNZ3v
	9RKgaBmIVuVjgnbQHs8j4rQ487Vk1RIwyZn6zBsnW38SxFqf3d3Laq1tZCjpdu2cFW46pCUPJ0T
	dnahAIEAW3UcSqyyVJjAolOnzu6ZCP1nX/SFjPrEPYNIHn/03xHr+fRtHLF4ul6Ck23VKwuPK8l
	xq5QrGN+Y7zJ/Q62LsLEc7xVG408+e8ysvZikAjWqXmlOs43kJhWfOXo5fQ05+KkUJYIn3ahV85
	NMNVvtBQojefKbra3+/dMJbHiL+NOoZv7ifbmFou+FhahUlwX9/0RVnMlclwZWb5j4ssDeZW6UD
	JlAB79qFBwMolrohykSBdse+1aHaoWz2ylhIlQegGDMgzKGTfd4HQV17M3cbvc/HXu32FeiPAR
X-Received: by 2002:a05:600c:8b31:b0:485:3a93:3a9e with SMTP id 5b1f17b1804b1-4854b0b33fdmr61711875e9.10.1773256513140;
        Wed, 11 Mar 2026 12:15:13 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-95-156-124.cust.vodafonedsl.it. [5.95.156.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2eeae0sm28084075e9.4.2026.03.11.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:15:12 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] e1000e: add XDP_REDIRECT support
Date: Wed, 11 Mar 2026 20:14:37 +0100
Message-ID: <20260311191437.3581-3-teknoraver@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311191437.3581-1-teknoraver@meta.com>
References: <20260311191437.3581-1-teknoraver@meta.com>
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
index 821b466b6673..1e28eaed7ae3 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -41,6 +41,7 @@ char e1000e_driver_name[] = "e1000e";
 #define E1000_XDP_PASS		0
 #define E1000_XDP_CONSUMED	BIT(0)
 #define E1000_XDP_TX		BIT(1)
+#define E1000_XDP_REDIR		BIT(2)
 
 static int debug = -1;
 module_param(debug, int, 0);
@@ -804,6 +805,9 @@ static void e1000_finalize_xdp(struct e1000_adapter *adapter,
 {
 	struct e1000_ring *tx_ring = adapter->tx_ring;
 
+	if (xdp_xmit & E1000_XDP_REDIR)
+		xdp_do_flush();
+
 	if (xdp_xmit & E1000_XDP_TX) {
 		/* Force memory writes to complete before letting h/w
 		 * know there are new descriptors to fetch.
@@ -822,13 +826,14 @@ static void e1000_finalize_xdp(struct e1000_adapter *adapter,
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
@@ -845,6 +850,12 @@ static int e1000_run_xdp(struct e1000_adapter *adapter, struct xdp_buff *xdp)
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
@@ -1039,11 +1050,11 @@ static bool e1000_clean_rx_irq_xdp(struct e1000_ring *rx_ring, int *work_done,
 
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
@@ -7815,6 +7826,11 @@ static int e1000_xdp_setup(struct net_device *netdev, struct netdev_bpf *bpf)
 	if (!need_reset)
 		return 0;
 
+	if (prog)
+		xdp_features_set_redirect_target(netdev, true);
+	else
+		xdp_features_clear_redirect_target(netdev);
+
 	if (running)
 		e1000e_open(netdev);
 
@@ -7831,6 +7847,64 @@ static int e1000_xdp(struct net_device *netdev, struct netdev_bpf *xdp)
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
+			   struct xdp_frame **frames, u32 flags)
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
@@ -7854,6 +7928,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
 	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
 	.ndo_bpf		= e1000_xdp,
+	.ndo_xdp_xmit		= e1000_xdp_xmit,
 };
 
 /**
@@ -8064,7 +8139,9 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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

