Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E01624D5
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367558; cv=none; b=oywbxMX1/2kptvaKJA+WaqKTutwoTIX2Dr5MGiyyW071wl+E5EzQRT+mT3gAciu8nSdkVzkaxNfs008AMg2aLvaosL9kW5hEYfIiZnaBtTMDr9Q/gTTubjGyG9jHgu/X7PD2U7YhExrSnR0Bq5PVCCBC6xrGdvTmT2QhwQUla1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367558; c=relaxed/simple;
	bh=kvk0+MVwbaR4ux60aCHSzqr7yBusRk1ryvuniX7hjq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p/70H5wLn6KVxGB3UqzuaiG7ZqN4FfTftpNfqX0XFKnvn+dqEfeF3fBZ4loMPvA2XDCSz5su8Bum0Bk0PGRpW/KhrI4jYdVVzJSXp+c4egdWeKfdIPr2HJSiUH2KKTqeB3DpM0ZJOFEQXnsPcDztbiWzkAmnGXMqsSYowFY5CDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4XdTp/L; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4XdTp/L"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8422f395a4aso450760b3a.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 23:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782367556; x=1782972356; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=68KcRpJXcNL6iuSfsYKnlE4wSj5i2OanVCOHmJ6NHSU=;
        b=P4XdTp/LNwlyk18iukOPt/vqvL0mvMwQK/2R4ANpblhkZGzEANA0ByGH1cXHdCcE81
         wGoKo0M2n+kQF82zgnwn1Zk6BmUss60FC0VPtxELZ3ZRvrQz2nyaI1AxtDt2StY1cKEH
         ScgygZAFO1TBEa3Q2K5tFbgRGrVpq28YiyvufJJTZGzi81VaL4eh3e77D2hOXCl6mPbg
         WfLs+m1YUoHjC7CSnUregPE16s8UUAOL5t4x8JtaLcOCQbZJ36lscg8MBYg5jtouShDg
         EOlqDV4+WjIxbinNKwSlaw6+KMvwdGlCOAB7m8G5tnFmHzDhg84VxuwhQ8n0jbgHE6hW
         YFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782367556; x=1782972356;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68KcRpJXcNL6iuSfsYKnlE4wSj5i2OanVCOHmJ6NHSU=;
        b=HdIhP1itoj3zwWIJIpj04Gyq9qiBWYKiafT1/oA17TdWZq5iKc1xhxs0phvHX9J7IP
         /Z0odkoMdlff5Mn/vdAIemFOpNbXXfPEoOVnN8sj1I4SlRp1uE7SE7JW0XZUi0qiTi7Z
         vVyIQyl2KpXEHhmB8QFZ+8t1tzqVMeuD1fg/ecFIeNSFSnT2U81+TVC9BBJshkSy6grB
         u9uGVmHvadaK3tsbDNnxhv4m9tKR9AXl2gZNjlJ0PjqdcWFQ3xs5yllGxpLaYGWUG4vw
         VqRAgeYapkGxD+nZQXSgQWHjLF6HA5CLs5LojvaeQQ28MKJg/2gJpUfUD6gq7LjYFrmt
         Gl2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrB2eRh23KVpjkSDNFfw2nK3CgNyMluVrCOOf1qGbEK1gG8lshQ/Mv8MBAQ5OJ3TEEEqk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bsWA0jGXntnm/asrnAZ8J8+LeQJkuqrRV7B8imjg61Og0hB9
	vKsLHSnQHR21WrXMIVfe11Y1N1gv4zySiz83PZEs3Hvceiev2AGgJa9Z
X-Gm-Gg: AfdE7clSPr/CNa0FIjf3ZN4lo4dTfxvA1+q/YCeF/ICont8jIFF7wb/S3gJxf44b15x
	q4SZhl9e4ZWr9loUourDTYYX+jwm2y5hVCqzaax5nnlSywczqtjkbEd20CpN6cWQl7AxTvyeBf3
	hsqBToq9p3CQTpvIzOK8V0q4pF/b6mDzIcTW45CySMK241ACYsOLUfOoKZ4vWV8snnWaBG+rfNg
	k40U2CFhhxyfShwMNaF7sVyod6SGtr0bxeB/VTHw/oBIcKr9bZMqVN8jh7YTml1+U8ZWi01QEqp
	CuU6eZlxpARYOYGeKkekz3eKyV9xZk886UFfLQS39Wr3PqV/pEEabYMjEsx5qznTJGjlQ6ojgSa
	+auRnkekvzJh0L5+1yWI4Bi9587BvKv66k1/o5VK9yuxnnSL6yNKvg8DJNh68t21Z7LcMEa23Ki
	LRJM9wxyQSrZpP4MtAyTmde0KCZlmiexaXM1EDzBbjP/84MFA5havX
X-Received: by 2002:a05:6a00:ab09:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-84591cba65cmr10573267b3a.25.1782367555930;
        Wed, 24 Jun 2026 23:05:55 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3ec0ec9sm3887798b3a.0.2026.06.24.23.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 23:05:55 -0700 (PDT)
Message-ID: <40a445e92a18ba6325081ae2be784bf0bdd45052.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 11/17] bpf: Report Call Type Safety argument
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 24 Jun 2026 23:05:46 -0700
In-Reply-To: <20260619205934.1312876-12-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-12-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:
> Augment selected helper and kfunc argument-contract failures with Call Ty=
pe
> Safety reports. Keep the existing terse verifier messages and add reason,
> source context, causal register or stack-argument history, and targeted
> suggestions.
>=20
> Cover helper register-type mismatch, helper and kfunc non-NULL pointer
> requirements, release-helper ownership requirements, scalar and constant =
kfunc
> arguments, trusted and RCU pointer contracts, kfunc memory arguments,
> memory/length pairs, refcounted kptrs, constant strings, and IRQ flag sta=
ck
> arguments.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index db151e6b8949..fdbf92bffc17 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -320,6 +320,15 @@ static int arg_idx_from_argno(argno_t a)
>  	return arg_from_argno(a) - 1;
>  }
> =20
> +static int bpf_diag_stack_arg_slot_from_argno(argno_t a)

