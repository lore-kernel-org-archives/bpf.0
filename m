Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F8C63697
	for <bpf@archiver.kernel.org>; Wed, 18 Nov 2020 08:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB02920867
	for <bpf@archiver.kernel.org>; Wed, 18 Nov 2020 08:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKRIZR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 18 Nov 2020 03:25:17 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60180 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgKRIZQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Nov 2020 03:25:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UFn3IGa_1605687911;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0UFn3IGa_1605687911)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Nov 2020 16:25:11 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     bjorn.topel@intel.com
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] xsk: replace datagram_poll by sock_poll_wait
Date:   Wed, 18 Nov 2020 16:25:08 +0800
Message-Id: <dfa43bcf7083edd0823e276c0cf8e21f3a226da6.1605686678.git.xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1605686678.git.xuanzhuo@linux.alibaba.com>
References: <3306b4d8-8689-b0e7-3f6d-c3ad873b7093@intel.com>
 <cover.1605686678.git.xuanzhuo@linux.alibaba.com>
In-Reply-To: <cover.1605686678.git.xuanzhuo@linux.alibaba.com>
References: <cover.1605686678.git.xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

datagram_poll will judge the current socket status (EPOLLIN, EPOLLOUT)
based on the traditional socket information (eg: sk_wmem_alloc), but
this does not apply to xsk. So this patch uses sock_poll_wait instead of
datagram_poll, and the mask is calculated by xsk_poll.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 net/xdp/xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index cfbec39..7f0353e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -477,11 +477,13 @@ static int xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 static __poll_t xsk_poll(struct file *file, struct socket *sock,
 			     struct poll_table_struct *wait)
 {
-	__poll_t mask = datagram_poll(file, sock, wait);
+	__poll_t mask = 0;
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
 	struct xsk_buff_pool *pool;
 
+	sock_poll_wait(file, sock, wait);
+
 	if (unlikely(!xsk_is_bound(xs)))
 		return mask;
 
-- 
1.8.3.1

