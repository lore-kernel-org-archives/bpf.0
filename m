Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F7184039
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392217; cv=none; b=c1Az7gg+s0BXs2VqtXGUT5EXZ8OH/7wQ5uKmJGS812QF3oSS0jt4ouZEr5vAgYSOzn8bBU8JUv6jQ51bN4vHdRubAAAF8BlrSoY+DvGoV6u/QEVJz5lQb7udHqJ2Fq0wQRvI4dKA+8oR9sM33wWWYA1aoLn71xgx7QcidxKaxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392217; c=relaxed/simple;
	bh=OBtsmoZ5w1wtCexE5fM24vv3yCvZBNKShUFFRy8HR/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dKbQ9ntJetQHnF3kjmz+y/VOOaejM/jF08SOwIJgC4VHuzHdAysv898xrRUhmxokmjVxtN/Vah3YMR7ZMltfFpwxxO10PMNbxUZEktjtoKGdj+6g9BQI9sJ0yo8Girf2l2kFsrBm3BEVeKu1NbYeq3bTvyFvBfDrfQtnnQcYPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj7kIDOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj7kIDOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9975A1F00893;
	Tue,  2 Jun 2026 09:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780392215;
	bh=mIOY0RrzMXml522VTzuoDhI6UGpIUVlL95+m4TqP0gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kj7kIDOnCnBp8zmEvaNynqvifFViRveXJ1yewXgl4vboocZI2ESvbzxweEgOtUSEm
	 HKT7mSDjj2Hk1cUHe2LfX+sr1XLsUh1bp4JxCX/by34WUf0MmSvHemCOY2/pToqTeW
	 hagnFIx8GSi7kDHtijlt4oSKsXOkzW87hizAuHkaZnPjXzIJLpDxQMFM/D9lG0Njoa
	 ehyPUq5ZaCSEdFpxriCp7EE+PO/wcOQBUjnLsUKrYEFOLUrftvzOW0FzUkctf+bEp8
	 gkUkOKnSsPHlBLri/L5PKqpL2LvByDa7CcUvpML7fUFdgKWY10O8TxkhaKGkV96EiI
	 GPEn4hZXlChFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602085827.2562222-2-chenyuan_fl@163.com>
References: <20260602085827.2562222-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 09:23:35 +0000
Message-Id: <20260602092335.9975A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces a fatal compilation error by using an undeclar=
ed variable `argno` and an undefined function `reg_arg_name`.

Pre-existing issues:
- [Critical] Module BTF dedup failures cause special pointer types (like bp=
f_timer, bpf_list_head, bpf_spin_lock) to fall back to KF_ARG_PTR_TO_MEM, a=
llowing BPF programs to pass attacker-controlled memory instead of valid ma=
p-backed objects.
--

commit 198d635479b994ffecc7d0ff675e91259613ce61
Author: Yuan Chen <chenyuan@kylinos.cn>
Subject: bpf: Fix kfunc implicit arg inject type detection to prevent inval=
id pointer deref

When a module kfunc declares an implicit struct bpf_prog_aux * argument,
the verifier must identify it so the kernel injects env->prog->aux into
the correct register at runtime. This patch ensures the verifier either
validates and injects the correct bpf_prog_aux pointer, or rejects the
program outright if BTF type matching fails.

> Root Cause
>=20
> This issue was triggered by pahole 1.30 generating module BTF with
> incorrect type information, which caused the kernel's distilled base
> BTF deduplication for modules to fail.

[Severity: Critical]
This is a pre-existing issue, but since module BTF dedup failures cause
btf_types_are_same() to return false, does this also affect explicit special
kfunc arguments?

When __is_kfunc_ptr_arg_type() in kernel/bpf/verifier.c fails to match types
like bpf_timer or bpf_list_head, the verifier falls through to the fallback
logic in get_kfunc_ptr_arg_type():

kernel/bpf/verifier.c:get_kfunc_ptr_arg_type() {
    ...
	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->=
btf, ref_t, 0) &&
	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
		...
	}
	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
}

Because structs like bpf_timer and bpf_list_head are composed solely of
scalars, __btf_type_is_scalar_struct() evaluates to true, and they are
categorized as KF_ARG_PTR_TO_MEM.

Does this allow BPF programs to pass a pointer to attacker-controlled memory
(like a stack buffer) to a module kfunc expecting a valid, map-backed kernel
object?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..57e5fdf9f7e06 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12082,9 +12082,22 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
> =20
> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, =
i))
> +		if (is_kfunc_arg_ignore(btf, &args[i]))
>  			continue;
> =20
> +		if (is_kfunc_arg_implicit(meta, i)) {
> +			/* list_push / rbtree_add kfuncs have implicit args
> +			 * (e.g. 'off' parameter) handled during verification
> +			 * in bpf_fixup_kfunc_call().  Don't flag them.
> +			 */
> +			if (is_bpf_list_push_kfunc(meta->func_id) ||
> +			    is_bpf_rbtree_add_kfunc(meta->func_id))
> +				continue;
> +			verbose(env, "%s unrecognized implicit argument, possible BTF mismatc=
h\n",
> +				reg_arg_name(env, argno));

[Severity: Low]
Will this compile?  It looks like argno is neither declared nor defined in
check_kfunc_args(), and reg_arg_name() is undefined in the kernel source tr=
ee.

Should this use regno instead of argno, and a different way to format the
register name?

> +			return -EFAULT;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602085827.2562=
222-1-chenyuan_fl@163.com?part=3D1
