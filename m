Return-Path: <SRS0=nay9=VU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7057C7618B
	for <bpf@archiver.kernel.org>; Tue, 23 Jul 2019 09:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C406227B6
	for <bpf@archiver.kernel.org>; Tue, 23 Jul 2019 09:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xe77j7e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfGWJhl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:37:41 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35903 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfGWJhl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jul 2019 05:37:41 -0400
Received: by mail-ot1-f41.google.com with SMTP id r6so43366959oti.3
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJLBmp3UcQgXAy8r7SgBn/DZj0JZbFiq1vAkMjnkyCs=;
        b=Xe77j7e62YGCOsI3aqFkbt2zOr7PST27REOv5q1UKex1uOn2VXSq6Opr3895VaUR4Y
         eCGfKY+ZAnSfqK5mo3z4Qhf62O7Q6Wmj1WA4/XXhCOUFpGkuiftEKqN4c+gqiWHGOBAl
         Kr0z1WO5InwvjBRyvV7Zov8BQwBLrJg4zQBbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJLBmp3UcQgXAy8r7SgBn/DZj0JZbFiq1vAkMjnkyCs=;
        b=Qd5WLjUoPwt35NpddXsUDKb+z0k3g5UCpFZgQzxAvSg451/kUfRW8G3aUymNkq1BO8
         4tFqo7jWfwOC5/1hHKUJLM8OSmKqpHF850ujTVL3CqBNFjNL1DMtLkGWmE+aRfdoh2ZI
         xGUvxj9tnbH07In0uAH3+ryw4MkslyWGE8fysVRW49I0DlsmXYEltvX0Mt1P+Q65td8r
         gyAjIeaRnryVSMvQVX/mCpQN3uVQlgZ/j0nbuYe2zgQBtRXzY6oeCiNKD22+mft2uVlc
         XF1D7GFaG44jJok/0xnlKuc4nx12UT+Z849JFO6lEfGGUvsdWlxLzOGXpY9zhM/JjN6X
         SnVA==
X-Gm-Message-State: APjAAAWbCrfoh2SiPQpe20fZmlkmtwSOq97fQmZoCRdPxVYHY8nKfyzV
        NCHSXZnVyDUalA1oyttCSaAHGVHyiaC1aB28PUGi5g==
X-Google-Smtp-Source: APXvYqw3z7VevpOyQx0l6zRV9kfnSV0zaQGQhjGkFjujGieKL5VAT4XveiRoEQ7amtDtd/auEZfScZRCFCBKIlXbf0Q=
X-Received: by 2002:a9d:1b21:: with SMTP id l30mr25731590otl.5.1563874660212;
 Tue, 23 Jul 2019 02:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190723002042.105927-1-ppenkov.kernel@gmail.com> <20190723002042.105927-7-ppenkov.kernel@gmail.com>
In-Reply-To: <20190723002042.105927-7-ppenkov.kernel@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 23 Jul 2019 10:37:29 +0100
Message-ID: <CACAyw9-qQ8KbQk6Q6dg0+A337ZbSpot-sHpH_tSxFaQmUfhLyQ@mail.gmail.com>
Subject: Re: [bpf-next 6/6] selftests/bpf: add test for bpf_tcp_gen_syncookie
To:     Petar Penkov <ppenkov.kernel@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        davem@davemloft.net, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Jul 2019 at 01:20, Petar Penkov <ppenkov.kernel@gmail.com> wrote:
> +static __always_inline __s64 gen_syncookie(void *data_end, struct bpf_sock *sk,
> +                                          void *iph, __u32 ip_size,
> +                                          struct tcphdr *tcph)
> +{
> +       __u32 thlen = tcph->doff * 4;
> +
> +       if (tcph->syn && !tcph->ack) {
> +               // packet should only have an MSS option
> +               if (thlen != 24)
> +                       return 0;

Just for my own understanding: without this the verifier complains since
thlen is not a known value, even though it is in bounds due to the check below?

> +
> +               if ((void *)tcph + thlen > data_end)
> +                       return 0;
> +
> +               return bpf_tcp_gen_syncookie(sk, iph, ip_size, tcph, thlen);
> +       }
> +       return 0;
> +}
> +

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
