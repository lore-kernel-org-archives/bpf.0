Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8334C10F05
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 02:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4C3218B0
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 02:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CVq1CQBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfCUCJX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:09:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38117 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfCUCJX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 22:09:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id w137so3524754oiw.5
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 19:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIP94NqwMrRfOFAiU37QPX/RHUC8e8YxVKPHxxfPTfA=;
        b=CVq1CQBW1exOXWj0kCtlcoDv1A4JkzIm6Gii1d1+L05YnDxay+AbRbISybN4mPAi71
         Iw2i1ViZDjdZvl4uGH4mCr99BsVIhlnzdznaN14Gd4UIqYz+mMTJpQB9OiYOCCDSNWqD
         6aq1pjtbkdKs+dPr0O8EBSVFZ2Mzavz1lHWB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIP94NqwMrRfOFAiU37QPX/RHUC8e8YxVKPHxxfPTfA=;
        b=VMvxFudK00kQhx1MIaHSX5LNjLRkB218kTBbJTtqXlJ6gSMlj3eSkNeKQN2gRe90/X
         yEP2tn5S9z9Sb5Bqtv/E7U4VfqakEUc0wbrjucvIUWLhoSHiLuzAV12U80qz3EPSvU9i
         aLi+TaZw6RkHt/gXMBtoCISpFxmjGvzYID3yJkKjU82RII/Vu5JtZky883sh4zGq2emR
         noRT2lNyOoyEnRf275Plkt+Uuog9Jmtum4d4B71RmwD57S9chiMbPSXfHlzosaoyjV5t
         vZli/gW+k6YiGNU4eBF0KbKzrh3kxejLYHaQpJxp/zg+qlVABIov2DlzgZA0SsTRYasy
         iGpA==
X-Gm-Message-State: APjAAAUbfq/ZEHnCzHnErTolJzdzrkNzY8pRtxV6KIoM0zpRjoOXB9CQ
        5g5hs3KVJ5vOrFQJHTAFKMM/n7lOtwRFIWrC2MvN+w==
X-Google-Smtp-Source: APXvYqxav4V2iKYSQq3RlVdQWJfyC1st2mQcL+pjKAhjCXmJm3mYQLCTMtYj81s+5jSWAhEy/XcyxnKBF88zFmrl2e8=
X-Received: by 2002:aca:d482:: with SMTP id l124mr686081oig.102.1553134162308;
 Wed, 20 Mar 2019 19:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190222095057.9442-1-lmb@cloudflare.com> <20190319102103.7380-1-lmb@cloudflare.com>
 <20190319102103.7380-5-lmb@cloudflare.com> <20190319221735.ycueci4ec4rvbkxf@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190319221735.ycueci4ec4rvbkxf@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 21 Mar 2019 02:09:08 +0000
Message-ID: <CACAyw9_euySi4LWWD-789DdY-XYgMNLaNY+RrhJieoY7r0qcwQ@mail.gmail.com>
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

