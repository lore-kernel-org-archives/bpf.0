Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDE4A33
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771891772; cv=none; b=NgQmjr9p2XE70w3W1sezgz2ZPI3pOURlINIos0G0dZp1NW8cUJjatCOmz2AN4YwQAYoq9yYPotjEWQJK+ikmkZIQHJFgFm0UwYdzUbzqW2rkdAZHd99wi+rW3X25ZISCaHKhxfI3MzgP+F9ek1eivDpjkJtIwAZuJYrAuEuqtxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771891772; c=relaxed/simple;
	bh=xKhDJWyK/cl3hk5DmwvCZDbri+Np95KqWd1DPqHE+QI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DNrr/d3xQiDb8eh9+9AAitSb/w8pe1ABoOmaPJbH4ZhBZe8PNKq8PrHJYYhtNPEwShA1I9QDghqJKsxR0S6waxd8VrT97jGeKaRnmA1Uhf64v9pjCdvu8B9M1pSwLQWzzY3h7Kl8oAjeNYBELtKIAimI+Qyrqb8u8/xv4u+ejmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMd416Ch; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMd416Ch"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba64b5a53aso4608153eec.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771891770; x=1772496570; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=56OCYXq2xHk01JKeesdvH+2uIvKX6569quREfGidvts=;
        b=AMd416ChG9p66mZNYujTZms/Iyf6tXqCs8YXQMoohdXYWDJ22lNXnS09Zlq6+HJf4/
         O+vEaip5Jn4Af3UfQ2LYR8UwWJmoTgCIPoFsKK2J0eMoR5TKN4RVpP2K2LJX3mLQCDG7
         kVehdm2uffPQ26wJ53JJyc88Gbhbm5SSKVmJhu08wYw/FRSDek8xwvfCtNx5qOhA+x88
         CWtmDhHWLgGn7v2/41grV26y53/GFxWcgJX04535XrBtFDHYofywGm2jKohaD8NC7t+A
         Msho4uKkVorDVBMnTPrXjOGV3BAEZCcDgNPGSMvDQQmf9EELRsM8B4aDvnO2AKxSNQFw
         hQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771891770; x=1772496570;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56OCYXq2xHk01JKeesdvH+2uIvKX6569quREfGidvts=;
        b=FahP5UXieEzjiHLHGLRCCHnz3wuuVJG8z0S/jW/BOnaQLPY0Vhp8p+EsYH28TuXIrE
         xhfQV3An1j6k/Wdd6q0Z8pHQSU8kT7lMxH9t1MxZ1AETRMsaPEb/XvugS5uxuNB2yxrc
         OuUSZR/ASGz61XI5o5cTXcDky9NzB0ItwnRVpy353prd1rnc3Nk1Oc4AzFTqdrIaKN6m
         wE6DghSlTDNgbcARYQfoGHNolvEXep0Sb2lofsRrkJGsclQwzyCPszpDVYVhO3np2PB0
         pKLg1qjAkHSx36LPcwRcw7DKL6wrasDNQWLsGPPw/ibco3NA7fGRmB0N18sDuRsVYymS
         ARMg==
X-Forwarded-Encrypted: i=1; AJvYcCUBnfnVQ9cZFEPHN9qidopHXN6YhrnGDcW49j37d4SmRFQO9Zl40kuPXjhh8kwpeZvD91w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/k4VXhOtpJuI665UkL3/ozObHXSQajZ43M20S794n41le+WGh
	fgdFkIabvlFRKTHe24NvyCxNUzdkOqK9zPNx66a5SRXVzRak9CmikWHF
X-Gm-Gg: ATEYQzx8WU8dhnlvR1f4U+VcJocJSAdzpsK3t0DV6f8Cgt7ltTKr8Zi1d7+y99AfjkK
	IVyvgtt7HrwghBu18ZKfZ4sv0+t+jNHH6WiqXeuck7cniZEI48x9qQcYsuctfsNpA7dxx+p3HOf
	6tj+WfNnFIX+2BeNsY23TnODbrWe3OU8cjBFKBsSbx+dMKP4a1OLpqiFllZNKk46X5fXLTvUTzN
	LhJJ/UjWylyM+B4UYlH3iWx4gCEZ4FLE1mfaBQV7iLFNdTOiBiUuNwNUHwrTCUfV1r9XKcl2ARe
	YcbiJTE8j5z/i6Bhgz3I+DAHaueYtmVYfHOHEqa5gRgVqPenlnVxk8AdKql7XDt/yJMRyiBynIh
	bRu2crN2tSEsxyfU0LJtYcMGWyyr892Lrk7iNRI5hXL0oPhsyDQCHv8552cUWlBjmwB9XUP6l2k
	9O2+0OROZN68jiVpd7KUpDzSIWjz8umo4pqn+rHk7z+KYEZxcLtZSUlLViQjh5vfgfpLZNegO5y
	SwzJY8R
