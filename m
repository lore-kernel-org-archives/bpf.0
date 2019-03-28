Return-Path: <SRS0=idkB=R7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748D1C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 03:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3036A2075E
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 03:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2fvqQMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfC1DcS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:32:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45977 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfC1DcS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 23:32:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so9826547pfi.12;
        Wed, 27 Mar 2019 20:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IcC12n0xT5+vA/Tbeu5mkJ5J4S5SI5uzpAwZur836QE=;
        b=C2fvqQMprT31CTJ1Na+DlLtFnEhGuhYKw+hn1ptV8KoHuEAsUCBc5/w0/LKunxyf8h
         tI0+G8leqOfz3Gar/dWhjKkqkEPnH6bWvOXcvIv4WAMI+S3UbqNsXTKK+tYn4Z7FKL38
         e0SmDnvpdI2zBVO7HUHbrlEU28JmzrlxZlrPaXiRxdzCQqTJE4EjuQfYyZ4nvKRDwQ0Z
         cRgVq1CK1K38Qt0zjnZUBNjq9UVuVTipELN+U7/5UAaDreEt/HRlEb/9pEP91EpaUAC/
         2h7qYgVoHa88uQSNXi1OzNUXMyUP8gzjpdfptC73SNg/5BTM+Tcq4mnVv3g62Ln1M/vm
         5lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IcC12n0xT5+vA/Tbeu5mkJ5J4S5SI5uzpAwZur836QE=;
        b=sCJylh5WttB8phI2q9aDEKj4O0dYT7UmjJTw5udMMhtSk7ktLYPmpt4v3KHSxHoU0l
         fi1qcZyYoyjfjGqp/ALaJ3LZ1tlRpCQAuk/5t/LoS+Cvd6QkeocPnFD8AsruX0gOEDrq
         DG4UbOnqCOxTyTvxltKdLjPzMnATyKRKjcXxSTTz87xzUEaPYujzUMnBCf1dLz4tLM/U
         v16sc3+2/mFJIyyUlR2d3IdBUOcCcUvvdLpyIwfY08v/gE5AGkNUirIczPYhpTx6nJtS
         aaR1XqFEIE7mpMoLf3XHvqJm/kbU/wcSzJZPZj2m8V3IP5os4prqFX6Jsu4iPQrtNboa
         0KOg==
X-Gm-Message-State: APjAAAX8f2UohjhnECfVWY3d1mgJXMVuve7vGg3tW09pBEAW+wr4XPEC
        Vd/pw4Z+BV4D+h5nWJDuoO0=
X-Google-Smtp-Source: APXvYqy63ptCrs1mM+IGjVM0QyzouPB2QII+htaluAHiidqXpeI0lAF9L0q3xpCMmNa6slGhOLDoDA==
X-Received: by 2002:a63:c149:: with SMTP id p9mr36824592pgi.362.1553743937549;
        Wed, 27 Mar 2019 20:32:17 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::27f1])
        by smtp.gmail.com with ESMTPSA id h4sm21646802pfo.119.2019.03.27.20.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 20:32:16 -0700 (PDT)
Date:   Wed, 27 Mar 2019 20:32:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Stanislav Fomichev <sdf@fomichev.me>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190328033212.hmhmnvksxfyaxmm4@ast-mbp>
References: <CAADnVQLiGZv=PzqFd=9f02spzo-vibrKBM7kRpTp29L=FeeooQ@mail.gmail.com>
 <20190326181719.GC7431@mini-arch.hsd1.ca.comcast.net>
 <20190326183011.jly4j3s332yohrj5@ast-mbp>
 <20190326185456.GD7431@mini-arch.hsd1.ca.comcast.net>
 <20190327014121.p45cblrgqgdyiu6z@ast-mbp>
 <20190327024421.GE7431@mini-arch.hsd1.ca.comcast.net>
 <20190327175535.ewpc6a7gpfoxmxys@ast-mbp>
 <20190327195820.GF7431@mini-arch.hsd1.ca.comcast.net>
 <20190328012616.exa6q7brzxvcqvnz@ast-mbp>
 <CAF=yD-KkurbKskd=7XpZDG8K0T9pj-Pv-Bsi+u1RubTF6_tHcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-KkurbKskd=7XpZDG8K0T9pj-Pv-Bsi+u1RubTF6_tHcQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 27, 2019 at 11:14:46PM -0400, Willem de Bruijn wrote:
