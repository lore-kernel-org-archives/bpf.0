Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C756472
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400847; cv=none; b=BXISz0dYRQXHDOfL5PaysdJhWiZi72sSl+9tmtWmw6W/FFRu1jjf/8pRbQ4Ds1s+Tbeh9rTEWFje0jCE/c1mEYzSt+WCXUqX9EdVJYGSNQAUYTw+Dz22vrv5yQeuGVzKkEXd+FCga2RAHbLBRcKETayGp3umhbP76bja9QtYzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400847; c=relaxed/simple;
	bh=fu6mtZBbHIp5zjFepK36A/iYjsiAs1J47Ua2XKPbppo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ib5ufxmijkugG0mjApYr45qcbJoE1eNGoXpnKmisf8LFvIfyW2bdA1IcKmzxh+o4R1kxKiEUc2c4g6yLyzQGJCbB17VoMo6WqXt1Uk/HtjEwxUf6XsfFHWFkjhfrLpsMjZu2uXhbV7LarbujDJ0+HQKGKIpGtsi7E3TcWejk2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPEVsA49; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPEVsA49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63861C19425;
	Fri, 17 Apr 2026 04:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400847;
	bh=fu6mtZBbHIp5zjFepK36A/iYjsiAs1J47Ua2XKPbppo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jPEVsA49bmPiJxX4V4/SD+nxuJqe9cJKIc+ECmffwO2JJoXBwezx7fKxAcrNHrcqC
	 UblmUL0cAGw0qfoULAI2LRlcdXRBUigfPsrwmxoAzV5qzQsij9UEf5MfZ6r+Q9ItBO
	 /OiIe38VGcDRklHEuK3apaq5Pk/iL28/rINHIbJq0UI2AxwjsQu7bIE+2ScIIOalcl
	 +H8sa9Tq9Q3o1pZjI0OjT3AqHYYGK3dYKPn06WrOH/m3ds30qFDGZPWJviinBhkhH8
	 UUv5Zz3KEfV79EAYCslMiNrJxVidF1+I234P/pSD+mBrRIPMifzxv4HQTdUeLYCnS/
	 h8OuEig6aOs8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 11/16] bpf: Support stack arguments for
 kfunc calls
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417034754.2630932-1-yonghong.song@linux.dev>
References: <20260417034754.2630932-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 04:40:46 +0000
Message-Id: <20260417044047.63861C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] Precision tracking (`mark_chain_precision`) is incorrectly byp=
assed or misapplied for kfunc scalar arguments passed via the stack, allowi=
ng malicious BPF programs to bypass verifier safety checks through state pr=
uning.
- [High] `get_kfunc_arg_reg()` fetches lookahead stack arguments without bo=
unds checking, leading to an out-of-bounds memory read or NULL pointer dere=
ference when resolving memory sizes.
- [High] Overwriting `insn->off` in `bpf_fixup_kfunc_call` destroys the BTF=
 file descriptor index, breaking module kfunc calls on architectures that u=
se JIT far calls.
--

commit 15b2d48bd7c1080e972b83211cc9794ac2ba763f
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Support stack arguments for kfunc calls

Extend the stack argument mechanism to kfunc calls, allowing kfuncs
with more than 5 parameters to receive additional arguments via the
r11-based stack arg area.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 739c3127520c3..a3f307909e401 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11653,6 +11659,19 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_=
call_arg_meta *meta)
>  	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_xdp_pull_data];
>  }
> =20
> +static struct bpf_reg_state *get_kfunc_arg_reg(struct bpf_verifier_env *=
env, int argno)
> +{
> +	struct bpf_func_state *caller;
> +	int spi;
> +
> +	if (argno < MAX_BPF_FUNC_REG_ARGS)
> +		return &cur_regs(env)[argno + 1];
> +
> +	caller =3D cur_func(env);
> +	spi =3D out_arg_spi(caller, argno - MAX_BPF_FUNC_REG_ARGS);
> +	return &caller->stack_arg_regs[spi];
> +}

Does get_kfunc_arg_reg() need to verify that spi is within bounds and the
stack slot is initialized?

When verifying pointer arguments that have a trailing size argument
(KF_ARG_PTR_TO_MEM_SIZE), the verifier looks ahead at argno + 1. If a BPF
program maliciously omits the stack size argument, could spi exceed
caller->stack_arg_depth and lead to an out-of-bounds memory read?

[ ... ]

> @@ -12394,9 +12435,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  						reg_arg_name(env, argno));
>  					return -EINVAL;
>  				}
> -				ret =3D mark_chain_precision(env, regno);
> -				if (ret < 0)
> -					return ret;
> +				if (regno > 0) {
> +					ret =3D mark_chain_precision(env, regno);
> +					if (ret < 0)
> +						return ret;
> +				}

Stack arguments use regno =3D -1, so it seems mark_chain_precision() is byp=
assed
for scalar constants and size arguments passed on the stack.

If precision tracking is bypassed, could the verifier's state equivalence l=
ogic
consider states with different scalar values in these stack slots as equiva=
lent
and incorrectly prune them?

[ ... ]

> @@ -20145,6 +20209,16 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
>  	if (!bpf_jit_supports_far_kfunc_call())
>  		insn->imm =3D BPF_CALL_IMM(desc->addr);
> =20
> +	/*
> +	 * After resolving the kfunc address, insn->off is no longer needed
> +	 * for BTF fd index. Repurpose it to store the number of stack args
> +	 * so the JIT can marshal them.
> +	 */
> +	if (desc->func_model.nr_args > MAX_BPF_FUNC_REG_ARGS)
> +		insn->off =3D desc->func_model.nr_args - MAX_BPF_FUNC_REG_ARGS;
> +	else
> +		insn->off =3D 0;

For architectures where bpf_jit_supports_far_kfunc_call() returns true
(such as s390x, loongarch, and powerpc), they resolve the address later
using bpf_get_kfunc_addr(), which requires the BTF file descriptor index
stored in insn->off.

If insn->off is overwritten here, could it destroy the BTF file descriptor
index and break module kfunc calls during JIT compilation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417034658.2625=
353-1-yonghong.song@linux.dev?part=3D11
