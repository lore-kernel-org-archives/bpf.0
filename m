Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD23054C7
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783639054; cv=none; b=C4MBsNi8ISVqvxdE7Uc0zVpw9/rNCOzQNlxcRMUsfYhtKFYlCI36ZYS/1ls8s1co4xLVu08PSI3hKKgb2OuJpUmyfjsB7K8bI6aX3iVcNyOhhf1neGEzAB7b0Zb7NCQZct4MqiRrpdBHQT7i9ZwbgVmveo1m72tnIY5lBWpmbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783639054; c=relaxed/simple;
	bh=xSKXXRldNoiM3znAQzuQT3Ii6tQPYrx2SoAnCZumMP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mIfyNaAtxpDdnq9tg0Ti0jLxVqvzZErEVN0TP5YZ6DFVfNHbZB81tIDg2nrNycwEuPrs5q6mab+/7xcIWu5V4xjmHpc58GNP/0JW8+X3bCtdKg4+BrDbbnzUKc7qCVgtNmZrbzUUGRQn0a+CyNEQJ4JQmZDUgtdto4GUjXdSd7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6m8UprX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6m8UprX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA701F000E9;
	Thu,  9 Jul 2026 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783639052;
	bh=/NLb4iGXvj/v4Kp3Cyfw8SABovkFWhyQtFZvxGVkrL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6m8UprX0kjA6ge4a3e75lUN6xDZ2ohlsUNDc8EL2ekBRxJRCigbKQ0+GRW58MJWh
	 Cd37DW8/3Wn09tf1jyoJrVSxr6Zbo3juy+KogsiJ4/5Lpavl8nAflCj/ZybBLjVMAH
	 AVl9t0EnDukZ7mNkLcfCs+hVmk3pHJjh1r/tdUGIf3+evse1Tr72me6NaI5zThmU79
	 hJwbeEQCG7IpVxj3RQeiKubhLcsjD2SmXzOAmgtUBU9mklqXReVhYjywhHUU96JEZd
	 iwEyM0bJDIMRmmPOiWuEy4GI6zkb2k8+JKsZA5HM8gLxwIRD6bzI9UEGskBptZOo+S
	 vGx+0yZM4W05A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/4] bpf: Factor out raw_mode-related fields
 in bpf_call_arg_meta
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709230242.2003459-3-ameryhung@gmail.com>
References: <20260709230242.2003459-1-ameryhung@gmail.com>
 <20260709230242.2003459-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 23:17:31 +0000
Message-Id: <20260709231732.AAA701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch drops the detection of `MEM_UNINIT` raw memory arguments=
 for `ARG_PTR_TO_MAP_VALUE`, which incorrectly breaks valid BPF programs th=
at pass uninitialized stack buffers to helpers like `bpf_map_pop_elem` and =
`bpf_map_peek_elem`.
--

--- Patch [2]: [PATCH bpf-next v1 2/4] bpf: Factor out raw_mode-related fie=
lds in bpf_call_arg_meta ---
commit bbac2673fbeb11bb9179553dc669702134b2c290
Author: Amery Hung <ameryhung@gmail.com>

    bpf: Factor out raw_mode-related fields in bpf_call_arg_meta
   =20
    To prepare for unifying the helper and kfunc call_arg_meta, group the
    scattered MEM_UNINIT ("raw") memory argument fields (raw_mode, regno and
    access_size) into a new struct arg_raw_mem_desc.

>     Also drop the bogus raw_mode assignment in the ARG_PTR_TO_MAP_VALUE c=
ase:
>     arg_type_is_raw_mem() only matches ARG_PTR_TO_MEM | MEM_UNINIT, and a=
 map
>     value pointer is handled by check_map_access(), never reaching
>     check_stack_range_initialized(), so tagging it raw mode had no effect.

[Severity: High]
Is this assumption accurate? If a BPF program calls a helper like
bpf_map_pop_elem() and passes a stack buffer (PTR_TO_STACK) as the map
value buffer, wouldn't check_helper_mem_access() call
check_stack_range_initialized() to validate the stack access?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7dd961ede88df..e2a3ed67d2eb5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6690,6 +6688,8 @@ static int check_stack_range_initialized(
>  	 * but BTF based global subprog validation isn't accurate enough.
>  	 */
>  	bool allow_poison =3D access_size < 0 || clobber;
> +	/* The call will initialize the memory; uninitialized stack allowed */
> +	bool raw_mode =3D meta && meta->arg_raw_mem.regno =3D=3D reg_from_argno=
(argno);
> =20
>  	access_size =3D abs(access_size);

[Severity: High]
Because arg_type_is_raw_mem() only checks ARG_PTR_TO_MEM, arg_raw_mem.regno
will not be set for ARG_PTR_TO_MAP_VALUE arguments.

Consequently, raw_mode will evaluate to false here. Does this cause the
verifier to fail to bypass the uninitialized read checks, rejecting valid
unprivileged programs with an 'invalid read from stack' error?

[ ... ]

> @@ -8403,7 +8401,6 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>  			verifier_bug(env, "invalid map_ptr to access map->value");
>  			return -EFAULT;
>  		}
> -		meta->raw_mode =3D arg_type & MEM_UNINIT;
>  		err =3D check_helper_mem_access(env, reg, argno_from_reg(regno), meta-=
>map.ptr->value_size,
>  					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
>  					      false, meta);

[Severity: High]
Without this MEM_UNINIT assignment for ARG_PTR_TO_MAP_VALUE, does the
verifier incorrectly reject valid programs passing uninitialized stack
memory?

[ ... ]

> @@ -10303,8 +10292,9 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>  	/* Mark slots with STACK_MISC in case of raw mode, stack offset
>  	 * is inferred from register state.
>  	 */
> -	for (i =3D 0; i < meta.access_size; i++) {
> -		err =3D check_mem_access(env, insn_idx, regs + meta.regno, argno_from_=
reg(meta.regno), i, BPF_B,
> +	for (i =3D 0; i < meta.arg_raw_mem.size; i++) {
> +		err =3D check_mem_access(env, insn_idx, regs + meta.arg_raw_mem.regno,
> +				       argno_from_reg(meta.arg_raw_mem.regno), i, BPF_B,
>  				       BPF_WRITE, -1, false, false);

[Severity: High]
Since meta.arg_raw_mem.size remains 0 for ARG_PTR_TO_MAP_VALUE, does this
cause check_helper_call() to skip this post-processing loop entirely?=20

Skipping this could miss crucial state scrubbing when a privileged program
uses special slots like STACK_DYNPTR as a map value buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709230242.2003=
459-1-ameryhung@gmail.com?part=3D2
