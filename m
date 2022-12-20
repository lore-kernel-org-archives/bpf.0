Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F0C10F1E
	for <bpf@archiver.kernel.org>; Tue, 20 Dec 2022 14:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiLTOO6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 20 Dec 2022 09:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiLTOO4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 09:14:56 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FB9E19;
        Tue, 20 Dec 2022 06:14:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VXlw2Sp_1671545692;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VXlw2Sp_1671545692)
          by smtp.aliyun-inc.com;
          Tue, 20 Dec 2022 22:14:52 +0800
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
Subject: [PATCH v2 2/9] virtio_net: set up xdp for multi buffer packets
Date:   Tue, 20 Dec 2022 22:14:42 +0800
Message-Id: <20221220141449.115918-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221220141449.115918-1-hengqi@linux.alibaba.com>
References: <20221220141449.115918-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When the xdp program sets xdp.frags, which means it can process
multi-buffer packets over larger MTU, so we continue to support xdp.
But for single-buffer xdp, we should keep checking for MTU.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 443aa7b8f0ad..c5c4e9db4ed3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3095,8 +3095,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		return -EINVAL;
 	}
 
-	if (dev->mtu > max_sz) {
-		NL_SET_ERR_MSG_MOD(extack, "MTU too large to enable XDP");
+	if (prog && !prog->aux->xdp_has_frags && dev->mtu > max_sz) {
+		NL_SET_ERR_MSG_MOD(extack, "MTU too large to enable XDP without frags");
 		netdev_warn(dev, "XDP requires MTU less than %lu\n", max_sz);
 		return -EINVAL;
 	}
-- 
2.19.1.6.gb485710b

