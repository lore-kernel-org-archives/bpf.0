Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F6C10F00
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F05218A5
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 15:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="X2k2ippR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfCUPog (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:44:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46608 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfCUPog (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 11:44:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so4299095pfj.13
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1lkRVARVozC1m9BQCaqAVJXYsyMo9Jfwg7+uFJl57k=;
        b=X2k2ippRSLuo+meEhXWREZ3D/508zQF4qMqPbwlnI+5q5FVGdSKUOhTUlP4CvdNIMR
         0uQPjoZwcg85mYCWwkHDm5VpJMfHC1igW+dmksq7qgdVRdlU+xFiETNblo0CXuj+GmuF
         MUykEvEiyv9QSdZU+v+pDm+2lWqM0jYurc5u30CdyfNJrvrW6flndAkrCGX9V/jDhm8M
         Tu/CnG6Kjko8SUoCfIYf8ABlmfIg9DWovzuXVyZ5Qa1saNHN1GPnCD7N3qIp8iCoRRcF
         Q7ZqdhJjvzGd7W9D1WAPsd6NP/RQv4ccCb/Hmt2pMBSHA72ERRfaWWcM5VNaADcKo4RR
         qIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1lkRVARVozC1m9BQCaqAVJXYsyMo9Jfwg7+uFJl57k=;
        b=acX+mOa57ZSCz0ETusjTSo+HVOeHiEe9J+i25WSXxgendMCMEeWmX6obh5+LqYHj/4
         iPl26vpHcjeBRDQ+6voLR3pNEuBv0Lv2z37c+cxsxILEfOkvSxkP2NlxCM9zgQOL6oaG
         EiwMzqwexgz1iPd58C/F+sB9MlIHYgqPMbkBdgr1ebFNxX/cshM+jGv6d8F+fc7HUVfx
         nM2zhRvCgdJxDndpvy7HMnHjiCknRnAXMk/BHOlCjRewcqP8nI3ZBCdP8bhzeMY+/oS4
         qSPGlE/nVq2ZQtK48JSM4hiUR1W3hMdTC/i0jWPCF/r+ZukyuFkT5qU2mj1S804PdWgJ
         /TIg==
X-Gm-Message-State: APjAAAX/rj82GCXNSGRYlbeqp96iBzd0jpx4rsX/iFFA8fVXIxrKsfUB
        9V34p1PtdGfH+p9kf5em3icq1g==
X-Google-Smtp-Source: APXvYqzz5dsF7ACGfei6vgZsCceB0XDcKA+IFQL2kCw4sjnF6lKL8TbkiRs2aMNxImQcv785PHihQg==
X-Received: by 2002:a62:e418:: with SMTP id r24mr4063200pfh.52.1553183075805;
        Thu, 21 Mar 2019 08:44:35 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id g67sm12676434pfg.13.2019.03.21.08.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 08:44:35 -0700 (PDT)
Date:   Thu, 21 Mar 2019 08:44:33 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        simon.horman@netronome.com, Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Subject: Re: [RFC bpf-next v2 1/9] net: introduce __init_skb{,_data,_shinfo}
 helpers
Message-ID: <20190321154433.GS7431@mini-arch.hsd1.ca.comcast.net>
References: <20190319221948.170441-1-sdf@google.com>
 <20190319221948.170441-2-sdf@google.com>
 <20190321033941.bygpejl2krltkdmm@ast-mbp.dhcp.thefacebook.com>
 <6406eae2-4633-9b2a-1101-2de48d29f9dd@gmail.com>
 <CAF=yD-KFZ2-p8BWf_EBpqCbpzeqwLbqtZutio5WM6MP62G7wKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-KFZ2-p8BWf_EBpqCbpzeqwLbqtZutio5WM6MP62G7wKQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/21, Willem de Bruijn wrote:
> On Thu, Mar 21, 2019 at 12:45 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> >
> >
> > On 03/20/2019 08:39 PM, Alexei Starovoitov wrote:
> >
> > > I think you need to convince Dave and Eric that
> > > above surgery is necessary to do the hack in patch 6 with
> > > +static DEFINE_PER_CPU(struct sk_buff, bpf_flow_skb);
> > >
> >
> > Yes, this is a huge code churn.
> 
> It touches a lot of lines. But it deduplicates logic that might become
> out of sync if we don't do that now.
Yeah, I remove a bunch of copy-paste with this change.

> > Honestly I believe we are going too far in this series.
> >
> > > I think the better option it to introduce new prog type that works
> > > without skb. I think it can be pretty close to shape and form to xdp.
> > >
> 
> That's an interesting alternative. The existing sample dissector
> does not access any skb fields aside from vlan. The interface could
> be superseded with one that has a more constrained context, like xdp.
> 
> When parsing for headlen in the device driver rx path, a program could
> conceivably in the same pass also compute an rxhash in case the
> device did not supply an L4 one. And perhaps some hash (the same?)
> to speed up GRO flow lookup. This would require a few extra fields in
> bpf_flow_keys.
With the xdp-like interface, what would be the end goal? Two different
program types, one triggering from eth_get_headlen, the other from
existing __skb_flow_dissect? Or we can use xdp-like interface everywhere
and just pass the first fragment in __skb_flow_dissect (that should be
enough, in theory, to get everything we want)?

If we end up with two interface, that can be confusing to the users. Which
one to use? Why? Why write essentially the same program twice?

If we can agree that we switch everything to xpd-like, do we deprecate the
skb-one?
