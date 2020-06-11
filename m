Return-Path: <SRS0=s2Gn=7Y=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB56C433DF
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 05:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DDE2072F
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 05:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgFKFLY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:11:24 -0400
Received: from mx140-tc.baidu.com ([61.135.168.140]:46171 "EHLO
        tc-sys-mailedm01.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725300AbgFKFLX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Jun 2020 01:11:23 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm01.tc.baidu.com (Postfix) with ESMTP id 971A4204006E;
        Thu, 11 Jun 2020 13:11:06 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] xdp: fix xsk_generic_xmit errno
Date:   Thu, 11 Jun 2020 13:11:06 +0800
Message-Id: <1591852266-24017-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

propagate sock_alloc_send_skb error code, not set it
to EAGAIN unconditionally, when fail to allocate skb,
which maybe causes that user space unnecessary loops

Fixes: 35fcde7f8deb "(xsk: support for Tx)"
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/xdp/xsk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b6c0f08bd80d..1ba3ea262c15 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -353,7 +353,6 @@ static int xsk_generic_xmit(struct sock *sk)
 		len = desc.len;
 		skb = sock_alloc_send_skb(sk, len, 1, &err);
 		if (unlikely(!skb)) {
-			err = -EAGAIN;
 			goto out;
 		}
 
-- 
2.16.2

