Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954FAC43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617E721873
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 19:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="ONkV7Hea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfCTTTP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:19:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33837 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTTTO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 15:19:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id v64so2631835pfb.1
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XkgPHLP9fZGwN2An2hE1JguaqWNL62rbF8Uc8hr04Dc=;
        b=ONkV7HeaZvFAgkIdare6k3JdQ0TwWqVsk7ENtlQHVPoeW5ybVR+/gMdIaBswxLjpnz
         ILUTKcSCEGTb9mJAtBkHAgwUFC1lXXyFU1I8CnVb0kGmzrvAxHITtbRILAsmHPsF2+Pm
         lqDWtuxcH6N/VMC0fupYJFbCpBOkIk2co1/kdFNEtd6WuFrjhMr+qCi5vpvIRFShqRIU
         tXRuP1ysFOcksxEvNhu0KCqsOltPrcWjHpYu+b3Tz8E716K25nLy/phWhMutt+E3jru7
         F7DjCCEDqYH7C8y0k080CE2ruSvklO4ELbxmUDsP7xfmuWDrZUNynpE6mMNP5xcu/sD8
         8KWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XkgPHLP9fZGwN2An2hE1JguaqWNL62rbF8Uc8hr04Dc=;
        b=cGQFV1ysHK41cNqxsJbqrg2/Jayh2Nb7mqarSRtA+SowlKyXl49cXni3aghNtyYWH6
         A19Pf7u8J14Q1Lhe1aFrfDkiNu/jx/YC2meojO2H/pzoYXG+vLSSV1IveYT1FBFsr0Al
         whZy0o19Dp9P9kldIfumEXz4l7AdLtHjczYKU3TUF8LIH57SCDncnVC7Vk1s24A3LHJ1
         pKsOTV1h7dEUqH1pSecayK+Df9bl9dVpB+R1NUIbTV9IqzxlO2FWeB4LaSTv9jf1omW9
         xY/HEhhhVXB88JHT7obBaLy/VWbD8gweRVESqIrMJ2pGUQOplG1+k+fw7IZ8+MnkOq7M
         uE5A==
X-Gm-Message-State: APjAAAUYVAzWh/UlFgN1m6D7gH747McGArg5bVC4NL1y8M86RGPhwWRD
        GI9R38wPoybfs6+eBOOIgxRTwA==
X-Google-Smtp-Source: APXvYqyWd4csWj2XLyvnLHTwWAPV1AO7gh7xIwbZH60/WRMRxa1D+vV/+Lw3+XWsQ9Ay1q2x+0Frog==
X-Received: by 2002:aa7:8299:: with SMTP id s25mr9333143pfm.56.1553109554140;
        Wed, 20 Mar 2019 12:19:14 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id n15sm7503042pgc.92.2019.03.20.12.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 12:19:13 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:19:12 -0700
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
Message-ID: <20190320191912.GM7431@mini-arch.hsd1.ca.comcast.net>
References: <20190319221948.170441-1-sdf@google.com>
 <20190319221948.170441-8-sdf@google.com>
 <CAF=yD-+=91KJEV==jE0VLT=FBTyM+j5sLfovk-HTj_2BbCC2Hw@mail.gmail.com>
 <20190320165744.GI7431@mini-arch.hsd1.ca.comcast.net>
 <CAF=yD-J3RDh=pX490gO2c+ybe5ZUbeYsEqGyFVcCNXMDHXqE6w@mail.gmail.com>
 <20190320190225.GL7431@mini-arch.hsd1.ca.comcast.net>
 <CAF=yD-J9BZ4eLBywrxcEyFO=zNFr7_+5Nuo5qHaRv=97HQyMTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-J9BZ4eLBywrxcEyFO=zNFr7_+5Nuo5qHaRv=97HQyMTA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/20, Willem de Bruijn wrote:
