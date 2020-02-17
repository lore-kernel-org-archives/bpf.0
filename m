Return-Path: <SRS0=hNf8=4F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00566C3402A
	for <bpf@archiver.kernel.org>; Mon, 17 Feb 2020 20:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAD02067D
	for <bpf@archiver.kernel.org>; Mon, 17 Feb 2020 20:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="fK82/v2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgBQUWG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Feb 2020 15:22:06 -0500
Received: from gateway30.websitewelcome.com ([192.185.160.12]:20428 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729041AbgBQUWF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Feb 2020 15:22:05 -0500
X-Greylist: delayed 1413 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 15:22:04 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 03CDE925A
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2020 13:58:31 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3mXGjVCx3XVkQ3mXGjsIvJ; Mon, 17 Feb 2020 13:58:30 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lL/wXEQHi6LCYu2lhykWxgmf1aHw3CsCn1BREA1tfRE=; b=fK82/v2ZvhIZLJatuoWe0R1cPJ
        pAvAjXK22AfD8Z/Du17oJLpt7auD8pYHZpKBB5J93519ocXDYMERj8cONkZeFbahHPRH5RXYxIV6M
        AxzvuVd+cg9PG2eh6aUyqpWWR5DGeUMpcKYOi6/yZAEAeDTNOh0CNhynuWryGDMeuClYY6/XY8KcR
        dU7c4txB1QAsHDWa2eJ0kkK2gS9XZNT4IULQgdkyqeZPtKP4AuwVy1PI7jyvQ9+nXskmDHhkGjJUV
        pov0c83Un8z+vtC6yzGbPB4+hhdAN5lLBUjjw+BIy0nquFVXVfDhGShblYTzr9s4zijvIESHIUHlg
        nkjnRtMg==;
Received: from [200.68.140.26] (port=19134 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j3mXF-000Mi0-Fe; Mon, 17 Feb 2020 13:58:29 -0600
Date:   Mon, 17 Feb 2020 14:01:11 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] bpf, sockmap: Replace zero-length array with
 flexible-array member
Message-ID: <20200217200111.GA5283@embeddedor>
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
X-Source-IP: 200.68.140.26
X-Source-L: No
X-Exim-ID: 1j3mXF-000Mi0-Fe
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.26]:19134
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 28
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
 net/core/sock_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 085cef5857bb..3a7a96ab088a 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -518,7 +518,7 @@ struct bpf_htab_elem {
 	u32 hash;
 	struct sock *sk;
 	struct hlist_node node;
-	u8 key[0];
+	u8 key[];
 };
 
 struct bpf_htab_bucket {
-- 
2.25.0

