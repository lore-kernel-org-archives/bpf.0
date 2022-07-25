Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6F7C43334
	for <bpf@archiver.kernel.org>; Mon, 25 Jul 2022 22:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiGYW1m (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGYW1m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 18:27:42 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC748252AA;
        Mon, 25 Jul 2022 15:27:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VKRVmKQ_1658788056;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VKRVmKQ_1658788056)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 06:27:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] bpf: remove unneeded semicolon
Date:   Tue, 26 Jul 2022 06:27:33 +0800
Message-Id: <20220725222733.55613-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Eliminate the following coccicheck warning:
/kernel/bpf/trampoline.c:101:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/bpf/trampoline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 42e387a12694..f20b92ad0c50 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -98,7 +98,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, enum ftrace_ops_cmd
 	default:
 		ret = -EINVAL;
 		break;
-	};
+	}
 
 	mutex_unlock(&tr->mutex);
 	return ret;
-- 
2.20.1.7.g153144c

