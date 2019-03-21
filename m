Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AB7C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 20:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BFB2190A
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 20:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRrGXVRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfCUU4y (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:56:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35713 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfCUU4y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 16:56:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id t13so226647lji.2;
        Thu, 21 Mar 2019 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAd/Fk+2HbmoD1UWkRfM4ibaDWHGtbkC1k7Q8NSLquE=;
        b=QRrGXVRO9JVGzsOhuibpmwWpD+7YJ1KBAiwPqUKcxIUAbEkiTNFsyf+Jn6QevkseGp
         /rb4Sl+fLVUhqh9oV1KKf/SW6M7SOJ/AEvuB/3MjXsKSaHsdBpIRCnzLa3ZYiK6sAIUA
         O+icsOmIe0Vy+NVEvI2CifLQWELXvIgC5FGYTOuw/Fj4eDLPmSAAmmXbD/yktyU8D5ok
         gV1V2HsGBksWKidIlOkXL38fbczTPmAD5lj/5sb699QCeASUx8Uwuk47+zdDixty5t4N
         NnMSM0gmaETb3ZmJcnu6SLPOLsdP2ylPyfM9HRHJcElyeiI4KC6wCLfh1Hdh4O0xNhoS
         r/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAd/Fk+2HbmoD1UWkRfM4ibaDWHGtbkC1k7Q8NSLquE=;
        b=FMceOmai9sk0omJizDj7sDNGbwHKMEEw/I2xyuShjR811+Td9M+iFLU1PMmORLHtwl
         gWKyVsAxGZjQ6GqImvkMq/32vJAznvYLx/PuPM6HvJYfNshka4glvZiIwLme3ndATinH
         i51NzkuFm5JbBuVUr4d7USggH5U5LvUMDNzG89c+MaDAk6i4DgbYIFwfo2QznaWgVCmP
         63F8ZrNZgZWTHKWd2udqFHQG090KddWwH+6eJnMVOcqmyzgYZ3P6bo3wsxrn7LoKVZgy
         9gjVKkZ/VMyhtF8I7bwtLiPBr/Wmbrtk/sniHmBfCbUKusjiQBSWbmL/Yz6tAre1ZOt6
         fpng==
X-Gm-Message-State: APjAAAVFua2F9MUqhgS4ikKlbd+i1n76JzyxBh9wgNaX17wUDuo23xaR
        ZOlaId+92ootOmQyjvFHfdG/25yy2+IJ+JTXKFI=
X-Google-Smtp-Source: APXvYqwU6M76TGcNJIZ5uwUBUg2F6PVOJkbEuwJhNod/xwkrzZqfjGdbVd9uttNTsLSa49dp4WLLVQHE0prVI/RGWco=
X-Received: by 2002:a2e:a284:: with SMTP id k4mr2852400lja.99.1553201812100;
 Thu, 21 Mar 2019 13:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com> <20190319221948.170441-2-sdf@google.com>
 <20190321033941.bygpejl2krltkdmm@ast-mbp.dhcp.thefacebook.com>
 <6406eae2-4633-9b2a-1101-2de48d29f9dd@gmail.com> <CAF=yD-KFZ2-p8BWf_EBpqCbpzeqwLbqtZutio5WM6MP62G7wKQ@mail.gmail.com>
 <20190321154433.GS7431@mini-arch.hsd1.ca.comcast.net> <20190321160057.57u7ahijddqwtfdd@ast-mbp.dhcp.thefacebook.com>
 <CAF=yD-+-aR7r2u+xEXQfn1u7e9-s2F9qmQXR4w-8Qw0BEvb6Pg@mail.gmail.com>
In-Reply-To: <CAF=yD-+-aR7r2u+xEXQfn1u7e9-s2F9qmQXR4w-8Qw0BEvb6Pg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Mar 2019 13:56:40 -0700
Message-ID: <CAADnVQJ+_aEWnMe8FfDX6_5muxgXUPynPrpH62ezwjRORm5RgQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 1/9] net: introduce __init_skb{,_data,_shinfo} helpers
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Stanislav Fomichev <sdf@fomichev.me>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@netronome.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 21, 2019 at 9:13 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Mar 21, 2019 at 12:01 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 21, 2019 at 08:44:33AM -0700, Stanislav Fomichev wrote:
> > >
> > > If we can agree that we switch everything to xpd-like, do we deprecate the
> > > skb-one?
> >
> > This whole discussion that have been going on for long time is an indication
> > that initial bpf flow dissector concept was not thought through
> > and I regret on merging it in the first place.
> > Adding more hacks on top of it with fake skbs is not going to make it any better.
> > Since it's been in the official release we cannot remove it now.
>
> This patch set addresses the only open issue.
>
> That said, if direction is towards an alternative interface, then it would
> make sense for the new interface to supplant the existing one for all
> use-cases, even if that existing one cannot be removed.
>
> Essentially a BPF_PROG_TYPE_FLOW_DISSECTOR_RAW that
> takes a simpler context than skb. And either that or a program of
> type BPF_PROG_TYPE_FLOW_DISSECTOR can be attached in
> skb_flow_dissector_bpf_prog_attach, but not both.

another idea is to keep 'struct __sk_buff' as a context,
but have kernel side to be something like struct xdp_buff
and disallow access to fields of __sk_buff depending on
attach_type.
and do different ctx rewrite for __sk_buff->foo
depending on attach_type.
