Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0355EC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 01:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA772082F
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 01:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFkCV0bF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfC0Bl1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:41:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32938 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfC0Bl1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 21:41:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so288543pfd.0;
        Tue, 26 Mar 2019 18:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cSLpheXXbH8xheIDLfPAeNGZDwyrQAw9ZNkh9ZwjcuE=;
        b=iFkCV0bFXZkrehbPR2cvj+vtHL/AUj4hwoDwRUBCtu5VhCLuDMZYuA4yKpRgEL0yyh
         N8rkv8c5j5U/Knscj6dlN8ELQwmwS44kchKJmHzUMbYL/LmEBfZhO/wwIXC/cLT1YINe
         N842jOss8/q84y0MEMJ6J4tNWc4CAqu5Jvw9beiQ1fUsdnLyDzdb3t3gTtNTnIDU4ME0
         qwKWhK0w1YP835/TM7MhXCbC3hwKH+ZINcm6T3xLhFB69ZpVHFx+owU7gK6DKfD8YMmR
         SPNKlVtJ/kiskdLf6Vc7YGI0ucwHBQiXMj29lByxTOAOgfWIJ7KcsTNWDSR7RlBPjLYz
         YZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cSLpheXXbH8xheIDLfPAeNGZDwyrQAw9ZNkh9ZwjcuE=;
        b=Z9kCVWS85Wniuh5iSoBCCSjz1N09BaJ5j+kHoVx+ICR2lPWOpyJWBTXKpz1BHUIne+
         ioDRPx2+9Ac0JM+Z8fgPWy9pZrO3qTFqCPc0XnMTtx2dRkGwUxROTVpkIk2lCZq1F59N
         rdP9ONIyoFVWqR71V3i9AJkTVS//H3h62mp2NlQ8RK1BgnllqVzlcJSVeKCUNJBW+l+M
         c6Nn6M0bJZgpUFcKkjcDncWW9aHeCEZXrgE7Bm+w3cAQMUrgjpOOVET2W2DmDBreQAxy
         l3eucjzY++KfFEFmNfx9dklB3QJo63dAFnVLV4eSe6yjjNe94gQswSNUciPBBiBmnHjd
         d5qg==
X-Gm-Message-State: APjAAAUNH+32zxZNVxyfFKz10/SrComQkA2qjYhe0h66z2XUAgrdMx4P
        X2D4LuGnp5QS8cVmJ3tQi8o=
X-Google-Smtp-Source: APXvYqzIPLPBx6QmDbzMcpWNbBTgKNfTK3lx6oXn1b50pdWu+u4nhRHbEMzmnBQ4G4LPpzL4XrDIDw==
X-Received: by 2002:a62:3849:: with SMTP id f70mr29536775pfa.46.1553650885846;
        Tue, 26 Mar 2019 18:41:25 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::1:f1fc])
        by smtp.gmail.com with ESMTPSA id e1sm25614441pfn.73.2019.03.26.18.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 18:41:25 -0700 (PDT)
Date:   Tue, 26 Mar 2019 18:41:23 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
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
Message-ID: <20190327014121.p45cblrgqgdyiu6z@ast-mbp>
References: <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
 <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net>
 <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
 <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net>
 <20190326174802.jnhvtdephykfj6ku@ast-mbp>
 <CAF=yD-KzG1E0kL3s4TfYX+T8Bc3VeZw9siKK8iDHAN1uyYDyLA@mail.gmail.com>
 <CAADnVQLiGZv=PzqFd=9f02spzo-vibrKBM7kRpTp29L=FeeooQ@mail.gmail.com>
 <20190326181719.GC7431@mini-arch.hsd1.ca.comcast.net>
 <20190326183011.jly4j3s332yohrj5@ast-mbp>
 <20190326185456.GD7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326185456.GD7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 11:54:56AM -0700, Stanislav Fomichev wrote:
> On 03/26, Alexei Starovoitov wrote:
> > On Tue, Mar 26, 2019 at 11:17:19AM -0700, Stanislav Fomichev wrote:
> > > On 03/26, Alexei Starovoitov wrote:
> > > > On Tue, Mar 26, 2019 at 10:52 AM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > The BPF flow dissector should work the same. It is fine to pass the
> > > > > data including ethernet header, but parsing can start at nhoff with
> > > > > proto explicitly passed.
> > > > >
> > > > > We should not assume Ethernet link layer.
> > > > 
> > > > then skb-less dissector has to be different program type
> > > > because semantics are different.
> > > The semantics are the same as for c-based __skb_flow_dissect.
> > > We just need to pass nhoff and proto that has been passed to
> > > __skb_flow_dissect to the bpf program. In case of with-skb,
> > > take this initial data from skb, like __skb_flow_dissect does (and don't
> > > ask BPF program to do it essentially):
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n763
> > > 
> > > I was thinking of passing proto as flow_keys->n_proto and we already
> > > pass flow_keys->nhoff, so no need to do anything for it. With that,
> > > BPF program doesn't need to look into skb and can parse optional vlan
> > > and L3+ headers. The same way __skb_flow_dissect does that.
> > 
> > makes sense. then I'd also prefer for proto to be in flow_keys to
> > high light this difference.
> Maybe rename existing flow_keys->n_proto to flow_keys->proto?
> That would match __skb_flow_dissect and remove ambiguity with both proto
> and n_proto in flow_keys.

disabling useless fields in ctx is one thing, since probability of breaking users
is low, but renaming n_proto is imo too much.

> > may be add vlan_proto/present/tci there as well?
> > At least on the kernel side ctx rewriter will be the same for w/ & w/o skb cases.
> Why do you think we need them? My understanding was that when
> skb_vlan_tag_present(skb) (or skb->vlan_present) returns true, that means
> that vlan info has been already parsed out of the packet and stored in
> the vlan_tci/vlan_proto (where vlan_proto is 8021Q/8021AD); skb data
> points to proper L3 header.
> 
> If that's correct, BPF flow dissector should not care about that. For
> example, look at how C-based flow dissector does that:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n944
> 
> If skb_vlan_tag_present(skb) returns true, we set proto to skb->protocol
> and move on.
> 
> But, we would need vlan_proto/present/tci in the flow_keys in the future.
> We don't currently return parsed vlan data from the BPF flow dissector.
> But it feels like it's getting into bpf-next territory :-)

Whether ctx->data points to L2 or L3 is uapi regardless whether
progs/bpf_flow.c is relying on that or not.
So far I think you're saying that in all three cases:
no-skb, skb befor rfs, skb after rfs ctx->data points to L2, right?
This has to be preserved.
Only now after reading bpf_flow.c for Nth time I realized what semantics
you gave to skb->vlan* and skb->protocol fields. All of them have
to be kept as-is.
For no-skb cases all of them should be available with the same logic
and it has to documented, since it's different from other bpf progs
that access these fields.

