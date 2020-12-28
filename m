Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A3C433E0
	for <bpf@archiver.kernel.org>; Mon, 28 Dec 2020 07:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE47207D1
	for <bpf@archiver.kernel.org>; Mon, 28 Dec 2020 07:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgL1HFv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Dec 2020 02:05:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9937 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgL1HFv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Dec 2020 02:05:51 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D47p66lS3zhyMc;
        Mon, 28 Dec 2020 15:04:30 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 15:05:06 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: [PATCH] arm64: traps: remove duplicate include statement
Date:   Mon, 28 Dec 2020 15:05:08 +0800
Message-ID: <1609139108-10819-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

asm/exception.h is included more than once. Remove the one that isn't
necessary.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 arch/arm64/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 08156be..6895ce7 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -42,7 +42,6 @@
 #include <asm/smp.h>
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
-#include <asm/exception.h>
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>
 
-- 
2.7.4

