Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB83B6344
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936400; cv=none; b=Yjfz/ubrXgedG+gHqTfTWW3eX5mk2BnshomgNHv8AUSOXPyyPrwdoNYMzdoBdgUOSwM4239b6AECwD5h8LER2srY/nE3A7V26JLgM7chnaO/OmRG+T3I51xOHnbc98OchiUfGQHHjHJQXaTC3fQRzTCj6pj5ybxg5GfWkTlSGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936400; c=relaxed/simple;
	bh=0PR7r2ZSRXnLH1J/DJf131MBT4kVTjxFj6KM7tEukKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SvjiDCb3ZtCoupfha4O2a1Ca0V4Q8f4wKDpI3BIJOoLngO9d9TRLlQ/09kSOWsWu4St1Evbwsm9+twiv4uH7Wmre7t+isE4AN6OvvAa/UK9j2RYNWWjBZ4OF3v49PugbFrkKH1g/rJYfvAvNdBNSAEZaWLLvE8d+DNUvCTclY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0EEKyms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0EEKyms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA26D1F00A3A;
	Wed,  9 Sep 2026 06:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936398;
	bh=BMJiYrGCnznqM73+SehzZbOse02ewF/ATkvsYOuUtn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O0EEKymsAvgGYOo5MiDLL/sYigOn3PIiCkNgMCPrSQe+mQ0gfjyeGTmnkf1ogGreB
	 4kzlnuOxD2ywOMpaBgZZixWUSunmRXtSl0TYpXL1V2ZGnIlivj064MzoD5CaYKbSJs
	 3AQiq0BIYYi4whJuDnxi3apnoydY0cvhFniUy5gFZWc7th3MjDuQJ6LSFazNI+Tl7b
	 HemgEEuaIX0MkvK+LTOqSsaGuzV2/wRa77EfrSLQZlGNnkFsevZ27IfOclsWdWHOfH
	 CgyhetWb+0SVh1VcLGp9YstUh/3YaXmuujdHQeS86AFI+8RLPD3YEopHvoyMIhN1TB
	 bQ+Ope6yOxGSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 06/12] bpf: Recognize by-value struct and
 __int128 kfunc arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909062554.4007131-1-yonghong.song@linux.dev>
References: <20260909062522.4001896-1-yonghong.song@linux.dev>
 <20260909062554.4007131-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:46:38 +0000
Message-Id: <20260909064638.AA26D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_kfunc_stack_access_bytes incorrectly maps stack slots to BPF_R=
EG_6 through BPF_REG_9 (or higher), causing an out-of-bounds read and bypas=
sing uninitialized memory checks.
--

commit 7f4b25d0dad6ba6fed374b3111fcc89d67434d87
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Recognize by-value struct and __int128 kfunc arguments

This commit modifies the BPF verifier to support kfuncs taking structs or
int128 by value. It updates argument tracking to walk slots rather than just
registers, rejecting multi-slot arguments until JIT support is fully added.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cf526f28f3e5b..94c359351bb69 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13765,23 +13850,32 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_ver=
ifier_env *env, struct bpf_insn *
>  	btf =3D meta.btf;
>  	args =3D btf_params(meta.func_proto);
>  	nargs =3D btf_type_vlen(meta.func_proto);
> -	if (arg >=3D nargs)
> +
> +	/*
> +	 * @arg is an argument slot and a 16-byte parameter takes two of them,
> +	 * so walk the parameters to find the one that starts at this slot. A
> +	 * slot holding the upper eightbyte of such a parameter belongs to no
> +	 * pointer, and neither does a slot past the last parameter.
> +	 */
> +	for (i =3D 0, slot =3D 0; i < nargs && slot < arg; i++)
> +		slot +=3D kfunc_arg_slots(btf_type_skip_modifiers(btf, args[i].type, N=
ULL));
> +	if (i >=3D nargs || slot !=3D arg)
>  		return 0;
> =20
> -	t =3D btf_type_skip_modifiers(btf, args[arg].type, NULL);
> +	t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
>  	if (!btf_type_is_ptr(t))
>  		return 0;
> =20
>  	/* dynptr: fixed 16-byte on-stack representation */
> -	if (is_kfunc_arg_dynptr(btf, &args[arg])) {
> +	if (is_kfunc_arg_dynptr(btf, &args[i])) {
>  		size =3D BPF_DYNPTR_SIZE;
>  		goto out;
>  	}
> =20
>  	/* ptr + __sz/__szk pair: size is in the next register */
> -	if (arg + 1 < nargs &&
> -	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
> -	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
> +	if (i + 1 < nargs &&
> +	    (btf_param_match_suffix(btf, &args[i + 1], "__sz") ||
> +	     btf_param_match_suffix(btf, &args[i + 1], "__szk"))) {
>  		int size_reg =3D BPF_REG_1 + arg + 1;
> =20
>  		if (aux->const_reg_mask & BIT(size_reg)) {
>  			size =3D (s64)aux->const_reg_vals[size_reg];

[Severity: High]
This is a pre-existing issue, but does this code lead to an out-of-bounds
read or bypass uninitialized memory checks when the pointer argument is
passed on the stack?

The size_reg calculation inherently assumes the size argument is always pas=
sed
in a register. If the pointer argument slot is 4 or higher (which might be
more common now that large by-value structs consume multiple slots), the si=
ze
argument lands on the stack.

In that scenario, size_reg maps to BPF_REG_6 or higher, which are
callee-saved registers. A BPF program could place a fake constant in one of
these registers to trick the verifier into thinking 0 bytes are read, while
the runtime stack argument is non-zero. This could bypass stack
initialization checks and potentially leak uninitialized kernel memory.

Furthermore, if the pointer argument slot is 8 or higher, size_reg becomes
greater than or equal to 10. Checking BIT(size_reg) and reading from
aux->const_reg_vals[size_reg] would result in an out-of-bounds array read,
since const_reg_vals is sized for 10 registers. Should this logic be updated
to correctly query the BPF stack when the size argument is passed there?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909062522.4001=
896-1-yonghong.song@linux.dev?part=3D6
