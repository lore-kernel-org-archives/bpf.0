Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69092ECAAD4
	for <bpf@archiver.kernel.org>; Tue, 30 Aug 2022 12:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiH3MiW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH3MiR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 08:38:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35968F14CC;
        Tue, 30 Aug 2022 05:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661863097; x=1693399097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ar3h548rpaRpqxHgVz0lKjqIVfTKSVBgjMXjddGtLcY=;
  b=NU7q07zQZN2n5s4CQoHdldOniemc3fz+pwdUa9HZkmTrpWtUhHAdkZMp
   R4+Y2kbE9JAi51pC14sqckPf5WkB+fRdAGL9oxL1M4qYm3B3sCtPvc27z
   rppuX3VhNCn58AYlxFNV9MtBY9LHbNnXoM9qdziTSNtoL9cSp5KbieYvP
   Hwv/iOPWW2J6KsIgyX3xU/MiJfyqcu7L/HtuGTCmBFpFT/Vxzhxq3CSk1
   QgWItS/c7tlmhlIGtIEBystKpD0vdIvs+VD/F4e3wuM9aqXGKrbHBJO8w
   h/tMJJRVHxZFgecdL+xLcn44qIhBD6Amp3TsSN1AWXRj0II0B6VpkckKC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="321289544"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="321289544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 05:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="588585167"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2022 05:38:15 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH intel-net 0/2] ice: xsk: ZC changes
Date:   Tue, 30 Aug 2022 14:38:01 +0200
Message-Id: <20220830123803.9361-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

this set consists of two fixes to issues that were either pointed out on
indirectly (John was reviewing AF_XDP selftests that were testing ice's
ZC support) mailing list or were directly reported by customers.

First patch allows user space to see done descriptor in CQ even after a
single frame being transmitted and second patch removes the need for
having HW rings sized to power of 2 number of descriptors when used
against AF_XDP.

Thanks!
Maciej

Maciej Fijalkowski (2):
  ice: xsk: change batched Tx descriptor cleaning
  ice: xsk: drop power of 2 ring size restriction for AF_XDP

 drivers/net/ethernet/intel/ice/ice_txrx.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 165 +++++++++-------------
 drivers/net/ethernet/intel/ice/ice_xsk.h  |   7 +-
 3 files changed, 72 insertions(+), 102 deletions(-)

-- 
2.34.1

