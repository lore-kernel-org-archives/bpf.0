Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A58BC433E0
	for <bpf@archiver.kernel.org>; Fri, 26 Mar 2021 12:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643056197C
	for <bpf@archiver.kernel.org>; Fri, 26 Mar 2021 12:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCZMlF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Mar 2021 08:41:05 -0400
Received: from foss.arm.com ([217.140.110.172]:58694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhCZMks (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 08:40:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19461143D;
        Fri, 26 Mar 2021 05:40:48 -0700 (PDT)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 95E803F7D7;
        Fri, 26 Mar 2021 05:40:41 -0700 (PDT)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, viro@zeniv.linux.org.uk, rdna@fb.com,
        dvyukov@google.com, nicolas.dichtel@6wind.com,
        keescook@chromium.org, masahiroy@kernel.org, maheshb@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jianlin.Lv@arm.com, iecedge@gmail.com, nd@arm.com
Subject: [PATCH bpf-next] bpf: trace jit code when enable BPF_JIT_ALWAYS_ON
Date:   Fri, 26 Mar 2021 20:40:30 +0800
Message-Id: <20210326124030.1138964-1-Jianlin.Lv@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When CONFIG_BPF_JIT_ALWAYS_ON is enabled, the value of bpf_jit_enable in
/proc/sys is limited to SYSCTL_ONE. This is not convenient for debugging.
This patch modifies the value of extra2 (max) to 2 that support developers
to emit traces on kernel log.

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
 net/core/sysctl_net_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index d84c8a1b280e..aa16883ac445 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -386,7 +386,7 @@ static struct ctl_table net_core_table[] = {
 		.proc_handler	= proc_dointvec_minmax_bpf_enable,
 # ifdef CONFIG_BPF_JIT_ALWAYS_ON
 		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= &two,
 # else
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
-- 
2.25.1

