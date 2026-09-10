Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F0309EE7
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077125; cv=none; b=mLo6auLuq6aTm0MWZlr1bd/wpP6I6wh8KJER3eqh1h6s52V7iQaucQazYseskahJZLqk84BIsu0rxujCtsIJdpbd8d0gcRqVSS/oi40gEOz3Ee3+LotzVdsXmrNuPbiGKN+qd9T7CWvt8Er7UIi8Eram+r6hwup3IgjIEHSh0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077125; c=relaxed/simple;
	bh=J8UTQ6JIxoJJR6aibxfqdrGuAfR0T3qIsxa+5dRX2fk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Km/71JCfxMni6Q/ZeCRSYtawFhE2MbI3W1TMk74gyY/6UhqlKSnewN14KoWyBXBQ/fDSCHdxJg9C7ZMzQeoTtKxLh1thXA73yXtI/dmbBI0HbBfntZTR5h6S6cmacDpoIpCIEVE3fXj4oDOb1N/QxFVjW014dAvb6UL1jXgGiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7HJ7gt5; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7HJ7gt5"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-495b27007d0so310048b6e.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789077123; x=1789681923; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m3VMX7gqt4b9SIQ+rVsRsK/GVZVPUiTl2do3nw+FipE=;
        b=W7HJ7gt5rtfKvAkPdtTXoae0KeTf3TqOMTpY9D1c8xxuzjviMkWsqPJ7Tyo7piOGE2
         bUUXn3j5kJ7TtGAYRfYedTMHhgn4p96gWd7ZA3KsyYIAcui3Hp+5efENRmR0LbnJCIG+
         wdc5LnmdvbpIU0B+TOAJBfxqwyjTi5sxqOBo4xjHoMH3G3jVtSbb5ULUxUlf7LShgIll
         flOSeT0txaG6PbQlshsbVrPo304pwbjsZaAyL6rkWe3/i7+KBeTUySHLh1suy6CF59L7
         4qzRQcNTAKYkbLb1u9F/U61Rq68q1QIBwOuKfqqOWv6s0i08qpKEaYifeu81rUeZqV9I
         uG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789077123; x=1789681923;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3VMX7gqt4b9SIQ+rVsRsK/GVZVPUiTl2do3nw+FipE=;
        b=qlKbIhv3JPJ0mJducsyWGzdagOdlLdaWV33etZ45WDMHZkZcKsxOyDFU9Kke7jsUwC
         oNrC02BBZwAdllNAUPQ6467zboJOsjzJu3LT0LwrrwITPqHSeGe0jhv7zOXac/w3q67r
         CSwkQ+B7DSpRhcrVKUmGWgyQMSMS0YghWAMTexNfLQhPTluNG736LTv+Ws3CBkCWt0v4
         QZUktFs3jmDMQK6HrzeYqHlwPZX6FNf0dvjGSJp23gAtgos4JOOyFJZrPNYvm0y8w0lE
         SUwZSGxlMn8Ugq375EQgRCSycFWKb8K3L0AoYxsEpSR+2LsFSdxkazY5jlPiJLLUKnsP
         C1wg==
X-Forwarded-Encrypted: i=1; AKwUvBxCLh7snXmHU1vw1mAaDJlf8ETr0COoI0VZnswt7kk8PQ5dNbTeYqdnB+BtCzi9VIALJ2k=@vger.kernel.org
X-Gm-Message-State: AFuF++mOTRjf0FqQtjhD1RrPrKPF6hRwO5hUj7/EQW1mM+5nmQqM5LZ+
	/SI2l/r7fU+JHRqEW91egzTj6eoKj2QQEFEC/w41maCtsWfoHh+JpCoH
X-Gm-Gg: AYBFou3QBh0o4c8uYXvAbwZTJs2K4O0VIv07+akr6k94bIGjZVj++xVxuNec/BgNT8F
	T1ZPTqbljkpb0mTjJWblXtsWkOuUNu3f++z6VoNbbVKf1j98906tIg8BgfQkXd0XI3CVomllShs
	Yj5l4L5cGrVuO0pllE9VlaTrYuTfZeEL5uwEaGS/lZQAdA51Km6Wn6hkWAWU1UKo1PTK+ECGrOV
	JOwlN64FfSBAZt7JySfvRQm+bHDFvy2HAKSKvbTWhx2xBoEZ87ibeYDdDNHhhv4m8t2ikXfLEM3
	pqxA1iv0r7R3hCvoWRjWOnY4BwHJRv5kioy2cNtX5ynCM2Q9/ksqwKzVmIrCxB18oO6nZCmrNAX
	YOJQgL+Spopp7f/9A5XQYxnFcFVtEP75Fu8z4yXKv38qKSYQ+C9IOsfezDVWlI/06SqSXNafKeg
	wV5MQyJUEB1Rc2J9s2zMithMxoVCNFN8H57Xu4ih9UnzCLappq7oOv23OpygNRuTxIPbi5K7f2d
	4rKKGgSasbjy+frEXtB6dE9iEd/TkDKRmX0aum1DmLkd9AR/vZwINNCzun3WD1M8g==
X-Received: by 2002:a05:6808:2384:b0:495:e5a5:d62 with SMTP id 5614622812f47-4c318f28416mr826343b6e.6.1789077122622;
        Thu, 10 Sep 2026 14:52:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:24::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df90f5b1asm421048fac.11.2026.09.10.14.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 14:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 14:52:01 -0700
