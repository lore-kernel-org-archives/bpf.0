Return-Path: <SRS0=QUaE=3Z=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A471AC35254
	for <bpf@archiver.kernel.org>; Wed,  5 Feb 2020 12:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE71217BA
	for <bpf@archiver.kernel.org>; Wed,  5 Feb 2020 12:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBEMGa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:06:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:56044 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgBEMG3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Feb 2020 07:06:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 04:06:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="254742609"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga004.fm.intel.com with ESMTP; 05 Feb 2020 04:06:28 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com, maximmi@mellanox.com
Subject: [PATCH bpf 2/3] samples: bpf: drop doubled variable declaration in xdpsock
Date:   Wed,  5 Feb 2020 05:58:33 +0100
Message-Id: <20200205045834.56795-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205045834.56795-1-maciej.fijalkowski@intel.com>
References: <20200205045834.56795-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Seems that by accident there is a doubled declaration of global variable
opt_xdp_bind_flags in xdpsock_user.c. The second one is uninitialized so
compiler was simply ignoring it.

To keep things clean, drop the doubled variable.

Fixes: c543f5469822 ("samples/bpf: add unaligned chunks mode support to xdpsock")
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 samples/bpf/xdpsock_user.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 0b5acd722..bab7a850e 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -83,7 +83,6 @@ static u32 opt_xdp_bind_flags = XDP_USE_NEED_WAKEUP;
 static u32 opt_umem_flags;
 static int opt_unaligned_chunks;
 static int opt_mmap_flags;
-static u32 opt_xdp_bind_flags;
 static int opt_xsk_frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 static int opt_timeout = 1000;
 static bool opt_need_wakeup = true;
-- 
2.20.1

