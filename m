Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23048097B;
	Fri, 25 Sep 2026 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372564; cv=none; b=Cor14mGP6UxLHQMAta5HCqbkLxIvKw6z95MCKPjkp8aP0crQzwT7xm/iVhTH7ubRrStCKghfv7azTODnSCLQQIkJHOAZco1U7FEtA5Qa1VwxRaMLt+1WtYXMir92mlZRiLMNZ+TPOadkRwDWp14+6BlOLido/UGKpNJoJDX4Qig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372564; c=relaxed/simple;
	bh=6cBTDfXrN3G+VKLi/fzl4YGdODAM1ltZ4omSGjVotvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RbrWGNokcpRXk7hZgm542cURvXJWJNa/66OWSidwrBJTfjRtsk0FSBSWrvEkD80LJno1uYn7PECOaVFEcz3T0f9EKm5z+tOssIN3MFdCls25beHbWYzzZHARJQTKz7rukQrvJObyhdWkw2iZ3ctfAblS7zOYovIR2HG3Wjuv0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzfOVELl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzfOVELl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367201F000FF;
	Fri, 25 Sep 2026 21:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790372562;
	bh=KoPDG8/do7TX+GsahT3CIdo/LvRtlXhe38jTPslnFZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzfOVELlSzFUt5STifeU/d5/o125+hPI7uNyzbaDwrqP2w6184o1iJh52mfAM0TT0
	 ZNMz/bQhE6bhOccdr/xJFFH3ib8R8YkUIDSb0HqDR/0i6zvxQWFVKJV5AKYefmeQdX
	 gY54+YqW8IQGjx9vfkFH3LuWIaLR+416bb28HrMLR0HaBA3ta2Uv4i1o7BiOxqxRmU
	 O9KnOEGkgKl5mlGF9DKCY/fUgmp9MgrEp7N2p7Nd5e9U8W3gK4pNalVd1naR2ktfgi
	 hHAD2FUHhjrCy0HOQ8mErGHWmyiQ9p7Hq6FOIgOPzrl5FoR5bTzOykpQvYFEOAgc1s
	 HlH1KfGw69fCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/9] bpf: fetch the vmlinux BTF where kernel
 types enter a program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260925211314.5118-4-wanjay@amazon.com>
References: <20260925211314.5118-1-wanjay@amazon.com>
 <20260925211314.5118-4-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:42:41 +0000
Message-Id: <20260925214242.367201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: NULL pointer dereference in process_arg_ptr_to_btf_id due to =
missing ARG_PTR_TO_BTF_ID_SOCK_COMMON
--

commit 84d2361be82e8cb989ae15ca8d3347130aa3ce1b
Author: Jay Wang <wanjay@amazon.com>

bpf: fetch the vmlinux BTF where kernel types enter a program

This commit defers fetching the vmlinux BTF in the BPF verifier until
kernel types are actually needed by a program. This optimization avoids
loading and parsing BTF data for programs that do not use kernel types,
such as simple socket filters.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7c9e2d8965d5..f02ecb0dae75c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -11568,6 +11570,24 @@ static int release_reg(struct bpf_verifier_env *=
env, struct bpf_reg_state *reg,
>  	return err;
>  }
> =20
> +/* Does calling helper @func_id bring kernel BTF types into the program?=
 */
> +static bool helper_uses_vmlinux_btf(enum bpf_func_id func_id,
> +				    const struct bpf_func_proto *fn)
> +{
> +	int i;
> +
> +	/* these take the kernel type id in a struct btf_ptr, not in a register=
 */
> +	if (func_id =3D=3D BPF_FUNC_snprintf_btf || func_id =3D=3D BPF_FUNC_seq=
_printf_btf)
> +		return true;
> +	if (base_type(fn->ret_type) =3D=3D RET_PTR_TO_BTF_ID)
> +		return true;
> +	for (i =3D 0; i < MAX_BPF_FUNC_ARGS; i++) {
> +		if (base_type(fn->arg_type[i]) =3D=3D ARG_PTR_TO_BTF_ID)
> +			return true;

[Severity: High]
Does this logic also need to check for ARG_PTR_TO_BTF_ID_SOCK_COMMON?

If ARG_PTR_TO_BTF_ID_SOCK_COMMON is omitted here, helpers like
bpf_sk_release() that accept this argument type will skip loading
btf_vmlinux.

If a program synthesizes a PTR_TO_BTF_ID pointing to a module's BTF using
ldimm64, btf_vmlinux could remain NULL. Later, in check_func_args(),
arg_btf is assigned from btf_vmlinux:

check_func_args() {
    ...
    case ARG_PTR_TO_BTF_ID:
    case ARG_PTR_TO_BTF_ID_SOCK_COMMON:
    {
        const u32 *arg_btf_id =3D fn->arg_btf_id[arg];
        const struct btf *arg_btf =3D meta->btf ?: btf_vmlinux;
    ...
}

Because btf_vmlinux is NULL, arg_btf becomes NULL. Could this lead to a
NULL pointer dereference when process_arg_ptr_to_btf_id() unconditionally
dereferences it?

process_arg_ptr_to_btf_id() {
    ...
    arg_t =3D btf_type_skip_modifiers(arg_btf, arg_btf_id, &arg_btf_id);
    ...
}

> +	}
> +	return false;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925211314.5118=
-1-wanjay@amazon.com?part=3D3
