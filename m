Return-Path: <SRS0=UYZo=VA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4428EC5B578
	for <bpf@archiver.kernel.org>; Wed,  3 Jul 2019 22:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B6F218A0
	for <bpf@archiver.kernel.org>; Wed,  3 Jul 2019 22:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc8X3Isa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfGCWrI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:47:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46240 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfGCWrI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 18:47:08 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so8695122iol.13;
        Wed, 03 Jul 2019 15:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eE2kt2fOf4nOCR2gT9Cc5WBPkLgpH54MFVNYVNHuT3k=;
        b=hc8X3IsaHzgYLZCGuiqZl0GTV81QUBlW8ECgF+IDmIXVDqtE2PqACYoqXGnN5t8zCQ
         /ue26gbbQKRxb59izsXKb08MksobwfIrIS56W4nie6js75B3UMkOT/88t48kTCpiGDj+
         Kc5POh/K+n+N0MH/2R4uBNNeKHC+Z0+JF+qRmStmYiSoXeVMCYB6fD7Ne6xOxd/U2Dav
         HYdv5/2cmC1gE1W203zTTmhFJVoeoIheurqtwvilo09in954cfA7bmGTV0uE6I7i6t+3
         l4sejf56+wIVumUHgN3Yp2gV5oi6ijwSELIUFUJnkgCEOxbulBlnt5dER/hVZhlzYreP
         a5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eE2kt2fOf4nOCR2gT9Cc5WBPkLgpH54MFVNYVNHuT3k=;
        b=cl9JkJTIRyn+Dji0CBBJs176AGN4QR4KEbNLKwY+q01ECjgNcKPR1B0qRHLPAijNsm
         Qypzfez3pG59LTYFT8XPKwmWt3kK5a4mX0xZVwcBPGWvCAlHfUyf3sSd+5nZoIhbOZV+
         No/0YQwCDs9k2qlW01mFfkMR842lxN/XdAsX8UOKoVlKgMSSSQ3iiCkaQAtrDCI/ZEI1
         42qOIfHG1wvs1YwUfnbP/uC4T5doqyU2AJCjCCwGNXrm964EEU63MpiXx9AsLiZBcg24
         5Ni+Af2qvlQZLtw8PnH7i6N9PM7dcmqo/3qMvXViI9ZsAy8Mr2mUQci/JQBUut4JYJta
         laLw==
X-Gm-Message-State: APjAAAVEcaxequJeo0SAeF3D4oK6OsrKIuOywJQBX43zNERh6WqI8wEb
        /lbZWQZNm0eppeGlaY8YrQLXZyBlcTDrfFXAUnI=
X-Google-Smtp-Source: APXvYqwuOG2FJCVGXA+eJ8Z4YGZ0bxemVUgimORj0I6x35Fg/d69JWqkuvuekey9tLv5EUCCKOrem6nr3Zovx2Vss8Y=
X-Received: by 2002:a6b:bf01:: with SMTP id p1mr7587428iof.181.1562194027328;
 Wed, 03 Jul 2019 15:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190703200952.159728-1-sdf@google.com>
In-Reply-To: <20190703200952.159728-1-sdf@google.com>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 3 Jul 2019 15:46:31 -0700
Message-ID: <CAH3MdRXEaLgbkcP9Zs6n2sQHP4jc7bNkJf2odtuEnQZYrwqQCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add test_tcp_rtt to .gitignore
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 3, 2019 at 1:10 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Forgot to add it in the original patch.
>
> Fixes: b55873984dab ("selftests/bpf: test BPF_SOCK_OPS_RTT_CB")
> Reported-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>  tools/testing/selftests/bpf/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index a2f7f79c7908..90f70d2c7c22 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -42,3 +42,4 @@ xdping
>  test_sockopt
>  test_sockopt_sk
>  test_sockopt_multi
> +test_tcp_rtt
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
