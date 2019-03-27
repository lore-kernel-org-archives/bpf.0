Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2C0C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 19:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D1221734
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 19:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="GRpTeqj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfC0T6X (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:58:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34660 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfC0T6X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 15:58:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so8833374pfd.1
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2019 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TAJVfat7VNTwoAIHoW3AnWfvcFPTiUpA2s+SxAB06x8=;
        b=GRpTeqj5vIp3AS7Uw8Siu4WWCt1ZfkbEXVf2OTDYmteBFASAO2qvphgpTmZ+eI+ACa
         lxydaWk3OdBY+OhWHYXnYJtmR6+HC1K4OOkVn7kIi2Ig5vBXXhPZg2DdP7SensAt1t1/
         t2IwjfAP+nf9OGaHiN84tuRSQp+iryiNvKsHXQldq+hg5fhUs5krExB8Qv2UvPFVOJtf
         pTvqOhM9nGc3PwAMa5DkR3Tjc+1uXs88ekYOJMFGIt5Vj0a5Fxr1qkLWl6TaVTKlFkji
         eW8OqwXXAdz4gHWFfGFAzyEZDIeGl21ZVaZVKoC0Op4d7I+jI9FDKq58xRU2m4fAtCfG
         eHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TAJVfat7VNTwoAIHoW3AnWfvcFPTiUpA2s+SxAB06x8=;
        b=Bv+ycyIt6820KWGyVTL4j3A2c+Hk7V6SvGLdl7mt0OhPhuYflLCDDfJxd+YizeBs+5
         2YQdTnGTWS4bQJpkSOp8b4o4tBPicTUEoM1XPY+gyw/2UJTQxwXHBzhbP4HSx5JT5SLG
         yBAGyaE5T7uVbQ3cz32+ZSzfEuGg1VP0NHWKZa/6fN9l7IXcFXU4ijZJSYQbiKOMx0PN
         i5g5qzrdphtuCFBDXA2OGQ78dGgLMjtjnAtDsANjOmx+M+dQgNoxF1Nf7UOsnDWyYhTC
         DUx+AWPanre2X2CmFLkM+cHj/Xa7ZOrCHqQ6e/OtZYoHv7G5YuHvmKXxnYE0g4sHw9Wu
         OCkw==
X-Gm-Message-State: APjAAAViUWH5N8pRCJ2D/XL9/wKHkw2XQxzFNWeVqC7dDYGg9iUWjclw
        ThiH9+HqWb/mpGrHzRQUIWLaDg==
X-Google-Smtp-Source: APXvYqzB8PneAyE0E6cQwNOguFWjiDCx/L89hj81c20VgPhbY1yCUSBYRduxeNYnARyvVbVPMtcnnw==
X-Received: by 2002:a62:76c1:: with SMTP id r184mr2359866pfc.229.1553716702637;
        Wed, 27 Mar 2019 12:58:22 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id d187sm25585133pgc.43.2019.03.27.12.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 12:58:21 -0700 (PDT)
Date:   Wed, 27 Mar 2019 12:58:20 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190327195820.GF7431@mini-arch.hsd1.ca.comcast.net>
References: <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net>
 <20190326174802.jnhvtdephykfj6ku@ast-mbp>
 <CAF=yD-KzG1E0kL3s4TfYX+T8Bc3VeZw9siKK8iDHAN1uyYDyLA@mail.gmail.com>
 <CAADnVQLiGZv=PzqFd=9f02spzo-vibrKBM7kRpTp29L=FeeooQ@mail.gmail.com>
 <20190326181719.GC7431@mini-arch.hsd1.ca.comcast.net>
 <20190326183011.jly4j3s332yohrj5@ast-mbp>
 <20190326185456.GD7431@mini-arch.hsd1.ca.comcast.net>
 <20190327014121.p45cblrgqgdyiu6z@ast-mbp>
 <20190327024421.GE7431@mini-arch.hsd1.ca.comcast.net>
 <20190327175535.ewpc6a7gpfoxmxys@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327175535.ewpc6a7gpfoxmxys@ast-mbp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/27, Alexei Starovoitov wrote:
