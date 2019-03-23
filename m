Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C2C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 01:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F8621902
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 01:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="ggC+9DHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCWBUA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:20:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41507 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfCWBUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 21:20:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so2618489pgb.8
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 18:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UQWG7Qbg5yvYaTUpz1CWln7tVYmSgD4ctZwy0pv91Qo=;
        b=ggC+9DHj2DzuCl6CSpR/wn+P1cwh6RCFCmgRcYcE+Wx7n8lv246nvP/oudn7Sne4hX
         2JApMZuqS6VeB67Y3sPLc13AsY2wtwOkxUxEjkojSLALx81HprKLsbdA708ebFMWDXVg
         x5Y4RjBPUPr2hzwXzw4ZHyl7gvT3cH/tAnIi6CpEKwldz9i36tiZ7eVmnK7KUGx+3Xp9
         MI0MBucHHgR7TBFjYgPwkJ5EXSrijCprvofXzRt1GiAuzpaFCbUia8jU0HUEfkkfRN1m
         gCyLQL66QGMPZkXbaWjgwaxcBQsV1S6m+rUVwArERev3AYjQdrD0XUbWqzYLreFNpmb4
         FGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UQWG7Qbg5yvYaTUpz1CWln7tVYmSgD4ctZwy0pv91Qo=;
        b=YFuB2IfOxbdg7FjOl3zDDGC5MvhDS6Bfl3QL1yc9491AvdBQfRXKRmR7gt8e/Ym1eN
         /uszXB2QXWcmvZoym7XkpLYiYfjGq+mOJfRl+pWbUTYb/xHUvpraSh0tNqfNJBA3J3pg
         lqYbpALvgTsuQ5eqD0KdH2ku6ByuRyNhEMmc+2tw3EW++lDGNKjulUtWGXFUvlXK6NiB
         9ksxHDHPvUWWfTtvZJmsvcWLTXxtnVFxVFPe2/MwkJEiFX6qzSCUuRH4GOzdRkTd/cYM
         awgHDskM7yrDxMRkJND0O7QtHQVLUDSIOrc2mSWCI5DTSN4dlLLfWhrp2l8XgPD+a2As
         WryQ==
X-Gm-Message-State: APjAAAUx/sNFnwrKtZ//u90EWLIx+rzEdoD7XZxhNzo0t0HMEyeS9+8T
        uOYiIqjSUdlqwq5O/eNtPm9IyA==
X-Google-Smtp-Source: APXvYqwgskeemA4F+of5V1p+z2mCBlHdeKrd75Io2E2E3+ZCN6weh3drQ5OEKUhuDIwp9Rxpe37u2g==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr73844plo.279.1553303998852;
        Fri, 22 Mar 2019 18:19:58 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id u20sm8017533pga.76.2019.03.22.18.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 18:19:58 -0700 (PDT)
Date:   Fri, 22 Mar 2019 18:19:57 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net>
References: <20190322195903.162516-1-sdf@google.com>
 <20190322195903.162516-7-sdf@google.com>
 <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/22, Alexei Starovoitov wrote:
> On Fri, Mar 22, 2019 at 12:59:01PM -0700, Stanislav Fomichev wrote:
> > When called without skb, gather all required data from the
> > __skb_flow_dissect's arguments and use recently introduces
> > no-skb mode of bpf flow dissector.
> > 
> > Note: WARN_ON_ONCE(!net) will now trigger for eth_get_headlen users.
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > +			struct bpf_flow_keys flow_keys;
> > +			struct bpf_flow_dissector ctx = {
> > +				.flow_keys = &flow_keys,
> > +				.data = data,
> > +				.data_end = data + hlen,
> > +				.protocol = proto,
> > +			};
> > +
> > +			if (skb) {
> > +				ctx.skb = skb;
> > +				ctx.protocol = skb->protocol;
> > +				ctx.vlan_tci = skb->vlan_tci;
> > +				ctx.vlan_proto = skb->vlan_proto;
> > +				ctx.vlan_present = skb->vlan_present;
> > +			}
> 
> are you suggesting to have vlan* fields that only work properly for skb case?
> It means that progs/bpf_flow.c would not work as-is for eth_get_headlen.
> And to have unified program that works in both cases the program would need to rely
> on above internal implementation detail, like checking that ctx->protocol == 0 ?
> imo that is worse than having two different flow dissector program types.
Yeah. The reference implementation (bpf_flow.c) should handle it though.
In parse_eth_proto we handle ETH_P_8021Q/ETH_P_8021AD, so I'm not sure
why we even had that skb->vlan_present check in the first place.
[But, again, who knows what's out there besides bpf_flow.c]

In general, this RFC's approach is to have a "best effort" vlan
detection, bpf program would still have to handle it.
Agree, that it's confusing.

> May be remove protocol and vlan* from ctx ?
> Then the only thing program can do is look at the packet data which is
> eth_get_headlen use case. For skb case the existence of vlan can be retrofitted into
> dissector results by the kernel after the program finished.
Are we ok with breaking api in this case? I'm all in on removing this
extra information. We can always put it back if somebody complains (and
manually parse in eth_get_headlen case).

Regarding dissector results: that's currently not implemented, we don't
export vlan information.

We can still have protocol, because in both skb/skb-less cases we have
it.
