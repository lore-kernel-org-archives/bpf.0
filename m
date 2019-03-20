Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59CDC10F05
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 19:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B50720857
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 19:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmQU2jd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCTTJE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:09:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46349 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfCTTJD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 15:09:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id d1so2940998edd.13;
        Wed, 20 Mar 2019 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQZwKWwEXMP/Vdnk82O0g6JSHQJznII/yCivhgZAXm8=;
        b=JmQU2jd7cU8aD3m+NcIpZLWr0Tg8Hyii4knqCAT+PxpcSTwOqLuSoMMytWlOdx9uM5
         2dzomGlsPKS+XhdYU/fWt0URDim3s9ke3A9HuUGJVzg1OCtqlXJ2JnsZxpoVb3f8cAz/
         8QX0K9VDxiHYNhhTcLwAPD+yFhBFtjFKoNpeRqBBQ3UChlN8CUKKjXv90GEUhrbq+YSN
         FUuKCoxBfypPlr5eYCqHp+ddwDEDygcr5Hwmsw3C7VUzrUAz8xSdEEazbWHrFgFqEGC8
         bYTRrjEtygfTvlmZRFWDQL//+esFAF6WtW6/gYSk12H+rkoLoFRpdFo2gbXKT3VjSmkK
         2qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQZwKWwEXMP/Vdnk82O0g6JSHQJznII/yCivhgZAXm8=;
        b=Jj52KevtXNFOxnpP8dZjQ0mnPnXIipR5eMtz2YPUDoVI1ynShqZxUzhl6eNb/RgtRW
         sotijKmZCpZUJIFCmAhL/2BV94/Fr7v4tDbVdkyT5oF3nVY0fSuuceHmH7fCJcOPAaqr
         s9ovAxdku+2e6vuHNQfJf7EIcIgLkn9BY3Gmb60RfM6IQ7jz6hvzEk5+1Kfl4g09RcE+
         WzLPRVdwm7D2j2QfoeTxBV3t21UmGJFS27VdE7xQAd7nk9982AkYF+mWDquZOBankRFV
         OgDEudU0ACpD9VwUTsnupGvRWoZkvAE07Wgqc7AOgKO7og99u3m/Mu+uOLEORNsQ+Fej
         iJNQ==
X-Gm-Message-State: APjAAAV3T610zoHqMBBhUjPsnkPdTCKJ84YPT1zCa74fmP9C/uCQlHle
        FIlxWUumwl8H82gQWv9+/9U/3eYwse4oJkp7AuA=
X-Google-Smtp-Source: APXvYqzESUXKxwjRFLsJI4DReapTm1kLOpstnoagnjP44ZSAm1eXrvlayOUbfFbexMVmTF8VrHLpGq/WmjJZkJt7Uq0=
X-Received: by 2002:a17:906:c4f:: with SMTP id t15mr11440570ejf.132.1553108941456;
 Wed, 20 Mar 2019 12:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com> <20190319221948.170441-8-sdf@google.com>
 <CAF=yD-+=91KJEV==jE0VLT=FBTyM+j5sLfovk-HTj_2BbCC2Hw@mail.gmail.com>
 <20190320165744.GI7431@mini-arch.hsd1.ca.comcast.net> <CAF=yD-J3RDh=pX490gO2c+ybe5ZUbeYsEqGyFVcCNXMDHXqE6w@mail.gmail.com>
 <20190320190225.GL7431@mini-arch.hsd1.ca.comcast.net>
In-Reply-To: <20190320190225.GL7431@mini-arch.hsd1.ca.comcast.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 20 Mar 2019 15:08:25 -0400
Message-ID: <CAF=yD-J9BZ4eLBywrxcEyFO=zNFr7_+5Nuo5qHaRv=97HQyMTA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 7/9] bpf: when doing BPF_PROG_TEST_RUN for flow
 dissector use no-skb mode
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Stanislav Fomichev <sdf@google.com>,
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

On Wed, Mar 20, 2019 at 3:02 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 03/20, Willem de Bruijn wrote:
> > On Wed, Mar 20, 2019 at 12:57 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > >
> > > On 03/19, Willem de Bruijn wrote:
> > > > On Tue, Mar 19, 2019 at 6:21 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > > >
> > > > > Now that we have __flow_bpf_dissect which works on raw data (by
> > > > > constructing temporary on-stack skb), use it when doing
> > > > > BPF_PROG_TEST_RUN for flow dissector.
> > > > >
> > > > > This should help us catch any possible bugs due to missing shinfo on
> > > > > the per-cpu skb.
> > > > >
> > > > > Note that existing __skb_flow_bpf_dissect swallows L2 headers and returns
> > > > > nhoff=0, we need to preserve the existing behavior.
> > > > >
> > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > > ---
> > > > >  net/bpf/test_run.c | 48 ++++++++++++++--------------------------------
> > > > >  1 file changed, 14 insertions(+), 34 deletions(-)
> > > > >
> > > >
> > > > > @@ -300,9 +277,13 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
> > > > >         preempt_disable();
> > > > >         time_start = ktime_get_ns();
> > > > >         for (i = 0; i < repeat; i++) {
> > > > > -               retval = bpf_flow_dissect_skb(prog, skb,
> > > > > -                                             &flow_keys_dissector,
> > > > > -                                             &flow_keys);
> > > > > +               retval = bpf_flow_dissect(prog, data, eth->h_proto, ETH_HLEN,
> > > > > +                                         size, &flow_keys_dissector,
> > > > > +                                         &flow_keys);
> > > > > +               if (flow_keys.nhoff >= ETH_HLEN)
> > > > > +                       flow_keys.nhoff -= ETH_HLEN;
> > > > > +               if (flow_keys.thoff >= ETH_HLEN)
> > > > > +                       flow_keys.thoff -= ETH_HLEN;
> > > >
> > > > why are these conditional?
> > > Hm, I didn't want these to be negative, because bpf flow program can set
> > > them to zero and clamp_flow_keys makes sure they are in a "sensible"
> > > range. For this particular case, I think we need to amend
> > > clamp_flow_keys to make sure that flow_keys.nhoff is in the range of
> > > initial_nhoff..hlen, not 0..hlen (and then we can drop these checks).
> >
> > So, previously eth_type_trans would call with data at the network
> > header. Now it is called with data at the link layer. How would
> > __skb_flow_bpf_dissect "swallows L2 headers and returns nhoff=0"? That
> s/__skb_flow_bpf_dissect/eth_type_trans/, I'll clarify that in the patch
> description.
>
> > sounds incorrect.
> Previously, for skb case, eth_type_trans would pull ETH_HLEN (L2) and
> after that we did skb_reset_network_header. So when later we initialized
> flow keys (flow_keys->nhoff = skb_network_offset(skb)), that would
> yield nhoff == 0.
>
> For example, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
>
> Now, we explicitly call bpf_flow_dissect with nhoff=ETH_HLEN and have to
> undo it, otherwise, it breaks those tests.
>
> We could do something like the following instead:
> retval = bpf_flow_dissect(prog, data + ETH_HLEN, eth->h_proto, 0,
>                           size, &flow_keys_dissector,
>                           &flow_keys);
>
> But I wanted to make sure nhoff != 0 works.

Makes sense. Ensuring that nhoff lies within initial_nhoff..hlen
sounds correct to me. But this is a limitation of the test, so should
be in the test logic, not in the generic clamp code. Perhaps just fail
the test if returned nhoff < ETH_HLEN?
