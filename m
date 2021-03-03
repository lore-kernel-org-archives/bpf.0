Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2096CC15501
	for <bpf@archiver.kernel.org>; Wed,  3 Mar 2021 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E970564EFE
	for <bpf@archiver.kernel.org>; Wed,  3 Mar 2021 22:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449659AbhCCWxT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:53:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:62497 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350766AbhCCTHS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 14:07:18 -0500
IronPort-SDR: PJwbUyMZyuI3FEEuFGD1ha8TvluQb4yywNoRHWXagE49DAw5RafxmIcpuvYqXx+sxkCOSp8dsP
 EJ2gPOISxDOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="251309581"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="251309581"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:06:37 -0800
IronPort-SDR: XxzFY7CG/O8CQSqa7ZiObXvlFq6y+58KLiVRG+cYcSBy6GFMhVjvl3w0Su9PiuivSJhesiBmfA
 1hTy/P9AejGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="506992632"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2021 11:06:36 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Cc:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        john.fastabend@gmail.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf v2 0/3] AF_XDP small fixes
Date:   Wed,  3 Mar 2021 19:56:33 +0100
Message-Id: <20210303185636.18070-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This time three no-brainers, one is a fix that I sent among with
bpf_link for AF_XDP set where John suggested that it should land in bpf
tree.

Other is the missing munmap on xdpsock and some ancient function
declaration removal.

Thanks!
Maciej

v2:
- collect Bjorn's Acks
- change strlen to sizeof in patch 3

Maciej Fijalkowski (3):
  xsk: remove dangling function declaration from header file
  samples: bpf: add missing munmap in xdpsock
  libbpf: clear map_info before each bpf_obj_get_info_by_fd

 include/linux/netdevice.h  | 2 --
 samples/bpf/xdpsock_user.c | 2 ++
 tools/lib/bpf/xsk.c        | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.20.1

