Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E82772D
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525495; cv=none; b=fBt0AL7gkKuidFKVlgWr7Sg3WvkTmvcuNaS5v66zpHBI5ub1MKBR5jElPF0oo/deg8rrBbHktUtDrUFD2yTBhfVHjiVarjt4/Tv+HKtxSYW9RmHwrIeHgmZ60Mp66e2OH2xJ3piVhqJdCGbaOFxJ190nWLsUcSKZ3eI2UDplyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525495; c=relaxed/simple;
	bh=w8Uh6m6A5j0wcy1QZdu1jCrr0OfMB+uc5U5fJXY9vvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vE37T6Y/G4xj4nAcXEu++ZbfKs1dYuORDduBA8VFhQooO93IaJ9pF+B5b54JvD60zSQzOX85duYw0mfk8FX/xkJm4qSMbHJPD0Hj9NrotdoKk1CqNxWa3KOtCxesswNaKrBsjOQpfIndfxEB5wUWLaSgOoi+IzJ6gXpuRxHNS0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaK2wj4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaK2wj4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03DA1F00AC4;
	Fri, 31 Jul 2026 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785525494;
	bh=O1fPriQJz0pTYvduhUdUeYylWvSJcxSYJMnjqHrkaAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IaK2wj4jExKymRTYp9+Q4tAp55Jo8H9h4JdoGtPsZg3QeEY9s1jrqjWTy6Sz2Ow3N
	 4f3jSrljuB0E0rg1nwXkPIsGna6ya+E/7h1tHSVf1+JAyzsvpMIelnmW8uhaJrhsmg
	 y46kF5ip3AHan7toYlOE9Jcw0EYdxRV26XzAQ8260u89/4ACGT5dW+y1miRWIvnWWL
	 hnY5DOhZTLFssgNpLpeyVFCpI9ruLG3UXJDTXoigi5Xd5nxU/PKhmAmoihILSONFWo
	 tq+A5BUenXXPDWb4bmDLvgQuILWaZt5fi1vl52US2PDgYDNMbNvC1ktmD2BqB7j4aM
	 /Aw16sbg4xuPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/5] bpf: simplify the bpf_is_reg64() signature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731-static-zext-v1-4-98a4dc73e94b@gmail.com>
References: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
 <20260731-static-zext-v1-4-98a4dc73e94b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:18:13 +0000
Message-Id: <20260731191813.E03DA1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] A comment explicitly referring to removed arguments of bpf_is_reg64=
() was left intact.
- [Low] The handling of BPF_JMP, BPF_JMP32, and BPF_ST classes inside bpf_i=
s_reg64() is now completely dead code and contains misleading comments.
--

--- Patch [4]: [PATCH bpf-next 4/5] bpf: simplify the bpf_is_reg64() signat=
ure ---
commit ed53634b5ab05a53b4f5cd2fc3aac98c66a8ccd4
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: simplify the bpf_is_reg64() signature

After the previous commit this function is only used in a context
where destination register's property is queried.
Hence, simplify the function by removing the 'regno' and 't'
parameters.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 6125598d16a84..73ab95573f609 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -623,7 +623,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_veri=
fier_env *env,
>  			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
>  			 *       here.
>  			 */
> -			if (bpf_is_reg64(&insn, load_reg, NULL, DST_OP)) {
> +			if (bpf_is_reg64(&insn)) {

[Severity: Low]
Since the parameters have been removed from bpf_is_reg64(), should we also
remove or update this comment referring to the "fourth one"?

>  				if (class =3D=3D BPF_LD &&
>  				    BPF_MODE(code) =3D=3D BPF_IMM)
>  					i++;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0709dded013ea..d5b6fef1ad897 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3028,11 +3028,10 @@ static void mark_stack_slots_scratched(struct bpf=
_verifier_env *env,
>  }
> =20
>  /* This function is supposed to be used by the following 32-bit optimiza=
tion
> - * code only. It returns TRUE if the source or destination register oper=
ates
> - * on 64-bit, otherwise return FALSE.
> + * code only. It returns TRUE if the destination register operates on 64=
-bit,
> + * otherwise return FALSE.
>   */
> -bool bpf_is_reg64(struct bpf_insn *insn,
> -	      u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
> +bool bpf_is_reg64(struct bpf_insn *insn)

[Severity: Low]
Are the branches handling BPF_JMP, BPF_JMP32, and BPF_ST inside this functi=
on
now dead code?

The callers in bpf_insn_def32() and bpf_opt_subreg_zext_lo32_rnd_hi32() onl=
y=20
evaluate bpf_is_reg64() if insn_def_regno() returns a value >=3D 0.=20

Since insn_def_regno() returns -1 for BPF_JMP, BPF_JMP32, and BPF_ST,=20
execution should never reach those branches here anymore. This leaves behind
unreachable code and makes the corresponding comments (like "BPF_EXIT for
'main' will reach here") inaccurate.

>  {
>  	u8 code, class, op;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-static-zex=
t-v1-0-98a4dc73e94b@gmail.com?part=3D4
