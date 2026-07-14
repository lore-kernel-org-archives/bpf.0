Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542A3264FB
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052848; cv=none; b=G/pGd6m9/qAKZtyko9xWxkBEsytJsS5zLb+2HughS7n0bFERjsUifhPAROAb1+6s2h/D/hqyCGakuZyhJZXQUCFMELEOw5UQny8f08ovdsaPEPhcNa+hsUgLbOoxWTH4hOHqcT5VuOidnPn3PneugJ7COFwmzjs6/QJ2DzLYrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052848; c=relaxed/simple;
	bh=UBiebPainng191K7yxhOj9z0RREK9FuCEQ6qVUyV0e0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=heBqobOTKZDpeYaMSPrRr362NDEQSBdOY3kWSWTjQFGgHP/AWo218M+7gFPKMoepyHhb1WuKCz3WUy8VTZU9W206V8GcqXth6bumTbvTShkF+bvmz+vzVZU7i7V9YYPFNiA+h/rzFit3yCOMw3CSS4z+8qxoTp3ZearMTtuKKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5mkYfz6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5mkYfz6"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so3364721a12.1
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784052847; x=1784657647; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/mBHuO9FCv6rQ7+Kfp5TVHfUjCv4XAjb3CHE5IdAR8o=;
        b=a5mkYfz6iK/V56wiL4JglLF/dVk37NfFcovrcR//0ATWiUIuIBNSqLSUT+AzVFd8hP
         c3XBc0UlRUUZTURMT/v//gHweL4Ioh7eU7dnmG4zIMdAzn+qiEvJZxK56eObffBm0VcD
         U8xqC9d/dsenzn1Wo0a0pRqnimPHt7+SMB+u09xiws3SjsF8woNJA6LR/OHkLEyeCD4O
         TXH2zwUbZoykkNK8b0BP/OCwf+Kuq45iutbBe4Mz1stZJQMjWw251VXQbypPyC55/cHU
         gAO4UIqnpxAIyscGT8AXcElYxtcjf2JEjClbSYTXZg9OrsPthOcQ2vKo8Tkd6iv/azf9
         6eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052847; x=1784657647;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/mBHuO9FCv6rQ7+Kfp5TVHfUjCv4XAjb3CHE5IdAR8o=;
        b=slr60Itvbc9c2hJ6hCyI9uVyzP0NWsza5B5qU3eaIF+sUqtTL3ZQSOrW40zjvp3PuY
         rCSTCrwSEr5rt8UAtBChOMd/0bkQLqCUa2udP+1ZcHWv6+btR04XCIzdouosAE+79gnN
         tqe0gqsJY0/2mvqb8OQyzgIlCetoWTXh0CI6YAg4G2gGHKEcvoC3JKg4WGgQvyCt7qBI
         RbeJJDxa/YIA9gLDlx673i+a1PvYwxCXi2KUr3kOjB5A8Vb7iFy8qdHzoRRJK2K6Uyki
         Ug3ASFTULVECfC0AtzpNEkupe7zZY9/F5xv9d79OMKh+KHqNEozwspQfwUyweUEsXZwb
         rm6g==
X-Forwarded-Encrypted: i=1; AHgh+RoYLVWz5IatAAI6oSMHBSqvSItFlOKNrE0jlWIOl867YDwYGKZU8TSILw8+QIWTNqvo9/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+km/xUmVhwXgsveW8w2BWOMtOA0AHMkhAJjweq/+IcKlv6zMY
	9uYsV3HlD0Trb7T5x3a3QJmY0bqIKM2hQY5cbKxeTw/bHLIs6YwItMl8
X-Gm-Gg: AfdE7clZtYeCoHxcjMZkIBbnzwdUZ3x1dJK0JEYtoxwaS+IV8yJm7ueR83ytzhRLL+B
	ct12ciErv87jfKubykBRtQNs+yKkRMZnOijPzyXK2RlJpU+0qtptvK9fAUGqKm27PtSktM+tBov
	INSoG+Y4llt3GGIe+et6qhOH6YlNFfLJQNGCzTwYXwiberapRed4bN9dKKI+U639213rNxcNTIl
	KhSlB2rwkhS+LjNX9VOm4+Ebz6pDlNpEV0s8J5ks0cAlUEow8VoRf4cMiQa2cAgMws9StgWGlUt
	a6IE8F469RfDqTAU6R6GZYF7iaCb+M7aUl9Gg0K9RwsjmXBQFBtxc9DbZN2hD9zJPjQlmvonBUi
	VGX3OJUedL5qvDxujdfc7P7vwrD7EQVxkzzAmtC+rvM097cHjuZHogr73Nd0KoEaTyJS3Go6aa4
	1rue0VyJdVaIog32hfiWZ4P3QT0//zFDML6fi6YgZKGTK66NovXIFADCLQzDGPuaqnPWs=
