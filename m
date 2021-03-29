Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E696AC433E3
	for <bpf@archiver.kernel.org>; Mon, 29 Mar 2021 22:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B4161919
	for <bpf@archiver.kernel.org>; Mon, 29 Mar 2021 22:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhC2WzR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:55:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:2470 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhC2WzH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 18:55:07 -0400
IronPort-SDR: NTO1oW0iKzDW4tZX//itcPfM62i3IgreXo6ifMz4r9rEt2+d1hDRoDtBlpwdTo97R8062tB4oW
 OEG3FO4ALs2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="189392986"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="189392986"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 15:55:07 -0700
IronPort-SDR: jr5yBqcoe/LCyJcigL7Jy056Wa+8lUFUe4PdB8oBSI/ssnQxndD5qx4RnAxY2SqOvrzthahsu9
 bpBx+68GDSyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="417884119"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2021 15:55:04 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        ast@kernel.org, andrii@kernel.org
Cc:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        ciara.loftus@intel.com, john.fastabend@gmail.com, toke@redhat.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v5 bpf-next 03/17] selftests: xsk: remove unused function
Date:   Tue, 30 Mar 2021 00:43:02 +0200
Message-Id: <20210329224316.17793-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210329224316.17793-1-maciej.fijalkowski@intel.com>
References: <20210329224316.17793-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Probably it was ported from xdpsock but is not used anywhere.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/xdpxceiver.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index 04bc007d5b08..6769e9e2de17 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -153,19 +153,6 @@ static void *memset32_htonl(void *dest, u32 val, u32 size)
 	return dest;
 }
 
-/*
- * This function code has been taken from
- * Linux kernel lib/checksum.c
- */
-static inline unsigned short from32to16(unsigned int x)
-{
-	/* add up 16-bit and 16-bit for 16+c bit */
-	x = (x & 0xffff) + (x >> 16);
-	/* add up carry.. */
-	x = (x & 0xffff) + (x >> 16);
-	return x;
-}
-
 /*
  * Fold a partial checksum
  * This function code has been taken from
-- 
2.20.1

