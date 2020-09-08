Return-Path: <SRS0=2QCY=CR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454A9C2BC11
	for <bpf@archiver.kernel.org>; Tue,  8 Sep 2020 20:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16282204FD
	for <bpf@archiver.kernel.org>; Tue,  8 Sep 2020 20:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgIHUG6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:06:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10846 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730180AbgIHPTy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Sep 2020 11:19:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B2B2EC4769032B1941B4;
        Tue,  8 Sep 2020 21:21:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Sep 2020 21:21:01 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>
CC:     <chenzhou10@huawei.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: [PATCH -next] bpf: Remove duplicate headers
Date:   Tue, 8 Sep 2020 21:22:01 +0800
Message-ID: <20200908132201.184005-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove duplicate headers which are included twice.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 net/core/bpf_sk_storage.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index a0d1a3265b71..4a86ea34f29e 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -12,7 +12,6 @@
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
-#include <linux/btf_ids.h>
 
 DEFINE_BPF_STORAGE_CACHE(sk_cache);
 
-- 
2.17.1

