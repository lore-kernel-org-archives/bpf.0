Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DD332EC8
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643171; cv=none; b=lkk8Hh+cianhbeOnB+HpZsprQz7HbfLLyuPfsFI3zps5jbytuySU9x/IWZmbzMKaMj9q5SiaHWTuW7uVNjcYyxdOi+I/ysnv+IgGKN68alcQ0jmQldfE+nkzyHdjeBQhp3NhN4qGbVonTah8q/McE6l5Nu5AzlSy3cdbLXPxd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643171; c=relaxed/simple;
	bh=/yKZRGH4+GpAIrGagjYBNzBFjSGCfw/Tqe59C63TFBc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IlCvYNdVvDDpZds002CHZTfuwhkDKrvvwJeluPloxuxnWfHSHOZJSm1+MNDdwqaIYtxeXYNguZwPwnJf4YBxLpBXklZpbefmZxT3b+R7My/RATSvU7Rx7BHAb77S7Xd7My618iiG934Tritfuh53jKrIhxH6rbJ2yS0FOEkrRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfTh1uaL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfTh1uaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D711F000FF;
	Tue, 29 Sep 2026 00:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790643168;
	bh=MitsnVF3Q90/4xJPKe2+OJGBP0gvZiFinx+Odu9ya30=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NfTh1uaLgSAOgFwBVTCdF0Fu6MYH4OcspefJZGWMk66idk/p3sjr60e+Ot1HvOwYr
	 pEhVgRqhEI0dSWeY2oHpBU8GuB1Y4HGtgeOf9Zp5+Ox95DGu8iLXfqHY9zy9Psf/W6
	 UrstckpzrBIhwauRKl64HqahkUBUhEinFjijKoJC1bddXPhtM7WUlYTW2reRj8PmoZ
	 jk791Wl/pMyeVMSgaSDxW4MO86QSvJYyjhN5nPK/lwjGBeZcJKvcoQabGW7V8uRxh9
	 5Wvb75cCDtaImmAJQXeegumosdChR7RZdNTZTqgPS590zc+NtBHcjO7bWNsMkEHJq9
	 NEz+18BRUyQOw==
Content-Type: multipart/mixed; boundary="===============1641852687631582221=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <914df2aac52c3769cc5e0a433e8b6e792fec9288034f80af7b23a75e6568cce2@mail.kernel.org>
In-Reply-To: <20260929001757.3256926-1-yonghong.song@linux.dev>
References: <20260929001757.3256926-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v7 22/22] selftests/bpf: Load an exception cleanup program from a light skeleton
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 00:52:47 +0000 (UTC)

--===============1641852687631582221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
> index 2e22bb901bf3..41575e180efb 100644
> --- a/tools/testing/selftests/bpf/Makefile.skel
> +++ b/tools/testing/selftests/bpf/Makefile.skel
> @@ -33,7 +33,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
>  LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
>  	core_kern.c core_kern_overflow.c test_ringbuf.c			\
>  	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> -	test_ringbuf_overwrite.c callx_rodata.c
> +	test_ringbuf_overwrite.c callx_rodata.c exceptions_cleanup_light.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c
> new file mode 100644
> index 000000000000..19d53569bbda
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "exceptions_cleanup.h"
> +
> +static __used __noinline void __kfunc_btf_anchor(void)
> +{
> +	bpf_throw(0);
> +	bpf_unwind();
> +	bpf_preempt_disable();
> +	bpf_preempt_enable();
> +	bpf_unwind_resume(NULL);
> +}
> +
> +__u64 pads_ran = 0;
> +
> +SEC("syscall")
> +__naked int entry_light(void)
> +{
> +	asm volatile (
> +	"call bpf_preempt_disable;"
> +"1:"	"call bpf_unwind;"		/* cleanup region */
> +"2:"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"call bpf_preempt_enable;"
> +	PAD_RAN("%[ran]")
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	:
> +	: [ran]"i"(RAN_LIGHT),
> +	  __imm_addr(pads_ran)
> +	: __clobber_all);
> +}
> +
> +char _license[] SEC("license") = "GPL";

A subsystem pattern flags this as potentially concerning:

This adds a new BPF program file to test loading a cleanup table through
the light skeleton path. The commit message states this is the smallest
program that can verify whether the table survives the trip through
bpf_gen__prog_load().

However, progs/exceptions_cleanup.c already covers the same behavior
more broadly - pads run on unwind and set bits in pads_ran. Makefile.skel
already has LSKELS_EXTRA for building programs as both light skeleton
and libbpf skeleton. Could exceptions_cleanup.c be built as a light
skeleton and have the existing test cases (no_unwind, unwind_from_foo3,
unwind_from_foo2) run through the gen loader path?

That approach would also exercise the light skeleton code paths this new
program never reaches. The new program has only one record in the main
function, so in bpf_prog_collect_cleanup_info() it takes the owner == prog
branch. The owner->sub_insn_off rebasing for records inside appended
subprograms, and the multi-frame bpf_unwind_rewrite() walk, would not run
under the gen loader with this minimal test.

Should this be a light-skeleton case of the existing exceptions_cleanup.c
instead of a separate file?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904
--===============1641852687631582221==--
