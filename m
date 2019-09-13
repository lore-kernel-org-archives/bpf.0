Return-Path: <SRS0=GvDj=XI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79961C4CEC5
	for <bpf@archiver.kernel.org>; Fri, 13 Sep 2019 10:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52099208C2
	for <bpf@archiver.kernel.org>; Fri, 13 Sep 2019 10:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfIMKm2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 13 Sep 2019 06:42:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:8384 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387512AbfIMKm1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 06:42:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 03:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="187784065"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.223.65])
  by orsmga003.jf.intel.com with ESMTP; 13 Sep 2019 03:42:25 -0700
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bjorn.topel@intel.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Cc:     bruce.richardson@intel.com, bpf@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, kevin.laatz@intel.com,
        Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf-next v2 2/3] ixgbe: fix xdp handle calculations
Date:   Fri, 13 Sep 2019 10:39:47 +0000
Message-Id: <20190913103948.32053-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913103948.32053-1-ciara.loftus@intel.com>
References: <20190913103948.32053-1-ciara.loftus@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 7cbbf9f1fa23 ("ixgbe: fix xdp handle calculations") reintroduced
the addition of the umem headroom to the xdp handle in the ixgbe_zca_free,
ixgbe_alloc_buffer_slow_zc and ixgbe_alloc_buffer_zc functions. However,
the headroom is already added to the handle in the function
ixgbe_run_xdp_zc. This commit removes the latter addition and fixes the
case where the headroom is non-zero.

Fixes: 7cbbf9f1fa23 ("ixgbe: fix xdp handle calculations")
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index ad802a8909e0..fd45d12b5a98 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -145,15 +145,15 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 {
 	struct xdp_umem *umem = rx_ring->xsk_umem;
 	int err, result = IXGBE_XDP_PASS;
-	u64 offset = umem->headroom;
 	struct bpf_prog *xdp_prog;
 	struct xdp_frame *xdpf;
+	u64 offset;
 	u32 act;
 
 	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
-	offset += xdp->data - xdp->data_hard_start;
+	offset = xdp->data - xdp->data_hard_start;
 
 	xdp->handle = xsk_umem_adjust_offset(umem, xdp->handle, offset);
 
-- 
2.17.1

