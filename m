Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56A7C10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D522175B
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3z/vSvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfDVSxd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:53:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40819 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfDVSxc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 14:53:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id a28so9702001lfo.7
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 11:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzaR+kCFYF1F5P43dLEAzHVn/Q+qHOMNbLNJNy+v0RU=;
        b=W3z/vSvOT5qXoKw6eeUyjFHU4JkhmooOJdXMtYqaWxziT8cfY/UoZPu04DKs0+kOgp
         bK2O/VuEqA5WSjwNb1XkFgUQiyVACb+sTn/IVVj7awLG7Lv8n1Lk0XzVLVfvzDO7tlr1
         ga1zb+dUGG4nsnz+baVwsWUOj065itqORTLt8bZvqNlBj2zMKh6yF4rUXZSkE1m29N1B
         nT4ddzhj/itAs+T6oNkmUFgss/j+vhIy3qKqgRC8En9fu5GjwTFZJQLXVsfF4Eis3NdY
         EBEmjA0jUHBja76httjxXAzoTjMAkDvyRjOmdsrVw8HIUcv+T5Ef9CXgE1hjaPqKQUSF
         wlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzaR+kCFYF1F5P43dLEAzHVn/Q+qHOMNbLNJNy+v0RU=;
        b=dVNJAc2bUjWNQ46GREBlPmEd36SpkPVjz3jIsOuZYx/WSf4QuGZvfp/S1FGi6rJAj1
         F3a/m8FmzWFnfPehbojfFDXOcyo3qlKI4aouLh/JRCxYXSHfEVQq0kbsykVF67XdOOVT
         ntC2ehjfncIJkP9byFLY0oGE1Ixagc99BLg/Onxh5a8HsOA+FMELTknLXUvzmbnRIplz
         +8uKgXoCB0GmIzpBabxdI5cpLoINcevNiRgM+J5jhn0OmMIIr82wMiT4wZTKArWmAkiZ
         eEcPsmmj7qe25f0wkXh2/vF0plv+x6eZD8SS+Jb5PZhK2mwF19Yp5bTSj/qQf+ExCP75
         wz3w==
X-Gm-Message-State: APjAAAWi0u2olq7+YuYslp807RSEq7mqbg8rUqS6tyRYo/3f60wbYcss
        FqalNf7Rfk2fGwq9GXtLTm2lP5YvpcL1cLH4IRVocQ==
X-Google-Smtp-Source: APXvYqxfYUDBDO1ZoPCWV6t/VgKTam30kCoo7YuEwjQ2MtlzE3T5qoZUpaAntLYmt11tfYQ7oi6Fdp6KFx1BM5PzONU=
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr11108242lfn.10.1555959209543;
 Mon, 22 Apr 2019 11:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com> <20190422155552.222910-4-sdf@google.com>
 <67dc0b5f17c63281c88e9be44043765a2cd0cc17.camel@mellanox.com>
In-Reply-To: <67dc0b5f17c63281c88e9be44043765a2cd0cc17.camel@mellanox.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 22 Apr 2019 11:53:17 -0700
Message-ID: <CAKH8qBs-hM4XR3p+1bk_0F7j-dKcgWnzNG8mK_iY=ihzwaEejw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/9] net: plumb network namespace into __skb_flow_dissect
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "peterpenkov96@gmail.com" <peterpenkov96@gmail.com>,
        "willemb@google.com" <willemb@google.com>,
        "simon.horman@netronome.com" <simon.horman@netronome.com>,
        "ast@kernel.org" <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 22, 2019 at 11:08 AM Saeed Mahameed <saeedm@mellanox.com> wrote:
