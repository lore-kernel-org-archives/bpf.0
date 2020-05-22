Return-Path: <SRS0=QYON=7E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1566C433E0
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 01:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9F120825
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 01:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8F8P+0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgEVBH0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 May 2020 21:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgEVBH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 May 2020 21:07:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D44C061A0E;
        Thu, 21 May 2020 18:07:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id c75so4202162pga.3;
        Thu, 21 May 2020 18:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lv+YS1zO2UCM69yS5OoPJXNOOibtu9XQ00S3pH6Tp84=;
        b=J8F8P+0acdRJJf+nskVlhuxphxHjclsf9EDyKOHZ8sxnAxIEFrQCeXZQfErpyCC4U8
         dupalUm3Zcn/Nj7VjKPaZkZOMFSTDTMgXWghvXTqZjme6CNv2nmAIBiRxDqSSKiVFa+8
         63DxnA1To2wl5AZg0FAENv+N1pR8f5maX8iipNEi24C5Vrqo2k38TnFDGhFi827gNUvE
         GZ/Wjc3J+swAwX/kChZz+mWL1ooqSYDmunamROLhxoqP1HH8ILEDo/RqEERgWecx8DFx
         FEg6QFVX+tWd1vrofuOQIWG0lUVR5bR8+qOoSgA0Rgbk32eLAeA/6s9o5DKS4vRIPG8v
         i22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lv+YS1zO2UCM69yS5OoPJXNOOibtu9XQ00S3pH6Tp84=;
        b=lPGjTmO5hutzQ6i7Wyp/o8qxUiNn6EBy5apbxJBP3GhTP+fEKIuVGfOiEb5DUGLm89
         81prkUG7jUK7q2SumNg7N8UXmKQVDku88fhtC20dpfg6/uL3qp1I4oQZQ2If2gDtbzNn
         uyMF85gZl30ElI7MfxQ3B6eGKJ9F/bNZfEhNqiJ8nti5shtvqSQ1frM5p1O8ITymLPu8
         MwhrnFIrKqqph3vMZ5/civQh0/59LNGV9WENt2jp0D7S+gh4Tq0lGW0FDTL5jNPXJkzJ
         Qrz4oB8r/UmS/2Icuq2+h7qfvw4ooYM/JvR96kCgFhYRdtlZcLmvTy38fCPqe3nEQnSH
         sJCg==
X-Gm-Message-State: AOAM532QbVpVp5uqSQDZGYJ6RpzfPVy1ej8iWouPY6xuy9zChYCvDMQM
        y715ZTr6tih88aLosVXQgu0=
X-Google-Smtp-Source: ABdhPJyDz9lWQ05hQbQmqSkvKMZcygQmILLo9pwFGUw23PARFcJoE9gkZI3jq2hc68UyHfLwiyWGkA==
X-Received: by 2002:aa7:808e:: with SMTP id v14mr1518634pff.168.1590109645459;
        Thu, 21 May 2020 18:07:25 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e680])
        by smtp.gmail.com with ESMTPSA id q9sm5326587pff.62.2020.05.21.18.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 18:07:24 -0700 (PDT)
Date:   Thu, 21 May 2020 18:07:22 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        kernel-team@fb.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/7] bpf: implement BPF ring buffer and
 verifier support for it
Message-ID: <20200522010722.2lgagrt6cmw6dzmm@ast-mbp.dhcp.thefacebook.com>
References: <20200517195727.279322-1-andriin@fb.com>
 <20200517195727.279322-2-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517195727.279322-2-andriin@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 17, 2020 at 12:57:21PM -0700, Andrii Nakryiko wrote:
> -	if (off < 0 || size < 0 || (size == 0 && !zero_size_allowed) ||
> -	    off + size > map->value_size) {
> -		verbose(env, "invalid access to map value, value_size=%d off=%d size=%d\n",
> -			map->value_size, off, size);
> -		return -EACCES;
> -	}
> -	return 0;
> +	if (off >= 0 && size_ok && off + size <= mem_size)
> +		return 0;
> +
> +	verbose(env, "invalid access to memory, mem_size=%u off=%d size=%d\n",
> +		mem_size, off, size);
> +	return -EACCES;

iirc invalid access to map value is one of most common verifier errors that
people see when they're use unbounded access. Generalizing it to memory is
technically correct, but it makes the message harder to decipher.
What is 'mem_size' ? Without context it is difficult to guess that
it's actually size of map value element.
Could you make this error message more human friendly depending on
type of pointer?

>  	if (err) {
> -		verbose(env, "R%d min value is outside of the array range\n",
> +		verbose(env, "R%d min value is outside of the memory region\n",
>  			regno);
>  		return err;
>  	}
> @@ -2518,18 +2527,38 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
>  	 * If reg->umax_value + off could overflow, treat that as unbounded too.
>  	 */
>  	if (reg->umax_value >= BPF_MAX_VAR_OFF) {
> -		verbose(env, "R%d unbounded memory access, make sure to bounds check any array access into a map\n",
> +		verbose(env, "R%d unbounded memory access, make sure to bounds check any memory region access\n",
>  			regno);
>  		return -EACCES;
>  	}
> -	err = __check_map_access(env, regno, reg->umax_value + off, size,
> +	err = __check_mem_access(env, reg->umax_value + off, size, mem_size,
>  				 zero_size_allowed);
> -	if (err)
> -		verbose(env, "R%d max value is outside of the array range\n",
> +	if (err) {
> +		verbose(env, "R%d max value is outside of the memory region\n",
>  			regno);

I'm not that worried about above three generalizations of errors,
but if you can make it friendly by describing type of memory region
I think it will be a plus.
