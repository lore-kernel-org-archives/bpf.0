Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074FCEAF0
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022256; cv=none; b=AFdY8rr9X3mbmpd4rTJlh1K5hlJXL1krVOQS6p9bUZPsly+hHDp/de50jgUUpBReJGcXbMprmsH71f/VF2x+jz79VyYo/zoqHBIeaUVY7Byj2fT/KxBvukME3p4J5ar7ehRawdkn7fvxwwDps00ryv1FHBJDkyg6S0oKSPY51gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022256; c=relaxed/simple;
	bh=gWi2pap83Nu2RXbgYvJUFaGhAa7pfpqpq9MKWf2/k6s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YYEQj+sttaTuAkM3XEbK64Iiq+jFneg/Et5XFAm58SsH5GAL4l+3ybTc92QKY9nZW5UurU7pmpeFsOwz/AlcWT7ON9bYQH6s5xtcWSaj+Ce8M4EPbdi/Wy+U1JkvB9wHU7ItjEsnnlJFBaqcxSz5gvwdMeL69aAGhm05HKAYHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCt2+ysT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCt2+ysT"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so2778548a12.1
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 18:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712022254; x=1712627054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7MnAG8H57AtIjeLuv/6P9n3kOxg6ps8k5VuAlg5LWU=;
        b=MCt2+ysTrd01OgJNfS5SnPh7gRqRtni4kv4ea5K4V/l2mRQFiBmgHJXW9Zhgbwu/8o
         wLXFqjYxX+ZYJsWzvfN/jO83BnXA5wMuZzWKx/gdPIUhH8hcStVXyLSxBSqg8fSndXKd
         yzddRQZur4VNTMSC+ryOKJV/ZYlPgchisrDgIe8OZ0/wlMqIwcXMu3lR4LZoGBDGrEg/
         44e3e77g1/0413fhRn6MQyECIT5LjvPDMTiF5b+X2GrCZaGn/W5z6bmM3gv3uEaRV117
         v/3UV4tzXO/dOr9D53UTVXKPO+D1GvJn4vz2K3KYAAmok1cR4uJlJi1gAqYel2CVJwoq
         t+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712022254; x=1712627054;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y7MnAG8H57AtIjeLuv/6P9n3kOxg6ps8k5VuAlg5LWU=;
        b=vcmxDF+ghn+/ncCqucu2UxB6VFhMR6k+hdXBHEjGBGWBiB5rFVFNeA1XM9mE5Kal/a
         0ddgPlSnZQ8HOHnlxTgixyB2UoyWgE89RWF7DGhygm1DYRwRfLtrla3Yq/BnXYtPjTnO
         TLJV1kAozBGSXU5Z28YH+5D8bxQC05Lq/4/voP+aSap/qrlDrthoeuH9/uOb/3Jkbqt1
         dO3MPfnoN1ZrUmuAy4abpzA0vrslHB/rw+GLVv61xEI11qlY+M64BkwsMyj/Ma/CAlfO
         s1Lai3tAIanjIG4nkxOyIE7zc3ESzAHSKVMgpaxcAaqM/H6CnHOfGTpBvloi6jFmIT0G
         qIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8nTXTJkz30Col+a42LHCP0WdURSFtYNRMdWgnnjRfBKZGWqSW2oOb0RL0jGeLxp64vavU0r61OCvrgH+pB3prl/9m
X-Gm-Message-State: AOJu0YxPBKe8nAJZ/FfxqAICgR0jUbWh7pBMRAqSz9oeVDPeaRUUnM2S
	Op512QGS/gZAOepoaQKZs86YmkvZkyY2HuGeBAZEjEb0yE3IwX26
X-Google-Smtp-Source: AGHT+IHisIdq0JZEgBa2vvMPyQ3JUFq2rUqLE7fHLGco6/r+66RSqB/T/MuneVOYpsGpS45ecGyabQ==
X-Received: by 2002:a17:902:7847:b0:1e0:1bff:59e2 with SMTP id e7-20020a170902784700b001e01bff59e2mr11061082pln.39.1712022254154;
        Mon, 01 Apr 2024 18:44:14 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b001ddce57bdbfsm9680402pld.308.2024.04.01.18.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 18:44:13 -0700 (PDT)
Date: Mon, 01 Apr 2024 18:44:13 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <660b62ed3561d_8015208e4@john.notmuch>
In-Reply-To: <20240401170713.2081368-1-andrii@kernel.org>
References: <20240401170713.2081368-1-andrii@kernel.org>
Subject: RE: [PATCH bpf-next] bpftool: use __typeof__() instead of typeof() in
 BPF skeleton
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> When generated BPF skeleton header is included in C++ code base, some
> compiler setups will emit warning about using language extensions due to
> typeof() usage, resulting in something like:
> 
>   error: extension used [-Werror,-Wlanguage-extension-token]
>   obj->struct_ops.empty_tcp_ca = (typeof(obj->struct_ops.empty_tcp_ca))
>                                   ^
> 
> It looks like __typeof__() is a preferred way to do typeof() with better
> C++ compatibility behavior, so switch to that. With __typeof__() we get
> no such warning.
> 
> Fixes: c2a0257c1edf ("bpftool: Cast pointers for shadow types explicitly.")
> Fixes: 00389c58ffe9 ("bpftool: Add support for subskeletons")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/bpf/bpftool/gen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 786268f1a483..b3979ddc0189 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -386,7 +386,7 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
>  			 */
>  			needs_typeof = btf_is_array(var) || btf_is_ptr_to_func_proto(btf, var);
>  			if (needs_typeof)
> -				printf("typeof(");
> +				printf("__typeof__(");
>  
>  			err = btf_dump__emit_type_decl(d, var_type_id, &opts);
>  			if (err)
> @@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct btf *btf, struct bpf_object *obj)
>  			continue;
>  		codegen("\
>  			\n\
> -				obj->struct_ops.%1$s = (typeof(obj->struct_ops.%1$s))\n\
> +				obj->struct_ops.%1$s = (__typeof__(obj->struct_ops.%1$s))\n\
>  					bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
>  			\n\
>  			", ident);
> -- 
> 2.43.0
> 
> 

sure.

Acked-by: John Fastabend <john.fastabend@gmail.com>