X-Received: by 2002:a05:7300:8bac:b0:2ba:8543:c918 with SMTP id 5a478bee46e88-2bd7bd797a8mr3636075eec.33.1771891769755;
        Mon, 23 Feb 2026 16:09:29 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:7bec:d612:85a2:37de? ([2620:10d:c090:500::1:3a66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da45537sm5697407eec.7.2026.02.23.16.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 16:09:29 -0800 (PST)
Message-ID: <7fcfdf81aa76d816f7b5032d5b8a85302621fe64.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Allow void global functions in the
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Mon, 23 Feb 2026 16:09:28 -0800
In-Reply-To: <20260223215046.1706110-2-emil@etsalapatis.com>
References: <20260223215046.1706110-1-emil@etsalapatis.com>
	 <20260223215046.1706110-2-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-23 at 16:50 -0500, Emil Tsalapatis wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0162f946032f..e997c3776fa7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -444,6 +444,29 @@ static bool subprog_is_global(const struct bpf_verif=
ier_env *env, int subprog)
>  	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
>  }
> =20
> +static bool subprog_returns_void(struct bpf_verifier_env *env, int subpr=
og)
> +{
> +	const struct btf_type *type, *func, *func_proto;
> +	const struct btf *btf =3D env->prog->aux->btf;
> +	u32 btf_id;
> +
> +	btf_id =3D env->prog->aux->func_info[subprog].type_id;
> +
> +	func =3D btf_type_by_id(btf, btf_id);
> +	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
> +		return false;
> +
> +	func_proto =3D btf_type_by_id(btf, func->type);
> +	if (verifier_bug_if(!func_proto, env, "btf_id %u not found", func->type=
))
> +		return false;
> +
> +	type =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
> +	if (verifier_bug_if(!type, env, "btf_id %u not found", func_proto->type=
))
> +		return false;
> +

Nit: I there there are a few unnecessary 'verifier_bug_if()' checks here,
     e.g. btf.c:btf_check_all_types() guarantees that func->type and func_p=
roto->type
     would be valid.

> +	return btf_type_is_void(type);
> +}
> +
>  static const char *subprog_name(const struct bpf_verifier_env *env, int =
subprog)
>  {
>  	struct bpf_func_info *info;

[...]

> @@ -17812,6 +17837,16 @@ static int check_return_code(struct bpf_verifier=
_env *env, int regno, const char
> =20
>  	/* LSM and struct_ops func-ptr's return type could be "void" */
>  	if (!is_subprog || frame->in_exception_callback_fn) {
> +
> +		/*
> +		 * If the actual program is an extension, let it
> +		 * return void - attaching will succeed only if the
> +		 * program being replaced also returns void, and since
> +		 * it has passed verification its actual type doesn't matter.
> +		 */
> +		if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT && subprog_returns_void(e=
nv, frame->subprogno))
> +			return 0;
> +
>  		switch (prog_type) {
>  		case BPF_PROG_TYPE_LSM:
>  			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> @@ -17841,6 +17876,10 @@ static int check_return_code(struct bpf_verifier=
_env *env, int regno, const char
>  		default:
>  			break;
>  		}
> +	} else {
> +		/* If this is a void global subprog, there is no return value. */
> +		if (subprog_is_global(env, frame->subprogno) && subprog_returns_void(e=
nv, frame->subprogno))
> +			return 0;

Suppose a global subprogram is verified and it calls bpf_throw().
check_return_code() is called from check_kfunc_call() in such case
with R1 as a parameter.  This check acts on the return type of the
program, will it miss proper return value check for the program?

>  	}
> =20
>  	/* eBPF calling convention is such that R0 is used

[...]
