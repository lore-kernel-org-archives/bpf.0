Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6C0C4338F
	for <bpf@archiver.kernel.org>; Fri,  6 Aug 2021 10:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA0560E97
	for <bpf@archiver.kernel.org>; Fri,  6 Aug 2021 10:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244802AbhHFKJT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Aug 2021 06:09:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:29475 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244910AbhHFKJQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Aug 2021 06:09:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="214074255"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="214074255"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 03:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="513338510"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2021 03:08:58 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        anthony.l.nguyen@intel.com, kuba@kernel.org, bjorn@kernel.org,
        magnus.karlsson@intel.com, jesse.brandeburg@intel.com,
        alexandr.lobakin@intel.com, joamaki@gmail.com, toke@redhat.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 intel-next 0/6] XDP_TX improvements for ice
Date:   Fri,  6 Aug 2021 11:55:33 +0200
Message-Id: <20210806095539.34423-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

it's been a while. Here's another revision of XDP_TX improvements for
ice. This time I decided to split the generic ring struct that was
serving both Tx and Rx sides onto separate entities. It is due to the
fact that this set introduces few Tx specific fields onto ring.

Also, when compared to v2, Xdp ring is propagated onto Rx ring.
Accessing vsi->xdp_rings array, especially in fallback path, is not
convenient.

This v4 fixes the compile issue reported by lkp.

Finally patch 5 introduces yet another cleaning logic, different from
v2. For more info please see commit messages.

Thanks!
Maciej

v3 : https://lore.kernel.org/bpf/20210805230046.28715-1-maciej.fijalkowski@intel.com/
v2 : https://lore.kernel.org/bpf/20210705164338.58313-1-maciej.fijalkowski@intel.com/
v1 : https://lore.kernel.org/bpf/20210601113236.42651-1-maciej.fijalkowski@intel.com/


Maciej Fijalkowski (6):
  ice: split ice_ring onto Tx/Rx separate structs
  ice: unify xdp_rings accesses
  ice: do not create xdp_frame on XDP_TX
  ice: propagate xdp_ring onto rx_ring
  ice: optimize XDP_TX workloads
  ice: introduce XDP_TX fallback path

 drivers/net/ethernet/intel/ice/ice.h          |  30 +++-
 drivers/net/ethernet/intel/ice/ice_base.c     |  27 ++--
 drivers/net/ethernet/intel/ice/ice_base.h     |   6 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   5 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  17 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  32 ++--
 drivers/net/ethernet/intel/ice/ice_lib.h      |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 101 +++++++++----
 drivers/net/ethernet/intel/ice/ice_trace.h    |   8 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 139 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  94 +++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  86 +++++++++--
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   8 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  52 ++++---
 drivers/net/ethernet/intel/ice/ice_xsk.h      |   8 +-
 17 files changed, 410 insertions(+), 219 deletions(-)

-- 
2.20.1

