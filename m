Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E25AC433ED
	for <bpf@archiver.kernel.org>; Mon, 17 May 2021 10:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B19611ED
	for <bpf@archiver.kernel.org>; Mon, 17 May 2021 10:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhEQKRZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 May 2021 06:17:25 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:42459 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236352AbhEQKRA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 May 2021 06:17:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UZ9B-kz_1621246526;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UZ9B-kz_1621246526)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 May 2021 18:15:32 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] net/packet: Remove redundant assignment to ret
Date:   Mon, 17 May 2021 18:15:25 +0800
Message-Id: <1621246525-65683-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Variable ret is set to '0' or '-EBUSY', but this value is never read
as it is not used later on, hence it is a redundant assignment and
can be removed.

Clean up the following clang-analyzer warning:

net/packet/af_packet.c:3936:4: warning: Value stored to 'ret' is never
read [clang-analyzer-deadcode.DeadStores].

net/packet/af_packet.c:3933:4: warning: Value stored to 'ret' is never
read [clang-analyzer-deadcode.DeadStores].

No functional change.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 net/packet/af_packet.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ae906eb..71dd6b9 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3929,12 +3929,9 @@ static void packet_flush_mclist(struct sock *sk)
 			return -EFAULT;
 
 		lock_sock(sk);
-		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
-			ret = -EBUSY;
-		} else {
+		if (!po->rx_ring.pg_vec && !po->tx_ring.pg_vec)
 			po->tp_tx_has_off = !!val;
-			ret = 0;
-		}
+
 		release_sock(sk);
 		return 0;
 	}
-- 
1.8.3.1

