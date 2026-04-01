Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C23E5EF7
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038723; cv=none; b=DOY8bWQEwOz9UxtjvCGJN8ieMtL4hPdtz9S8BMo/XTkpdUYE7Oaej0fMnT75w2inx/0ihGt3b2L8TTLFNgr8KQjIM+CPEPrT2UDlgj3cw2XirdcpVoP9SSqmu3iIuoS4/WquVdRpMvISGHTDIdW0oZby2o58FJDKJZe/UCD7+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038723; c=relaxed/simple;
	bh=EyjYid29bAhw9hm/p8J3Ub+EF1bcpIqDrqHLvERCp1E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rapHnOzAFUJqUjzD+zBKFwt//NDFEvOWI4Bmi217I2afKwMebEWVUG64s5OJ64nCW9MjWFqhpFUv9J8WTUtjWGAkBiBT7y7x9k3AgiiWDaaD2tsqFwrrfFc+oyoZMHfyNGmtI6hpz9Cxo7OMcjCiyrI2fWsKq35VARmRS1XX/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxEczZBG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxEczZBG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso67528615e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775038712; x=1775643512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7LdBImJvw09LuSxdczLfZcSvTflB+c8zMehtT9Cz5Bw=;
        b=NxEczZBGqJgVX1z98c1EU45a7AKHpG34gubFAnuM3pDngaV+JpvVyBbMrthobo4PbY
         uMAXTl2XLPhWyxkwmqGnx6aRd8UR0ECCRqWsWomxbeEs+hLWtKKrEenQnIk6luZw+rVK
         TGNm5txitqq95jyC0ebS90rvhYgZM6WWvigGv1ES48YOZLbZcKN71iCO1dEiyxMQ2TNX
         d8zF7ESJDybIKHcZNcZXdtqfYCoCFXscmAX1DY8GulFJwaVpWJbi0jaHbEBmc2+rgzFD
         TY64lvjS0latJ/pIajS811HFFUA9VQ6ezg0TIQNzEZxj2mWQLI+6wCHmHLQu/J5QmSua
         L/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775038712; x=1775643512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LdBImJvw09LuSxdczLfZcSvTflB+c8zMehtT9Cz5Bw=;
        b=H8f39mG5z8LFedZcPtnHa0skmAUFnHLw2FzMH23/an+WwKdONsc1RZ3Wb6POnNN73y
         CfknHQcA5tjoZmTOqofkxq4Kjcml4x8d1HXp8HYcF75VH67nFMQ2qK8Ia8E3DhzA+o1A
         9eUQg8qo1RZ3PmZrRBz02P6B9081Ovgm5GzB0G6GA31u/QXrBZ4p1Hw2Gh/vTziZ6pv1
         SsIbuqXThM9bzkLeQnEZWgnJWR72+H2RP5y+XH5qTJq+Zwj9Z1lGSq1d0t9XbbPB/TXQ
         vDh18Hfkvyr16/h7SHbdsr98oCUyjkeEK2bWBLcZxfr1SjvepAVjzlP2MHOFStGb7uh9
         N/EQ==
X-Gm-Message-State: AOJu0Yzj4HsCa5OVcmGZUU14NUjNuZ05StIceqiwo4o0b/6fp9wC43cw
	myhurTFQlEV+KhupuW7iuBPyf/ATZiRwfD7crVqFeEfze8z0nwxTxLH2
X-Gm-Gg: ATEYQzxrEjLw0ishZnRJg++PdYMfzbymH642CZpe/hQNvZZyfoe8gQLYmjKziOZ1Hnp
	enrbCiFXUbTcZizw0FOsp6MgNmaD6UhFbeZoSWQWyYRHbpK6a9fZZfMYAfrv0kDDYz6mu0UsYeu
	JaHMZybs70bNqjIgrJgyKSZPqGyzBXMB7SkHNbua3oyV3awsSDuuy1aXGKPyRDWKqm/yymqvA+r
	MmDpb3JRf8xRktF1TZq8SBy3dB8g5zfylF16WnC2VDp9BcSyjCIqV2Rz4LP9kcomZjBRDAIQsy8
	vD340tWshslq7Bu71eO+aZFmgLu4y321x5FoEvsmtQZrKjAhidoQ3erdH5ly50ob3nJXsoipqIu
	i0uK9U4p4/82xYVkrZp+Kpu5BPpZuieS2wUYSRZxbiON7Bb8mO+kVgLPNI7WAcTRDjuVGSVzd