Message-Id: <DLBYWR47GK83.33M4TZ2YKQU5W@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 14/22] bpf: Consolidate runtime argument
 type resolution
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260905220117.922028-1-ameryhung@gmail.com>
 <20260905220117.922028-15-ameryhung@gmail.com>
In-Reply-To: <20260905220117.922028-15-ameryhung@gmail.com>

On Sat Sep 5, 2026 at 3:01 PM PDT, Amery Hung wrote:
> A function argument type can require call-site refinement before
> register admission. Helpers refine map-value arguments according to the
> recorded map type, while kfuncs reinterpret a pointer to a scalar-only
> BTF struct as fixed-size memory when the register does not carry a
> BTF ID.
>
> Add resolve_func_arg_type() as the common entry point. It delegates
> helper map-value refinement to the existing resolve_map_arg_type(),
> then handles the kfunc BTF-to-memory fallback. It updates the effective
> argument type and size consumed by the subsequent checks.
>
> Preserve PTR_MAYBE_NULL when changing the base type so later
> nullability validation observes the BTF contract. Keep OBJ_RELEASE
> arguments in their original pointer class. The latter is not a bug fix:
> existing kfunc checking already validates ownership before this
> resolver. It preserves release metadata for the later shared checking
> order, where ownership validation follows register admission.
>
> Moving the kfunc fallback before admission lets the resulting
> fixed-size memory argument enter the compatibility check directly.
> This is another step toward routing both call types through
> check_func_arg().
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 199 +++++++++++++++++++++++-------------------
>  1 file changed, 110 insertions(+), 89 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2e068c095436..15ed47b90316 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8151,8 +8151,8 @@ static bool is_kfunc_call(const struct bpf_call_arg=
_meta *meta, u32 btf_id)
>  }
> =20
>  static int resolve_map_arg_type(struct bpf_verifier_env *env,
> -				 const struct bpf_call_arg_meta *meta,
> -				 enum bpf_arg_type *arg_type)
> +				const struct bpf_call_arg_meta *meta,
> +				enum bpf_arg_type *arg_type)
>  {
>  	if (!meta->map.ptr) {
>  		/* kernel subsystem misconfigured verifier */
> @@ -8180,6 +8180,11 @@ static int resolve_map_arg_type(struct bpf_verifie=
r_env *env,
>  	return 0;
>  }
> =20
> +static int resolve_func_arg_type(struct bpf_verifier_env *env,
> +				 struct bpf_reg_state *reg, u32 arg,
> +				 struct bpf_call_arg_meta *meta, int insn_idx,
> +				 enum bpf_arg_type *arg_type, u32 *arg_size);
> +
>  struct bpf_reg_types {
>  	const enum bpf_reg_type types[10];
>  	u32 *btf_id;
> @@ -8794,6 +8799,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>  	int regno =3D reg_from_argno(argno);
>  	enum bpf_reg_type type =3D reg->type;
>  	const u32 *arg_btf_id =3D NULL;
> +	u32 arg_size =3D arg_type & MEM_FIXED_SIZE ? fn->arg_size[arg] : 0;
>  	u32 key_size;
>  	int err =3D 0;
> =20
> @@ -8823,11 +8829,9 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
>  		return -EACCES;
>  	}
> =20
> -	if (base_type(arg_type) =3D=3D ARG_PTR_TO_MAP_VALUE) {
> -		err =3D resolve_map_arg_type(env, meta, &arg_type);
> -		if (err)
> -			return err;
> -	}
> +	err =3D resolve_func_arg_type(env, reg, arg, meta, insn_idx, &arg_type,=
 &arg_size);
> +	if (err)
> +		return err;
> =20
>  	if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
>  		/* A NULL register has a SCALAR_VALUE type, so skip
> @@ -8965,12 +8969,12 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
>  		 * next is_mem_size argument below.
>  		 */
>  		if (arg_type & MEM_FIXED_SIZE) {
> -			err =3D check_mem_reg(env, reg, argno, fn->arg_size[arg],
> +			err =3D check_mem_reg(env, reg, argno, arg_size,
>  					    arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ, meta, NULL);
>  			if (err)
>  				return err;
>  			if (arg_type & MEM_ALIGNED)
> -				err =3D check_ptr_alignment(env, reg, 0, fn->arg_size[arg], true);
> +				err =3D check_ptr_alignment(env, reg, 0, arg_size, true);
>  		}
>  		break;
>  	case ARG_MEM_SIZE:
> @@ -11814,6 +11818,65 @@ static bool btf_type_is_scalar_struct(struct bpf=
_verifier_env *env,
>  	return btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR);
>  }
> =20
> +static int resolve_func_arg_type(struct bpf_verifier_env *env,
> +				 struct bpf_reg_state *reg, u32 arg,
> +				 struct bpf_call_arg_meta *meta, int insn_idx,
> +				 enum bpf_arg_type *arg_type, u32 *arg_size)
> +{
> +	argno_t argno =3D argno_from_arg(arg + 1);
> +	const struct btf_param *args;
> +	const struct btf_type *ref_t, *resolve_ret;
> +	const struct btf *btf;
> +	const char *ref_tname;
> +	u32 ref_id;
> +
> +	if (base_type(*arg_type) =3D=3D ARG_PTR_TO_MAP_VALUE)
> +		return resolve_map_arg_type(env, meta, arg_type);
> +
> +	if (base_type(*arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {

Overall, it all looks great to me.

Here can reduce indent by:
 if (base_type(*arg_type) !=3D ARG_PTR_TO_BTF_ID)=20
    return 0;

Pls address AI nits and respin, so we can land asap.