On Tue, 19 Mar 2019 at 22:17, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 19, 2019 at 10:20:59AM +0000, Lorenz Bauer wrote:
> > Using bpf_skc_lookup_tcp it's possible to ascertain whether a packet
> > belongs to a known connection. However, there is one corner case: no
> > sockets are created if SYN cookies are active. This means that the final
> > ACK in the 3WHS is misclassified.
> >
> > Using the helper, we can look up the listening socket via
> > bpf_skc_lookup_tcp and then check whether a packet is a valid SYN
> > cookie ACK.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >  include/uapi/linux/bpf.h | 18 +++++++++-
> >  net/core/filter.c        | 72 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 89 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 8e4f8276942a..587d7a3295bf 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -2391,6 +2391,21 @@ union bpf_attr {
> >   *           Pointer to **struct bpf_sock**, or **NULL** in case of failure.
> >   *           For sockets with reuseport option, the **struct bpf_sock**
> >   *           result is from **reuse->socks**\ [] using the hash of the tuple.
> > + *
> > + * int bpf_tcp_check_syncookie(struct bpf_sock *sk, void *iph, u32 iph_len, struct tcphdr *th, u32 th_len)
> > + *   Description
> > + *           Check whether iph and th contain a valid SYN cookie ACK for
> > + *           the listening socket in sk.
> > + *
> > + *           iph points to the start of the IPv4 or IPv6 header, while
> > + *           iph_len contains sizeof(struct iphdr) or sizeof(struct ip6hdr).
> > + *
> > + *           th points to the start of the TCP header, while th_len contains
> > + *           sizeof(struct tcphdr).
> > + *
> > + *   Return
> > + *           0 if iph and th are a valid SYN cookie ACK, or a negative error
> > + *           otherwise.
> >   */
> >  #define __BPF_FUNC_MAPPER(FN)                \
> >       FN(unspec),                     \
> > @@ -2492,7 +2507,8 @@ union bpf_attr {
> >       FN(tcp_sock),                   \
> >       FN(skb_ecn_set_ce),             \
> >       FN(get_listener_sock),          \
> > -     FN(skc_lookup_tcp),
> > +     FN(skc_lookup_tcp),             \
> > +     FN(tcp_check_syncookie),
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> >   * function eBPF program intends to call
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index f5210773cfd8..45a46fbe4ee0 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5546,6 +5546,74 @@ static const struct bpf_func_proto bpf_skb_ecn_set_ce_proto = {
> >       .ret_type       = RET_INTEGER,
> >       .arg1_type      = ARG_PTR_TO_CTX,
> >  };
> > +
> > +BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
> > +        struct tcphdr *, th, u32, th_len)
>
> what was the reason to pass ip and tcp header pointers separately?
> Why not to pass 'void* iph' with len long enough to cover both?

Our use case is to look at Foo-over-UDP encapsulated packets before they are
decapsulated, and if necessary forward them to another machine.
Essentially a bit
of BPF which either XDP_PASSes when we find that a packet belongs to a known
connection, or XDP_TX if it doesn't.

This means we already have to have both ip and tcp header parsed,
otherwise it can't get a reference to a socket via bpf_skc_lookup_tcp.
Giving both pointers
to the syncookie helper saves us from doing that work twice.

> the helper can compute tcp header and can take into account variable length ipv4 hdr
> while checking that resulting ptr is within 'iph + len' validated by the verifier.

I guess you're thinking of a use case where ip and tcp are not already
parsed in eBPF, like checking
tcp_check_syncookie(skb->sk, ...)?

For IPv4 this seems straightforward, but for IPv6 I need to skip
extension headers.
ipv6_skip_exthdr requires an sk_buff, which isn't available when
calling from an XDP context.
Neither creating an sk_buff ad-hoc, nor duplicating ipv6_skip_exthdr
are particularly appealing.

Even if I have an skb context, I need to be able to specify at which offset in
the skb the TCP/IP header starts, since we're using FoU encapsulation.
In this case I also can't
use skb->sk, but have to do skc_lookup_tcp, which requires demuxing
again (to get a socket tuple).
If the helper only takes a single pointer + length, that work is done twice.

I think there is a tension here between integrating well with
bpf_sock_tuple based APIs and
using skb->sk directly. My best attempt at fixing this is

bpf_tcp_check_syncookie(struct sock * sk, void *tcpiph,
         u32 tcpiph_len, u32 th_off, u64 flags)

Where th_off is < tcpiph_len and gives the offset of the tcp header in tcpiph.
But using that API seems even more cumbersome? It still requires demux in eBPF
and figuring out th_off isn't very natural. It might be possible to
allow th_off to be
0 to invoke ipv6_skip_exthdr machinery if there is a way around sk_buff.

Alternatively:

bpf_tcp_check_syncookie(void *ctx, u32 iph_offset, struct sock * sk, u64 flags)

No idea whether this is feasible from XDP (due to sk_buff), and forces
duplicate work.
It would allow bpf_tcp_check_syncookie(skb, 0, NULL, 0) for checking skb
against it skb->skb, which seems nice, but I'm not sure whether it's
actually useful.

> Last patch example is buggy in that sense, since it's doing:
> tcph = data + sizeof(struct ethhdr) + sizeof(struct iphdr);

Oops!

>
> If we drop two args then there will be room for 'flags'.
> It can be used for example to indicate whether LINUX_MIB_SYNCOOKIESFAILED
> should be incremented or not.
> May be it shold be unconditionally?

No, I think that is only the right thing to do do if a) the packet is
destined for the local machine
and b) is dropped by BPF as a result of doing the check (otherwise
we'd double count).

For us, a) isn't necessarily true. For others, knowing to drop in case
b) to avoid double counting
seems harder than just letting the packet continue up the stack? I
guess I'm not exactly clear what
the use case could be.

I agree that having flags would be good though.

>
> > +{
> > +#ifdef CONFIG_SYN_COOKIES
> > +     u32 cookie;
> > +     int ret;
> > +
> > +     if (unlikely(th_len < sizeof(*th)))
> > +             return -EINVAL;
> > +
> > +     /* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
> > +     if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
> > +             return -EINVAL;
> > +
> > +     if (!sock_net(sk)->ipv4.sysctl_tcp_syncookies)
> > +             return -EINVAL;
> > +
> > +     if (!th->ack || th->rst || th->syn)
> > +             return -ENOENT;
> > +
> > +     if (tcp_synq_no_recent_overflow(sk))
> > +             return -ENOENT;
> > +
> > +     cookie = ntohl(th->ack_seq) - 1;
> > +
> > +     switch (sk->sk_family) {
> > +     case AF_INET:
> > +             if (unlikely(iph_len < sizeof(struct iphdr)))
> > +                     return -EINVAL;
> > +
> > +             ret = __cookie_v4_check((struct iphdr *)iph, th, cookie);
> > +             break;
> > +
> > +#if IS_BUILTIN(CONFIG_IPV6)
> > +     case AF_INET6:
> > +             if (unlikely(iph_len < sizeof(struct ipv6hdr)))
> > +                     return -EINVAL;
> > +
> > +             ret = __cookie_v6_check((struct ipv6hdr *)iph, th, cookie);
>
> I guess this is fast path and you don't want indirect call via ipv6_bpf_stub ?
>

We run this on all inbound eyeball traffic, so yes. What is the
benefit of going via ipv6_bpf_stub?

-- 
Lorenz Bauer  |  Systems Engineer
25 Lavington St., London SE1 0NZ

www.cloudflare.com
