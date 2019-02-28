Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8036C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA0F218B0
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiDOWOeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfB1SwS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:52:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43100 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfB1SwS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 13:52:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id f196so12718677qke.10;
        Thu, 28 Feb 2019 10:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+/Y9Yfv0uXzFpUNmFa6qqu162u7qOKzkWHppw6BO154=;
        b=UiDOWOeQFTctlg6gJzaeIICfsi4deXS5pHgG9XG6D/asMFRIQgsYTHwwcxnJpTD2Vx
         6pP1MATzDPo33IfGYPUx8lXfewHdhocBy+teTc2G135G9cz+CkJdHpA+55yohIWWNqzh
         s0c88MN1vOC4urHeqHxtp8Yhx11CXk222tby6gRBUjsUiqVFxDSqRoS5JIAGSgmczn1I
         hGduNQPFiKSMQZIrMs0YXAwkx/deASelGkAj3XSCIm3j85YKSetQSOP5Bl5h3d3hFXXa
         MgB2ZUctJ6uEg8/wif5Fe8a4sW1VSobscbpN0BmoPhx602SSy1TMZcCOgUZYkMV2geUi
         lHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+/Y9Yfv0uXzFpUNmFa6qqu162u7qOKzkWHppw6BO154=;
        b=SbmqSkO8yqDYuQSibdx2wTkbsSL9Y7Ul/LeVMKCVOjmwlr1F6PN2Dr59W7Nc6s5JPY
         x5rh9khJHMf7K0jT93ALPHGG2EcH5fjZb0t2e1U2pAlcRFhX6Cj6ClVkbSBEPfJxtcrc
         sXPGj+S4LmuIiMPExXxQFBv6hmNxcMvdWR1QQsD3TRzBdyh6WGJMEWKaEXJBRjniM+iU
         MYNQH3EydMaKvjl2sCO2er1t7/7FHWDcs/TcYnlvMoJrkTA4g8lbOzkzwAyFy9ybvzqa
         +qY2hjpM5NHtkrPxNbET9y2BjPwdGhuQO44t8wlyHzOMiZ8VQ08oTUGc8JsQY3J/nYgu
         R2LA==
X-Gm-Message-State: APjAAAX7lxNalm6STYMngL6LoIm3vAbtVC7fPhh97LaWhbtwvDU5NNg7
        +aYLUW7RKFI3o4Gpl7RCVzs=
X-Google-Smtp-Source: APXvYqyHtHITe7xJtmts7QYAnBn52WZoy39t7oBXCeQbAUNqVsrvZUG+vBLoMVEtkfH6V9THKrOQCA==
X-Received: by 2002:a05:620a:1333:: with SMTP id p19mr722159qkj.165.1551379936719;
        Thu, 28 Feb 2019 10:52:16 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id n78sm2908138qkn.10.2019.02.28.10.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:52:15 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C401C4039C; Thu, 28 Feb 2019 15:52:12 -0300 (-03)
Date:   Thu, 28 Feb 2019 15:52:12 -0300
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com, ast@fb.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: fix btf_dedup testing code
Message-ID: <20190228185212.GH9508@kernel.org>
References: <20190227224642.1069138-1-andriin@fb.com>
 <20190227224642.1069138-2-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227224642.1069138-2-andriin@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 27, 2019 at 02:46:37PM -0800, Andrii Nakryiko escreveu:
> btf_dedup testing code doesn't account for length of struct btf_header
> when calculating the start of a string section. This patch fixes this
> problem.
> 
> Fixes: 49b57e0d01db ("tools/bpf: remove btf__get_strings() superseded by raw data API")

I think this clarifies things, but a Fixes seems excessive, right? I.e.
if you missed it in both sides of the (a != b) expression, the test will
be just as valid.

I say this because Fixes tags are now tracked and generates backporting
efforts that sometimes end up causing unnecessary human exchanges when
the patches don't apply because of some other patch.o

Or is there some further use of 'test_strs' and 'expect_strs' further
down that do_test_dedup() function?

/me scratches head, probably missing something...

- Arnaldo

> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
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
>  	}
>  
>  	test_hdr = test_btf_data;
> -	test_strs = test_btf_data + test_hdr->str_off;
> +	test_strs = test_btf_data + sizeof(*test_hdr) + test_hdr->str_off;
>  	expect_hdr = expect_btf_data;
> -	expect_strs = expect_btf_data + expect_hdr->str_off;
> +	expect_strs = expect_btf_data + sizeof(*test_hdr) + expect_hdr->str_off;
>  	if (CHECK(test_hdr->str_len != expect_hdr->str_len,
>  		  "test_hdr->str_len:%u != expect_hdr->str_len:%u",
>  		  test_hdr->str_len, expect_hdr->str_len)) {
> -- 
> 2.17.1

-- 

- Arnaldo
