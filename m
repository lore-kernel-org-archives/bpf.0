Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CA37CD45
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218081; cv=none; b=gdrA33XfVFnicJPI51R51pQp4OpmVnFKefX8+g3ZQ8txfQq/llCkIzWjWP93sjpTittW5IpoAObTUzNWsbLDBpK/j8HDVNPieoRMNiyZJnfbRT2DSPH3AlqWNMp9wJsr88A57nSMftCtcYUE3BzlaR2xQsK5xUBdMFEgnwZPy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218081; c=relaxed/simple;
	bh=sHYh3r8ZmJNxpdKZCvQOZmLLrXDnc9ItHvvUBy2C2SU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YIYn8Vxc0dx1s9w1FUqgc1VsexGGqNCvg8vxxy2XipbRYiYIDv/PdwPN0S4ZIMINOPlNA4jTu7WFEPKYv9Zb4IntPEiQY5Jo16vmcBKG6yYWkHhAZQrcYMHCECx5MQ3it7H/zq5ozF0POifbLOkP7iL0WQKVw/jlehROEwLBEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biU8kcIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biU8kcIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A171F000E9;
	Sat,  8 Aug 2026 19:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218080;
	bh=aruYvSTWwrLEDKQCv4jitGR8pJUSzhT2ylaCe7aMlp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=biU8kcIwN5A8tx2znjKEpdJhV3M9NdVlStbFHOHnKN0p2cLYPHsTVal7XU0J1vs5E
	 o0GpSpqJXWj7Izr7DkvOj8I2WO/7fVi7LchGLuw+rwdUXIiS3bzaw1Y22lWlaAKKnS
	 0u+PEfpUcbJMjcnfDnaoiSpFIRjsaY/Xu3uDHtLeDJKWsqzyirZuFBdiJZfewU4WmO
	 zDVTu81uufOPM3p4hYbHH5S7V5tGwQPQeENNNaeksVxMa9t0DWagxdsp7kkqObA2JW
	 E69nyNBsBJTEm85tl3TVfbjAEf04lLhDHE9ycPaqLQ3v4HCUHP76iiXTEe8d3j+ZGn
	 uGusVVytBis0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 07/13] bpf: Add verifier support for 16-byte
 returns in R0:R2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808190358.1899615-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
 <20260808190358.1899615-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 19:41:19 +0000
Message-Id: <20260808194120.31A171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Kfuncs returning structs by value can leak uninitialized kernel re=
gisters or stack memory via struct padding.
- [Low] Multi-line comments do not follow the mandatory BPF subsystem style.
--

--- Patch [7]: [PATCH bpf-next v3 07/13] bpf: Add verifier support for 16-b=
yte returns in R0:R2 ---
commit 655df23f6a36d32f4e8e39dbf37f70004e7dee82
Author: Yonghong Song <yonghong.song@linux.dev>
Subject: bpf: Add verifier support for 16-byte returns in R0:R2

LLVM 23 added support for returning a value in two registers for an
__int128, or a struct/union whose size is greater than 8 but not more than
16 bytes. This patch adds handling for returns greater than 8 bytes in
BPF subprogram returns and kfunc returns.

Link: https://github.com/llvm/llvm-project/pull/190894
Link: https://github.com/llvm/llvm-project/pull/206876

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0c070957a52b7..41c47bcc3b0a2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -9849,8 +9870,21 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
>  			return -EFAULT;
>  		}
>  	} else {
> -		/* return to the caller whatever r0 had in the callee */
> -		caller->regs[BPF_REG_0] =3D *r0;
> +		/* return to the caller whatever the callee had in the
> +		 * return register(s)
> +		 */
> +		for (i =3D 0; i < nregs; i++)
> +			caller->regs[ret_regs[i]] =3D callee->regs[ret_regs[i]];
> +
> +		/* R2 carries only the upper half of a register pair return
> +		 * value. A stack pointer must not escape the callee (see the
> +		 * R0 case above), but there is no need to reject the whole
> +		 * program for it: hand the caller an uninitialized R2 instead,
> +		 * so that only a caller actually using the returned pointer
> +		 * fails.
> +		 */

[Severity: Low]
This isn't a bug, but do these multi-line comments follow the modern BPF
subsystem style? The opening /* typically needs to be on its own line.

[ ... ]
> @@ -10747,6 +10781,18 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  	return 0;
>  }
> =20
> +/* Mark the register(s) holding a @size byte kfunc return value as unkno=
wn
> + * scalars. Both halves of a register pair are treated the same way.
> + */
> +static void mark_kfunc_ret_regs(struct bpf_verifier_env *env,

[Severity: Low]
This isn't a bug, but here is another instance where the multi-line comment
might need the opening /* on its own line.

[ ... ]
> @@ -13223,10 +13269,25 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>  	}
> =20
>  	if (btf_type_is_scalar(t)) {
> -		mark_reg_unknown(env, regs, BPF_REG_0);
> +		mark_kfunc_ret_regs(env, regs, t->size);
>  		if (meta.btf =3D=3D btf_vmlinux && (meta.func_id =3D=3D special_kfunc_=
list[KF_bpf_res_spin_lock] ||
>  		    meta.func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsav=
e]))
>  			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
> +	} else if (btf_type_is_struct(t)) {
> +		/*
> +		 * The returned struct comes back as raw register bits modeled
> +		 * as an unknown scalar, so it must contain only scalars:
> +		 * otherwise a pointer field would be laundered into a scalar
> +		 * and escape provenance and reference tracking.
> +		 */
> +		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
> +			verbose(env,
> +				"kernel function %s returns %s %s that is not composed of scalars\n",
> +				func_name, btf_type_str(t),
> +				btf_name_by_offset(desc_btf, t->name_off));
> +			return -EINVAL;
> +		}
> +		mark_kfunc_ret_regs(env, regs, t->size);

[Severity: High]
Could this leak uninitialized kernel registers or stack memory via struct
padding?

When a kfunc returns a struct by value, __btf_type_is_scalar_struct() checks
that the defined members are scalars, but it doesn't appear to check for or
enforce zero padding.

Since mark_kfunc_ret_regs() marks the entire return registers (BPF R0 and R=
2)
as initialized SCALAR_VALUE based on t->size, wouldn't a BPF program be able
to read uninitialized padding bytes left by the native C compiler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808190322.1896=
580-1-yonghong.song@linux.dev?part=3D7
