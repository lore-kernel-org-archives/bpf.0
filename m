Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07775C4360F
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DDE218AE
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 17:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRBK0fuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfB1RxF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:53:05 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46210 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfB1RxF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 12:53:05 -0500
Received: by mail-qk1-f196.google.com with SMTP id i5so12589244qkd.13;
        Thu, 28 Feb 2019 09:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EUIMg/eMi/ZWApfScrWv41Lh/z9K/sxY/cROUXflAik=;
        b=DRBK0fuQ783WG3P2g+PIeflSx5qvHpZD646O9fA+Wdsz802YnvHJ6sfXB68nklDtOt
         SKkHp3AFrvwke0nR/wUsIUM5WV9TfPlyd3m9dlngB3ZWjgvRisymc/oIpOnDWQmDa5gS
         sjTOWhZcriZs1YqpgBSw49/QoYi97BktWPDtIrcmiG74f22LlOp+55OWo88OGhO06twT
         xQeNARGa5Q/BdTVJZJ2RET7HL8kSoYuKfq5tN/emSBFZE/vk66BqeGv8HpheYN9wb+WZ
         AatK+FywUDvYxldewrd6mDVvlPd/MBUBt6KB6yThl+W61Gj4+KcnsDRPppRz/pcxviYy
         J8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EUIMg/eMi/ZWApfScrWv41Lh/z9K/sxY/cROUXflAik=;
        b=FG/AJ3W9npnQX/2JXW8tJitHyWrE4+Wm8yrCy+vPXk5wQgE2mU6q0ZX9+RwD7eCOKb
         jaopVcxza12mZG65iUJXWolgLyfipDtB4GqrW6+I6etDMknAlsLw6rphy6t75GGBqsva
         r4v2htNxJm6yhpt6LbTYWY33a+Jh92dX6bGp8WAm3QyB5zXghwqlMEjz1a9iIgLFvVnm
         WYrtEhqSEgYMSd/q6D3kxtJJCgRmEjShFpiqODkGwzjEKykD0nLTbEb5hIq70pYMntxX
         +I4hv+hoGZhSXsES6X1U54lB3mgy5AZrUqaJRLuWxRsFu0b8PiZUjhCsybrdl3wjFo0n
         bmTg==
X-Gm-Message-State: APjAAAVz+RuRJYWzOzTHMATJgOp9oqZuimI33WIAXykHaSOyd7dA+9xT
        J6NLFlsmhB0iyAeL5MFGBD4=
X-Google-Smtp-Source: APXvYqwuBkqiAzYDB7FSdBkrYy0mq6mIk0Zcr2njh8qZN1kqmv5VdyapB73zpEhNyAoF+u2mYsr/aw==
X-Received: by 2002:a37:ccc5:: with SMTP id n66mr540132qkl.209.1551376383540;
        Thu, 28 Feb 2019 09:53:03 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id r9sm7890212qkl.1.2019.02.28.09.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 09:53:02 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A6824039C; Thu, 28 Feb 2019 14:53:00 -0300 (-03)
Date:   Thu, 28 Feb 2019 14:53:00 -0300
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] tools/libbpf: signedness bug in btf_dedup_ref_type()
Message-ID: <20190228175300.GB9508@kernel.org>
References: <a34432d0-b838-c004-ef79-052cd50996c0@fb.com>
 <20190228175035.GA30148@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228175035.GA30148@kadam>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 28, 2019 at 08:50:35PM +0300, Dan Carpenter escreveu:
> The "ref_type_id" variable needs to be signed for the error handling
> to work.

Does the infiniband signedness change comes as a bonus? :-)

- Arnaldo
 
> Fixes: d5caef5b5655 ("btf: add BTF types deduplication algorithm")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> ---
> v2: Use reverse Christmas tree style
> 
> This goes through the BPF tree probably, although it does apply to
> net-next.
> 
>  drivers/infiniband/ulp/iser/iscsi_iser.h | 2 +-
>  tools/lib/bpf/btf.c                      | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
> index 120b40829560..ee7d3f6a666e 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.h
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
> @@ -197,7 +197,7 @@ struct iser_data_buf {
>  	struct scatterlist *sg;
>  	int                size;
>  	unsigned long      data_len;
> -	unsigned int       dma_nents;
> +	int		   dma_nents;
>  };
>  
>  /* fwd declarations */
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 68b50e9bbde1..00a2f06e38fd 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2326,7 +2326,8 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
>  	struct btf_type *t, *cand;
>  	/* if we don't find equivalent type, then we are representative type */
>  	__u32 new_id = type_id;
> -	__u32 h, ref_type_id;
> +	int ref_type_id;
> +	__u32 h;
>  
>  	if (d->map[type_id] == BTF_IN_PROGRESS_ID)
>  		return -ELOOP;
> -- 
> 2.17.1

-- 

- Arnaldo
