Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC5C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 02:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD3A2075E
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 02:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="nlr14I6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfC0CoZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:44:25 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:44944 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfC0CoY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 22:44:24 -0400
Received: by mail-pl1-f182.google.com with SMTP id g12so2575009pll.11
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 19:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8zR7fnmF5oAkMkoaPQya0T5Tdhawd6Xb4IEZPohRFtA=;
        b=nlr14I6ozQlowChjzE1qYvkX2Qv8LDIscgGrrhUECL/GPYkvGN9INt1FKqCOIZJ6oH
         QmuVmrjhOeLPtBZXLHcRxPB/YKThY11z4RBOFwqKH22G6UixBPMiURoOPgEMwF9KLggn
         dP1U5X0trtyCTKK0o4d1U7I8DvIQiclXNDhdLuek0jfJgJX29c1S7vkdPrleEf6QsMFx
         AbBYgaSoYnuCksTk/6+DfGA1mBtDOD5ebahvYEvp0K2jjkup6h68A1oU9wi9Pnw1bBY8
         O9hmXtgrv2qmK54ce27j5n4U/mBIGCY80pWFv5QVBvU6rNDrc4cXz2VMJ+LBVuWbEJQx
         p6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8zR7fnmF5oAkMkoaPQya0T5Tdhawd6Xb4IEZPohRFtA=;
        b=Dx0Od6Bi4tNVYPPjow+1IH8S7+2GIL/xNi9JcxpswrZwbiO6oowogizY7PWeZskb5V
         5bancFlOyNPPxPsmWiHM0Fym2vDpQ4/agPtnncBdkjaoJAQFQZaKdxm9068+ZUblsVuA
         o0+zHljovNG8B32eYqKL6oSmD3KOCEcMneztIZj4Y0JPc/qAw86rbot3BhXpF/bvePUN
         7ghpb7V10647MkycQpFOybvaDRD0u+2oRq4tsmB3nu3/zpM/yNEpRX6iBmOolHozHadP
         MYi9C0qN8y9Xizk6BnkeEInkudbHYctXgVWPhCg4LuZSZ3qqvxGXLnzNoZ2qY1s+v26F
         Aiaw==
X-Gm-Message-State: APjAAAX/px03NfA8bJteM6dxs1SNMSAcn20XBNj7xCYUjtk4CKzfEQJR
        OOB2M8w2PGfvLUTmC0xAYMfsyQ==
X-Google-Smtp-Source: APXvYqwBAh/NIBUo7wIY9+7IZUkg4VzKpe03WOD6VTvCNWKIV9MGmKLvHLEOkVOO/SIktu1OJklPKw==
X-Received: by 2002:a17:902:d889:: with SMTP id b9mr32083524plz.294.1553654663577;
        Tue, 26 Mar 2019 19:44:23 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id u15sm30236770pfm.163.2019.03.26.19.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 19:44:22 -0700 (PDT)
Date:   Tue, 26 Mar 2019 19:44:21 -0700
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
Message-ID: <20190327024421.GE7431@mini-arch.hsd1.ca.comcast.net>
References: <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net>
 <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
 <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net>
 <20190326174802.jnhvtdephykfj6ku@ast-mbp>
 <CAF=yD-KzG1E0kL3s4TfYX+T8Bc3VeZw9siKK8iDHAN1uyYDyLA@mail.gmail.com>
 <CAADnVQLiGZv=PzqFd=9f02spzo-vibrKBM7kRpTp29L=FeeooQ@mail.gmail.com>
 <20190326181719.GC7431@mini-arch.hsd1.ca.comcast.net>
 <20190326183011.jly4j3s332yohrj5@ast-mbp>
 <20190326185456.GD7431@mini-arch.hsd1.ca.comcast.net>
 <20190327014121.p45cblrgqgdyiu6z@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327014121.p45cblrgqgdyiu6z@ast-mbp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/26, Alexei Starovoitov wrote:
