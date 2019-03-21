Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ACCC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 04:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF962218A5
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 04:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="xndoGEiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfCUExO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:53:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39292 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCUExO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 00:53:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so4363003otb.6
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 21:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWhahsUokkoxOfy4U6mBkwWbWuau4Q/EYPDD1wKvrqw=;
        b=xndoGEiRtB/OlxaR6tMymzQKurEBjg4K9VSs9J2RrFM1Hkj9+vtNk2g0AD2rzkZJ5J
         fN2foMCBr95VH7NgNM1IQ6rhxj3puCHeurXYsRp4tJyd9JhVESfxaEMwsZyJpYyVmLYV
         raGp0qDwrJkoEj1LCqAdFk4jUqi2CsA7cpiS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWhahsUokkoxOfy4U6mBkwWbWuau4Q/EYPDD1wKvrqw=;
        b=Co4Z9HyLpn2jTasFTB5JgS7Wg4Gg2Gfc6a29HZFVTcdIvgQcfIEmE3+S1i+Pc/4FWQ
         nRp539DtXYS9osc7eWcWwkhH99cAOkVz/UMootbBefPLhLQUy+vrUiaGE7I9M3n2B0O/
         e9dTxW2ZqWs2avGvw+/beMOMnKa0lqu6dM2maAcPfucrJWl22fg9QQ0/F2fLOlSIYRez
         Di4jkadjpx9kVdHrk0PKPVLOKFkzUwyhq4Q2W6Ap33jqnOxPqGDDzuhD3cpRpvTbcTfx
         af2402HYMDBBiSKDUS0lnqY5tVlgyd5bS207Y8Nz+gbuxogUU5nPVQpNWf8AHk9YuDd4
         tvBQ==
X-Gm-Message-State: APjAAAWrEIruDHPePetCtYBVs//XwGy1/VfqDnISCc4KTdzuMq7RkjXx
        LqWd1e/rDua9+Qq3qGYKJzNZ4HYvYEMCrggfi4dkmA==
X-Google-Smtp-Source: APXvYqz4N0HyjjUistLni4w/S5ocmkVVuf7g+1trNhR6YJX6BnaH9LKRDiBpNf+9v5PO7qWm9MG6TvcEDtNbY5NSBB0=
X-Received: by 2002:a9d:5e83:: with SMTP id f3mr1188228otl.181.1553143993195;
 Wed, 20 Mar 2019 21:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190222095057.9442-1-lmb@cloudflare.com> <20190319102103.7380-1-lmb@cloudflare.com>
 <20190319102103.7380-5-lmb@cloudflare.com> <20190319221735.ycueci4ec4rvbkxf@ast-mbp.dhcp.thefacebook.com>
 <CACAyw9_euySi4LWWD-789DdY-XYgMNLaNY+RrhJieoY7r0qcwQ@mail.gmail.com> <20190321030339.mr2jlxtyevfuegyf@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190321030339.mr2jlxtyevfuegyf@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 21 Mar 2019 04:53:00 +0000
