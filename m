Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154633B52EA
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870088; cv=none; b=lITLIsIPHjPoHspIav4XNdeiUXEknD5xWheDP47q0h9UweysVuapHgQ7oYOMhhwaSqOOkgXTP+Rg8wSKe5/QoF5t9iHUE+8GncQhzil1rzDh8rczBSdq0IBCnBMVI/ygXh/L8jEtSRMSejQeo+74dJIhH+/ZwiWV2WFxWAMBuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870088; c=relaxed/simple;
	bh=yeloL1j1lKhLIUg7hud+N8YpLZqVN2MNFPXK4A5PGKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IyqLTBAdTPHU06o6BYrL0+IeBKVnpFoyIgO4MP52muBzr3HBxuY3cu3sztMVP/96S3VUem7EUCq3K8hjbXuYSCmWXrJ9kh6hvO8jDLQv3/lEQsM536slGiM7mru3X2+JBm0zd1Kbei/ggL1XaCwyxdt2bz17Z1Qja1HMLsrO5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKtdNLic; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKtdNLic"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so58106435e9.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 04:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774870085; x=1775474885; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pagEjue3hP0Ovx6smu0Zp6wn4rpL38e2++5mahSGOu8=;
        b=HKtdNLic2OqyuGjisdqQd2Tyl6r6OIV3HNr437W1jtiOp6/fl3qgoq04jiJekSHrQv
         zSbELWWBxLU+BvkCglATFLLEIW0TEVIGYAr1W6eE8HMHyjXcyj8Hg+7/EM0+lQ4aQ8bw
         32q4PWutth7iKfz8qQycP7PVUaBICsx4L59FAuoA6tneC1FvWCF0Vq9gk/CucAEwWz3j
         yQwpr+MY8BMXr9SaRK2C7TbbUH0oH4xvNPMo1U+8i1Oz7wAAuLprtOZJO+kN2rUid5NF
         6yV7bb1WvTtVlxYgzyXFTeRlPuQXl3OKTLmSjOgwBZLf3Rf3rMSmr9+PTXH6dwx94knw
         lERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774870085; x=1775474885;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pagEjue3hP0Ovx6smu0Zp6wn4rpL38e2++5mahSGOu8=;
        b=FtK+/2g+Yoj1q+mY9mBKJzXyakH6jhXnV954DVBlVSH3EVvTzyTbG1uXIw/fH1ff4T
         zwG/RLlu8Tm1KEcgVTZ7OfiQqhR7lN2/yeGkQ1JejtNsxkxHt/UD3WFbGs7CLtEIbtkZ
         rySA1BbkC5r1iJ+6o9qIENQzQOJdT7Nztq7ukoTjCqJXuMby1/Tq8feM/qjw9ufgb/XB
         CwHtj+/+tEKiZoQ4FvN60dAvJVtt1Vq3EoaCVNP3/cpEXNAp1CU8tzS7bLz/VSQJOU4b
         120Zo8fUCVfw9vy442l3ntMrx7nCZhrXoy0tSDduJTvb1R9Lpk1NnpHU3cSxKPT/jPGK
         d86w==
X-Forwarded-Encrypted: i=1; AJvYcCULveMhxYTaGiDTkvogbfcIJufcKjHb/9PBXpz9xiQvuO7jQlPiH350U+auYeDwcVrVmn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGlv4UH/lTAnpqrz5m19+8z3EOSQ3iV5aPTb37WLc/eiCuidL
	xiRvgGzBsWyOZH9Kvq959uDNbIsdkjLMExKsIV34QqQaSejXZh6N5Eh9
