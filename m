Return-Path: <SRS0=idkB=R7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27BEC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 03:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74DD206C0
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 03:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjlQw7ZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfC1DP1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:15:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35509 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfC1DPZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 23:15:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id s39so10413903edb.2;
        Wed, 27 Mar 2019 20:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0Mv1zLNcMTLDGNpEPgY/gozwdF5oeAVhl72SRoZlmk=;
        b=YjlQw7ZOx43oq/jhhPPt4XDVlXBwgeS1NbOTDLJL8OYtbV/LmzmhgtUJTgHKljXp62
         Lpfc0PFyqgwL1RGRYGs1ROj2/80oxB+cCr+jnRyeV1+gZCB1Nd02YXS+MSWf++OYe8/+
         eR3/3QnbQ5j5/1BzaakYlzPSpToK5z7nNFLmgv9QOMiuX4CpScPJT5Q/whPmXV6wYYn7
         ygijGvfbeQGLBSyTgzRhfRd76uAuvk9s1bTJF65ts8fuCShAbcm2XWjxkUS/kp8X8kpM
         AhM1EBrhBxsRQLiVuGpfq8Sv34bdt8WJ58hLJDPjpRkE/zPPPKTP0B12vq3bim5obLOR
         dcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0Mv1zLNcMTLDGNpEPgY/gozwdF5oeAVhl72SRoZlmk=;
        b=N7z87rCJvujxh5ZGckeQuzJaJZG1lDI/EprZM/7ComPzWiTW0mpbD1QogNJD1XhMmz
         sGizN7sUMKhCLxVWR2kT3G88cmTYGU97KtV+NZBX8whB817TzI1g9urffEb98S3MlSgM
         3AIsalzSaaoWI5E4urvT1Bv3Erb50UhxqV/QKY7R46a98Gi1IJhDBoIJDMoD1HpX5pAa
         vxzNWV1mBbLC8Z/A1qy0G5f+vbrTxE+ALSuaYGZSRTZS0Bkrgtf7PXbBF7Lo8mkCR/5y
         JhL9R60kNLbQjR9EQGOBMZEJdQnPNT9+U+3hu+LCOdHSTp0PEE+WrPcHsYqUzN0PCGLl
         flCw==
X-Gm-Message-State: APjAAAXAmlbeVxp7MeZAS3HQFeGAtuM/+JK1yBFcmruFr3zduuTp1mfY
        8m50qFE9raXapUYHUzRTymBa1aPMf8R1i+1x8vo=
X-Google-Smtp-Source: APXvYqw+G8UZf3oq2DI76Z1wT4BvcUSw/PoVY8+9V7Gsq9uEZl/0C/9h5ksiw90/iOxc8zn4C7Z/Cn3lyINM2iAe8mU=
X-Received: by 2002:a50:86c3:: with SMTP id 3mr26485685edu.143.1553742922250;
 Wed, 27 Mar 2019 20:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190326174802.jnhvtdephykfj6ku@ast-mbp> <CAF=yD-KzG1E0kL3s4TfYX+T8Bc3VeZw9siKK8iDHAN1uyYDyLA@mail.gmail.com>
 <CAADnVQLiGZv=PzqFd=9f02spzo-vibrKBM7kRpTp29L=FeeooQ@mail.gmail.com>
 <20190326181719.GC7431@mini-arch.hsd1.ca.comcast.net> <20190326183011.jly4j3s332yohrj5@ast-mbp>
 <20190326185456.GD7431@mini-arch.hsd1.ca.comcast.net> <20190327014121.p45cblrgqgdyiu6z@ast-mbp>
 <20190327024421.GE7431@mini-arch.hsd1.ca.comcast.net> <20190327175535.ewpc6a7gpfoxmxys@ast-mbp>
 <20190327195820.GF7431@mini-arch.hsd1.ca.comcast.net> <20190328012616.exa6q7brzxvcqvnz@ast-mbp>
