Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723AD1F91F6;
	Mon, 13 Jul 2026 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911589; cv=none; b=TMBYHSGYqQ5LUs6MNzH11MK70lRde7Qc6CVJByufkZcPQMMMLjzOKX6CgSLRdVOHuUBIf4ZUleWKz/EJDsd57ZrN51X+/+S/DBtV48CJ8+IrWnlnDOPNrl1O/YVdG5M9M+zp8vBTJClidY0DycqAUd50ojyc6Aik0P3sv9A10rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911589; c=relaxed/simple;
	bh=GhAs1JyKRTTPHtgdZplptvRdM/7X74aAFz8Ov+nFg28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U76HdUXLr8+b7hdq7Qhp1LvOWJmHK7iH30pLGNV13Kbk5/7bwJqx7CVC25DCue5vsmEoYDw2B6OPYZrSDtmdWepGV9o7I42DGY2pYujOvheDJr2WVhq4f6lI6ssh4gLMyDQYxMbs5QU4/QNLIQm2+CeIyhN7y3t2T/2uGOPs9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOOzDlXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOOzDlXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CC41F000E9;
	Mon, 13 Jul 2026 02:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783911588;
	bh=7DBw4eCHRMg53hdQZdFUi5Ks27TXGVCGZRAnsHsYWIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bOOzDlXpJar8GiPGpi+zOIgfQwxkIJqfTNQbPjixb5rXozps0gI32+1BFZ3/XEzGm
	 BnVA5xGV87eymXgGcBOqFAGoHSQcx3vU5niYCqzLDsKkTLN3oJHWXjR5MkkUGT6Ylr
	 /kUlXghuJCTQwYyCDnFqs/Hvj7BI8PkWpQ4W70sla+TkEJk1Z1eXmZRyi3wZIjGVR7
	 XBqF9Zcm6OFDdnmbViFDV2jaqesc64oXM2eANMjSDMi66ya2WocfqNp1/bXw5J/WSe
	 zjQLDEVCf9xVcQilUuMF8ow23IK+Ii6y+GDmgsJ3A9SZ/Poolnucvjnay1KCUmV6Pw
	 x2+I7cNi6PUjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHSET SLOP RFC 3/6] bpf: Support __arena suffix on
 struct_ops stub arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260713024414.3759854-4-tj@kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org>
 <20260713024414.3759854-4-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 02:59:47 +0000
Message-Id: <20260713025947.E9CC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Tail-calling another struct_ops program causes double-subtraction =
of the arena base address, corrupting arena pointers in the context.
--

--- Patch [3]: [PATCHSET SLOP RFC 3/6] bpf: Support __arena suffix on struc=
t_ops stub arguments ---
commit 7fff65a383d9791611afe2d53ac2633d4bac8dda
Author: Tejun Heo <tj@kernel.org>

bpf: Support __arena suffix on struct_ops stub arguments

A struct_ops callback cannot receive an arena pointer directly, so passing
one takes two steps. The pointer arrives as a bare u64 that the callback
casts, and because the two sides address the arena through different bases
it also has to be rebased by hand on the way in. Add the __arena stub
argument suffix and both steps go away.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -680,6 +680,64 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_ver=
ifier_env *env,
[ ... ]
> +static int gen_arena_arg_prologue(struct bpf_verifier_env *env,
> +				  struct bpf_insn *insn_buf)
> +{
[ ... ]
> +	for (i =3D 0; i < aux->ctx_arg_info_size; i++) {
> +		int off;
> +
> +		if (base_type(aux->ctx_arg_info[i].reg_type) !=3D PTR_TO_ARENA)
> +			continue;
> +		off =3D aux->ctx_arg_info[i].offset;
> +		insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, off);
> +		insn_buf[cnt++] =3D blinding ?
> +			BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_AX, 2) :
> +			BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 2);
> +		insn_buf[cnt++] =3D BPF_ALU64_REG(BPF_SUB, BPF_REG_2, base_reg);
> +		insn_buf[cnt++] =3D BPF_ZEXT_REG(BPF_REG_2);
> +		insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, off);
> +	}
> +	insn_buf[cnt++] =3D env->prog->insnsi[0];
> +	return cnt;
> +}

[Severity: High]
Does this in-place modification cause an issue if the program performs a ta=
il
call to another struct_ops program?

Since tail calls pass the exact same context array to the callee, and the
callee will also have this prologue injected, it seems the already-rebased
32-bit offset will be read and the arena base address will be subtracted a
second time. This could severely corrupt the arena pointer offset.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18729,10 +18730,17 @@ static int check_struct_ops_btf_id(struct bpf_v=
erifier_env *env)
[ ... ]
> -	for (i =3D 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
> -		if (st_ops_desc->arg_info[member_idx].info[i].refcounted) {
> +	arg_info =3D &st_ops_desc->arg_info[member_idx];
> +	for (i =3D 0; i < arg_info->cnt; i++) {
> +		const struct bpf_ctx_arg_aux *info =3D &arg_info->info[i];
> +
> +		if (info->refcounted)
>  			has_refcounted_arg =3D true;
> -			break;
> +		if (base_type(info->reg_type) =3D=3D PTR_TO_ARENA && !prog->aux->arena=
) {
> +			verbose(env,
> +				"arena argument of %s requires a program with an associated arena\n",
> +				mname);
> +			return -EINVAL;
>  		}
>  	}

[Severity: High]
Should we also restrict tail calls for programs with __arena arguments here?

Right below this loop, check_struct_ops_btf_id() blocks tail calls if
has_refcounted_arg is true:

    for (i =3D 0; i < env->subprog_cnt; i++) {
        if (has_refcounted_arg && env->subprog_info[i].has_tail_call) {
            verbose(env, "program with __ref argument cannot tail call\n");
            return -EINVAL;
        }
    }

Since gen_arena_arg_prologue() modifies the context in-place, blocking
tail calls for programs with arena arguments would prevent the double
subtraction issue entirely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713024414.3759=
854-1-tj@kernel.org?part=3D3
