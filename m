Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96BDC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9132520C01
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBuWA9IT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfB1TIb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:08:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44847 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfB1TIb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 14:08:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id r21so12729552qkl.11;
        Thu, 28 Feb 2019 11:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7rd/ayGO4dlTTSMPRAnHqo2/KRLTZ7r46O/mvlN3pE=;
        b=kBuWA9ITfdowN3imvXd3AEIKLjP1NrMPd4uAWR+tobJl6KvmNcjDjMF83i0ftY5kJX
         A3e+0IXC2VS0IU3FmzZFjw66h1dtGU7/Ei1XXw3KQ3mnUOu9vpq5pDfJv8v33+/Rsn5j
         9K33ivvVv/nVAmgoeeS1dycPMwJd8BeGDd/nlHLaF+tBuiQnNNv6anHRJwQhheNohYvK
         IyejtMOejoX9VGHgcacD3ToQgceP1BxsBksyJjvyKWKooLkF8TDH3ZaE54LUntKJ1N7C
         5V4PIIjpdpC6bnerYFcJ9U3NZ94L1ApI/c1WKenOMcYQDphGH74DlMNC4JKBqLrGcAXa
         WQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7rd/ayGO4dlTTSMPRAnHqo2/KRLTZ7r46O/mvlN3pE=;
        b=fLGe0ZC84LQkDG136Be4nz1+jfUCJHmG/AJCkmma+Vedpa/gz41R8rIY1+DVMk6eex
         5bcZkai8DOiXM+q+Nq3iJbXeH0HlQ45jJw5ChWCBfHiJDXOMaLwJI/mk1MZjxSOZ0/hR
         sh2b9dmfSbCBVOHE7QXxAgha/KSxfC2TBDmi1vDbXW4A5o/gpK7558OzfhwW4qPdfeiG
         wcltYTA+BBX1ZfKnBkpPpRmSN0+Eimk0GdUzGoscymqUDIOpGDGpb+eDhJKyPTuj99l2
         NjUr/x7KWB+uD4q4Juj4IlYRb1IbBd2PaYos7m3MWm+4PglRPmOpXn88F2VlKGvcZkXW
         d3RQ==
X-Gm-Message-State: APjAAAUPHeL8ykEBOtlOMyKfFdVM1zqrpNQx150vuZsORn9F3BZikoh1
        i4ieSStvxGCvaRNIlVv3TrwhPV1aBHjrI2fQd1Q=
X-Google-Smtp-Source: APXvYqwBvlMrPI+hgmFfSe8CzSdGI8+18h9BSw8P+O8lz6Jo7/L9RwC4fgHyCH7uf5wvVYXygsUSrRhAph4xUNGAIqo=
X-Received: by 2002:a37:bc04:: with SMTP id m4mr818218qkf.41.1551380909758;
 Thu, 28 Feb 2019 11:08:29 -0800 (PST)
MIME-Version: 1.0
References: <20190228023044.3802998-1-ast@kernel.org>
In-Reply-To: <20190228023044.3802998-1-ast@kernel.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 28 Feb 2019 11:08:18 -0800
Message-ID: <CAPhsuW5ujxPyAExPAT7fp=PzEdLKmPysh=5ZKAN5J2B85buShQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix build without bpf_syscall
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>, sfr@canb.auug.org.au,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 6:32 PM Alexei Starovoitov <ast@kernel.org> wrote:
>
> wrap bpf_stats_enabled sysctl with #ifdef
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 492ecee892c2 ("bpf: enable program stats")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/sysctl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 86e0771352f2..7578e21a711b 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -224,9 +224,11 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
>  #endif
>  static int proc_dopipe_max_size(struct ctl_table *table, int write,
>                 void __user *buffer, size_t *lenp, loff_t *ppos);
> +#ifdef CONFIG_BPF_SYSCALL
>  static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
>                                           void __user *buffer, size_t *lenp,
>                                           loff_t *ppos);
> +#endif
>
>  #ifdef CONFIG_MAGIC_SYSRQ
>  /* Note: sysrq code uses its own private copy */
> @@ -1232,7 +1234,6 @@ static struct ctl_table kern_table[] = {
>                 .extra1         = &one,
>                 .extra2         = &one,
>         },
> -#endif
>         {
>                 .procname       = "bpf_stats_enabled",
>                 .data           = &sysctl_bpf_stats_enabled,
> @@ -1242,6 +1243,7 @@ static struct ctl_table kern_table[] = {
>                 .extra1         = &zero,
>                 .extra2         = &one,
>         },
> +#endif
>  #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
>         {
>                 .procname       = "panic_on_rcu_stall",
> @@ -3272,6 +3274,7 @@ int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int write,
>
>  #endif /* CONFIG_PROC_SYSCTL */
>
> +#ifdef CONFIG_BPF_SYSCALL
>  static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
>                                           void __user *buffer, size_t *lenp,
>                                           loff_t *ppos)
> @@ -3293,7 +3296,7 @@ static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
>         }
>         return ret;
>  }
> -
> +#endif
>  /*
>   * No sense putting this after each symbol definition, twice,
>   * exception granted :-)
> --
> 2.20.0
>
