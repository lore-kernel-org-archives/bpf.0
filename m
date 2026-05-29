Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C7243964
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021352; cv=none; b=AbORfaYOzsbMrEgzUstPFwuRLGkObL5hC8shd0A+fivZ2tB3Yj9+pZORhgmpqpQofVBG713TtE+J0gAIR1+2zruOcLY5yPOzEsF7xMbW6lrUO6tTu7N7P4Rvet/YPvxVd7+AMt32wKYtTeS8aplXa8j2zqMbslk0y7StcgA93vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021352; c=relaxed/simple;
	bh=tgv/hNlSyq6NFxlDs+dd9rqbX8KQ+1SOIr++qESJs7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=egcTH/g/dqBOpYMOnVHiiPMYZxt8lo9MyCrVTVO4JcLrSFJIMQqJfdDXrXxoSbEn2xiOupr6cw8kLeKqC44ewG1WrTLb2FNBWLxXSLJJkajdqqB+tC/Ub7AIZbusJIhsve9X5sA0cqHXvgh3mgqK3pGN90DwGwDP016kB5mAu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh/QS6vn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh/QS6vn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E161F000E9;
	Fri, 29 May 2026 02:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780021350;
	bh=w/pAs/AZ+zheQ+WZFwxJyItgSxUL/mOvysQ6A7n6uLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dh/QS6vnKSNC7dJPlxCyFEUIRCi520Ff4tRbUGZTk29jmq6wYzpfCKH1LL1ZG1QWH
	 Jvag/zCrg7NDrPICkUNnQKk2/+g2PJ/dT+zemg9rkEEKbImGr6rBHaIZ73fj68A+G2
	 2kRwx1qyBQBB3Kh+jOaXOKaQq2DCCkp0f+clXSPbOvFITX3wbGPpr0ZXe8TErtAbwD
	 izjtY09/FC8e9xAEV6A8wxm64IJfHjx1GoPzlj55rvA8JFewJ7V8Z2nxRv6tPXRyhQ
	 P9jndU4VxhM72BmVDRNTk6AkbWEFZVnmz5YYCgmnsdmmDdiMoZ7HKr8Xvmp8vrqJfK
	 ci9Hqqza/e4Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 07/13] bpf: Unify referenced object tracking
 in verifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529014936.2811085-8-ameryhung@gmail.com>
References: <20260529014936.2811085-8-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 02:22:30 +0000
Message-Id: <20260529022230.C4E161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing validation for multiple referenced objects in BPF helper r=
elease paths causes incorrect reference releasing and memory leaks.
--

commit 1ad7c42ef2c2cadcc679c403e24d66c882bd0438
Author: Amery Hung <ameryhung@gmail.com>

bpf: Unify referenced object tracking in verifier

This commit unifies referenced object tracking in the verifier by replacing
standalone id fields with a consolidated ref_obj_desc struct. It introduces
update_ref_obj() to populate the struct from bpf_reg_state, replacing open-=
coded
assignments in functions like check_func_arg() and check_helper_call().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3db0f1db475a3..1a49e5194bb41 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8226,15 +8232,8 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
>  		meta->release_regno =3D regno;
>  	}
> =20
> -	if (reg_is_referenced(env, reg) && base_type(arg_type) !=3D ARG_KPTR_XC=
HG_DEST) {
> -		if (meta->id) {
> -			verbose(env, "more than one arg with referenced id R%d %u %u",
> -				regno, reg->id,
> -				meta->id);
> -			return -EACCES;
> -		}
> -		meta->id =3D reg->id;
> -	}
> +	if (reg_is_referenced(env, reg))
> +		update_ref_obj(&meta->ref_obj, reg);
> =20
>  	switch (base_type(arg_type)) {

[ ... ]

> @@ -10119,8 +10119,8 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>  		err =3D -EINVAL;
>  		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
>  			err =3D unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
> -		} else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.id) {
> -			u32 id =3D meta.id;
> +		} else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.ref_obj.id) {
> +			u32 id =3D meta.ref_obj.id;
[Severity: High]
Does this code inadvertently cause memory leaks when bpf_kptr_xchg() is cal=
led
with NULL as the second argument?

Because ARG_KPTR_XCHG_DEST is no longer excluded in check_func_arg(), the f=
irst
argument (map_value) will populate meta.ref_obj.id if it is a referenced ob=
ject.

When the second argument (ptr) is NULL, it isn't referenced, so update_ref_=
obj()
isn't called for it. As a result, meta.ref_obj.id holds the ID of the first
argument, and the verifier incorrectly releases it from the reference state.

At runtime, the helper merely exchanges NULL into the kptr field and does n=
ot
free the map_value object. However, because the verifier considers it relea=
sed,
the BPF program cannot explicitly free it later, leading to a forced memory=
 leak
of the allocated kernel object.

I noticed this issue was fixed later in the patch series in commit a23fc3d5=
455bd
("bpf: Unify release handling for helpers and kfuncs").

>  			bool in_rcu =3D in_rcu_cs(env);
>  			struct bpf_func_state *state;
>  			struct bpf_reg_state *reg;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529014936.2811=
085-1-ameryhung@gmail.com?part=3D7
