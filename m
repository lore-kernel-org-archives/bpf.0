Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741768;
	b=CgB2QxVPrKjaqdNDJivBPVd1qDt7zRasMR5QFthtlXjzcHuuaMxZLMs3x3ZW5aq2ZM8f
	 ZKain1b/d9w30sbueTVyWJI6QFoJK50+m0uQZqqPDnxu8+jdulU+LZQoSRDfAiCQpUGd4
	 mth/odXhPViIGeHEYfFbrA6G93bJzez1OhlHpzwNIb6Ls5yJI49HEzijQgveFoY/1nCXW
	 RhIHwdZGoHDJhosXj9rUAcouj0KQUXLKuVKLaacT5gPuMr2JF/AQ5BZgoGhmT7w1a7wVD
	 x9fsXykZDkka4z3AKT4tMeBEQ7Pw8Faj1y0CYBEJCppR2pCc309MoSRT6dqMNhlnoLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZpdlkavEfjkayM7oxGd9psZOcAVEgOwlChzz31ofe4s=;
	b=oCStDnTVf2XFwjGhIv+6/FI87A0UPEAw+1KIlKuKUY1obkx0sKHX/mLMR1zzmsAQNGoF
	 8KKkkihVYUfKe/bY9Hmph0jXYfK0ZojL93YsBtGUt4rH1NR/Shf3jblMmCkpbJlXYFgIK
	 hsbxuCK1A4stEDo1IT17Vb8jxyE7umEvGwSq0A1EsoLbcL2DczU9BYgXhJ0rGss9lIp3Q
	 DIhUr1spEYTKcMcaMUKOMQSE4DwwcMNii3+puKBgvKVCjKssIQ3PGsA+D5b8DeMcubXC1
	 5v6uKQTYdbYN9PFRIIBUzVsdkbvebdWs2gsAOM7hRNGHqVwnhRdR+qMFr+HV5hVjGAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFbv5AhT;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4C606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 21:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30A4C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFbv5AhT
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso91935e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 13:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793741766; x=1794346566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZpdlkavEfjkayM7oxGd9psZOcAVEgOwlChzz31ofe4s=;
        b=rFbv5AhTfo5XOIBYYtOGPZf1bVB1qYcCRBIuNzXwAs6xsNXWCcsZHHkjAWJmMwL3pw
         Yn9TYzvlUvh3l+j7x965DBt6rqdTFXUwMw3q8T9tZocXsTl6ZCX64Fz4qCriqnXgSGnX
         wMlAiDy9nqJbW4JIEga8hP0O1rRukdjrLH2L4KeEzcnQt44k6jR4TmdsCppcTr/6A4Ot
         4vAXcX4GB0VYGvYK7EmV796yDOlvRjV5GpNLdx5p3p1paYnkqwBuEwZKt4sA8+uYXP6u
         iHEJpRJe39zyaueaeUKCId94Drp3mzysZSWyFvQmzpmVl4Xp2pIWvewLT1cIXArzD7Jz
         FHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741766; x=1794346566;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpdlkavEfjkayM7oxGd9psZOcAVEgOwlChzz31ofe4s=;
        b=QCnqAuiEvypwLWA6dilyDNTUM87jTKiySNkseJwD7PX42qDJtCm3sL+7jZQ6MUsFgZ
         QkOmb4gieC0IobH41NLkb3Zkcn5uoFnprqDJG3fs4SlRAh52t24aSm0POBIMiKdHZFVW
         ZH/WpYO1EqL0ue9xC/o1FV+MmF8a0AEElgqUMtYjkvqEoxAMpbwumpF0xdJQbvF9IC4w
         mNLg8yCUBDxFCGF3Q5id7dWkIl4nmKtc+4gPLYCZDldsrAFz0Y9g9d9dBNoz4idrQUpY
         kGYJzVSShHpMVbweqpIoNXf1sUDRy7d+HAX+1Ud9dIS+fz1jXOsEgJh+W9oAJ4+IFs/p
         QLIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUm2fmFs+o1LrnMb82375SzFe3XBzXXePMBMoAhSwGoIMjJY3zAT1pLcB/PZPXHEyiU/s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QImGCXxsW2cLaFC0jgBeznoLl73AFRIJc6tTQUPiBoT3TQSrp
	o5rxHcrs/hhJ1ZJLPJbq9KRfU1EeoQ26TE2BBYUQVyijUtsSv1kfk4y2
