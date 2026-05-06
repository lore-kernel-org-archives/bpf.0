Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF630EF63
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111955; cv=none; b=qCl/b9kWl5jXynGIirXF2FNm4qXBFaIq7Qr0E+I5jRrqcopeDQKv4qqSEadcEyWztt5TECd8yz3mvq9KiAjlF2MulX/HOzl/kZt8PSPBYU12r4ZSzdfo92wopY3TaFyx9YRyzms5lyN8gFBtU+dO6AGPooiiiMqPhONtnFmeVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111955; c=relaxed/simple;
	bh=L8SMuth0aUxjuyaRSGrv54zhQoPyPDF7evq6ZCgc5Ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GDntwdACvdtfdXCW3ZkKWpLAMgMqshI2mIlHWV6bbEx86pd3va0PuB7B+fE87jGkwyxaNyOFWoIpHrZ7zaYhRGyQXyRUBHlQXS4gVH4ai5UVICZRk+e0B3yi5ssAtWdZw1hxApuUbWNofK5/p3JMSjebV69R/OfpThmvJ4KK5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zpx2D34k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zpx2D34k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687C5C2BCB0;
	Wed,  6 May 2026 23:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778111955;
	bh=L8SMuth0aUxjuyaRSGrv54zhQoPyPDF7evq6ZCgc5Ew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Zpx2D34kaURRHgLVqFp6sEizAv1/5Z/6iU9cBYU6drRRSAMpiD5ZZLl7FJDrXjYQO
	 8vfIYMgMh9T2cKOdDLwDTnCwtZoq9gjrov+6mNdkVitQOxvw2Ta2H1AAC1+waCGcsR
	 p7QLRiW2dJfe8aoUUwh2VPg7N9REWJC12TcHFkCahlTBK6mF+g8iBhKVPmZdJn+n88
	 VXCc0ECWMvSN9BFbdBq8oi22DPGS95zulGrAoCKeIG6MdYWGrB8FV0ssrDyE2FjBuG
	 BdlIIz9p1GoptQwg4/B8zCGQMPII2q3z919GDSS0DtKll2fCTBGxlNTUeHFIeoQHun
	 ED0lW1rqzHuJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 08/12] bpf: Unify release handling for
 helpers and kfuncs
Reply-To: sashiko@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506142709.2298255-9-ameryhung@gmail.com>
References: <20260506142709.2298255-9-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 23:59:14 +0000
Message-Id: <20260506235915.687C5C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardcoding meta->release_regno =3D BPF_REG_1 for KF_RELEASE kfuncs=
 creates a Use-After-Free vulnerability for kfuncs releasing non-first argu=
ments.
- [Medium] Incorrect evaluation of the release_dynptr flag leads to false r=
ejection of valid BPF programs.
--

commit e0e1bbafcfda45d42ce5635352bc4b69c0d713c6
Author: Amery Hung <ameryhung@gmail.com>

bpf: Unify release handling for helpers and kfuncs

Introduce release_reg() to consolidate the release logic shared by both
helpers and kfuncs. The patch determines release_regno from the function
prototype or metadata before argument checking.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 542912c7983f7..e40f09cefa291 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -9870,37 +9928,11 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>  	}
> =20
>  	if (meta.release_regno) {
[ ... ]
> +		struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> +		bool convert_rcu =3D (func_id =3D=3D BPF_FUNC_kptr_xchg) && in_rcu_cs(=
env) &&
> +				   (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU);
> +
> +		err =3D release_reg(env, reg, convert_rcu, !!meta.dynptr.ref_obj_id);
>  		if (err)
>  			return err;
>  	}

Does passing !!meta.dynptr.ref_obj_id as the release_dynptr flag cause valid
programs to be rejected?

If a kfunc or helper accepts both a normal PTR_TO_BTF_ID to be released and
a referenced dynptr as a normal (non-release) argument,
meta.dynptr.ref_obj_id would be set. This would cause release_reg() to
mistakenly invoke unmark_stack_slots_dynptr() on the non-dynptr release
register, returning -EINVAL.

Could the release condition be strictly derived from the argument type of
the specific release register instead?

[ ... ]
> @@ -12083,6 +12107,9 @@ int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_=
env *env,
> =20
>  	meta->kfunc_flags =3D *kfunc.flags;
> =20
> +	if (is_kfunc_release(meta))
> +		meta->release_regno =3D BPF_REG_1;
> +
>  	return 0;
>  }

By unconditionally hardcoding BPF_REG_1 here, could this create a
use-after-free if a kernel module defines a release kfunc that frees an
argument other than the first?

If a BPF program passes a dummy referenced object to R1 and the actual
target object to R2, the verifier might drop the reference for R1 while
retaining R2, even though the kfunc frees R2 at runtime.

Should we still rely on dynamically discovering the release register based
on the argument type to avoid this?

[ ... ]
> @@ -12622,13 +12638,7 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
[ ... ]
>  	if (meta.release_regno) {
> -		struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> -
> -		if (meta.dynptr.ref_obj_id) {
> -			err =3D unmark_stack_slots_dynptr(env, reg);
> -		} else {
> -			err =3D release_reference(env, reg->ref_obj_id);
> -		}
> +		err =3D release_reg(env, &regs[meta.release_regno], false, !!meta.dynp=
tr.ref_obj_id);
>  		if (err)
>  			return err;
>  	}

Similar to the check_helper_call() case above, does this global dynptr
metadata check safely handle mixed arguments when releasing registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506142709.2298=
255-1-ameryhung@gmail.com?part=3D8
