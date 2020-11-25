Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9D7C64E7D
	for <bpf@archiver.kernel.org>; Wed, 25 Nov 2020 06:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CA120DD4
	for <bpf@archiver.kernel.org>; Wed, 25 Nov 2020 06:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgKYGtM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 25 Nov 2020 01:49:12 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49785 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbgKYGtM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Nov 2020 01:49:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UGTnDfl_1606286938;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0UGTnDfl_1606286938)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Nov 2020 14:48:58 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     magnus.karlsson@gmail.com
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        netdev@vger.kernel.org (open list:XDP SOCKETS (AF_XDP)),
        bpf@vger.kernel.org (open list:XDP SOCKETS (AF_XDP)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf v2 0/2] xsk: fix for xsk_poll writeable
Date:   Wed, 25 Nov 2020 14:48:55 +0800
Message-Id: <cover.1606285978.git.xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1605686678.git.xuanzhuo@linux.alibaba.com>
References: <cover.1605686678.git.xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for magnus very much.

V2:
   #2 patch made some changes following magnus' opinions.

Xuan Zhuo (2):
  xsk: replace datagram_poll by sock_poll_wait
  xsk: change the tx writeable condition

 net/xdp/xsk.c       | 20 ++++++++++++++++----
 net/xdp/xsk_queue.h |  6 ++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

--
1.8.3.1

