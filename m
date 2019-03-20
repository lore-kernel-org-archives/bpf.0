Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20670C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 02:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AEE2184D
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 02:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gewzyMMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCTCPU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:15:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45277 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfCTCPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 22:15:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id m16so584732edd.12;
        Tue, 19 Mar 2019 19:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCSsbgTujROkjIQgUls9VqUaXNwprPv3Y1gzy3x41SE=;
        b=gewzyMMUeDse979UcdTGKLxrOJzStKocEBnX8kWuMY7+/EyYhK6zGJRK9rsgkwesDz
         5LpFvCIugTbLJ2OwkaD4GmLgrHmmnuuGxgEcHnct1fdnCTrxypSBF+HgRoKh7Dr0SzdT
         g5AZ5AJxyXlMlioOQsV1F9TXsQAU9+ooC8eeEq542gKIKt7uvr+jFjnqrotzGVsp8P3C
         kRwlQJLY1CzlAzJy23GKRmxojM3jQUgPolWMnNopSf8wUQ9yqmtPKM9k2zupEreMedBW
         inHX1WOR7ev3jDcsA7KPEhn9xKOuzIgtskWNfRfo7NUvQvcc+EJjj7QNHHcMSU1QXBFU
         F/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCSsbgTujROkjIQgUls9VqUaXNwprPv3Y1gzy3x41SE=;
        b=g7CjPsKo1iR53QAKP1/7Pt7Qeu+E+hlMLQ6Z5ihwaeHK322M1ldvWRMKLnkuvLqxjd
         RT3pG+kjeMernDrYfCShLDyctKWNbKmQIUUxc48f/N3AYOjG8Vs47opGfYjeDg/JTtAR
         R2NLr4V/5hClLqrKhZxKy3Muxt4athWghyun4D7zsBuTlkqax+RpCOV0GwS0JT0+MGq8
         RldZzLMzYz8eGTkzZz50Er/W8yP30tWh+xkyixQZ9OHyKl9vjoc+ZWiCWanRSojbgrSu
         bRYO6PLAMerHpTejwKMdoh8yAI/BH8KPVjYyqrDK2O6266WkloEom+CYX35WZDg8Z56M
         cb3w==
X-Gm-Message-State: APjAAAWKfBCBUzr2SpJ34SBvgvBJ0Sy4OXFvghdZuXBGY2bmUojfyIEe
        sBRgNiHgWSNQF+qeEWt+wenw6wV9LNUVddHQ94Q=
X-Google-Smtp-Source: APXvYqyuPiWrE84vGc4zSntNN7/IiD/MJv/5MTj4DXG7hKQJrSg2CDfxlQBaKGtYC36+GZfrd3vSF7MOqS0jMIuR6/Y=
X-Received: by 2002:a17:906:2501:: with SMTP id i1mr3886512ejb.76.1553048118762;
 Tue, 19 Mar 2019 19:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com> <20190319221948.170441-8-sdf@google.com>
In-Reply-To: <20190319221948.170441-8-sdf@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 19 Mar 2019 22:14:43 -0400
Message-ID: <CAF=yD-+=91KJEV==jE0VLT=FBTyM+j5sLfovk-HTj_2BbCC2Hw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 7/9] bpf: when doing BPF_PROG_TEST_RUN for flow
 dissector use no-skb mode
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

On Tue, Mar 19, 2019 at 6:21 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Now that we have __flow_bpf_dissect which works on raw data (by
> constructing temporary on-stack skb), use it when doing
> BPF_PROG_TEST_RUN for flow dissector.
>
> This should help us catch any possible bugs due to missing shinfo on
> the per-cpu skb.
>
> Note that existing __skb_flow_bpf_dissect swallows L2 headers and returns
> nhoff=0, we need to preserve the existing behavior.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  net/bpf/test_run.c | 48 ++++++++++++++--------------------------------
>  1 file changed, 14 insertions(+), 34 deletions(-)
>

> @@ -300,9 +277,13 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>         preempt_disable();
>         time_start = ktime_get_ns();
>         for (i = 0; i < repeat; i++) {
> -               retval = bpf_flow_dissect_skb(prog, skb,
> -                                             &flow_keys_dissector,
> -                                             &flow_keys);
> +               retval = bpf_flow_dissect(prog, data, eth->h_proto, ETH_HLEN,
> +                                         size, &flow_keys_dissector,
> +                                         &flow_keys);
> +               if (flow_keys.nhoff >= ETH_HLEN)
> +                       flow_keys.nhoff -= ETH_HLEN;
> +               if (flow_keys.thoff >= ETH_HLEN)
> +                       flow_keys.thoff -= ETH_HLEN;

why are these conditional?
