Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE94C433E9
	for <bpf@archiver.kernel.org>; Thu, 18 Feb 2021 20:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0343764EBA
	for <bpf@archiver.kernel.org>; Thu, 18 Feb 2021 20:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBRUvX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:51:23 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:46390 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhBRUvA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Feb 2021 15:51:00 -0500
Date:   Thu, 18 Feb 2021 20:50:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1613681418; bh=nvb2yx8DAQSWWcjoTwgm5AP3LHJtzlTi3X02uTTAjO0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=bjUASJEJZpVOK3U8eOaxIx7AQETLm4KBLHSNpWpoE+Q2dy76YRTXZis9tFDicFGUG
         YqD+gKmNSKojjy1YVZou7MpSnrzgxtyJLttJnYwHwOiQ7r50/pGUZfByj41FdhoKWT
         QakuOv57clNV7tUMsBd+0vaRlFKOtD0SZKXe3OTm/UFfcEVVWWe1SkjMKNUC3GmptP
         9TDLJiZicwLzZpT+DXJH8jEf52j9vz+miTl+PRG3GozSTSp3WuBrOD+IpFLoRY1sGh
         iXaaGX113Xplqxtu6r9KVQUJgr6n4BeHtvjcGZFp0Ez1HsjE8HCUDm5qYms/FzlJc9
         s632M29CivQyw==
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Magnus Karlsson <magnus.karlsson@intel.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        =?utf-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Alexander Lobakin <alobakin@pm.me>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH v8 bpf-next 3/5] virtio-net: support IFF_TX_SKB_NO_LINEAR
Message-ID: <20210218204908.5455-4-alobakin@pm.me>
In-Reply-To: <20210218204908.5455-1-alobakin@pm.me>
References: <20210218204908.5455-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Virtio net supports the case where the skb linear space is empty, so add
priv_flags.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ba8e63792549..f2ff6c3906c1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2972,7 +2972,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 =09=09return -ENOMEM;

 =09/* Set up network device as normal. */
-=09dev->priv_flags |=3D IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
+=09dev->priv_flags |=3D IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
+=09=09=09   IFF_TX_SKB_NO_LINEAR;
 =09dev->netdev_ops =3D &virtnet_netdev;
 =09dev->features =3D NETIF_F_HIGHDMA;

--
2.30.1


