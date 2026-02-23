Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191773783CE
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879267; cv=none; b=iIiXSPS466Lmk/GNJjJz9hLcg7132E/CvnEk/HQXwDcZVX16UsQkcdHPFNSTPZQ+q3ILMhcug8j953Kfw60eJNFiISXZqlazhWhYqXzeJLGSBU1T6iREyh5KNfK8ypHqp3MSDK64gSH3f2PQEHfTnZUdz/tA5z55DL4GN8+gEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879267; c=relaxed/simple;
	bh=VLbrYIJwMWGuzQz1SNZcSgtdCmIn6DdrhGtP0Qde+rM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKnOFo6aw+5WVObXHXu93pJq4pPfdESTLkYe0q5Nnui+ELHuNiCmKV9NNlqasqwveQjM71EdqZt1+JWwsQUsXA9MNKDoLc72ZGWGBE62GuUbGfRF5KguA+tSrfqExVvacyAUqG8Kk/G/QUT5rHUN7PoNlbetNF31Hhtzkc5qDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgKXYKYj; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgKXYKYj"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1271257ae53so4452073c88.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 12:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771879265; x=1772484065; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wlZBzDcNxEKJGA6OLz+Nok2r1Hy+QsGpkL7Mx9T7Vwo=;
        b=ZgKXYKYjrxgpPAxhie31nUydtHUM+FuJLFFvMQ4vXnb3yjYzpctduVshTfa7B7TaM3
         f8R/cV6M7UYoekTItFMrfxIbUprrobEx3bH7BqWYZA5DXIOoaM4cw9o5ynsx2KAKirVA
         7BI5IrIPCOHvHnlrqfBbfjvXBvNh/3MtdpwcimQprDlBg+UDqlIhUf+lI4Qa1swHiIGx
         prLJdhIBbT8HGfhA/fYelmveP2k4FdXiRY8t3FHVgr7JKsh1MmEfjQSfgZM5g5SN4cgz
         KMQNCCfsdHdTlcsHbftOFrnVY3Kh+9GkCiVPlHAlwmRxlY5k0z85NU7WUOveyBeCnnoV
         605A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771879265; x=1772484065;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlZBzDcNxEKJGA6OLz+Nok2r1Hy+QsGpkL7Mx9T7Vwo=;
        b=lOhw60qs4AEE9McUzz7s3OAVhvv9vJwng6NRwj+ZK6FCuo/zjATvC/6mgcIfWeM1kN
         YptFiG2ycgH/vspbVI5JV/QTMyep7+V1gWrOlrpPy6EHlMkJy9BYZVAlCsapvJZtDlVA
         U9BeGABtNyKRIO0dtM5VLgCu2mjhfjBkGt4Yx5oG7k92MEgTuioQil0ZovxgpB0j9P1/
         yO5vpUfLyk7Un6NyeNTLGM06nKIvaK7OCKel7sCtQT1NResnC+3UdkapweWPPKlyxMII
         a06pBHeMzRudxzJNaZwyx0rGD+fz3/8b1HMt5jLdzCgfuHlP3jIwM+s2++yXe/PdkcRZ
         XtFA==
X-Forwarded-Encrypted: i=1; AJvYcCVzvWAtVplBYFl9O93F+vxZ8gMpgAZssbZnsQwMG2pUe1rp9SBhw5PncIClVzjAJr8vstk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmf2HCdwSaz0UJ47tG4PJbzL3QA0a2AoOTh4gEh/MoZDfgcQ8l
	wbofaXIH/NmMIfykULzaFLK5TONU3V97nEdDpTm7+kXL1573n0HQAUYPefkz+9dz
