Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF4285CB9;
	Tue, 15 Sep 2026 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441992; cv=none; b=nCELsmXUANPKk3ucPM/o2OdzYgmtgvDp/z53RB3S1wCAcoIxFUo/4GQ/qZmit+GtluKpvLqe6Q7WMN4FbPtSeXRS8tLmUTyoXcMjFjw8DyeO7puHYc7XRF0cJflWYPzuVIizkXZeVeXPWiqfy5o1Vlw1rUknN6tsYR8gXsOfDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441992; c=relaxed/simple;
	bh=9spURXFnhUEOE6ectUrU4Mx+hFIK7BnXqVFjIwIadHw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ii+14vV8ZhRJ58G0LMc2DezSQ+WDGq8eSJYih1hbjvsATmVhjNxMkO+fkv0Kp9MbqOSyprcBlYpIbQzIZKdE7HieZro6gwLVXWJHXvGRRuKg1aUeTbB5JFfoPLIrU1dArm4xsFmXiD6nwMd0rAfHnNd+6y6W6iEtYx83jCtGJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsMgusAH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsMgusAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24B01F000FF;
	Tue, 15 Sep 2026 03:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789441990;
	bh=ViR8JggVtC0w9yFDIbiooQtd0VS8UfWsVm77wUEmMEc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JsMgusAHOEvg6C2ux+VTY/a7sJAb9fLBvB9I3pP8WvnczISFiy7+SMd0JoY7d+A36
	 46FkVNzWR9uSBsrQyKXCD/7IcNExqo4c4roCQchC0gGcbzJ7rynqD7H+DgWyFyRV0B
	 FSnuwhguUspI86R9oPiossrmeBfLVYe6DdPYhahdzMoBV97+D/QOuCfoJia2Z4LsGP
	 RCnQekEVLJ1UxFrEM37ZolP2U5WLWHKDbEu4+8lIVqwKSCOoKBZKwzBn+P3Bhdv8FO
	 5R2CBl3IfnAd3/9doQ1lsIBjEqkdUPi6UuYtp4sD+OkDk4aYNkELJ0i3IIc3w+JtBL
	 JVuL657MHQj6w==
Content-Type: multipart/mixed; boundary="===============0010365477308784097=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <491fb0b335c0814e914b3d041b8cee9fda122c37567bd20e456fd3758fb51568@mail.kernel.org>
In-Reply-To: <20260915022905.1535566-3-main.kalliope@gmail.com>
References: <20260915022905.1535566-3-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc32 JIT
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,James.Bottomley@HansenPartnership.com,deller@gmx.de
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-parisc@vger.kernel.org,linux-kernel@vger.kernel.org,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 03:13:09 +0000 (UTC)

--===============0010365477308784097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 78e60eb41cf96a6559947f9582f1a6e1e10551af
> Author: Nicholas Dudar <main.kalliope@gmail.com>
>
>     bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc32 JIT
>
>     emit_alu_r32() and emit_alu_r64() call the unsigned millicode
>     ($$divU/$$remU) and libgcc-style (hppa_div64()/hppa_div64_rem())
>     divide/remainder helpers for BPF_DIV and BPF_MOD regardless of the
>     BPF instruction's signedness, so the parisc32 JIT does not implement
>     signed BPF_SDIV and BPF_SMOD (off == 1). Signed ALU32 and ALU64
>     div/mod get an unsigned quotient and remainder rather than the
>     verifier's and the interpreter's signed result for negative operands.
>
>     Thread is_signed = (insn->off == 1) through emit_alu_r32()/
>     emit_alu_r64(), and on the signed path use the $$divI/$$remI signed
>     millicode routines (32-bit) or the hppa_sdiv64()/hppa_sdiv64_rem()
>     helpers added in patch 1 (64-bit) instead of their unsigned
>     counterparts. $$divI and $$remI are extern-declared and exported next
>     to $$divU/$$remU in arch/parisc/kernel/parisc_ksyms.c.
>     bpf_do_misc_fixups() rewrites the zero-divisor and INT_MIN/-1 cases out
>     of the instruction stream before the JIT runs.
>
>     Acked-by: Helge Deller <deller@gmx.de>
>     Tested-by: Helge Deller <deller@gmx.de>
>     Assisted-by: Claude:claude-opus-4-8
>     Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>

This looks like a bug fix for the parisc32 JIT's handling of signed
division and modulo operations. Should this include a Fixes: tag?

  Fixes: 847b98421362 ("adding ci files")

This isn't a bug, but would it be worth naming the sibling commit (or
saying "the previous patch") instead of "patch 1" here, so the reference
still makes sense once the series is applied?

>     helpers added in patch 1 (64-bit) instead of their unsigned

The "patch 1" reference is only resolvable while the series is on the
list. Once the commits land, git history has no "patch 1" for later
readers or anyone doing archaeology on this code.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34922459599
--===============0010365477308784097==--
