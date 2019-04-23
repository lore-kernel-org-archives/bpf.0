Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7262C282DD
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C8E208E4
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 16:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmU4VR2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfDWQZQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:25:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44900 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfDWQZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 12:25:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id i13so13153124edf.11;
        Tue, 23 Apr 2019 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbmn1ABPZG02jL61shQbasPDCAUP/9BAoQVxRAiyNnA=;
        b=WmU4VR2ZvEIkcOzAx+FbcjWzElYFL4xzvJlAaBLJemB8O1VQRO6jGOQzJQwUA4KYNe
         Knw4ose1oWdgycioxBHBnwnBOSlpEv1LvePKuMli4vOTvttdHKCSpovb9uAhnUBpUBXB
         2Kx/t4YZLaMVRgc94LZQhUqwN+kgrcHkgevmoxIai4qRco+VpAsefkmxGw+EF4BHdfZn
         qMrkznO55p9QzMTLkT8NZPd9mCJqGFfQMsLWCpVzFOHxveDM9pPxgV1Gj7/TXHBd0evm
         Qp6Q2y2VIPPROPm2VMSDnBivJJeXJLgearQYXBVegWRROf19L98igfWl0CIJn8hNV5tW
         PLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbmn1ABPZG02jL61shQbasPDCAUP/9BAoQVxRAiyNnA=;
        b=QhzXqnH6W3C/POS2p+Q5H3bISFmU3Ds3ROH6HYqo7ypPvpDAtsD3s607dHMzuepb60
         Qzn9HzGEKAEOvjfCU+4fEiSeaUmKI1dzjA4kqwuusTFZhrR4d1/hRipkE427LrzFqIXq
         KlbVTKxLUTO5ZSiBgexxPIR8yvrlrjDW/Je+illcaR8OC8F22OlwWHPnh2j09Xl4KSp8
         D883Y32hCuWXc0yXcy8HlPjc6y/DsXFCpGio3qZBdIp/9sPjx4pTCv/usu+ypFhOkv3L
         bCrXahYL9Z9A29vXXqDEhs7Hxt/Zi5J620VLMwZ/oskmK7BKY/148AEDSZGQs1Ncnfw0
         FM1g==
X-Gm-Message-State: APjAAAWjh9zDWY7N7cQYN+pzGT1o7OlwqCCkAUyvUF2VHW0I6OBgz10s
        jH+05B1AbY5KyvGEV41Vfhcix4HpEktRuk32/VxUtg==
X-Google-Smtp-Source: APXvYqwDUwC92xkb6QwE76tdrnS522bXM5YWH/hPjsrDQzyVy1ZrCa8/QLNyA6681absM4QZZgQ+Afp13AoENrrnNU8=
X-Received: by 2002:a50:adda:: with SMTP id b26mr3127005edd.2.1556036711677;
 Tue, 23 Apr 2019 09:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com> <20190423041503.np4dlso7c6qw3wfv@ast-mbp>
 <CANn89i+WFCQYxi-efjEBaAHY3rorornJ5dhGgQegBTkgwm1ZOQ@mail.gmail.com> <CANn89iJY3jYqanGGLgbR43ucTNYYu7bhgF=uaJCHgLg8_KEHsw@mail.gmail.com>
In-Reply-To: <CANn89iJY3jYqanGGLgbR43ucTNYYu7bhgF=uaJCHgLg8_KEHsw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 23 Apr 2019 12:24:35 -0400
Message-ID: <CAF=yD-K244NQghPTCLMhMJTrX3Kq73BUBK5d-dph1fYA3ONHMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/9] net: flow_dissector: trigger BPF hook
 when called from eth_get_headlen
To:     Eric Dumazet <edumazet@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
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

On Tue, Apr 23, 2019 at 12:21 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Apr 23, 2019 at 9:00 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Apr 22, 2019 at 9:15 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >
> > > Eric and Willem, could you please take a look as well
> > > and hopefully ack it ?
> >
> > Sure, I am taking a look.
>
> For the series :
>
> Acked-by: Eric Dumazet <edumazet@google.com>
>
> Thanks

Just finished going over it as well.

Acked-by: Willem de Bruijn <willemb@google.com>

Very nice solution wrt testing.
