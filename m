Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA79468C23
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813617; cv=none; b=IL2X8IUKqH9WM3mY53j+0ScjiBfk3Vlx2tVFaS5fS6Q9FmcDaj0ywAwJI1Gm1j59KWT7dwWV5vjOHHHb1fMhNR/LljWOR7O3AUWJf5JzFgrqMddZRkXKiJOllBa0NX1eV5Bk2CWEcajQjUPQsAodKeUV1IPjg9F4U4spbcqpMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813617; c=relaxed/simple;
	bh=sh+xsokUyBzH/TX2AbOgAxfShFnn3lF58U0EW21Prp8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BLaEkneczWvaU05Wg48bPXpRzY78eGRRwPlYk7NIv1yv7ByjAHolmeWKqndZefmKYVQnJtAGKpc9yDfUuzhFr3wHVH6PJF1YDvZU5rxO/05bszJ9aUAA8sCmnLnvifon9tDKiUphOUuyGft5AxNx2r6+vHepdDj8bGGzbkt14Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpXzfYR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpXzfYR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F351F0089B;
	Mon, 12 Oct 2026 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791813615;
	bh=wULXwR8cgvbDRmpgNP3BD1rmA4GNG0Aexm+xfEPZ3mU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PpXzfYR5MYmiNyw89W921d/pvYMReFwnlW0wgSOpbEeoaIvIHtz8E8tfbpcPLzHXV
	 vdh/ah2PQEnekE4TR2URaX7GhoKSeEQ7jR4hcKlQBxv4vh2nOjAJtobZH/7tox/1Gj
	 7hY+FTFvZNsD/tNjwd1svcBzXvvfKif+KSENFVyYSP3QF0jHTdVNXyD5+bDk12166g
	 sFNipVgT+QSAp4EPxCKxz8vZwlrEZLdBYdHAkvjl4sWzVA7i8zp347edTip4DfCkZd
	 8Hch84pwGws/FOvw+VPrZKTQz0BWqgSyM1rUj10/uUrPSvg3hheP7Pwd+QxEgtIloM
	 9bO3dVtTE4smA==
Message-ID: <sashiko-outbox-168226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Turn loads of __arena pointer
 members into arena pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261012133711.4030594-4-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
 <20261012133711.4030594-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:00:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: arena_member fixup corrupts PTR_TO_MEM scalar loads
--

commit 5458ef081d9f29cc60192d4b6fde6d8fd3989b75
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Turn loads of __arena pointer members into arena pointers

This commit translates loads of __arena pointer members in kernel structs
into arena pointers in the verifier. It appends a fixup to subtract the
kernel's virtual memory start address from the loaded value, and adds logic
to ensure paths disagreeing on member types are rejected.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index b2fa7e8bedf3a..bbb653df6b6f0 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -870,6 +870,36 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_ver=
ifier_env *env,
>   *     struct __sk_buff    -> struct sk_buff
>   *     struct bpf_sock_ops -> struct sock
>   */
> +/*
> + * A load through an __arena pointer member of a kernel struct reads the=
 kernel
> + * address of arena memory. Append the conversion to the arena pointer f=
orm,
> + * (u32)(kaddr - kern_vm_start), that the struct_ops trampoline applies =
to
> + * __arena arguments. A __nullable member keeps NULL as NULL, tested on =
the
> + * full kernel address. Returns the number of insns in @buf, 0 when the =
insn
> + * loads no such member, or an error when it does so on some paths only.
> + */
> +static int arena_member_fixup(struct bpf_verifier_env *env, int idx, str=
uct bpf_insn *insn,
> +			      struct bpf_insn *buf)
> +{
> +	struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[idx];
> +	int cnt =3D 0;
> +	u32 base;
> +
> +	if (!aux->arena_member)
> +		return 0;
> +	if (aux->non_arena_member) {
> +		verbose(env, "an insn loads an arena pointer member on one path and a =
different member on another\n");
> +		return -EINVAL;
> +	}

[Severity: High]
Because non_arena_member might not be set by the PTR_TO_MEM path (as noted=
=20
below), could this check fail to reject the mismatch?

If it fails to reject, arena_member_fixup() blindly appends a
SUB kern_vm_start instruction to the shared load. At runtime, if the
PTR_TO_MEM path executes, its scalar load would be corrupted by the
subtraction, potentially leading to out-of-bounds access or data corruption
if the result is used as an index or offset.

> +
> +	base =3D bpf_arena_get_kern_vm_start(env->prog->aux->arena);
> +	buf[cnt++] =3D *insn;
> +	if (aux->arena_member_nullable)
> +		buf[cnt++] =3D BPF_JMP_IMM(BPF_JEQ, insn->dst_reg, 0, 1);
> +	buf[cnt++] =3D BPF_ALU32_IMM(BPF_SUB, insn->dst_reg, (s32)base);
> +	return cnt;
> +}
[ ... ]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 70fd44a6e1c56..a24a2bab802b3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -6661,6 +6697,11 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>  	if (ret < 0)
>  		return ret;
> =20
> +	if (ret =3D=3D PTR_TO_ARENA)
> +		return check_arena_member_load(env, regs, value_regno, flag, tname, fi=
eld_name);
> +	if (atype =3D=3D BPF_READ && value_regno >=3D 0)
> +		env->insn_aux_data[env->insn_idx].non_arena_member =3D true;

[Severity: High]
Does this code miss setting the conflict flag for non-BTF pointers?=20

The verifier's save_aux_ptr_type() permits sharing an instruction across=20
branches where one path uses PTR_TO_BTF_ID and the other uses PTR_TO_MEM
(by merging them via allow_trust_mismatch).=20

If the PTR_TO_BTF_ID path reads an __arena member, check_ptr_to_btf_access(=
)=20
sets aux->arena_member =3D true. However, when the PTR_TO_MEM path is
evaluated, check_mem_access() does not set aux->non_arena_member =3D true f=
or=20
memory pointers.

> +
>  	if (ret !=3D PTR_TO_BTF_ID) {
>  		/* just mark; */
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012133711.4030=
594-1-memxor@gmail.com?part=3D3
