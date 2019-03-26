Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B306BC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D782206DF
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 17:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0WrYjeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCZRwG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:52:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37253 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZRwG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 13:52:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id v21so11580710edq.4;
        Tue, 26 Mar 2019 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmr5wpCD1eis4bGfIB+7WzDaH6mvbD8ZehNIQUcbOrI=;
        b=S0WrYjeHhO5CKptaMoao0AfjeVaeK7h+NHSnP6Mt60Q4JkI3w25cyfYo0zd3qusQDr
         330bVP6MqkB+2mE32SqHvcAnn3SvFmEja88FUoSNSz4Xrj9z37hsvtgDv7vBEM1Bmf+z
         ofsbScEvM+FAkhaAIpz+BylU63Hk/G7AfPlYADXDK8ln+bXtTU1kOhGZzjhExx+LNkgp
         TBUWBtrnvjXDCWalIKIRzG/3i5wqYoYNzB64vsOaCv82xDIBFN7sCU10/TNbyoClhhS3
         Vm8LxVJR7VPoCW6cnZQ/Jd3RT53wp+HVl/RwlUk7QpNpP2B+/WPFlKs61w/vEYeB5lON
         wvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmr5wpCD1eis4bGfIB+7WzDaH6mvbD8ZehNIQUcbOrI=;
        b=KU5u7FmILHbaXn1xUmQutqXPm6sjFwkGGE3tnEd3nsvyYUl5vnSkKwPdC7qStPFMg4
         mjgGMQkAtrausGSAWWETVS+yFt09xiTpE3kDOOeEQFlYijJhaD4pH3U3KBxAuUDG62uX
         F0BuEUSsSHHeSjkSz2AU3eyLtZJgBdUGGJ/T1o1+50FB9v/bo3mmYAKpZrRg9gWCDsNN
         xCng89GiE3h93tKehGAEnPCyVi2mZSE6KFTl6X4uaMA7DX7rHrWlDm/XG9SJlq1U54aF
         rpJxpYqmK0BhKIIALczIQTbaDja7uhH2e62K4mch7/8ggt+oUIzRjuu562VAGYygSHMn
         9kcg==
X-Gm-Message-State: APjAAAX96d4xmVW5x/FyLL76ESIuYZWrdjI2gjaljr3P0mIKRAVKnimV
        qspAOr4rq0FAHUproj7i/kyIsjiZQmVO4zQ/4s0=
X-Google-Smtp-Source: APXvYqzA/HCVD5htkh5ciZ6uLV65mB2K35WXQAcgw6kdalSuTkVO1rn+yrHYkDa5pZWeMXh6ryafw5cD9iFgthkhi3Y=
X-Received: by 2002:a50:f5f8:: with SMTP id x53mr21800929edm.2.1553622723905;
 Tue, 26 Mar 2019 10:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190322195903.162516-1-sdf@google.com> <20190322195903.162516-7-sdf@google.com>
 <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
 <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net> <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
 <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net> <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
 <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net> <20190326174802.jnhvtdephykfj6ku@ast-mbp>
In-Reply-To: <20190326174802.jnhvtdephykfj6ku@ast-mbp>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 26 Mar 2019 13:51:27 -0400
Message-ID: <CAF=yD-KzG1E0kL3s4TfYX+T8Bc3VeZw9siKK8iDHAN1uyYDyLA@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@fomichev.me>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        simon.horman@netronome.com, Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 26, 2019 at 1:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 26, 2019 at 09:45:29AM -0700, Stanislav Fomichev wrote:
> > On 03/25, Alexei Starovoitov wrote:
> > > On Sat, Mar 23, 2019 at 09:05:31AM -0700, Stanislav Fomichev wrote:
> > > > On 03/22, Alexei Starovoitov wrote:
> > > > > On Fri, Mar 22, 2019 at 06:19:57PM -0700, Stanislav Fomichev wrote:
> > > > > > Are we ok with breaking api in this case? I'm all in on removing this
> > > > > > extra information. We can always put it back if somebody complains (and
> > > > > > manually parse in eth_get_headlen case).
> > > > >
> > > > > Fine. That seems to be the only way forward to clean it all up.
> > > > > Could you submit patch 1 to bpf tree disallowing vlan fields?
> > > > > Patch 3 looks like candidate as well?
> > > > SGTM, will do. Let me also spend some time and do a simple test for
> > > > the vlan case, to make sure I didn't miss something important.
> > > > One question here though: would I need to wait for bpf and bpf-next
> > > > to re-merge to continues the series? Or we can cherry-pick those
> > > > patches to bpf-next as well (and git will work it out during the
> > > > merge)?
> > > >
> > > > > > We can still have protocol, because in both skb/skb-less cases we have
> > > > > > it.
> > > > >
> > > > > proto can work in both cases, but is it needed ? Does program benefit from it?
> > > > > The kernel side burns extra bytes by copying it and extra branches to handle it.
> > > > > May be drop it as well?
> > > > I feel like the program benefits from it, there is no need to go back and
> > > > re-parse that (and in the skb case, this data is already pulled). I was
> > > > also thinking about re-purposing flow_keys->n_proto for that (instead
> > > > of skb->protocol), so it functions as input and output, maybe that's a
> > > > more clear way to do it.
> > >
> > > Are you saying that skb-less and skb flow dissector progs are looking
> > > at different positions into the packet ?
> > No, sorry for confusion, they are both called to parse (optional) L2-vlan
> > and L3+ headers. However, with-skb case can be called with l2-vlan
> > parsed (post RFS) or with l2-vlan unparsed (RFS). The vlan is pulled in
> > __netif_receive_skb_core, but we can still invoke flow dissector prior to
> > that when doing RFS (get_rps_cpu).
> >
> > That's why have this 'if skb->vlan_present' check in the bpf_flow.c program
> > (and then also manually test for ETH_P_8021Q/ETH_P_8021AD).
> >
> > Let me try to post the patches to bpf tree somewhere this week, we
> > can discuss the API changes there.
>
> let's figure out what we disable for bpf/stable first.
> Sound like skb->protocol isn't helping.
> prog has to read it from eth header anyway. then let's drop it from ctx?

The C flow dissector does not parse link layer headers It starts with
proto either given as argument or derived from skb->protocol (or
skb->vlan_proto).

The BPF flow dissector should work the same. It is fine to pass the
data including ethernet header, but parsing can start at nhoff with
proto explicitly passed.

We should not assume Ethernet link layer.
