Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040121EFFB7
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107714; cv=none; b=pcOCz1J0XaN+zgk2Q9a6UYH+RSXZ5sbfSy3tQJMU73reeCRkjww+9Yz+sxolv5JrnJq6huNPP06aWHoYLddI4sWQpVBCuMUo8PWGULAOgOM2/179FjQe3bjIVhgTrax+wkT9JBIDPCsENpNjSyL2Y/dbC4YawbWlzdmp18PeRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107714; c=relaxed/simple;
	bh=fdQcxvvU3QzQlMj02IcxFyfvmyGqa6VGAr3Oa2Vnqu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H98d/J0QC5Y+lp4Sc2J7sj4hNPpR0fT5KQ9p+fGbBHfHdCEc/mVfrCiTI495v0eCNc/4IvytQl28he6jnU/fePOItHGZ0VkHNy6DVVVR7fN+Rr7XvEec6FfbEzaK+nJ0C7N1q0XXCzThNtzkbnU0E/hsh9S+5DCPdsGZ+9J6RA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy6YRS7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy6YRS7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FC4C2BCB0;
	Wed,  6 May 2026 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778107713;
	bh=fdQcxvvU3QzQlMj02IcxFyfvmyGqa6VGAr3Oa2Vnqu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Qy6YRS7Hzie06o0PbLbobGbzkfplbArwN2kXQJcd9CfC/5A4aifr7NJVF4w2GZpe0
	 +wyXZvZLXIp1TwlV8h4JklP136JGllJT5/K54oz76rm6RQvTDnld//Xh9UYCwgqCVv
	 L/lTqnOmSAx5YYPjZJynR+zcNF/lTRviH0nVjoJhjYG4e8syhlN9cRlMDBdLcMN8SI
	 TC2ERAbImDY1pRCVMmLJkXNhDAfdzUD3ARLzYvbVZ+KwjaRZQ4xSXj5d7bA0uznqek
	 79g2ypPaCc+4Mx7UtS4hA5iNF1zZcb7H75CDEXSu/HEckWXYvvYwKwPQKc9ORZfB/0
	 wTRaTiJf4ncIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
Reply-To: sashiko@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506142709.2298255-8-ameryhung@gmail.com>
References: <20260506142709.2298255-8-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 22:48:32 +0000
Message-Id: <20260506224833.71FC4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The verifier uses `verifier_bug()` to handle ambiguous reference=
d object arguments, allowing user input to potentially trigger kernel warni=
ngs.
--

commit e4dc51a4e8f54da451d3c9dcfb864ea9abe239c6
Author: Amery Hung <ameryhung@gmail.com>

    bpf: Unify referenced object tracking in verifier

This commit unifies the reference tracking logic used by helpers and kfuncs
into a common ref_obj_desc structure. It updates tracking mechanisms and=20
pushes validation of ambiguous referenced objects out to their use location=
s.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 792e61e07b065..542912c7983f7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -713,6 +700,13 @@ static int mark_stack_slots_dynptr(struct bpf_verifi=
er_env *env, struct bpf_reg_
>  				return ref_obj_id;
>  		}
>  		/* Track parent's id if the parent is a referenced object */
> +		if (ref_obj && ref_obj->ref_obj_id) {
> +			if (ref_obj->cnt > 1) {
> +				verifier_bug(env, "function expects only one referenced object but g=
ot %d\n", ref_obj->cnt);
> +				return -EFAULT;
> +			}
> +			parent_id =3D ref_obj->id;
> +		}

Since ref_obj->cnt is determined by the number of referenced arguments
provided by the BPF program, is it possible for a user to intentionally
trigger this verifier_bug() by passing multiple referenced objects?

Since verifier_bug() expands to BPF_WARN_ONCE(), triggering a warning
via unprivileged or user-controlled input could be problematic if
panic_on_warn is enabled.

Would it be safer to gracefully reject the program using verbose() and
returning -EINVAL, similar to how it is handled for release kfuncs earlier
in this patch?

This same pattern appears in a few other places introduced by this patch:

[ ... ]
> @@ -10165,15 +10160,14 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>  	if (type_may_be_null(regs[BPF_REG_0].type))
>  		regs[BPF_REG_0].id =3D ++env->id_gen;
> =20
> -	if (helper_multiple_ref_obj_use(func_id, meta.map.ptr)) {
> -		verifier_bug(env, "func %s#%d sets ref_obj_id more than once",
> -			     func_id_name(func_id), func_id);
> -		return -EFAULT;
> -	}
> -
>  	if (is_ptr_cast_function(func_id)) {
>  		/* For release_reference() */
> -		regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
> +		if (meta.ref_obj.cnt > 1) {
> +			verifier_bug(env, "function expects only one referenced object but go=
t %d\n",
> +				     meta.ref_obj.cnt);
> +			return -EFAULT;
> +		}
> +		regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj.ref_obj_id;

[ ... ]
> @@ -12740,8 +12733,14 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  				regs[BPF_REG_0].type |=3D MEM_RDONLY;
> =20
>  			/* Ensures we don't access the memory after a release_reference() */
> -			if (meta.ref_obj_id)
> -				regs[BPF_REG_0].parent_id =3D meta.ref_obj_id;
> +			if (meta.ref_obj.ref_obj_id) {
> +				if (meta.ref_obj.cnt > 1) {
> +					verifier_bug(env, "function expects only one referenced object but =
got %d\n",
> +						     meta.ref_obj.cnt);
> +					return -EFAULT;
> +				}
> +				regs[BPF_REG_0].parent_id =3D meta.ref_obj.ref_obj_id;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506142709.2298=
255-1-ameryhung@gmail.com?part=3D7