X-Gm-Gg: ATEYQzwo87SHcZNxz6ktI8voa0nwd8thfl57LJquy/M3XJTvnYOnigSMYOFO7THTG7k
	JwnDI1Kovk6CzrhFN0cQ2Y7ig1A/v0E/TjN7sgJ0eyeCl48sp9bMGFhAIm6FE2/kxPoe43E+dg9
	GxbYiYyeRaatJGeysJYwLqB3kHf3qJSWlfu7sl5H5swg72h4xH/MtCCW8hHwpXBNNpECEFcrwPL
	GxdSTc8l0YA7FYsf61vB0XP0PCeLAISbRpaa1FPOgdJJGAiPFt4pLYYnnQ8cwWNnWqtBS91NuPu
	wlRWDOD92rSsQeTCeQeFml+Welcm4W6d4nyhf0IzvDE3To2WqKV2KDFd9koxmnKrvbt/JSaEBxs
	9keWINI1BDgGt8HYcu0cVQbzcQaSmVZx7/QAqqlsqcO05OqDH7nTD8MYHGCwdphxIpqO71U7zLR
	vfPhznBUsSd3WeWW7d2/w2hHVuFA==
X-Received: by 2002:a05:600c:8485:b0:487:36c:f5ab with SMTP id 5b1f17b1804b1-48727d73464mr230173515e9.10.1774870085150;
        Mon, 30 Mar 2026 04:28:05 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:4b08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730628efasm285067855e9.5.2026.03.30.04.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:28:04 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Extract bpf_get_linfo_file_line
In-Reply-To: <20260329212534.3270005-2-memxor@gmail.com>
References: <20260329212534.3270005-1-memxor@gmail.com>
 <20260329212534.3270005-2-memxor@gmail.com>
Date: Mon, 30 Mar 2026 12:28:03 +0100
Message-ID: <87qzp1h7zw.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Extract bpf_get_linfo_file_line as its own function so that the logic to
> obtain the file, line, and line number for a given program can be shared
> in subsequent patches.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
The patch extracted bpf_get_linfo_file_line() and modified it slightly
to support optional output arguments.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>  include/linux/bpf.h |  2 ++
>  kernel/bpf/core.c   | 32 +++++++++++++++++++++++---------
>  2 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05b34a6355b0..2c4f92085d79 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3946,6 +3946,8 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>  	return prog->aux->func_idx != 0;
>  }
>  
> +int bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
> +			    const char **filep, const char **linep, int *nump);
>  int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
>  			   const char **linep, int *nump);
>  struct bpf_prog *bpf_prog_find_from_stack(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1af5fb3f21d9..052dd78a2d81 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3313,6 +3313,28 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
>  
>  #ifdef CONFIG_BPF_SYSCALL
>  
> +int bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
> +			    const char **filep, const char **linep, int *nump)
> +{
> +	/* Get base component of the file path. */
> +	if (filep) {
> +		*filep = btf_name_by_offset(btf, linfo->file_name_off);
> +		*filep = kbasename(*filep);
> +	}
> +
> +	/* Obtain the source line, and strip whitespace in prefix. */
> +	if (linep) {
> +		*linep = btf_name_by_offset(btf, linfo->line_off);
> +		while (isspace(**linep))
> +			*linep += 1;
> +	}
> +
> +	if (nump)
> +		*nump = BPF_LINE_INFO_LINE_NUM(linfo->line_col);
> +
> +	return 0;
> +}
> +
>  int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
>  			   const char **linep, int *nump)
>  {
> @@ -3347,15 +3369,7 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
>  	if (idx == -1)
>  		return -ENOENT;
>  
> -	/* Get base component of the file path. */
> -	*filep = btf_name_by_offset(btf, linfo[idx].file_name_off);
> -	*filep = kbasename(*filep);
> -	/* Obtain the source line, and strip whitespace in prefix. */
> -	*linep = btf_name_by_offset(btf, linfo[idx].line_off);
> -	while (isspace(**linep))
> -		*linep += 1;
> -	*nump = BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
> -	return 0;
> +	return bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump);
>  }
>  
>  struct walk_stack_ctx {
> -- 
> 2.52.0
