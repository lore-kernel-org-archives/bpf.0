Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024043C7B1;
	Wed, 23 Sep 2026 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143462; cv=none; b=E+BcGNhnFFjQQmUjGrARwzmmuf3W3D6gXM5BvlCwX/u02VS88H+/cxJqB9gB8B0TVt3bla7s3EwXzJ6vpDC/Rwa7gQfUFhQ+IDnPF/A0l4eZWTRxA2pN0tnA6r8IFzwC6PimqhoCCMDBq5b3MNIITYb8nb6HDzYK5a2C0wCLYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143462; c=relaxed/simple;
	bh=KZZLvh/Rnb+SX6UdsPekIii9ycH3G+daLNCp8ikcsD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H7B+lydb3xRSf4iaOVUxM/4Dm7P6Eg3FVt8ULxX2qyK0628B+lEiRSwg+sdp/hOAjf/TOTNCWx6be0sEK6VzyXh9ZbosplaTboPI4msDh/gg/5dXiWlA/N1YEIXCCLbT1TVx0PjiHu51ya7Gp5dDBWTFY5g1y9yWbZx5+FC1X1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv4vERby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv4vERby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F141F00893;
	Wed, 23 Sep 2026 06:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790143461;
	bh=HKCy1J0wtnVlGdqfStoYZ8oHIGxDhEI8aQlme7TXDd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rv4vERbyhGsv97hKC8J9ezxt9Pk2upGOvjgN733PtIOi1Na0u+Hj9k/LUBSYwEuH6
	 iLj7bnoD6r1SebCOaXdp67Ki4W9H/H6eEPy9BRHtFwOLhrnkL3+MhzsPeaDeCqr6eA
	 FeBZNM3pcjGMcbIbpv0sQY+kMqIfqaz/3yUUvrqBAO77Aygphe+j9fjZmuLbuKHNyi
	 /Q3DTcjSwuntLxKAlFFM7Pv2lkOgjzmIkgSiiDFagrQY6BT2BdJToNjNrOGF+5WF/Q
	 PnY8odYCW/9SbVHRAK+5QGkt/px9bP04iG2KfBWKX4dFvRXaarJz/KGrniWKaPiAiA
	 0pfg3V8d8GWGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/6] bpf: fetch the vmlinux BTF where kernel
 types enter a program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: linux-modules@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260923053948.30617-4-wanjay@amazon.com>
References: <20260923053948.30617-1-wanjay@amazon.com>
 <20260923053948.30617-4-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 06:04:20 +0000
Message-Id: <20260923060420.F3F141F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] bpf: crash on blind dereference of ERR_PTR from bpf_get_btf_vmlinu=
x()
- [High] bpf: single vmlinux BTF parse failure permanently bricks verifier
- [Medium] bpf: context translation fails for EXT/TRACING progs without vml=
inux BTF
- [Medium] bpf: AB-BA deadlock between bpf_verifier_lock and request_module=
()
- [Medium] bpf: bpf_snprintf_btf fails because vmlinux BTF load is skipped
--

commit 68de9774165f5e9dfaacde093071f89754bece4b
Author: Jay Wang <wanjay@amazon.com>

bpf: fetch the vmlinux BTF where kernel types enter a program

