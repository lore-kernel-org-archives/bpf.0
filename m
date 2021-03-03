Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D97AC433E9
	for <bpf@archiver.kernel.org>; Wed,  3 Mar 2021 22:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F93464F0B
	for <bpf@archiver.kernel.org>; Wed,  3 Mar 2021 22:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449535AbhCCWwB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:52:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:41913 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1384426AbhCCQIB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 11:08:01 -0500
IronPort-SDR: dmCBhNOpLnYFj4huJwDYDBXOzXxm5k79lvLLV2WR2vIyqjaIepJDHxx3JidxOAYIjVBXxVR138
 nCIcINm0iHiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="186571055"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="186571055"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:01:57 -0800
IronPort-SDR: QJ+2Vak3ixVm919wKu4HuWEhsXh7ahLoEGrVV/1Yf75Dk9UA4Su0Ci7ZQvdi3/tonEjY295JoT
 dHny2koXIzVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="445323977"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 08:01:55 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Cc:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        john.fastabend@gmail.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf 3/3] libbpf: clear map_info before each bpf_obj_get_info_by_fd
Date:   Wed,  3 Mar 2021 16:51:57 +0100
Message-Id: <20210303155158.15953-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210303155158.15953-1-maciej.fijalkowski@intel.com>
References: <20210303155158.15953-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

xsk_lookup_bpf_maps, based on prog_fd, looks whether current prog has a
reference to XSKMAP. BPF prog can include insns that work on various BPF
maps and this is covered by iterating through map_ids.

The bpf_map_info that is passed to bpf_obj_get_info_by_fd for filling
needs to be cleared at each iteration, so that it doesn't contain any
outdated fields and that is currently missing in the function of
interest.

To fix that, zero-init map_info via memset before each
bpf_obj_get_info_by_fd call.

Also, since the area of this code is touched, in general strcmp is
considered harmful, so let's convert it to strncmp and provide the
length of the array name from current map_info.

Last but not least, do s/continue/break/ once we have found the xsks_map
to terminate the search.

Fixes: 5750902a6e9b ("libbpf: proper XSKMAP cleanup")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/lib/bpf/xsk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index ffbb588724d8..e56b2d76efc2 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -610,15 +610,16 @@ static int xsk_lookup_bpf_maps(struct xsk_socket *xsk)
 		if (fd < 0)
 			continue;
 
+		memset(&map_info, 0, map_len);
 		err = bpf_obj_get_info_by_fd(fd, &map_info, &map_len);
 		if (err) {
 			close(fd);
 			continue;
 		}
 
-		if (!strcmp(map_info.name, "xsks_map")) {
+		if (!strncmp(map_info.name, "xsks_map", strlen(map_info.name))) {
 			ctx->xsks_map_fd = fd;
-			continue;
+			break;
 		}
 
 		close(fd);
-- 
2.20.1

