Return-Path: <SRS0=5TR3=DF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD3C2D0A8
	for <bpf@archiver.kernel.org>; Mon, 28 Sep 2020 08:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9297207E8
	for <bpf@archiver.kernel.org>; Mon, 28 Sep 2020 08:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgI1ItT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Sep 2020 04:49:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:28714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1ItT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 04:49:19 -0400
IronPort-SDR: g9Fe5TOEEK1kfomXuoZEhWy0LaHeqIvN6xz9R6TSYNZJBMYwmjUNnykOhAb/XogBcg+ICR2VRx
 P7NelkPhGkeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="246701799"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="246701799"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 01:49:18 -0700
IronPort-SDR: 136wNds2FhQL8pe7eFDP1W6hbW6pV7CrSzYmyU1+cacj7v/Hvezv+f13zptZ3g7YRXl2wnD+QN
 J+gkkPk8DtcQ==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="456743211"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.222.142])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 01:49:17 -0700
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf] xsk: fix a documentation mistake in xsk_queue.h
Date:   Mon, 28 Sep 2020 08:23:44 +0000
Message-Id: <20200928082344.17110-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After 'peeking' the ring, the consumer, not the producer, reads the data.
Fix this mistake in the comments.

Fixes: 15d8c9162ced ("xsk: Add function naming comments and reorder functions")
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 net/xdp/xsk_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index bf42cfd74b89..a0bb2f722b3f 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -96,7 +96,7 @@ struct xsk_queue {
  * seen and read by the consumer.
  *
  * The consumer peeks into the ring to see if the producer has written
- * any new entries. If so, the producer can then read these entries
+ * any new entries. If so, the consumer can then read these entries
  * and when it is done reading them release them back to the producer
  * so that the producer can use these slots to fill in new entries.
  *
-- 
2.17.1

