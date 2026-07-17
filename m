Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88E3914FD;
	Fri, 17 Jul 2026 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317946; cv=none; b=kWdS2z1BWIHUz/+YzkcRNezRbOa6EEDIpkKagSD2le9i/Xbp7/UAOzosdh0BXXgRq227VqIQoDq4a7nCxExPqwG7M3GlAr0iKWwogt2+rJx9AsuuLxgunAli88Zyj13Vhs0Bj3kaswCYRiesrTb1IXD+A5znPRaj+YWORu6m0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317946; c=relaxed/simple;
	bh=rrspSGehfKYKSnQ3rbmXPCsQVH+cgD7MP5a6ioOOlXw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sYHq7SOvV9HLawWH9CvPfTGYmvl18638TpTUSyFp0tGQI/MnjxZ5wNvbsJJxyf6x+MUhEOe62lDwViB5fLf3JYm1M8YkscAU8cx4PdymN+GnZpSAdnbIhbXdL1j2YVuyKxYcWCtb/KwCzsCzVAG787Wp0HLF92uhAP12/eDKQKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMkXlI4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMkXlI4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA541F000E9;
	Fri, 17 Jul 2026 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784317945;
	bh=c2c+nCQRFnQzMGUEwe4sVdtFvea3M+zacbG58Luv/FA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bMkXlI4NHqtCOwMGFqOAzBphoOETmxMwLgPLrB0oMUt9QrbI/GCU64H/UQZJAobg3
	 ECILpixnlncYUDdSe1k9Z3c9NkOQgknOPDXdqeaUdyRN9xyh66n+YbwxzOI6RbbScz
	 tRW5kMZxobaTO+cH7eQLUI1rzroNy+Ov08rog0d1kr5T+IMwgTPnbaZj+61u0GmrDs
	 C4/Bca6VSpjAm4jFuQ9mb/a1l0RuSq/5nFDnASdgnNHeFrUac84D+bfPJMlTETw55c
	 jTm0crkllI8iHAvJpul5aFYa1UXG+7g66Bc0ADVMKQUPPuO6NYzb5VueDbBDeJbZN0
	 8FjN0KHI7eyAA==
Content-Type: multipart/mixed; boundary="===============7499260634970125321=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <730b11181226fe2aa47c5add541431bb8bd4b4fa6af6e3b41bd8a09161d2f51c@mail.kernel.org>
In-Reply-To: <20260717190544.257306-2-main.kalliope@gmail.com>
References: <20260717190544.257306-2-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc64 JIT
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,deller@gmx.de,James.Bottomley@HansenPartnership.com
Cc: bpf@vger.kernel.org,linux-parisc@vger.kernel.org,linux-kernel@vger.kernel.org,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Jul 2026 19:52:25 +0000 (UTC)

--===============7499260634970125321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> emit_call_libgcc_ll() zero-extends the ALU32 operands and calls the
> unsigned hppa_div64()/hppa_div64_rem() helpers regardless of the BPF
> instruction's signedness, so the parisc64 JIT does not implement
> signed BPF_SDIV and BPF_SMOD (off == 1). Signed ALU32 and ALU64
> div/mod get an unsigned quotient and remainder rather than the
> verifier's and the interpreter's signed result for negative operands.
>
> Add hppa_sdiv64()/hppa_sdiv64_rem() wrapping div64_s64(), thread
> is_signed = (insn->off == 1) through the div/mod emit sites, and on the
> signed path sign-extend the ALU32 operands (and the immediate divisor)
> instead of zero-extending them before calling the signed helpers.
> bpf_do_misc_fixups() rewrites the zero-divisor and INT_MIN/-1 cases out
> of the instruction stream before the JIT runs.
>
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>

This looks like a fix for a correctness bug that has been present since
the parisc64 eBPF JIT was first added, where signed div/mod produced an
unsigned result for negative operands.

Should this carry a Fixes: tag?

  Fixes: c95e269773b3 ("parisc: Add 64-bit eBPF JIT compiler")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29607384764
--===============7499260634970125321==--
