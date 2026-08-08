Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9952C1788
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218340; cv=none; b=Sba5qtFol5V697MBVRvWSzBXliWG9QqtcQlR4E0Qk+bJEkhd8rFwy8Dm6jQ6avQgj9//aw29+/My3vTEP/cJXmPTuJfMi52e0t4gtlXjwj/B6Cx22wn9FfHhVbgR4zLid0o+kdSu6y1VOmIeYQVpl5gj5Jg1KAZJnwZG3gV90yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218340; c=relaxed/simple;
	bh=gsZaI2D6B/uxsvQxLlFW4O0a52AMAQjfbpBshyupauo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HUeewvif8bEQGngxulwmA65OfKSbldli8hXkWYM9wSFjU5cc7JPyy2aUD3gOTxeNBNlTi1TlskktHk9U8gXqPSwzgX8K8VUM1BhFediro94zb2I8zY+L1RngYQTrdllYAaLUfMf9cnrpnUAQYreIwkgkdCQA7TeJbaOenI46ODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy+SBrVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy+SBrVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1418B1F000E9;
	Sat,  8 Aug 2026 19:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218339;
	bh=ZvbRNbXQUtKQRjX5Dth8eXzHyrIYL2G+dIWH/W69vEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uy+SBrVMrKfe7xyPCL3EP9wxfXxI2TIwhP00njVp4Sm/0kvsb8fQ+PHPLuxTF5ih+
	 Rl9shPjgGqFR6r7h9f7MWZDRPRmrs1/gHzu1a0GQdT2R0wRfCjYxdbnhtg7vrMh2Xd
	 N1A/r0v2C80mZnmCN9hYBm23heSiILLfrBSsjLPWWNbkPPPJYdbcWOcZ0nxX3NoBj+
	 AEiCyO77hSUyCjxUSvu40paFV4kZ+ANnPkMZwxrpbmtJufUbMKypDvyBs09ncIIT+M
	 kBo8TsUus+cnTOI9vKUUwq7ybOkbS8qr+Jj120d4tVyCnhRJtc1dWmlcuRuIXIVDDR
	 Dppz9VvsDL43w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 06/13] bpf: Reject callbacks returning more
 than 8 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808190353.1899379-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
 <20260808190353.1899379-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 19:45:38 +0000
Message-Id: <20260808194539.1418B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] check_global_subprog_return_code() fails to validate BPF_REG_2 for=
 global subprograms returning > 8 bytes, allowing kernel pointer leaks.
- [High] BPF-to-BPF calls returning 16-byte values are broken because prepa=
re_func_exit() only copies R0 to the caller, leaving R2 uninitialized.
- [High] BPF programs cannot use 16-byte returns from kfuncs because check_=
kfunc_call() fails to initialize BPF_REG_2.
--

--- Patch [6]: [PATCH bpf-next v3 06/13] bpf: Reject callbacks returning mo=
re than 8 bytes ---
commit d03b8255604638dcb72d6dda989b79be64af9fa4
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject callbacks returning more than 8 bytes

This patch prevents BPF callbacks passed to helpers, kfuncs, or as exception
callbacks from returning more than 8 bytes. Since the callback prototypes
yield a single u64 in R0, returning a 16-byte value would cause the upper
half to be silently dropped. The verifier now rejects such callbacks at
load time in check_ld_imm() and do_check_common().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16306,6 +16306,11 @@ static int check_ld_imm(struct bpf_verifier_env =
*env, struct bpf_insn *insn)
>  			verbose(env, "callback function not static\n");
>  			return -EINVAL;
>  		}
> +		if (bpf_ret_reg_pair(env, subprogno)) {
> +			verbose(env,
> +				"callback function with >8-byte return value is not supported\n");
> +			return -EINVAL;
> +		}
> =20
>  		dst_reg->type =3D PTR_TO_FUNC;
>  		dst_reg->subprogno =3D subprogno;

[ ... ]

> @@ -18528,6 +18533,12 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
>  				ret =3D -EINVAL;
>  				goto out;
>  			}
> +			if (bpf_ret_reg_pair(env, subprog)) {
> +				verbose(env,
> +					"exception cb cannot return value larger than 8 bytes\n");
> +				ret =3D -EINVAL;
> +				goto out;
> +			}
> =20
>  			/* Also ensure the callback only has a single scalar argument. */
>  			if (sub->arg_cnt !=3D 1 || sub->args[0].arg_type !=3D ARG_ANYTHING) {


While reviewing the support for 16-byte return values, I noticed a few other
places in kernel/bpf/verifier.c that might need updates:

In kernel/bpf/verifier.c:check_global_subprog_return_code():

> 	return check_global_ret_scalar_reg(env, BPF_REG_0);

[Severity: High]
Does check_global_subprog_return_code() fail to validate BPF_REG_2 for glob=
al
subprograms returning more than 8 bytes?

A global subprogram returning a 16-byte value (e.g. __int128) could place a
kernel pointer in BPF_REG_2 and exit without the verifier rejecting it,
bypassing the verifier's pointer leak prevention.

Although currently unexploitable because callers have R2 marked uninitializ=
ed
due to another issue, if the caller issue is fixed, or if the kernel reads
the return value directly (e.g. via BPF trampoline), can this missing
validation become an exploitable KASLR bypass or pointer leak?


In kernel/bpf/verifier.c:prepare_func_exit():

> 	/* return to the caller whatever r0 had in the callee */
> 	caller->regs[BPF_REG_0] =3D *r0;

[Severity: High]
Are BPF-to-BPF calls returning 16-byte values broken here?

This only copies R0 to the caller, leaving R2 uninitialized in the caller's
frame. BPF programs calling static subprograms that return 16-byte values
cannot use the upper 64 bits of the return value, as the verifier will reje=
ct
the program with an uninitialized register error.

Additionally, precision backtracking logic added for R2 on static subprog e=
xit
appears to be rendered unreachable dead code because R2 can never be marked
precise by the caller.


In kernel/bpf/verifier.c:check_kfunc_call():

> 	if (btf_type_is_scalar(t)) {
> 		mark_reg_unknown(env, regs, BPF_REG_0);

[Severity: High]
Can BPF programs actually use 16-byte returns from kfuncs?

This handles scalar return types from kfuncs but only initializes R0, leavi=
ng
R2 uninitialized.

Since caller-saved registers (including R2) are cleared before the call, any
BPF program attempting to use this new feature will be rejected by the
verifier when attempting to read R2. Should this also mark R2 as initialized
for 16-byte scalar returns?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808190322.1896=
580-1-yonghong.song@linux.dev?part=3D6
