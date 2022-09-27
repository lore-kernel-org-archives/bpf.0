Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155BFC433FE
	for <bpf@archiver.kernel.org>; Fri, 30 Sep 2022 01:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiI3BBw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Sep 2022 21:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiI3BBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 21:01:50 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823BC1F8C0D;
        Thu, 29 Sep 2022 18:01:48 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id YAF00140;
        Fri, 30 Sep 2022 09:01:40 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 30 Sep 2022 09:01:43 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
        <kuba@kernel.org>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <andrii@kernel.org>
CC:     <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
        <jolsa@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] samples, bpf: fix the typo of sample
Date:   Tue, 27 Sep 2022 15:25:27 -0400
Message-ID: <20220927192527.8722-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20229300901401c89c41559e6149114e126f6d18044e9
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

fix the typo of the enty.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 samples/bpf/xdp_router_ipv4_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index 294fc15ad1cb..683913bbf279 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -209,7 +209,7 @@ static void read_route(struct nlmsghdr *nh, int nll)
 					/* Rereading the route table to check if
 					 * there is an entry with the same
 					 * prefix but a different metric as the
-					 * deleted enty.
+					 * deleted entry.
 					 */
 					get_route_table(AF_INET);
 				} else if (prefix_key->data[0] ==
-- 
2.27.0

