Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00107C43460
	for <bpf@archiver.kernel.org>; Wed, 14 Apr 2021 05:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C0E613A9
	for <bpf@archiver.kernel.org>; Wed, 14 Apr 2021 05:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245694AbhDNFpm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Apr 2021 01:45:42 -0400
Received: from mx313.baidu.com ([180.101.52.140]:59785 "EHLO
        njjs-sys-mailin06.njjs.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345352AbhDNFpk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 01:45:40 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2021 01:45:39 EDT
Received: from unknown.domain.tld (unknown [10.168.57.222])
        by njjs-sys-mailin06.njjs.baidu.com (Postfix) with ESMTP id D88E6185C0031;
        Wed, 14 Apr 2021 13:39:12 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     bpf@vger.kernel.org, magnus.karlsson@intel.com
Subject: [PATCH] xsk: align xdp socket batch size with dpdk
Date:   Wed, 14 Apr 2021 13:39:12 +0800
Message-Id: <1618378752-4191-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DPDK default burst size is 32, however, kernel xsk sendto
syscall can not handle all 32 at one time, and return with
error.

So make kernel xdp socket batch size larger to avoid
unnecessary syscall fail and context switch which will help
increase performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/xdp/xsk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index a71ed66..cd62d4b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -30,7 +30,7 @@
 #include "xdp_umem.h"
 #include "xsk.h"
 
-#define TX_BATCH_SIZE 16
+#define TX_BATCH_SIZE 32
 
 static DEFINE_PER_CPU(struct list_head, xskmap_flush_list);
 
-- 
1.7.1

