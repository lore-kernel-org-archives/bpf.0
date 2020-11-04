Return-Path: <SRS0=nPxa=EK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB063C388F7
	for <bpf@archiver.kernel.org>; Wed,  4 Nov 2020 10:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6323A223FD
	for <bpf@archiver.kernel.org>; Wed,  4 Nov 2020 10:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604485471;
	bh=+RUZHynLyxTatAmq9hoGDTN7qqG/7NdYssFLQkyjpbk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1Ko0fiSUU0mxWDOovxWTwla69HHypDAjqU0gWVsT+PmF7fBL6W186iWch1DqjDQg8
	 HYDoPl0UHZVI1qWHo3kWNuFjMhTZUGtIK5o/sHnq0SaONjZsd22dMEt+NWUe+vgikm
	 HRK/3RxX5fbJEQovFwLa3CkaVHFSIlayJji7kNh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgKDKYa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Nov 2020 05:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgKDKXI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 05:23:08 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE3B223AB;
        Wed,  4 Nov 2020 10:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604485387;
        bh=+RUZHynLyxTatAmq9hoGDTN7qqG/7NdYssFLQkyjpbk=;
        h=From:To:Cc:Subject:Date:From;
        b=jan2z8DmW/i/koF9YOZgmPubatlBkDg+NL5itOcjeGgKr4yGEz8VcNyY2nYDPZE9x
         +OjmPHK6tFCSaQDSdKWi9ra3OME0nkR606aYBE38ynPsAMcPP5Us33Y/6bXhHUNoCx
         dJQaAGlWTXSkkpTiV/FvH2F5xntgZK6WPZF9a5N4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, brouer@redhat.com,
        ilias.apalodimas@linaro.org
Subject: [PATCH v3 net-next 0/5] xdp: introduce bulking for page_pool tx return path
Date:   Wed,  4 Nov 2020 11:22:53 +0100
Message-Id: <cover.1604484917.git.lorenzo@kernel.org>
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

Changes since v2:
- move mvneta changes in a dedicated patch

Changes since v1:
- improve comments
- rework xdp_return_frame_bulk routine logic
- move count and xa fields at the beginning of xdp_frame_bulk struct
- invert logic in page_pool_put_page_bulk for loop

Lorenzo Bianconi (5):
  net: xdp: introduce bulking for xdp tx return path
  net: page_pool: add bulk support for ptr_ring
  net: mvneta: add xdp tx return bulking support
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