> On Tue, Mar 26, 2019 at 11:54:56AM -0700, Stanislav Fomichev wrote:
> > On 03/26, Alexei Starovoitov wrote:
> > > On Tue, Mar 26, 2019 at 11:17:19AM -0700, Stanislav Fomichev wrote:
> > > > On 03/26, Alexei Starovoitov wrote:
> > > > > On Tue, Mar 26, 2019 at 10:52 AM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > The BPF flow dissector should work the same. It is fine to pass the
> > > > > > data including ethernet header, but parsing can start at nhoff with
> > > > > > proto explicitly passed.
> > > > > >
> > > > > > We should not assume Ethernet link layer.
> > > > > 
> > > > > then skb-less dissector has to be different program type
> > > > > because semantics are different.
> > > > The semantics are the same as for c-based __skb_flow_dissect.
> > > > We just need to pass nhoff and proto that has been passed to
> > > > __skb_flow_dissect to the bpf program. In case of with-skb,
> > > > take this initial data from skb, like __skb_flow_dissect does (and don't
> > > > ask BPF program to do it essentially):
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n763
> > > > 
> > > > I was thinking of passing proto as flow_keys->n_proto and we already
> > > > pass flow_keys->nhoff, so no need to do anything for it. With that,
> > > > BPF program doesn't need to look into skb and can parse optional vlan
> > > > and L3+ headers. The same way __skb_flow_dissect does that.
> > > 
> > > makes sense. then I'd also prefer for proto to be in flow_keys to
> > > high light this difference.
> > Maybe rename existing flow_keys->n_proto to flow_keys->proto?
> > That would match __skb_flow_dissect and remove ambiguity with both proto
> > and n_proto in flow_keys.
> 
> disabling useless fields in ctx is one thing, since probability of breaking users
> is low, but renaming n_proto is imo too much.
> 
> > > may be add vlan_proto/present/tci there as well?
> > > At least on the kernel side ctx rewriter will be the same for w/ & w/o skb cases.
> > Why do you think we need them? My understanding was that when
> > skb_vlan_tag_present(skb) (or skb->vlan_present) returns true, that means
> > that vlan info has been already parsed out of the packet and stored in
> > the vlan_tci/vlan_proto (where vlan_proto is 8021Q/8021AD); skb data
> > points to proper L3 header.
> > 
> > If that's correct, BPF flow dissector should not care about that. For
> > example, look at how C-based flow dissector does that:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n944
> > 
> > If skb_vlan_tag_present(skb) returns true, we set proto to skb->protocol
> > and move on.
> > 
> > But, we would need vlan_proto/present/tci in the flow_keys in the future.
> > We don't currently return parsed vlan data from the BPF flow dissector.
> > But it feels like it's getting into bpf-next territory :-)
> 
> Whether ctx->data points to L2 or L3 is uapi regardless whether
> progs/bpf_flow.c is relying on that or not.
> So far I think you're saying that in all three cases:
> no-skb, skb befor rfs, skb after rfs ctx->data points to L2, right?
> This has to be preserved.
It points to L3 (or vlan). And this will be preserved, I have no
intention to change that.

Just to make sure, we are on the same page, here is what
__skb_flow_dissect (and BPF prog) is seeing in nhoff.

NO-VLAN is always the same for both with-skb/no-skb:
+----+----+-----+--+
|DMAC|SMAC|PROTO|L3|
+----+----+-----+--+
                 ^
                 +-- nhoff
                     proto = PROTO

VLAN no-skb (eth_get_headlen):
+----+----+----+---+-----+--+
|DMAC|SMAC|TPID|TCI|PROTO|L3|
+----+----+----+---+-----+--+
                ^
                +-- nhoff
                    proto = TPID

VLAN with-skb, RFS (pre __netif_receive_skb_core):
+----+----+----+---+-----+--+
|DMAC|SMAC|TPID|TCI|PROTO|L3|
+----+----+----+---+-----+--+
                ^
                +-- nhoff
                    proto = TPID

VLAN with-skb, post RFS (post __netif_receive_skb_core / skb_vlan_untag):
+----+----+----+---+-----+--+
|DMAC|SMAC|TPID|TCI|PROTO|L3|
+----+----+----+---+-----+--+
                          ^
                          +-- nhoff
			      proto = PROTO

And in the last case, networking stack sets:
 * skb->vlan_present to true
 * skb->vlan_proto to TPID
 * skb->vlan_tci to TCI
 * skb->protocol to PROTO
 * pulls vlan header, so skb->data points to L3 header

> Only now after reading bpf_flow.c for Nth time I realized what semantics
> you gave to skb->vlan* and skb->protocol fields. All of them have
> to be kept as-is.
Don't read too much into current bpf_flow.c, I don't think it really
works with vlans in all the cases :-/

It always looks back, assuming post RFS situation; that needs to be
changed by dropping that "if (!skb->vlan_present)" and just looking
into input 'proto' (and optionally parsing vlan hdr if proto ==
802.1q/ad, which we already, sort of, do).

I'm gonna add a small testcase for BPF_PROG_TEST_RUN.

> For no-skb cases all of them should be available with the same logic
> and it has to documented, since it's different from other bpf progs
> that access these fields.
I feel like dropping those vlan_{present,proto,tci} from bpf flow dissector.
It should not care what's in the skb and should just rely on the input 'proto'
to optionally parse vlan header.

+1 on documenting all of that
