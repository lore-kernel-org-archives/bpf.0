Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACF2D29C8
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788000136; cv=none; b=U5kiqM1Wm5Qri7+MqaNxNO/md38bFU5LU8SAYrW8MhbkwW7ULFB+x7LhT1yJPM1F2vLqDDI6lq2KGd6EEVzEqidjVEhzdAJsWYEmv2J6cLradpPESfe6S9qkezElfqB77jLG3gZTmTasVr5hXFsVVD/DP11SPm64nSJCW3Eeh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788000136; c=relaxed/simple;
	bh=DE6MOvwKuxqgQCZjrG8p4nxTI3nnniwIFYIQYftft3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=scdwVN2ef0FlJBkfXO53UVRbtfnBx6eP2rsNnC6W30/dmSr5Eo+Ck4pzUxDvC9IbuNE0Rne0NlEH2Jp4ZgCNfGyquDJ2l79OQZeKfEOYe++Tbv5K4EA3CjdkG/rjW7NZST6MzZbfmG5JPvgK++T4iz01xkzAyEw+Vq6GWcBKsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGHQoU1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGHQoU1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4B01F000E9;
	Sat, 29 Aug 2026 10:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788000134;
	bh=LRUYiXgyl1xy+2Vh9kC72xjqd7Ilf2K88X+P5+m8yBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QGHQoU1YawJDMHxiOssr13wrM5ITu3Q9MBfAzApjiTvI4p6FVyeAVrt407qnMhjpC
	 wCfq2MyUQyKnfsiFE7WvoD+rc5W3T7ZR0laucJ7Y8BVNpTj0DwpYai6Xz3zPsRTMao
	 E0896/tSQiJ/exCXsZV4SEXEC9MUo9h40R0Rgky9LnPA7B03Bv6MvIJwN8dYvRFCjQ
	 dkA0+IRjhrKAebLfLErQ4YDmYWAoojxI5vVYepwskOVoIR3ufuNrYLZCk5FaQuvNEp
	 xVLSJDdyt+2WcTRU+OavBWZt+4gy6jqyZeM0pVde87ZYXzlkNGQ6x2MyC0b9R0sZJ9
	 bViFAlfMDpKWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y v2 2/3] bpf: Propagate referenced dynptr release
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260829102618.105116-3-xyx2021@mail.ustc.edu.cn>
References: <20260829032754.2324760-1-xyx2021@mail.ustc.edu.cn>
 <20260829102618.105116-1-xyx2021@mail.ustc.edu.cn>
 <20260829102618.105116-3-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 10:42:14 +0000
Message-Id: <20260829104214.9F4B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The commit fixes a kernel panic where a callback releasing a calle=
r-acquired dynptr reference triggers a WARN_ON_ONCE, but leaves the identic=
al vulnerability unfixed for BPF iterators in unmark_stack_slots_iter().
- [High] A kernel panic can be triggered via WARN_ON_ONCE(release_reference=
_state(...)) in mark_ptr_or_null_regs() when performing a NULL check on a c=
aller's spilled PTR_OR_NULL register inside a callback.
--

commit 0666efa4fca54b7a83f6a6c69d44d1c775940a2e
Author: Amery Hung <ameryhung@gmail.com>
Subject: bpf: Propagate referenced dynptr release errors

This patch fixes a panic caused by a WARN_ON_ONCE in the verifier when a BPF
callback incorrectly attempts to release a referenced dynptr acquired by its
caller. It does this by correctly propagating the error returned from
release_reference() in unmark_stack_slots_dynptr().

Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ad679bc42427c..c9e3856bb59fd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -1013,8 +1017,16 @@ static int unmark_stack_slots_dynptr(struct bpf_ve=
rifier_env *env, struct bpf_re
>  	 * 2) Any slices derived from this dynptr.
>  	 */
> =20
> -	/* Invalidate any slices associated with this dynptr */
> -	WARN_ON_ONCE(release_reference(env, ref_obj_id));
> +	/* Invalidate any slices associated with this dynptr.
> +	 * release_reference() only walks registers that carry ref_obj_id;
> +	 * slices are PTR_TO_MEM with dynptr_id set and ref_obj_id left 0.
> +	 * Mirror destroy_if_dynptr_stack_slot(), which already invalidates
> +	 * slices by dynptr_id.
> +	 */
> +	err =3D release_reference(env, ref_obj_id);
> +	if (err)
> +		return err;

[Severity: High]
This isn't a bug introduced by this patch, but does the same vulnerability
still exist for BPF iterators in unmark_stack_slots_iter()?

If a caller allocates an iterator on its stack, passes a pointer to this st=
ack
slot into a callback via bpf_loop(), and the callback invokes a destroy kfu=
nc
(like bpf_iter_num_destroy()), the verifier will call:

kernel/bpf/verifier.c:unmark_stack_slots_iter() {
    ...
		if (i =3D=3D 0)
			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
    ...
}

Because the reference belongs to the caller frame, release_reference() retu=
rns
-EINVAL, which triggers the WARN_ON_ONCE and panics the kernel if
panic_on_warn=3D1.

[Severity: High]
This is a pre-existing issue, but could a similar panic occur when performi=
ng
a NULL check on a caller's spilled PTR_OR_NULL register inside a callback?

If a caller acquires a reference-tracked pointer that could be NULL, spills=
 it
to the stack, and passes a pointer to that stack slot to a callback, the
restored register preserves the caller's id and ref_obj_id.

When the callback performs a NULL check on this restored pointer:

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

Because the reference belongs to the caller frame, release_reference_state()
returns -EINVAL, triggering the warning.

> +	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
> =20
>  	/* Invalidate any dynptr clones */
>  	for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829102618.1051=
16-1-xyx2021@mail.ustc.edu.cn?part=3D2
