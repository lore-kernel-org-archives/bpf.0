Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D788C433E6
	for <bpf@archiver.kernel.org>; Thu, 18 Feb 2021 20:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD23564EB6
	for <bpf@archiver.kernel.org>; Thu, 18 Feb 2021 20:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhBRUvP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:51:15 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:54191 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhBRUux (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Feb 2021 15:50:53 -0500
Date:   Thu, 18 Feb 2021 20:50:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1613681403; bh=UT5dqOxXemXMBrQO9+qpLgvawJH5qOALCJiqi4jXfPQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ZzPhaU1Um8KKnztCWdjI7U1gntZ54rIbwLoyG7z7JO3++LUhiAORy0MgqXE/++yRk
         gBTBajl4Kw+vw+g+fNl3uQ8uOaSdtOL3wWa6H1BirrmQ79QJeQINP6Y5tWT8pOd6Qa
         DalmENxYUoppmXBC22JeA1fzilIOKF9HLjjHxP9zpv2M4z9XHggpcu1r3cAsTZnKVS
         rMOV7DQNcbsVP7P7z7+p4p2gNmg2+8ODetnUuCQzveJ5BJPdSY6uh3GJp14Aqkq8AG
         G/GKp35+v2K8Zz8j2nkQPpgw1O2d+zI2K7JTnG9803cnqeuIA9qFz44X+VSE3iLusm
         f2Wse1HssAk2g==
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
Subject: [PATCH v8 bpf-next 2/5] net: add priv_flags for allow tx skb without linear
Message-ID: <20210218204908.5455-3-alobakin@pm.me>
In-Reply-To: <20210218204908.5455-1-alobakin@pm.me>
References: <20210218204908.5455-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

In some cases, we hope to construct skb directly based on the existing
memory without copying data. In this case, the page will be placed
directly in the skb, and the linear space of skb is empty. But
unfortunately, many the network card does not support this operation.
For example Mellanox Technologies MT27710 Family [ConnectX-4 Lx] will
get the following error message:

    mlx5_core 0000:3b:00.1 eth1: Error cqe on cqn 0x817, ci 0x8,
    qn 0x1dbb, opcode 0xd, syndrome 0x1, vendor syndrome 0x68
    00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    00000030: 00 00 00 00 60 10 68 01 0a 00 1d bb 00 0f 9f d2
    WQE DUMP: WQ size 1024 WQ cur size 0, WQE index 0xf, len: 64
    00000000: 00 00 0f 0a 00 1d bb 03 00 00 00 08 00 00 00 00
    00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    00000020: 00 00 00 2b 00 08 00 00 00 00 00 05 9e e3 08 00
    00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    mlx5_core 0000:3b:00.1 eth1: ERR CQE on SQ: 0x1dbb

So a priv_flag is added here to indicate whether the network card
supports this feature.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Suggested-by: Alexander Lobakin <alobakin@pm.me>
[ alobakin: give a new flag more detailed description ]
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3b6f82c2c271..6cef47b76cc6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1518,6 +1518,8 @@ struct net_device_ops {
  * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
  * @IFF_L3MDEV_RX_HANDLER: only invoke the rx handler of L3 master device
  * @IFF_LIVE_RENAME_OK: rename is allowed while device is up and running
+ * @IFF_TX_SKB_NO_LINEAR: device/driver is capable of xmitting frames with
+ *=09skb_headlen(skb) =3D=3D 0 (data starts from frag0)
  */
 enum netdev_priv_flags {
 =09IFF_802_1Q_VLAN=09=09=09=3D 1<<0,
@@ -1551,6 +1553,7 @@ enum netdev_priv_flags {
 =09IFF_FAILOVER_SLAVE=09=09=3D 1<<28,
 =09IFF_L3MDEV_RX_HANDLER=09=09=3D 1<<29,
 =09IFF_LIVE_RENAME_OK=09=09=3D 1<<30,
+=09IFF_TX_SKB_NO_LINEAR=09=09=3D 1<<31,
 };

 #define IFF_802_1Q_VLAN=09=09=09IFF_802_1Q_VLAN
@@ -1584,6 +1587,7 @@ enum netdev_priv_flags {
 #define IFF_FAILOVER_SLAVE=09=09IFF_FAILOVER_SLAVE
 #define IFF_L3MDEV_RX_HANDLER=09=09IFF_L3MDEV_RX_HANDLER
 #define IFF_LIVE_RENAME_OK=09=09IFF_LIVE_RENAME_OK
+#define IFF_TX_SKB_NO_LINEAR=09=09IFF_TX_SKB_NO_LINEAR

 /**
  *=09struct net_device - The DEVICE structure.
--
2.30.1


