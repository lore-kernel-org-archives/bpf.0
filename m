Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645E6C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4A218D0
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 18:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG1zTI2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfB1SxQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:53:16 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46508 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfB1SxP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 13:53:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id i5so12714640qkd.13;
        Thu, 28 Feb 2019 10:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xd1/bhWb7St+gWn1vRT+BT0pbe/9VFl30birLI72GtA=;
        b=JG1zTI2K/tFU0IlEjawdltqqgjoHNsp7s9VMGvWbHJiUJpWdQLXfncYC5pH6Ub2F1V
         ZE1RP08m41Gdac3ojUT30nafjDxt4qSq2wklo0I/MwUqWTuw044XVaRv0PWHY5A4R06F
         9psecwD24aSnhXbBw/X9kfcskPLElc/YLa66m2iO1ursiZu/OpBK4/BihBhDeRHdxi1T
         DD4t74WbGj4b9GbcRU9FMf/qjQJLwRdEF374BDxaHMUoVg6QEYtzJ/8bsvYv+fcdRcyh
         gh5yXKMJW9+5LVPaCM22Fs9x8ou+o24BUGJ/YlKtb9MNE0hG8NzooFla1pP89nIlms3j
         Vhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xd1/bhWb7St+gWn1vRT+BT0pbe/9VFl30birLI72GtA=;
        b=ZQaXBtSqpCGT1Sbh4Kc+dFbucap+BI1idxmWnRLFURD/gLWiq554pM3w9BJB8EeGf6
         DEXnxkKWf4JQXN3HAMme8feaCkJc31xIkSQjjRd3VE4ssYoEZg1dMktWLoZQ2XAXIEWK
         rnBWuoyUkAydORFfLe6AS4adfDKNSfUhbow9KbsXQp5fao62wyvmGuMFxXHlZT357Awe
         b85HdSP15kopD3xUmYm3WeS5Z9oAH6LsJnKTBZs8c7hqvKRF/KiHTg6P0Fmsg/e4mfCp
         EmxcxQRolz9hXUS0tTZ11AkYp5PEhfah1BJ7bGEQ/fA7uxyrEU84sg27tLQUIUTeoF7g
         uYlg==
X-Gm-Message-State: APjAAAWPrD0OxgZKi+vWUJDxW2ShXymwQQQFvXwl5NESAWloZh8PbzGU
        7/Lyc/NHY6pqGPscQcWKeBOZ9MyP
X-Google-Smtp-Source: APXvYqzuUn/dH7+XorneLoMuLQ4qzlKSaeIvIG4gPoNM9DvLQUEJ0KH9dpCOrJVobN9Xj6Bol8ZRfw==
X-Received: by 2002:a37:d204:: with SMTP id f4mr732048qkj.311.1551379994352;
        Thu, 28 Feb 2019 10:53:14 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id h26sm12949764qtk.52.2019.02.28.10.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:53:13 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D8E34039C; Thu, 28 Feb 2019 15:53:11 -0300 (-03)
Date:   Thu, 28 Feb 2019 15:53:11 -0300
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com, ast@fb.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 2/5] libbpf: fix formatting for
 btf_ext__get_raw_data
Message-ID: <20190228185311.GI9508@kernel.org>
References: <20190227224642.1069138-1-andriin@fb.com>
 <20190227224642.1069138-3-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227224642.1069138-3-andriin@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 27, 2019 at 02:46:38PM -0800, Andrii Nakryiko escreveu:
> Fix invalid formatting of pointer arg.
> 
> Fixes: ae4ab4b4117d ("btf: expose API to work with raw btf_ext data")

Also I think Fixes here is not applicable :-)

- Arnaldo

> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/lib/bpf/btf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 94bbc249b0f1..b60bb7cf5fff 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -76,7 +76,7 @@ LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
>  
>  LIBBPF_API struct btf_ext *btf_ext__new(__u8 *data, __u32 size);
>  LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
> -LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext* btf_ext,
> +LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext,
>  					     __u32 *size);
>  LIBBPF_API int btf_ext__reloc_func_info(const struct btf *btf,
>  					const struct btf_ext *btf_ext,
> -- 
> 2.17.1

-- 

- Arnaldo
