Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4C7C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 21:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A9B2077C
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 21:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiJmUmzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDKVTi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:19:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34151 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKVTh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 17:19:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so6539237eds.1;
        Thu, 11 Apr 2019 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wePQ9gpVXM07ws5vB4Kn+rzGjOMxzOWRUOhMdpR7PF4=;
        b=ZiJmUmzNr4oGgRpIsoPqUX07jsIxMJdOeVbHPt9Rmzm8XDvAneD54pOLr3QwVZ150u
         X8qmGrdD28HoaOVWVZNn//8NBVHFsiseIY6KBdsi0zAk0htbrLvUQ88Swx9jkyTKFlAb
         pHrhKtHMD7UBukN54Xbw6l0KVXoSeychUAp4F2UPZYUiEgW06SSq1AS3r4dYsAkw7fE1
         lzbU3RBmo4RQ0fYNHtG3lXbhWoKKUnj9SvhyfIf9dp3awP9vk4zsP3Vp0P/PS8H3mmAi
         AyuJ/2MVG7OYWPxdbyOWpXhWMAjl8hbLBiw5RPdzE8GF7IeNlKzdgs8iyB1XYEwlkPAX
         WV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wePQ9gpVXM07ws5vB4Kn+rzGjOMxzOWRUOhMdpR7PF4=;
        b=iaysCTXEYb4J+nKowqjSmLbD37b4iAHdKECWgzv7BjlUCwseF20g6bYvyTu9KuSmlx
         bm6uqtdeHUGHEVx11a6khSSUxZ4tl7sbcDdDdJy1kiY/aB3Fycd2FE92OWzyYwarS4C7
         wA6F5sDzHMgbpNcBPJPPSdV8YasTDOKUrDxQbeD928a0vb1OWcyKLD/B9OPiL5oqDjon
         PvxpkS85FzsIg8utjPUw8DbECJVcTB6JtM+pJGBfqbDJgkK1cZYlIqhLt7wvLNRDCHE1
         BDpdwHZyimAYJaVvuZK2lUtDPasyN465mbri1mAtB2l0CiRzrmHTXOARlFDgLOdSdNM6
         +pWQ==
X-Gm-Message-State: APjAAAXLmVod5RSrcYAX8S14xH0naNDnlzIG7sF2CYmigB5L750IfGDj
        Dxy1XHyHnpsEaMucG+fPV+GCARMO36wzTUdOeWc=
X-Google-Smtp-Source: APXvYqx4CH87mHKeNQ5XidioRQUs9ul2yJPm2E1I921C47GmYdiCxFiCXG1pIY2z4PPwLUK4YaxgHiwT9vS0LtsPOA0=
X-Received: by 2002:a50:b53c:: with SMTP id y57mr2552061edd.60.1555017575155;
 Thu, 11 Apr 2019 14:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
 <1554818803-4070-3-git-send-email-alan.maguire@oracle.com> <12f9cef4-f5ff-78a4-ec0f-42f737696735@iogearbox.net>
In-Reply-To: <12f9cef4-f5ff-78a4-ec0f-42f737696735@iogearbox.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 11 Apr 2019 17:18:59 -0400
Message-ID: <CAF=yD-LMZF2gU+AmKSgtzN3YDDiO=XF19kf7RNg5_8zNp2m93w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/4] bpf: add layer 2 encap support to bpf_skb_adjust_room
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Willem de Bruijn <willemb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Thu, Apr 11, 2019 at 5:09 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 04/09/2019 04:06 PM, Alan Maguire wrote:
> > commit 868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")
> > introduced support to bpf_skb_adjust_room for GSO-friendly GRE
> > and UDP encapsulation.
> >
> > For GSO to work for skbs, the inner headers (mac and network) need to
> > be marked.  For L3 encapsulation using bpf_skb_adjust_room, the mac
> > and network headers are identical.  Here we provide a way of specifying
> > the inner mac header length for cases where L2 encap is desired.  Such
> > an approach can support encapsulated ethernet headers, MPLS headers etc.
> > For example to convert from a packet of form [eth][ip][tcp] to
> > [eth][ip][udp][inner mac][ip][tcp], something like the following could
> > be done:
> >
> >       headroom = sizeof(iph) + sizeof(struct udphdr) + inner_maclen;
> >
> >       ret = bpf_skb_adjust_room(skb, headroom, BPF_ADJ_ROOM_MAC,
> >                                 BPF_F_ADJ_ROOM_ENCAP_L4_UDP |
> >                                 BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 |
> >                                 BPF_F_ADJ_ROOM_ENCAP_L2(inner_maclen));
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  include/uapi/linux/bpf.h | 10 ++++++++++
> >  net/core/filter.c        | 12 ++++++++----
> >  2 files changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 8370245..912391c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1500,6 +1500,10 @@ struct bpf_stack_build_id {
> >   *           * **BPF_F_ADJ_ROOM_ENCAP_L4_UDP **:
> >   *             Use with ENCAP_L3 flags to further specify the tunnel type.
> >   *
> > + *           * **BPF_F_ADJ_ROOM_ENCAP_L2(len) **:
> > + *             Use with ENCAP_L3/L4 flags to further specify the tunnel
> > + *             type; **len** is the length of the inner MAC header.
> > + *
> >   *           A call to this helper is susceptible to change the underlaying
> >   *           packet buffer. Therefore, at load time, all checks on pointers
> >   *           previously done by the verifier are invalidated and must be
> > @@ -2641,10 +2645,16 @@ enum bpf_func_id {
> >  /* BPF_FUNC_skb_adjust_room flags. */
> >  #define BPF_F_ADJ_ROOM_FIXED_GSO     (1ULL << 0)
> >
> > +#define      BPF_ADJ_ROOM_ENCAP_L2_MASK      0xff
> > +#define      BPF_ADJ_ROOM_ENCAP_L2_SHIFT     56
>
> Would appreciate a small whitespace cleanup in that tab after the define
> is replaced with a normal space like in the rest of the file.
>
> >  #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 (1ULL << 1)
> >  #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 (1ULL << 2)
> >  #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE  (1ULL << 3)
> >  #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP  (1ULL << 4)
> > +#define      BPF_F_ADJ_ROOM_ENCAP_L2(len)    (((__u64)len & \
> > +                                       BPF_ADJ_ROOM_ENCAP_L2_MASK) \
> > +                                      << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)
>
> Ditto here.
>
> >  /* Mode for BPF_FUNC_skb_adjust_room helper. */
> >  enum bpf_adj_room_mode {
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 22eb2ed..a1654ef62 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2969,11 +2969,14 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
> >  #define BPF_F_ADJ_ROOM_MASK          (BPF_F_ADJ_ROOM_FIXED_GSO | \
> >                                        BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
> >                                        BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
> > -                                      BPF_F_ADJ_ROOM_ENCAP_L4_UDP)
> > +                                      BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
> > +                                      BPF_F_ADJ_ROOM_ENCAP_L2( \
> > +                                       BPF_ADJ_ROOM_ENCAP_L2_MASK))
> >
> >  static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
> >                           u64 flags)
> >  {
>
> One thing that it seems missing in this but also in Willem's earlier set
> is that we reject these flags in bpf_skb_net_shrink(). Both are called from
> bpf_skb_adjust_room(), so if we don't support decap yet we should reject
> such flags so we can extend in future. Could you or Willem send a follow-up?

Indeed. Thanks for bringing that up, Daniel. I only thought of that
after submitting the original patchset, too. Will send a patch.
