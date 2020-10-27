Return-Path: <SRS0=pSPe=EC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCD4C388F9
	for <bpf@archiver.kernel.org>; Tue, 27 Oct 2020 19:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6412F2223C
	for <bpf@archiver.kernel.org>; Tue, 27 Oct 2020 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603825459;
	bh=4YHS7RKLjKKZj9G4Gq4OrnoIaC2pHgPE5X/FD5oclsU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Tni8RBPYMEiO6XyhlRTYfaKsT7XGMjjLqEfunCUHApUGCO812V6foyAvqhMZ1TfIq
	 JcHZ5FhFM6kWVak6ZfzrViSiOjPNheNshtjc/HJSjF9As1qmLTphNAeekORdMh0nhJ
	 8uyMVj5aQiMkfFXRyWtEwruehZj1o1ik4H3aAxHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829294AbgJ0TET (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Oct 2020 15:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1829286AbgJ0TES (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 15:04:18 -0400
Received: from lore-desk.redhat.com (unknown [151.66.125.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9745A206D4;
        Tue, 27 Oct 2020 19:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603825458;
        bh=4YHS7RKLjKKZj9G4Gq4OrnoIaC2pHgPE5X/FD5oclsU=;
        h=From:To:Cc:Subject:Date:From;
        b=KApTiYSxPNpZt+KlNqyFajHh6ORcIEPen6L6uBazik39JsRzpidM//OY32KS4gYst
         Cpa7EcXIPP+sEp7Y+N4vcgnbhl+yfy7Cyxz6eV3GA/SFNSfmYmr/LVtzhWU8eJudZs
         v02JGRefCifLF53gyGAU+61GchQS28zuhx1UQffs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, brouer@redhat.com,
        ilias.apalodimas@linaro.org
Subject: [PATCH net-next 0/4] xdp: introduce bulking for page_pool tx return path
Date:   Tue, 27 Oct 2020 20:04:06 +0100
Message-Id: <cover.1603824486.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

xdp_return_frame and page_pool_put_page are usually run inside the driver
NAPI tx completion loop so it is possible batch them.
Introduce bulking capability in xdp tx return path (XDP_REDIRECT).
Convert mvneta, mvpp2 and mlx5 drivers to xdp_return_frame_bulk APIs.

Lorenzo Bianconi (4):
  net: xdp: introduce bulking for xdp tx return path
  net: page_pool: add bulk support for ptr_ring
  net: mvpp2: add xdp tx return bulking support
  net: mlx5: add xdp tx return bulking support

 drivers/net/ethernet/marvell/mvneta.c         |  5 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  5 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  5 +-
 include/net/page_pool.h                       | 26 +++++++++++
 include/net/xdp.h                             |  9 ++++
 net/core/page_pool.c                          | 33 +++++++++++++
 net/core/xdp.c                                | 46 +++++++++++++++++++
 7 files changed, 126 insertions(+), 3 deletions(-)

-- 
2.26.2