This commit delays the fetching and parsing of vmlinux BTF in the BPF
verifier, moving it from an upfront operation for all programs to an
on-demand fetch. This prevents unnecessary module loading and memory usage
for BPF programs that do not rely on kernel types.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7c9e2d8965d5..2425ea74b61d6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2873,7 +2873,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env=
, u32 func_id, u16 offset)
>  	tab =3D prog_aux->kfunc_tab;
>  	btf_tab =3D prog_aux->kfunc_btf_tab;
>  	if (!tab) {
> -		if (!btf_vmlinux) {
> +		/* with CONFIG_DEBUG_INFO_BTF=3Dm this is where the vmlinux BTF gets l=
oaded */
> +		if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {

[Severity: Medium]
Could this introduce an AB-BA deadlock with the module loader?

For unprivileged programs, bpf_check() acquires bpf_verifier_lock before
executing instruction verification. When CONFIG_DEBUG_INFO_BTF=3Dm, this
on-demand fetch calls request_module() which blocks and spawns a usermode
helper (modprobe).

If the usermode helper (or another user-space process triggered during the
module load) attempts to load an unprivileged BPF program, it will block
indefinitely waiting for bpf_verifier_lock.

[ ... ]

> @@ -11568,6 +11570,20 @@ static int release_reg(struct bpf_verifier_env *=
env, struct bpf_reg_state *reg,
>  	return err;
>  }
> =20
> +/* Does calling @fn bring kernel BTF types into the program state? */
> +static bool helper_uses_vmlinux_btf(const struct bpf_func_proto *fn)
> +{
> +	int i;
> +
> +	if (base_type(fn->ret_type) =3D=3D RET_PTR_TO_BTF_ID)
> +		return true;
> +	for (i =3D 0; i < MAX_BPF_FUNC_ARGS; i++) {
> +		if (base_type(fn->arg_type[i]) =3D=3D ARG_PTR_TO_BTF_ID)
> +			return true;
> +	}
> +	return false;
> +}

[Severity: Medium]
Does this logic miss helpers that require the vmlinux BTF but don't explici=
tly
take or return a PTR_TO_BTF_ID?

For instance, the bpf_snprintf_btf helper takes a struct btf_ptr * as an
ARG_PTR_TO_MEM. Because this isn't caught by helper_uses_vmlinux_btf(), the
verifier skips loading the BTF.

At runtime, the helper calls bpf_peek_btf_vmlinux(). Since the module was
never loaded by the verifier, this returns NULL and the helper functionally
fails with -EINVAL, potentially breaking valid BPF programs that rely on it.

[ ... ]

> @@ -21724,7 +21762,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
>  	if (ret)
>  		goto err_prep;
> =20
> -	bpf_get_btf_vmlinux();
> +	/*
> +	 * The vmlinux BTF is not fetched up front: with CONFIG_DEBUG_INFO_BTF=
=3Dm
> +	 * it is loaded on demand, at the points where kernel types enter the
> +	 * program (attach_btf, kfuncs, ksyms, map pointers, BTF-typed helpers).
> +	 */

[Severity: High]
Can a single transient module load or parse failure permanently brick the
verifier?

If bpf_get_btf_vmlinux() fails (e.g., due to ENOMEM or a temporary module l=
oad
failure), btf_parse_vmlinux() returns an ERR_PTR which is permanently cached
in btf_vmlinux via smp_store_release(&btf_vmlinux, btf).

The verifier unconditionally checks if (IS_ERR(btf_vmlinux)) at the beginni=
ng
of bpf_check(). Consequently, a single transient failure permanently breaks=
 the
loading of all subsequent BPF programs system-wide, including those that do=
 not
require BTF.

[Severity: Medium]
Does removing this upfront fetch break context translation for EXT and TRAC=
ING
programs?

When loading a BPF_PROG_TYPE_EXT or BPF_PROG_TYPE_TRACING program targeting
another BPF program, bpf_prog_load() skips fetching the vmlinux BTF. If the
program does not trigger an on-demand BTF load via kfuncs or helpers, the
global bpf_ctx_convert.t remains NULL.

During verification, btf_ctx_access() calls btf_translate_to_vmlinux(), whi=
ch
uses find_canonical_prog_ctx_type(). Because bpf_ctx_convert.t is NULL,
translation fails and the verifier incorrectly rejects valid context access=
es.

[Severity: High]
Does delaying the BTF load expose paths to blind ERR_PTR dereferences?

Because the patch makes the BTF load lazy, it is more likely to fail much l=
ater
in the verification process, exposing paths that blindly dereference the
pointer returned by bpf_get_btf_vmlinux() without checking IS_ERR().

For example, btf_prepare_func_args() does:

    vmlinux_btf =3D bpf_get_btf_vmlinux();
    ref_t =3D btf_type_by_id(vmlinux_btf, kern_type_id);

And btf_check_kfunc_name() does:

    id =3D btf_find_by_name_kind(bpf_get_btf_vmlinux(), func_name, kind);

If bpf_get_btf_vmlinux() returns an ERR_PTR, passing it directly to these
functions will result in a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923053948.3061=
7-1-wanjay@amazon.com?part=3D3
