Return-Path: <SRS0=0VAB=4B=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20635C2BA83
	for <bpf@archiver.kernel.org>; Thu, 13 Feb 2020 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E676320661
	for <bpf@archiver.kernel.org>; Thu, 13 Feb 2020 15:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qUBPc+5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgBMPpJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:45:09 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.43]:29973 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729501AbgBMPpE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Feb 2020 10:45:04 -0500
X-Greylist: delayed 1401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 10:45:03 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id E956B494E
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2020 09:21:41 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 2GJBjQYpnAGTX2GJBjcaCO; Thu, 13 Feb 2020 09:21:41 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tlzInWey23Efbti3IVI7QK7bG7x1edOF4vWB/j8UuCg=; b=qUBPc+5fDEGt6M5dgwJulMJp+G
        xcMtSAYOH/X0jV8IyUUPvs80Ttm+MXBgQ8qc27gOJWz05nEnxh4pFjiFklBTyOZgBCxQ0gkv0qNVU
        oKGPrxltSRC+XnaTwGk/xuX5mhgyFpgQdq+I4gqPpsSIi2DpRDoQCe55ho30GyrzWIqoyuzXhHiwE
        jyiSnpGoggRlGalXfSmMNqIutwrK5Wee4Z77OuIp/CvM13nU/t/nBmkfntKDkFRCSdgrqjor/APB0
        5QE3/CkAoKBfUgQV9K5AT+4GfPe1H4rDZTWmD742+C+7oRRpkbCKEhX4WDPXJMHEDFtddVW2fo3hk
        OXEc0N7Q==;
Received: from [200.68.140.15] (port=29529 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j2GJA-003BYr-8t; Thu, 13 Feb 2020 09:21:40 -0600
Date:   Thu, 13 Feb 2020 09:24:16 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] bpf: queue_stack_maps: Replace zero-length array with
 flexible-array member
Message-ID: <20200213152416.GA1873@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.140.15
X-Source-L: No
X-Exim-ID: 1j2GJA-003BYr-8t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.15]:29529
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 29
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/bpf/queue_stack_maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index f697647ceb54..30e1373fd437 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -19,7 +19,7 @@ struct bpf_queue_stack {
 	u32 head, tail;
 	u32 size; /* max_entries + 1 */
 
-	char elements[0] __aligned(8);
+	char elements[] __aligned(8);
 };
 
 static struct bpf_queue_stack *bpf_queue_stack(struct bpf_map *map)
-- 
2.25.0

