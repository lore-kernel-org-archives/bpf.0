Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF31BC433E9
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 14:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14BF64EEC
	for <bpf@archiver.kernel.org>; Thu,  4 Mar 2021 14:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhCDOEf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Mar 2021 09:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbhCDOEO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 09:04:14 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29F7C061574
        for <bpf@vger.kernel.org>; Thu,  4 Mar 2021 06:03:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so25790936edx.1
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 06:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1tdC4DAWUKpwHKmfGOMBVPLo5pkE31kY4A2V+ZSNK8=;
        b=j+QE9hFHwOn0jf2iY8vZIRkwwANg+cq6OkDtp7/5QGxaV2rEMZars6of5cZ056++Wl
         opV3ATU5jpM0hMBSf5WoUIwscIYDGb7UJbeXys9RZG2LCa5lGZnHqPClrDwMGYWahoHm
         rKUwZOtIwkPT2S+oc/kQQ2xnT2xDInRyQXdgcD+I76SOqmhgcTUGQLAJ/EXbphTjygZ5
         dKHpiWitNLtBzHTcQxpW1EiICT35xQz7LO+FatvVh34zvtjcLLHEQzv+LqTRx8CC7H+L
         21Jlkpo0Tdza6mjSn45SqfkEMmnCV7Zso4Qi30atHXHzf//0FntT9Y7vpC0RA5MIR2/L
         sDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1tdC4DAWUKpwHKmfGOMBVPLo5pkE31kY4A2V+ZSNK8=;
        b=D3db5rG6oYyn0x22ZzvD1I2gIFh1o7IAjgj13hBfqtTo4EROF9L1BVCm4zE0GPDv63
         LjcXURFrRaCAzWjBy0j/FbF4TLxwslD6ES6sR++kwYmxYPDBj+0Ke3yk4ifXb/0qZjzm
         p/0LIZ3gT5/V9KxAFSkgCioufiOEU+NQQjVRcKNL52x61UT6p0uaF1h3W2Rnwf3nXOPV
         k5SYBw+qaucXxnu9MkahzeKHQLxjcZ7p28z/9AWvjr62IcClfdcPmG7x2Hk3KhH86mWk
         9dOfII8oHgFFhPvV4tlJngeAdM/+fazmgKyl6//kTRULt2ruqnK03wdkWin+xRaLZmrc
         iT7Q==
X-Gm-Message-State: AOAM530CNWJfUHbt8WHk8GZu5TksR2nP5iaZsszKsVz0Od2vI6L5CEZN
        XenO/bISV7lP7c/A7haRfEcQKuWSmRo=
X-Google-Smtp-Source: ABdhPJzOnxAwAmCpOlFTxBIebBGuzwg/ZxroeDzyYwfI7r+nXwJuxE22v4npvhWBMlmQ7z+RJUWnBQ==
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr4503036ede.271.1614866612444;
        Thu, 04 Mar 2021 06:03:32 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id h2sm22194881ejk.32.2021.03.04.06.03.31
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 06:03:32 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id u125so9780988wmg.4
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 06:03:31 -0800 (PST)
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr4014740wmq.183.1614866611549;
 Thu, 04 Mar 2021 06:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20210304064212.6513-1-hxseverything@gmail.com>
In-Reply-To: <20210304064212.6513-1-hxseverything@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 4 Mar 2021 09:02:53 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfj2u5pEbKJR_m0qCiPfdhCVS_BZVPPO=dNjAyL7HG7FQ@mail.gmail.com>
Message-ID: <CA+FuTSfj2u5pEbKJR_m0qCiPfdhCVS_BZVPPO=dNjAyL7HG7FQ@mail.gmail.com>
Subject: Re: [PATCH] selftests_bpf: extend test_tc_tunnel test with vxlan
To:     Xuesen Huang <hxseverything@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Xuesen Huang <huangxuesen@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 4, 2021 at 1:42 AM Xuesen Huang <hxseverything@gmail.com> wrote:
>
> From: Xuesen Huang <huangxuesen@kuaishou.com>
>
> Add BPF_F_ADJ_ROOM_ENCAP_L2_ETH flag to the existing tests which
> encapsulates the ethernet as the inner l2 header.
>
> Update a vxlan encapsulation test case.
>
> Signed-off-by: Xuesen Huang <huangxuesen@kuaishou.com>
> Signed-off-by: Li Wang <wangli09@kuaishou.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Please mark patch target: [PATCH bpf-next]

> ---
>  tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 113 ++++++++++++++++++---
>  tools/testing/selftests/bpf/test_tc_tunnel.sh      |  15 ++-
>  2 files changed, 111 insertions(+), 17 deletions(-)


> -static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
> -                                     __u16 l2_proto)
> +static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
> +                                       __u16 l2_proto, __u16 ext_proto)
>  {
>         __u16 udp_dst = UDP_PORT;
>         struct iphdr iph_inner;
>         struct v4hdr h_outer;
>         struct tcphdr tcph;
>         int olen, l2_len;
> +       __u8 *l2_hdr = NULL;
>         int tcp_off;
>         __u64 flags;
>
> @@ -141,7 +157,11 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
>                 break;
>         case ETH_P_TEB:
>                 l2_len = ETH_HLEN;
> -               udp_dst = ETH_OVER_UDP_PORT;
> +               if (ext_proto & EXTPROTO_VXLAN) {
> +                       udp_dst = VXLAN_UDP_PORT;
> +                       l2_len += sizeof(struct vxlanhdr);
> +               } else
> +                       udp_dst = ETH_OVER_UDP_PORT;
>                 break;
>         }
>         flags |= BPF_F_ADJ_ROOM_ENCAP_L2(l2_len);
> @@ -171,14 +191,26 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
>         }
>
>         /* add L2 encap (if specified) */
> +       l2_hdr = (__u8 *)&h_outer + olen;
>         switch (l2_proto) {
>         case ETH_P_MPLS_UC:
> -               *((__u32 *)((__u8 *)&h_outer + olen)) = mpls_label;
> +               *(__u32 *)l2_hdr = mpls_label;
>                 break;
>         case ETH_P_TEB:
> -               if (bpf_skb_load_bytes(skb, 0, (__u8 *)&h_outer + olen,
> -                                      ETH_HLEN))
> +               flags |= BPF_F_ADJ_ROOM_ENCAP_L2_ETH;
> +
> +               if (ext_proto & EXTPROTO_VXLAN) {
> +                       struct vxlanhdr *vxlan_hdr = (struct vxlanhdr *)l2_hdr;
> +
> +                       vxlan_hdr->vx_flags = VXLAN_FLAGS;
> +                       vxlan_hdr->vx_vni = bpf_htonl((VXLAN_VNI & VXLAN_VNI_MASK) << 8);
> +
> +                       l2_hdr += sizeof(struct vxlanhdr);

should this be l2_len? (here and ipv6 below)

> +SEC("encap_vxlan_eth")
> +int __encap_vxlan_eth(struct __sk_buff *skb)
> +{
> +       if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
> +               return __encap_ipv4(skb, IPPROTO_UDP,
> +                               ETH_P_TEB,
> +                               EXTPROTO_VXLAN);

non-standard indentation: align with the opening parenthesis. (here
and ipv6 below)
