Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB07C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 19:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1650F20850
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 19:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="liVq9FkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfCTTC2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:02:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42381 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTTC2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 15:02:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so2453044pgh.9
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GHlgYjbmuj6/6irfgcZeVOFx7YzSdGsvpeqwr7Do9N0=;
        b=liVq9FkDpbUbfk2XeByxVsKR3+LQoVfnIEVwr/btQyz9x41fIlfQ0LuI1AiquMENdZ
         9PL5uavBVTOXKaJT0uy7BWeDKjG2InGC2/7dDZAc5+FWGfJuwW8VrUEIxyr+l1DIzEs0
         ABI8y3hsE7KFYw1GH1cE/FsWwgxSoooOXnBAhARHIuAcO3njcBA8QRP8aAVKvi2sb8qd
         +Hf+W+m0cumdduKbmKFa2RTDhWtUMHsbQODrfGdKELuoxB2/JiSFvMCAI+2H9VY6ky2n
         0pkOhiwvX8dRv6mFOKYMsMp5XGvJh9Uh5YzRZLwz/aZuJMpFPn/inAodq+26MaVlTNs/
         cUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GHlgYjbmuj6/6irfgcZeVOFx7YzSdGsvpeqwr7Do9N0=;
        b=gYZGS5E01HCxb99uaadCLgjdt9T9W9du4Pf8Tyma0SYmiSCCkKZer+e/TeVgo2UyVi
         XFWCJO5E/ihKz8iB9cm65mpog4b1DtAgLNo5VYFW/aVn6mI1k1GWSjJMwCxVMx1r7rDZ
         hp8LjzMs+iz9ivrqjgvOFLZzDY8sxxAFjI2v1skJmZ8s2hZkbx579VrxBRBSPw4I5lGp
         hdx17yKiw5Df+ubmktN6JLuqxt9YQ2jn7dGkQq14S6oy6cSYncUIFqLvoF/oAaxipHNj
         lmzRAycHlPUKIZ0bzwN7qBaJUNCqOVyZeC3wWvmBwEP9Qp2LsCvbCJCpo47WZbCe5gPp
         zVaw==
X-Gm-Message-State: APjAAAXK50VGpvYezaWLXbS57yE90s65cK1lBnKeeWJhYKjbRy4oJw7Y
        1068aH/iG3sHF+PCVuM5tMc7Cg==
X-Google-Smtp-Source: APXvYqxP/6DMajFdZhQZcBEP1Xm5PFvqQMLlb/HdAaPwCOhIm+QIS/LRNy0r2LCj9KXPSPeARVDLQg==
X-Received: by 2002:a65:424d:: with SMTP id d13mr9313934pgq.203.1553108547395;
        Wed, 20 Mar 2019 12:02:27 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id x11sm3863880pfa.154.2019.03.20.12.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 12:02:26 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:02:25 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        simon.horman@netronome.com, Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Subject: Re: [RFC bpf-next v2 7/9] bpf: when doing BPF_PROG_TEST_RUN for flow
 dissector use no-skb mode
Message-ID: <20190320190225.GL7431@mini-arch.hsd1.ca.comcast.net>
References: <20190319221948.170441-1-sdf@google.com>
 <20190319221948.170441-8-sdf@google.com>
 <CAF=yD-+=91KJEV==jE0VLT=FBTyM+j5sLfovk-HTj_2BbCC2Hw@mail.gmail.com>
 <20190320165744.GI7431@mini-arch.hsd1.ca.comcast.net>
 <CAF=yD-J3RDh=pX490gO2c+ybe5ZUbeYsEqGyFVcCNXMDHXqE6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-J3RDh=pX490gO2c+ybe5ZUbeYsEqGyFVcCNXMDHXqE6w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/20, Willem de Bruijn wrote:
> On Wed, Mar 20, 2019 at 12:57 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 03/19, Willem de Bruijn wrote:
> > > On Tue, Mar 19, 2019 at 6:21 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >
> > > > Now that we have __flow_bpf_dissect which works on raw data (by
> > > > constructing temporary on-stack skb), use it when doing
> > > > BPF_PROG_TEST_RUN for flow dissector.
> > > >
> > > > This should help us catch any possible bugs due to missing shinfo on
> > > > the per-cpu skb.
> > > >
> > > > Note that existing __skb_flow_bpf_dissect swallows L2 headers and returns
> > > > nhoff=0, we need to preserve the existing behavior.
> > > >
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > >  net/bpf/test_run.c | 48 ++++++++++++++--------------------------------
> > > >  1 file changed, 14 insertions(+), 34 deletions(-)
> > > >
> > >
> > > > @@ -300,9 +277,13 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
> > > >         preempt_disable();
> > > >         time_start = ktime_get_ns();
> > > >         for (i = 0; i < repeat; i++) {
> > > > -               retval = bpf_flow_dissect_skb(prog, skb,
> > > > -                                             &flow_keys_dissector,
> > > > -                                             &flow_keys);
> > > > +               retval = bpf_flow_dissect(prog, data, eth->h_proto, ETH_HLEN,
> > > > +                                         size, &flow_keys_dissector,
> > > > +                                         &flow_keys);
> > > > +               if (flow_keys.nhoff >= ETH_HLEN)
> > > > +                       flow_keys.nhoff -= ETH_HLEN;
> > > > +               if (flow_keys.thoff >= ETH_HLEN)
> > > > +                       flow_keys.thoff -= ETH_HLEN;
> > >
> > > why are these conditional?
> > Hm, I didn't want these to be negative, because bpf flow program can set
> > them to zero and clamp_flow_keys makes sure they are in a "sensible"
> > range. For this particular case, I think we need to amend
> > clamp_flow_keys to make sure that flow_keys.nhoff is in the range of
> > initial_nhoff..hlen, not 0..hlen (and then we can drop these checks).
> 
> So, previously eth_type_trans would call with data at the network
> header. Now it is called with data at the link layer. How would
> __skb_flow_bpf_dissect "swallows L2 headers and returns nhoff=0"? That
s/__skb_flow_bpf_dissect/eth_type_trans/, I'll clarify that in the patch
description.

> sounds incorrect.
Previously, for skb case, eth_type_trans would pull ETH_HLEN (L2) and
after that we did skb_reset_network_header. So when later we initialized
flow keys (flow_keys->nhoff = skb_network_offset(skb)), that would
yield nhoff == 0.

For example, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/flow_dissector.c

Now, we explicitly call bpf_flow_dissect with nhoff=ETH_HLEN and have to
undo it, otherwise, it breaks those tests.

We could do something like the following instead:
retval = bpf_flow_dissect(prog, data + ETH_HLEN, eth->h_proto, 0,
                          size, &flow_keys_dissector,
                          &flow_keys);

But I wanted to make sure nhoff != 0 works.

> 
> Agreed that the output should lie between nhoff and hlen, but as far
> as I can tell it is always zero indexed to the data passed, here the
> link layer:
> 
>         if (!data) {
>                 data = skb->data;
>                 proto = skb_vlan_tag_present(skb) ?
>                          skb->vlan_proto : skb->protocol;
>                 nhoff = skb_network_offset(skb);
That's for the skb != NULL case. eth_get_headlen calls with skb == NULL
and passes data and nhoff=sizeof(*eth):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ethernet/eth.c#n139
