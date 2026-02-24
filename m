Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C339A7F2
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938644; cv=none; b=AAiAxWTf11S9N0eZ8omovq2pRfW4H8bV+fOh0xPRYMeSt26j5ZyoV7IxrNVywXcwZCB1Uf4IJJrCa4Ey336nMiuyNj92Bj4/fleNG8GBI/rU/M22HQqrX9SGdWWpc8sNdQqFclB5ttRuNdN9NKTr6qFHVJIncvpF+sSNvuVbUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938644; c=relaxed/simple;
	bh=x9CadwnpvBbG5CH3x//Yz8OZHHKAq7NVk9dhSWagQJo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzJz9R3XJoZGG69EtUMtaKpiR3S4c5vKe8MgrohirccfbWxjuouvDvPfxV0ZAQjaRmvos2UQ6W2izEuGcProQRpzoINoapoFQ1KGn1rwtWDfVhVnLonUxKPRKjB9JpNCW7T7V6Fs8yX63U9VX9BVogRbMmiaT/RUE7itkzyvRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8AO9yIf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8AO9yIf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so50199035e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 05:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771938641; x=1772543441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FKQDZWY7SKE61bky+prMkMM2yhqARIpIhe7cD1aSTY=;
        b=N8AO9yIfJnU3Dw8WYEVwt7HVcX6rCE6U93IrBAKhLckMsBywSGwk44W4CJhhDrJQ4X
         gs2oEC2bU59Jwh2BUh+TtB28BDs3shb3+xNGozF8DNkRU93E8cwuaJzSIRlBX67akOZa
         3v6hO1KdO1+e0xOH9HJhUw9UgGqF2LavxRvllCan/sSbb6yci4oUyfUFUjJo1qH8y9sW
         YHMGXIi7e2M3UYSO2wQz4bKRdrSwG92ctSz1lahAIm7JWhIJy2SxZPbeD9U1CEPIDMCY
         piTIhrLVLhk46RqTevnINqhBRe+QtYIXjw3bcx9zp5WTSHi0quXaYinKzP/wYge7FL2B
         /J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938641; x=1772543441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FKQDZWY7SKE61bky+prMkMM2yhqARIpIhe7cD1aSTY=;
        b=XHKT7STaLHaqumhVC9hC8zEh3YODhunBBKow3gipy0zDruYP5z4jCzJKUipiymEVxA
         t7PaEHy46644LBnFLznxjK1bnfihSk6MlhfOJsuVN89/urbQ5d4vVeH+kSgEKXiNmcvs
         TLqHO8M9gSJqYsQjspC+h6BzWwzjkDs+Or3RuRUcyXkIRV+AAM+bKTiA2J5glrTcZxEq
         xWdapPNqIy2wC7fNYPqrscRYpaQWzlFwA0AaJxgTNViTKNpykMvMQXrOTngAcQlPwE4q
         4+/+ABb7YbxegeF8kWZa+k235Fk3uRwTNzbBTrJq4Uv2QXBRgm3Ovc/HhrTFEli1T/nt
         hFTg==
X-Gm-Message-State: AOJu0Yw4HSleK5UIGZkDVZG42XdUqO/whqtaXHDIViJePH9Ky9rfOLJf
	w7URkYo8YWc/m2tRDiWSacbjcUv5XMUXHw5J802V/R5/3vWrNY468ewQ
X-Gm-Gg: AZuq6aLW+2ia3F2RYOn0KvX2/Cy0gVJx8fn/h0O3ecF8jfi6hxwQnmG1rLXOCIZLw3j
	PZss4+LMJq2zCw3L1xMam8Il1n5kaXV/qQA5XKyKQnvyEDJtlid4FWbeED65xdJOAnupDzvnx4g
	9hLQMgmpAcbvb3n8X8jLEsgvvI5AgWMOhGgTvlfq1EKTzBahkvwWtO5m3LCnNN6ml1ckH4sbL0x
	NnO1mtJDcQ2cO5D7vSFNJE0QDbndwEMxJ4LQy+eyCZPWvF8luGxCom6b5wJz73XivT+aSch7wZP
	ciraGTPD9x+9/byIHsdWQipPecBckHmPH1rgcif8lCVZ1vuNzihdicf1VeWj5TXEzgYg89psKIJ
	dvtdD5Lh7SG0LNBLEfHc01CGpgjIr8c9FwxPZxeIHqudeBr1mPLMa0cYrno1x2xnxQNuGUklS