> On Wed, Mar 27, 2019 at 9:26 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Mar 27, 2019 at 12:58:20PM -0700, Stanislav Fomichev wrote:
> > > On 03/27, Alexei Starovoitov wrote:
> > > > On Tue, Mar 26, 2019 at 07:44:21PM -0700, Stanislav Fomichev wrote:
> > > > > On 03/26, Alexei Starovoitov wrote:
> > > > > > On Tue, Mar 26, 2019 at 11:54:56AM -0700, Stanislav Fomichev wrote:
> > > > > > > On 03/26, Alexei Starovoitov wrote:
> > > > > > > > On Tue, Mar 26, 2019 at 11:17:19AM -0700, Stanislav Fomichev wrote:
> > > > > > > > > On 03/26, Alexei Starovoitov wrote:
> > > > > > > > > > On Tue, Mar 26, 2019 at 10:52 AM Willem de Bruijn
> > > > > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > > > > > The BPF flow dissector should work the same. It is fine to pass the
> > > > > > > > > > > data including ethernet header, but parsing can start at nhoff with
> > > > > > > > > > > proto explicitly passed.
> > > > > > > > > > >
> > > > > > > > > > > We should not assume Ethernet link layer.
> > > > > > > > > >
> > > > > > > > > > then skb-less dissector has to be different program type
> > > > > > > > > > because semantics are different.
> > > > > > > > > The semantics are the same as for c-based __skb_flow_dissect.
> > > > > > > > > We just need to pass nhoff and proto that has been passed to
> > > > > > > > > __skb_flow_dissect to the bpf program. In case of with-skb,
> > > > > > > > > take this initial data from skb, like __skb_flow_dissect does (and don't
> > > > > > > > > ask BPF program to do it essentially):
> > > > > > > > >
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n763
> > > > > > > > >
> > > > > > > > > I was thinking of passing proto as flow_keys->n_proto and we already
> > > > > > > > > pass flow_keys->nhoff, so no need to do anything for it. With that,
> > > > > > > > > BPF program doesn't need to look into skb and can parse optional vlan
> > > > > > > > > and L3+ headers. The same way __skb_flow_dissect does that.
> > > > > > > >
> > > > > > > > makes sense. then I'd also prefer for proto to be in flow_keys to
> > > > > > > > high light this difference.
> > > > > > > Maybe rename existing flow_keys->n_proto to flow_keys->proto?
> > > > > > > That would match __skb_flow_dissect and remove ambiguity with both proto
> > > > > > > and n_proto in flow_keys.
> > > > > >
> > > > > > disabling useless fields in ctx is one thing, since probability of breaking users
> > > > > > is low, but renaming n_proto is imo too much.
> > > > > >
> > > > > > > > may be add vlan_proto/present/tci there as well?
> > > > > > > > At least on the kernel side ctx rewriter will be the same for w/ & w/o skb cases.
> > > > > > > Why do you think we need them? My understanding was that when
> > > > > > > skb_vlan_tag_present(skb) (or skb->vlan_present) returns true, that means
> > > > > > > that vlan info has been already parsed out of the packet and stored in
> > > > > > > the vlan_tci/vlan_proto (where vlan_proto is 8021Q/8021AD); skb data
> > > > > > > points to proper L3 header.
> > > > > > >
> > > > > > > If that's correct, BPF flow dissector should not care about that. For
> > > > > > > example, look at how C-based flow dissector does that:
> > > > > > >
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n944
> > > > > > >
> > > > > > > If skb_vlan_tag_present(skb) returns true, we set proto to skb->protocol
> > > > > > > and move on.
> > > > > > >
> > > > > > > But, we would need vlan_proto/present/tci in the flow_keys in the future.
> > > > > > > We don't currently return parsed vlan data from the BPF flow dissector.
> > > > > > > But it feels like it's getting into bpf-next territory :-)
> > > > > >
> > > > > > Whether ctx->data points to L2 or L3 is uapi regardless whether
> > > > > > progs/bpf_flow.c is relying on that or not.
> > > > > > So far I think you're saying that in all three cases:
> > > > > > no-skb, skb befor rfs, skb after rfs ctx->data points to L2, right?
> > > > > > This has to be preserved.
> > > > > It points to L3 (or vlan). And this will be preserved, I have no
> > > > > intention to change that.
> > > > >
> > > > > Just to make sure, we are on the same page, here is what
> > > > > __skb_flow_dissect (and BPF prog) is seeing in nhoff.
> > > > >
> > > > > NO-VLAN is always the same for both with-skb/no-skb:
> > > > > +----+----+-----+--+
> > > > > |DMAC|SMAC|PROTO|L3|
> > > > > +----+----+-----+--+
> > > > >                  ^
> > > > >                  +-- nhoff
> > > > >                      proto = PROTO
> > > > >
> > > > > VLAN no-skb (eth_get_headlen):
> > > > > +----+----+----+---+-----+--+
> > > > > |DMAC|SMAC|TPID|TCI|PROTO|L3|
> > > > > +----+----+----+---+-----+--+
> > > > >                 ^
> > > > >                 +-- nhoff
> > > > >                     proto = TPID
> > > >
> > > > where ctx->data will point to ?
> > > > These nhoff differences are fine.
> > > > I want to make sure that ctx->data is the same for all.
> > > For with-skb, nhoff would be zero, and ctx->data would point to
> > > TCI/L3.
> > > For skb-less, ctx->data would point to L2 (DMAC), and nhoff would be
> > > non-zero (TCI/L3 offset).
> > >
> > > If you want, for skb-less case, when calling BPF program we can do the math
> > > ourselves and set ctx->data to data + nhoff, and pass nhoff = 0.
> > > But I'm not sure whether we need to do that; flow dissector is supposed
> > > to look at ctx->data + nhoff, it should not matter what each individual
> > > value is, they only make sense together.
> >
> > My strong preference is to have data to point to L2 in all cases.
> > Semantics of requiring bpf prog to start processing from a tuple
> > (data + nhoff) where both point to random places is very confusing.
> 
> Since flow dissection starts at the network layer, I would then
> suggest data always at L3 and nhoff 0.
> 
> This can be derived in the same manner as __skb_flow_dissect
> already does if !data, using only skb_network_offset.
> 
> From a quick scan, skb_mac_offset should also be valid in all cases
> where the flow dissector is called today, so the other can be computed, too.
> 
> But this is less obvious. For instance, tun_get_user calls into the flow
> dissector up to three times (wow) and IFF_TUN has no link layer
> (ARPHRD_NONE). And then there are also fun variable length link layer
> protocols to deal with..

ahh. ok. Can we guarantee some stable position?
Current bpf_flow_dissect_get_header assumes that
ctx->data + ctx->flow_keys->thoff point to IP, right?
Based on what Stanislav saying above even that is not a guarantee?
I'm struggling to see how users can wrap their heads around this.
It seems bpf_flow.c will become the only prog that can deal with
this range of possible inputs.

I propose to start with the doc that describes all cases, where
things point to and how prog suppose to parse that.