X-Gm-Gg: AZuq6aLQzJ7mRYiHTCMEltisXBIv2rCR3HLCdYuSWI+PmuPRo+6BGfEDx3jty4uCqFs
	dffS172DCqYOPJHRDRo37o1+EpRopyqjWRmenD6KXksf0eWgvYzxKCvSnj6Cy+7hTFnFKiqZ3ah
	ewqqMfQ4xtleDGaRCdaqp0oynP/Mi+j1hpSfr0n3Ka20DPR7jOcSoBVo3VnaXAFuoyqr1aLb4PY
	2U1cuMok79b+8iJJhY1VNqsMDP0kFKfUgnaQRZYL0EU1eEl85KFDMffauHnQ3KiHEeOBjAUaQaU
	omq+uf8fH3FikL2KVre5uX9jUISFFAhXPYJXjadokUAl7WHPDLrqpG5mEsqZax796EOYWTAmQIQ
	6xUcShryNjipD/Z8z5OhFF9ak6SXMaZRXNZ2aQQ+1rdK/Ca1AeTZhLYDQFRGY7huBfYHeHE1ahF
	HoVrxd9p30aJP+JtbTZ5d7RUU5sj1i+mU0nhuiE5hPjSFUmJsRwpQdhPblrGXbkUy6tv2v4O/iN
	QyIcd8F
X-Received: by 2002:a05:7022:6993:b0:11b:ade6:45a7 with SMTP id a92af1059eb24-1276acb2090mr3375400c88.1.1771879264833;
        Mon, 23 Feb 2026 12:41:04 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:7bec:d612:85a2:37de? ([2620:10d:c090:500::1:3a66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af8c936sm9079044c88.14.2026.02.23.12.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 12:41:04 -0800 (PST)
Message-ID: <9ae642bd94696a019f62aca5f49da3b3d941a927.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Add KF_ACQUIRE and KF_RELEASE
 support for iterators
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Mon, 23 Feb 2026 12:41:03 -0800
In-Reply-To: <20260223174659.2749964-2-puranjay@kernel.org>
References: <20260223174659.2749964-1-puranjay@kernel.org>
	 <20260223174659.2749964-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-23 at 09:46 -0800, Puranjay Mohan wrote:

[...]

> @@ -1083,6 +1084,23 @@ static int mark_stack_slots_iter(struct bpf_verifi=
er_env *env,
>  	return 0;
>  }
> =20
> +/*
> + * Release the acquired reference tracked by iter_st->id, if any.
> + * Used during auto-release in _next, DRAINED handling, and _destroy.
> + */
> +static int iter_release_acquired_ref(struct bpf_verifier_env *env,
> +				     struct bpf_reg_state *iter_st)
> +{
> +	int err;
> +
> +	if (!iter_st->id)
> +		return 0;
> +	err =3D release_reference(env, iter_st->id);
> +	if (!err)
> +		iter_st->id =3D 0;

Nit: maybe drop the `!err` check?
     It requires a few moments to process mentally and the verifier
     should stop on this error anyway.

> +	return err;
> +}
> +
>  static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
>  				   struct bpf_reg_state *reg, int nr_slots)
>  {

[...]

> @@ -9178,8 +9204,11 @@ static int process_iter_next_call(struct bpf_verif=
ier_env *env, int insn_idx,
>  	/* mark current iter state as drained and assume returned NULL */
>  	cur_iter->iter.state =3D BPF_ITER_STATE_DRAINED;
>  	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
> -
> -	return 0;
> +	/*
> +	 * If _next acquired a ref (KF_ACQUIRE), release it in the DRAINED bran=
ch since NULL
> +	 * was returned.
> +	 */
> +	return iter_release_acquired_ref(env, cur_iter);

Nit: Check that `_next` is KF_ACQUIRE here?
     Not strictly needed for this patch but is a bit more consistent.
     E.g. consider some future iterator that acquires reference on creation
     and not on `_next`.

>  }
> =20
>  static bool arg_type_is_mem_size(enum bpf_arg_type type)
> @@ -14197,6 +14226,17 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
> =20
>  		if (meta.initialized_dynptr.ref_obj_id) {
>  			err =3D unmark_stack_slots_dynptr(env, reg);
> +		} else if (base_type(reg->type) =3D=3D PTR_TO_STACK) {
> +			struct bpf_reg_state *iter_st;
> +
> +			iter_st =3D get_iter_from_state(env->cur_state, &meta);
> +			if (!iter_st->id) {
> +				verbose(env, "no acquired reference to release\n");
> +				return -EINVAL;
> +			}
> +			err =3D release_reference(env, iter_st->id);
> +			if (!err)
> +				iter_st->id =3D 0;

Nit: iter_release_acquired_ref()?

>  		} else {
>  			err =3D release_reference(env, reg->ref_obj_id);
>  			if (err)

[...]
