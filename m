Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C38C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 16:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DBB2146E
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 16:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="WybsnccW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCTQ5q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:57:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40105 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfCTQ5q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 12:57:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so2351418pfc.7
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+/nMzUl14qqdTnuUSyHmIpbxFDa9PFqeN1nL/FCgmE8=;
        b=WybsnccWWUKgppBGrkkdi8SmiCeCuuygEaxutB2QymrLbzrUyqDU8kXQ3LpVnpkN83
         Mbsx/pQwvZ0oFB+vnHkbXRltIORaJCu6uGHgRxzL9clzTLuCS3IERVVCqdyXh6SY/RxG
         Dg2W1iu8kllDWFEtWJFipr5XwkPxFM3e3h7JsRFUwM2E8WgDmJGy76+4ZdCEVirfUUyZ
         7SNoDFl9qie24FgkG9lIyjx8XBFmH2o7e/B8Fm9OMJfTkPRXI/GcDksLakyWO4kZvpxg
         cgmoyMbyk8ez79K8OollLPrbGcYpZ8YKt901CUkcFA/JheUyd+g+wyX+JGtgXZjuPdY/
         11ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+/nMzUl14qqdTnuUSyHmIpbxFDa9PFqeN1nL/FCgmE8=;
        b=icprf0Tohzsv+29dbAixj9pFjhe0rObhtvVbCMvVI1NAkbn6Nd83XWHQzCI688OkPk
         g9GGxaTQ6RnH/zZzFxo+LupFgdNnahHm51gkUUYconKTgTRsbebxomFZpRKdP4Sjw1Ko
         MxjZyI2tzQ1Uz2SFXenCtsNRn0Ynhc1yGNQcUT9dYb+ol90mL+xANGsOY+Rz0mUj5yeo
         CMIOJk0vE9YIyGvtU7MaXkIyylSWTLFyIZMv/as610jF4I3HnSw+D0qbof076EwkJOYB
         GJmNdQbbavslwfLEwAwl4208FWoOUu4U5tVeeL9Z4PvSUR6XmdGE7KHYR54kmeCNdpdt
         DTtg==
X-Gm-Message-State: APjAAAVvGP56ufix4/5sWvqhsrqR1jdBAZQeUAPu3hLs9vxdcbQ7x3wU
        frcFD5mse0ckA7VCnRrdyJEssQ==
X-Google-Smtp-Source: APXvYqwK3KDI6pWeRyDQ4TBWPx2Sgtz9M9PzEh15f2I5z85ubX15MO3/ko91MXYt3YdqICMRAp8CAA==
X-Received: by 2002:a17:902:f209:: with SMTP id gn9mr8982817plb.50.1553101065791;
        Wed, 20 Mar 2019 09:57:45 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id r3sm7250127pgb.82.2019.03.20.09.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 09:57:45 -0700 (PDT)
Date:   Wed, 20 Mar 2019 09:57:44 -0700
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
Message-ID: <20190320165744.GI7431@mini-arch.hsd1.ca.comcast.net>
References: <20190319221948.170441-1-sdf@google.com>
 <20190319221948.170441-8-sdf@google.com>
 <CAF=yD-+=91KJEV==jE0VLT=FBTyM+j5sLfovk-HTj_2BbCC2Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-+=91KJEV==jE0VLT=FBTyM+j5sLfovk-HTj_2BbCC2Hw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/19, Willem de Bruijn wrote:
> On Tue, Mar 19, 2019 at 6:21 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Now that we have __flow_bpf_dissect which works on raw data (by
> > constructing temporary on-stack skb), use it when doing
> > BPF_PROG_TEST_RUN for flow dissector.
> >
> > This should help us catch any possible bugs due to missing shinfo on
> > the per-cpu skb.
> >
> > Note that existing __skb_flow_bpf_dissect swallows L2 headers and returns
> > nhoff=0, we need to preserve the existing behavior.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  net/bpf/test_run.c | 48 ++++++++++++++--------------------------------
> >  1 file changed, 14 insertions(+), 34 deletions(-)
> >
> 
> > @@ -300,9 +277,13 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
> >         preempt_disable();
> >         time_start = ktime_get_ns();
> >         for (i = 0; i < repeat; i++) {
> > -               retval = bpf_flow_dissect_skb(prog, skb,
> > -                                             &flow_keys_dissector,
> > -                                             &flow_keys);
> > +               retval = bpf_flow_dissect(prog, data, eth->h_proto, ETH_HLEN,
> > +                                         size, &flow_keys_dissector,
> > +                                         &flow_keys);
> > +               if (flow_keys.nhoff >= ETH_HLEN)
> > +                       flow_keys.nhoff -= ETH_HLEN;
> > +               if (flow_keys.thoff >= ETH_HLEN)
> > +                       flow_keys.thoff -= ETH_HLEN;
> 
> why are these conditional?
Hm, I didn't want these to be negative, because bpf flow program can set
them to zero and clamp_flow_keys makes sure they are in a "sensible"
range. For this particular case, I think we need to amend
clamp_flow_keys to make sure that flow_keys.nhoff is in the range of
initial_nhoff..hlen, not 0..hlen (and then we can drop these checks).