Nit: drop the bpf_diag_ prefix (or just inline at the callsite?).

> +{
> +	int arg =3D arg_from_argno(a);
> +
> +	if (arg <=3D MAX_BPF_FUNC_REG_ARGS)
> +		return -1;
> +	return arg - MAX_BPF_FUNC_REG_ARGS - 1;
> +}
> +
>  static const char *btf_type_name(const struct btf *btf, u32 id)
>  {
>  	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
> @@ -8161,6 +8170,8 @@ static const char *bpf_diag_reg_type_plain(struct b=
pf_verifier_env *env,
>  			return "a nullable memory pointer";
>  		return "a memory pointer";
>  	case PTR_TO_BTF_ID:
> +		if (type_may_be_null(type))
> +			return "a nullable kernel object pointer";

Nit: move this hunk such that bpf_diag_reg_type_plain() is defined in
     a single patch?

>  		if (type_is_non_owning_ref(type))
>  			return "a borrowed allocated object pointer";
>  		if (type_is_ptr_alloc_obj(type))
> @@ -8173,6 +8184,60 @@ static const char *bpf_diag_reg_type_plain(struct =
bpf_verifier_env *env,

[...]

> +static void diag_call_arg_fmt(struct bpf_verifier_env *env,
> +			      u32 insn_idx, argno_t argno,
> +			      const char *call_name,
> +			      const char *suggestion,
> +			      const char *fmt, ...) __printf(6, 7);

Nit: Is this prototype necessary?

> +static void diag_call_arg_fmt(struct bpf_verifier_env *env,
> +			      u32 insn_idx, argno_t argno,
> +			      const char *call_name,
> +			      const char *suggestion,
> +			      const char *fmt, ...)
> +{
> +	size_t size;
> +	va_list args;
> +	char *reason;
> +
> +	reason =3D bpf_diag_scratch_buf(env, 0, &size);

An alternative to juggling the scratch slot numbers
might be some kind of:

  char *bpf_diag_fmt(env, fmt_string, ...)

that would do the vaprintf behind the scene and accumulate
the buffers in env->diag, to be freed after reporting.

> +	if (reason) {
> +		va_start(args, fmt);
> +		vscnprintf(reason, size, fmt, args);
> +		va_end(args);
> +	} else {
> +		reason =3D "";
> +	}
> +
> +	bpf_diag_report_call_arg(env, insn_idx, argno, call_name, reason,
> +				 suggestion);
> +}
> +
>  static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_s=
tate *reg, argno_t argno,
>  			  enum bpf_arg_type arg_type,
>  			  const u32 *arg_btf_id,
> @@ -8226,6 +8291,32 @@ static int check_reg_type(struct bpf_verifier_env =
*env, struct bpf_reg_state *re
>  	for (j =3D 0; j + 1 < i; j++)
>  		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
>  	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
> +	{
> +		size_t expected_size;
> +		char *expected_buf;
> +		const char *call_name;
> +		int len =3D 0;
> +
> +		expected_buf =3D bpf_diag_scratch_buf(env, 1,
> +						    &expected_size);
> +		if (expected_buf) {
> +			expected_buf[0] =3D '\0';
> +			for (j =3D 0; j < i && len < expected_size; j++)
> +				len +=3D scnprintf(expected_buf + len,
> +						 expected_size - len,
> +						 "%s%s", j ? ", " : "",
> +						 reg_type_str(env, compatible->types[j]));

Nit: this is a bit ugly, maybe hide it as a utility function?

> +		} else {
> +			expected_buf =3D "";
> +		}
> +
> +		call_name =3D meta->func_id ? func_id_name(meta->func_id) : "callee";

Nit: I'd avoid the defensive meta->func_id ? ... here.

> +		diag_call_arg_fmt(env, env->insn_idx, argno, call_name,
> +				  "Pass a value with one of the accepted pointer or scalar types for=
 this call.",
> +				  "it has type %s, but this argument accepts %s",
> +				  bpf_diag_reg_type_plain(env, reg->type),
> +				  expected_buf);
> +	}
>  	return -EACCES;
> =20
>  found:

[...]

> @@ -11808,9 +11908,20 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *=
env, struct bpf_func_state *call
>  	 */
>  	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, met=
a->btf, ref_t, 0) &&
>  	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> +		const char *expected_type;
> +
> +		expected_type =3D bpf_diag_format_btf_type_scratch(env,
> +								 1,
> +								 meta->btf,
> +								 ref_id);

Nit: isn't this exactly the diag_btf_type_name()?
     (and in a few places below).

>  		verbose(env, "%s pointer type %s %s must point to %sscalar, or struct =
with scalar\n",
>  			reg_arg_name(env, argno),
>  			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
> +		diag_call_arg_fmt(env, env->insn_idx, argno, meta->func_name,
> +				  "Pass a verifier-tracked pointer to the expected kernel object typ=
e, not a pointer to stack storage or another memory buffer.",
> +				  "the kfunc expects a pointer to %s, but this argument is %s and ca=
nnot be used as that kernel object pointer",
> +				  expected_type,
> +				  bpf_diag_reg_type_plain(env, reg->type));
>  		return -EINVAL;
>  	}
>  	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;

[...]
