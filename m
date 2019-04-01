Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC1C43381
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 17:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC90620883
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 17:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFkIcHZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbfDARa5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40701 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733171AbfDARay (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id h22so8997938edw.7;
        Mon, 01 Apr 2019 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYta5z14lA1IlUFd6p3Fhqnnv2Q/Ju/b5pYPjil6HpM=;
        b=jFkIcHZCbKuCorbjg9eslhTwVb2crrFkJ+GPHeq43q/9FXcnEJVkzcFTiRtZKih5c9
         D2hJG2WhClH7JkY49a0YF4R2q5BXIwWHbm7bxV7RLGswE5gTtwsDIXarZLMbok7Dhzsv
         spEc1/bU4NUuuxz8gemJg9sphAa8IuEngrr54eAdhFgazGB257to3b7ykR7zDFKIV7zp
         CjyYtNqnnnBPgcbP0WefA/G6KWlX2Yq4MNBRi4gxhLZw7BLpeuGHaFaWhYxrwNi2kW6X
         O+q0Q3c0IFAWLsrb0IQWUjGCt0PhbgwSsS5VLZm4toN3kwSF4DB8m38KvEH9E5FHubZF
         DLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYta5z14lA1IlUFd6p3Fhqnnv2Q/Ju/b5pYPjil6HpM=;
        b=BGVftolncecukGk91P0ncSwpUTDmHS73HhnQIsx9W57tI6javkl3a819GYBGLkg0Mm
         BpdIHyUBlrhq9ZikVEKE1qSEcr3zzdnwG+xj6Z7I3hlglMS86HlmXuJYGtpamV0JNNRI
         XQ0tqsuDc0G+M7smh+SBr19TxTbT0FWCpNB20o2ATYganW11kckgTWheUyYEh+dYZwRh
         Qr5t2ey/AZbtcQtArGrgyriOmrvKPvZx94jhs50bCbw7OSx4wLUxcrfCTXxa408vCE9I
         os7Dh8Lznr0ibSNj+VyGvUAOBMiE8m2zwlivNEsKu2U9mKd4OPPf5h+1oy5k43lBiQQL
         EpAA==
X-Gm-Message-State: APjAAAUU2zfGtliYnS2FeXjoUHAd/vMOhlIVS8SfNgLsudXmV8I9wIj3
        rvLMJ0SP4sOv8d5HN+Fjab+2+Iu3IeHEl08MJfg=
X-Google-Smtp-Source: APXvYqyMLECtnZc7Y0lOol4fEqv4dhlBlbkz2AhPC6UIhX2TX0InAxY3hXrrOvHtHiD/kEkhH6Cv/7p4UtA+tiyNeao=
X-Received: by 2002:a50:ca0d:: with SMTP id d13mr23222349edi.72.1554139852842;
 Mon, 01 Apr 2019 10:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com> <1554132731-3095-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1554132731-3095-3-git-send-email-alan.maguire@oracle.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 1 Apr 2019 13:30:16 -0400
Message-ID: <CAF=yD-KRFNiRk24CVkNsJBkfw=im8J67J5jCe2gkM28BXs_zSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: add layer 2 encap support to bpf_skb_adjust_room
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

On Mon, Apr 1, 2019 at 11:33 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> In
>
> commit 868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")
>
> ...Willem introduced support to bpf_skb_adjust_room for GSO-friendly
> GRE and UDP encapsulation.
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
> ---

> +#define        BPF_F_ADJ_ROOM_ENCAP_L2(len)    (((__u64)len & 0xff) << 56)

Here ..

>
>  /* Mode for BPF_FUNC_skb_adjust_room helper. */
>  enum bpf_adj_room_mode {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 22eb2ed..02ae8c0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2969,14 +2969,16 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
>  #define BPF_F_ADJ_ROOM_MASK            (BPF_F_ADJ_ROOM_FIXED_GSO | \
>                                          BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>                                          BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
> -                                        BPF_F_ADJ_ROOM_ENCAP_L4_UDP)
> +                                        BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
> +                                        BPF_F_ADJ_ROOM_ENCAP_L2(0xff))

.. and here ..
>
>  static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>                             u64 flags)
>  {
> +       u16 mac_len = 0, inner_mac = 0, inner_net = 0, inner_trans = 0;
>         bool encap = flags & BPF_F_ADJ_ROOM_ENCAP_L3_MASK;
> -       u16 mac_len = 0, inner_net = 0, inner_trans = 0;
>         unsigned int gso_type = SKB_GSO_DODGY;
> +       u8 inner_mac_len = flags >> 56;

.. and here: please do not use hardcoded constants. Define explicit
constant integers or macros for readability and consistency.

>         int ret;
>
>         if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
> @@ -3003,11 +3005,19 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>                     flags & BPF_F_ADJ_ROOM_ENCAP_L4_UDP)
>                         return -EINVAL;
>
> +               if (flags & BPF_F_ADJ_ROOM_ENCAP_L4_UDP &&
> +                   flags & BPF_F_ADJ_ROOM_FIXED_GSO &&
> +                   inner_mac_len > 0)
> +                       return -EINVAL;
> +

Why is UDP encap with inner MAC (or MPLS) not allowed with fixed GSO?
