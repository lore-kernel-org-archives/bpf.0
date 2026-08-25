Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E42727F3
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692376; cv=none; b=qpgE8r6Hr2piIFExiKA384uun3FGpPirJj/kJYSgnNrBJjfcVGeunq7UHWyDAN2CEXF8GZXNZZja6z+QhlEqhhiBgxD1ctN/Ec96MtVLjCdGrkcHJODUpkbldrt1n4i2+daMpxPxU9G8YL8VhB57rNbSQ/hCMp8n/+qKJDcLoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692376; c=relaxed/simple;
	bh=7dTsTnbJrnjaRdARCqn6xzmQjz2tmI+UkQFw/hHVfuw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SlYA/RzageoFlcgidlR8ft0uduhS2n6j8zo0XuQQBiiYXTgVvkQCPSOCe/Ih4++zyms26tEplFH0W6qILQOs9kdSFOB2mAyZvFN9IA6HyAHOAwL5ikP1NoeLTUkC5ZR5r4E5ftdmaVIHaCqTM2Iv678FGTHSbRgbH0K/G4szUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYn1WQ4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYn1WQ4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DBA1F000E9;
	Tue, 25 Aug 2026 21:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787692374;
	bh=kch0OKybk1bppeRTDkyi2hgB3raKn7PnJNXCtu8QvYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WYn1WQ4fLi8+oqlNi45zW4u75C+qoP5IgmGuH6HQ+U/oK6Tw30rko9MuWPY5TZs3K
	 kaaqEi4qm+kmy+vyVDZD6FqEse8jxXJCTRy3h7OUJmqpN6AsS8tCOPugJKCOYaTuZU
	 tfzmVWkytfm4d7aEIWYWiBNaDmYk4i/9TV0ahbZ1J7sVChGmAXsVz6zC8e5S3500w/
	 WyYW4+kHscPyxt6P8x9TUpb/0tHM3qBFOuXr9LKiPhoM/ZavA52cMq82rtXrSQRbjE
	 8kKcrGMNvQZcANbJACOoQ7l74Np5DAz2iVGgVyiwIc2qYUXBhXK1tHKnNgkORyoDJV
	 B9MoOlLfXtdZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 06/10] bpf: Allow a global function to
 return arena pointers by value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260825205443.1323867-1-yonghong.song@linux.dev>
References: <20260825205412.1320099-1-yonghong.song@linux.dev>
 <20260825205443.1323867-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 21:12:54 +0000
Message-Id: <20260825211254.88DBA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] BPF_PROG_TYPE_EXT (freplace) programs are erroneously rejected whe=
n replacing a global function that returns an arena pointer or a struct con=
taining an arena pointer.
- [High] Callers of global functions returning arena pointers receive a `SC=
ALAR_VALUE` instead of `PTR_TO_ARENA`, causing valid dereferences to be rej=
ected.
--

commit 9797a7277b67bb03067fdf11db423996a277abbd
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Allow a global function to return arena pointers by value

This commit relaxes BTF verification to allow global functions to return
arena pointers or structures containing arena pointers. It updates the
verifier's return type validation to recognize these types when processing
subprograms.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b1f4ef614d4c4..70481fadacc0f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7972,14 +7972,18 @@ static int btf_validate_return_type(struct bpf_ve=
rifier_env *env, struct btf *bt
> =20
>  	if (btf_type_is_struct(t) && t->size <=3D 16) {
>  		/*
> -		 * A global function's caller models the return as an opaque
> -		 * scalar pair, so it may only return scalars by value. A local
> -		 * function is verified inline, so a pointer field stays tracked
> -		 * and needs no such restriction.
> +		 * A global function may return a struct with scalar(s) or arena
> +		 * pointer(s) as its members. A local function is verified inline,
> +		 * so its caller receives the real register state and any member
> +		 * is fine.
>  		 */
>  		bool local_func =3D subprog && !is_global;
> +		u32 member_kinds =3D BTF_MEMBER_SCALAR;
> =20
> -		if (local_func || btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SC=
ALAR))
> +		if (subprog)
> +			member_kinds |=3D BTF_MEMBER_ARENA_PTR;

[Severity: High]
Does this subprog condition inadvertently reject valid BPF_PROG_TYPE_EXT
(freplace) programs?

When replacing a global function that returns an arena pointer, the
extension's main program must have an identical BTF signature to the target.
During verification of the extension's main program (where subprog is 0),
btf_prepare_func_args() is called. Since subprog evaluates to false,
BTF_MEMBER_ARENA_PTR isn't added to member_kinds, causing the verifier to
fall back and return -EOPNOTSUPP.

[Severity: High]
Even though this patch allows global functions to return arena pointers,
won't callers still be unable to dereference them?

In check_func_call() inside kernel/bpf/verifier.c, the return registers of
global functions are unconditionally marked as unknown scalars:

	if (!returns_void) {
		nregs =3D bpf_ret_reg_pair(env, subprog) ? 2 : 1;
		for (i =3D 0; i < nregs; i++)
			mark_reg_unknown(env, caller->regs, ret_regs[i]);
		bpf_diag_mod_end(env);
	}

Since the C type returned by the function (void __arena *) matches the type
in the caller, the compiler doesn't emit an addr_space_cast instruction.
Without this cast, the scalar is never promoted back to a PTR_TO_ARENA,
causing check_mem_access() to reject subsequent dereferences with an "inval=
id
mem access 'scalar'" error.

> +
> +		if (local_func || btf_struct_is_composed_of(env, btf, t, member_kinds))
>  			return 0;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825205412.1320=
099-1-yonghong.song@linux.dev?part=3D6
