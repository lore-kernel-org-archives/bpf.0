Return-Path: <SRS0=4Daw=T4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FEEC04AB6
	for <bpf@archiver.kernel.org>; Tue, 28 May 2019 21:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740A3208CB
	for <bpf@archiver.kernel.org>; Tue, 28 May 2019 21:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7Z0cnEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfE1VEt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 May 2019 17:04:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44083 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfE1VEs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 May 2019 17:04:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id m2so51023qtp.11;
        Tue, 28 May 2019 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdLChIagF/mUw9YeOGCyBWe4oSr7/uq03RdN8WKEtoE=;
        b=t7Z0cnEoHbRttMLaJ2OZYhYrpNVTkmvzkZD1h2FFhSmqVie8V8PN3sWppFcjRqzei0
         vIRvWZF8NSYs04ntwz0lW0xXYkbIHp3r+Bp7I33ouCQ5W/EiLHYgfh1cXGaTC21I9Ohf
         tKvBWKKLxO8qOB1isHGkLXB8gXXee2nlbzZdtOcV0YlC2jhEsFUqVwWYnQuoosTqt5ub
         zgstAhcBiHQu/jBIQKESnoq1X6dXBxu7O4b7LhqIprQwiVNZsqThAcqyocm7BnkfnQ3K
         acE45duVO4ulHhm4Xfkt1GqSS4qWtvZgZQzTjAtyI6GT/uz9SAtr/ewfKhham7BfG6a6
         NSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdLChIagF/mUw9YeOGCyBWe4oSr7/uq03RdN8WKEtoE=;
        b=V3mExFUHHEL7al1hp03nbdDTvUsHMhlsfE0km8oMBOoxGwllBlVgMbKX6kG/Wp7Nbq
         g8C9ApLpv6qHrwEbHeeCib1FFc3pRy3KLl/GNjgL0vXKuqo9SkMZFR98PWI3Gz/tg6ku
         k8mXZu6dOYc7s6OQRrIKawEj9hf0XLYCjWAq3kp9U2eDwOMfvKlTHtmsAhCcUq8XSibn
         k3tf3dd/r1VvBKdbH2RcugQiRp7oj9uyrmR0dbss4WoaZ5++/WQabWCnZ7h3S1nao3pM
         HPKHFhJdqMSjMDpzempNCRuu30tD1zvaZHveE1+IF8qgaisTccgf5+uLj+q6eU8rnr2y
         DHtw==
X-Gm-Message-State: APjAAAVNd/ieLK+CZAhvX1qeJe69QzqGOpn7xGeNAO3pMGwdzAVfzDjc
        9lljhHPpgvQuA5fnaRI772FGuYKyQfCvZtmbhLeA0Es4
X-Google-Smtp-Source: APXvYqzKlUW5I4Fmxa9kh82xNKHZ7Zj8btGNodhYAGUa9x0xZc3DMkxPUcIksraU56XPkqAalTpqw4C6sO+FlUFn9WM=
X-Received: by 2002:aed:3b66:: with SMTP id q35mr14897917qte.118.1559077487843;
 Tue, 28 May 2019 14:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <56c1f2f89428b49dad615fc13cc8c120d4ca4abf.camel@domdv.de>
In-Reply-To: <56c1f2f89428b49dad615fc13cc8c120d4ca4abf.camel@domdv.de>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 28 May 2019 14:04:36 -0700
Message-ID: <CAPhsuW4TV5m_E3iO7FNyFoKwsKzGSZizbPfciHOJtun-=H_biA@mail.gmail.com>
Subject: Re: [RFC][PATCH kernel_bpf] honor CAP_NET_ADMIN for BPF_PROG_LOAD
To:     Andreas Steinmetz <ast@domdv.de>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 28, 2019 at 9:59 AM Andreas Steinmetz <ast@domdv.de> wrote:
>
> [sorry for crossposting but this affects both lists]
>
> BPF_PROG_TYPE_SCHED_CLS and BPF_PROG_TYPE_XDP should be allowed
> for CAP_NET_ADMIN capability. Nearly everything one can do with
> these program types can be done some other way with CAP_NET_ADMIN
> capability (e.g. NFQUEUE), but only slower.
>
> This change is similar in behaviour to the /proc/sys/net
> CAP_NET_ADMIN exemption.
>
> Overall chances are of increased security as network related
> applications do no longer require to keep CAP_SYS_ADMIN
> admin capability for network related eBPF operations.
>
> It may well be that other program types than BPF_PROG_TYPE_XDP
> and BPF_PROG_TYPE_SCHED_CLS do need the same exemption, though
> I do not have sufficient knowledge of other program types
> to be able to decide this.
>
> Preloading BPF programs is not possible in case of application
> modified or generated BPF programs, so this is no alternative.
> The verifier does prevent the BPF program from doing harmful
> things anyway.
>
> Signed-off-by: Andreas Steinmetz <ast@domdv.de>
>
> --- a/kernel/bpf/syscall.c      2019-05-28 18:00:40.472841432 +0200
> +++ b/kernel/bpf/syscall.c      2019-05-28 18:17:50.162811510 +0200
> @@ -1561,8 +1561,13 @@ static int bpf_prog_load(union bpf_attr
>                 return -E2BIG;
>         if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
>             type != BPF_PROG_TYPE_CGROUP_SKB &&

You should extend this if () statement instead of adding another
if () below.

Thanks,
Song

> -           !capable(CAP_SYS_ADMIN))
> -               return -EPERM;
> +           !capable(CAP_SYS_ADMIN)) {
> +               if (type != BPF_PROG_TYPE_SCHED_CLS &&
> +                   type != BPF_PROG_TYPE_XDP)
> +                       return -EPERM;
> +               if(!capable(CAP_NET_ADMIN))
> +                       return -EPERM;
> +       }
>
>         bpf_prog_load_fixup_attach_type(attr);
>         if (bpf_prog_load_check_attach_type(type, attr->expected_attach_type))
>
