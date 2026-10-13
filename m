Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC1B3B14B7
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880859; cv=none; b=euJHrcO7agdKOUqgKMYt3I4gMUjsZqjVUzgQu1RBs+OkXh18sTmNmM3CorAwcJBmdeu/anm6R2SpQrmHEz1/ZflfWufC7NreAK4qmhvncmY1iNzz9oYwpu+hgY8VFvJvmd+CDZW1jRt1LMjKFBWevjNBP4AjODbqY/yEgI4ReBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880859; c=relaxed/simple;
	bh=VjVG6fhCZ+WPHYhdPwWiKV9IAN8Ykrirnm6ILR2H8L4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=OyEmT7pwNcyK9RasOHo5LYtd6qilYnOay8xVSvi2KB8M1TH8SZhl708HTbMMOJsEE6ndffr5FQH5d/BKHIuQZGvBVM+Yv3NfwGHsYEBrwU3op7psQ9Xe4D9kymsitkIuRJBeTh/zelVokQWzS0LICdCYoNyK0g0E+kPYTRTNOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhghM6aw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhghM6aw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D3D1F000FF;
	Tue, 13 Oct 2026 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791880858;
	bh=EaoZsaP6y+jFnEHjQZIhtv31zFL0FQMmIra5+z6iq0Q=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NhghM6awHVPg65tB9zqmzUJFrEcwGjxR3PW/lixf4bbWuIW2wlM5vLD4g3tCapjuc
	 lJbsqBRhgPFixSAYZN7z1zGt80hzjYjC9aWcW9gBRhyez2DVOG+uNY704xW7AYqw4S
	 HQzSAmiK6si/nHvdfpu21jr8Y2zjNto2P0GyJN7SCSPxM9e+N4+gvrJw2rVf5mxz9H
	 CCUba+CyHO5cNrAUSMSJ4xi9ehtLJgQT72Cr5frylm1cbijSBnPJCBCz+YYt3lYzIc
	 nN+pjeYUVcGWIX/galDpkUum1GBWKZQEbFjg6DKe6LxE/o5hewKQH4Y5FJmnBwV5zp
	 1yj6TbjyDhjLg==
Message-ID: <sashiko-outbox-169266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 05/13] bpf: Turn loads of __arena pointer
 members into arena pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261013082012.1107446-6-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
 <20261013082012.1107446-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 08:40:57 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: PROBE_MEM fault bypass via non-nullable __arena pointers
--

commit fdb573c7b91be34110bf569fb46f6159ad42b9b8
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Turn loads of __arena pointer members into arena pointers

This commit translates the loads of __arena tagged pointer members in
kernel structs into arena pointers during verification. If the member
is also tagged as __nullable, a NULL test is kept before subtracting
the arena base address.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index b2fa7e8bedf3a..3c95b6c8bbbc5 100644
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
[ ... ]
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
> +	if (aux->non_arena_load) {
> +		verbose(env, "an insn loads an arena pointer member on one path and so=
mething else on another\n");
> +		return -EINVAL;
> +	}
> +
> +	base =3D bpf_arena_get_kern_vm_start(env->prog->aux->arena);
> +	buf[cnt++] =3D *insn;
> +	if (aux->arena_member_nullable)
> +		buf[cnt++] =3D BPF_JMP_IMM(BPF_JEQ, insn->dst_reg, 0, 1);
> +	buf[cnt++] =3D BPF_ALU32_IMM(BPF_SUB, insn->dst_reg, (s32)base);

[Severity: High]
Could this allow a bypass of the PROBE_MEM zeroing mechanism when a fault
occurs on a non-nullable arena pointer?

If a PROBE_MEM read of a non-nullable __arena pointer faults, the exception
handler zeroes the destination register and resumes execution at the next
instruction. Because the pointer lacks __nullable, the zero-check branch
is omitted and the BPF_SUB instruction executes unconditionally.

This executes on the zeroed register, changing its value to -(u32)base.
Since base (kern_vm_start) is page-aligned but shifted by GUARD_SZ / 2 (32K=
B),
the truncated 32-bit offset calculates to 4GB - (base % 4GB). This
consistently points to the next 4GB-aligned address in the kernel.

Because base % 4GB is at least 32KB, this mathematically guarantees the
address falls strictly within the 4GB valid, user-mapped bounds of the aren=
a.
Could an attacker map this arena offset, populate it with a malicious
payload, and spoof the BPF program into using attacker-controlled data?

> +	return cnt;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013082012.1107=
446-1-memxor@gmail.com?part=3D5