X-Received: by 2002:a05:600c:1d0e:b0:483:78c7:e1c1 with SMTP id 5b1f17b1804b1-483a95bd940mr205257745e9.12.1771938640484;
        Tue, 24 Feb 2026 05:10:40 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00d0csm27199623f8f.11.2026.02.24.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:10:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Feb 2026 14:10:37 +0100
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 1/3] libbpf: Optimize kprobe.session
 attachment for exact function names
Message-ID: <aZ2jTfNv2qgnRXAK@krava>
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
 <20260223215113.924599-2-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223215113.924599-2-andrey.grodzovsky@crowdstrike.com>

On Mon, Feb 23, 2026 at 04:51:11PM -0500, Andrey Grodzovsky wrote:
> Implement dual-path optimization in attach_kprobe_session():
> - Fast path: Use syms[] array for exact function names
>   (no kallsyms parsing)
> - Slow path: Use pattern matching with kallsyms only for
>   wildcards
> 
> This avoids expensive kallsyms file parsing (~150ms) when function names
> are specified exactly, improving attachment time 50x (~3-5ms).
> 
> Error code normalization: The fast path returns ESRCH from kernel's
> ftrace_lookup_symbols(), while slow path returns ENOENT from userspace
> kallsyms parsing. Convert ESRCH to ENOENT in fast path to maintain API
> consistency - both paths now return identical error codes for "symbol
> not found".
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0be7017800fe..87a71eab4308 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12192,7 +12192,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
>  {
>  	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts, .session = true);
>  	const char *spec;
> -	char *pattern;
> +	char *func_name;
>  	int n;
>  
>  	*link = NULL;
> @@ -12202,14 +12202,36 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
>  		return 0;
>  
>  	spec = prog->sec_name + sizeof("kprobe.session/") - 1;
> -	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> +	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &func_name);
>  	if (n < 1) {
> -		pr_warn("kprobe session pattern is invalid: %s\n", spec);
> +		pr_warn("kprobe session function name is invalid: %s\n", spec);
>  		return -EINVAL;
>  	}
>  
> -	*link = bpf_program__attach_kprobe_multi_opts(prog, pattern, &opts);
> -	free(pattern);
> +	/* Check if pattern contains wildcards */
> +	if (strpbrk(func_name, "*?")) {
> +		/* Wildcard pattern - use pattern matching path with kallsyms parsing */
> +		*link = bpf_program__attach_kprobe_multi_opts(prog, func_name, &opts);
> +	} else {
> +		/* Exact function name - use syms array path (fast, no kallsyms parsing) */
> +		const char *syms[1];
> +
> +		syms[0] = func_name;
> +		opts.syms = syms;
> +		opts.cnt = 1;
> +		*link = bpf_program__attach_kprobe_multi_opts(prog, NULL, &opts);

hi,
good idea, could we do this directly in bpf_program__attach_kprobe_multi_opts ?
seems like it's not drectly related to session

jirka

> +		if (!*link && errno == ESRCH) {
> +			/*
> +			 * Normalize error code for API consistency: fast path returns ESRCH
> +			 * from kernel's ftrace_lookup_symbols(), while slow path returns ENOENT
> +			 * from userspace kallsyms parsing. Convert ESRCH to ENOENT so both paths
> +			 * return the same error for "symbol not found".
> +			 */
> +			errno = ENOENT;
> +		}
> +	}
> +
> +	free(func_name);
>  	return *link ? 0 : -errno;
>  }
>  
> -- 
> 2.34.1
> 
