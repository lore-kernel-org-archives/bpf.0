Return-Path: <SRS0=Im41=TX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE42C282DD
	for <bpf@archiver.kernel.org>; Thu, 23 May 2019 11:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687E320851
	for <bpf@archiver.kernel.org>; Thu, 23 May 2019 11:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfEWLZq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 May 2019 07:25:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41719 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbfEWLZq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 07:25:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id q16so5094083ljj.8
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 04:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SrYXsYajuhxHoYUyiFBd8Tl+QmrENDXMAS1vXU2GDmk=;
        b=hmlN/tseKmC3wbuOAd1VY6S5uNt32yn+f1l83fQWeiKKEPTZuXkpx/s7xSR0kVID+2
         kc1XHfoQPOsu66IoR1RjNksvsuimhQN/4cF3YWZHNJ1H0EB+dUKk8nA93rg885GRZ2Sj
         L/7IrF9t15V58k+v1HCLfeMBd4ZsDne1pGsxdkZCBiN4O6jOv8yPJHeEvwdxPuTPDX1t
         RFcUtICAuboEs6naTqXTJLSW7lk2tYlBX8VhtUhrj9VlNSyZaAYjy74Ujy7sirI62zVn
         QBL3OteX+i5m8Cskkh47Z4i1EyI2o23pENa/ULsBKQhZh9Y7ydOLPCJW1a3qhryH4Nza
         NwAQ==
X-Gm-Message-State: APjAAAXNDj9dm5zjgXYebRR/u0RySa68evCKrsHJZadURZpd8MGM5gQ8
        oNGNSfdNQksNvGVAZEMyS2aXzg==
X-Google-Smtp-Source: APXvYqyH2WNXzf0sY4Zfc0VvB7Ym06Z0i+3CkgkwpnAjAUzvRTCKfo/WBlR7bk3l2r85cxF8ZGh21w==
X-Received: by 2002:a2e:9acb:: with SMTP id p11mr19382428ljj.129.1558610744451;
        Thu, 23 May 2019 04:25:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id i74sm6064892lfg.78.2019.05.23.04.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 04:25:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 953EF1800B1; Thu, 23 May 2019 13:25:42 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        netdev@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/3] veth: Support bulk XDP_TX
In-Reply-To: <1558609008-2590-4-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1558609008-2590-1-git-send-email-makita.toshiaki@lab.ntt.co.jp> <1558609008-2590-4-git-send-email-makita.toshiaki@lab.ntt.co.jp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 23 May 2019 13:25:42 +0200
Message-ID: <87zhnd1kg9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> writes:

> This improves XDP_TX performance by about 8%.
>
> Here are single core XDP_TX test results. CPU consumptions are taken
> from "perf report --no-child".
>
> - Before:
>
>   7.26 Mpps
>
>   _raw_spin_lock  7.83%
>   veth_xdp_xmit  12.23%
>
> - After:
>
>   7.84 Mpps
>
>   _raw_spin_lock  1.17%
>   veth_xdp_xmit   6.45%
>
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---
>  drivers/net/veth.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 52110e5..4edc75f 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -442,6 +442,23 @@ static int veth_xdp_xmit(struct net_device *dev, int n,
>  	return ret;
>  }
>  
> +static void veth_xdp_flush_bq(struct net_device *dev)
> +{
> +	struct xdp_tx_bulk_queue *bq = this_cpu_ptr(&xdp_tx_bq);
> +	int sent, i, err = 0;
> +
> +	sent = veth_xdp_xmit(dev, bq->count, bq->q, 0);

Wait, veth_xdp_xmit() is just putting frames on a pointer ring. So
you're introducing an additional per-cpu bulk queue, only to avoid lock
contention around the existing pointer ring. But the pointer ring is
per-rq, so if you have lock contention, this means you must have
multiple CPUs servicing the same rq, no? So why not just fix that
instead?

-Toke
