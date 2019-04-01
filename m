Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F29C43381
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 16:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80D520883
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 16:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="vLSDocOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfDAQaS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:30:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42862 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfDAQaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 12:30:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so4743272plb.9
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HmvzFWZlOV1Rk2EHE8enaOsod7sy/DPA37OBZhiM0bw=;
        b=vLSDocOMc5oO6GTO4Vpig44VaTbopvTvx14EAD6o/n4aMskOixql4H7AYWm2rXDsyK
         cGgL00yDqiQDHTdjxdpp/Ly/lznLWqPMdB8pFB0vw6Z574b/Cw3uQmKRzul7VdxT7rLT
         /YCeJkf5piw4Q0G/l8+rtJ5SfEcO1Xo4v25Bv2sI4ud407+CjSW7Z7wHHXDKfD81nqwQ
         1IfQwpvfu2jGMcJL1kBesN56rzoz0osYd4O7BaxGhbMPFECKqcNhp2LJVDhQkpiGhpCW
         SglDQkqQGcs9RcHgcd0LbUscXRAbIJKy11oy9kjRoLdHjjcmIFyXeP+nkapok+3GbYHA
         Uyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HmvzFWZlOV1Rk2EHE8enaOsod7sy/DPA37OBZhiM0bw=;
        b=YrVYrF3TDAu0Fys8eWTFV7wyzjfPgavQW9f4XwszcQOw5OOQXIX8sRyegw9R0mntxS
         uHQkd1Ew/agdGlFPJAvOtn2AqFYTZCijL6sXZR9YE5RJuy9AEMXigpqvlxg+1iG3t7x7
         PfEw4/L/g0XrENw75KQa4aNdWTdP0EVp3rxOU5inx6mNBzQtHgNYh8b8AENoBHmcfuPw
         w1z1rizb2zHsnjFr/DNgjL0y6nS3dlV9FJv0C9Nab12eLCH3OBTnAe4koEYI098UeKvw
         cPvlnCBfDIMaTnMGl4gM3uK3f7aN+B97XXOQgLhfPV00SVr4NWdhh13QCRofVRkpeW+/
         ShEQ==
X-Gm-Message-State: APjAAAVKhhzvv9xI0pxDzrEbos2bO6enLVhda7D+8LcO2Jyukw5YpXGA
        53LjL7H5NAWqGHg/SmtRVkWUrw==
X-Google-Smtp-Source: APXvYqy5RZQXsQaAI6PmjdHx2gnH/h1PIYo/wnWFIY5ssIZhGCVZVU/i1cPyxQ/tdgin8eFoSqxVDQ==
X-Received: by 2002:a17:902:4101:: with SMTP id e1mr66598672pld.25.1554136217162;
        Mon, 01 Apr 2019 09:30:17 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id n26sm33183912pfi.165.2019.04.01.09.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 09:30:16 -0700 (PDT)
Date:   Mon, 1 Apr 2019 09:30:15 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190401163015.GH7431@mini-arch.hsd1.ca.comcast.net>
References: <20190326185456.GD7431@mini-arch.hsd1.ca.comcast.net>
 <20190327014121.p45cblrgqgdyiu6z@ast-mbp>
 <20190327024421.GE7431@mini-arch.hsd1.ca.comcast.net>
 <20190327175535.ewpc6a7gpfoxmxys@ast-mbp>
 <20190327195820.GF7431@mini-arch.hsd1.ca.comcast.net>
 <20190328012616.exa6q7brzxvcqvnz@ast-mbp>
 <CAF=yD-KkurbKskd=7XpZDG8K0T9pj-Pv-Bsi+u1RubTF6_tHcQ@mail.gmail.com>
 <20190328033212.hmhmnvksxfyaxmm4@ast-mbp>
 <20190328041715.GG7431@mini-arch.hsd1.ca.comcast.net>
 <CAF=yD-KG8xaP+VMAXcAYKnbJOtuLmF7yibnetJfws94bQZvmVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-KG8xaP+VMAXcAYKnbJOtuLmF7yibnetJfws94bQZvmVQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/28, Willem de Bruijn wrote:
