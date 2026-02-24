Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA25225416
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936714; cv=none; b=s9DibmbgtxkqVp4T5Ko9Q0r6sqExzdOnTljGzMnA/qWCaxgUllFRvJD3rFO0qBreuYknz5GZvsTPEyxU/Fs+J5SVouOFDneoQK3XmojAxDtYQ7xoG/lPFmjIx2pGjdCPWVzaLhu4YR+XcxNzGYOgQ4sg+hb1gPiNGjhLGgcb2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936714; c=relaxed/simple;
	bh=oXDKd50PcR3o8XNqPf8uMrmunzOoieZCrT9mA1rTgsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IEYf9AlRCF7Lln81riL4xACWz6dWwHrScTgI0Ntc3W/axZ8mRDfuOKHhXmCkBHMZqvAsgqd6uDtUfH4biKUmnaHYpWcMR8Kwj9mbwkFxHL90X/lGhkCmEkIPMGdwLO+HWN4MfBBozJp1bUtN0c5SpJjyCW9DekyI7cdOHYSR+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=zdenek.bouska@siemens.com header.b=c0FUpjxz; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=zdenek.bouska@siemens.com header.b="c0FUpjxz"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260224123821fc15a672fe000207e5
        for <bpf@vger.kernel.org>;
        Tue, 24 Feb 2026 13:38:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=zdenek.bouska@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZK6pwPA0ICZ+Gacpu5r5lttbWewOZgHz7aEYNA6FSLk=;
 b=c0FUpjxzDpLswDhMBIkvrYF6Y53m3VIxMptKCF63PXx8L2xGtB8D89PuQZ1PBVS7/JHbFk
 jMHtrok/h42ZkISlsW7LK9Nm2oJ/FiGSyTDSpjzQsrKPVnHJYKROhIgZQwdaK4Jvh1RBDVzt
 NaGr+0gxAhDfogMllwYXC4GfVJfvAoyBzpU97ieCzdRUkZYEocvWgVKgg4xlJ3VL0qKAiUOl
 BfYMy091s4OOt+p60UZ/ad9DYkrvF+pxa0+qusrFj6tpBG1+VY5UTRGLNEkF7Nir3B3l7hVN
 nC7PPh2lYP74MCf17Pj42LPdeQjZjz7OlkLb+Nqxir5D85kR90Ayl16g==;
From: Zdenek Bouska <zdenek.bouska@siemens.com>
Date: Tue, 24 Feb 2026 13:38:13 +0100
Subject: [PATCH] igc: fix page fault in XDP TX timestamps handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com>
X-B4-Tracking: v=1; b=H4sIALSbnWkC/x2NQQqDMBAAvyJ7dkG3VopfKR62yZouVBuSKAHJ3
 w0eB4aZE6IElQhTc0KQQ6P+twp924D58uYE1VYG6mjsqCdUZ3DRjNl6TBlTTLx69Oxk4f2X0Az
 8sTI8H6+RoFZ8kKrfh/dcygXMciYIcQAAAA==
X-Change-ID: 20260212-igc-fix-xdp-tx-tstamp-pagefault-c4abde453862
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Song Yoong Siang <yoong.siang.song@intel.com>, 
 Lai Peter Jun Ann <jun.ann.lai@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Zdenek Bouska <zdenek.bouska@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328595:519-21489:flowmailer

If an XDP application that requested TX timestamping is shutting down
while the link of the interface in use is still up the following kernel
splat is reported:

[  883.803618] [   T1554] BUG: unable to handle page fault for address: ffffcfb6200fd008
...
[  883.803650] [   T1554] Call Trace:
[  883.803652] [   T1554]  <TASK>
[  883.803654] [   T1554]  igc_ptp_tx_tstamp_event+0xdf/0x160 [igc]
[  883.803660] [   T1554]  igc_tsync_interrupt+0x2d5/0x300 [igc]
...

During shutdown of the TX ring the xsk_meta pointers are left behind, so
that the IRQ handler is trying to touch them.

This issue is now being fixed by cleaning up the stale xsk meta data on
TX shutdown. TX timestamps on other queues remain unaffected.

Fixes: 15fd021bc427 ("igc: Add Tx hardware timestamp request for AF_XDP zero-copy packet")
Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  2 ++
 drivers/net/ethernet/intel/igc/igc_main.c |  7 +++++++
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 33 +++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index a427f05814c1ae7330c6f7034cd0f2b40b74dab6..17236813965d334f14eba928affbd4f91b96ecd4 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -781,6 +781,8 @@ int igc_ptp_hwtstamp_set(struct net_device *netdev,
 			 struct kernel_hwtstamp_config *config,
 			 struct netlink_ext_ack *extack);
 void igc_ptp_tx_hang(struct igc_adapter *adapter);
+void igc_ptp_clear_xsk_tx_tstamp_queue(struct igc_adapter *adapter,
+				       u16 queue_id);
 void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
 void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 89a321a344d263ace5c66f7ade782b40cc482566..570e90fab67d653bbbb242d242d0b64a49fba602 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -193,6 +193,7 @@ static void igc_unmap_tx_buffer(struct device *dev, struct igc_tx_buffer *buf)
  */
 static void igc_clean_tx_ring(struct igc_ring *tx_ring)
 {
+	struct igc_adapter *adapter;
 	u16 i = tx_ring->next_to_clean;
 	struct igc_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
 	u32 xsk_frames = 0;
@@ -264,6 +265,12 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
 	/* reset next_to_use and next_to_clean */
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
+
+	/* Clear any lingering XSK TX timestamp requests */
+	if (test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags)) {
+		adapter = netdev_priv(tx_ring->netdev);
+		igc_ptp_clear_xsk_tx_tstamp_queue(adapter, tx_ring->queue_index);
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 7aae83c108fd7611b00bf075592f93a902b83422..98491346d21b80925ce42ba276d851d4318e66b7 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -576,6 +576,39 @@ static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
 	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
+/**
+ * igc_ptp_clear_xsk_tx_tstamp_queue - Clear pending XSK TX timestamps for a queue
+ * @adapter: Board private structure
+ * @queue_id: TX queue index to clear timestamps for
+ *
+ * Iterates over all TX timestamp registers and releases any pending
+ * timestamp requests associated with the given TX queue. This is
+ * called when an XDP pool is being disabled to ensure no stale
+ * timestamp references remain.
+ */
+void igc_ptp_clear_xsk_tx_tstamp_queue(struct igc_adapter *adapter, u16 queue_id)
+{
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+
+	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
+		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
+
+		if (tstamp->buffer_type != IGC_TX_BUFFER_TYPE_XSK)
+			continue;
+		if (tstamp->xsk_queue_index != queue_id)
+			continue;
+		if (!tstamp->xsk_tx_buffer)
+			continue;
+
+		igc_ptp_free_tx_buffer(adapter, tstamp);
+	}
+
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
+}
+
 static void igc_ptp_disable_tx_timestamp(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;

---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260212-igc-fix-xdp-tx-tstamp-pagefault-c4abde453862

Best regards,
-- 
Zdenek Bouska

Siemens, s.r.o.
Foundational Technologies

