Return-Path: <SRS0=4a0o=B5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8772AC433E1
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 13:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59252205CB
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597843614;
	bh=rmxXFYnJhm6AclYJvk4E3lIKlyPcgCSgmhQTuA+q5ck=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=U1FjIjbVmlXd7inMtBGd7/Wo5xfH6n+qhiUd/BnOKHng2moWXR9sh1xJdc2pOUm+e
	 1QZa6/qI5G4863gjeAWcy0NfLr5M7O2Rn6n5B4kGIBop5uihOLXc9NYATSFzR6dbag
	 tgfGRk32q35EddFHFnbDf0Ax7epQNayUcOnuBSqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgHSN0r (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgHSNPv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 09:15:51 -0400
Received: from lore-desk.redhat.com (unknown [151.48.139.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9777206FA;
        Wed, 19 Aug 2020 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597842878;
        bh=rmxXFYnJhm6AclYJvk4E3lIKlyPcgCSgmhQTuA+q5ck=;
        h=From:To:Cc:Subject:Date:From;
        b=r6WpotYD0apYJ5cM1HQ1ixPr9O9rC2VgtFPSCGeu/GB9bLEjQtt5sdIa6jtVbsXSA
         0crujSauqlk3Rwqui+PD5s6n8yrqqzqUEXM/xupSLBfW1PbPOcDC/PTHNGW5mcJXCZ
         6VHkl1xOVjHfoWrcSXRPXHl73gZc7ldqtEAPeA4o=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net,
        lorenzo.bianconi@redhat.com, brouer@redhat.com,
        echaudro@redhat.com, sameehj@amazon.com, kuba@kernel.org
Subject: [PATCH net-next 0/6] mvneta: introduce XDP multi-buffer support
Date:   Wed, 19 Aug 2020 15:13:45 +0200
Message-Id: <cover.1597842004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Finalize XDP multi-buffer support for mvneta driver introducing the capability
to map non-linear buffers on tx side.
Introduce multi-buffer bit (mb) in xdp_frame/xdp_buffer to specify if
shared_info area has been properly initialized.
Initialize multi-buffer bit (mb) to 0 in all XDP-capable drivers.
Add multi-buff support to xdp_return_{buff/frame} utility routines.

Changes since RFC:
- squash multi-buffer bit initialization in a single patch
- add mvneta non-linear XDP buff support for tx side

Lorenzo Bianconi (6):
  xdp: introduce mb in xdp_buff/xdp_frame
  xdp: initialize xdp_buff mb bit to 0 in all XDP drivers
  net: mvneta: update mb bit before passing the xdp buffer to eBPF layer
  xdp: add multi-buff support to xdp_return_{buff/frame}
  net: mvneta: add multi buffer support to XDP_TX
  net: mvneta: enable jumbo frames for XDP

 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  1 +
 .../net/ethernet/cavium/thunder/nicvf_main.c  |  1 +
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  1 +
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  1 +
 drivers/net/ethernet/marvell/mvneta.c         | 92 +++++++++++--------
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  1 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  1 +
 .../ethernet/netronome/nfp/nfp_net_common.c   |  1 +
 drivers/net/ethernet/qlogic/qede/qede_fp.c    |  1 +
 drivers/net/ethernet/sfc/rx.c                 |  1 +
 drivers/net/ethernet/socionext/netsec.c       |  1 +
 drivers/net/ethernet/ti/cpsw.c                |  1 +
 drivers/net/ethernet/ti/cpsw_new.c            |  1 +
 drivers/net/hyperv/netvsc_bpf.c               |  1 +
 drivers/net/tun.c                             |  2 +
 drivers/net/veth.c                            |  1 +
 drivers/net/virtio_net.c                      |  2 +
 drivers/net/xen-netfront.c                    |  1 +
 include/net/xdp.h                             | 25 ++++-
 net/core/dev.c                                |  1 +
 net/core/xdp.c                                | 37 ++++++++
 26 files changed, 135 insertions(+), 44 deletions(-)

-- 
2.26.2

