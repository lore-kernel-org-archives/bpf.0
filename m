Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28453C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 02:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60F921841
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 02:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgA/NPUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCTCPN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:15:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34277 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfCTCPN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 22:15:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id a16so637065edn.1;
        Tue, 19 Mar 2019 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S03chWOuYds6NvnLDQalOFcuuc/q7ZhcibBUXvFENuQ=;
        b=XgA/NPUTO4k7WT2chRCh5WPguAmVHv6mbdVcZ5t40xZTmo5d57rD6umaIHTwzEwUKN
         Wt2KHqZjDJzHP7fj1/y/4JNngWjh9ecVKFb8xZyVk5OyICOK/1To7z+mQyWwlQKtClLd
         pYX1YWKrEAkjO1Ifc1ey6BVQYUGxYiE2RAKie+EemrELuCF78zlhr75EMkCkiQzfqrc6
         zWsE77p+r/uwU2KSPZqj4WcuSSKHG3TV2nt+3JztVNdbXqjKnOyjHBSVtmZNF9e+rDFA
         SU9EDq0Kxeo+CdLa5erl1kF0NtlIrkSxHF90UGAFqdRFidq8CIN1ngBosxrnjJYiIo/f
         31Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S03chWOuYds6NvnLDQalOFcuuc/q7ZhcibBUXvFENuQ=;
        b=A5qES7XtBH4nP87z76c2uBLYdzSiBWPRfZSwBu9OnffsaDCq6lVJ09s7DHEott0DrS
         6Y5WBpI5S69R/Oa4C1vxvE2sYYrMzPHwBCmSz5zNLgV0g/2ZJqD2agJw8Qpqrma98dY/
         u0QX/Lz1auy2HnTEHl8godstHYdkN/ZY1+HhEbAVT/5J0sx7bkbY+65zrNj3uzYI+zHj
         geODoX+6XM6QRjI1CDJkH3Jrz2XZskV0EWkTBfc/ujWOe0nPG6d1eCTNwbkRAmbJW3/H
         QQBfzEWUTKnTKKWlQwyvHukTCAQpTMhBXScwHdJqvObA8tqSer9LfGW71FhYxVjLbA3m
         LbiQ==
X-Gm-Message-State: APjAAAWWRgW5dafiYlepqHgKKMEc4xq4Hg8Pf5nW7qY1iJVFkdn/z1PY
        3o2AMvdEJgKPAfdUJLFjdagjaCVApCr4HyhpW/E=
X-Google-Smtp-Source: APXvYqyuZ2ib4oFc47JMVPJyGjB/5PW36rz2PfdqHLKXqi518aN18k1NuyZVFVlyzQoyeTwZblaqKeuD0BbY5pA/Mo0=
X-Received: by 2002:a50:f286:: with SMTP id f6mr4826960edm.139.1553048111378;
 Tue, 19 Mar 2019 19:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com> <20190319221948.170441-3-sdf@google.com>
In-Reply-To: <20190319221948.170441-3-sdf@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 19 Mar 2019 22:14:35 -0400
Message-ID: <CAF=yD-JbxFKSVGuXz0-LbzAzSkMR-wZFEQe0e1mck2EY6vn3vg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] net: introduce skb_net helper
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Network Development <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        simon.horman@netronome.com, Willem de Bruijn <willemb@google.com>,
        Petar Penkov <peterpenkov96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 19, 2019 at 6:20 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> skb_net returns network namespace from the associated device or socket.
>
> This will be used in the next commit.
>
> I tried to inline it in skbuff.h, but I don't think it's feasible.

If so, is this helper necessary?

All existing cases that use it pass both skb_net(skb) and skb to the
flow dissector, so can continue to call it locally if new argument net
is NULL.

The new users are in patch 9/9 in the device drivers, but those should
pass the device pointer unconditionally.



> It depends on 'net/sock.h' for sock_net() and 'linux/netdevice.h' for
> dev_net(), both of which we don't include from 'linux/skbuff.h' (but
> both sock.h and netdevice.h include skbuff.h). I though about doing
> it as a macro/putting it somewhere else, but we will have
> skb_flow_dissect{_xyz} use it in the next commits.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/linux/skbuff.h |  2 ++
>  net/core/skbuff.c      | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index e8c1d5b97f96..75e1d4d73cca 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1275,6 +1275,8 @@ static inline int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr)
>  }
>  #endif
>
> +struct net *skb_net(const struct sk_buff *skb);
> +
>  struct bpf_flow_keys;
>  bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
>                             const struct sk_buff *skb,
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b413354ee709..d81f3a95fb4e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5725,3 +5725,19 @@ void __skb_ext_put(struct skb_ext *ext)
>  }
>  EXPORT_SYMBOL(__skb_ext_put);
>  #endif /* CONFIG_SKB_EXTENSIONS */
> +
> +/**
> + * skb_net - Return network namespace associated with skb.
> + * @skb: skb
> + *
> + * Returns pointer to struct net or NULL.
> + */
> +struct net *skb_net(const struct sk_buff *skb)
> +{
> +       if (skb->dev)
> +               return dev_net(skb->dev);
> +       else if (skb->sk)
> +               return sock_net(skb->sk);
> +       return NULL;
> +}
> +EXPORT_SYMBOL(skb_net);
> --
> 2.21.0.225.g810b269d1ac-goog
>
