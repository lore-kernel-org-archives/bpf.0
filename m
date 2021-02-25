Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A6BC433DB
	for <bpf@archiver.kernel.org>; Thu, 25 Feb 2021 07:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BAB64E6C
	for <bpf@archiver.kernel.org>; Thu, 25 Feb 2021 07:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBYHLh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:11:37 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55724 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233159AbhBYHJd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 02:09:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UPWUmt0_1614236919;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UPWUmt0_1614236919)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Feb 2021 15:08:47 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] kallsyms: make arch_get_kallsym static
Date:   Thu, 25 Feb 2021 15:08:37 +0800
Message-Id: <1614236917-80472-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the following sparse warning:

kernel/kallsyms.c:457:12: warning: symbol 'arch_get_kallsym' was not
declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 8043a90..a26f98e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -454,7 +454,7 @@ struct kallsym_iter {
 	int show_value;
 };
 
-int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
+static int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
 			    char *type, char *name)
 {
 	return -EINVAL;
-- 
1.8.3.1

