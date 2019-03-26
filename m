Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A810C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 16:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5958C20811
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 16:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="0SaPuWct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfCZQpd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:45:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41189 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfCZQpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 12:45:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so4388499pgs.8
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4EXT8WSfX5aDZzj/zXdwjOZzrpmd3eQwjWQGqbLKfLc=;
        b=0SaPuWctY/7Tc2eN+l3PMu0qQMxRhXFIP1JFRF0MbEwlFehtwsjyyPFMF7FnjmrP2f
         lTvtjKHyoBHwl5Mmza2Ar0VK/UxuVzW7efX1CpVBncU8NNZl4nbmo3W68gzyh+of0DQN
         A2BtTZ7s9N+Pcb1trWAr9J5SnxGhzkMaxMZsGHtZdotYSm7OvaUj9VHLWOpqd1iSDRqZ
         eA6XpV8UxhXFK5+jt0d1HErO7RewCKTA6e28/gQQ/aL3br5T5Si+lXTJbNzAJrD5pV9R
         LM/H3mI91egzwwrnEncufY9qUspQNK01prELjMNWblvfTlQD0Izq3QRc5cI6g6+6BE1m
         2eAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4EXT8WSfX5aDZzj/zXdwjOZzrpmd3eQwjWQGqbLKfLc=;
        b=HGj/bc7D5IZ1AMw6s9MiJqQwgIJz3l7W4mg8vTWIG5rSaZ73c0NNV1xy0qIxOHGco+
         2fHiHO299XpFyWDoPMPrLXZT3NYGbeWeGHCct2LET7sAIsrPVXOt65ZH+R0mq+twrC5N
         WUqr4hJ64IBVCHjz4waHDbGmG/9nLgR+rmMVovlVlxWs71b3EOMMwAiGx1oX12MZSVVx
         tM8KhhQms7G9xSI+Mzwzaw+yJg+I994RUGDI1bu1JplZmVix/JiyT1Rp4zqBYE2zCrXz
         D0NngRwxpOcWyAWagT4Hi5yJkaqGlTDGJykLDsZ/HjKcEM7IKbKyilLew62LGB5BCWHd
         5uQw==
X-Gm-Message-State: APjAAAX8l8IkbqOo8fdR3JDT9XshxpGu6nZT+g1sHORKSGeML83MwtG/
        PqmUkrYG5NiWuqAXC7Pl4v7APw==
X-Google-Smtp-Source: APXvYqyhd6bhVTTtmHWaZOeqsrrTXG1a13+PiSAIlaVCRaIN6Q7kfBwAfb0Dceod/udQT+z5oooEHw==
X-Received: by 2002:a62:bd17:: with SMTP id a23mr29940661pff.233.1553618731485;
        Tue, 26 Mar 2019 09:45:31 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id z124sm49193726pfb.150.2019.03.26.09.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 09:45:30 -0700 (PDT)
Date:   Tue, 26 Mar 2019 09:45:29 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net>
References: <20190322195903.162516-1-sdf@google.com>
 <20190322195903.162516-7-sdf@google.com>
 <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
 <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net>
 <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
 <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net>
 <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/25, Alexei Starovoitov wrote:
> On Sat, Mar 23, 2019 at 09:05:31AM -0700, Stanislav Fomichev wrote:
> > On 03/22, Alexei Starovoitov wrote:
> > > On Fri, Mar 22, 2019 at 06:19:57PM -0700, Stanislav Fomichev wrote:
> > > > Are we ok with breaking api in this case? I'm all in on removing this
> > > > extra information. We can always put it back if somebody complains (and
> > > > manually parse in eth_get_headlen case).
> > > 
> > > Fine. That seems to be the only way forward to clean it all up.
> > > Could you submit patch 1 to bpf tree disallowing vlan fields?
> > > Patch 3 looks like candidate as well?
> > SGTM, will do. Let me also spend some time and do a simple test for
> > the vlan case, to make sure I didn't miss something important.
> > One question here though: would I need to wait for bpf and bpf-next
> > to re-merge to continues the series? Or we can cherry-pick those
> > patches to bpf-next as well (and git will work it out during the
> > merge)?
> > 
> > > > We can still have protocol, because in both skb/skb-less cases we have
> > > > it.
> > > 
> > > proto can work in both cases, but is it needed ? Does program benefit from it?
> > > The kernel side burns extra bytes by copying it and extra branches to handle it.
> > > May be drop it as well?
> > I feel like the program benefits from it, there is no need to go back and
> > re-parse that (and in the skb case, this data is already pulled). I was
> > also thinking about re-purposing flow_keys->n_proto for that (instead
> > of skb->protocol), so it functions as input and output, maybe that's a
> > more clear way to do it.
> 
> Are you saying that skb-less and skb flow dissector progs are looking
> at different positions into the packet ?
No, sorry for confusion, they are both called to parse (optional) L2-vlan
and L3+ headers. However, with-skb case can be called with l2-vlan
parsed (post RFS) or with l2-vlan unparsed (RFS). The vlan is pulled in
__netif_receive_skb_core, but we can still invoke flow dissector prior to
that when doing RFS (get_rps_cpu).

That's why have this 'if skb->vlan_present' check in the bpf_flow.c program
(and then also manually test for ETH_P_8021Q/ETH_P_8021AD).

Let me try to post the patches to bpf tree somewhere this week, we
can discuss the API changes there.

> In case of with-skb it's already after eth header was pulled?
> In such case skb-less should be different program type or
> both should point at the same point.
