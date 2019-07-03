Return-Path: <SRS0=UYZo=VA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57406C0650E
	for <bpf@archiver.kernel.org>; Wed,  3 Jul 2019 20:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2286921850
	for <bpf@archiver.kernel.org>; Wed,  3 Jul 2019 20:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o51SQ9wI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGCUMZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:12:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42712 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCUMZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 16:12:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id h18so3251696qtm.9;
        Wed, 03 Jul 2019 13:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2Am3pNf0gtX0xa8NrVXo9X+EbqqfHNPKIbtbcAOF3c=;
        b=o51SQ9wIEcN6+t9gJiEvVcm14339rBtS+QftvXvuphLgPizb50/772XEasXs7ZNhmB
         pbYjhF7OGVS1Ud3UFZS4oO4W8l1ABIyNs7Y+vdYdGdVyOpCFY+9o8XHFbwQZWXD5OPjm
         40uwpsKFGWZAMPHoDCPTh0bJ2Ph+7FLV7wcASw3YT2wLsfWEZCWWNOA10tAc60hQOjgM
         07RiQ/HGTy43ySW4uO989eiY0D4030lHSXMxvqLQAmmzSVEThZkbTmuARyKRvMtpqF+G
         gEXYAaIBaSi/X93VzLRK93NSorXjeVvFnVwZXFSDGlQTRuWMgL5rW/SK2TNGGp1DjgBO
         RjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2Am3pNf0gtX0xa8NrVXo9X+EbqqfHNPKIbtbcAOF3c=;
        b=Bu+kfGpsFwVEbm09XurMd12dOzcHiP3omynoSAdNqncHW7SN6burG9mvpldDlx7fES
         U63ldZOMGC11eybJ2R7gMbb6LFJ9dn2UApLNhqC2KBSCHSVoOAq9GblJ8L1ULrl2u9wA
         V8iYWbUh8Xl+j57bAMSt/tg8ZRIQzEAEwDmKVdFGP5rmjMccAaRoiZSxzJ2vnittWgwn
         8qR5H8BTphktN6zomg4fgz0zqqDXg9c79odGUxqdyVtkfw3sgLedAF6dRcqqkblwMW6g
         iRL1pzCIrkqNiq0NISSIIRdYPH4K/5YjjNyeC5DWSEkrBgQlTENARFviaQ3MovIV0fDv
         rN1g==
X-Gm-Message-State: APjAAAW024fXtM1Xw+EJ312/0/bp0qv0SuMbyfEjcqA5zWtvz9m8XyqW
        ZbkOe2ZU5M9aYtLljh3mUWVbKyPIpOnq0yrWmxU=
X-Google-Smtp-Source: APXvYqx4TX63x1dlMWyifXLqO5LyaRa6a0+CChkSJuswItxelAyZsCAeIWwEj0nLxAEi9a9Xw51sbs4hrBHyT1Ih/K8=
X-Received: by 2002:a0c:d0fc:: with SMTP id b57mr34092840qvh.78.1562184744489;
 Wed, 03 Jul 2019 13:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190703200952.159728-1-sdf@google.com>
In-Reply-To: <20190703200952.159728-1-sdf@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Jul 2019 13:12:13 -0700
Message-ID: <CAEf4BzbOFmxKoA8qFs=SN-0AKKZRoyDSZhAe5kw8jRgzGgn3bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add test_tcp_rtt to .gitignore
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
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
> ---

Thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

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