Message-ID: <CACAyw986toY6X3_m=bo-0b8BQXfTJFBvpC+tYrk-iu3F8uf9QQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] bpf: add helper to check for a valid SYN cookie
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 21 Mar 2019 at 03:03, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 21, 2019 at 02:09:08AM +0000, Lorenz Bauer wrote:
> > On Tue, 19 Mar 2019 at 22:17, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Mar 19, 2019 at 10:20:59AM +0000, Lorenz Bauer wrote:
> > > > Using bpf_skc_lookup_tcp it's possible to ascertain whether a packet
> > > > belongs to a known connection. However, there is one corner case: no
> > > > sockets are created if SYN cookies are active. This means that the final
> > > > ACK in the 3WHS is misclassified.
> > > >
> > > > Using the helper, we can look up the listening socket via
> > > > bpf_skc_lookup_tcp and then check whether a packet is a valid SYN
> > > > cookie ACK.
> > > >
> > > > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > > > ---
> > > >  include/uapi/linux/bpf.h | 18 +++++++++-
> > > >  net/core/filter.c        | 72 ++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 89 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index 8e4f8276942a..587d7a3295bf 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -2391,6 +2391,21 @@ union bpf_attr {
> > > >   *           Pointer to **struct bpf_sock**, or **NULL** in case of failure.
> > > >   *           For sockets with reuseport option, the **struct bpf_sock**
> > > >   *           result is from **reuse->socks**\ [] using the hash of the tuple.
> > > > + *
> > > > + * int bpf_tcp_check_syncookie(struct bpf_sock *sk, void *iph, u32 iph_len, struct tcphdr *th, u32 th_len)
> > > > + *   Description
> > > > + *           Check whether iph and th contain a valid SYN cookie ACK for
> > > > + *           the listening socket in sk.
> > > > + *
> > > > + *           iph points to the start of the IPv4 or IPv6 header, while
> > > > + *           iph_len contains sizeof(struct iphdr) or sizeof(struct ip6hdr).
> > > > + *
> > > > + *           th points to the start of the TCP header, while th_len contains
> > > > + *           sizeof(struct tcphdr).
> > > > + *
> > > > + *   Return
> > > > + *           0 if iph and th are a valid SYN cookie ACK, or a negative error
> > > > + *           otherwise.
> > > >   */
> > > >  #define __BPF_FUNC_MAPPER(FN)                \
> > > >       FN(unspec),                     \
> > > > @@ -2492,7 +2507,8 @@ union bpf_attr {
> > > >       FN(tcp_sock),                   \
> > > >       FN(skb_ecn_set_ce),             \
> > > >       FN(get_listener_sock),          \
> > > > -     FN(skc_lookup_tcp),
> > > > +     FN(skc_lookup_tcp),             \
> > > > +     FN(tcp_check_syncookie),
> > > >
> > > >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > > >   * function eBPF program intends to call
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index f5210773cfd8..45a46fbe4ee0 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -5546,6 +5546,74 @@ static const struct bpf_func_proto bpf_skb_ecn_set_ce_proto = {
> > > >       .ret_type       = RET_INTEGER,
> > > >       .arg1_type      = ARG_PTR_TO_CTX,
> > > >  };
> > > > +
> > > > +BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
> > > > +        struct tcphdr *, th, u32, th_len)
> > >
> > > what was the reason to pass ip and tcp header pointers separately?
> > > Why not to pass 'void* iph' with len long enough to cover both?
> >
> > Our use case is to look at Foo-over-UDP encapsulated packets before they are
> > decapsulated, and if necessary forward them to another machine.
> > Essentially a bit
> > of BPF which either XDP_PASSes when we find that a packet belongs to a known
> > connection, or XDP_TX if it doesn't.
> >
> > This means we already have to have both ip and tcp header parsed,
> > otherwise it can't get a reference to a socket via bpf_skc_lookup_tcp.
> > Giving both pointers
> > to the syncookie helper saves us from doing that work twice.
> >
> > > the helper can compute tcp header and can take into account variable length ipv4 hdr
> > > while checking that resulting ptr is within 'iph + len' validated by the verifier.
> >
> > I guess you're thinking of a use case where ip and tcp are not already
> > parsed in eBPF, like checking
> > tcp_check_syncookie(skb->sk, ...)?
> >
> > For IPv4 this seems straightforward, but for IPv6 I need to skip
> > extension headers.
> > ipv6_skip_exthdr requires an sk_buff, which isn't available when
> > calling from an XDP context.
> > Neither creating an sk_buff ad-hoc, nor duplicating ipv6_skip_exthdr
> > are particularly appealing.
> >
> > Even if I have an skb context, I need to be able to specify at which offset in
> > the skb the TCP/IP header starts, since we're using FoU encapsulation.
> > In this case I also can't
> > use skb->sk, but have to do skc_lookup_tcp, which requires demuxing
> > again (to get a socket tuple).
> > If the helper only takes a single pointer + length, that work is done twice.
> >
> > I think there is a tension here between integrating well with
> > bpf_sock_tuple based APIs and
> > using skb->sk directly. My best attempt at fixing this is
> >
> > bpf_tcp_check_syncookie(struct sock * sk, void *tcpiph,
> >          u32 tcpiph_len, u32 th_off, u64 flags)
> >
> > Where th_off is < tcpiph_len and gives the offset of the tcp header in tcpiph.
> > But using that API seems even more cumbersome? It still requires demux in eBPF
> > and figuring out th_off isn't very natural. It might be possible to
> > allow th_off to be
> > 0 to invoke ipv6_skip_exthdr machinery if there is a way around sk_buff.
> >
> > Alternatively:
> >
> > bpf_tcp_check_syncookie(void *ctx, u32 iph_offset, struct sock * sk, u64 flags)
> >
> > No idea whether this is feasible from XDP (due to sk_buff), and forces
> > duplicate work.
> > It would allow bpf_tcp_check_syncookie(skb, 0, NULL, 0) for checking skb
> > against it skb->skb, which seems nice, but I'm not sure whether it's
> > actually useful.
> >
> > > Last patch example is buggy in that sense, since it's doing:
> > > tcph = data + sizeof(struct ethhdr) + sizeof(struct iphdr);
> >
> > Oops!
> >
> > >
> > > If we drop two args then there will be room for 'flags'.
> > > It can be used for example to indicate whether LINUX_MIB_SYNCOOKIESFAILED
> > > should be incremented or not.
> > > May be it shold be unconditionally?
> >
> > No, I think that is only the right thing to do do if a) the packet is
> > destined for the local machine
> > and b) is dropped by BPF as a result of doing the check (otherwise
> > we'd double count).
> >
> > For us, a) isn't necessarily true. For others, knowing to drop in case
> > b) to avoid double counting
> > seems harder than just letting the packet continue up the stack? I
> > guess I'm not exactly clear what
> > the use case could be.
> >
> > I agree that having flags would be good though.
>
> Ok. All makes sense.
>
> Was thinking that something like this should be possible:
> BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph,
>         struct tcphdr *, th, u32, th_len, u64, flags)
> and the helper would need to check that th - iph > sizeof(iphdr)
> but that requires some non-trivial verifier hacks.
>
> So please resubmit as-is.
> It doesn't apply cleanly yet.

Sorry about this. It requires Martin KaFai Lau's fix for the
bpf_tcp_sock reference
tracking, since it depends on sk_release on PTR_TO_SOCK_COMMON. How do I fix
this for bpf-next?

>
> > > > +#if IS_BUILTIN(CONFIG_IPV6)
> > > > +     case AF_INET6:
> > > > +             if (unlikely(iph_len < sizeof(struct ipv6hdr)))
> > > > +                     return -EINVAL;
> > > > +
> > > > +             ret = __cookie_v6_check((struct ipv6hdr *)iph, th, cookie);
> > >
> > > I guess this is fast path and you don't want indirect call via ipv6_bpf_stub ?
> > >
> >
> > We run this on all inbound eyeball traffic, so yes. What is the
> > benefit of going via ipv6_bpf_stub?
>
> to keep this helper working when ipv6 is a module,
> but I very much prefer to kill ipv6-as-module option,
> so IS_BUILTIN(CONFIG_IPV6) is fine to me.
>


-- 
Lorenz Bauer  |  Systems Engineer
25 Lavington St., London SE1 0NZ

www.cloudflare.com
