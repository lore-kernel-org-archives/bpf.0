Return-Path: <SRS0=zD4z=YI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3E2ECE59D
	for <bpf@archiver.kernel.org>; Tue, 15 Oct 2019 23:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116F520872
	for <bpf@archiver.kernel.org>; Tue, 15 Oct 2019 23:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReU7WC9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbfJOXPF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:15:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39685 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfJOXPF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 19:15:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so33233172qtb.6;
        Tue, 15 Oct 2019 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfMbQ8a8meesI1NI4Hqulr+S9z9Yk1aV9Dr8Gs57isw=;
        b=ReU7WC9RtpMxJCEv0n/SfjysKXJrZDkbqZg1Li2m6E/8Acuo9CtQH0OJ4Vhgmb/niD
         oPtS1B/KgupEvK+TaVkm/bfkGA0uIdonqihGHFqDgimVmhWa4fE/s6j79GAgIqpTJYHY
         24BIMimWtXRudh+LjzMBDsZhAyZ9iDDHC3/sGhOv+G52W+8F2pUe+IieOi7lk/lrnBqA
         UPiib1G1s/4NokIEPaYHl2wAZwKnv9euQ+GiQnYSnaWA6Ze0ZebQQv6G6GHkxbi5FBuO
         Dum0xiunfIHVS+AgqqcLLnsRn+UVfr2Ii+5nRbr+qmtSXjMsXiDua6v6Fc7YGUBjW2O3
         WO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfMbQ8a8meesI1NI4Hqulr+S9z9Yk1aV9Dr8Gs57isw=;
        b=ozYyEBnGFMHWNYc5pUGX4T1Su8fe30A1Ob9KtUv1/goVwxFKOoCVHnLBXCEnnLXhxL
         OOTihprcWhSFAFaG5c5EVuccwvxglFP2wy4i+iCyvrH/nKrrTdUHhI+TLoSkWGxR2Tvg
         BI8J3AFK91PpdR8JB8TBxsYGhBsSbIffhG3unK4lZiveFs26a7Um5AgEGH/6JP1eUxNN
         WtjWzmbXncY5DPENT14i3oqym5kCbZuZfJbyuQSqnRxhohqA4r0KD25raVnTu/cDTFIm
         7mP/S2fdiQrhnPMCu/7ooVmgVd8z/6RQhsKh90Lim4LgCJ+9Cl8fFHZe0Wl9HX6aXr2T
         F73w==
X-Gm-Message-State: APjAAAWSvz1jmWzqNlGObbEjb+sES8F65eeSX/DzgG81RozSpEvO4+cw
        H9EdH5tmf5OINjncTTS2JS5AiVwT7qQWQEITTbc=
X-Google-Smtp-Source: APXvYqx0/G4mwZlqAhDhZc/MBELQvuFFQ/WVcEhzSG+5ZFLxO0AmNaZRZadu0oYfw6VLn0hueTPkr9ZqJxMAWDP86Jg=
X-Received: by 2002:ac8:5147:: with SMTP id h7mr7234345qtn.117.1571181302685;
 Tue, 15 Oct 2019 16:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191015183125.124413-1-sdf@google.com>
In-Reply-To: <20191015183125.124413-1-sdf@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Oct 2019 16:14:51 -0700
Message-ID: <CAEf4Bzb+ZjwA-Jxd4fD6nkYnKGAjOt=2Pz-4GNWBbxtNZJ85UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: allow __sk_buff tstamp in BPF_PROG_TEST_RUN
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 15, 2019 at 2:26 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> It's useful for implementing EDT related tests (set tstamp, run the
> test, see how the tstamp is changed or observe some other parameter).
>
> Note that bpf_ktime_get_ns() helper is using monotonic clock, so for
> the BPF programs that compare tstamp against it, tstamp should be
> derived from clock_gettime(CLOCK_MONOTONIC, ...).
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  net/bpf/test_run.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 1153bbcdff72..0be4497cb832 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -218,10 +218,18 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
>
>         if (!range_is_zero(__skb, offsetof(struct __sk_buff, cb) +
>                            FIELD_SIZEOF(struct __sk_buff, cb),
> +                          offsetof(struct __sk_buff, tstamp)))
> +               return -EINVAL;
> +
> +       /* tstamp is allowed */
> +
> +       if (!range_is_zero(__skb, offsetof(struct __sk_buff, tstamp) +
> +                          FIELD_SIZEOF(struct __sk_buff, tstamp),

with no context on this particular change whatsoever: isn't this the
same as offsetofend(struct __sk_buff, tstamp)? Same above for cb.

Overall, this seems like the 4th similar check, would it make sense to
add a static array of ranges we want to check for zeros and just loop
over it?..

>                            sizeof(struct __sk_buff)))
>                 return -EINVAL;
>
>         skb->priority = __skb->priority;
> +       skb->tstamp = __skb->tstamp;
>         memcpy(&cb->data, __skb->cb, QDISC_CB_PRIV_LEN);
>
>         return 0;
> @@ -235,6 +243,7 @@ static void convert_skb_to___skb(struct sk_buff *skb, struct __sk_buff *__skb)
>                 return;
>
>         __skb->priority = skb->priority;
> +       __skb->tstamp = skb->tstamp;
>         memcpy(__skb->cb, &cb->data, QDISC_CB_PRIV_LEN);
>  }
>
> --
> 2.23.0.700.g56cf767bdb-goog
>
