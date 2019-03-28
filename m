Return-Path: <SRS0=idkB=R7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC8C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9129C204EC
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 12:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey3by4aH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbfC1M6l (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:58:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34917 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1M6l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Mar 2019 08:58:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id s39so11619892edb.2;
        Thu, 28 Mar 2019 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sx8Dsd9dPARNonl7xflRJe+Pe/j9FB03q9WhPpzh5gw=;
        b=Ey3by4aHxupLX0ENmg8YF70S4iH+JIVpqnjnV4+XOZhaO5HGiUiYr2eqYJ9idY9sZV
         FxMSAjVc6lgewCJPg5qVdYq4j82ygHMcbgigddXgNxYJpd/+de5M3bTDWbNgcmwLi0y9
         kh4avjiy7wYePqrWqvnEE9AEkK+uDlq4cnoQtvjytV68UqMhSt9mjNy0oHAjTRVgzj8S
         wXnfVzwGpx2smRl7PlwpqYvjynp8ABNWOKK4BKTPN3OyOL4y9QU20IvxZWQR0CqHcc6X
         FN/k3D5P3B5XHo58e59barAZ2AF8zeAVQnqPszxJUE8w/bQuhmzS3uB8wqbknMXvOqKn
         RyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sx8Dsd9dPARNonl7xflRJe+Pe/j9FB03q9WhPpzh5gw=;
        b=tHo9V/RoDWiU+Bx+Mhf72hShheTuavr1KwaWyHcbMVGC7X8QAHvt6jEOYV33RaRc2A
         tDO2S3EVLM2aW6oPK2izerSZ9rTevUL8CahnkBdbeaRKSMVYoM+qzA2EMhElASuOAV7c
         sM3uk6+acOeBoBDzqcBT4uAQ70mgi+E4omX6nqWQzK/3zI7ksmHhS50F9bNW2STb9Y/+
         wFFfM93Qdni+R8IAz8fxoEpEO3Pl2rwRctA0OqHoDamX26fzG6EBDB9cCzEVrwStvsT4
         ZtVNp5ZVOTGMdB1IsXvrmpzRkbJhK+lqqedcmR3u7aYskYN7frte3vnJX3pk6u9t5zjA
         p9MQ==
X-Gm-Message-State: APjAAAWKG/buBAUoQq/fKOo3h4UE/RDyMuw4s/biOEqVTeNw/lw60W/1
        xDRqOGCJswx+ZLJw6/EZCnMoYA+6Le48ltZ82+4=
X-Google-Smtp-Source: APXvYqwVKn2N4EVAgzmN1fIoZJigpv0gnkJuRnDET574eJHoY0Nf5UNwUt1Kii6B78IOuCKEYYEj+HOHWXI14r5k/Uo=
X-Received: by 2002:a17:906:2501:: with SMTP id i1mr23073249ejb.76.1553777918470;
 Thu, 28 Mar 2019 05:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190326181719.GC7431@mini-arch.hsd1.ca.comcast.net>
 <20190326183011.jly4j3s332yohrj5@ast-mbp> <20190326185456.GD7431@mini-arch.hsd1.ca.comcast.net>
 <20190327014121.p45cblrgqgdyiu6z@ast-mbp> <20190327024421.GE7431@mini-arch.hsd1.ca.comcast.net>
 <20190327175535.ewpc6a7gpfoxmxys@ast-mbp> <20190327195820.GF7431@mini-arch.hsd1.ca.comcast.net>
 <20190328012616.exa6q7brzxvcqvnz@ast-mbp> <CAF=yD-KkurbKskd=7XpZDG8K0T9pj-Pv-Bsi+u1RubTF6_tHcQ@mail.gmail.com>
 <20190328033212.hmhmnvksxfyaxmm4@ast-mbp> <20190328041715.GG7431@mini-arch.hsd1.ca.comcast.net>
In-Reply-To: <20190328041715.GG7431@mini-arch.hsd1.ca.comcast.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 28 Mar 2019 08:58:02 -0400
Message-ID: <CAF=yD-KG8xaP+VMAXcAYKnbJOtuLmF7yibnetJfws94bQZvmVQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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

> > > > > > > > > If skb_vlan_tag_present(skb) returns true, we set proto to skb->protocol
> > > > > > > > > and move on.
> > > > > > > > >
> > > > > > > > > But, we would need vlan_proto/present/tci in the flow_keys in the future.
> > > > > > > > > We don't currently return parsed vlan data from the BPF flow dissector.
> > > > > > > > > But it feels like it's getting into bpf-next territory :-)
> > > > > > > >
> > > > > > > > Whether ctx->data points to L2 or L3 is uapi regardless whether
> > > > > > > > progs/bpf_flow.c is relying on that or not.
> > > > > > > > So far I think you're saying that in all three cases:
> > > > > > > > no-skb, skb befor rfs, skb after rfs ctx->data points to L2, right?
> > > > > > > > This has to be preserved.
> > > > > > > It points to L3 (or vlan). And this will be preserved, I have no
> > > > > > > intention to change that.
> > > > > > >
> > > > > > > Just to make sure, we are on the same page, here is what
> > > > > > > __skb_flow_dissect (and BPF prog) is seeing in nhoff.
> > > > > > >
> > > > > > > NO-VLAN is always the same for both with-skb/no-skb:
> > > > > > > +----+----+-----+--+
> > > > > > > |DMAC|SMAC|PROTO|L3|
> > > > > > > +----+----+-----+--+
> > > > > > >                  ^
> > > > > > >                  +-- nhoff
> > > > > > >                      proto = PROTO
> > > > > > >
> > > > > > > VLAN no-skb (eth_get_headlen):
> > > > > > > +----+----+----+---+-----+--+
> > > > > > > |DMAC|SMAC|TPID|TCI|PROTO|L3|
> > > > > > > +----+----+----+---+-----+--+
> > > > > > >                 ^
> > > > > > >                 +-- nhoff
> > > > > > >                     proto = TPID
> > > > > >
> > > > > > where ctx->data will point to ?
> > > > > > These nhoff differences are fine.
> > > > > > I want to make sure that ctx->data is the same for all.
> > > > > For with-skb, nhoff would be zero, and ctx->data would point to
> > > > > TCI/L3.
> > > > > For skb-less, ctx->data would point to L2 (DMAC), and nhoff would be
> > > > > non-zero (TCI/L3 offset).
> > > > >
> > > > > If you want, for skb-less case, when calling BPF program we can do the math
> > > > > ourselves and set ctx->data to data + nhoff, and pass nhoff = 0.
> > > > > But I'm not sure whether we need to do that; flow dissector is supposed
> > > > > to look at ctx->data + nhoff, it should not matter what each individual
> > > > > value is, they only make sense together.
> > > >
> > > > My strong preference is to have data to point to L2 in all cases.
> > > > Semantics of requiring bpf prog to start processing from a tuple
> > > > (data + nhoff) where both point to random places is very confusing.
> > >
> > > Since flow dissection starts at the network layer, I would then
> > > suggest data always at L3 and nhoff 0.
> For eth_get_headlen we need to manually parse 802.1q header. And for RFS
> case as well (unless I'm missing something).
>
> > > This can be derived in the same manner as __skb_flow_dissect
> > > already does if !data, using only skb_network_offset.
> > >
> > > From a quick scan, skb_mac_offset should also be valid in all cases
> > > where the flow dissector is called today, so the other can be computed, too.
> > >
> > > But this is less obvious. For instance, tun_get_user calls into the flow
> > > dissector up to three times (wow) and IFF_TUN has no link layer
> > > (ARPHRD_NONE). And then there are also fun variable length link layer
> > > protocols to deal with..
> >
> > ahh. ok. Can we guarantee some stable position?
> I don't think so. Pre RFS ctx->data+nhoff can point to 802.1q header,
> post RFS it will point to L3. The only thing we can do is to have
> nhoff=0 (and adjust ctx->data accordingly) when the main bpf
> flow dissector procedure is called. But that would require bringing
> this new kernel context (bpf_flow_dissector) into bpf/stable.
> (And it's not clear what's the benefit, since tail calls would still
> have to look at that offset).

The flow dissector can be called also before and after tunneling, in
which case skb_network_offset points to an inner header. Or after
MPLS, which stumps a flow dissector called earlier as that has no
information about the encapsulated protocol.

I don't think that there should be a goal that flow dissection starts
at the same point in the packet for all callsites along the datapath.
As long as it always starts at a known ETH_P_.. type protocol header
the program should be able to parse that. That is how the non-BPF
flow dissector works.

> > Current bpf_flow_dissect_get_header assumes that
> > ctx->data + ctx->flow_keys->thoff point to IP, right?
> Yes, mostly, except that if skb->protocol is 802.1q/ad, it's 802.1q header.
> And it's only for the "main" call; bpf program adjusts this thoff
> to make sure that tail calls preserve some sense of progress (so it
> eventually points to L4 and that's what we export back).
>
> > Based on what Stanislav saying above even that is not a guarantee?
> > I'm struggling to see how users can wrap their heads around this.
> > It seems bpf_flow.c will become the only prog that can deal with
> > this range of possible inputs.
> >
> > I propose to start with the doc that describes all cases, where
> > things point to and how prog suppose to parse that.
> Yeah, that is what I was going to propose - add a doc along with the
> patch series. I don't see how we can make it simple(r) at this point :-(

Does it have to be simpler? A flow dissector should be ready to
dissect VLAN tags. That's the only complication here?



> I can try to document everything so users don't have to read the
> kernel code to understand how to write the bpf flow dissector programs.
