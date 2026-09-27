Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF263932EE
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541603; cv=none; b=USqJhK2a/rBMfR88DPBmM2wwVpL1VwJJ8jmFwgpP7dKhGINW8YiCY9vnhqwZoDV4z+P4ddZBkl8zjknBBS+jirlFtivid5KJ6xBFUbzhABMrUOND+ZrxE2yYOGgpGPMtAxz0Og/xUU7vciUsyNFAK7VCMYant6nmgHJrqMKqwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541603; c=relaxed/simple;
	bh=Io7j8Hd2jTvBD8xOG6K59R2rZXxhKLKMNVoGekR2wcU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iKWQOc922FJ1UcbAhhRq/33hkLdPBlnk89UsdRkzVKGCd1vXh8BWH+aOLGsKupNZxaXP9QNmUihYCFXg1v2sgm+IgsQ6mhsM/oPJPA02yi2wsy2NEEpq3+/lw9td0mKJQlb7QW4WqGPLrdJrLNsC8O4VzlP2d2oOKnUIte/+3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr3LjZK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr3LjZK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062461F000FF;
	Sun, 27 Sep 2026 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541602;
	bh=kHj9Khx4g8kZYWltADlCr/P8RFPdYgBQmPnANrxMvvM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Kr3LjZK4HPyenPFSVu+FPuakbaY8zznXS3kVOs/2RJ0CpiRqggLZMpd6HiVXyeCaU
	 dlRzDEZFnxvqzAFfGDzmbjdkGK9ihwi/iqOqBnRd5Mu49IU/7TGaUq9JoRHdKcP1au
	 w9Lq22OL+GARuGVUj2vwBwfz371IY2PfeiCsk9PD60hbcOPzk6F46+joft2dHjGUQ2
	 7P3F9JJEEwVbuQ2RwE9DjOSP82jDfNia4KNBCyTHoHtAj2KBrem1kxD2i+FV4YIH8O
	 InbWyIKqTnb+H5b+KtiaJ2MXRQQCAZEvBXk2jxyv2tAX1j8DTbHfTMkq5acJtCRUeF
	 ude9FP56wljQg==
Content-Type: multipart/mixed; boundary="===============1462799085225289243=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c23637cc1ccedfd0f1487b3a623608ca1356f4569c8bb5d0bd91a59c2a30cff@mail.kernel.org>
In-Reply-To: <20260926050148.2222810-1-yonghong.song@linux.dev>
References: <20260926050148.2222810-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 20/21] selftests/bpf: Cover the exception cleanup shapes the chain does not reach
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:40:01 +0000 (UTC)

--===============1462799085225289243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/testing/selftests/bpf/exceptions_cleanup.h
> index d1d40314035e..49b6806cde82 100644
> --- a/tools/testing/selftests/bpf/exceptions_cleanup.h
> +++ b/tools/testing/selftests/bpf/exceptions_cleanup.h

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> new file mode 100644
> index 000000000000..37a78e035a50
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> @@ -0,0 +1,665 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "exceptions_cleanup.h"

[ ... ]

> +/* The callee most of the shapes below unwind out of. */
> +static __used __noinline __u64 pc_unwinder(__u64 x)
> +{
> +	if (x > 100)
> +		bpf_unwind();
> +	return x + 1;
> +}

[ ... ]

> +/* A callee on both a covered and an uncovered call: the pad is the site's. */
> +static __used __noinline __u64 shared_callee(__u64 x)
> +{
> +	if (x > 100)
> +		bpf_unwind();
> +	return x + 1;
> +}

This isn't a bug, but shared_callee() looks the same as pc_unwinder().
Could the shared-callee shape call pc_unwinder() from both sites, or
could wide_rec_frame() use pc_unwinder() so that shared_callee() is left
to the one shape its comment describes? And should the 'most of the
shapes' comment on pc_unwinder() be narrowed to match its three callers?

[ ... ]