> On Tue, Mar 26, 2019 at 07:44:21PM -0700, Stanislav Fomichev wrote:
> > On 03/26, Alexei Starovoitov wrote:
> > > On Tue, Mar 26, 2019 at 11:54:56AM -0700, Stanislav Fomichev wrote:
> > > > On 03/26, Alexei Starovoitov wrote:
> > > > > On Tue, Mar 26, 2019 at 11:17:19AM -0700, Stanislav Fomichev wrote:
> > > > > > On 03/26, Alexei Starovoitov wrote:
> > > > > > > On Tue, Mar 26, 2019 at 10:52 AM Willem de Bruijn
> > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > > The BPF flow dissector should work the same. It is fine to pass the
> > > > > > > > data including ethernet header, but parsing can start at nhoff with
> > > > > > > > proto explicitly passed.
> > > > > > > >
> > > > > > > > We should not assume Ethernet link layer.
> > > > > > > 
> > > > > > > then skb-less dissector has to be different program type
> > > > > > > because semantics are different.
> > > > > > The semantics are the same as for c-based __skb_flow_dissect.
> > > > > > We just need to pass nhoff and proto that has been passed to
> > > > > > __skb_flow_dissect to the bpf program. In case of with-skb,
> > > > > > take this initial data from skb, like __skb_flow_dissect does (and don't
> > > > > > ask BPF program to do it essentially):
> > > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n763
> > > > > > 
> > > > > > I was thinking of passing proto as flow_keys->n_proto and we already
> > > > > > pass flow_keys->nhoff, so no need to do anything for it. With that,
> > > > > > BPF program doesn't need to look into skb and can parse optional vlan
> > > > > > and L3+ headers. The same way __skb_flow_dissect does that.
> > > > > 
> > > > > makes sense. then I'd also prefer for proto to be in flow_keys to
> > > > > high light this difference.
> > > > Maybe rename existing flow_keys->n_proto to flow_keys->proto?
> > > > That would match __skb_flow_dissect and remove ambiguity with both proto
> > > > and n_proto in flow_keys.
> > > 
> > > disabling useless fields in ctx is one thing, since probability of breaking users
> > > is low, but renaming n_proto is imo too much.
> > > 
> > > > > may be add vlan_proto/present/tci there as well?
> > > > > At least on the kernel side ctx rewriter will be the same for w/ & w/o skb cases.
> > > > Why do you think we need them? My understanding was that when
> > > > skb_vlan_tag_present(skb) (or skb->vlan_present) returns true, that means
> > > > that vlan info has been already parsed out of the packet and stored in
> > > > the vlan_tci/vlan_proto (where vlan_proto is 8021Q/8021AD); skb data
> > > > points to proper L3 header.
> > > > 
> > > > If that's correct, BPF flow dissector should not care about that. For
> > > > example, look at how C-based flow dissector does that:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n944
> > > > 
> > > > If skb_vlan_tag_present(skb) returns true, we set proto to skb->protocol
> > > > and move on.
> > > > 
> > > > But, we would need vlan_proto/present/tci in the flow_keys in the future.
> > > > We don't currently return parsed vlan data from the BPF flow dissector.
> > > > But it feels like it's getting into bpf-next territory :-)
> > > 
> > > Whether ctx->data points to L2 or L3 is uapi regardless whether
> > > progs/bpf_flow.c is relying on that or not.
> > > So far I think you're saying that in all three cases:
> > > no-skb, skb befor rfs, skb after rfs ctx->data points to L2, right?
> > > This has to be preserved.
> > It points to L3 (or vlan). And this will be preserved, I have no
> > intention to change that.
> > 
> > Just to make sure, we are on the same page, here is what
> > __skb_flow_dissect (and BPF prog) is seeing in nhoff.
> > 
> > NO-VLAN is always the same for both with-skb/no-skb:
> > +----+----+-----+--+
> > |DMAC|SMAC|PROTO|L3|
> > +----+----+-----+--+
> >                  ^
> >                  +-- nhoff
> >                      proto = PROTO
> > 
> > VLAN no-skb (eth_get_headlen):
> > +----+----+----+---+-----+--+
> > |DMAC|SMAC|TPID|TCI|PROTO|L3|
> > +----+----+----+---+-----+--+
> >                 ^
> >                 +-- nhoff
> >                     proto = TPID
> 
> where ctx->data will point to ?
> These nhoff differences are fine.
> I want to make sure that ctx->data is the same for all.
For with-skb, nhoff would be zero, and ctx->data would point to
TCI/L3.
For skb-less, ctx->data would point to L2 (DMAC), and nhoff would be
non-zero (TCI/L3 offset).

If you want, for skb-less case, when calling BPF program we can do the math
ourselves and set ctx->data to data + nhoff, and pass nhoff = 0.
But I'm not sure whether we need to do that; flow dissector is supposed
to look at ctx->data + nhoff, it should not matter what each individual
value is, they only make sense together.

> > And in the last case, networking stack sets:
> >  * skb->vlan_present to true
> >  * skb->vlan_proto to TPID
> >  * skb->vlan_tci to TCI
> >  * skb->protocol to PROTO
> >  * pulls vlan header, so skb->data points to L3 header
> 
> then skb-less should point after L2 as well
> or point to L2 for all.
Sure, we can do that, see above, we can manually move ctx->data to nhoff
and set nhoff to zero.

> I'm arguing about it because early on during tc-bpf days
> we had this discrepancy and it caused issues.
> Thankfully we addressed it before it became long term headache.
Ack, that's what we are trying to do here as well :-) Address all
existing shortcomings before it's too late.
