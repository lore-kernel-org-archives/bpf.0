Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A4AC10F05
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7E120823
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="L343UoiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbfCZSRX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:17:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42672 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbfCZSRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:17:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so8433399pfn.9
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ysLRaZae9d86EFgy8BXNbkkrXmKK+CpCrVhtFxs5pYQ=;
        b=L343UoiPm+Ih6V7BbzsFsuNMUjZYK8VmomKPeqQUR7Z/VVLr9AhvIQgwgrx/ah6X4y
         4WIhypYJcj9mH1TGEdqoEiJI7S1iemwPzRRQZ8ofOggqKiiwDcRAf/03X8naO8dJeIk7
         hQhGWmCFTPygbuBZ6rLPldpyuJsuavp7EWug0+fQ+s7N1P1QKFJEFSvdgnFSxWXtWw26
         2rfjjovPR91p9dKQxt1CvbIksudUvHhFFxIxyh+Jrm4S/Km9vfAFkl5LYkThSTuLgIaR
         1SsgnobFM/5+2G1Ia+40cIPQkY3xpGbTnEg8+IzDLWMpU/45jaMkKC/jroCd8br20gHe
         3yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ysLRaZae9d86EFgy8BXNbkkrXmKK+CpCrVhtFxs5pYQ=;
        b=geQ8mb2op2P2Ez6uBDhyitQnxsEfUxcJ6UgdFVStlUG1YRd0RqmKs+8Y/MnNLbdQAf
         L4CqzPVYsAsvOw+bpvtz6ttvlqJ2kBPyzrgUIaVmfsdTDYet5277mRkkWSNVxVgmbv+p
         iVhy/+NMMj6+I1ZM2swDGbPe5WEXl+Yl6IL93X7ow1c7S5u76GHpompwrXFP75SjsB3C
         W+v6Qi5ZI12QXqVbUasYWCwAZ8G0G4mecJVwEpUPtaK59GVn87yZ2eSj69ZUykWfqR8B
         /46kC6EMAKxf3ZsLXQLNskLJRbA3VMn0Mrua+NdL/QEBSdXK5rDiF5rArXrD8Dr1cWUE
         FdRg==
X-Gm-Message-State: APjAAAWhu4LOMsZg0Je7XCMOx9TGuYUDkKX+XKysy+M5SFK3Q51zWClg
        aHUjbALuwFSJWaR8f50e8H0LOg==
X-Google-Smtp-Source: APXvYqyn21r3mrYlmYl7zNcRukoUkLqWajKRC3pTHTI+a9Xn415zaNl3MQVCCsi+xHDyRU/11M20FA==
X-Received: by 2002:a62:6c43:: with SMTP id h64mr31142100pfc.123.1553624241677;
        Tue, 26 Mar 2019 11:17:21 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id b133sm25988036pfb.62.2019.03.26.11.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 11:17:20 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:17:19 -0700
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
Message-ID: <20190326181719.GC7431@mini-arch.hsd1.ca.comcast.net>
References: <20190322195903.162516-7-sdf@google.com>
 <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
 <20190323011957.GY7431@mini-arch.hsd1.ca.comcast.net>
 <20190323014101.mxeey4tw3gt7o4yi@ast-mbp.dhcp.thefacebook.com>
 <20190323160531.GZ7431@mini-arch.hsd1.ca.comcast.net>
 <20190326003517.fuqb4mqsbqq4mtk5@ast-mbp>
 <20190326164529.GB7431@mini-arch.hsd1.ca.comcast.net>
 <20190326174802.jnhvtdephykfj6ku@ast-mbp>
 <CAF=yD-KzG1E0kL3s4TfYX+T8Bc3VeZw9siKK8iDHAN1uyYDyLA@mail.gmail.com>
 <CAADnVQLiGZv=PzqFd=9f02spzo-vibrKBM7kRpTp29L=FeeooQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLiGZv=PzqFd=9f02spzo-vibrKBM7kRpTp29L=FeeooQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/26, Alexei Starovoitov wrote:
> On Tue, Mar 26, 2019 at 10:52 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > The BPF flow dissector should work the same. It is fine to pass the
> > data including ethernet header, but parsing can start at nhoff with
> > proto explicitly passed.
> >
> > We should not assume Ethernet link layer.
> 
> then skb-less dissector has to be different program type
> because semantics are different.
The semantics are the same as for c-based __skb_flow_dissect.
We just need to pass nhoff and proto that has been passed to
__skb_flow_dissect to the bpf program. In case of with-skb,
take this initial data from skb, like __skb_flow_dissect does (and don't
ask BPF program to do it essentially):

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/core/flow_dissector.c#n763

I was thinking of passing proto as flow_keys->n_proto and we already
pass flow_keys->nhoff, so no need to do anything for it. With that,
BPF program doesn't need to look into skb and can parse optional vlan
and L3+ headers. The same way __skb_flow_dissect does that.
