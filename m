Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D46C282CE
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C22D2077C
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJ6iqGnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfDVP4J (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:56:09 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:55713 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfDVP4I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 11:56:08 -0400
Received: by mail-vk1-f201.google.com with SMTP id z6so5743786vkf.22
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x3x0dxrLN6N1eimpZj4gMK3KhGsEP3CbyzCFG0I5C8k=;
        b=JJ6iqGnXbGk+SEemrwNgxJbsFhorkRkwsfYokiq09ti9YBTn9RO+Z/n/37k8O/v/Te
         Ea/myZoGJhrxtGozGiiH1zAI05r37OAH2CQEFhQtte2fL5YZzbERvnawn34v0LRnWk0C
         0/+TJj7V0c/i7DMRg2b1d0as3PO/re09puxCkglyBmCc5ckhkxct5TixPFCHfAog9Pye
         zzN+IZs1s99CrAsKKBR0Zn5kbAwEi5fVAU0XZ5Ql0jPPxmBDsY0z4AUaem9msTyHcKRf
         rTxsJyj19AIqpq1Dq1ZgtkUEpu8AyCoUgQ9bJpQIDy44H1H2A7OdX53n9WZhyrBvr71t
         5WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x3x0dxrLN6N1eimpZj4gMK3KhGsEP3CbyzCFG0I5C8k=;
        b=eBPySTknLXS5gvwJ+RfRZ6eVPcoztwK4tD7Mtlbe0qtN3hmXbAvUM8pAep3EYTrIAQ
         Ji1HE1fSiAfxab036y+PYS7yfpZTQqiP/LE3wyRGnUHJXvYgnw9G/5KQ4SeCTlerEaeG
         qVd6ki1g4oY3+a2SSz8zXiYtBOprtd1+c3Z8rAhNF54AS+HpapUEvrUKCJcKofAX+iXf
         TbplyG3iO+XzBc8qkBUhO0YAC2Chw38SV3VCZzFp5tjmNMfXc6MT4KvxijUYX4/RbxRD
         t0RvfOETo/a4VKSFk+/WUN8qzod7Dmg6TbfMAU/2uM5wouvTkrelyUW8mP4/xHhCDIEZ
         tiZg==
X-Gm-Message-State: APjAAAWBPQsNilZDWJgWWYhvZdCEZ2B6blvh0JgEppfwW118wJpD13pL
        WFFV1wSxkQ8fbPNHrPg+1sZWbeM=
X-Google-Smtp-Source: APXvYqxnIqbXU8o6gTrkV9w7mqbAZIC9n6fxa7BgS5kTE4PDPFizmJCoTSmgJUBLppsOofbHqZB6yBw=
X-Received: by 2002:ab0:6849:: with SMTP id a9mr496540uas.135.1555948566985;
 Mon, 22 Apr 2019 08:56:06 -0700 (PDT)
Date:   Mon, 22 Apr 2019 08:55:48 -0700
In-Reply-To: <20190422155552.222910-1-sdf@google.com>
Message-Id: <20190422155552.222910-6-sdf@google.com>
Mime-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v6 5/9] net: pass net_device argument to the eth_get_headlen
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update all users of eth_get_headlen to pass network device, fetch
network namespace from it and pass it down to the flow dissector.
This commit is a noop until administrator inserts BPF flow dissector
program.

Cc: Maxim Krasnyansky <maxk@qti.qualcomm.com>
Cc: Saeed Mahameed <saeedm@mellanox.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Salil Mehta <salil.mehta@huawei.com>
Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c  | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c     | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   | 2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 3 ++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c       | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c         | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c         | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c         | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   | 2 +-
 drivers/net/tun.c                                 | 3 ++-
 include/linux/etherdevice.h                       | 2 +-
 net/ethernet/eth.c                                | 5 +++--
 16 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index c64e2fb5a4f1..350e385528fd 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -354,7 +354,8 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 
 			hdr_len = buff->len;
 			if (hdr_len > AQ_CFG_RX_HDR_SIZE)
