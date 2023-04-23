Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F68BC77B76
	for <bpf@archiver.kernel.org>; Sun, 23 Apr 2023 10:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDWK5n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 23 Apr 2023 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWK5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 06:57:43 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E24E68;
        Sun, 23 Apr 2023 03:57:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vgjkwcz_1682247456;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vgjkwcz_1682247456)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 18:57:37 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [PATCH net-next v3 00/15] virtio_net: refactor xdp codes
Date:   Sun, 23 Apr 2023 18:57:21 +0800
Message-Id: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: 3bb17d92efad
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Due to historical reasons, the implementation of XDP in virtio-net is relatively
chaotic. For example, the processing of XDP actions has two copies of similar
code. Such as page, xdp_page processing, etc.

The purpose of this patch set is to refactor these code. Reduce the difficulty
of subsequent maintenance. Subsequent developers will not introduce new bugs
because of some complex logical relationships.

In addition, the supporting to AF_XDP that I want to submit later will also need
to reuse the logic of XDP, such as the processing of actions, I don't want to
introduce a new similar code. In this way, I can reuse these codes in the
future.

Please review.

Thanks.

v2:
    1. re-split to make review more convenient

v1:
    1. fix some variables are uninitialized


Xuan Zhuo (15):
  virtio_net: mergeable xdp: put old page immediately
  virtio_net: introduce mergeable_xdp_get_buf()
  virtio_net: optimize mergeable_xdp_get_buf()
  virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
    run xdp
  virtio_net: separate the logic of freeing xdp shinfo
  virtio_net: separate the logic of freeing the rest mergeable buf
  virtio_net: auto release xdp shinfo
  virtio_net: introduce receive_mergeable_xdp()
  virtio_net: merge: remove skip_xdp
  virtio_net: introduce receive_small_xdp()
  virtio_net: small: optimize code
  virtio_net: small: optimize code
  virtio_net: small: remove skip_xdp
  virtio_net: introduce receive_small_build_xdp
  virtio_net: introduce virtnet_build_skb()

 drivers/net/virtio_net.c | 659 +++++++++++++++++++++++----------------
 1 file changed, 386 insertions(+), 273 deletions(-)

-- 
2.32.0.3.g01195cf9f