X-Gm-Gg: AYBFou1YQ4E6yGshWhRsYU+jLgKeT34Xm07BJVDzKvgVnO24HVUYytARXXcQqOd/W4r
	HT0Zk8KDtfnBOxlCZ+iFW0aSMNbOeP1RWjKkIEDqmnXP4oxmF00GWwBi9nPaSrBcBVxwNYgg5Cc
	WF3zk7gk5rxp+OfoRAOyZwM6i91oLeYB7EhnCzuMdyRwjZYF/Uv9LcUMP5jsoTtRaT3fquNrAZA
	cL8lRZrZ2Vpzc36tttJkaF0jsv5nFSoJdKPElfaVHyioSY4FyiM4+npdBBQRIeDgZq9MqA23huI
	Jj1ss6HHYHweFRbpc8hbg2ldeN6qHjiI1mugfo0Wa8rtorej/D0jE3FS826vJ7ovkm1HiFvqDiW
	24axiSLncSCjwYhbSwHYy84nG9ek1bina4ImC7fzwnOu0zUFBrnSpsY2ojZUzoPRDOFVauUIiin
	hGuTFNhUczWcGtjo0l4d2BsTU9qtzWlJq+pDn6kuvIVKtwrV2tbNtb0vTorugFALZOMe32/s8OQ
	YuSMhyo4NlCSNNSvBVlH3hZEgyA5XHvnNa5Mka47O58kP+4i2l2bDwBp2HtCJ0UgxccN0te2Vjg
	nFvj6KvcIpskx4g=
X-Received: by 2002:a05:600c:4e48:b0:4a2:150f:1610 with SMTP id 5b1f17b1804b1-4ac183d16eemr312517175e9.23.1793741766293;
        Tue, 03 Nov 2026 13:36:06 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ed95sm2610425e9.4.2026.11.03.13.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:36:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Nov 2026 22:36:03 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/8] bpf: Honor const on generic kfunc memory
 arguments
Message-ID: <aupTwyu_l85H_XJL@krava>
References: <20261103075916.100050-1-jolsa@kernel.org>
 <20261103075916.100050-2-jolsa@kernel.org>
 <DMLRV3E28SC8.3FJZXLBLZI4DD@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMLRV3E28SC8.3FJZXLBLZI4DD@gmail.com>

On Tue, Nov 03, 2026 at 06:03:21PM +0000, Alexei Starovoitov wrote:
> On Mon, Nov 02, 2026 at 11:59 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > +	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> > +	if (!btf_type_is_ptr(t))
> > +		return false;
> > +
> > +	t = btf_type_by_id(btf, t->type);
> > +	while (t) {
> > +		switch (BTF_INFO_KIND(t->info)) {
> > +		case BTF_KIND_CONST:
> > +			return true;
> > +		case BTF_KIND_VOLATILE:
> > +		case BTF_KIND_RESTRICT:
> > +		case BTF_KIND_TYPEDEF:
> > +		case BTF_KIND_TYPE_TAG:
> 
> My earlier feedback must have been lost ?

ah sry, at the time I saw you email I already had my version
and did not realize yours is different

> 
> This switch is a copy of btf_type_is_modifier().
> All three callers already know that the arg is a pointer.
> t is never NULL.
> One helper of half the size is enough.

ok, will change, thanks

jirka

> 
> 
> The patch from the v1 thread, rebased (compile tested only):
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 73578a4..54d4ce2 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -137,6 +137,10 @@ argument as its size. By default, without __sz annotation, the size of the type
>  of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
>  pointer.
> 
> +The verifier checks such memory for read and write access. When the argument
> +is a pointer to const, like ``const void *mem``, the verifier checks it for
> +read access only, and read-only memory (e.g. ``.rodata``) can be passed.
> +
>  2.3.2 __k Annotation
>  --------------------
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 935b163..21dd273 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13182,6 +13182,22 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
>  	return btf_param_match_suffix(btf, arg, "__szk");
>  }
> 
> +/* A kfunc only reads through 'const T *arg'. The compiler enforces it. */
> +static enum bpf_type_flag kfunc_arg_mem_flag(const struct btf *btf,
> +					     const struct btf_param *arg)
> +{
> +	const struct btf_type *t = btf_type_skip_modifiers(btf, arg->type, NULL);
> +	u32 id, ref_id;
> +
> +	btf_type_skip_modifiers(btf, t->type, &ref_id);
> +	for (id = t->type; id != ref_id; id = t->type) {
> +		t = btf_type_by_id(btf, id);
> +		if (btf_kind(t) == BTF_KIND_CONST)
> +			return MEM_RDONLY;
> +	}
> +	return MEM_WRITE;
> +}
> +
>  static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
>  {
>  	return btf_param_match_suffix(btf, arg, "__k");
> @@ -13550,7 +13566,8 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
>  			PTR_ERR(resolve_ret));
>  		return -EINVAL;
>  	}
> -	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
> +	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
> +		    kfunc_arg_mem_flag(meta->btf, &args[arg]) |
>  		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
> 
>  	return 0;
> @@ -14102,7 +14119,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
>  			return -EINVAL;
>  		}
> -		arg_type = ARG_PTR_TO_MEM | MEM_WRITE;
> +		arg_type = ARG_PTR_TO_MEM | kfunc_arg_mem_flag(meta->btf, &args[arg]);
>  	} else if (btf_type_is_struct(ref_t))
>  		/* A pointer to a struct without a size argument is classified as ARG_PTR_TO_BTF_ID */
>  		arg_type = ARG_PTR_TO_BTF_ID;
> @@ -14127,7 +14144,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  			return -EINVAL;
>  		}
>  		proto->arg_size[arg] = type_size;
> -		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
> +		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
> +			   kfunc_arg_mem_flag(meta->btf, &args[arg]);
>  	}
> 
>  	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
