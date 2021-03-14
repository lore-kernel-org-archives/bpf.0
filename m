Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304CEC433E9
	for <bpf@archiver.kernel.org>; Sun, 14 Mar 2021 11:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C6764EB7
	for <bpf@archiver.kernel.org>; Sun, 14 Mar 2021 11:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhCNLMM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 14 Mar 2021 07:12:12 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:23674 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbhCNLLy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Mar 2021 07:11:54 -0400
Date:   Sun, 14 Mar 2021 11:11:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1615720313; bh=5MpWKAjO4E1TpGup0jNHoJh4fKp9mBQ4WRLVO089bHE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=dbiUPBOmaUdweDnPve56m+Fshaf0U8bdXHkN24JVcIYUbpoizTv55lvHF/w8XNmg3
         Qhc1V/KdtQD+jcN7EKajUKa/v4sEZsRlXnNpbm/z/1IqO24GsfeAlezRBd6QB/lfbZ
         bAnrXo9BTu0rYUQQ0HvcuPyotUTPNVCxVZILC6nH34Xoo6hLIsRWAPcfBbTTEZmXM2
         JWUVlFSFtpi3/hl/h4uJv7rYrRapbq5CLpQmTP52r2V1V4aXeFzINSrM03jHdS4dE5
         89g5/EtcJjdyvnshLOwfUVQ+dCCJHtEMaPVAprXSGUJIA2y2tpe6zfSbbhuv62RYXl
         KIsmX4XcdmAcg==
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kevin Hao <haokexin@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Dexuan Cui <decui@microsoft.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        Wang Qing <wangqing@vivo.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH v3 net-next 6/6] skbuff: micro-optimize {,__}skb_header_pointer()
Message-ID: <20210314111027.7657-7-alobakin@pm.me>
In-Reply-To: <20210314111027.7657-1-alobakin@pm.me>
References: <20210314111027.7657-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

{,__}skb_header_pointer() helpers exist mainly for preventing
accesses-beyond-end of the linear data.
In the vast majorify of cases, they bail out on the first condition.
All code going after is mostly a fallback.
Mark the most common branch as 'likely' one to move it in-line.
Also, skb_copy_bits() can return negative values only when the input
arguments are invalid, e.g. offset is greater than skb->len. It can
be safely marked as 'unlikely' branch, assuming that hotpath code
provides sane input to not fail here.

These two bump the throughput with a single Flow Dissector pass on
every packet (e.g. with RPS or driver that uses eth_get_headlen())
on 20 Mbps per flow/core.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 include/linux/skbuff.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 46c61e127e9f..ecc029674ae4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3680,11 +3680,10 @@ static inline void * __must_check
 __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
 =09=09     const void *data, int hlen, void *buffer)
 {
-=09if (hlen - offset >=3D len)
+=09if (likely(hlen - offset >=3D len))
 =09=09return (void *)data + offset;

-=09if (!skb ||
-=09    skb_copy_bits(skb, offset, buffer, len) < 0)
+=09if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0))
 =09=09return NULL;

 =09return buffer;
--
2.30.2


