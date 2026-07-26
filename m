Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5D175A80
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785030476; cv=none; b=A6vEAd43r6PBw5nYQlVJO+qtDfYMBZP0jYw3IgJY/VCqfSxkeldQeHPFkphbAgW7YD5gvKxSYO2oFd7arqXhpDZrkxdEMznmE/IcNtHgB4pxdv3bmOmncDjf/l2gStJprFsslZyyX1G34cM1esyy4DzlNwkdMcsMAF966sBWP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785030476; c=relaxed/simple;
	bh=vg8Fyj2skHFlttJJVuJy99Ckw4hdrGkMNXJbFm4SaCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R0PT6LXJC2MsMdBqCBmtl47l8GV+a/i4FE8FzXRxClEaBMDWUizAE9DV6f6V7TB7RIgH4UwmK+dQ8jFR2BOHk5/ZGIZsLtZmK7FFVFR1IXnIpRI2lCQ+j+lUWVTCAdpuZ2PndEKihpUt/d+NwtxApZODQCD7eUJJuO8O7ITlAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djKkJljE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djKkJljE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA7D1F000E9;
	Sun, 26 Jul 2026 01:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785030475;
	bh=c13j6f58p8a8ADY9847qufRclnPvtruin6AN2yC5jSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=djKkJljEVErUZKPmAb8WbrzzjV0zDmxggQOdhXAJGPB9+xX9DESVpKoFIutl462Cd
	 96I36u8EWfJVidBnAp3HeNqymCjs7NjUR/WVbr24ih19MZcmiDcWAPtrbCXKMo1nPW
	 X3wLjnO6k2GiG/8SkQNfvMACs+6b6+N3cmx65qY23Abh74j1NABH8OCxnMSppPaSLX
	 3sZkWT/VTOFB4YWuZAm/GsvmxrEQba+iNtFbz8hWfpSA/h9VO5ItCs+hBH8htd5O6Q
	 HiaRWc4D4nuDnWENQ6WWpQSdQVq/YeNttlxQoYJKdGntlpgRHG25uGHP1umb0yWPpz
	 FaFXtBZ8s+5Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/9] bpf: Support __arena and
 __arena_nullable kfunc argument suffixes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726013105.3689867-2-memxor@gmail.com>
References: <20260726013105.3689867-1-memxor@gmail.com>
 <20260726013105.3689867-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 01:47:54 +0000
Message-Id: <20260726014755.2DA7D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `__arena_nullable` kfunc argument design uses a 32-bit truncat=
ed value of 0 as a sentinel for NULL, which collides with valid memory allo=
cations from `bpf_arena_alloc_pages()`.
--

--- Patch [1]: [PATCH bpf-next v2 1/9] bpf: Support __arena and __arena_nul=
lable kfunc argument suffixes ---
commit fb759ca6f84030ccde9ee83f1e83634342bdae0d
Author: Tejun Heo <tj@kernel.org>

bpf: Support __arena and __arena_nullable kfunc argument suffixes

This patch adds support for passing BPF arena pointers to kfuncs by introdu=
cing
__arena and __arena_nullable argument suffixes. The verifier processes these
suffixes and allows JITs to handle the translation (rebasing) at the call s=
ite.
__arena rebases unconditionally, while __arena_nullable preserves NULL by s=
kipping
the rebase when the arena offset is zero.

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index c801a330aece0..9809680bee43e 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
[ ... ]
> @@ -250,6 +250,33 @@ Or::
>                  ...
>          }
> =20
> +2.3.7 __arena and __arena_nullable Annotations
> +----------------------------------------------
> +
> +Both annotations indicate that the pointer argument points into the
> +calling program's arena. The JIT rebases the value at the call site so
> +the kfunc receives a directly dereferenceable kernel address, subject to
> +the access rules described in :ref:`BPF_kfunc_arena_access` (at most
> +``GUARD_SZ / 2``, 32 KiB, past the pointer in a single unchecked access).
> +
> +With ``__arena`` the rebase is unconditional and the argument is never
> +NULL: a value whose lower 32 bits are zero arrives as the arena base
> +address (arena offset 0). The kfunc must not check the argument for NULL.
> +With ``__arena_nullable`` such a value arrives as NULL instead and the
> +kfunc must check before dereferencing.

[Severity: High]
Does this __arena_nullable design cause a collision with valid allocations?

If an arena is mapped at a 4GB-aligned boundary, the user_vm_start address =
will
have its lower 32 bits as 0. When bpf_arena_alloc_pages() returns the first
free page at offset 0, the resulting user pointer also has its lower 32 bits
equal to 0.

If a BPF program passes this valid pointer to an __arena_nullable kfunc, wo=
n't
the JIT see the 0 value in the lower 32 bits and incorrectly pass NULL to t=
he
kfunc instead of the valid arena base address?

> +
> +An example is given below::
[ ... ]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 641c3c62c1ecf..f3e6190f639e4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -12056,6 +12066,35 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
> =20
>  		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> =20
> +		if (is_kfunc_arg_arena(btf, &args[i]) || is_kfunc_arg_arena_nullable(b=
tf, &args[i])) {

[Severity: High]
Should check_kfunc_args() or the arena allocator ensure that offset 0 is
reserved?

If offset 0 is not reserved, the verifier will allow programs to pass a val=
id
offset 0 allocation to __arena_nullable arguments. The JIT will then silent=
ly
translate this to NULL, causing unexpected behavior in the kfunc since it w=
ill
assume the optional argument was not provided.

> +			if (verifier_bug_if(!btf_type_is_ptr(t), env,
> +					    "kfunc %s arg#%d has __arena tag on non-pointer",
> +					    func_name, i))
> +				return -EFAULT;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726013105.3689=
867-1-memxor@gmail.com?part=3D1