>
> On Mon, 2019-04-22 at 08:55 -0700, Stanislav Fomichev wrote:
> > This new argument will be used in the next patches for the
> > eth_get_headlen use case. eth_get_headlen calls flow dissector
> > with only data (without skb) so there is currently no way to
> > pull attached BPF flow dissector program. With this new argument,
> > we can amend the callers to explicitly pass network namespace
> > so we can use attached BPF program.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/linux/skbuff.h    | 19 +++++++++++--------
> >  net/core/flow_dissector.c | 27 +++++++++++++++++----------
> >  net/ethernet/eth.c        |  5 +++--
> >  3 files changed, 31 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index beaedd487be1..ee7d1a85f624 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1284,7 +1284,8 @@ bool __skb_flow_bpf_dissect(struct bpf_prog
> > *prog,
> >                           const struct sk_buff *skb,
> >                           struct flow_dissector *flow_dissector,
> >                           struct bpf_flow_keys *flow_keys);
> > -bool __skb_flow_dissect(const struct sk_buff *skb,
> > +bool __skb_flow_dissect(const struct net *net,
> > +                     const struct sk_buff *skb,
> >                       struct flow_dissector *flow_dissector,
> >                       void *target_container,
> >                       void *data, __be16 proto, int nhoff, int hlen,
> > @@ -1294,8 +1295,8 @@ static inline bool skb_flow_dissect(const
> > struct sk_buff *skb,
> >                                   struct flow_dissector
> > *flow_dissector,
> >                                   void *target_container, unsigned
> > int flags)
> >  {
> > -     return __skb_flow_dissect(skb, flow_dissector,
> > target_container,
> > -                               NULL, 0, 0, 0, flags);
> > +     return __skb_flow_dissect(NULL, skb, flow_dissector,
> > +                               target_container, NULL, 0, 0, 0,
> > flags);
> >  }
> >
> >  static inline bool skb_flow_dissect_flow_keys(const struct sk_buff
> > *skb,
> > @@ -1303,18 +1304,19 @@ static inline bool
> > skb_flow_dissect_flow_keys(const struct sk_buff *skb,
> >                                             unsigned int flags)
> >  {
> >       memset(flow, 0, sizeof(*flow));
> > -     return __skb_flow_dissect(skb, &flow_keys_dissector, flow,
> > -                               NULL, 0, 0, 0, flags);
> > +     return __skb_flow_dissect(NULL, skb, &flow_keys_dissector,
> > +                               flow, NULL, 0, 0, 0, flags);
> >  }
> >
> >  static inline bool
> > -skb_flow_dissect_flow_keys_basic(const struct sk_buff *skb,
> > +skb_flow_dissect_flow_keys_basic(const struct net *net,
> > +                              const struct sk_buff *skb,
> >                                struct flow_keys_basic *flow, void
> > *data,
> >                                __be16 proto, int nhoff, int hlen,
> >                                unsigned int flags)
> >  {
> >       memset(flow, 0, sizeof(*flow));
> > -     return __skb_flow_dissect(skb, &flow_keys_basic_dissector,
> > flow,
> > +     return __skb_flow_dissect(net, skb, &flow_keys_basic_dissector,
> > flow,
> >                                 data, proto, nhoff, hlen, flags);
> >  }
> >
> > @@ -2494,7 +2496,8 @@ static inline void
> > skb_probe_transport_header(struct sk_buff *skb)
> >       if (skb_transport_header_was_set(skb))
> >               return;
> >
> > -     if (skb_flow_dissect_flow_keys_basic(skb, &keys, NULL, 0, 0, 0,
> > 0))
> > +     if (skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
> > +                                          NULL, 0, 0, 0, 0))
> >               skb_set_transport_header(skb, keys.control.thoff);
> >  }
> >
> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> > index ef6d9443cc75..f32c7e737fc6 100644
> > --- a/net/core/flow_dissector.c
> > +++ b/net/core/flow_dissector.c
> > @@ -722,6 +722,7 @@ bool bpf_flow_dissect(struct bpf_prog *prog,
> > struct bpf_flow_dissector *ctx,
> >
> >  /**
> >   * __skb_flow_dissect - extract the flow_keys struct and return it
> > + * @net: associated network namespace, derived from @skb if NULL
> >   * @skb: sk_buff to extract the flow from, can be NULL if the rest
> > are specified
> >   * @flow_dissector: list of keys to dissect
> >   * @target_container: target structure to put dissected values into
> > @@ -738,7 +739,8 @@ bool bpf_flow_dissect(struct bpf_prog *prog,
> > struct bpf_flow_dissector *ctx,
> >   *
> >   * Caller must take care of zeroing target container memory.
> >   */
> > -bool __skb_flow_dissect(const struct sk_buff *skb,
> > +bool __skb_flow_dissect(const struct net *net,
> > +                     const struct sk_buff *skb,
> >                       struct flow_dissector *flow_dissector,
> >                       void *target_container,
> >                       void *data, __be16 proto, int nhoff, int hlen,
>
> LGTM,
>
> Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
>
> Side Note: it is not this patch's fault, but I think that there is lots
> of room for improvement in __skb_flow_dissect parameters set, it seems
> that the function can receives two separate sets of parameters and each
> set is only used when a valid skb is passed, while the other set is
> used when skb is null but data ptr isn't, this makes this function very
> hard to read and track it's flow.
>
> My 2 cent is that we need two versions of __skb_flow_dissect, one that
> uses skb and the other uses data pointer, and the skb version can
> perfectly use the "data" ptr version, it could be a hard re-factoring
> task, but i think it is doable.
Agreed, the only problem with separating those two is __skb_header_pointer
which is occasionally called to fetch more data from the skb frags (for
both data!=NULL and skb!=NULL cases).

I was thinking about changing the order of input params to move skb
to the end (so it looks more optional) and to move all this !data initialization
into a wrapper.

I might look into this at some point..
