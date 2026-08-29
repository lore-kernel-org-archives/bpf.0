Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AB10F0
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787976072; cv=none; b=sTTKV1y9p/KGe5IUqZnqMP8AbJmPFfjPejSGtd9iYtDWdwEVIaSHQRnR+jQC71+lTpWGmz/jpfHS3T1hFZAyiQkx/7Z9ZXi5crPjm8c4IH6GiKAxT+iuEscjJsV4XbPbBifOM6rcCsVH8udcWkgGvTsHWd5AKdP/GAk+ziPFBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787976072; c=relaxed/simple;
	bh=dMOKPsAEDHTE7MdhsBQWKZ5alAmPYE7CMGjtLblBaAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GlKsx27ByT4HGutiDGCjHsRKw7tdDX3L0yBSSndhNd90yGVQQxWvXtDLkeeabKn3csvbcfiUTOj5PztDoSxsuSwCPi1gmBvIlwPrHSbSsO+v5EDoxsde1BFdjiNvlnagY3FBOb5389Bu/YEXhwgzCky9LDWgQkL+bquXxT24Y9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=husQOjsi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="husQOjsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A991F000E9;
	Sat, 29 Aug 2026 04:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787976071;
	bh=ObQIvvr3vOR35ppaClsvn78UGo1cmt1e0qAScvDos+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=husQOjsiEKOVSNLaE/Bfqn70NMkV6aKbm9BY2Eht9WmWTX95G6KwiALj8irTdrGOQ
	 hMclSN0EdiBIjpGoBJda7w2UhcwodFIJAqn4vtfNVPP5wbO8zuHhswfhzZNWkq6TVm
	 3x725lhfbwhAnfQ4sPWzi9CwTDsN5Ju8V0yfo6yo8TO9JergPExQWaRgAWqqR3LXks
	 jzD7M0ehNdSTBLyr+Qx48QicTQGB4/jVDbBUHfNFMWhwIIX583mZe9GykX/3clsb+8
	 YD/ZuauR6Of66/ucrxIkvPHXAkBRyTav6f+RgWHsETL3/ZNRSEE3/+ajoUvzsPNaOM
	 ChgMsCC3FqhYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y v2 2/2] bpf: Invalidate dynptr clones in every
 call frame on release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260829033725.2365697-3-xyx2021@mail.ustc.edu.cn>
References: <20260829033725.2365697-1-xyx2021@mail.ustc.edu.cn>
 <20260829033725.2365697-3-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 04:01:10 +0000
Message-Id: <20260829040110.D6A991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] User-triggerable WARN_ON_ONCE in verifier via cross-frame dynptr r=
elease in callbacks, leading to local DoS.
--

commit 47e1f4599f52a8453ee0613fbb7c12af9d40d361
Author: Amery Hung <ameryhung@gmail.com>

bpf: Invalidate dynptr clones in every call frame on release

This patch modifies dynptr release handling to invalidate clones across all
call frames instead of only the submitting pointer's frame. It fixes an
issue where a caller's dynptr slot would not be cleared if a clone was
released in a subprogram.

Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5d0874a09a8db..9f314360551f8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -841,22 +841,31 @@ static int unmark_stack_slots_dynptr(struct bpf_ver=
ifier_env *env, struct bpf_re
>  	WARN_ON_ONCE(release_reference(env, ref_obj_id));

[Severity: High]
This is a pre-existing issue, but can an unprivileged user trigger this
warning intentionally by releasing a caller's reference from within a
callback?

If a program acquires a refcounted dynptr in a caller frame, passes a
pointer to it into a synchronous callback (such as via a bpf_loop context),
and calls a release helper like bpf_ringbuf_submit_dynptr() from inside
the callback, the initial helper validation succeeds since the dynptr is
valid on the caller's stack. This subsequently invokes
unmark_stack_slots_dynptr().

However, release_reference() calls release_reference_state(), which explici=
tly
checks if it is inside a callback trying to release a caller's reference.
Since callbacks cannot release caller references, it correctly fails and
returns -EINVAL.

This predictable -EINVAL return unconditionally triggers the WARN_ON_ONCE.
If panic_on_warn is enabled, could this allow a local user to intentionally
crash the kernel during program verification?

>  	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
> =20
> -	/* Invalidate any dynptr clones */
> -	for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> -		if (state->stack[i].spilled_ptr.ref_obj_id !=3D ref_obj_id)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829033725.2365=
697-1-xyx2021@mail.ustc.edu.cn?part=3D2
