Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E73164B5
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630618; cv=none; b=Fd8LlunkZlmOkcNGaOAfuPbyRO59TFPsWrdCaPwNuejbG9gydkSYBe4OsCmKKexcAwyyUA3Pm8R/02mltuC5CJHKT2CAqjgUYP6Jvj0BEds0ilGh5prHeK1IuaI7FViA4idzvZ6TjxTw5uF0KBvPPT59Uf+zpZL3RKdSF3jFrLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630618; c=relaxed/simple;
	bh=HGfKtASE6hCUs5HTjuQlSNm+zLo/qRgRLHqOjPzhuws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JUeU8B+/5NbYOSGICg/ol5NmjF0PPZcfDy63GyrtzrxPwhg2qWJ+pJMFGEhQHbegsCURJ78Nv3UT5GdjofvSvKb4A64YK9iJDsaAooJG8o7BDJ/Anr/R26xFU+zI5F897YrNYdOA01k2sRO0a2WITU7hZ96E6/Zwjt8LM01nStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftB//iL5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftB//iL5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so29350505e9.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630615; x=1775235415; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dT/51iTyMD8EYtgPUQxz7kSi+jQ5mE8CjTwC/WRtnWE=;
        b=ftB//iL5KtuIK1Ju7f2xKdSj7U0CgcStPwdTGtBRPAwxFORLmP+qSemYDoMIoGh4Vg
         VY8aXLK6ogItYCCrjRcR/SQxBmzoEx9FH+d6x3AjwpGLrd/tIe+N+bvcOvixb4whlTpT
         e1lH8ZFPcckvnWqO05/lURi1dO/GZjnzrRwuLMSVyWC3ldsuZWtGcTTQf9rbSldPz+RW
         U97vmrM7lP480LVDgGn48R8l5ROUkp3NPYJsKxlyP7ls5zl+MBjLgG9bjiMSftR7PlMt
         JwNb2aFvZNlR2/7sML+JWdQQZMopM6SbpQEaCTlPtEAiqcZqtbStuREIqdg9k+hCXHcZ
         FHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630615; x=1775235415;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT/51iTyMD8EYtgPUQxz7kSi+jQ5mE8CjTwC/WRtnWE=;
        b=nzlpfxn2lWOzo3tIxtnolXLgTclHWZZeEbFkSpFh/VkPCSRSksKb6DUgg8e7ckuvZx
         cjxLmsA0yCfGIORLlTVnhWeGAfmaJ4/eiyFcgAI+HeyqYJ6jaLw4jJR6wkF9dmIDviuB
         3HWSzBv1UZawNubrRWwwye03QWTXiLCt8bPs1wGt/5iIkWk5BniRGHeOjcy35qzFkXhu
         UJQIfcoEOnvMm4pnj5aSgkmvfKPGXICHGu6nTiSJczg+V8/RNAIRRcObup2AiqMI8a4L
         +GMsYGEg9GooWfUhRn5SMD4Ts5AefQTQfjJYk9Bts8p5BEBLTr++DzsC3qJGH4YPKmsE
         u+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKW72Sc/RO8+H3AkcOxPR/XpNPNDhe76k7F1WJ1bd52Q9Is3CeRZzrn6E8Lt91L9qUIB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3LNTYbcw/1PHIh2MEY4ZbZue+QOGElnKTBpLPmRLNVTERSvE
	ztR6EaFQ8/8BvblE0gDp/cHTVJATcrympw2XGyMUWZSBr3QKK8JKOY1y
X-Gm-Gg: ATEYQzyaUEL7m+7KIn7m2C0AJfuygTlyvxhdK1epcm0cw7UU/0OC7KPFYCt7QaHaybF
	23Spjq2PbzjmUyuaM3BFGfrbKYVTxtzeLH9sR3OLCNFa6qm46k+86eAuSAW2/5Wlf9jvmMBw/b+
	asYxj6cKHZG//MNs/zQUIOVGCgAdtoeoncKm2pXpLYs7sD3A0dfIzUB8yUtcl6bog5QOHipEt14
	z5bLF17SbpoEvCBSWhReKb6IHYDvuGXbR0Uget5UFgX/PMsjZIzXYVl9Epi86wdEVMKVUwGRE0G
	ynVtCA+rju4WE1AmPEKfG3dy7LspmLXnF6tuQbmGe7+lMjkXn1+93Knnc9UonFThWbgTEDHcf4R
	FqRpoOY6ayJM4qZU5Dw8e2O5dh+10NyF6Dq4knwkxAtjjnoOKac6nNLn6hbkZMJPkpmdS3Kcsx+
	40eXSxurpHqgk2SiCYYegB7EjTKsgyNnse2g==
X-Received: by 2002:a05:600c:3d87:b0:487:1114:d42f with SMTP id 5b1f17b1804b1-48727d59da0mr54625845e9.1.1774630614938;
        Fri, 27 Mar 2026 09:56:54 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d236a9sm195353905e9.11.2026.03.27.09.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:56:54 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, ameryhung@gmail.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Make sure TLD_DEFINE_KEY
 runs first
In-Reply-To: <20260326052437.590158-4-ameryhung@gmail.com>
References: <20260326052437.590158-1-ameryhung@gmail.com>
 <20260326052437.590158-4-ameryhung@gmail.com>
Date: Fri, 27 Mar 2026 16:56:54 +0000
Message-ID: <874im1i52h.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amery Hung <ameryhung@gmail.com> writes:

> Without specifying constructor priority of the hidden constructor
> function defined by TLD_DEFINE_KEY, __tld_create_key(..., dyn_data =
> false) may run after tld_get_data() called from other constructors.
> Threads calling tld_get_data() before __tld_create_key(..., dyn_data
> = false) will not allocate enough memory for all TLDs and later result
> in OOB access. Therefore, set it to the lowest value available to
> users. Note that lower means higher priority and 0-100 is reserved to
> the compiler.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> index 366a6739c086..e242c455ddae 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -278,7 +278,7 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
>  #define TLD_DEFINE_KEY(key, name, size)			\
>  tld_key_t key;						\
>  							\
> -__attribute__((constructor))				\
> +__attribute__((constructor(101)))			\
>  void __tld_define_key_##key(void)			\
>  {							\
>  	key = __tld_create_key(name, size, false);	\
> -- 
> 2.52.0
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