> > > > > > > > > > If skb_vlan_tag_present(skb) returns true, we set proto to skb->protocol
> > > > > > > > > > and move on.
> > > > > > > > > >
> > > > > > > > > > But, we would need vlan_proto/present/tci in the flow_keys in the future.
> > > > > > > > > > We don't currently return parsed vlan data from the BPF flow dissector.
> > > > > > > > > > But it feels like it's getting into bpf-next territory :-)
> > > > > > > > >
> > > > > > > > > Whether ctx->data points to L2 or L3 is uapi regardless whether
> > > > > > > > > progs/bpf_flow.c is relying on that or not.
> > > > > > > > > So far I think you're saying that in all three cases:
> > > > > > > > > no-skb, skb befor rfs, skb after rfs ctx->data points to L2, right?
> > > > > > > > > This has to be preserved.
> > > > > > > > It points to L3 (or vlan). And this will be preserved, I have no
> > > > > > > > intention to change that.
> > > > > > > >
> > > > > > > > Just to make sure, we are on the same page, here is what
> > > > > > > > __skb_flow_dissect (and BPF prog) is seeing in nhoff.
> > > > > > > >
> > > > > > > > NO-VLAN is always the same for both with-skb/no-skb:
> > > > > > > > +----+----+-----+--+
> > > > > > > > |DMAC|SMAC|PROTO|L3|
> > > > > > > > +----+----+-----+--+
> > > > > > > >                  ^
> > > > > > > >                  +-- nhoff
> > > > > > > >                      proto = PROTO
> > > > > > > >
> > > > > > > > VLAN no-skb (eth_get_headlen):
> > > > > > > > +----+----+----+---+-----+--+
> > > > > > > > |DMAC|SMAC|TPID|TCI|PROTO|L3|
> > > > > > > > +----+----+----+---+-----+--+
> > > > > > > >                 ^
> > > > > > > >                 +-- nhoff
> > > > > > > >                     proto = TPID
> > > > > > >
> > > > > > > where ctx->data will point to ?
> > > > > > > These nhoff differences are fine.
> > > > > > > I want to make sure that ctx->data is the same for all.
> > > > > > For with-skb, nhoff would be zero, and ctx->data would point to
> > > > > > TCI/L3.
> > > > > > For skb-less, ctx->data would point to L2 (DMAC), and nhoff would be
> > > > > > non-zero (TCI/L3 offset).
> > > > > >
> > > > > > If you want, for skb-less case, when calling BPF program we can do the math
> > > > > > ourselves and set ctx->data to data + nhoff, and pass nhoff = 0.
> > > > > > But I'm not sure whether we need to do that; flow dissector is supposed
> > > > > > to look at ctx->data + nhoff, it should not matter what each individual
> > > > > > value is, they only make sense together.
> > > > >
> > > > > My strong preference is to have data to point to L2 in all cases.
> > > > > Semantics of requiring bpf prog to start processing from a tuple
> > > > > (data + nhoff) where both point to random places is very confusing.
> > > >
> > > > Since flow dissection starts at the network layer, I would then
> > > > suggest data always at L3 and nhoff 0.
> > For eth_get_headlen we need to manually parse 802.1q header. And for RFS
> > case as well (unless I'm missing something).
> >
> > > > This can be derived in the same manner as __skb_flow_dissect
> > > > already does if !data, using only skb_network_offset.
> > > >
> > > > From a quick scan, skb_mac_offset should also be valid in all cases
> > > > where the flow dissector is called today, so the other can be computed, too.
> > > >
> > > > But this is less obvious. For instance, tun_get_user calls into the flow
> > > > dissector up to three times (wow) and IFF_TUN has no link layer
> > > > (ARPHRD_NONE). And then there are also fun variable length link layer
> > > > protocols to deal with..
> > >
> > > ahh. ok. Can we guarantee some stable position?
> > I don't think so. Pre RFS ctx->data+nhoff can point to 802.1q header,
> > post RFS it will point to L3. The only thing we can do is to have
> > nhoff=0 (and adjust ctx->data accordingly) when the main bpf
> > flow dissector procedure is called. But that would require bringing
> > this new kernel context (bpf_flow_dissector) into bpf/stable.
> > (And it's not clear what's the benefit, since tail calls would still
> > have to look at that offset).
> 
> The flow dissector can be called also before and after tunneling, in
> which case skb_network_offset points to an inner header. Or after
> MPLS, which stumps a flow dissector called earlier as that has no
> information about the encapsulated protocol.
> 
> I don't think that there should be a goal that flow dissection starts
> at the same point in the packet for all callsites along the datapath.
> As long as it always starts at a known ETH_P_.. type protocol header
> the program should be able to parse that. That is how the non-BPF
> flow dissector works.
> 
> > > Current bpf_flow_dissect_get_header assumes that
> > > ctx->data + ctx->flow_keys->thoff point to IP, right?
> > Yes, mostly, except that if skb->protocol is 802.1q/ad, it's 802.1q header.
> > And it's only for the "main" call; bpf program adjusts this thoff
> > to make sure that tail calls preserve some sense of progress (so it
> > eventually points to L4 and that's what we export back).
> >
> > > Based on what Stanislav saying above even that is not a guarantee?
> > > I'm struggling to see how users can wrap their heads around this.
> > > It seems bpf_flow.c will become the only prog that can deal with
> > > this range of possible inputs.
> > >
> > > I propose to start with the doc that describes all cases, where
> > > things point to and how prog suppose to parse that.
> > Yeah, that is what I was going to propose - add a doc along with the
> > patch series. I don't see how we can make it simple(r) at this point :-(
> 
> Does it have to be simpler? A flow dissector should be ready to
> dissect VLAN tags. That's the only complication here?
I don't see how it can be made simpler. That's the context from which
existing __skb_flow_dissect is called and that's what we have to dissect
from the BPF as well. We can try to make nhoff to be 0 when the
dissector is called, that's probably the only simplification we can
attempt to do (but, as I said previously, it requires bringing
new kernel context to bpf/stable and seems more complicated than
necessary).

Let me prepare a series for bpf/stable with the small doc describing
BPF flow dissector environment. We can continue the discussion
from there :-)

> > I can try to document everything so users don't have to read the
> > kernel code to understand how to write the bpf flow dissector programs.
