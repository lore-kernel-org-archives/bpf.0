Return-Path: <SRS0=/NIo=RH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CACC43381
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 20:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E323E20830
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 20:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QX+XERJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfCDUru (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:47:50 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42830 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCDUrq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Mar 2019 15:47:46 -0500
Received: by mail-ua1-f65.google.com with SMTP id s26so5664008uao.9
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2019 12:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8mwHyTQD3viibZhlwqMBx4el6lQf1vUm4nyYwj8u4Q=;
        b=QX+XERJpa12NN7BG83hwaLrRmRKeSTj/iLPZ5Rvc3NZtHb0XWTH2x5Z0t2+rsxKlU9
         iNMVpLkRMTYeiVTK0Tu8anwvPVL97EYa/4fvIQA9lX5LAcva8M4D8i4m63Nv0fE6Dl0B
         YEsd+8SbGlgiC+DdawHMX8+0BWFfldL2AYZbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8mwHyTQD3viibZhlwqMBx4el6lQf1vUm4nyYwj8u4Q=;
        b=QlUE3r94RC2owT0acGyshz1AjOI975rmigvrPW8hzF74hQLDTt31wPrR2YaCsHyWve
         cexSTcJlJU5VBqZd76vsQZxZg0IF0chphl0cflfMQ+sLNTehjmqOEgahi2bKXw7eS0up
         e/G+oS4+KPk+tVkUpMuLLkOrisbMSId/YnfZsACqxQcjuViSwNDz27rif+UUqy5+gOjU
         eut8GC2c1b0o0EI4hMiDmprHw4kUdq3zokDmH4tp2JWQqlLg4q620KmrBjUVvIB0HizN
         fZHKt6HdXOA58Iwc7mhZq5yynbY9G7bF2xMGorfQkd3mCu0SbZ/ArwdXbo89Ag+y60QS
         eDNg==
X-Gm-Message-State: APjAAAUCr6yIJVPc4HOPyHDtdUnJTj15EcpiD4EG2ndMPkBdXaBPi/94
        FuYgAbiMy4INcrEEw7aH1glawgvuVus=
X-Google-Smtp-Source: APXvYqxfLLQu5rfvLRsKnOKvRfAsRcjzDdumHeK7QhmR0PuaVaFtv1Svsw13/fjB9SLioRxaSWuepg==
X-Received: by 2002:a67:1407:: with SMTP id 7mr10686389vsu.125.1551732464478;
        Mon, 04 Mar 2019 12:47:44 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id x8sm5034996vkc.36.2019.03.04.12.47.42
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 12:47:43 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id j8so5654241uae.13
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2019 12:47:42 -0800 (PST)
X-Received: by 2002:a05:6102:d2:: with SMTP id u18mr10635494vsp.172.1551732462335;
 Mon, 04 Mar 2019 12:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20190304203443.1992942-1-arnd@arndb.de>
In-Reply-To: <20190304203443.1992942-1-arnd@arndb.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 4 Mar 2019 12:47:31 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLfAqwFBGH6VPLKrGXOdeEX4ngKdvsG729MbMOuBU7AcA@mail.gmail.com>
Message-ID: <CAGXu5jLfAqwFBGH6VPLKrGXOdeEX4ngKdvsG729MbMOuBU7AcA@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix sysctl.c warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 4, 2019 at 12:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When CONFIG_BPF_SYSCALL or CONFIG_SYSCTL is disabled, we get
> a warning about an unused function:
>
> kernel/sysctl.c:3331:12: error: 'proc_dointvec_minmax_bpf_stats' defined but not used [-Werror=unused-function]
>  static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
>
> The CONFIG_BPF_SYSCALL check was already handled, but the SYSCTL check
> is needed on top.
>
> Fixes: 492ecee892c2 ("bpf: enable program stats")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 46a0d0a14a66..b3df3ab7ac28 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3330,7 +3330,7 @@ int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
>
>  #endif /* CONFIG_PROC_SYSCTL */
>
> -#ifdef CONFIG_BPF_SYSCALL
> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_SYSCTL)
>  static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
>                                           void __user *buffer, size_t *lenp,
>                                           loff_t *ppos)
> --
> 2.20.0
>


-- 
Kees Cook
