Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9A1C10F03
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 22:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7336020848
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 22:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSQNNvum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfCAWdR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:33:17 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:45141 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfCAWdQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 17:33:16 -0500
Received: by mail-vk1-f201.google.com with SMTP id z135so12793916vkd.12
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 14:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GphJeGcrVUdSJiuk8a21bkooJ9Vfv3oqGouCtm4Iwuc=;
        b=lSQNNvumZP+qG8q3A1NSqu4JwKpuXLySpTsk0bNQcYa3L1MF/OaKnpEX+NVNmPRUrL
         IlZmYAVrSbAryx2DkUDYV+E1Wj7TRX1NeKDvpbTEOCTEfKfU/hzFPjFNRxf4AFcbcPue
         ZeajmL/X5zWyjC2NQYqVfnuBxYfGnBAX6PcAisp9fJT/vVW8w5Ya2LiNvfVnfiZ0b0kC
         d+lYVs9szrqh72hIrBdvZnwwP5viCc0u1JZNzf/f+VtSjB6tQ9BJ/5DaUhby6lpzwMvO
         5SRIMdAZvn8trVKRv31XU6cOEXHyRccPXXCO32RbqffYiys1i5w1J6eRZ8j2jo/Z7dhZ
         6aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GphJeGcrVUdSJiuk8a21bkooJ9Vfv3oqGouCtm4Iwuc=;
        b=OV41tp0lXBpWyxsbOMenBZdpjwvk1/x1XHt7gRcIHuEQlRjYLr72XWuMbwdhh0+ceV
         HUCKstInQG9mSW6dvYTndesF1ertALuDLIvzhIjUp/PB3nD5mqZqC5f4E1cVmsQi0I+J
         T1jZe0pCLjPia7RuVsPN8WfwwTgdFPBrlFhSJBReDsWbaCe6EEuf1VCRjaI42WPpxZMg
         LxBC139ppMk5WGCj7GgnXCi2mgirb/CAfumbFGi2tm8Ezhir/jsapGXYMYgNA5SIEeqJ
         p/DQAb7AxelE1NchJWRZbq5ckIAQx3GEPdggGrMerAZ8rdGkM+thCsRIjMFBmwuaLpF1
         kV2g==
X-Gm-Message-State: APjAAAUzFAxjwy5FeZo6MGLp2GAivsL/9DbHsikgcGXb1KBi2FPG6ao3
        iPtJbOVNOi0y9ndAmzouAZDDffV43CnvFA==
X-Google-Smtp-Source: APXvYqwmyJN3vNz3RZ2Hm/9SUldG0vP0lgfXc4Cyvbo4e6a7h6/2FMA2j35+baZ40YXQ1Dec38InhjdRLxC8SA==
X-Received: by 2002:a9f:310a:: with SMTP id m10mr4635365uab.17.1551479595938;
 Fri, 01 Mar 2019 14:33:15 -0800 (PST)
Date:   Fri,  1 Mar 2019 14:33:11 -0800
Message-Id: <20190301223311.155501-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH net] bpf: fix u64_stats_init() usage in bpf_prog_alloc()
From:   Eric Dumazet <edumazet@google.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We need to iterate through all possible cpus.

Fixes: 492ecee892c2 ("bpf: enable program stats")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/bpf/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1c14c347f3cfe1f7c0cf8a7eccff8135b16df81f..3f08c257858e1570339cd64a6351824bcc332ee3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -109,6 +109,7 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 {
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
 	struct bpf_prog *prog;
+	int cpu;
 
 	prog = bpf_prog_alloc_no_stats(size, gfp_extra_flags);
 	if (!prog)
@@ -121,7 +122,12 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 		return NULL;
 	}
 
-	u64_stats_init(&prog->aux->stats->syncp);
+	for_each_possible_cpu(cpu) {
+		struct bpf_prog_stats *pstats;
+
+		pstats = per_cpu_ptr(prog->aux->stats, cpu);
+		u64_stats_init(&pstats->syncp);
+	}
 	return prog;
 }
 EXPORT_SYMBOL_GPL(bpf_prog_alloc);
-- 
2.21.0.352.gf09ad66450-goog

