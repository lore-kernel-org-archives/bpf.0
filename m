Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165F5C433DB
	for <bpf@archiver.kernel.org>; Thu, 25 Mar 2021 02:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17D461974
	for <bpf@archiver.kernel.org>; Thu, 25 Mar 2021 02:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhCYCEm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Mar 2021 22:04:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13683 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhCYCEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Mar 2021 22:04:39 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5Sz13xqYznTTn;
        Thu, 25 Mar 2021 10:02:05 +0800 (CST)
Received: from t01.huawei.com (10.67.174.119) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 10:04:34 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>
CC:     <jackmanb@google.com>
Subject: [PATCH bpf-next] bpf: Fix a spelling typo in kernel/bpf/disasm.c
Date:   Thu, 25 Mar 2021 02:05:11 +0000
Message-ID: <20210325020511.5891-1-xukuohai@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.119]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The name string for BPF_XOR is "xor", not "or", fix it.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 3acc7e0b6916..faa54d58972c 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -84,7 +84,7 @@ static const char *const bpf_atomic_alu_string[16] = {
 	[BPF_ADD >> 4]  = "add",
 	[BPF_AND >> 4]  = "and",
 	[BPF_OR >> 4]  = "or",
-	[BPF_XOR >> 4]  = "or",
+	[BPF_XOR >> 4]  = "xor",
 };
 
 static const char *const bpf_ldst_string[] = {
-- 
2.27.0

