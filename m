Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD57C10F13
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 19:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E86D20855
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 19:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4GW1g1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfDHTIS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:08:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41902 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDHTIR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 15:08:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id u2so8290490eds.8;
        Mon, 08 Apr 2019 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlJ/u57vvqC6jYWluBPaTRIYb8h48/WQPXl7fZ2PiBM=;
        b=F4GW1g1iarYIA+vPEPkchQ/Qg44Y7GVxLwri6FBw9V2tqEqjoGbWMlwOPiBcTsOQFW
         Tj2WtqdeXFix86/OhAL84h4nmecj8PiLU7DMRIz4QkWlvhtQaSWJp1t4AtSXDUV3Jp6+
         A8EG1v/69ISZZtj6Cu2bkqYIbz4SF5XNx/QGvBiAPbW28INJef0NRUjEkc3HysIcBi9h
         nDkxSsgJxuR6yZcpRk2Uymc+upTr3V/eDaSnhJs1VDsh8TVuzXRxiUBrT+0MY54DzNez
         NeEtNevYpLGM6FdnQN4Dow5DnwWI7G8skQOX/PTVzeooo2O0vbtfYbNX4tJJvnhuggkq
         dUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlJ/u57vvqC6jYWluBPaTRIYb8h48/WQPXl7fZ2PiBM=;
        b=VlO6/n4e1OMESCz6gF6dYEKoDFnflfnYXhLRtAITwmcVF9Ua6dKU0cFBVSJsQ1kmeg
         mORgqO/VsdVLaIWcSt20ydZ2xI+Kc8SfPeyI2Glf3ENobOgTjuSUhtBxOrO01D1mgnnK
         vZngH3zm02CpkOvt3UT0zp7GWwHNbTbaiLq8fHbpY600U4ZolJoLzKwZj3XG3wtQN1ou
         poltdAwKPT41QZy0F077qS60jRVv0kERS/lLPjvvJXaRImwga8CX5qaHl9piKi/aYbfg
         RzWlwf5ytN51/iXupxvtMnw7El+Byza1CnL60NmQeq41jS+WeBCYZFI3BhskVKrmpdQg
         8vow==
X-Gm-Message-State: APjAAAU0sNk9uoldM97elMC83bceguSp+Ogg9mMPWR2PHpPpuQHnlZdw
        Wjp0pmImIoyA62VtsweUPKJLU3LjetGFl5PQ/ic=
X-Google-Smtp-Source: APXvYqyPJAlKBwONhDH30qU851qQgZXSdzwYfx1di35zbFUKbJ/+AyR2fYxjJocpU418mkPYZAShtJALNLay+aLyxxk=
X-Received: by 2002:a50:926e:: with SMTP id j43mr20120849eda.60.1554750495602;
 Mon, 08 Apr 2019 12:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <1554742668-28313-1-git-send-email-alan.maguire@oracle.com> <1554742668-28313-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1554742668-28313-3-git-send-email-alan.maguire@oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 8 Apr 2019 15:07:39 -0400
Message-ID: <CAF=yD-K9Ld3jqCtE29P0n4noWYgC0i5A2TJvKyJAUkssnDOJ2w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: add layer 2 encap support to bpf_skb_adjust_room
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Willem de Bruijn <willemb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        John Fastabend <john.fastabend@gmail.com>, rdna@fb.com,
        linux-kselftest@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 8, 2019 at 12:59 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> commit 868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")
> introduced support to bpf_skb_adjust_room for GSO-friendly GRE
> and UDP encapsulation.
>
> For GSO to work for skbs, the inner headers (mac and network) need to
> be marked.  For L3 encapsulation using bpf_skb_adjust_room, the mac
> and network headers are identical.  Here we provide a way of specifying
> the inner mac header length for cases where L2 encap is desired.  Such
> an approach can support encapsulated ethernet headers, MPLS headers etc.
> For example to convert from a packet of form [eth][ip][tcp] to
> [eth][ip][udp][inner mac][ip][tcp], something like the following could
> be done:
>
>         headroom = sizeof(iph) + sizeof(struct udphdr) + inner_maclen;
>
>         ret = bpf_skb_adjust_room(skb, headroom, BPF_ADJ_ROOM_MAC,
>                                   BPF_F_ADJ_ROOM_ENCAP_L4_UDP |
>                                   BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 |
>                                   BPF_F_ADJ_ROOM_ENCAP_L2(inner_maclen));
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

>  static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>                             u64 flags)
>  {
> +       u16 mac_len = 0, inner_mac = 0, inner_net = 0, inner_trans = 0;
>         bool encap = flags & BPF_F_ADJ_ROOM_ENCAP_L3_MASK;
> -       u16 mac_len = 0, inner_net = 0, inner_trans = 0;
>         unsigned int gso_type = SKB_GSO_DODGY;
> +       u8 inner_mac_len = flags >> BPF_ADJ_ROOM_ENCAP_L2_SHIFT;
>         int ret;
>
>         if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
> @@ -3008,6 +3011,9 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>
>                 mac_len = skb->network_header - skb->mac_header;
>                 inner_net = skb->network_header;
> +               if (inner_mac_len > len_diff)
> +                       return -EINVAL;
> +               inner_mac = inner_net - inner_mac_len;

nit: variable inner_mac is not needed.

> @@ -3031,7 +3036,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>                         gso_type |= SKB_GSO_GRE;
>                 else if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
>                         gso_type |= SKB_GSO_IPXIP6;
> -               else
> +               else if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
>                         gso_type |= SKB_GSO_IPXIP4;

Nice catch. L2 encap should also work without L3 encap.
