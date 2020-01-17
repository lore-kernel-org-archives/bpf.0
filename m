Return-Path: <SRS0=dKsF=3G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D0C33CAF
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 01:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC75A206D7
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 01:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugp3anPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAQBuZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jan 2020 20:50:25 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40010 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgAQBuY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 20:50:24 -0500
Received: by mail-il1-f194.google.com with SMTP id c4so20021574ilo.7;
        Thu, 16 Jan 2020 17:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tHtqe+vbud/w0IaK1ugZ2tB2D6H3Z6b7eSEBjo6CMi0=;
        b=Ugp3anPFnM6hWsR/PQbGMLK7SoczhvQsl5NKeBhUMAUdj6b4wjZpmpn5tvnVy51cGJ
         ZbZqMgSTBKWWry8StchUVarxFZXkKXGIOcyzecXgi3rbMMLE0k4esRbx919Hs6J+Oy50
         U/IBqGozxBGhVFzEp1YTgSrCPv9UgJMQ7xZVhmU/8Z+u469o7cbwayJQnt+x9BsKhAl/
         SkzW7cyCxQFwFnj3KQeHpK130oTp2Y4elt2+30TeGmPGX6ejscwV65yutl7bYtO9PGc4
         5apSll8DpWwQNKflpegatdPltxhIjfa0JUS/Q1icpJUP/rSfoyUMt30DGLYdTnq9ISde
         VGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tHtqe+vbud/w0IaK1ugZ2tB2D6H3Z6b7eSEBjo6CMi0=;
        b=Kq1wpIIhJ+7jcmZ3yOBGyK8JGib6W+uJDoIZCzHxm3TiPTRfJLdvEVwd29d2xyVqYB
         59XjjwEOHHnKrLJIpTqQlqG5EepsQaTKT5flF0Vs/bDoFNuyo9yO8d0b19lRh2fa/Vlm
         lkABNg+Q4qu/+j+4w1cPFzvqgdRl6q7JxcRPPV1L2gLorB6yh/nFmir7KIuiQhf+599s
         9O8HLZxu+BZ1AV9vK0jndZFp4InFtBQYPDUlT2VRaSk1DetoLnZ1uuAgjGtJQP3T/YcT
         bbN+YsSMyVFNVkUnrFdL2n3HWx0JMjPJIzrTwwSbVM/WWm+z20qAn9rz9KjEsVB0wf8l
         ZKKg==
X-Gm-Message-State: APjAAAWhdQL8JXZEh6yG/0bMKnZzG3Q44rJlNPnSGoGYQa8XKXGxcFnG
        ET0dFmh8GftcFGdlWTZH0KnHEN2MIrhGkDA+s5U=
X-Google-Smtp-Source: APXvYqzhyxjHVJxRzGsk2t8Y5ErnEKJgdb/HckAVDjL5vsCFh0lFzROCUaocCldZ8KRdnRW7vmR201gnoqSbLj058fo=
X-Received: by 2002:a92:5855:: with SMTP id m82mr1151491ilb.302.1579225824225;
 Thu, 16 Jan 2020 17:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20200116085133.392205-1-komachi.yoshiki@gmail.com>
 <20200116085133.392205-2-komachi.yoshiki@gmail.com> <CAGdtWsQ4aigyJUjBxmFQ8C5zU_4p-t0K2=uwVg2NxdUQuh-WoQ@mail.gmail.com>
In-Reply-To: <CAGdtWsQ4aigyJUjBxmFQ8C5zU_4p-t0K2=uwVg2NxdUQuh-WoQ@mail.gmail.com>
From:   Yoshiki Komachi <komachi.yoshiki@gmail.com>
Date:   Fri, 17 Jan 2020 10:50:12 +0900
Message-ID: <CAA6waG+y97Uw-0OVYXwCz_wRUiDyWSfXr5VmzXofDhAf1Og9pw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] flow_dissector: Fix to use new variables for port
 ranges in bpf hook
To:     Petar Penkov <ppenkov.kernel@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020=E5=B9=B41=E6=9C=8817=E6=97=A5(=E9=87=91) 2:45 Petar Penkov <ppenkov.ke=
rnel@gmail.com>:
>
> On Thu, Jan 16, 2020 at 1:13 AM Yoshiki Komachi
> <komachi.yoshiki@gmail.com> wrote:
> >
> > This patch applies new flag (FLOW_DISSECTOR_KEY_PORTS_RANGE) and
> > field (tp_range) to BPF flow dissector to generate appropriate flow
> > keys when classified by specified port ranges.
> >
> > Fixes: 8ffb055beae5 ("cls_flower: Fix the behavior using port ranges wi=
th hw-offload")
> > Signed-off-by: Yoshiki Komachi <komachi.yoshiki@gmail.com>
> > ---
> >  net/core/flow_dissector.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> > index 2dbbb03..06bbcc3 100644
> > --- a/net/core/flow_dissector.c
> > +++ b/net/core/flow_dissector.c
> > @@ -876,10 +876,17 @@ static void __skb_flow_bpf_to_target(const struct=
 bpf_flow_keys *flow_keys,
> >                 key_control->addr_type =3D FLOW_DISSECTOR_KEY_IPV6_ADDR=
S;
> >         }
> >
> > -       if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS=
)) {
> > +       if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS=
))
> >                 key_ports =3D skb_flow_dissector_target(flow_dissector,
> >                                                       FLOW_DISSECTOR_KE=
Y_PORTS,
> >                                                       target_container)=
;
> > +       else if (dissector_uses_key(flow_dissector,
> > +                                   FLOW_DISSECTOR_KEY_PORTS_RANGE))
> > +               key_ports =3D skb_flow_dissector_target(flow_dissector,
> > +                                                     FLOW_DISSECTOR_KE=
Y_PORTS_RANGE,
> > +                                                     target_container)=
;
> > +
> > +       if (key_ports) {
>
> If the flow dissector uses neither FLOW_DISSECTOR_KEY_PORTS_RANGE, nor
> FLOW_DISSECTOR_KEY_PORTS, I believe key_ports would be used
> uninitialized here. We should probably explicitly set it to NULL at
> the top of this function.

Thank you for kind comments.
I will fix it, and submit the next version later.

Best regards,

--
Yoshiki Komachi

> >                 key_ports->src =3D flow_keys->sport;
> >                 key_ports->dst =3D flow_keys->dport;
> >         }
> > --
> > 1.8.3.1
> >
