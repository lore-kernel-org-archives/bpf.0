Return-Path: <SRS0=L8C4=EE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3345BC2D0A3
	for <bpf@archiver.kernel.org>; Thu, 29 Oct 2020 19:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDED520796
	for <bpf@archiver.kernel.org>; Thu, 29 Oct 2020 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603999787;
	bh=oAprieKuw4Y/NSNpSPIW2/x4vRSmn30JSRz7wRBT+/E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aKp70rApyNJIfnd6pFgEFk6XdnxEVtDODEBRAZsGzyookXHbwit/VnExN9dzpSLTg
	 T623cGGiNTxJ2BC/mryC3fD+m50+zmI0q411tUZUyv1JwUWssi2SykdL8m5zOa9125
	 gycKMV8PXtOm/A7oRuVrB8yAacHaUBfMw7TC8b+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgJ2T3l (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Oct 2020 15:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgJ2T3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 15:29:32 -0400
Received: from lore-desk.redhat.com (unknown [151.66.29.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B8DC204FD;
        Thu, 29 Oct 2020 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603999737;
        bh=oAprieKuw4Y/NSNpSPIW2/x4vRSmn30JSRz7wRBT+/E=;
        h=From:To:Cc:Subject:Date:From;
        b=YCoi2EfUy+4BzvW2/+iao4LP8fxxc5EMX4LKu0cNDseM9akHcAoZmHPn7fW3Z+2fo
         rD6qFGU6xqs5v7A9V01oLRAmCvYgudGqPSfb5ehjq6dgQ4P2yarUiya6yPWVIe6Qkr
         taFmZ46/oiCF3PYWGiBevVOz0oeWpZoUxb20+GT8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, brouer@redhat.com,
        ilias.apalodimas@linaro.org
Subject: [PATCH v2 net-next 0/4] xdp: introduce bulking for page_pool tx return path
Date:   Thu, 29 Oct 2020 20:28:43 +0100
Message-Id: <cover.1603998519.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

XDP bulk APIs introduce a defer/flush mechanism to return
pages belonging to the same xdp_mem_allocator object
(identified via the mem.id field) in bulk to optimize
I-cache and D-cache since xdp_return_frame is usually run
inside the driver NAPI tx completion loop.
Convert mvneta, mvpp2 and mlx5 drivers to xdp_return_frame_bulk APIs.

Changes since v1:
- improve comments
- rework xdp_return_frame_bulk routine logic
- move count and xa fields at the beginning of xdp_frame_bulk struct
- invert logic in page_pool_put_page_bulk for loop

Lorenzo Bianconi (4):
  net: xdp: introduce bulking for xdp tx return path
  net: page_pool: add bulk support for ptr_ring
  net: mvpp2: add xdp tx return bulking support
  net: mlx5: add xdp tx return bulking support

 drivers/net/ethernet/marvell/mvneta.c         |  5 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  5 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  5 +-
 include/net/page_pool.h                       | 26 +++++++++
 include/net/xdp.h                             |  9 +++
 net/core/page_pool.c                          | 35 ++++++++++++
 net/core/xdp.c                                | 56 +++++++++++++++++++
 7 files changed, 138 insertions(+), 3 deletions(-)

-- 
2.26.2