-				hdr_len = eth_get_headlen(aq_buf_vaddr(&buff->rxdata),
+				hdr_len = eth_get_headlen(skb->dev,
+							  aq_buf_vaddr(&buff->rxdata),
 							  AQ_CFG_RX_HDR_SIZE);
 
 			memcpy(__skb_put(skb, hdr_len), aq_buf_vaddr(&buff->rxdata),
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6528a597367b..526f36dcb204 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -899,7 +899,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 			     DMA_ATTR_WEAK_ORDERING);
 
 	if (unlikely(!payload))
-		payload = eth_get_headlen(data_ptr, len);
+		payload = eth_get_headlen(bp->dev, data_ptr, len);
 
 	skb = napi_alloc_skb(&rxr->bnapi->napi, payload);
 	if (!skb) {
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 297b95c1b3c1..65b985acae38 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -598,7 +598,7 @@ static int hns_nic_poll_rx_skb(struct hns_nic_ring_data *ring_data,
 	} else {
 		ring->stats.seg_pkt_cnt++;
 
-		pull_len = eth_get_headlen(va, HNS_RX_HEAD_SIZE);
+		pull_len = eth_get_headlen(ndev, va, HNS_RX_HEAD_SIZE);
 		memcpy(__skb_put(skb, pull_len), va,
 		       ALIGN(pull_len, sizeof(long)));
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b53b0911ec24..f2b5489ee796 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2457,7 +2457,7 @@ static int hns3_alloc_skb(struct hns3_enet_ring *ring, int length,
 	ring->stats.seg_pkt_cnt++;
 	u64_stats_update_end(&ring->syncp);
 
-	ring->pull_len = eth_get_headlen(va, HNS3_RX_HEAD_SIZE);
+	ring->pull_len = eth_get_headlen(netdev, va, HNS3_RX_HEAD_SIZE);
 	__skb_put(skb, ring->pull_len);
 	hns3_nic_reuse_page(skb, ring->frag_num++, ring, ring->pull_len,
 			    desc_cb);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 2325cee76211..b4d970e44163 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -280,7 +280,7 @@ static bool fm10k_add_rx_frag(struct fm10k_rx_buffer *rx_buffer,
 	/* we need the header to contain the greater of either ETH_HLEN or
 	 * 60 bytes if the skb->len is less than 60 for skb_pad.
 	 */
-	pull_len = eth_get_headlen(va, FM10K_RX_HDR_LEN);
+	pull_len = eth_get_headlen(skb->dev, va, FM10K_RX_HDR_LEN);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, pull_len), va, ALIGN(pull_len, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 1a95223c9f99..e1931701cd7e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2035,7 +2035,8 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > I40E_RX_HDR_SIZE)
-		headlen = eth_get_headlen(xdp->data, I40E_RX_HDR_SIZE);
+		headlen = eth_get_headlen(skb->dev, xdp->data,
+					  I40E_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), xdp->data,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index b64187753ad6..cf8be63a8a4f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1315,7 +1315,7 @@ static struct sk_buff *iavf_construct_skb(struct iavf_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IAVF_RX_HDR_SIZE)
-		headlen = eth_get_headlen(va, IAVF_RX_HDR_SIZE);
+		headlen = eth_get_headlen(skb->dev, va, IAVF_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a6f7b7feaf3c..4ef6ae942656 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -698,7 +698,7 @@ ice_construct_skb(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > ICE_RX_HDR_SIZE)
-		headlen = eth_get_headlen(va, ICE_RX_HDR_SIZE);
+		headlen = eth_get_headlen(skb->dev, va, ICE_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index acbb5b4f333d..9b8a4bb25327 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8051,7 +8051,7 @@ static struct sk_buff *igb_construct_skb(struct igb_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IGB_RX_HDR_LEN)
-		headlen = eth_get_headlen(va, IGB_RX_HDR_LEN);
+		headlen = eth_get_headlen(skb->dev, va, IGB_RX_HDR_LEN);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index f79728381e8a..e58a6e0dc4d9 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1199,7 +1199,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IGC_RX_HDR_LEN)
-		headlen = eth_get_headlen(va, IGC_RX_HDR_LEN);
+		headlen = eth_get_headlen(skb->dev, va, IGC_RX_HDR_LEN);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 60cec3540dd7..7b903206b534 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1800,7 +1800,7 @@ static void ixgbe_pull_tail(struct ixgbe_ring *rx_ring,
 	 * we need the header to contain the greater of either ETH_HLEN or
 	 * 60 bytes if the skb->len is less than 60 for skb_pad.
 	 */
-	pull_len = eth_get_headlen(va, IXGBE_RX_HDR_SIZE);
+	pull_len = eth_get_headlen(skb->dev, va, IXGBE_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 49e23afa05a2..d189ed247665 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -895,7 +895,8 @@ struct sk_buff *ixgbevf_construct_skb(struct ixgbevf_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IXGBEVF_RX_HDR_SIZE)
-		headlen = eth_get_headlen(xdp->data, IXGBEVF_RX_HDR_SIZE);
+		headlen = eth_get_headlen(skb->dev, xdp->data,
+					  IXGBEVF_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
 	memcpy(__skb_put(skb, headlen), xdp->data,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 40f3f98aa279..7b61126fcec9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -163,7 +163,7 @@ static inline u16 mlx5e_calc_min_inline(enum mlx5_inline_modes mode,
 	case MLX5_INLINE_MODE_NONE:
 		return 0;
 	case MLX5_INLINE_MODE_TCP_UDP:
-		hlen = eth_get_headlen(skb->data, skb_headlen(skb));
+		hlen = eth_get_headlen(skb->dev, skb->data, skb_headlen(skb));
 		if (hlen == ETH_HLEN && !skb_vlan_tag_present(skb))
 			hlen += VLAN_HLEN;
 		break;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 24d0220b9ba0..9d72f8c76c15 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1965,7 +1965,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (frags) {
 		/* Exercise flow dissector code path. */
-		u32 headlen = eth_get_headlen(skb->data, skb_headlen(skb));
+		u32 headlen = eth_get_headlen(tun->dev, skb->data,
+					      skb_headlen(skb));
 
 		if (unlikely(headlen > skb_headlen(skb))) {
 			this_cpu_inc(tun->pcpu_stats->rx_dropped);
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index e2f3b21cd72a..c6c1930e28a0 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -33,7 +33,7 @@ struct device;
 int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
 unsigned char *arch_get_platform_mac_address(void);
 int nvmem_get_mac_address(struct device *dev, void *addrbuf);
-u32 eth_get_headlen(void *data, unsigned int max_len);
+u32 eth_get_headlen(const struct net_device *dev, void *data, unsigned int len);
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
 extern const struct header_ops eth_header_ops;
 
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 1e439549c419..0f9863dc4d44 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -119,13 +119,14 @@ EXPORT_SYMBOL(eth_header);
 
 /**
  * eth_get_headlen - determine the length of header for an ethernet frame
+ * @dev: pointer to network device
  * @data: pointer to start of frame
  * @len: total length of frame
  *
  * Make a best effort attempt to pull the length for all of the headers for
  * a given frame in a linear buffer.
  */
-u32 eth_get_headlen(void *data, unsigned int len)
+u32 eth_get_headlen(const struct net_device *dev, void *data, unsigned int len)
 {
 	const unsigned int flags = FLOW_DISSECTOR_F_PARSE_1ST_FRAG;
 	const struct ethhdr *eth = (const struct ethhdr *)data;
@@ -136,7 +137,7 @@ u32 eth_get_headlen(void *data, unsigned int len)
 		return len;
 
 	/* parse any remaining L2/L3 headers, check for L4 */
-	if (!skb_flow_dissect_flow_keys_basic(NULL, NULL, &keys, data,
+	if (!skb_flow_dissect_flow_keys_basic(dev_net(dev), NULL, &keys, data,
 					      eth->h_proto, sizeof(*eth),
 					      len, flags))
 		return max_t(u32, keys.control.thoff, sizeof(*eth));
-- 
2.21.0.593.g511ec345e18-goog

