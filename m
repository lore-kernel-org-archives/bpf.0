Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE2C433B4
	for <bpf@archiver.kernel.org>; Thu, 13 May 2021 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE811613B6
	for <bpf@archiver.kernel.org>; Thu, 13 May 2021 11:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhEMLt6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 13 May 2021 07:49:58 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45823 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233673AbhEMLtU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 May 2021 07:49:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UYkPI60_1620906488;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0UYkPI60_1620906488)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 May 2021 19:48:08 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [PATCH net-next 0/2] virtio-net: fix for build_skb()
Date:   Thu, 13 May 2021 19:48:06 +0800
Message-Id: <20210513114808.120031-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

#1 Fixed a serious error.
#2 Fixed a logical error, but this error did not cause any serious consequences.

The logic of this piece is really messy. Fortunately, my refactored patch can be
completed with a small amount of testing.

Thanks.

Xuan Zhuo (2):
  virtio-net: fix for unable to handle page fault for address
  virtio-net: get build_skb() buf by data ptr

 drivers/net/virtio_net.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--
2.31.0

