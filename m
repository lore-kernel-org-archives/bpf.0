Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684EF3BED19
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006132; cv=none; b=bqx2h2Kc3RE47CaPhEpnLCORmg0n1Xfgp+vw7mM9aUl0XmQlkbGYTpDcIFvs7PpmoY/Z7BBTo8VnmBMvgx6zHod2/k3mQbqXsgTggHle9PhlyDYqPeztEcsO5emGAgUmRspttiI3h+i8TbkZZefiyv9OUekwUOUdfGDBO4sLQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006132; c=relaxed/simple;
	bh=2SVwoNC5ZP1pWt7Gr/pz0P4UyHeMiqIgVVvZKTFh6pE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iSF+E0BResTs4JDwzAuJzgmLwpA5s17rSvK98qEQQBtB5UnPTEmZsfGuoBYQN1mHV95fBQqHGdm8c+FaPKHySNdQuY6L0+Bt+Q/wzyT3/t6J3iRj5aHHRBWVRDZaX/SrmtFvKSDa38ImFLfXAolmXLvyxx0RXZom4b8Q64QZqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OK6i8Aix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OK6i8Aix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EE8C2BCC7;
	Tue,  5 May 2026 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778006131;
	bh=2SVwoNC5ZP1pWt7Gr/pz0P4UyHeMiqIgVVvZKTFh6pE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OK6i8Aix9KtIKb5SOh3qcqIuBaVsOvI02tx7dsXfLwverWCOYKIPmPeg9l1c9PiZV
	 exq6/UdWdyFFDlwiTj5rsqFBVKQrkmIWw7XbjR7uvl+gCO8UP+6FWk832y8iIVebb/
	 MzJc7Wd9X9eJnOwYJx9i7d3vFh0A9woSS5nQUy76/HHnWQOa574qFpDiScvmNFW896
	 Ii/1Ds66ToPHsJZztOSkZcQDlczWOWCJLn5kRduox1Emzdrrb5zQZgnLmNLJBCtlVw
	 EET+wSES6JrzGmj9vuK0n6pbTQoVoKT93ZReJ6crBnobQLg0o+VsHQZ44yNpwsNUkY
	 DXYux+ZIJu21A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 13/19] unwind_user: Enable archs that pass RA in a
 register
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-14-jremus@linux.ibm.com>
References: <20260505121718.3572346-14-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:35:31 +0000
Message-Id: <20260505183531.C9EE8C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unprivileged user space can trigger a kernel warning (`WARN_ON_ONC=
E`) and potential panic by providing a maliciously crafted `.sframe` sectio=
n.
--

commit 20f03d41baa46baef137fb9a88081c8f92b5eb5f
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user: Enable archs that pass RA in a register

This commit updates the user space stack unwinder to support architectures
that pass the return address in a register instead of saving it on the
stack. It also handles architectures where the stack pointer may be
unchanged in the topmost frame.

> diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
> index 64618618febde..bc2edae399556 100644
> --- a/include/linux/unwind_user.h
> +++ b/include/linux/unwind_user.h
> @@ -23,6 +23,15 @@ static inline bool unwind_user_at_function_start(struc=
t pt_regs *regs)
>  #define unwind_user_at_function_start unwind_user_at_function_start
>  #endif
> =20
> +#ifndef unwind_user_get_ra_reg
> +static inline int unwind_user_get_ra_reg(unsigned long *val)
> +{
> +	WARN_ON_ONCE(1);

Can a maliciously crafted .sframe section trigger this warning and panic
the kernel if panic_on_warn is enabled?

The SFrame unwind data is parsed from user-provided ELF binaries, so the
.sframe sections are entirely user-controlled.

If an unprivileged user on an architecture using the generic fallback
provides an SFrame Frame Row Entry with dataword_count > 0 but an
explicit ra_off dataword of 0, it appears this would bypass the
frame->outermost check while keeping frame->ra_off =3D=3D 0.

When the kernel unwinds the stack, unwind_user_next_common() would see
frame->ra_off =3D=3D 0 and call unwind_user_get_ra_reg():

kernel/unwind/user.c:unwind_user_next_common() {
    ...
	if (frame->ra_off) {
		if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
			return -EINVAL;
	} else {
		if (!state->topmost || unwind_user_get_ra_reg(&ra))
			return -EINVAL;
	}
    ...
}

Would it be better to gracefully return an error code like -EINVAL here
without raising a warning?

> +	return -EINVAL;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D13
