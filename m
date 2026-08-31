Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87E1DE8AD
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788136631; cv=none; b=paj4q4lHVGqZfgR4A6F0GJ3FxT+kurrsU5LGxGfQ5UENE7+fdhZpRK7x0RKychjrotnehwml3/fZPgo8lnVL/n+iBiK8f5n4Ga+nfuYegTB1fcSL5yL0ckQbUY+TFRMZAWoRxph4/rycKgTjF1F4eWa8ZNRnmBcP2CfihoN1UfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788136631; c=relaxed/simple;
	bh=kRrzxN3f/oN8WTg+mixwgwmxf15XjknuYkeRbXZpFMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sxJ8cne0R3kIPDppVR6+Ni4tHHnHVDwC5zwvnPCT8wRWuvKGP6wLH38i1tV4FLNxcb/0C4uaqIXPQJXaBqjRYsN2s3qH+oZxc4iXyWTpCKSaLeBp4oPgmIC/W7Eq1udsujfxetPtSpo6ds+NMJngkMbZqUDj9yS21hhdZRk3458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R22VyyBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R22VyyBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7691F000E9;
	Mon, 31 Aug 2026 00:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788136629;
	bh=wSeEdsUQqvQRQWE/Y3MzHPVNnF9yM/2ylURaLGnUlE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R22VyyBbFmZjYoqR8yZYlfw5YnNZmjshRvBYuDhzdlhYLLEM1jdNU2Q3LP+mIwXZA
	 TyF6euPHjzIkZGzc+tgusrOOg9LxnuiniWIlEwYX2eRvQ6aWOunFCQnNRSvvtQodVY
	 yKDw24CcRGEd99Yh+Z1kfrx75Fxeoc/VG7Hkv/Gjc03K1gWomFgqKe10+Du2FZe4bn
	 abY3bk0wqiRX0DMoQZ5HE/yQswNvFJM+GxSRZkhWQr+7g/w21jcKe0kB/YJysEqVwj
	 ow1PmyiD/OPBK6xut5Eiv0NjATQWR5NwGYhkydn4Mz30gkwmwuJI45UZL7tD7bVPag
	 iUWaSGiLSgaLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y v3 2/3] bpf: Propagate referenced dynptr release
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831001524.3223134-3-xyx2021@mail.ustc.edu.cn>
References: <20260831001524.3223134-1-xyx2021@mail.ustc.edu.cn>
 <20260831001524.3223134-3-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 00:37:08 +0000
Message-Id: <20260831003709.5D7691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes a kernel panic caused by callbacks releasing calle=
r-acquired dynptrs, but leaves identical WARN_ON_ONCE vulnerabilities for i=
terators and PTR_MAYBE_NULL registers.
--

commit fab416bf47d5e1f31c36e5cf7824ece03db8c1c5
Author: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

bpf: Propagate referenced dynptr release errors

This commit fixes a kernel panic vulnerability where a BPF callback releasi=
ng
a caller-acquired referenced dynptr triggers a verifier WARN_ON_ONCE. It
handles the failure from release_reference gracefully instead of warning.

Closes: https://lore.kernel.org/r/20260829040110.D6A991F000E9@smtp.kernel.o=
rg

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ccd5c86706b18..c9e3856bb59fd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -1023,7 +1023,9 @@ static int unmark_stack_slots_dynptr(struct bpf_ver=
ifier_env *env, struct bpf_re
>  	 * Mirror destroy_if_dynptr_stack_slot(), which already invalidates
>  	 * slices by dynptr_id.
>  	 */
> -	WARN_ON_ONCE(release_reference(env, ref_obj_id));
> +	err =3D release_reference(env, ref_obj_id);
> +	if (err)
> +		return err;

[Severity: High]
This is a pre-existing issue, but while this patch fixes the kernel panic f=
or
dynptrs, doesn't the exact same vulnerability exist for iterators and
PTR_MAYBE_NULL registers?

If a BPF program acquires an iterator (e.g., via bpf_iter_num_new) or a
refcounted PTR_MAYBE_NULL pointer (e.g., via bpf_sk_lookup_tcp) in a caller
frame, and passes it via the stack as context to a callback like bpf_loop,
the callback can attempt to destroy it.

Inside the callback, if the program calls a destroy kfunc on the iterator
or performs a NULL check on the restored PTR_MAYBE_NULL pointer, the
verifier attempts to release the reference state in the callee's frame.
Since the reference was acquired in the caller, it resides in the caller's
state->refs array, causing release_reference or release_reference_state to
return -EINVAL.

This triggers identical unpatched WARN_ON_ONCE macros in kernel/bpf/verifie=
r.c:

- In unmark_stack_slots_iter:
  WARN_ON_ONCE(release_reference(env, st->ref_obj_id));

- In mark_ptr_or_null_regs:
  WARN_ON_ONCE(release_reference_state(state, id));

Should these locations also be updated to propagate the error instead of
warning to prevent userspace from crashing the kernel when panic_on_warn is
enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831001524.3223=
134-1-xyx2021@mail.ustc.edu.cn?part=3D2
