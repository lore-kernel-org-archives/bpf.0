Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B0BC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9459218C3
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH806AGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfB1SR2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:17:28 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41892 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfB1SR2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 13:17:28 -0500
Received: by mail-qk1-f193.google.com with SMTP id y15so12655853qki.8;
        Thu, 28 Feb 2019 10:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaLAGaGGjqI+SVy0Xd17Jhezo2ZZtmB3NBZUS1FPZ64=;
        b=cH806AGe13Fpnap+OlR4y0rWKAd1+tKG2EA0YW2dgrzMvS3MwLEDXwQLRS6FrsDE5Q
         74SVN5o0mZmdT2V2IC48N8qhabmZq//Cqwzq8Oe4GN5X4d1a/3UnpFxncv6BiEVmqFiS
         EItby0dmMantpL8bknZqs+lKj5QspGZxOzNSQ8X9OnX6woHneKcdvhmoef+RzKshJ9ye
         S6EzPkCoUrGkymtI4vMFGkk7X2rMfmQXH7NAMhfdwW8QVXMAzbO/UCQDdEWtGEQO/L/3
         zBShl5YzT3mol1YClOc2HUSjvOezdF/SIyvH3AJ9o/ZmMtZ2Z4m2se9F2mW5TxfBDYov
         8rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaLAGaGGjqI+SVy0Xd17Jhezo2ZZtmB3NBZUS1FPZ64=;
        b=lIfX3gb68DNi25gjui/iAT5l1mKKHZDbGWDFdZJRsTtkMJMPb1aQAhmjcLN+SzJaNV
         rsvqFFBN6Z6WYLq6UiloeZ3dmg4Ln3/MYRZ6FAarPBvWT9qaDm8a0i+GqsNeuYb+dy8m
         semWb5/2tlPoVvsMVJEKvG1QRNZkkwH8CkDh8ABXjWGhnNvAhNBEzO3BLzsjXC5VU/we
         2nWf9oIcHJiLT/b+6fR2G2LYnG1wyv8VjkbzoXHXN5ZgkkB5pEkesTBKmrM7hr0xkecc
         DkHvxluD3qzSXQoCGx452JBbP8LLh7vIoHQEkyvEBYtQs8mOl/sWkPDFBfeN1NdDnwZ2
         eAfw==
X-Gm-Message-State: APjAAAUJXZsYlJ1LKeZYb65momqYzknAnuFfP9xP6bM2F7kMNwH7oSaW
        Ni8wDTOj16Y1xHyP1HWwJr87rBvcJJKuNxLGUf4=
X-Google-Smtp-Source: APXvYqyjfPZNjazgNoC6r2Qf/rZDvIM3LQIt2c9fiWBajIh57MeveCg/zf7vv1dawrMyOnLOMLGuMwpqIS4n4CpgNh0=
X-Received: by 2002:a37:e10d:: with SMTP id c13mr650383qkm.284.1551377846771;
 Thu, 28 Feb 2019 10:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20190227224642.1069138-1-andriin@fb.com> <20190227224642.1069138-2-andriin@fb.com>
In-Reply-To: <20190227224642.1069138-2-andriin@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 28 Feb 2019 10:17:15 -0800
Message-ID: <CAPhsuW52gmGrZGr50=L6FEVK760G=HPVzRgvzeJc3-mU+MqkMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: fix btf_dedup testing code
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com, ast@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 2:47 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> btf_dedup testing code doesn't account for length of struct btf_header
> when calculating the start of a string section. This patch fixes this
> problem.
>
> Fixes: 49b57e0d01db ("tools/bpf: remove btf__get_strings() superseded by raw data API")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/.gitignore | 1 +
>  tools/testing/selftests/bpf/test_btf.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index e47168d1257d..3b74d23fffab 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -14,6 +14,7 @@ feature
>  test_libbpf_open
>  test_sock
>  test_sock_addr
> +test_sock_fields
>  urandom_read
>  test_btf
>  test_sockmap
> diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
> index 02d314383a9c..1426c0a905c8 100644
> --- a/tools/testing/selftests/bpf/test_btf.c
> +++ b/tools/testing/selftests/bpf/test_btf.c
> @@ -5936,9 +5936,9 @@ static int do_test_dedup(unsigned int test_num)
>         }
>
>         test_hdr = test_btf_data;
> -       test_strs = test_btf_data + test_hdr->str_off;
> +       test_strs = test_btf_data + sizeof(*test_hdr) + test_hdr->str_off;
>         expect_hdr = expect_btf_data;
> -       expect_strs = expect_btf_data + expect_hdr->str_off;
> +       expect_strs = expect_btf_data + sizeof(*test_hdr) + expect_hdr->str_off;
>         if (CHECK(test_hdr->str_len != expect_hdr->str_len,
>                   "test_hdr->str_len:%u != expect_hdr->str_len:%u",
>                   test_hdr->str_len, expect_hdr->str_len)) {
> --
> 2.17.1
>
