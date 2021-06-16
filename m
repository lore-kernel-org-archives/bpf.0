Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBF1C48BE8
	for <bpf@archiver.kernel.org>; Wed, 16 Jun 2021 02:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C6F613CD
	for <bpf@archiver.kernel.org>; Wed, 16 Jun 2021 02:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhFPCHC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Jun 2021 22:07:02 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44375 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230454AbhFPCHB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Jun 2021 22:07:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UcZE8xD_1623809077;
Received: from localhost(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0UcZE8xD_1623809077)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jun 2021 10:04:54 +0800
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: [PATCH bpf-next] bpf: Fix typo in kernel/bpf/bpf_lsm.c
Date:   Wed, 16 Jun 2021 10:04:36 +0800
Message-Id: <1623809076-97907-1-git-send-email-chengshuyi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
---
 kernel/bpf/bpf_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 5efb2b2..99ada85 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -125,7 +125,7 @@ static bool bpf_ima_inode_hash_allowed(const struct bpf_prog *prog)
 }
 
 /* The set of hooks which are called without pagefaults disabled and are allowed
- * to "sleep" and thus can be used for sleeable BPF programs.
+ * to "sleep" and thus can be used for sleepable BPF programs.
  */
 BTF_SET_START(sleepable_lsm_hooks)
 BTF_ID(func, bpf_lsm_bpf)
-- 
1.8.3.1

