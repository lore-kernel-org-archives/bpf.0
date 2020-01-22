Return-Path: <SRS0=pBRf=3L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A26BC2D0DB
	for <bpf@archiver.kernel.org>; Wed, 22 Jan 2020 18:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B00921835
	for <bpf@archiver.kernel.org>; Wed, 22 Jan 2020 18:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="sJRp0psx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAVSHr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:07:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37519 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgAVSHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 13:07:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so313981lfc.4
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2020 10:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=RiWPRMMIW94oOn3WcniI4UvcBxmCL6rmBgal4r7HtqI=;
        b=sJRp0psxE/jQSgHKovsMY4pAqhyarBtkzftC+GFTxUUo6oQ6K6yYzyQGejwhgaBE/+
         Xdys35Sk7dRH1c+FIdwggMGiIEKhFKZ/sGvbf6Y9WmvnxTohTC4PZsEZP88StDENQTHA
         ha9um3tk95yL0iKOUgOsqfnN6/fz9svGoBtIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=RiWPRMMIW94oOn3WcniI4UvcBxmCL6rmBgal4r7HtqI=;
        b=spglSZvkcaXXRwTvSsTrhrmMdbPxs7QH7nCpFbtSgnExMkvABWaeiiOq2MhgnOm/E8
         +hiOzJvATRfFt2O7Rj2KDqidj+9qy+vQdxCAUaAcr1eIgOaLz0LNnL513QT7+huK03ht
         mQODy1FYcO2uu9ncafrmDXxcasSaYjJbfLURjxtzAPGs74R+dXpa85szBQTGMWGLm7tq
         4nR6aB0cIJv4QIyWN0/sDYNdvqpR7GZlIWUX5IuBAgUNkzIEydq9SmgE0Jd/LylGY3IA
         ZBIzx0H8V0DKSpIH9F1aEOzFSHvEbXP2S2mYMgArzhnJVuaMYuPYAJcBAn7KK0jWS7sL
         ayhA==
X-Gm-Message-State: APjAAAV2aNbzktTrCAqzO35zEHJiI3nu83U3NlRvvIC/Z6jwLqEOLuep
        PgEgZsxGIYEC9UAl6Vt+Hs23DPEbj2+JWA==
X-Google-Smtp-Source: APXvYqyyNqzdDNqIMEP1+8DKo3ma4T4KgZ8SkoCZW0CxF5Wo1h36FdAhduXA1kPxYEeDZR6RmCraBQ==
X-Received: by 2002:a19:7401:: with SMTP id v1mr2502943lfe.129.1579716465041;
        Wed, 22 Jan 2020 10:07:45 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id f8sm3895313lfc.22.2020.01.22.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:07:44 -0800 (PST)
References: <20200122130549.832236-1-jakub@cloudflare.com> <20200122130549.832236-7-jakub@cloudflare.com> <CACAyw9_bbZQD604YTJTM7G9rGgON6buoL11zzu0YW_pAa2U0AA@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next v3 06/12] bpf, sockmap: Don't set up sockmap progs for listening sockets
In-reply-to: <CACAyw9_bbZQD604YTJTM7G9rGgON6buoL11zzu0YW_pAa2U0AA@mail.gmail.com>
Date:   Wed, 22 Jan 2020 19:07:43 +0100
Message-ID: <87zhefqs9c.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 22, 2020 at 05:24 PM CET, Lorenz Bauer wrote:
> On Wed, 22 Jan 2020 at 13:06, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> @@ -352,7 +376,15 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
>>         if (!link)
>>                 return -ENOMEM;
>>
>> -       ret = sock_map_link(map, &stab->progs, sk);
>> +       /* Only established or almost established sockets leaving
>> +        * SYN_RECV state need to hold refs to parser/verdict progs
>> +        * and have their sk_data_ready and sk_write_space callbacks
>> +        * overridden.
>> +        */
>> +       if (sk->sk_state == TCP_LISTEN)
>> +               ret = sock_map_link_no_progs(map, sk);
>> +       else
>> +               ret = sock_map_link(map, &stab->progs, sk);
>
> Could you use sock_map_redirect_okay from the previous patch here
> instead of checking for TCP_LISTEN?

Makes sense. Queuing it for next iteration if more things pile up.

To give the rest of reviewers some context - Lorenz started looking at
adding bare-bones support for UDP to sockmap. Bare-bones meaning that
UDP sockets could be inserted/deleted into/from sockmap, but not spliced
with sockmap.

Being consistent about how we check if a socket can be used for splicing
will make extending it for UDP easier.

Thanks,
-jkbs
