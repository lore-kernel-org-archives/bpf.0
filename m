Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D7426D16;
	Wed,  1 Jul 2026 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902687; cv=none; b=LY0/0FYPF3XQxyd3ySed9gh3WC6ostZ0LsNhjy6Psvwrg0ldKaceqVbeU83X6Tkjiw4wV6X3iNEL8eX66YPSWNlZ6K0CQhsuuqnCgd04qeFu8Au5fW6wdW0r9TB6jQy3LChS9NOZ1ZNcbsUyDnJOQJW/5yAElyoYbK90kULu+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902687; c=relaxed/simple;
	bh=qD/E0dFKs/WxiQOX8LBB6paRI9fS1U5QUI2Nu3EagYM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c0EfyB7YqOrA+qLpLRvinJ86oUwcu+sVfAVzYS7wkdAY0kaslE3EILI1q/hdnUX7ABgtG8aSCx6+kNF7GZIbMbDvfEbKk+JIJB+Qxpu4TZosixzVrmgKL66mEsiwmo0j8xgzNQc2wjmIC9OsY/N1G8kG+2ZI6lTYtAZiVa58WJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfaiVOMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfaiVOMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729551F00A3A;
	Wed,  1 Jul 2026 10:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782902685;
	bh=AqAFojxBasO3zWqKZueMPCaa/3uW5XVkDqxsbzVCUYg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TfaiVOMyWJYjbcSy1re5I9YRsDTRn51AtUhKpwVnvpFJ/oD13mMDNOwPGN3gaVUl1
	 dX0icEZX6uN7FECCQL9c5KJ802uYPgxs4t/8oHvsRCSEnlJm1gPMxb1tFR0WNHOT/a
	 +jw3MwGoynysUDCk7gAc0sIi3KQwb4+OpyQlkAhP5MlWJxQiq8xDDSafOTo3GUUuwD
	 MLA8H7g/czJY1lbTBPj7sa2NS8pBw5J5V0MEzXortWkxvcej3b6hKaiTcBs6fY6ZcN
	 sZOQJn8Kc3CzFJhBl+UrfPih5I6X8qi7NWJQraxSMr5bmoprUot9tWo/5S3nuVsnFS
	 Zustgxo4YIZ3A==
Content-Type: multipart/mixed; boundary="===============4787310242088628169=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d173a3958e4fb9cfe928b4ecfb7799ffaf12029cdde1a1d9c493c5ecba1e9b7f@mail.kernel.org>
In-Reply-To: <20260701-kasan-v3-4-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-4-bd09bb942d86@bootlin.com>
Subject: Re: [PATCH bpf-next v3 04/10] bpf, x86: add helper to emit kasan checks in x86 JITed programs
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 10:44:45 +0000 (UTC)

--===============4787310242088628169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 054e043ffcd2..68c5f9f94e5e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1110,6 +1121,90 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)

[ ... ]

> +	/* Save rax */
> +	EMIT1(0x50);
> +	/* Save rcx */
> +	EMIT1(0x51);
> +	/* Save rdx */
> +	EMIT1(0x52);
> +	/* Save rsi */
> +	EMIT1(0x56);
> +	/* Save rdi */
> +	EMIT1(0x57);
> +	/* Save r8 */
> +	EMIT2(0x41, 0x50);
> +	/* Save r9 */
> +	EMIT2(0x41, 0x51);

[ ... ]

> +	EMIT2(0x41, 0x59);
> +	EMIT2(0x41, 0x58);
> +	EMIT1(0x5F);
> +	EMIT1(0x5E);
> +	EMIT1(0x5A);
> +	EMIT1(0x59);
> +	EMIT1(0x58);

This isn't a bug, but the save block annotates each push with its target
register (/* Save rax */, /* Save rcx */, ... /* Save r9 */), while the
matching restore block emits the seven pops with no comments at all.
Would adding the mirrored comments here (/* Restore r9 */, /* Restore r8 */,
... /* Restore rax */) make the push/pop symmetry easier to check at a
glance?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28510424881
--===============4787310242088628169==--
