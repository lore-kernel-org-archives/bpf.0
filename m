Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F03D34B9
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290536; cv=none; b=fFlf4KrqYqUvrwuBd+DN0U820ys1KovTJid+3L0HDLlg2Xb6DPB9rh5oN0sGJErJAlziiftn2l4UiHgBK2U69wsyvhruWJrNxayG9WNNNbvHUkv4g9So0roJp8Dgn9DDbbDAbYTUmi8rHfHMYaKrtGl1zDptDvqScI1rOqwxW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290536; c=relaxed/simple;
	bh=UR0wxAJljmGCXJ+jOK6daMXItb/fhYUqkOWlYcn0dBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5CqB8JcRE2M00c4K882pPONYD2nBjodbgz5FvlNZweo30eG0Q9ClvynRKnxzXlK4OFlXMsJtnoJF/NXIPWw3vt3CCuQJ8J3oKGiaLjRQpVX5JaL/c2tFsyT6zSYfXNFsA3i/IECXhARrXMLd20tvii17Ul/3tZoR27e6ikC4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4yPnwc6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4yPnwc6"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c56e822eso455055f8f.2
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290532; x=1774895332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaHp2/FUvMOtomlFmeSVzxYjb6RSDeBp4ispDMEXgtk=;
        b=h4yPnwc6oAOg7qIjdmRodCa4OOKjuVrCmao4it7X4RrXzjrYRoe/eXkvwvq6FfvI7V
         fv3ueLwiBdvzLNmCDhxvlZUw+gzkjibLQNGPjjnfUl/WYErlzM7jFDgGoZm7Fdl2Vd6s
         XsRqRI60Dz6/q3CHVNlAPiT3cjtZMMo1SX/aLyeDddBcepEvJ6UGNP5wU1b8uvdbt1WB
         /S6kZfiseZKU7ek4VI4EWz8r+mi+kHl/YVHI1y4bGni6zptV9uArOwYZyfBDYRZGpiiA
         08ZdW5Ne8E1QdtOmrZhydyDyff99T/14iWT5jJJ+Zfo2gp2QpP7n77SCrHS8axnJ5cUY
         9VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290532; x=1774895332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaHp2/FUvMOtomlFmeSVzxYjb6RSDeBp4ispDMEXgtk=;
        b=aayGB0ot9h8Kk9QYoKG8xerGNgXi4VCMg9Hl3CbXkXfNXwKmcAJU72tF9P9SyRMGv0
         xIriiKXXegaRR3nMYdb+tY09gF4XLbSmwk93Dj0Mwn/dncbfKLWvQ70epz+H2NkGmqiI
         +KmR5URPKtEpbMyfZXf39tLW4hn5RBEIUHMBR3guI9Akmt163xGTdBETmvrKTE6hCHdM
         apB1jM1RIHSksPrrsllIH81ln5nq2I7zF2Zhkhj4ZIFaftOVzUu3KL+tnq4DPN9mjanJ
         NNJauPJO8ES9CetBHTt+Dw1q6wVJmDiv9tniQLAi/VNoEuv3i9+uSfh9d4LZBSlXW8Zv
         +rkw==
X-Forwarded-Encrypted: i=1; AJvYcCUjSYVMi62NW3is+QJESFIw5iqs6BD9JggM0sdg5ZQzfqNmKGMrzGLbA4bp4A+XmSmxAcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmPKfWUWubracjlgkFJjBCDRqBtkpND2FsG/kfOxShp2nrDPu
	m0H1jsM4vQHsiqvhkvGDnDj4wE7p278CKo5+AWrsfxdmTEi7IUXGWl+N
X-Gm-Gg: ATEYQzxy8xTddyomFE6T+ejsaSDgrznyoWMac1WeAtTzr4hopSQN/WbI7cbrhvDDcfs
	qK0qNx0wxHdhhGEoMxWVVXYxWe42XCi5VR9UyXXSD9gF1NP6mriOVKhyTWeEcf15sYWxnRU2wI4
	5gfK/THoxFEvEveiTehzHzbvMoILMjoZLwIzKJPgaoj7QXA+QieqBIxMNwv1OtMmfBJ9CDnT2QY
	t3ePwjHlmdiy2cjKLHtJsFSp0lA1FGWWy2wckpWQYYWrfyJhLKKJbcQHTVkvfLQNnD/NFDNqUl8
	M/fZXZvpo798DerXMQVRcI2q9PEBN1JA2gTnBfV/QQ/aKMWlLXLXEaRvCWj8ga2exCTy5FOeaYx
	R16k4N69UpbdhdpLlWIJc4a06/BioSs6xigaKhlP2jjrh/W/Yy/9swAey4QucEwWMMHQWPmiFvU
	0rzM4/CqHrBOIfQr8ari/QjZZ6NwjpxoJFLQt0ya35p3I6QBnWVx6Hcau/ixQQXRoYSjJgqOB3O
	wE=
X-Received: by 2002:a05:6000:1883:b0:43b:4440:9c28 with SMTP id ffacd0b85a97d-43b63fe235fmr20398332f8f.0.1774290531496;
        Mon, 23 Mar 2026 11:28:51 -0700 (PDT)
Received: from turbo.teknoraver.net (net-37-119-137-97.cust.vodafonedsl.it. [37.119.137.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714decsm28448751f8f.31.2026.03.23.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:28:51 -0700 (PDT)
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
	John Fastabend <john.fastabend@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/2] e1000e: add XDP_REDIRECT support
Date: Mon, 23 Mar 2026 19:28:23 +0100
Message-ID: <20260323182823.5813-3-teknoraver@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323182823.5813-1-teknoraver@meta.com>
References: <20260323182823.5813-1-teknoraver@meta.com>
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
index d77f208f00cc..01661e1a74e5 100644
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
@@ -1041,11 +1052,11 @@ static bool e1000_clean_rx_irq_xdp(struct e1000_ring *rx_ring, int *work_done,
 
 			/* page consumed by skb */
 			buffer_info->page = NULL;
-		} else if (xdp_res & E1000_XDP_TX) {
+		} else if (xdp_res & (E1000_XDP_TX | E1000_XDP_REDIR)) {
 			xdp_xmit |= xdp_res;
 			total_rx_bytes += length - crc_len;
 			total_rx_packets++;
-			/* page consumed by XDP TX */
+			/* page consumed by XDP TX/redirect */
 			buffer_info->page = NULL;
 		} else {
 			/* XDP_DROP / XDP_ABORTED - recycle page */
@@ -7812,6 +7823,11 @@ static int e1000_xdp_setup(struct net_device *netdev, struct netdev_bpf *bpf)
 	if (!need_reset)
 		return 0;
 
+	if (prog)
+		xdp_features_set_redirect_target(netdev, true);
+	else
+		xdp_features_clear_redirect_target(netdev);
+
 	if (running) {
 		int err = e1000e_open(netdev);
 
@@ -7837,6 +7853,64 @@ static int e1000_xdp(struct net_device *netdev, struct netdev_bpf *xdp)
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
@@ -7860,6 +7934,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
 	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
 	.ndo_bpf		= e1000_xdp,
+	.ndo_xdp_xmit		= e1000_xdp_xmit,
 };
 
 /**
@@ -8070,7 +8145,9 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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