> +/*
> + * A covered bpf_unwind() the sweep leaves last, behind the exception callback
> + * patchlet, which has to carry the marks with it.
> + */
> +SEC("?syscall")
> +__success __set_global(input, 101) __retval(0)
> +__ret_global(pads_ran, RAN_PAD_FIRST)
> +__naked int entry_pad_first(void)
> +{

This isn't a bug, but is 'exception callback patchlet' meant to be the
exit that bpf_exc_keep_exits() puts back after bpf_unwind()? If so,
could the comment name that instead? This program never sets up an
exception callback.

[ ... ]

> +/* A pad that indexes its frame by a register set before the unwinding call. */
> +
> +/* An unwinder that touches none of r6-r9, so the walk leaves this frame. */
> +static __used __naked __noinline __u64 var_unwinder(void)
> +{
> +	asm volatile (
> +	"if r1 < 101 goto 1f;"
> +	"call bpf_unwind;"
> +"1:"
> +	"r0 = 0;"
> +	"exit;"
> +	::: __clobber_all);
> +}
> +
> +static __used __naked __noinline __u64 var_stack_frame(void)
> +{
> +	asm volatile (
> +	"r1 = %[magic] ll;"
> +	"r1 = *(u64 *)(r1 + 0);"
> +	"*(u64 *)(r10 - 8) = r1;"	/* the slot the pad will read... */
> +	"*(u64 *)(r10 - 16) = r1;"	/* ...whichever of the two it is */
> +	"r1 = %[input] ll;"
> +	"r6 = *(u64 *)(r1 + 0);"
> +	"r6 &= 1;"			/* an unknown slot number... */
> +	"r6 <<= 3;"			/* ...as an aligned byte offset */
> +	"r1 = %[input] ll;"
> +	"r1 = *(u64 *)(r1 + 0);"
> +"1:"	"call var_unwinder;"		/* cleanup region */
> +"2:"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"r7 = r0;"
> +	"r1 = r10;"
> +	"r1 += r6;"			/* variable offset into the frame */
> +	"r2 = *(u64 *)(r1 - 16);"
> +	"r3 = %[magic] ll;"
> +	"r3 = *(u64 *)(r3 + 0);"
> +	"if r2 != r3 goto 9f;"
> +	PAD_RAN("%[ran]")
> +"9:"
> +	"r1 = r7;"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	:
> +	: [ran]"i"(RAN_VAR_STACK), __imm_addr(input), __imm_addr(magic),
> +	  __imm_addr(pads_ran)
> +	: __clobber_all);
> +}

[ ... ]

> +/* The same over a global subprogram, which the verifier enters no frame for. */
> +__noinline __u64 global_unwinder(__u64 x)
> +{
> +	if (x > 100)
> +		bpf_unwind();
> +	return x + 1;
> +}
> +
> +static __used __naked __noinline __u64 global_pad_frame(void)
> +{
> +	asm volatile (
> +	"r1 = %[magic] ll;"
> +	"r1 = *(u64 *)(r1 + 0);"
> +	"*(u64 *)(r10 - 8) = r1;"
> +	"*(u64 *)(r10 - 16) = r1;"
> +	"r1 = %[input] ll;"
> +	"r6 = *(u64 *)(r1 + 0);"
> +	"r6 &= 1;"
> +	"r6 <<= 3;"
> +	"r1 = %[input] ll;"
> +	"r1 = *(u64 *)(r1 + 0);"
> +"1:"	"call global_unwinder;"		/* cleanup region */
> +"2:"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"r7 = r0;"
> +	"r1 = r10;"
> +	"r1 += r6;"
> +	"r2 = *(u64 *)(r1 - 16);"
> +	"r3 = %[magic] ll;"
> +	"r3 = *(u64 *)(r3 + 0);"
> +	"if r2 != r3 goto 9f;"
> +	PAD_RAN("%[ran]")
> +"9:"
> +	"r1 = r7;"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	:
> +	: [ran]"i"(RAN_GLOBAL_PAD), __imm_addr(input), __imm_addr(magic),
> +	  __imm_addr(pads_ran)
> +	: __clobber_all);
> +}

This isn't a bug, but global_pad_frame() looks nearly identical to
var_stack_frame(), and pad_r0_frame() repeats the same pad body. Could
these share a macro, the way LOAD_MAGIC_REGS/CHECK_MAGIC_REGS are shared
earlier in the file, so each variant only spells out the part it is
testing?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430
--===============1462799085225289243==--
