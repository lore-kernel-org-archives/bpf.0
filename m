Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02A7C433DB
	for <bpf@archiver.kernel.org>; Wed,  3 Feb 2021 03:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B32764E0F
	for <bpf@archiver.kernel.org>; Wed,  3 Feb 2021 03:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhBCDUr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:20:47 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53632 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232409AbhBCDRl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Feb 2021 22:17:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UNjponw_1612322253;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNjponw_1612322253)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 11:17:34 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] samples: bpf: remove unneeded semicolon
Date:   Wed,  3 Feb 2021 11:17:28 +0800
Message-Id: <1612322248-35398-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Eliminate the following coccicheck warning:
./samples/bpf/cookie_uid_helper_example.c:316:3-4: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 samples/bpf/cookie_uid_helper_example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/cookie_uid_helper_example.c b/samples/bpf/cookie_uid_helper_example.c
index deb0e3e..f364eaa 100644
--- a/samples/bpf/cookie_uid_helper_example.c
+++ b/samples/bpf/cookie_uid_helper_example.c
@@ -313,7 +313,7 @@ int main(int argc, char *argv[])
 			print_table();
 			printf("\n");
 			sleep(1);
-		};
+		}
 	} else if (cfg_test_cookie) {
 		udp_client();
 	}
-- 
1.8.3.1

