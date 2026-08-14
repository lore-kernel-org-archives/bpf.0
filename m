Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF425B098
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674395; cv=none; b=HeyOnBlaYDRk/psZenxIOhD6XtOgu6W5yDzRkQUEeIrhvKiD/8TjtlJyn4WDkhUYunq7HneqZTxjxrZGsSySCuBaZgre5YIfs0Xz1baPDqivjmCAIcCkBxN/DOQk25D/fC8VmqZxXP4kti1aXXLL41k7j6Grrd7VkbgDdzE3OuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674395; c=relaxed/simple;
	bh=6Gpssy9XgLyVK9orracXEB0/UYN59uTItiJlvQYZcxA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FQHBMp7Kr0Pmma7s+KIfW7glGEfyJDs9j+SgZaTsjmRkikpiJ2ix5orKLOAbwrjwhl8kNU0stIJtt/x9W+ltoraM0ZvDFIikx8TuTnAW3AFidg5dV+tEvbh+Gd242gkFLV7zy6GflYv/NhIEAHm0mgG0sIZyea66G3g6zNqOeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivuPjQfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivuPjQfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B578E1F00A3A;
	Fri, 14 Aug 2026 02:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786674393;
	bh=0Be2jvO6ttPyQPJ/cgYAfaces3khSRRo4qy8pnIe31Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ivuPjQfn9najI4CiYiBYQAVP3LVd/m1mcFetW/82HCZd/YsclV/vcImlwZxPQdtuB
	 SHbbDFVTCcGWAksHHHjImf4KDFJcBhDOOkJKOnFKbxppG/bpsvB2GSb3qsaK26LNm9
	 2Eow3TZl1kW70w4XILK8sPS9nHM3sPpYhTSe2LaKxFSuev0VmihKhGQq7ULQbM5EpB
	 a+9+pqtsQN+EydH2JPl64X+G6wFAiC+xsoz8tzKq0c6kauk5IFUlT72sm9E9Rojs0d
	 lERySYn6v5FWa18ImqG9AsaMUNYE53OtqjVwx5mzOtRKT+z0pLxrUPvdkG0OTQa17B
	 1S8wg5lKF1Thg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 06/11] bpf: Add verifier support for 16-byte
 returns in R0:R2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813200240.1995795-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200240.1995795-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:26:28 +0000
Message-Id: <20260814022633.B578E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added support for kfuncs and global subprograms return=
ing structs up to 16 bytes by value is unreachable dead code because existi=
ng BTF validation logic unconditionally rejects struct return types.
--

--- Patch [6]: [PATCH bpf-next v5 06/11] bpf: Add verifier support for 16-b=
yte returns in R0:R2 ---
commit 9e421b8a810e50b00fab2bcdb9c1dbd32e705d84
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Add verifier support for 16-byte returns in R0:R2

This commit adds verifier support for returning values in both R0 and R2 for
types greater than 8 bytes and up to 16 bytes. It models the register pair
for global and static subprograms as well as kfunc calls.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 161d77791bc62..0c68ab3bd6cec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13265,10 +13295,25 @@ static int check_kfunc_call(struct bpf_verifier=
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

[Severity: Medium]
Is this new logic for kfuncs returning structs actually reachable?

Looking at btf_distill_func_proto() in kernel/bpf/btf.c, it unconditionally
rejects struct return types, meaning programs would fail to load early on:

	if (ret < 0 || btf_type_is_struct(t)) {
		bpf_log(log,
			"The function %s return type %s is unsupported.\n",
			tname, btf_type_str(t));
		return -EINVAL;
	}

Similarly, btf_validate_return_type() blocks global subprograms from return=
ing
structs:

	/* We always accept void or scalars. */
	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
		return 0;

	return -EOPNOTSUPP;

Does this mean the new struct return handling logic is dead code, and only
static subprograms or __int128 returns can actually use the new convention?

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
>  	} else if (btf_type_is_ptr(t)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813200210.1991=
507-1-yonghong.song@linux.dev?part=3D6
