Return-Path: <SRS0=4a0o=B5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2F9C433E1
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9C205CB
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597843609;
	bh=Y061M4ar3nglvUj4QoM5qnmcswxlbE0Bc8f2da2JCd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qzg3fjWrBIP7VVBf37nG6F+eHW1cVmV/ukcMH7iUHlfXbzP9jvjXQqo1foam+Sk1j
	 65fmVBqTgiFf7LnfWXWH3rf3o5akUgOk4gOQJNN0+8lehC9TXXR1zr9+Wu/Qh83QMO
	 +75QMVKVBoZdNWPshY9L7UmvZK98ng4EKxoQLGCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgHSN0r (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgHSNPu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 09:15:50 -0400
Received: from lore-desk.redhat.com (unknown [151.48.139.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E4F20825;
        Wed, 19 Aug 2020 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597842891;
        bh=Y061M4ar3nglvUj4QoM5qnmcswxlbE0Bc8f2da2JCd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=waDwV3ovAeJ0rxBu4jayO71bWU1iRbaFQefg0soVnP4nr1aSFfZ4c4oOL8abYiIf4
         fvpck8WMylgN+80uTgjmqHnvT8wVjPEGqG4u6toehGP1knZoyI7RyzhJKSL/SlkZLa
         ETjBNWG1nhUBq1OsnjGKTrTiFEtWJubfcwxPaixk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net,
        lorenzo.bianconi@redhat.com, brouer@redhat.com,
        echaudro@redhat.com, sameehj@amazon.com, kuba@kernel.org
Subject: [PATCH net-next 3/6] net: mvneta: update mb bit before passing the xdp buffer to eBPF layer
Date:   Wed, 19 Aug 2020 15:13:48 +0200
Message-Id: <08f8656e906ff69bd30915a6a37a01d5f0422194.1597842004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597842004.git.lorenzo@kernel.org>
References: <cover.1597842004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update multi-buffer bit (mb) in xdp_buff to notify XDP/eBPF layer and
XDP remote drivers if this is a "non-linear" XDP buffer

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 832bbb8b05c8..36a3defa63fa 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2170,11 +2170,14 @@ mvneta_run_xdp(struct mvneta_port *pp, struct mvneta_rx_queue *rxq,
 	       struct bpf_prog *prog, struct xdp_buff *xdp,
 	       u32 frame_sz, struct mvneta_stats *stats)
 {
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 	unsigned int len, data_len, sync;
 	u32 ret, act;
 
 	len = xdp->data_end - xdp->data_hard_start - pp->rx_offset_correction;
 	data_len = xdp->data_end - xdp->data;
+
+	xdp->mb = !!sinfo->nr_frags;
 	act = bpf_prog_run_xdp(prog, xdp);
 
 	/* Due xdp_adjust_tail: DMA sync for_device cover max len CPU touch */
-- 
2.26.2

