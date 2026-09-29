Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532793CA4A1
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644484; cv=none; b=G4uCFsitRZ4bsc4scOphAVTkS5S+uFaVDFKYWdVAFAGxTvGPIzrkwQS0c0f4pol92LGx855aV93dkzJWpgmPDzIYPO2dvfBUez3oaEzxYxkXZr4aCYSA97jxiyfUpK+HSW8lrz3G2icZZM+Zos7fWxg4XN5mULWXi+1HME/UNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644484; c=relaxed/simple;
	bh=Yzn6ljfpmAqTzQyTiqJsU4Kbq+J6X0ri5A5/5JuB1vg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nAIzlSYQJ689a7GqEOLVfiZ47m5BhUMH8L00iWM4HeCTq4n73OqZ9gT2PhwmI9YPOixbjJ7RSjwC8svQYwnr+Ivvv0wnNv2cqb1ZiAy+HcnkDTKEezk+zNui9V9BJ0n6yxRVWofFmgZ0iX7l2NuKdfTv1OGtA+H7dlAUj4NJxbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw4pdnNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw4pdnNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ABD1F000FF;
	Tue, 29 Sep 2026 01:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644482;
	bh=Hai8K1hvs0C2ulDEl9UQbYAXLYvG6bYABxEX+u5V//0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Kw4pdnNwEI3CKAyXdE2skq2ZEt5x87RYRQ6k5T9PJ8eYamZ4wfQoDbSBBh2VAwTyM
	 X1m7o/oVBsG3nkDxPrYoGh//dl4d/Guu0QAW6H4JCuePA56MBb62Fr41ycdxxARt3a
	 QSvKzzquzZ7D/4cyaMzTJ/Nkh3jzGdL1vJicVI9BhFeLwfISmhwnu1l70Q4M/s8Jzn
	 BZJrjbNQZ7ytPearpKMX/lBZqBpIkWolconoLbQIb4SyrXbD33vwZzD8zGagQGjTEP
	 o/y+EmqmPDSYHkMTqnxfHoRMfMKkAZf6W/6H3dP/SfHWxXM/EdWeIMHJah+mBl20Ft
	 4tLUWjafQql0w==
Content-Type: multipart/mixed; boundary="===============1483874617242212674=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b205a4413229ec7b21d7ec94d0e97a9824725f1c75da88a04f31e48c72daacfa@mail.kernel.org>
In-Reply-To: <20260929001709.3252802-1-yonghong.song@linux.dev>
References: <20260929001709.3252802-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v7 13/22] bpf, arm64: Dispatch exception cleanup pads at run time
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 01:14:42 +0000 (UTC)

--===============1483874617242212674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 3ebcf8c53fb0..1e46a22cafbd 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -445,6 +445,109 @@ noinline noinstr void arch_bpf_stack_walk(bool (*consume_entry)(void *cookie, u6
>  	kunwind_stack_walk(arch_bpf_unwind_consume_entry, &data, current, NULL);
>  }
>
> +struct bpf_unwind_ra_consume_entry_data {
> +	bool (*consume_entry)(void *cookie, u64 ip, u64 sp, u64 fp, u64 *ra);
> +	void *cookie;
> +	unsigned long record;
> +	bool seen_first;
> +};
> +
> +static u64 bpf_unwind_sign_ra(u64 ra, u64 modifier)
> +{
> +	asm volatile(ARM64_ASM_PREAMBLE
> +		     ".arch_extension pauth\n"
> +		     "	pacia %0, %1"
> +		     : "+r" (ra) : "r" (modifier));
> +	return ra;
> +}
> +
> +/*
> + * PACIASP's modifier is the stack pointer the owner was entered with: record
> + * + 16 for a BPF prologue, but further up for bpf_unwind()'s own C frame.
> + * Recognise it by re-signing @pc, which the unwinder stripped from @stored.
> + */
> +static bool bpf_unwind_ra_modifier(unsigned long record, unsigned long caller_fp,
> +				   u64 stored, u64 pc, u64 *modifier)
> +{
> +	u64 m;
> +
> +	for (m = record + sizeof(struct frame_record); m <= caller_fp; m += 16) {
> +		if (bpf_unwind_sign_ra(pc, m) == stored) {
> +			*modifier = m;
> +			return true;
> +		}
> +	}
> +	return false;
> +}

Can this loop find the wrong modifier for bpf_unwind()'s own frame?

The search takes the first candidate whose PAC matches. With
CONFIG_ARM64_PTR_AUTH_KERNEL, the PAC field is quite short: roughly 15 bits
with 48-bit VA, 11 bits with 52-bit VA, and only 7 bits when TBI is enabled
for KASAN tag-based modes.

For JIT frames, the true modifier is always record+16 (the prologue does
paciasp then 'stp x29, lr, [sp, #-16]!'), so they always match correctly on
the first try.

But when bpf_unwind()'s own C frame is being rewritten (which happens when
the BPF frame that called bpf_unwind() has a pad covering the call), the
compiler might place the frame record at a different offset. For example,
with the traditional GCC aarch64 layout that puts locals above the frame
record, and bpf_unwind() has a stack local (ctx) whose address is taken, the
entry SP would be record+32 rather than record+16.

The loop would then try record+16 first. If PAC(pc, record+16) happens to
equal PAC(pc, record+32) for the current task's APIA key, it returns the
wrong modifier. With a 7-bit PAC (KASAN tag-based), that's roughly a 1/128
chance per key.

When autiasp runs in bpf_unwind()'s epilogue, the authentication would fail.
With FEAT_FPAC this faults immediately; otherwise ret faults on the poisoned
LR.

The code has no ambiguity check and never derives the frame's actual entry
SP. Could the search either verify there's exactly one matching candidate,
or derive bpf_unwind()'s true entry SP directly rather than guessing?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904
--===============1483874617242212674==--
