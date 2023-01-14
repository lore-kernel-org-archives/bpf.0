Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D3CC3DA78
	for <bpf@archiver.kernel.org>; Sat, 14 Jan 2023 08:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjANIWi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 14 Jan 2023 03:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjANIWh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Jan 2023 03:22:37 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B28468E;
        Sat, 14 Jan 2023 00:22:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VZX44sZ_1673684550;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VZX44sZ_1673684550)
          by smtp.aliyun-inc.com;
          Sat, 14 Jan 2023 16:22:31 +0800
From:   Heng Qi <hengqi@linux.alibaba.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v5 01/10] virtio-net: disable the hole mechanism for xdp
Date:   Sat, 14 Jan 2023 16:22:20 +0800
Message-Id: <20230114082229.62143-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230114082229.62143-1-hengqi@linux.alibaba.com>
References: <20230114082229.62143-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

XDP core assumes that the frame_size of xdp_buff and the length of
the frag are PAGE_SIZE. The hole may cause the processing of xdp to
fail, so we disable the hole mechanism when xdp is set.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9cce7dec7366..443aa7b8f0ad 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1419,8 +1419,11 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 		/* To avoid internal fragmentation, if there is very likely not
 		 * enough space for another buffer, add the remaining space to
 		 * the current buffer.
+		 * XDP core assumes that frame_size of xdp_buff and the length
+		 * of the frag are PAGE_SIZE, so we disable the hole mechanism.
 		 */
-		len += hole;
+		if (!headroom)
+			len += hole;
 		alloc_frag->offset += hole;
 	}
 
-- 
2.19.1.6.gb485710b

