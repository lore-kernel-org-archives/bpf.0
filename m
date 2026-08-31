Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4322472B8
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788136570; cv=none; b=SfOv58Di5lh9FFaZ3SELiktWU0Ho1WKJkFsPKrDODz+Ci4pg6JeAdtch8zQi+9KwpNIfNbSWGlXoV/NrjvnPAsKO/gq5SlwMdKGmh7IqAqv/UE7xhKgxxEp+xNk5OKIDuyEcbmjf/iphRBcdl39PfeFrhN8UdhS0fVzaK1cGe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788136570; c=relaxed/simple;
	bh=jSN8AnqCk6GyjTQn0SjfHtqoqHyF9dHrQC3h4SHe2wQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y0yNzs/4aAFA6UqKViZqJ2zaV1Zn0aMEHqXXtglirpTshZwEHgG1g3Kf6CyoNa3+tbRNewqyfqYs2VW2bY+pfV3KmvoI1N9RROXH0NZ3OJsKILTzx7WjRBY7Ba4O9kEEb9K0egsOKJxXMijn2QxBeuDmqA3S7+kdWIS9XWzf/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYbWJC5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYbWJC5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2151F000E9;
	Mon, 31 Aug 2026 00:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788136568;
	bh=rtST3dDOl/rwhxkk9B9abIFy1FYyeOOkKGg8t5qJYkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JYbWJC5KD/FJhqtYp6Yth4aDKcgBZj2x+SUV91OPzMnY4nbmd/qzVpUsDJFJZQD+8
	 mZXHHbSvko9lVsHCWgpjp4Yqz8ZwNR8gFcg/ZunLT+53KMdMFRyZlRIIQePvhfqJz6
	 GgVsFpDlkFiqXtF5wAwvtDoJaMOHNkMRgayfFauAnoqjD3q6p4V1Gv3pASOJbAg/bi
	 X7mP7CLCYyRN/V7vyy8FlWVsmrX7pHUxSIpwfzd0xo/amc+ej7/rDWDbA5fOQHfitT
	 bHsD/230KACPIA8t7Iqtso50N9R/8KdAPk2qYDT64TKnDQUoEIgw7mIvLko5yAXVHJ
	 4rZZVdVR09iPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y v4 2/3] bpf: Propagate referenced dynptr release
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831001552.3223196-3-xyx2021@mail.ustc.edu.cn>
References: <20260831001552.3223196-1-xyx2021@mail.ustc.edu.cn>
 <20260831001552.3223196-3-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 00:36:07 +0000
Message-Id: <20260831003608.5A2151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A BPF callback can trigger a kernel panic via WARN_ON_ONCE by dest=
roying a caller-acquired iterator, bypassing verifier boundary checks.
- [High] A BPF callback performing a NULL check on a caller-acquired PTR_MA=
YBE_NULL reference triggers a kernel panic via WARN_ON_ONCE.
--

commit d4b9f8473b6b567b88014154d968c1bc465a559e
Author: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
bpf: Propagate referenced dynptr release errors

This commit propagates release_reference() errors in
unmark_stack_slots_dynptr() instead of wrapping them in a WARN_ON_ONCE().
This prevents kernel panics from BPF callbacks trying to release
caller-acquired dynptrs.

Closes: https://lore.kernel.org/r/20260829040110.D6A991F000E9@smtp.kernel.o=
rg

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dbc9cfcffcd60..65ee9afaa5ff0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -838,7 +838,9 @@ static int unmark_stack_slots_dynptr(struct bpf_verif=
ier_env *env, struct bpf_re
>  	 * Mirror destroy_if_dynptr_stack_slot(), which already invalidates
>  	 * slices by dynptr_id.
>  	 */
> -	WARN_ON_ONCE(release_reference(env, ref_obj_id));
> +	err =3D release_reference(env, ref_obj_id);
> +	if (err)
> +		return err;
>  	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);

[Severity: High]
This isn't a bug introduced by this patch, but does unmark_stack_slots_iter=
()
have the exact same problem?

kernel/bpf/verifier.c:unmark_stack_slots_iter() {
...
		if (i =3D=3D 0)
			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
...
}

If a caller frame initializes an iterator on its stack and passes a pointer
to this stack slot as the ctx argument to a bpf_loop callback, and the
callback calls bpf_iter_num_destroy(), could the verifier panic the kernel
via this WARN_ON_ONCE (assuming panic_on_warn=3D1)?=20

Since release_reference() would return -EINVAL for a caller's reference,
it seems it would trigger the warning.

[Severity: High]
This is a pre-existing issue, but does mark_ptr_or_null_regs() also need to
handle cross-frame reference errors instead of warning?

kernel/bpf/verifier.c:mark_ptr_or_null_regs() {
...
	if (ref_obj_id && ref_obj_id =3D=3D id && is_null)
		/* regs[regno] is in the " =3D=3D NULL" branch.
		 * No one could have freed the reference state before
		 * doing the NULL check.
		 */
		WARN_ON_ONCE(release_reference_state(state, id));
...
}

If a caller acquires a PTR_MAYBE_NULL reference, spills it, and passes a
pointer to it to a bpf_loop callback, and the callback reads the pointer
and performs a NULL check, would release_reference_state() refuse to release
the caller's reference and return -EINVAL?=20

If so, this could also trigger the WARN_ON_ONCE and panic the kernel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831001552.3223=
196-1-xyx2021@mail.ustc.edu.cn?part=3D2
