Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8763C3F58
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546112; cv=none; b=HCtFTKjCl0d64rTDIjz+/NMOUxQyGNLb5jGo78Tg/Qbmyvt1jpCEIwZzRaXWfSBIXshKwVhf8/pYXnLQL91nwCHV5d9RWzMdyxSJeTTIPy6Zb1TJwthUCoKu52cpA+V3jVZvameG6om6AT99PT/Kl9cMM1iAt62jIdziBHVw1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546112; c=relaxed/simple;
	bh=erkB+pv5RbI0KKRL9l5UdsPsers0Kyn5gASlvVaG6yM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MMOc9d9odmHwQ1MxYExnaqY8x3XWtJs1ehp3kANxTcNOHZEtNA9kcDRFD6WhHnLqdOmdVeo2hDopPuMl3VKGvccmSiABgXUGv65GjL/IJl+TSWuVUr3hZBB7HtZBoj77DVb7IvPJux7NI5WeNiwxb5Ryun4fSw7VbvmNnvRUXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOEEeayP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOEEeayP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3391F000FF;
	Fri,  9 Oct 2026 11:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546102;
	bh=Nt3THb/FIo4zJ0rRNJORVeM0sQ29C2HS0304Xu1qPkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VOEEeayPNS7P9iFT0s37S/ocdhZkT1dARYtwi4KnlT5k8UFzMu2+gWqF+9+qbX+c8
	 oRk24c7xwgHHEdc7yuEFQRY1jxiwLBr+3srezpcX9SMpl1nDyZdoVTsu+UIG0jwM7T
	 1U53R4CRPfBLRSUeCyuLZHwxPt/tIr2SwU8LIzvTo+0odzA08Rd0i1ZaHmacBtyvxG
	 2CNhCOkdhOUabROjobjSOpIFL8V4Wmx3+gggXkwk8mIJ6T89SGCU21NCHGHDuNvW8c
	 wsogqzsK5L61Iyyl0w0cU9Un8r6Pa7FWo4BQaONxSRrFIy1OF1NgGwGDJa5qnW1RuN
	 l0o7DGNFdOamA==
Message-ID: <sashiko-outbox-165405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 20/51] bpf: varying offset access support
 for PTR_TO_BTF_ID pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-scev-minimal-rebase-v3-20-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
 <20261009-scev-minimal-rebase-v3-20-bcba9bc53ac9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:41:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: truncation of 64-bit var_off to 32-bit bypasses custom btf_st=
ruct_access bounds
- [High] bpf: unbounded variable offset read on trusted PTR_TO_BTF_ID bypas=
ses PROBE_MEM
--

commit ec6d1e8a8c55dc442e46ac3d70d36a00ec8a9ffd
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: varying offset access support for PTR_TO_BTF_ID pointers

This commit relaxes requirements for varying offset accesses to PTR_TO_BTF_=
ID
pointers, verifying they stay within array bounds and align with elements.
It modifies btf_struct_access to validate minimum offsets and array spans,
while skipping upper bounds checks for flexible arrays.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0630675377aaa..f4d119f3d5ef9 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -7899,6 +7961,55 @@ int btf_struct_access(struct bpf_verifier_log *log,
[ ... ]
> +		array_start =3D min_off - arrays[i].off;
> +		/* An array within the flexible tail has no upper bound to exceed */
> +		if (array_start >=3D flex_off && btf_type_is_array(t) &&
> +		    btf_type_array(t)->nelems =3D=3D 0)
> +			return ret;

[Severity: High]
Does this allow unbounded variable offset reads on trusted pointers?

This logic explicitly skips the upper bound check for flexible arrays,
assuming PROBE_MEM will safely catch out-of-bounds page faults at runtime.

However, if the pointer being accessed is trusted (meaning it has the
PTR_TRUSTED flag and lacks PTR_UNTRUSTED), wouldn't bpf_may_fault_on_deref()
evaluate to false?

If bpf_may_fault_on_deref() is false, bpf_convert_ctx_accesses() won't
convert the load into a PROBE_MEM exception-handled load. Passing an
arbitrarily large offset here could result in a native load from unmapped
memory, potentially crashing the kernel.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f5b2500335a7b..192efb7229975 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -6608,6 +6604,18 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>  	}
> =20
>  	if (env->ops->btf_struct_access && !type_is_alloc(reg->type) && atype =
=3D=3D BPF_WRITE) {
> +		if (!tnum_is_const(reg->var_off)) {
> +			char tn_buf[48];
> +
> +			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +			verbose(env,
> +				"%s is ptr_%s invalid variable offset: off=3D%d, var_off=3D%s\n",
> +				reg_arg_name(env, argno), tname, off, tn_buf);
> +			return -EACCES;
> +		}
> +
> +		off +=3D reg->var_off.value;
> +
>  		if (!btf_is_kernel(reg->btf)) {
>  			verifier_bug(env, "reg->btf must be kernel btf");
>  			return -EFAULT;

[Severity: High]
Could this assignment truncate a large 64-bit value into a negative 32-bit
offset?

Earlier in check_ptr_to_btf_access(), the negative check for off was removed
and replaced with min_off. Now that off +=3D reg->var_off.value is executed
down here for BPF_WRITE with custom handlers, a very large 64-bit
var_off.value could wrap into a negative 32-bit integer.

Since there is no negativity check immediately following this addition, the
truncated negative offset gets passed directly into the custom
btf_struct_access handler.

If a handler like bpf_scx_btf_struct_access compares this negative offset
against size_t boundaries, couldn't this bypass the bounds check and
allow out-of-bounds writes to kernel objects?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-scev-minim=
al-rebase-v3-0-bcba9bc53ac9@gmail.com?part=3D20