In-Reply-To: <20190328012616.exa6q7brzxvcqvnz@ast-mbp>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 27 Mar 2019 23:14:46 -0400
Message-ID: <CAF=yD-KkurbKskd=7XpZDG8K0T9pj-Pv-Bsi+u1RubTF6_tHcQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@fomichev.me>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 27, 2019 at 9:26 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 27, 2019 at 12:58:20PM -0700, Stanislav Fomichev wrote:
> > On 03/27, Alexei Starovoitov wrote:
> > > On Tue, Mar 26, 2019 at 07:44:21PM -0700, Stanislav Fomichev wrote:
> > > > On 03/26, Alexei Starovoitov wrote:
> > > > > On Tue, Mar 26, 2019 at 11:54:56AM -0700, Stanislav Fomichev wrote:
> > > > > > On 03/26, Alexei Starovoitov wrote:
> > > > > > > On Tue, Mar 26, 2019 at 11:17:19AM -0700, Stanislav Fomichev wrote:
> > > > > > > > On 03/26, Alexei Starovoitov wrote:
> > > > > > > > > On Tue, Mar 26, 2019 at 10:52 AM Willem de Bruijn
> > > > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > > > > The BPF flow dissector should work the same. It is fine to pass the
> > > > > > > > > > data including ethernet header, but parsing can start at nhoff with
> > > > > > > > > > proto explicitly passed.
> > > > > > > > > >
> > > > > > > > > > We should not assume Ethernet link layer.
> > > > > > > > >
> > > > > > > > > then skb-less dissector has to be different program type
> > > > > > > > > because semantics are different.
> > > > > > > > The semantics are the same as for c-based __skb_flow_dissect.
> > > > > > > > We just need to pass nhoff and proto that has been passed to
> > > > > > > > __skb_flow_dissect to the bpf program. In case of with-skb,
> > > > > > > > take this initial data from skb, like __skb_flow_dissect does (and don't
> > > > > > > > ask BPF program to do it essentially):
> > > > > > > >
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n763
> > > > > > > >
> > > > > > > > I was thinking of passing proto as flow_keys->n_proto and we already
> > > > > > > > pass flow_keys->nhoff, so no need to do anything for it. With that,
> > > > > > > > BPF program doesn't need to look into skb and can parse optional vlan
> > > > > > > > and L3+ headers. The same way __skb_flow_dissect does that.
> > > > > > >
> > > > > > > makes sense. then I'd also prefer for proto to be in flow_keys to
> > > > > > > high light this difference.
> > > > > > Maybe rename existing flow_keys->n_proto to flow_keys->proto?
> > > > > > That would match __skb_flow_dissect and remove ambiguity with both proto
> > > > > > and n_proto in flow_keys.
> > > > >
> > > > > disabling useless fields in ctx is one thing, since probability of breaking users
> > > > > is low, but renaming n_proto is imo too much.
> > > > >
> > > > > > > may be add vlan_proto/present/tci there as well?
> > > > > > > At least on the kernel side ctx rewriter will be the same for w/ & w/o skb cases.
> > > > > > Why do you think we need them? My understanding was that when
> > > > > > skb_vlan_tag_present(skb) (or skb->vlan_present) returns true, that means
> > > > > > that vlan info has been already parsed out of the packet and stored in
> > > > > > the vlan_tci/vlan_proto (where vlan_proto is 8021Q/8021AD); skb data
> > > > > > points to proper L3 header.
> > > > > >
> > > > > > If that's correct, BPF flow dissector should not care about that. For
> > > > > > example, look at how C-based flow dissector does that:
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n944
> > > > > >
> > > > > > If skb_vlan_tag_present(skb) returns true, we set proto to skb->protocol
> > > > > > and move on.
> > > > > >
> > > > > > But, we would need vlan_proto/present/tci in the flow_keys in the future.
> > > > > > We don't currently return parsed vlan data from the BPF flow dissector.
> > > > > > But it feels like it's getting into bpf-next territory :-)
> > > > >
> > > > > Whether ctx->data points to L2 or L3 is uapi regardless whether
> > > > > progs/bpf_flow.c is relying on that or not.
> > > > > So far I think you're saying that in all three cases:
> > > > > no-skb, skb befor rfs, skb after rfs ctx->data points to L2, right?
> > > > > This has to be preserved.
> > > > It points to L3 (or vlan). And this will be preserved, I have no
> > > > intention to change that.
> > > >
> > > > Just to make sure, we are on the same page, here is what
> > > > __skb_flow_dissect (and BPF prog) is seeing in nhoff.
> > > >
> > > > NO-VLAN is always the same for both with-skb/no-skb:
> > > > +----+----+-----+--+
> > > > |DMAC|SMAC|PROTO|L3|
> > > > +----+----+-----+--+
> > > >                  ^
> > > >                  +-- nhoff
> > > >                      proto = PROTO
> > > >
> > > > VLAN no-skb (eth_get_headlen):
> > > > +----+----+----+---+-----+--+
> > > > |DMAC|SMAC|TPID|TCI|PROTO|L3|
> > > > +----+----+----+---+-----+--+
> > > >                 ^
> > > >                 +-- nhoff
> > > >                     proto = TPID
> > >
> > > where ctx->data will point to ?
> > > These nhoff differences are fine.
> > > I want to make sure that ctx->data is the same for all.
> > For with-skb, nhoff would be zero, and ctx->data would point to
> > TCI/L3.
> > For skb-less, ctx->data would point to L2 (DMAC), and nhoff would be
> > non-zero (TCI/L3 offset).
> >
> > If you want, for skb-less case, when calling BPF program we can do the math
> > ourselves and set ctx->data to data + nhoff, and pass nhoff = 0.
> > But I'm not sure whether we need to do that; flow dissector is supposed
> > to look at ctx->data + nhoff, it should not matter what each individual
> > value is, they only make sense together.
>
> My strong preference is to have data to point to L2 in all cases.
> Semantics of requiring bpf prog to start processing from a tuple
> (data + nhoff) where both point to random places is very confusing.

Since flow dissection starts at the network layer, I would then
suggest data always at L3 and nhoff 0.

This can be derived in the same manner as __skb_flow_dissect
already does if !data, using only skb_network_offset.

From a quick scan, skb_mac_offset should also be valid in all cases
where the flow dissector is called today, so the other can be computed, too.

But this is less obvious. For instance, tun_get_user calls into the flow
dissector up to three times (wow) and IFF_TUN has no link layer
(ARPHRD_NONE). And then there are also fun variable length link layer
protocols to deal with..