X-Received: by 2002:a05:6a21:6190:b0:3c0:9c19:65ad with SMTP id adf61e73a8af0-3c110a4bb5bmr16638777637.69.1784052846874;
        Tue, 14 Jul 2026 11:14:06 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:11d2:f935:a412:8fad? ([2620:10d:c090:500::972d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b87b92b27sm38192413c88.6.2026.07.14.11.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:14:06 -0700 (PDT)
Message-ID: <04106a6f388a8852e456e473085a38000723be69.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: Unify helper and kfunc
 allocation-size argument handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Tue, 14 Jul 2026 11:14:04 -0700
In-Reply-To: <20260709230242.2003459-4-ameryhung@gmail.com>
References: <20260709230242.2003459-1-ameryhung@gmail.com>
	 <20260709230242.2003459-4-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-09 at 16:02 -0700, Amery Hung wrote:
> The constant "size of the PTR_TO_MEM returned in R0" argument is handled =
by
> both helpers (ARG_CONST_ALLOC_SIZE_OR_ZERO) and kfuncs (__rdonly_buf_size=
 /
> __rdwr_buf_size), each with its own meta field (meta->mem_size,
> meta->r0_size) and duplicated validation. Add struct arg_alloc_mem_desc
> and a shared process_const_alloc_mem_size(), and replace both fields with
> meta->arg_alloc_mem.
>=20
> The desc records presence with a 'found' flag instead of using a non-zero
> size as the sentinel. This also fixes a pre-existing bug on the kfunc
> return path: "no size argument" was tested as r0_size =3D=3D 0, so an exp=
licit
> __rdonly_buf_size/__rdwr_buf_size of 0 was treated as absent and fell
> through to btf_resolve_size(), giving R0 the size of the pointed-to retur=
n
> type instead of 0. With 'found', an explicit zero size is honored and
> btf_resolve_size() is used only when no size argument was passed.

Could you please add a selftest that triggers this bug w/o the change?

> The size is stored in a u32, matching regs[R0].mem_size. The U32_MAX
> check now apply to both helper and kfunc through
> process_const_alloc_mem_size().
>=20
> Fold bpf_session_cookie return size assignment into current kfunc return
> size resolution path.
>=20
> Note that verifier saves kfunc return size through r0_size instead of
> mem_size. The later has no active readers so remove it.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 056b99d26cca..3ed788ec6afc 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1473,6 +1473,12 @@ struct arg_raw_mem_desc {
>  	int size;
>  };
> =20
> +/* Size of PTR_TO_MEM returned, taken from a constant allocation-size ar=
gument */
> +struct arg_alloc_mem_desc {

Nit: 'returned_mem_desc' seem to be a better name.

> +	u32 size;
> +	bool found;
> +};
> +

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e2a3ed67d2eb..fcd9715eff01 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -6974,6 +6974,40 @@ static int check_mem_reg(struct bpf_verifier_env *=
env, struct bpf_reg_state *reg
>  	return err;
>  }
> =20
> +static int process_const_alloc_mem_size(struct bpf_verifier_env *env, st=
ruct bpf_reg_state *reg,
> +					int regno, argno_t argno,

Nit: argno_t can encode both register and stack arguments,
     would it be possible to adjust the code initializing
     'argno' variable in check_func_arg() such that it is
     constructed properly based on 'arg < 5' condition and
     passed here as a single value?
     It appears that such a change would also remove a lot of
     duplicated 'argno_from_reg(regno)' calls in that function.

> +					struct arg_alloc_mem_desc *arg_alloc_mem)
> +{
> +	int err;
> +
> +	if (arg_alloc_mem->found) {
> +		verifier_bug(env, "only one allocation size argument permitted");
> +		return -EFAULT;
> +	}
> +
> +	if (!tnum_is_const(reg->var_off)) {
> +		verbose(env, "%s is not a const\n", reg_arg_name(env, argno));
> +		return -EINVAL;
> +	}
> +
> +	if (reg->var_off.value > U32_MAX) {

Fun fact: when passing parameters to a function, the verifier forces
          the buffer's size to be < BPF_MAX_VAR_SIZ (see check_mem_size_reg=
()).
          But that's pre-existing inconsistency.

> +		verbose(env, "%s allocation size exceeds u32 max\n", reg_arg_name(env,=
 argno));
> +		return -EINVAL;
> +	}
> +
> +	if (regno >=3D 0)
> +		err =3D mark_chain_precision(env, regno);
> +	else
> +		err =3D mark_stack_arg_precision(env, arg_idx_from_argno(argno));
> +	if (err)
> +		return err;
> +
> +	arg_alloc_mem->size =3D reg->var_off.value;
> +	arg_alloc_mem->found =3D true;
> +
> +	return 0;
> +}
> +
>  static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct=
 bpf_reg_state *mem_reg,
>  				    struct bpf_reg_state *size_reg, argno_t mem_argno, argno_t size_=
argno)
>  {

[...]
