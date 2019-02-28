Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6524FC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E14218A5
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlvMNWRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfB1ASY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:18:24 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38545 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB1ASY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 19:18:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so15077064oic.5;
        Wed, 27 Feb 2019 16:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eit558OMm6KU6NVh0ZfUhdINky9OlhnN2KO1QGYwGhk=;
        b=dlvMNWRwDV6DjUQUxY8KhjB4tOgy7DzCUs1sfc8KvbN6jMs+LiwxrXSBxEyD3pqb+c
         VmK1cf57/AlNVYn1TPrCpzEazE+m4IQ3w7i82AhQqDDvT9OS6SxTXKE4QfB1LbrZJlFN
         +attBKV/TLyx1edn8xUNqqRgM2CMbaNe0AHXJnQTUfF5oA3raoRbg/3sInIjaGP3Jy1R
         Mom5US+qzxRfYcoU0n/5s+pF6cFIcRpPNjRor2sn6CpmvujkXqZgDlPD6sPARrXgjYqR
         B47JtaNg54eTZR2d5IhLv8uad6YC0dKmkorMBMIJk8MXQF9Bvto23boa6VTMhliUGB3j
         a6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eit558OMm6KU6NVh0ZfUhdINky9OlhnN2KO1QGYwGhk=;
        b=kT8gmI8QH4K6b6QOGY7mD0r7EXfUZEMxjIrDnCYHMM1BpAF3SHx6wHp59gwZ3Az4j4
         vfpJPM+tZ+oVrJQMRcYqyLPEJ70HA+9XzIZ5HGwcrW2QDiRBlRaH8DB7ZUydwh8vCnTx
         i9Y0gkk6pLMceuQykZS/iKP50XXv524E9PanDmxhXFKe8x0IsNhQ+v7y9XQiP0Tvfx1r
         hPE7tBbSx8HnjoztM7wAsTRFRw1H1Op17QidLIBnFVwgFesej2Hr7lboqn630M59K04F
         HQttuaRlsOTtdZrUnl0sSl5s7XUwnd75SPHabAdl1crcg/LGtXAgvq5LD546WtErmZL2
         nG/g==
X-Gm-Message-State: AHQUAuavwXk6kfz0seweiAeYUKJO3/QtAToO3ICJkf1k0Pcca0yQKXuC
        fSEVyYtxLJoMWgmJqZaRji2wwog2CGVlecyfgFQ=
X-Google-Smtp-Source: AHgI3Ia7xfrkXBRSVlP2YQQxK/09lMTfQJwPd6jeOmj5gWd5YeihTElBT6VD6QosljsSuNa2cnJD1vnlis/1KNzzZBw=
X-Received: by 2002:aca:55c6:: with SMTP id j189mr1328183oib.82.1551313103443;
 Wed, 27 Feb 2019 16:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20190227233046.11718-1-jakub.kicinski@netronome.com> <20190227233046.11718-2-jakub.kicinski@netronome.com>
In-Reply-To: <20190227233046.11718-2-jakub.kicinski@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Feb 2019 16:18:12 -0800
Message-ID: <CAEf4BzYHKgiw_OguQxXGzPJA75qqPxjUePrLxc-c4zxK-ijpkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] samples: bpf: force IPv4 in ping
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 3:31 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> ping localhost may default of IPv6 on modern systems, but
> samples are trying to only parse IPv4.  Force IPv4.
>
> samples/bpf/tracex1_user.c doesn't interpret the packet so
> we don't care which IP version will be used there.
>
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

Acked-by: Andrii Nakryiko <andriin@fb.com>

> ---
>  samples/bpf/sock_example.c | 2 +-
>  samples/bpf/sockex1_user.c | 2 +-
>  samples/bpf/sockex2_user.c | 2 +-
>  samples/bpf/sockex3_user.c | 2 +-
>  samples/bpf/tracex2_user.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/samples/bpf/sock_example.c b/samples/bpf/sock_example.c
> index 60ec467c78ab..00aae1d33fca 100644
> --- a/samples/bpf/sock_example.c
> +++ b/samples/bpf/sock_example.c
> @@ -99,7 +99,7 @@ int main(void)
>  {
>         FILE *f;
>
> -       f = popen("ping -c5 localhost", "r");
> +       f = popen("ping -4 -c5 localhost", "r");
>         (void)f;
>
>         return test_sock();
> diff --git a/samples/bpf/sockex1_user.c b/samples/bpf/sockex1_user.c
> index 93ec01c56104..be8ba5686924 100644
> --- a/samples/bpf/sockex1_user.c
> +++ b/samples/bpf/sockex1_user.c
> @@ -26,7 +26,7 @@ int main(int ac, char **argv)
>         assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, prog_fd,
>                           sizeof(prog_fd[0])) == 0);
>
> -       f = popen("ping -c5 localhost", "r");
> +       f = popen("ping -4 -c5 localhost", "r");
>         (void) f;
>
>         for (i = 0; i < 5; i++) {
> diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
> index 1d5c6e9a6d27..125ee6efc913 100644
> --- a/samples/bpf/sockex2_user.c
> +++ b/samples/bpf/sockex2_user.c
> @@ -34,7 +34,7 @@ int main(int ac, char **argv)
>         assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, prog_fd,
>                           sizeof(prog_fd[0])) == 0);
>
> -       f = popen("ping -c5 localhost", "r");
> +       f = popen("ping -4 -c5 localhost", "r");
>         (void) f;
>
>         for (i = 0; i < 5; i++) {
> diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
> index 9d02e0404719..bbb1cd0666a9 100644
> --- a/samples/bpf/sockex3_user.c
> +++ b/samples/bpf/sockex3_user.c
> @@ -58,7 +58,7 @@ int main(int argc, char **argv)
>                           sizeof(__u32)) == 0);
>
>         if (argc > 1)
> -               f = popen("ping -c5 localhost", "r");
> +               f = popen("ping -4 -c5 localhost", "r");
>         else
>                 f = popen("netperf -l 4 localhost", "r");
>         (void) f;
> diff --git a/samples/bpf/tracex2_user.c b/samples/bpf/tracex2_user.c
> index 1a81e6a5c2ea..c9544a4ce61a 100644
> --- a/samples/bpf/tracex2_user.c
> +++ b/samples/bpf/tracex2_user.c
> @@ -131,7 +131,7 @@ int main(int ac, char **argv)
>         signal(SIGTERM, int_exit);
>
>         /* start 'ping' in the background to have some kfree_skb events */
> -       f = popen("ping -c5 localhost", "r");
> +       f = popen("ping -4 -c5 localhost", "r");
>         (void) f;
>
>         /* start 'dd' in the background to have plenty of 'write' syscalls */
> --
> 2.19.2
>
