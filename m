Return-Path: <SRS0=579k=BN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4543CC433DF
	for <bpf@archiver.kernel.org>; Mon,  3 Aug 2020 01:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220AF2076B
	for <bpf@archiver.kernel.org>; Mon,  3 Aug 2020 01:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUbjFf33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHCBRL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 2 Aug 2020 21:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHCBRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Aug 2020 21:17:10 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855AAC06174A;
        Sun,  2 Aug 2020 18:17:10 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id y17so19320761ybm.12;
        Sun, 02 Aug 2020 18:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztHduAqIjNf4siusMwv8qHrm7SBmoblJfNscRl3QrRY=;
        b=iUbjFf33yEmDZBQ+40V7vcnnOP+5/Xsob87KXdGHL6drEOhvqmztTwyOPNmMSarZQz
         67STUmOLowdOPh1DM0g/uHpF4TnPzZ6PS+kT4cmbAMYR5BA5WurNFScr/a7bzPoRG/lz
         iww+Yv9JGZvAZujAaTsRkHmf7HNAwOrLIw7lDOC95/3CPJ72nFvjjdXGJ0aWihiEyB2C
         LUKDJd4H3YeFnBbLA3+KiwMNWdoJi6pAYASNCBky1UCxuw+Tm+boxxV0jhBH998dBAS5
         oUkdCMFmtbgwK35yMoFrKByyI9cVnRtzjxizHRge0L/ONER0qvYCc2ciwdYpXhuDS0b8
         anzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztHduAqIjNf4siusMwv8qHrm7SBmoblJfNscRl3QrRY=;
        b=bq/L24SuJVyRbpvIXylWZIiWHK5E9ZJoyF0VsoBftNnwlkGP5zuLrNj9H1MV7eLt2X
         Y+vr//VIwKQ1b4PQRWyyGkqMCWQgkeZE1rZSG3yERledK3PXNfhUpW0D+lebM3+k6R55
         Qterokzr9zKpqjl3sj7dyaBr9A/qVAG3Ss2goVG3tnoabuCLW0KYK/QcLupkAncnij0t
         gtp6RORs08QIwONwcLQu5OyCi7naQ/knuaPuv6jOn0Y/ppc/HC6335xRtj3fBuraMBnl
         Iq2mOd6QZe1goU7xCycFEUngE4Ui4QMB1kCq3Eb83OHGB885Ao9cpqUn79oB0unKYoNO
         KWmw==
X-Gm-Message-State: AOAM533S+pHAkzAVI5/W1nRTHuzJOzob0WCGFttBafh0JR6oYiqmuaAf
        hITXcqZS1WmIoqfW2IgeX4DznmkzdQtOMVkeJoA=
X-Google-Smtp-Source: ABdhPJwBicFZpikVx8NydRNdFSIoBjIwbTnLQEE6p+7DBEBUh8+HygttiMNtMO3NQPyX4jdYlxFr2/X1Ob4CYjuccVI=
X-Received: by 2002:a25:ad5a:: with SMTP id l26mr4572251ybe.510.1596417429637;
 Sun, 02 Aug 2020 18:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200802111540.5384-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200802111540.5384-1-tianjia.zhang@linux.alibaba.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 2 Aug 2020 18:16:58 -0700
Message-ID: <CAEf4Bza0C3iB3S8wXkkQxPoE+ndNuUtkmU3L8g7NzMgjHzkx8Q@mail.gmail.com>
Subject: Re: [PATCH] tools/bpf/bpftool: Fix wrong return value in do_dump()
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Jiri Olsa <jolsa@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        tianjia.zhang@alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 2, 2020 at 4:16 AM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> In case of btf_id does not exist, a negative error code -ENOENT
> should be returned.
>
> Fixes: c93cc69004df3 ("bpftool: add ability to dump BTF types")
> Cc: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---


Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/bpf/bpftool/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index faac8189b285..c2f1fd414820 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -596,7 +596,7 @@ static int do_dump(int argc, char **argv)
>                         goto done;
>                 }
>                 if (!btf) {
> -                       err = ENOENT;
> +                       err = -ENOENT;
>                         p_err("can't find btf with ID (%u)", btf_id);
>                         goto done;
>                 }
> --
> 2.26.2
>
