Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153E388377
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778008049; cv=none; b=PLiDXBnn/XtufvrKphu+D14O4pNiAHGCUA7TnNx6wHRG5nvOzDXHHHcFYEOCwTjCgUuj0zS3XiB85ruILuTMKYeLY7YqY8y5DxHbRrQWN5O3IcPRiWDAwqeoPimL5QviZGei2CoUlAJZnzbBiyFBoTICEUNSZ63Ruk4jM9zaQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778008049; c=relaxed/simple;
	bh=x1QtTkozLJb4EFFf0HLpxby4qIEP9VCLsuoLAzqtjOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jlx88dCqcnGLlstocIatcW2pSxQiwmyuTF3O9nxrWIwbflaYgY5jUX+LkfYxx941jd0GLtxipy4au2kDAXPMWSQ5R6FY93qV9rJ3p1SNLQSx7mPrGX2jm79TqjlnAloPsDuRpKasb/DRAgh0HGd2g4deoGmstctH5gSzqUJiN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np7ppcBq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np7ppcBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91695C2BCF4;
	Tue,  5 May 2026 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778008048;
	bh=x1QtTkozLJb4EFFf0HLpxby4qIEP9VCLsuoLAzqtjOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Np7ppcBqgOwatRl4cZ3FAD27iCrbtP0/QRoMtSdk8hmclitlk7OqM4BVT3rOvaRrP
	 ajAgxCMt+JY4ZEdxzEnoH63twcuLRFRgdJgCRUHbJqSRTV6Oqk1bQjrvXz2mmnnInr
	 MlMDY6rEl+9yGsS+PDYWJZpF9yYza5kDC7few0AVjREWhmr8299533Ob8OF5cy0uQa
	 tJZkK5BlTGyki4mI9+HP1+XjvYbv/YoSbl+pDgw9qrkJQa3X9hycS1cwpjt06tWlOO
	 6rn004efa0esvE6L7GQMtwbPzH2iG0R+5s0JhIyJsEg0HKoNZNlIhH/NW9SOwOKHvB
	 698+jp7By5gfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 18/19] unwind_user/sframe/x86: Enable sframe
 unwinding on x86
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-19-jremus@linux.ibm.com>
References: <20260505121718.3572346-19-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 19:07:27 +0000
Message-Id: <20260505190728.91695C2BCF4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] SFrame unwinding uses incorrect DWARF register mappings for 32-bit=
 (compat) user processes on x86_64.
--

commit 014ce7a38c83420c1017dd7293ec85cc9b4e45d6
Author: Josh Poimboeuf <jpoimboe@kernel.org>
unwind_user/sframe/x86: Enable sframe unwinding on x86

This commit enables SFrame V3 unwinding on x86, which requires binutils 2.4=
6.
It introduces DWARF register mappings and sets the SFrame register constant=
s.

> diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/un=
wind_user.h
> index f38f7c5ff1de1..b80f0ec0f7a74 100644
> --- a/arch/x86/include/asm/unwind_user.h
> +++ b/arch/x86/include/asm/unwind_user.h
> @@ -15,6 +15,39 @@ static inline int unwind_user_word_size(struct pt_regs=
 *regs)
>  	return user_64bit_mode(regs) ? 8 : 4;
>  }
> =20
> +static inline int unwind_user_get_reg(unsigned long *val, unsigned int r=
egnum)
> +{
> +#ifdef CONFIG_X86_64
> +	const struct pt_regs *regs =3D task_pt_regs(current);
> +
> +	switch (regnum) {
> +	/* DWARF register numbers 0..15 */
> +	case  0: *val =3D regs->ax; break;
> +	case  1: *val =3D regs->dx; break;
> +	case  2: *val =3D regs->cx; break;
> +	case  3: *val =3D regs->bx; break;
> +	case  4: *val =3D regs->si; break;
> +	case  5: *val =3D regs->di; break;
> +	case  6: *val =3D regs->bp; break;
> +	case  7: *val =3D regs->sp; break;

Does this code handle 32-bit (compat) user processes correctly?

32-bit (i386) processes use a different DWARF mapping where ESP is 4 and
EBP is 5, but this code unconditionally uses the x86_64 DWARF register
mapping (where register 4 is RSI and 7 is RSP).

When an i386 application uses an SFrame V3 flexible FDE, the DWARF register
number is explicitly encoded in the FRE data words. The generic unwinder
sframe_init_cfa_rule_data() compares the register against the hardcoded
SFRAME_REG_SP (which is 7 on x86_64).

Since an i386 SFrame specifies 4 for SP, the check would fail and fall
back to UNWIND_USER_CFA_RULE_REG_OFFSET with regnum =3D 4. Then
unwind_user_next_common() would call unwind_user_get_reg(&cfa, 4), which
would return regs->si instead of regs->sp.

Could this break unwinding for 32-bit tasks by using the wrong registers
(e.g., RSI acting as the stack pointer), leading to corrupted stack traces?
Would the unwinder need to be explicitly disabled for compat tasks or
dynamically adjust the DWARF mappings using user_64bit_mode(regs)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D18
