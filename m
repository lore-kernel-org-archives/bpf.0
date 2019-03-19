Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F30C4360F
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AE12175B
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gag5uOQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCSWUR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:17 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:42608 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfCSWUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:17 -0400
Received: by mail-yw1-f73.google.com with SMTP id c74so372778ywc.9
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hJ9IqsKLcKNtBIX8Ec/mXjnNU831bOxZnsMkbVqHiVI=;
        b=Gag5uOQop258MJdjnAYrHkUNMMQW7VDUUG1FSmMW8KBoZIXcnhW2sFE+R+Iqi13nVl
         YvI/vD3u4ELmaHFiML9MIkA8g4zfi22/zH//wb9Bzg19GGRdPjMA0l3g2n8URjvUT4XJ
         wZUySbrBHrnL5M0+ohLtNezQ8mRvfcPGBpgQCIg0EkxtnWT+VxaNJBilGq45tPuwmP6g
         qJVpp8YIs8IOWjrzS09ET7wAsPin/ftE/PtbsCkFEjYSuy6I5VDuWJVx07y97uVW52pH
         sfACGBBThob9Ff8XCq9XAsXi8UMK8w1yl3eCigJvQmhIsMptFUesUgdMBd/CGB05YnOL
         415w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hJ9IqsKLcKNtBIX8Ec/mXjnNU831bOxZnsMkbVqHiVI=;
        b=T5mIVS8d7Nr+xe88/opc14t08c3cCBDgOvrViXGNZpsMxvHsFMOi7EWGKAI56DiQIh
         cu1WSO7Y3i+3dpEfrwmUXP+4tPBz7zcRGEe4KzmqIPWdmdSJEejJg5LPaBWkCSAKl2XE
         Wl9kbG81ey1YgD+CNGuwJ2JiIoca7AE/UKHP8XjGDNxhZS6k/YVR/07cVEq9/AH+5XMe
         yj9w/e70Cpo+9eA+kF8mQF3WJn62jkOQD6YFZk3+z2quO0WtZ5EAhLN3nmX2oPw7BLlS
         2p2UEsIQWJ7AEcOmwNyV3xM2Q5Y/r85veSFeWjXQR/+4xiUkD6KY07VNSVZAcjUejFxq
         fVRA==
X-Gm-Message-State: APjAAAWZRmS8gIZJp6qTE8iEiyJYeyd9RjW4aQNyjEI4C68YFCYlQZU1
        7VZwUXVx6sjLkgTHbnmLSVHiU3I=
X-Google-Smtp-Source: APXvYqxOH4ulX+P7iFWiVKX2KnvNNB5jc7aDj0FN0XdRsrJUK9PhG/HKrjvSiiIZoDDiKMxHhfY1FUc=
X-Received: by 2002:a25:660d:: with SMTP id a13mr1598104ybc.0.1553034016608;
 Tue, 19 Mar 2019 15:20:16 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:48 -0700
In-Reply-To: <20190319221948.170441-1-sdf@google.com>
Message-Id: <20190319221948.170441-10-sdf@google.com>
Mime-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC bpf-next v2 9/9] net: flow_dissector: pass net argument to the eth_get_headlen
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an example and for RFC only, just to show what the end result
would look like. In a proper submission, we need to introduce new
helper and convert each driver one by one to make sure we don't
break 'git bisect'.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c     | 3 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   | 3 ++-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 3 ++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c       | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c         | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c         | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c         | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   | 3 ++-
 drivers/net/tun.c                                 | 3 ++-
 include/linux/etherdevice.h                       | 2 +-
 net/ethernet/eth.c                                | 5 +++--
 15 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0bb9d7b3a2b6..664e6392f71d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -899,7 +899,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 			     DMA_ATTR_WEAK_ORDERING);
 
 	if (unlikely(!payload))
