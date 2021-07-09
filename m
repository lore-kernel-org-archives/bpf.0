Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AC2C07E99
	for <bpf@archiver.kernel.org>; Fri,  9 Jul 2021 02:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303D761461
	for <bpf@archiver.kernel.org>; Fri,  9 Jul 2021 02:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhGICvI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 8 Jul 2021 22:51:08 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:49529 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231156AbhGICvI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Jul 2021 22:51:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UfA5fvT_1625798894;
Received: from localhost(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0UfA5fvT_1625798894)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Jul 2021 10:48:23 +0800
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: [PATCH bpf-next v3 2/2] libbpf: Fix the possible memory leak caused by obj->kconfig
Date:   Fri,  9 Jul 2021 10:47:53 +0800
Message-Id: <1625798873-55442-3-git-send-email-chengshuyi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625798873-55442-1-git-send-email-chengshuyi@linux.alibaba.com>
References: <1625798873-55442-1-git-send-email-chengshuyi@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When obj->kconfig is NULL, ERR_PTR(-ENOMEM) should not be returned
directly, err=-ENOMEM should be set, and then goto out.

Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
---
 tools/lib/bpf/libbpf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6702b7f..5e550e7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7626,8 +7626,10 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 	kconfig = OPTS_GET(opts, kconfig, NULL);
 	if (kconfig) {
 		obj->kconfig = strdup(kconfig);
-		if (!obj->kconfig)
-			return ERR_PTR(-ENOMEM);
+		if (!obj->kconfig) {
+			err = -ENOMEM;
+			goto out;
+		}
 	}
 
 	err = bpf_object__elf_init(obj);
-- 
1.8.3.1