X-Received: by 2002:a05:600c:3516:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-48883597ccdmr44164355e9.14.1775038711170;
        Wed, 01 Apr 2026 03:18:31 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e884dacsm150889635e9.15.2026.04.01.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 03:18:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Apr 2026 12:18:29 +0200
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 2/3] libbpf: clarify raw-address single
 kprobe attach behavior
Message-ID: <aczw9RkZsAISupsP@krava>
References: <20260401070738.122709-1-hoyeon.lee@suse.com>
 <20260401070738.122709-3-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401070738.122709-3-hoyeon.lee@suse.com>

On Wed, Apr 01, 2026 at 04:05:03PM +0900, Hoyeon Lee wrote:
> bpf_program__attach_kprobe_opts() documents single-kprobe attach
> through func_name, with an optional offset. For the PMU-based path,
> func_name = NULL with an absolute address in offset already works as
> well, but that is not described in the API.
> 
> This commit clarifies this existing non-legacy behavior. For PMU-based
> attach, callers can use func_name = NULL with an absolute address in
> offset as the raw-address form. For legacy tracefs/debugfs kprobes,
> reject this form explicitly.
> 
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
>  tools/lib/bpf/libbpf.c | 14 ++++++++------
>  tools/lib/bpf/libbpf.h | 27 ++++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 536c19c14d21..ebb965230bb4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11816,6 +11816,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>  	default:
>  		return libbpf_err_ptr(-EINVAL);
>  	}
> +	if (!func_name && legacy)
> +		return libbpf_err_ptr(-EOPNOTSUPP);
>  
>  	if (!legacy) {
>  		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
> @@ -11836,20 +11838,20 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>  	}
>  	if (pfd < 0) {
>  		err = pfd;
> -		pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf event: %s\n",
> +		pr_warn("prog '%s': failed to create %s '%s%s0x%zx' perf event: %s\n",
>  			prog->name, retprobe ? "kretprobe" : "kprobe",
> -			func_name, offset,
> -			errstr(err));
> +			func_name ?: "", func_name ? "+" : "",
> +			offset, errstr(err));
>  		goto err_out;
>  	}
>  	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
>  	err = libbpf_get_error(link);
>  	if (err) {
>  		close(pfd);
> -		pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s\n",
> +		pr_warn("prog '%s': failed to attach to %s '%s%s0x%zx': %s\n",
>  			prog->name, retprobe ? "kretprobe" : "kprobe",
> -			func_name, offset,
> -			errstr(err));
> +			func_name ?: "", func_name ? "+" : "",
> +			offset, errstr(err));
>  		goto err_clean_legacy;
>  	}
>  	if (legacy) {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 0be34852350f..bba4e8464396 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -557,7 +557,7 @@ struct bpf_kprobe_opts {
>  	size_t sz;
>  	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
>  	__u64 bpf_cookie;
> -	/* function's offset to install kprobe to */
> +	/* function offset, or raw address if func_name == NULL */
>  	size_t offset;
>  	/* kprobe is return probe */
>  	bool retprobe;
> @@ -565,11 +565,36 @@ struct bpf_kprobe_opts {
>  	enum probe_attach_mode attach_mode;
>  	size_t :0;
>  };
> +
>  #define bpf_kprobe_opts__last_field attach_mode
>  
> +/**
> + * @brief **bpf_program__attach_kprobe()** attaches a BPF program to a
> + * kernel function entry or return.
> + *
> + * @param prog BPF program to attach
> + * @param retprobe Attach to function return
> + * @param func_name Name of the kernel function to attach to
> + * @return Reference to the newly created BPF link; or NULL is returned on
> + * error, error code is stored in errno
> + */
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe(const struct bpf_program *prog, bool retprobe,
>  			   const char *func_name);
> +
> +/**
> + * @brief **bpf_program__attach_kprobe_opts()** is just like
> + * bpf_program__attach_kprobe() except with an options struct
> + * for various configurations.
> + *
> + * @param prog BPF program to attach
> + * @param func_name Name of the kernel function to attach to. If NULL,
> + * opts->offset is treated as a raw kernel address. Raw-address attach
> + * is supported with PROBE_ATTACH_MODE_PERF and PROBE_ATTACH_MODE_LINK.
> + * @param opts Options for altering program attachment
> + * @return Reference to the newly created BPF link; or NULL is returned on
> + * error, error code is stored in errno
> + */
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>                                  const char *func_name,
> -- 
> 2.52.0
> 
