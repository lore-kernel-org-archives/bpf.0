Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E18CC433E3
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D2622B43
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595504576;
	bh=8oBfRskePkkS6eyvSY1a9b5Gu4gA3IFuwT0e4ypbaQI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JA4ppuVUiZWOdnfeTdj1TnoWAAWRXE8iozH4J8TvCKGgOj+ZBpS84eo3NDB8ib92w
	 adLRxiyh27SjJk+gnXK5Chdh4sjxa3rT+dZgyvdyxKlf3ohzdXpif0U86FijM9gyKm
	 LHTV6mFV6sT9JuWrD5lM+jb3qZ+CDisMcqa/7q+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgGWLmz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgGWLmz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 07:42:55 -0400
Received: from lore-desk.redhat.com (unknown [151.48.142.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B2A42080D;
        Thu, 23 Jul 2020 11:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595504575;
        bh=8oBfRskePkkS6eyvSY1a9b5Gu4gA3IFuwT0e4ypbaQI=;
        h=From:To:Cc:Subject:Date:From;
        b=ayI0+g+7iwpKZlcrg/wNgNOuksLf0JTz5Skk9hrBLgAiAz8/pHCol29YPh447lYp9
         DKb/iffv2d8HdltJm/bCQBWGirxvRJx75evOLw63+EgDjPaVRqU4bNXHavnMluYfpI
         oCQftxXBF7toGvMgrBXqyuNlYe09L4z59vPPGCJw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        brouer@redhat.com, daniel@iogearbox.net,
        lorenzo.bianconi@redhat.com, echaudro@redhat.com,
        sameehj@amazon.com, kuba@kernel.org
Subject: [RFC net-next 00/22] Introduce mb bit in xdp_buff/xdp_frame
Date:   Thu, 23 Jul 2020 13:42:12 +0200
Message-Id: <cover.1595503780.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce multi-buffer bit (mb) in xdp_frame/xdp_buffer to specify
if shared_info area has been properly initialized for non-linear
xdp buffers.
Initialize mb to 0 for all xdp drivers

Lorenzo Bianconi (22):
  xdp: introduce mb in xdp_buff/xdp_frame
  xdp: initialize xdp_buff mb bit to 0 in netif_receive_generic_xdp
  net: virtio_net: initialize mb bit of xdp_buff to 0
  net: xen-netfront: initialize mb bit of xdp_buff to 0
  net: veth: initialize mb bit of xdp_buff to 0
  net: hv_netvsc: initialize mb bit of xdp_buff to 0
  net: bnxt: initialize mb bit in xdp_buff to 0
  net: dpaa2: initialize mb bit in xdp_buff to 0
  net: ti: initialize mb bit in xdp_buff to 0
  net: nfp: initialize mb bit in xdp_buff to 0
  net: mvpp2: initialize mb bit in xdp_buff to 0
  net: sfc: initialize mb bit in xdp_buff to 0
  net: qede: initialize mb bit in xdp_buff to 0
  net: amazon: ena: initialize mb bit in xdp_buff to 0
  net: cavium: thunder: initialize mb bit in xdp_buff to 0
  net: socionext: initialize mb bit in xdp_buff to 0
  net: tun: initialize mb bit in xdp_buff to 0
  net: ixgbe: initialize mb bit in xdp_buff to 0
  net: ice: initialize mb bit in xdp_buff to 0
  net: i40e: initialize mb bit in xdp_buff to 0
  net: mlx5: initialize mb bit in xdp_buff to 0
  net: mlx4: initialize mb bit in xdp_buff to 0

 drivers/net/ethernet/amazon/ena/ena_netdev.c        | 1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c       | 1 +
 drivers/net/ethernet/cavium/thunder/nicvf_main.c    | 1 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c    | 1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c         | 1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c           | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c       | 1 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c   | 1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c     | 1 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c          | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c     | 1 +
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 1 +
 drivers/net/ethernet/qlogic/qede/qede_fp.c          | 1 +
 drivers/net/ethernet/sfc/rx.c                       | 1 +
 drivers/net/ethernet/socionext/netsec.c             | 1 +
 drivers/net/ethernet/ti/cpsw.c                      | 1 +
 drivers/net/ethernet/ti/cpsw_new.c                  | 1 +
 drivers/net/hyperv/netvsc_bpf.c                     | 1 +
 drivers/net/tun.c                                   | 2 ++
 drivers/net/veth.c                                  | 1 +
 drivers/net/virtio_net.c                            | 2 ++
 drivers/net/xen-netfront.c                          | 1 +
 include/net/xdp.h                                   | 8 ++++++--
 net/core/dev.c                                      | 1 +
 24 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.26.2

