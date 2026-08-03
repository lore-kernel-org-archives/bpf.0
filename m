Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363D38910D
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763196; cv=none; b=iLlOdYyQTaSxWssSNH1g2SKL8zGLuPPUIrHGcLt0xoEbIHj8oDWP7miG6CWqgIZE4Qjnc3+NBONYINzl3PTYPOvoTPhBsyNGMpY+PRsXmeW/RAKvQQYaiNlVNlBaSMRLS+sy5U2JiyyWZ1sG+Ow+MqZMOKh798XhbC7yNcNcI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763196; c=relaxed/simple;
	bh=Bm/LnULlofAwwFp2t2QdIQpOI6W+9D8kqw/LMmkAFVM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QAdoy6padA4Jk9tWiuC1wxybY/AhQvJYX1lfRDOI9cDZX+cRIqTDF8Icxg8kuqrIiWyiC5xMWiU6igojFNRexLWU+2LaQ9o/QWSMOZNbl9e1nz7SZUDSiWjP6tkAyJRGfAC+afWhbk0iQoKpqxbD5ey1rrIEnGvPch10l8MaJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp5sThs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp5sThs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ECE1F00A3D;
	Mon,  3 Aug 2026 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785763187;
	bh=166GvoZbT74ERtHwAgiH/vGMkZIJSXj34ndKN0lk/uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hp5sThs0HPdicuyhqSIkC40Ycizg48CYELhK2y9qXHx56oVN4sa1A6IDLtSSX9xtt
	 7lIX+8yB2lhgsry/ZgO6/6rm7TocG6s0FU+lhYll90W8UN7FYv/Z3AlEJRGfst6gOr
	 Y1GOyTZAkTw//v9QVgEybB3V6X/WpDZ4cAy5ZVc5WYijDH2W9Vw9f+tT25gu1E+YPO
	 kt/VCsap7DZovinkyzxvrquRD4WSDDeuWitqbeng+h7f6xL4WU138IT3uK2rRYSWGO
	 vhtx8TSZRHkPGYK01gV+NaM8BDEEpFjV7ntIeYiezFxbmNPPMf0s4dArcTEe9TZW9F
	 Zg+82mUfJeb5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Support __arena and
 __arena_nullable kfunc argument suffixes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803125115.2264733-2-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
 <20260803125115.2264733-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:19:46 +0000
Message-Id: <20260803131946.67ECE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Valid allocated arena objects at page offset 0 are incorrectly tra=
nslated to NULL when passed to __arena_nullable kfunc arguments.
--

--- Patch [1]: [PATCH bpf-next v3 1/9] bpf: Support __arena and __arena_nul=
lable kfunc argument suffixes ---
commit d1b161404c5304b1bf05e11ad5b7dc889d1dcee6
Author: Tejun Heo <tj@kernel.org>

bpf: Support __arena and __arena_nullable kfunc argument suffixes

This commit adds support for __arena and __arena_nullable kfunc argument
suffixes, allowing kfuncs to receive directly dereferenceable kernel addres=
ses
for arena pointers. It updates the verifier to distill these into argument
flags for the JIT to retrieve.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b274004fccfd9..4c50237f49f13 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -12154,6 +12167,31 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
> =20
>  		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> =20
> +		if (base_type(kf_arg_type) =3D=3D KF_ARG_PTR_TO_ARENA) {

[Severity: High]
Can a valid allocated arena object at page offset 0 be incorrectly translat=
ed
to NULL when passed to an __arena_nullable kfunc argument?

Looking at arena_map_alloc() in kernel/bpf/arena.c, the range tree of free
pages includes page offset 0:

    err =3D range_tree_set(&arena->rt, 0, attr->max_entries);

If a user process mmaps the arena or sets map_extra at an address where the
lower 32 bits are zero (e.g., 0x7f0000000000), a BPF program could allocate
an object that gets offset 0. When passed to an __arena_nullable kfunc
argument, the JIT would see the lower 32 bits as exactly zero.

Since the commit message states that __arena_nullable skips the rebase when
the truncated value (arena offset 0) is zero to preserve NULL, would this
cause the kfunc to incorrectly assume a valid optional argument is absent
and lead to dropped data or logic errors?

> +			if (!bpf_jit_supports_arena_args()) {
> +				verbose(env, "JIT does not support kfunc %s() with arena pointer arg=
uments\n",
> +					func_name);
> +				return -ENOTSUPP;
> +			}
> +			if (!env->prog->aux->arena) {
> +				verbose(env,
> +					"%s arena pointer requires a program with an associated arena\n",
> +					reg_arg_name(env, argno));
> +				return -EINVAL;
> +			}
> +			if (regno < 0) {
> +				verbose(env, "%s arena pointer cannot be a stack argument\n",
> +					reg_arg_name(env, argno));
> +				return -EINVAL;
> +			}
> +			if (reg->type !=3D PTR_TO_ARENA && reg->type !=3D SCALAR_VALUE) {
> +				verbose(env, "%s is not a pointer to arena or scalar\n",
> +					reg_arg_name(env, argno));
> +				return -EINVAL;
> +			}
> +			continue;
> +		}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803125115.2264=
733-1-memxor@gmail.com?part=3D1
