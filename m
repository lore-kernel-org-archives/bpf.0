Return-Path: <SRS0=Fl3P=7K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6F4C433E0
	for <bpf@archiver.kernel.org>; Thu, 28 May 2020 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C138208A7
	for <bpf@archiver.kernel.org>; Thu, 28 May 2020 20:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590698864;
	bh=wX6hpx96dtyHkIEprPgNqQcW0SPTEvVl/tfu04hiw9A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HtySH+jXYPEHMvhtv8+1np7LQWvhu4tsRXcnLka4otc/xSLX1275vWt+zp63GP7WU
	 1X1ihViLmS/m9vV84iX4+mNddybHKXy4TfKN9t9Q3cv3iMojrHucjWx26MrtpzWPiq
	 vxKBTEKUJrLr8N5ZJ7V7jHP2jv0iXxpcr85rZ4/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407304AbgE1Uro (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 May 2020 16:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407240AbgE1Urn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 16:47:43 -0400
Received: from lore-desk.lan (unknown [151.48.140.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296C72074B;
        Thu, 28 May 2020 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590698862;
        bh=wX6hpx96dtyHkIEprPgNqQcW0SPTEvVl/tfu04hiw9A=;
        h=From:To:Cc:Subject:Date:From;
        b=V+NMYmUQjrwKHJKgGWQGsjvSfu9EoApWZ7VpWiz7GB3OQ13+WL8SVSh7rmz6Cp6pJ
         oD9fWfRVcmepBDQTebohDkkA8zMBH5z+fVCGn0k7FJRRTTx8dGkkkROQU0Nq1V8oeL
         CLUHbcQ7ktUf4azyeuIjPfmtm1gVZYxIPXK1TFco=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     ast@kernel.org, davem@davemloft.net, brouer@redhat.com,
        daniel@iogearbox.net, lorenzo.bianconi@redhat.com,
        dsahern@kernel.org
Subject: [PATCH v3 bpf-next 0/2] introduce xdp_convert_frame_to_buff routine
Date:   Thu, 28 May 2020 22:47:27 +0200
Message-Id: <cover.1590698295.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rename convert_to_xdp_frame in xdp_convert_buff_to_frame in order to use
standard 'xdp' prefix

Changes since v2:
- rename convert_to_xdp_buff in xdp_convert_frame_to_buff
- rename convert_to_xdp_frame in xdp_convert_buff_to_frame adding patch 2/2

Changes since v1:
- rely on frame->data pointer to compute xdp->data_hard_start one

Lorenzo Bianconi (2):
  xdp: introduce xdp_convert_frame_to_buff utility routine
  xdp: rename convert_to_xdp_frame in xdp_convert_buff_to_frame

 drivers/net/ethernet/amazon/ena/ena_netdev.c     |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c      |  2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c    |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c     |  2 +-
 drivers/net/ethernet/marvell/mvneta.c            |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 10 +++++-----
 drivers/net/ethernet/sfc/rx.c                    |  2 +-
 drivers/net/ethernet/socionext/netsec.c          |  2 +-
 drivers/net/ethernet/ti/cpsw_priv.c              |  2 +-
 drivers/net/tun.c                                |  2 +-
 drivers/net/veth.c                               |  8 ++------
 drivers/net/virtio_net.c                         |  4 ++--
 include/net/xdp.h                                | 12 +++++++++++-
 kernel/bpf/cpumap.c                              |  2 +-
 kernel/bpf/devmap.c                              |  2 +-
 16 files changed, 32 insertions(+), 26 deletions(-)

-- 
2.26.2