-		payload = eth_get_headlen(data_ptr, len);
+		payload = eth_get_headlen(dev_net(bp->dev), data_ptr, len);
 
 	skb = napi_alloc_skb(&rxr->bnapi->napi, payload);
 	if (!skb) {
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 60e7d7ae3787..caf075a7449c 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -603,7 +603,8 @@ static int hns_nic_poll_rx_skb(struct hns_nic_ring_data *ring_data,
 	} else {
 		ring->stats.seg_pkt_cnt++;
 
-		pull_len = eth_get_headlen(va, HNS_RX_HEAD_SIZE);
+		pull_len = eth_get_headlen(dev_net(ndev), va,
+					   HNS_RX_HEAD_SIZE);
 		memcpy(__skb_put(skb, pull_len), va,
 		       ALIGN(pull_len, sizeof(long)));
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 1c1f17ec6be2..265bb8e47d48 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2438,7 +2438,8 @@ static int hns3_alloc_skb(struct hns3_enet_ring *ring, int length,
 	ring->stats.seg_pkt_cnt++;
 	u64_stats_update_end(&ring->syncp);
 
-	ring->pull_len = eth_get_headlen(va, HNS3_RX_HEAD_SIZE);
+	ring->pull_len = eth_get_headlen(dev_net(netdev), va,
+					 HNS3_RX_HEAD_SIZE);
 	__skb_put(skb, ring->pull_len);
 	hns3_nic_reuse_page(skb, ring->frag_num++, ring, ring->pull_len,
 			    desc_cb);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 5a0419421511..d1b4b259b90b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -278,7 +278,7 @@ static bool fm10k_add_rx_frag(struct fm10k_rx_buffer *rx_buffer,
 	/* we need the header to contain the greater of either ETH_HLEN or
 	 * 60 bytes if the skb->len is less than 60 for skb_pad.
 	 */
-	pull_len = eth_get_headlen(va, FM10K_RX_HDR_LEN);
+	pull_len = eth_get_headlen(skb_net(skb), va, FM10K_RX_HDR_LEN);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, pull_len), va, ALIGN(pull_len, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 6c97667d20ef..9e42a3526360 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2035,7 +2035,8 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > I40E_RX_HDR_SIZE)
-		headlen = eth_get_headlen(xdp->data, I40E_RX_HDR_SIZE);
+		headlen = eth_get_headlen(skb_net(skb), xdp->data,
+					  I40E_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), xdp->data,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 9b4d7cec2e18..d3c7fd521fd7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1315,7 +1315,7 @@ static struct sk_buff *iavf_construct_skb(struct iavf_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IAVF_RX_HDR_SIZE)
-		headlen = eth_get_headlen(va, IAVF_RX_HDR_SIZE);
+		headlen = eth_get_headlen(skb_net(skb), va, IAVF_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index c289d97f477d..665ac75bb8ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -704,7 +704,7 @@ static void ice_pull_tail(struct sk_buff *skb)
 	/* we need the header to contain the greater of either ETH_HLEN or
 	 * 60 bytes if the skb->len is less than 60 for skb_pad.
 	 */
-	pull_len = eth_get_headlen(va, ICE_RX_HDR_SIZE);
+	pull_len = eth_get_headlen(skb_net(skb), va, ICE_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 69b230c53fed..55388c2b72b7 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8048,7 +8048,7 @@ static struct sk_buff *igb_construct_skb(struct igb_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IGB_RX_HDR_LEN)
-		headlen = eth_get_headlen(va, IGB_RX_HDR_LEN);
+		headlen = eth_get_headlen(skb_net(skb), va, IGB_RX_HDR_LEN);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 87a11879bf2d..9ea32e9d72c4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1150,7 +1150,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IGC_RX_HDR_LEN)
-		headlen = eth_get_headlen(va, IGC_RX_HDR_LEN);
+		headlen = eth_get_headlen(skb_net(skb), va, IGC_RX_HDR_LEN);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index e100054a3765..2fd75d761522 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1800,7 +1800,7 @@ static void ixgbe_pull_tail(struct ixgbe_ring *rx_ring,
 	 * we need the header to contain the greater of either ETH_HLEN or
 	 * 60 bytes if the skb->len is less than 60 for skb_pad.
 	 */
-	pull_len = eth_get_headlen(va, IXGBE_RX_HDR_SIZE);
+	pull_len = eth_get_headlen(skb_net(skb), va, IXGBE_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 49e23afa05a2..c45be7487d57 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -895,7 +895,8 @@ struct sk_buff *ixgbevf_construct_skb(struct ixgbevf_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IXGBEVF_RX_HDR_SIZE)
-		headlen = eth_get_headlen(xdp->data, IXGBEVF_RX_HDR_SIZE);
+		headlen = eth_get_headlen(skb_net(skb), xdp->data,
+					  IXGBEVF_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), xdp->data,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 25a8f8260c14..31beb9f92a2b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -163,7 +163,8 @@ static inline u16 mlx5e_calc_min_inline(enum mlx5_inline_modes mode,
 	case MLX5_INLINE_MODE_NONE:
 		return 0;
 	case MLX5_INLINE_MODE_TCP_UDP:
-		hlen = eth_get_headlen(skb->data, skb_headlen(skb));
+		hlen = eth_get_headlen(skb_net(skb), skb->data,
+				       skb_headlen(skb));
 		if (hlen == ETH_HLEN && !skb_vlan_tag_present(skb))
 			hlen += VLAN_HLEN;
 		break;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e9ca1c088d0b..dc7e343e4f79 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1966,7 +1966,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (frags) {
 		/* Exercise flow dissector code path. */
-		u32 headlen = eth_get_headlen(skb->data, skb_headlen(skb));
+		u32 headlen = eth_get_headlen(skb_net(skb), skb->data,
+					      skb_headlen(skb));
 
 		if (unlikely(headlen > skb_headlen(skb))) {
 			this_cpu_inc(tun->pcpu_stats->rx_dropped);
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index e2f3b21cd72a..782baa417685 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -33,7 +33,7 @@ struct device;
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
 unsigned char *arch_get_platform_mac_address(void);
 int nvmem_get_mac_address(struct device *dev, void *addrbuf);
-u32 eth_get_headlen(void *data, unsigned int max_len);
+u32 eth_get_headlen(struct net *net, void *data, unsigned int max_len);
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
 extern const struct header_ops eth_header_ops;
 
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 1e439549c419..a41e87816a48 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -119,13 +119,14 @@ EXPORT_SYMBOL(eth_header);
 
 /**
  * eth_get_headlen - determine the length of header for an ethernet frame
+ * @net: pointer to device network namespace
  * @data: pointer to start of frame
  * @len: total length of frame
  *
  * Make a best effort attempt to pull the length for all of the headers for
  * a given frame in a linear buffer.
  */
-u32 eth_get_headlen(void *data, unsigned int len)
+u32 eth_get_headlen(struct net *net, void *data, unsigned int len)
 {
 	const unsigned int flags = FLOW_DISSECTOR_F_PARSE_1ST_FRAG;
 	const struct ethhdr *eth = (const struct ethhdr *)data;
@@ -136,7 +137,7 @@ u32 eth_get_headlen(void *data, unsigned int len)
 		return len;
 
 	/* parse any remaining L2/L3 headers, check for L4 */
-	if (!skb_flow_dissect_flow_keys_basic(NULL, NULL, &keys, data,
+	if (!skb_flow_dissect_flow_keys_basic(net, NULL, &keys, data,
 					      eth->h_proto, sizeof(*eth),
 					      len, flags))
 		return max_t(u32, keys.control.thoff, sizeof(*eth));
-- 
2.21.0.225.g810b269d1ac-goog

