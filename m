Return-Path: <SRS0=396g=AN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F9C433DF
	for <bpf@archiver.kernel.org>; Thu,  2 Jul 2020 01:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E84F207F5
	for <bpf@archiver.kernel.org>; Thu,  2 Jul 2020 01:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653741;
	bh=yJmYPEf+/ys7oNlquKCxhblkgjIgqsa8v9szg++uPC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QvL75bEjbJDwQY4Jej4HI08oIQkgvaUwY0+7IPmk9LVzbstzrs+hNetqemgm6l7HL
	 RW6Yehmv9YNAsH6mj47dlyPnIE0jvSYgQPPLjevta4L+w4pTsozCgEUdfgNoLzt2qc
	 YMa0Uajw14jhG/hNKyZ5Q+RmPu+Qvnm7b5FHA5/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGBBfX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgGBBX1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 21:23:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F12F2085B;
        Thu,  2 Jul 2020 01:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653006;
        bh=yJmYPEf+/ys7oNlquKCxhblkgjIgqsa8v9szg++uPC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZZHsZTHN04GvCxNSDXAJbMvVcMe7GsBmV2hdPps0f6w9Yf3XoVbmfmxFXyPH/Cw3
         7dOzc1DtP4+RhQa1LGBfp4gVkbJcJiPw6ElROuRuaJlJFo2zP8nLXgGAsikpVFTeJX
         n0sInxXylMwEkrYo6qM7eud5HXMH9HsaolipWczU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ciara Loftus <ciara.loftus@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 25/53] ixgbe: protect ring accesses with READ- and WRITE_ONCE
Date:   Wed,  1 Jul 2020 21:21:34 -0400
Message-Id: <20200702012202.2700645-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Ciara Loftus <ciara.loftus@intel.com>

[ Upstream commit f140ad9fe2ae16f385f8fe4dc9cf67bb4c51d794 ]

READ_ONCE should be used when reading rings prior to accessing the
statistics pointer. Introduce this as well as the corresponding WRITE_ONCE
usage when allocating and freeing the rings, to ensure protected access.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  | 12 ++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 14 +++++++++++---
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index fd9f5d41b5942..2e35c5706cf10 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -921,7 +921,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 		ring->queue_index = txr_idx;
 
 		/* assign ring to adapter */
-		adapter->tx_ring[txr_idx] = ring;
+		WRITE_ONCE(adapter->tx_ring[txr_idx], ring);
 
 		/* update count and index */
 		txr_count--;
@@ -948,7 +948,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 		set_ring_xdp(ring);
 
 		/* assign ring to adapter */
-		adapter->xdp_ring[xdp_idx] = ring;
+		WRITE_ONCE(adapter->xdp_ring[xdp_idx], ring);
 
 		/* update count and index */
 		xdp_count--;
@@ -991,7 +991,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 		ring->queue_index = rxr_idx;
 
 		/* assign ring to adapter */
-		adapter->rx_ring[rxr_idx] = ring;
+		WRITE_ONCE(adapter->rx_ring[rxr_idx], ring);
 
 		/* update count and index */
 		rxr_count--;
@@ -1020,13 +1020,13 @@ static void ixgbe_free_q_vector(struct ixgbe_adapter *adapter, int v_idx)
 
 	ixgbe_for_each_ring(ring, q_vector->tx) {
 		if (ring_is_xdp(ring))
-			adapter->xdp_ring[ring->queue_index] = NULL;
+			WRITE_ONCE(adapter->xdp_ring[ring->queue_index], NULL);
 		else
-			adapter->tx_ring[ring->queue_index] = NULL;
+			WRITE_ONCE(adapter->tx_ring[ring->queue_index], NULL);
 	}
 
 	ixgbe_for_each_ring(ring, q_vector->rx)
-		adapter->rx_ring[ring->queue_index] = NULL;
+		WRITE_ONCE(adapter->rx_ring[ring->queue_index], NULL);
 
 	adapter->q_vector[v_idx] = NULL;
 	napi_hash_del(&q_vector->napi);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ea6834bae04c0..a32a072761aa2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7065,7 +7065,10 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
 	}
 
 	for (i = 0; i < adapter->num_rx_queues; i++) {
-		struct ixgbe_ring *rx_ring = adapter->rx_ring[i];
+		struct ixgbe_ring *rx_ring = READ_ONCE(adapter->rx_ring[i]);
+
+		if (!rx_ring)
+			continue;
 		non_eop_descs += rx_ring->rx_stats.non_eop_descs;
 		alloc_rx_page += rx_ring->rx_stats.alloc_rx_page;
 		alloc_rx_page_failed += rx_ring->rx_stats.alloc_rx_page_failed;
@@ -7086,15 +7089,20 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
 	packets = 0;
 	/* gather some stats to the adapter struct that are per queue */
 	for (i = 0; i < adapter->num_tx_queues; i++) {
-		struct ixgbe_ring *tx_ring = adapter->tx_ring[i];
+		struct ixgbe_ring *tx_ring = READ_ONCE(adapter->tx_ring[i]);
+
+		if (!tx_ring)
+			continue;
 		restart_queue += tx_ring->tx_stats.restart_queue;
 		tx_busy += tx_ring->tx_stats.tx_busy;
 		bytes += tx_ring->stats.bytes;
 		packets += tx_ring->stats.packets;
 	}
 	for (i = 0; i < adapter->num_xdp_queues; i++) {
-		struct ixgbe_ring *xdp_ring = adapter->xdp_ring[i];
+		struct ixgbe_ring *xdp_ring = READ_ONCE(adapter->xdp_ring[i]);
 
+		if (!xdp_ring)
+			continue;
 		restart_queue += xdp_ring->tx_stats.restart_queue;
 		tx_busy += xdp_ring->tx_stats.tx_busy;
 		bytes += xdp_ring->stats.bytes;
-- 
2.25.1

