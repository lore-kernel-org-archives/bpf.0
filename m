Return-Path: <SRS0=WdG8=ZL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0C3C432C3
	for <bpf@archiver.kernel.org>; Tue, 19 Nov 2019 14:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2968F222A9
	for <bpf@archiver.kernel.org>; Tue, 19 Nov 2019 14:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKSOVs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:21:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbfKSOVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 09:21:48 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B77656ADDA5E797D26F;
        Tue, 19 Nov 2019 22:21:42 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 22:21:34 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>, <andriin@fb.com>
CC:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH bpf-next] bpf: Make array_map_mmap static
Date:   Tue, 19 Nov 2019 22:21:13 +0800
Message-ID: <20191119142113.15388-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix sparse warning:

kernel/bpf/arraymap.c:481:5: warning:
 symbol 'array_map_mmap' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/bpf/arraymap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index a42097c..633c8c7 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -478,7 +478,7 @@ static int array_map_check_btf(const struct bpf_map *map,
 	return 0;
 }
 
-int array_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
+static int array_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	pgoff_t pgoff = PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
-- 
2.7.4


