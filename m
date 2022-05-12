Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012BBC433EF
	for <bpf@archiver.kernel.org>; Thu, 12 May 2022 07:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350686AbiELHCi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 May 2022 03:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiELHCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 03:02:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57B53F8A0;
        Thu, 12 May 2022 00:02:22 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KzN4H43Q3zgYt0;
        Thu, 12 May 2022 15:01:51 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 15:02:20 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 15:02:20 +0800
From:   Guangbin Huang <huangguangbin2@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lipeng321@huawei.com>, <huangguangbin2@huawei.com>,
        <chenhao288@hisilicon.com>
Subject: [PATCH net-next] net: page_pool: add page allocation stats for two fast page allocate path
Date:   Thu, 12 May 2022 14:56:31 +0800
Message-ID: <20220512065631.33673-1-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jie Wang <wangjie125@huawei.com>

Currently If use page pool allocation stats to analysis a RX performance
degradation problem. These stats only count for pages allocate from
page_pool_alloc_pages. But nic drivers such as hns3 use
page_pool_dev_alloc_frag to allocate pages, so page stats in this API
should also be counted.

Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 net/core/page_pool.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index bdbadfaee867..f18e6e771993 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -704,8 +704,10 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 
 	if (page && *offset + size > max_size) {
 		page = page_pool_drain_frag(pool, page);
-		if (page)
+		if (page) {
+			alloc_stat_inc(pool, fast);
 			goto frag_reset;
+		}
 	}
 
 	if (!page) {
@@ -727,6 +729,7 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 
 	pool->frag_users++;
 	pool->frag_offset = *offset + size;
+	alloc_stat_inc(pool, fast);
 	return page;
 }
 EXPORT_SYMBOL(page_pool_alloc_frag);
-- 
2.33.0

