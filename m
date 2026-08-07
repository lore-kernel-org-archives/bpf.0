Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F354B049C
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063895; cv=none; b=dxKXygrGCdV5cckhz2uQgl5x90EGcNzCLR530kajTmmrL3TPwef1L2aIEbXs0MrZWdbMGC6PqFc7RSpMiZLtsFPwFDsT3lE/R2iv97dGIY/mX0ulXDOnly3GxeZbLK5HEx4lJNA8w8suyhWr4/cWQ0JX1heYDcDu8o0LVXkCmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063895; c=relaxed/simple;
	bh=bPUtfijTFfyCmeiRo5+QSsoEA4eGGuV4qc6rmTNLclw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ng8hZ+HR39J8kNZry5Qje7sgZLWKgftsebEFlLlwXTC12Jw70S0gFKL7Q8RnMWie02gGa+vRSF7PD+Op64KVrQq0e3B455X+j9DtigFB2ILAgdaLZcbAbeumV4l+vfOkkTplaRR/OC0gJebENdgfEd3F7SnnPyUPmR9kNYtj4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5pE2aFP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5pE2aFP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf52d15d88so26856345ad.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 17:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786063893; x=1786668693; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QWP6Xi766A/TGDXAQcki6GXWHSp30NJRI550+694ZfU=;
        b=r5pE2aFPRibYDgLcnNwmuY6gpFTbfFvrRWsHBVChsz4WdBsdIiAPav7TOhVrC9GTz1
         0UsVO7+k4izvIeb8YYjAzKnEn1wE7BEHAzlmIXeXqYyuLCdIqmIjYYnVAxDh0RpCeZnD
         4fKppFNmov0+ERjdS7FtWhYrhxf8nO2bMXL5KsenbwmIi/V+nCivz4HI2xdYC7lo8lqn
         xyvi5g1C7H+F1Gf6NXHS9ygTpo2ULjZf54TT+LpVueV1jVN/yy4ZiW+26eS7bPz2LnNz
         VJvSaPy3eT9/zN7PAH4Prd5C868kDVwuQMBrFvfRr2sI3qU28/Gb+FFTlm6L6JejeB8y
         mTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786063893; x=1786668693;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWP6Xi766A/TGDXAQcki6GXWHSp30NJRI550+694ZfU=;
        b=lSGTBif8C2hQScE+xCoVDz7BrGDFLpFj0mca1d60drccsx6rKZMp0WWtzlNXkl/WN7
         C70zNz7liV37JnuRMtCBOoMl5iFCaXC4jiTcxVxv2cGJeyBF70XGwyzMLXef8rqHu7l+
         6huNF6EMQf4sQisvi40IFgaMld5o4A3Z4B3X46zMcLqZGlfEc+0GwHFOzxxFdt7Tourc
         a0NL9lDjcfBzR1IjoE3soDqO/8hwfD/n5Bb5PEQ63FMBDHBexTqk2a5fkRNZG017HfZd
         1sqrnKvr1m0jP7BEwwnbQUh+pvyDcQmzTU2Efg9G/2/t83w2xxvNOIxQPECsq5yw0tfG
         nQhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFBxj1Dni8MRf58cH22DyU1gYIMlWW3jwhAM4kK6UctrUNNN4QKjxaasa57gaeGrKLfc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4gLkNsa6tbEYLWg4OsjqBZHPgMrZ9RGE/mVFVSjQBRnHinGf
	GqeK5nZs3g/8lCRv2OYt9zSTpfKY/mcuKPqAvu4QsDscy1oBlQec5UzZ
X-Gm-Gg: AR+sD10wCeoFvBOQEW2lhKUgANxQ76IbLdJpGFG+tLVTr3r7D7QczVUZfJiMHAJxaR3
	UHE0qwhTpgx5Vjc04eIitC2I4uYYPoNMdo2q3Pycr5cXZcPJyRynWi6aezY3bJ3E8ECdANdbPvP
	nZtxFck/z6lPuqg64Zzyw7Xpcl/YeB8XMNh2DKUL6ADPficCQ9tLxa2Rdrbudp3CGGoP35Jh8vq
	T7E04P1W7WDggPui33oSnx+6aelJzt9LUCznMbqK3rvP1xNn2hNdDF0t86Ongz9bAgHDwLlNil6
	t0XGu8sAYxkjsT3o0cGAt0vys5Egs0u4mQtpM9u1AIfB142sWjprcoc9NTkreWgTjA4kN/P6tng
	f1o1ipag4pxnNBj2ehh7cy8UQWIMyrS6/CJkDvTlZqUNGzHqegrxXgWkMuqqQ8z/bcTXv6W6K1H
	ON61xWoJVf2ULQu8YtDRwxPdb00niATRo9WHwMGRc8aeKA5gdvGuA7i4pxTv0kCQC0BTKtCWtxZ
	IGkV8DLVUOdKftL
X-Received: by 2002:a17:90b:1e53:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-3903c54b3a1mr16790321a91.2.1786063892937;
        Thu, 06 Aug 2026 17:51:32 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff24b91sm140650a91.9.2026.08.06.17.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:51:32 -0700 (PDT)
