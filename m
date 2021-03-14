Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C13C433DB
	for <bpf@archiver.kernel.org>; Sun, 14 Mar 2021 10:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B84DF64EB5
	for <bpf@archiver.kernel.org>; Sun, 14 Mar 2021 10:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhCNKPk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 14 Mar 2021 06:15:40 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:42922 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhCNKPR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Mar 2021 06:15:17 -0400
Date:   Sun, 14 Mar 2021 10:15:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1615716915; bh=bM7cn3Afzu5HwMEmA8LHq+iVZuDxZxEEQbnZuhdZvEg=;
        h=Date:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=jpFMl4hp7PYW0YfoBbb27jcEpamNRG53Kbe0U4P2zNXtu+ZXg4SYVY5cMuyC+d0Hn
         V28lFAHmNlil0dmG4Z1dDYZggrLQpnNsWqRSRCBKEFBdDMVfIrEDaT79OzsUEUyHNd
         RVZ6sE83S0YPfPROa9KrfykjYGmNqzQIS6FstZTSYR9ufeNuJcPKk//7GfNDWbBmSl
         7nNb9EOCDNOCpfI+HiVZglkkQOAylsmb//HzrFHW/aTb2mcIoEa+XOYenZH/w3+YFJ
         8hiSEYw7zShjXaIgNe4u7UipqQ4QT/Y1UNl0s+//0XNgxY+1weKsbVWeeqNLqXR2YO
         fHCM1UpjZ+8SQ==
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        jonathan.lemon@gmail.com, edumazet@google.com, willemb@google.com,
        haokexin@gmail.com, pablo@netfilter.org, jakub@cloudflare.com,
        elver@google.com, decui@microsoft.com, vladimir.oltean@nxp.com,
        lariel@mellanox.com, wangqing@vivo.com, dcaratti@redhat.com,
        gnault@redhat.com, eranbe@nvidia.com, mchehab+huawei@kernel.org,
        ktkhai@virtuozzo.com, bgolaszewski@baylibre.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH v2 net-next 0/6] skbuff: micro-optimize flow dissection
Message-ID: <20210314101452.2482-1-alobakin@pm.me>
In-Reply-To: <20210313.181000.1671061556553245861.davem@davemloft.net>
References: <20210313113645.5949-1-alobakin@pm.me> <20210313.181000.1671061556553245861.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 13 Mar 2021 18:10:00 -0800 (PST)

> None of these apply to net-next as per the patchwork automated checks.  A=
ny idea why?

No unfortunately. That'why I sent a follow-up mail. All of them
successfully apply to pure net-next on my machine.
Can it be a Git version conflict? I use 2.30.2, but also tried 2.30.1
and the latest development snapshot, and in either case they got
applied with no problems.

I could have more clue if NIPA provided more detailed log, but didn't
find any. And apply_patches stage doesn't seem to be present on NIPA
GitHub repo, so I couldn't reproduce it 1:1.

I can try again on Monday, not sure if it will help.
I also sent another series yesterday, and it has 15 green lights on
Patchwork, so this problem seems to take place only with this
particular series.

> Thanks.

Thanks,
Al

