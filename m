Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C32C11F66
	for <bpf@archiver.kernel.org>; Tue, 13 Jul 2021 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506F86128B
	for <bpf@archiver.kernel.org>; Tue, 13 Jul 2021 12:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhGMMqg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:46:36 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41288 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236167AbhGMMqg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Jul 2021 08:46:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UfgxQcF_1626180215;
Received: from localhost(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0UfgxQcF_1626180215)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 13 Jul 2021 20:43:43 +0800
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shuyi Cheng <chengshuyi@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH bpf-next v4 2/3] libbpf: Fix the possible memory leak on error
Date:   Tue, 13 Jul 2021 20:42:38 +0800
Message-Id: <1626180159-112996-3-git-send-email-chengshuyi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626180159-112996-1-git-send-email-chengshuyi@linux.alibaba.com>
References: <1626180159-112996-1-git-send-email-chengshuyi@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If the strdup() fails then we need to call bpf_object__close(obj) to
avoid a resource leak.

Fixes: 166750b ("libbpf: Support libbpf-provided extern variables")

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
---
 tools/lib/bpf/libbpf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6e11a7b..9d80794 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7611,8 +7611,10 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
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

