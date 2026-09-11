Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DFB3BED6A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165197; cv=none; b=l7M0ICf3uts3DT04nK4SWHoQdtbBW4XkIXDWR9Fo2FmmdG8o1kXmYtht5+yWkisxKosVKSHwcZsQ9u/Cm3Y7b2yqQjpe9y+jIkTVQG9zSq9hY9IrRU5afxadrA61UYD66uurE/287vkH0bflDdSpODpnQWmtwj9JVRBQAQ7b7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165197; c=relaxed/simple;
	bh=Lt6Sfke4WcWzt+tpBVWjX1Hgbiek91kk8TJbP/Bvets=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=USieoaAcUdJ4iEIGKs5JMmiXA0DliyqWqeuSlgMdH9xva0O7TMrX7XGN6ju0DSY7le7YiIy3jd3Prc2NBuUaXQZJnfmlkdW9N2SFNcC7DUG8Tx56Uu2CUN3EUobrzldhP4dmcx/8gW8QZ9Y+wluC1czkQleJnv8wTqdD1mu1tX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0vchACr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0vchACr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F62A1F00893;
	Fri, 11 Sep 2026 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789165196;
	bh=E5EHD2mVzSlENXXvAmNNnpB09EDVaBe5QAPMbRujQzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X0vchACr4XqQbWzVTKXnuO2cJN9UVpIDlXX6CPVcvEyRnzolzYA5KHFchppbG30px
	 tMvriXGDB9Ebjz+5OkH1Ws43/mZs1GHsQ1g/UCEhbP6OgQKpm1I4haHdKA1jdhm9Ne
	 L8ErX3V/n4jWm9BRYs4pAVTnpjCyBQiLnKLsZskWS3Z2P5cQKjVAkr5CMG/ZTUEB1Y
	 gnbCELPkJnufdYbTnH/SItDtLH0CrbkkrX+9TploZB4rfBBvgWxvIwjWeu5KUVGmZO
	 YNpk0pYy03Uoo8C14b1gdENAnqFX5ZrWI+igjJUE5HBCQM70JEdZdHE2gxBJXgVQmD
	 WAI1lEAgFukPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 05/23] bpf: Clarify unused and scalar
 function argument types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911220415.1396439-6-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
 <20260911220415.1396439-6-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:19:55 +0000
Message-Id: <20260911221956.1F62A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds array access in memcg kfuncs (`bpf_mem_cgroup_memory=
_events` and `bpf_mem_cgroup_vm_events`) due to missing negative bounds che=
cks for enum arguments.
--

commit a779fb1811c9555981f50c14118ca53a762cdd76
Author: Amery Hung <ameryhung@gmail.com>

bpf: Clarify unused and scalar function argument types

This commit renames ARG_DONTCARE to ARG_UNUSED to indicate it terminates
argument iteration. It also reuses ARG_SCALAR for integer, enum, and=20
exception callback arguments to reflect that they require SCALAR_VALUE.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 42d89db5df07b..5d21bee458055 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -9818,7 +9815,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
>  		struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, i);
>  		struct bpf_subprog_arg_info *arg =3D &sub->args[i];
> =20
> -		if (arg->arg_type =3D=3D ARG_ANYTHING) {
> +		if (arg->arg_type =3D=3D ARG_SCALAR) {
>  			if (reg->type !=3D SCALAR_VALUE) {
>  				bpf_log(log, "%s is not a scalar\n", reg_arg_name(env, argno));
>  				return -EINVAL;

[Severity: High]
This is a pre-existing issue, but while reviewing how the verifier treats
enum arguments as SCALAR_VALUE, I noticed that the memcg kfuncs might be
vulnerable to negative enum values.

Because the BPF verifier treats enum arguments as scalars without enforcing
their ranges, a BPF program can pass a negative value (like -1).=20

In bpf_mem_cgroup_memory_events(), the bounds check uses a signed
comparison:

mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events() {
	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

	return atomic_long_read(&memcg->memory_events[event]);
}

If event is negative, does this code overflow the memory_events[] array
and allow an out-of-bounds read?

Similarly, in bpf_mem_cgroup_vm_events(), it relies on
memcg_vm_event_item_valid() for bounds checking:

mm/bpf_memcontrol.c:bpf_mem_cgroup_vm_events() {
	if (unlikely(!memcg_vm_event_item_valid(event)))
		return (unsigned long)-1;
}

mm/memcontrol.c:memcg_vm_event_item_valid() {
	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;

	return !BAD_STAT_IDX(memcg_events_index(idx));
}

If idx is negative, will this bypass the >=3D NR_VM_EVENT_ITEMS check and
cause an out-of-bounds access in memcg_events_index()?=20

Should these kfuncs be updated to explicitly check for negative values
(e.g., event < 0 || event >=3D MEMCG_NR_MEMORY_EVENTS)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911220415.1396=
439-1-ameryhung@gmail.com?part=3D5
