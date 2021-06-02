Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82CBC47080
	for <bpf@archiver.kernel.org>; Wed,  2 Jun 2021 02:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A161613D0
	for <bpf@archiver.kernel.org>; Wed,  2 Jun 2021 02:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFBDBd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 1 Jun 2021 23:01:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2835 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhFBDBc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 23:01:32 -0400
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvttL2TSNzWlbT;
        Wed,  2 Jun 2021 10:55:06 +0800 (CST)
Received: from huawei.com (10.175.113.133) by dggeme766-chm.china.huawei.com
 (10.3.19.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 2 Jun
 2021 10:59:48 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
        <jonathan.lemon@gmail.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>
CC:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] xsk: Return -EINVAL instead of -EBUSY after xsk_get_pool_from_qid() fails
Date:   Wed, 2 Jun 2021 11:10:01 +0800
Message-ID: <20210602031001.18656-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme766-chm.china.huawei.com (10.3.19.112)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

xsk_get_pool_from_qid() fails not because the device's queues are busy,
but because the queue_id exceeds the current number of queues.
So when it fails, it is better to return -EINVAL instead of -EBUSY.

Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/xdp/xsk_buff_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 8de01aaac4a0..30ece117117a 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -135,7 +135,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		return -EINVAL;
 
 	if (xsk_get_pool_from_qid(netdev, queue_id))
-		return -EBUSY;
+		return -EINVAL;
 
 	pool->netdev = netdev;
 	pool->queue_id = queue_id;
-- 
2.17.1