Message-ID: <e92417ee5a8486e1310a4fe72527517e4a1a19a3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 05/13] bpf: Support __arena and
 __arena__nullable on struct_ops arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 06 Aug 2026 17:51:29 -0700
In-Reply-To: <20260805210427.3218326-6-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
	 <20260805210427.3218326-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 23:04 +0200, Kumar Kartikeya Dwivedi wrote:

Lgtm, but we botched communication regarding the squash.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f47556b56a48..0d1773af8373 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1289,6 +1289,20 @@ struct bpf_tramp_nodes {
> =C2=A0	int nr_nodes;
> =C2=A0};
> =C2=A0
> +/*
> + * Which 8-byte ctx slots of a struct_ops trampoline hold arena kernel
> + * pointers that save_args() converts to the arena pointer form,
> + * ctx[slot] =3D (u32)(kaddr - kern_vm_start).
> + */
> +struct bpf_tramp_arena_args {
> +	u32 slots;
> +	u32 nullable_slots;	/* subset of @slots where NULL is preserved */
> +	u64 kern_vm_start;
> +};
> +
> +bool bpf_tramp_collect_arena_args(struct bpf_tramp_nodes *tnodes, u32 fl=
ags,
> +				=C2=A0 struct bpf_tramp_arena_args *aargs);
> +

"bpf, x86: Convert struct_ops arena arguments in the trampoline"
removes the type and rewrites bpf_tramp_collect_arena_args()
as bpf_tramp_arena_base(). Please move these definitions here
to avoid unnecessary churn. Same for 'arena_nullable' field below.

> =C2=A0struct bpf_tramp_run_ctx;
> =C2=A0
> =C2=A0/* Different use cases for BPF trampoline:
> @@ -1690,6 +1704,11 @@ struct bpf_ctx_arg_aux {
> =C2=A0	u32 btf_id;
> =C2=A0	u32 ref_id;
> =C2=A0	bool refcounted;
> +	/*
> +	 * We don't encode NULL-ness in the type for the program, but still nee=
d
> +	 * to distinguish it for the purposes of telling JITs what sequence to =
emit.
> +	 */
> +	bool arena_nullable;
> =C2=A0};
> =C2=A0
> =C2=A0struct btf_mod_pair {
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c

...

> @@ -225,27 +229,35 @@ static int prepare_arg_info(struct btf *btf,
> =C2=A0	/* Prepare info for every nullable argument */
> =C2=A0	info =3D info_buf;
> =C2=A0	for (arg_no =3D 0; arg_no < nargs; arg_no++) {
> -		/* Skip arguments that is not suffixed with
> -		 * "__nullable or __ref".
> +		/*
> +		 * Skip arguments that are not suffixed with "__arena__nullable",
> +		 * "__arena", "__nullable", or "__ref".
> =C2=A0		 */
> -		is_nullable =3D btf_param_match_suffix(btf, &stub_args[arg_no],
> -						=C2=A0=C2=A0=C2=A0=C2=A0 MAYBE_NULL_SUFFIX);
> +		is_arena_nullable =3D btf_param_match_suffix(btf, &stub_args[arg_no],
> +							=C2=A0=C2=A0 ARENA_MAYBE_NULL_SUFFIX);
> +		is_arena =3D btf_param_match_suffix(btf, &stub_args[arg_no], ARENA_SUF=
FIX);
> +		is_nullable =3D !is_arena_nullable &&
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btf_param_match_suffix(btf, &stub_args=
[arg_no], MAYBE_NULL_SUFFIX);
> =C2=A0		is_refcounted =3D btf_param_match_suffix(btf, &stub_args[arg_no],
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REFCOUNTED_SUFFIX);
> =C2=A0
> -		if (is_nullable)
> +		if (is_arena_nullable)
> +			suffix =3D ARENA_MAYBE_NULL_SUFFIX;
> +		else if (is_arena)
> +			suffix =3D ARENA_SUFFIX;
> +		else if (is_nullable)
> =C2=A0			suffix =3D MAYBE_NULL_SUFFIX;
> =C2=A0		else if (is_refcounted)
> =C2=A0			suffix =3D REFCOUNTED_SUFFIX;
> =C2=A0		else
> =C2=A0			continue;
> =C2=A0
> -		/* Should be a pointer to struct */
> -		pointed_type =3D btf_type_resolve_ptr(btf,
> -						=C2=A0=C2=A0=C2=A0 args[arg_no].type,
> -						=C2=A0=C2=A0=C2=A0 &arg_btf_id);
> -		if (!pointed_type ||
> -		=C2=A0=C2=A0=C2=A0 !btf_type_is_struct(pointed_type)) {
> +		/*
> +		 * Should be a pointer to struct, or any pointer for __arena or
> +		 * __arena__nullable.
> +		 */
> +		pointed_type =3D btf_type_resolve_ptr(btf, args[arg_no].type, &arg_btf=
_id);
> +		if (!pointed_type || (!is_arena && !is_arena_nullable && !btf_type_is_=
struct(pointed_type))) {

Nit: it is so painful to read conditions like this, adding two variables 'p=
tr_to_struct'
     and 'ptr_to_arena' would make it much nicer. (since respin is needed a=
nyway).

...
