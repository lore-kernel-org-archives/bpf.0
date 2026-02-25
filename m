Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17E38F92C
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013532; cv=none; b=s3uFko8/kmksNHz5wS+qZ/SAL9ye6iTBDJH/VqlaqA25bmanPZA2Mw+mkSLHowm0o6T0WisQn+PE0BJoEXj1HBsEjUNjCxU1zzgXcqk1+31VhaYXschTJvFVp+87IvfpL+6+BddoPvDZ4ulKtyTtPQEfcKCzroRBZVYM9OEoRFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013532; c=relaxed/simple;
	bh=Ox0L7LirTZNfJd5VLbNpMdUA+4MnK0U5rhS/1YdWexA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lbh26hlNDb6d07RNYGO6Mt9I/tbkM1DhoHqx33O2C9VZmpLkQgnno7xoJVIDPaqOC2aWjgnjhpOqwfj/RqZDBSq6oaKQhmfvQx+b5TfDbAJDJFbUsVNdmjbz8bg1Bc3zAS6S2U6vv5dpr6ZRZy5s07+8xgcn2iXHGvhU7PvhaGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=zdenek.bouska@siemens.com header.b=POAQ8MaP; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=zdenek.bouska@siemens.com header.b="POAQ8MaP"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026022509583867410a43ac00020767
        for <bpf@vger.kernel.org>;
        Wed, 25 Feb 2026 10:58:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=zdenek.bouska@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=vbj4RSQJDuRYZ5fTpF5eYkTEyvzPIP9uBuxY7VVzDmM=;
 b=POAQ8MaPlX4fuojo9+xfcFWxUf97NiISPsrBO2/DpPm093KQwl0AJglgbNtaQJzz0iIFp6
 AAfPsLjNAV/eE+cPiN9/yvtya0J9mNc6iJ5qioKDKLoiR5g7yarF7s1+VCCEo147aipwwrX+
 HcrlK5Qk4F9EkN6ApiPnnM4FY++3CqEznsh0cfOzSBHXah68oViZ3s45liPWlE572HgU5+yX
 1CsbEiUgOOOWzfz3fLxb6sxQ+L9vFRqXJjhr3+fJQtDOrUTqUdlnML7rYV273MOF1eWSc2pR
 +PE0TVizaznqZI94VNSYZeneQ1VUIEGxhZCUhbsQnyZ7sPwoJZ+OIZUQ==;
From: Zdenek Bouska <zdenek.bouska@siemens.com>
Date: Wed, 25 Feb 2026 10:58:29 +0100
Subject: [PATCH v2] igc: fix page fault in XDP TX timestamps handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-igc-fix-xdp-tx-tstamp-pagefault-v2-1-bf797ec20f3b@siemens.com>
X-B4-Tracking: v=1; b=H4sIAMTHnmkC/4WNyw6CMBBFf4XM2jF05KGu/A/DopYBJhHatJVgC
 P9uJe5dnpubc1YI7IUDXLMVPM8SxE4J6JCBGfTUM0qbGCinKidFKL3BThZcWodxwRiiHh063XO
 nX8+IptCPlovydK4IksV5Tve9cG8SDxKi9e89OKvv+nNT8dc9K1RYm5ou3FWKubwF4ZGncDR2h
 Gbbtg9mcT600AAAAA==
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
Changes in v2:
- Moved 'adapter' variable declaration into the if block (Vinicius)
- Link to v1: https://lore.kernel.org/r/20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com
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
index 89a321a344d263ace5c66f7ade782b40cc482566..1931fcb659354d5009e0ea02316bf3a47b66b04d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -264,6 +264,13 @@ static void igc_clean_tx_ring(struct igc_ring *tx_ring)
 	/* reset next_to_use and next_to_clean */
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
+
+	/* Clear any lingering XSK TX timestamp requests */
+	if (test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags)) {
+		struct igc_adapter *adapter = netdev_priv(tx_ring->netdev);
+
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

