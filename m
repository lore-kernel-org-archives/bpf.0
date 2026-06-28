Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD63A9D9B
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782656644; cv=none; b=rmUWTRckxQIKtZrB2b/X4c+5RUqwY8JLw3bv5Scg9nwQglibF0t0CCxZ2XPxCuPMQKNd6K6J2QEtMwulMJSxI/0D/a6kkdN0GMgCIN51wFZvIQiCp+gMZPTvwBYLAU3qUosBInI1gfeMckD05SiTbHJRhzzn0PWy0hD0NAXCwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782656644; c=relaxed/simple;
	bh=3hsrKxlHkuRy+tFzRvHBAE9uRl/bYK1TugsyGFd9ydU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F00W8Q4VAbz5jnpRstvX6bpCfvMAX8ZjHrp6o1yhr2WrOdzfemd7w0KFTAjQKlAZm4FO5YRlx/OID+YdTmBmcxQmGzA1rQZVjJ6bFx5NDYnq7MtDgAzsjbddWEu1g/F4qVNE1nFrkkRhHY2tLNBVUNptr2gOBCjM75HVZb2KxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARUaIj8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARUaIj8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DC21F000E9;
	Sun, 28 Jun 2026 14:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782656641;
	bh=9z1BAdNEfUui+KzQrcTXy1YL2zG5hyu/VH8llukbrOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ARUaIj8VjQxowNifuObLfNa+Iwhns2/mvl3ac0a8AQ8k1TDDXlIf03/pT1eUQkGcW
	 GlXbQXVjt1FA2ftpF0Xui0WiUgM46tmk24KQngTPcC6hMSLEWWesueA60I/29gibu5
	 AEsDGqIHiO9CStBhSWjJoKfmI+gc2L3cq/YvZoaxTprW6aEgpVgEVbUtc+tccXIetP
	 yQIFrZ7qHf5Rehvj12M8Fiy5jazczoVxajZJw113kZlACyCWYHpNQvbQcY2Q2acq60
	 8mmLbxRXV0T8eDYtYHZSyHv5gPaYJiJiLVECdj9wYJBOOnF52L4rHN2NE+CWVIQ7Uv
	 zbd2oQZdMq3aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Enforce gotox targets against
 subprog bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260628-f01-03-gotox-bpf-next-v3-1-b744432e1361@mails.tsinghua.edu.cn>
References: <20260628-f01-03-gotox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn>
 <20260628-f01-03-gotox-bpf-next-v3-1-b744432e1361@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 14:24:01 +0000
Message-Id: <20260628142401.80DC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch adds a runtime bounds check to prevent `gotox` targe=
ts from jumping outside the current subprogram, but fails to ensure that dy=
namically observed targets were actually modeled during Control Flow Graph =
(CFG) construction. This allows an attacker to follow unmodeled control-flo=
w edges and bypass static liveness-based state pruning.
--

commit 5e0bdd5b4a7e2ce073913482349669d9387d6a32
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf: Enforce gotox targets against subprog bounds

During CFG construction, the verifier records the modeled gotox target set
in insn_aux_data->jt. This patch adds a check to reject targets outside the
calling subprogram bounds when check_indirect_jump() follows targets from
the runtime PTR_TO_INSN register's actual INSN_ARRAY map.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -17188,6 +17190,23 @@ static int check_indirect_jump(struct bpf_verifi=
er_env *env, struct bpf_insn *in
>  		return -EINVAL;
>  	}
> =20
> +	subprog =3D bpf_find_containing_subprog(env, env->insn_idx);
> +	if (verifier_bug_if(!subprog, env,
> +			    "gotox insn %d is outside subprog bounds\n",
> +			    env->insn_idx))
> +		return -EFAULT;
> +	subprog_start =3D subprog->start;
> +	subprog_end =3D (subprog + 1)->start;
> +
> +	for (i =3D 0; i < n; i++) {
> +		u32 target =3D env->gotox_tmp_buf->items[i];
> +
> +		if (target < subprog_start || target >=3D subprog_end) {

[Severity: Critical]
This is a pre-existing issue, but does this bounds check alone fully protect
against unmodeled control-flow edges?

During CFG construction in kernel/bpf/cfg.c:jt_from_subprog(), if an
INSN_ARRAY map's minimum offset falls outside the subprogram, the heuristic
skips the map entirely:

    if (jt_cur->items[0] >=3D subprog_start && jt_cur->items[0] < subprog_e=
nd) {

If an attacker creates an INSN_ARRAY map containing both an out-of-bounds
offset (e.g., 0) and a valid in-bounds target Y, the CFG construction drops
Y completely because items[0] is less than subprog_start.

Later at runtime, if the attacker restricts the bounds to index exactly Y,
this check passes because Y is within subprog_start and subprog_end. The
verifier then explores the gotox to Y edge that was never modeled in the
CFG jump tables.

Because liveness analysis relies strictly on the statically modeled CFG,
could traversing this unmodeled edge cause liveness to incorrectly assume
registers are dead, allowing an unsound state pruning bypass?

Should this logic verify that the dynamic target is actually present in
env->insn_aux_data[env->insn_idx].jt, rather than only verifying the target
is within subprogram boundaries?

> +			verbose(env, "gotox target %u outside subprog\n", target);
> +			return -EINVAL;
> +		}
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-f01-03-got=
ox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn?part=3D1
