Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7B371878
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947067; cv=none; b=Ivp7Op4QQipROC1EAoNuDHd4G5lLBDjj4gPPnz/61AnU+oTTOK343c6x8eQPK6MRDf17HeURkIUQliiLdsWg7FrJelziMQypwBIqFcIi/J/6fTaanxReZGI0ert5nOHxcbATglUNr9eHJCNExUXasteAyEe7MeS0gbEjONBqqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947067; c=relaxed/simple;
	bh=k528E+foGnZjc/WUKuAV9InREsPYjEI4yQwtIXkIh/A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzcT/v+O6hHg0y4cMaVyQSs8Ampm3i82/M3sudYRgmQ1Sw7/AhM1lHweiCf96MBBRnDr4OfTuxYOT7B6Mt5FLPvs3lDLJmc0vtpcxnlhHOZpCI5H8wbFG2+/RilosbpH/BTy9YViZu/Su/43TFG0C++wmaGEm10igIUKS943tu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2oQIntD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2oQIntD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4728c12ba97so1306989f8f.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783947064; x=1784551864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l0I/X/UkBYjhgh10fSSEuuuQfKfdwOyWW+HpoEOzWog=;
        b=D2oQIntDgAq9/lwZ0gSaSGkJ8sx7tpG1PMqft4kWzOkehAyZIkf9t81x/osdTxmz3I
         2ykGbEMAOQAJNzbOJwZYIz9wA8NpVnIN1suv5aexQIlBHeP02zLO+EvEGy2W1QikvjIN
         yVpR1hLDHkWtn+ej5CKUK/vqLbq0cz3+xOAvN5epLji3rVPgpPQeclbXe81mKpZGWtPv
         sGMx1X9YL7qlspUBhTXFHD2ONq+ZHIJEbPTLcuAn21Y3wcQLCXUIOr0FDAQOy5N5jc2b
         xC6JeD7yctfWF6FECuAzT0Zbxlxl8Yo1y5ZqxpRDXoPvyUZE6qoewLkeQQOJsoGFUrzc
         7YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947064; x=1784551864;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0I/X/UkBYjhgh10fSSEuuuQfKfdwOyWW+HpoEOzWog=;
        b=fa2s+DEfsE+A7M54xXlUIXF9RJUQEUgnAzSUs3YxaP7myZexkY0nNRljFxNNuC3ojJ
         bo8YrOgbUGpNBVQ5qmKa8egSkhUrN0Kj8I2hU3KMUHlGkbWs8wooM1VDIAaAwp3DyCIJ
         8fny1978jhmst35L43Ee6aKLRG07jVpieqC+dm/2nBiYEDqYskjdokmKcKkWjlAaM65v
         /zvVAKtJY+vHstLWHwfce1RL07G7/ovZ8XIre0iZLHabtd4i7yGbFAuP/2ezFl/4O0xr
         uUhCdnhOhvaA1Fo3BVD3xpzADuCa9uGHBm3i3F5N9bt7w8YIxqF0NB/TgU6eT0hzCnfi
         w++A==
X-Forwarded-Encrypted: i=1; AHgh+RrF4uZclYQbc8xpWf+7AyMaxJ6BYE6yiv5Z17p280g7xHTlQ29zhqjtp9vC3Mx8E1F3ZJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8oNe8ZewLT50V79KdMu/yu8dwBE1JpeZRg/NO2FzzxNC62Hl
	BTKdBFMcLuFwRXu0SqKahnnMaVHiXPzx1Ve2Xv+aUFWXVVaSU+tlVvFN
X-Gm-Gg: AfdE7ckZ/fY+xrGNJWJJ3b6KpOLTOZB/CT49Si6bgXHpyGJV28IvoSRBN/rm9IOMn6d
	lGHh6OWI5JTon8s65Aw8tZZo85OJHQx5NVwOboS4hq+4YRD/UvcLPJM9gyJ2q4w2XAQx93d0Mx+
	7SqjP6rQC2lqFeJ9+sa6oDrI/4wTjBqRcYvwP7YoiYMIQ6ys6SoGYRksJijj8F4b3oALAUCYpja
	Tx2S82dSGrnq6d1RpzTejrVXjeSQcSw55MhaiNisgLo0AWofJ3WQaZMkZf8Jehb7ZgLfFchy8jd
	2lAs1RiFTp3jp52jMljdkI++u16cf0l2FnPrCK1s1fiCvJwG+Zr8QVJ9/ztusjT+7wtlVUqLbkI
	NYVtFnTiUf4sfHNaERnYpUkB2xyBQ+uNGs2VMe2HOQuFrbd+nLZp+ZhG58wSPBiJ94Jbs4vsO
X-Received: by 2002:a5d:5f92:0:b0:470:80f7:9ef with SMTP id ffacd0b85a97d-47f2dcb7580mr9906116f8f.19.1783947064142;
        Mon, 13 Jul 2026 05:51:04 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::86b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6da9sm85874543f8f.12.2026.07.13.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:51:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 13 Jul 2026 14:51:01 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix tracing of kfuncs with implicit args
Message-ID: <alTfNc_Q8k0KcSPg@krava>
References: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
 <20260710192940.3020280-2-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710192940.3020280-2-ihor.solodrai@linux.dev>

On Fri, Jul 10, 2026 at 12:29:39PM -0700, Ihor Solodrai wrote:

SNIP

> +
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    const struct bpf_prog *prog,
>  			    const struct bpf_prog *tgt_prog,
> @@ -19121,8 +19159,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  		if (prog_extension &&
>  		    btf_check_type_match(log, prog, btf, t))
>  			return -EINVAL;
> -		t = btf_type_by_id(btf, t->type);
> -		if (!btf_type_is_func_proto(t))
> +		t = btf_attach_func_proto(log, btf, btf_id);
> +		if (!t || !btf_type_is_func_proto(t))
>  			return -EINVAL;
>  
>  		if ((prog->aux->saved_dst_prog_type || prog->aux->saved_dst_attach_type) &&
> @@ -19407,8 +19445,8 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
>  		return -EINVAL;
>  	if (!btf_type_is_func(t))
>  		return -EINVAL;

the btf_type_is_func check is now part of btf_attach_func_proto,
so I think we can remove this one

jirka

> -	t = btf_type_by_id(btf, t->type);
> -	if (!btf_type_is_func_proto(t))
> +	t = btf_attach_func_proto(NULL, btf, btf_id);
> +	if (!t || !btf_type_is_func_proto(t))
>  		return -EINVAL;
>  	err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
>  	if (err < 0)
> -- 
> 2.55.0
> 
> 
