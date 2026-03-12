Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AAF3FFAA6
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340739; cv=none; b=NQYlDYoc7cgdaqo9z8owIYVf7NEbaplstCBIr4WfjYBUReV3g1wPwAZyoACJSjzb+IgRcWT+DxYaBa/dtzLD4Wjf2vHm5Mv7rrK8EYWSTVqs+8oYwx2oYObjJCLlEl1SVdjO7AaX2hxmIt7WXJistxbXc7+C7YiMrbAWm3P22b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340739; c=relaxed/simple;
	bh=3UxO3hGZusgNn8ofIA0kPIescWqHZiqa7lRiRs+eqWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYtKvmQ299Qjc5KwZCnH3LfU4vxJ4Ei328s3nVIj2aw7oQlPf+/DbV2Q4GqlXlCuqcuDpDgMglWpojD67nHRKMy8BdvqO+ZwE7bA7nIG02hk7KLk8tel1JzwHrW0tumPwKpc+u2yuvlpskNLrC8gLOFW+N7CfupQsFBKc2RNeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lsw11Son; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsw11Son"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48529c325f0so9847095e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773340736; x=1773945536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSKBN+Tb2XKCGJildwBJPH5bXGsZAUeul85uzs2xixU=;
        b=Lsw11SonvI2upuS/evyzdmJJbBT+ilmTLQqle4qa3xMbQPphHTK/BTnRO4iYuuZXP1
         Vx9Nx5Fgz/tSLDXb0mOR7Ws9oLWyJU2n8YoBHE8nKCAkBLPv1+FKLDicDVM0hf63Lb9w
         mVDEmF/Z4sfR7RN787AQ25uk4DFeEOdqJC7dsWUe5FGy3NO/5xl3WbQGEZNKoQ721JIp
         8aJsh4au3GCs0KxAC6vXcfjwV/pACpIV7HyAKu1zSnaaBqMvtTuszlSTdgPpqf831m6k
         CV37DEHAFWONWA1bV/FCDA2Gp9NqB8dbuSSOGzZhZYig1m366xZVwdMbf/gXHIM7RWfF
         YmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773340736; x=1773945536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jSKBN+Tb2XKCGJildwBJPH5bXGsZAUeul85uzs2xixU=;
        b=C8UIpuGGrPz0j/Z5Tq5PKQoOtZj+qA1C+7fuMgSNV2mVlDZU5KgC5sIhmQDxRO7d85
         5egpIpVFyLj9LOCejV7MOr6QiT7GWeN6t6kayqUOz+AqfRU20Q+n/7ug5+NLHluvXnPW
         O/NdLu0ACh2VSVb5XNluzsbzTWv+ZCWk+C8pmQs7i5djzwUhK7gfV6lEcw1H/7z2BFhg
         j6vb8c3T6dizQlbFGEE5GRNXP4s1keO/gm0avR97u5dC96PbxzdUnxv/7/9GX+9xf4/7
         yFWCX7hDaGtNoS2JydkYrJj42Seg08L/vyUQ00IixL0NJghwc7FvXAFm/I7ttbmyMVaw
         TqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXWl/+szmsNaUfVbsg7f6JK38L/Xz1hlJ5/xWrMAxeMjyXYtk9lGvCtDLRBLdrx4qCeCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TZen5AbplBRzIr4rGNL8kIGyaWcBo1tb5A5XC2bS0bMFB+K9
	VR2rmtZgU6XOy6DEkP1wnY/PfChqliIYL/xSmLZkj+gt9Zf2z04Lzq2+
X-Gm-Gg: ATEYQzxwkKzNrSucXqyFkJJsFHkaGrHdZ9Nk4cixhnAHPoywRiDx7RvedYIQVAP6/Hr
	fB0A/Bj8amJ0N7S1o/ZpvGQ3GLvxDs4HC83Eg+nDsROHeYvU/3D6/srnNjBnupQVgQ3qtSe6azC
	R4JvprRhZm7cyab3z1ajupo/f1kR3znmcKn5T7BEZ+MqVp0f8ONBI2kylt6GsElUkvfQnKaXgYE
	zz/+qEXAwDLOHZi8VCux/h0wXciZ0rhUyOSBmN//FeYelQ+wWr6MctMHjZeq8r/8auD5l5OKyRf
	y15h05020wbv9fy+J9IXy5DH/Prq+JiOKb96l1GpT/2jGDFjtm3Vto1ZFI6TIBECTa8SCXdLRTd
	I+AvHj/GOAaggezf/DUoLohZwl2pyZGl7chJb67r4X4JExl7PogrFCykjrLGVGcmuNMppuYhoQE
	YpBrR+7/m7pemfjv4JbwwvsfeCXSeVTFL3YZZ1+rlSV5lgWWMdkglUFAqiwDdNYIxdO/lGRn1YR
	RGzwPWL/8s=
X-Received: by 2002:a05:600c:c4a5:b0:485:4388:348b with SMTP id 5b1f17b1804b1-485564892e6mr6973235e9.0.1773340735474;
        Thu, 12 Mar 2026 11:38:55 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-95-156-124.cust.vodafonedsl.it. [5.95.156.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6c24sm135560395e9.5.2026.03.12.11.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:38:55 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] e1000e: add XDP_REDIRECT support
Date: Thu, 12 Mar 2026 19:38:17 +0100
Message-ID: <20260312183817.104878-3-teknoraver@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312183817.104878-1-teknoraver@meta.com>
References: <20260312183817.104878-1-teknoraver@meta.com>
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