> On Wed, Mar 20, 2019 at 3:02 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 03/20, Willem de Bruijn wrote:
> > > On Wed, Mar 20, 2019 at 12:57 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > On 03/19, Willem de Bruijn wrote:
> > > > > On Tue, Mar 19, 2019 at 6:21 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > > > >
> > > > > > Now that we have __flow_bpf_dissect which works on raw data (by
> > > > > > constructing temporary on-stack skb), use it when doing
> > > > > > BPF_PROG_TEST_RUN for flow dissector.
> > > > > >
> > > > > > This should help us catch any possible bugs due to missing shinfo on
> > > > > > the per-cpu skb.
> > > > > >
> > > > > > Note that existing __skb_flow_bpf_dissect swallows L2 headers and returns
> > > > > > nhoff=0, we need to preserve the existing behavior.
> > > > > >
> > > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > > > ---
> > > > > >  net/bpf/test_run.c | 48 ++++++++++++++--------------------------------
> > > > > >  1 file changed, 14 insertions(+), 34 deletions(-)
> > > > > >
> > > > >
> > > > > > @@ -300,9 +277,13 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
> > > > > >         preempt_disable();
> > > > > >         time_start = ktime_get_ns();
> > > > > >         for (i = 0; i < repeat; i++) {
> > > > > > -               retval = bpf_flow_dissect_skb(prog, skb,
> > > > > > -                                             &flow_keys_dissector,
> > > > > > -                                             &flow_keys);
> > > > > > +               retval = bpf_flow_dissect(prog, data, eth->h_proto, ETH_HLEN,
> > > > > > +                                         size, &flow_keys_dissector,
> > > > > > +                                         &flow_keys);
> > > > > > +               if (flow_keys.nhoff >= ETH_HLEN)
> > > > > > +                       flow_keys.nhoff -= ETH_HLEN;
> > > > > > +               if (flow_keys.thoff >= ETH_HLEN)
> > > > > > +                       flow_keys.thoff -= ETH_HLEN;
> > > > >
> > > > > why are these conditional?
> > > > Hm, I didn't want these to be negative, because bpf flow program can set
> > > > them to zero and clamp_flow_keys makes sure they are in a "sensible"
> > > > range. For this particular case, I think we need to amend
> > > > clamp_flow_keys to make sure that flow_keys.nhoff is in the range of
> > > > initial_nhoff..hlen, not 0..hlen (and then we can drop these checks).
> > >
> > > So, previously eth_type_trans would call with data at the network
> > > header. Now it is called with data at the link layer. How would
> > > __skb_flow_bpf_dissect "swallows L2 headers and returns nhoff=0"? That
> > s/__skb_flow_bpf_dissect/eth_type_trans/, I'll clarify that in the patch
> > description.
> >
> > > sounds incorrect.
> > Previously, for skb case, eth_type_trans would pull ETH_HLEN (L2) and
> > after that we did skb_reset_network_header. So when later we initialized
> > flow keys (flow_keys->nhoff = skb_network_offset(skb)), that would
> > yield nhoff == 0.
> >
> > For example, see:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
> >
> > Now, we explicitly call bpf_flow_dissect with nhoff=ETH_HLEN and have to
> > undo it, otherwise, it breaks those tests.
> >
> > We could do something like the following instead:
> > retval = bpf_flow_dissect(prog, data + ETH_HLEN, eth->h_proto, 0,
> >                           size, &flow_keys_dissector,
> >                           &flow_keys);
> >
> > But I wanted to make sure nhoff != 0 works.
> 
> Makes sense. Ensuring that nhoff lies within initial_nhoff..hlen
> sounds correct to me. But this is a limitation of the test, so should
> be in the test logic, not in the generic clamp code. Perhaps just fail
> the test if returned nhoff < ETH_HLEN?
I don't think it's only about the tests. BPF program can return
nhoff/thoff out of range as well (if there was some bug in its logic,
for example). We should not blindly trust whatever it returns, right?
