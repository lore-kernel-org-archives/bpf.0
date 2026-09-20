Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315F37DAD0
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885914; cv=none; b=mhX+q1lVmfIWfZKvZHyPc1GRV71uG9ygyIdfI7V9FBwvgQGrrl+VdJAL6UyPXOktDGGeJVId/uGw/+bVWRel3aBb7P+pj4nbMtUttGFhMlJquRfn9TJXg/mmkVaQFc/X3tGbySkkWxj+FyGSUD/abb10KQnr0rCFrKqzBqvpOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885914; c=relaxed/simple;
	bh=XJzr7srircKro/MNIQ0NR05Qx6gBqk9hZvJ5AnVj7hk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ewEYWtqBz/NX0g0i7np7ZQYvjffdVrpK7788S1ccG5pZ7SQGHea2UgHgAVekR8/LLNLtd5D3ZFeBNds95VAQ13xq3PxMjx8OLQoPAS8wA2Koe1KtbiHFUzdB8PLCuxU/3tV4rN2lBFvaparr0KelsPWGusXzgVuJm/iy1LBkIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2skwc9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2skwc9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329E71F000FF;
	Sun, 20 Sep 2026 06:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789885912;
	bh=AvNBKE6y7blsvEyKiSkSbVwEyCh76UAL4tpTf1WJ62A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l2skwc9OsQ/Aj4C41Bp0xCGQs9pw3Z0ogaGu62zAT/YJJgn4kDDHg3xJtmNeNbDoX
	 VfXBoy40CAKikaCfq/IwYuR2r0Pv24EGkcymalDPL81lDK8E3Pe2Eprwaf6XZtrdW8
	 zYRo6ufwvW1rJgchEiJcU1TAqUE2+kmFZncXXkMYM9UVr8hR0rqECmV6yoXCbFM4Nu
	 oRAx46Nu5UH9003lYfDQhbkj+gNe1L1dC3MpoNEyTbluMOQV+Pz0Ny6ipg0suDfexV
	 0QwACvdHU68WrGwz3BisPs0o8uHGkXN7JtyzhEFGFgdXeo009+n9OUPERNpqYLF8yH
	 a7S+PUebKxzfg==
Content-Type: multipart/mixed; boundary="===============4972820713869885235=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a956e774692a94a2926fb953553f546ab0293fca13f6d021bc3d75e89752bcf9@mail.kernel.org>
In-Reply-To: <20260920054408.875401-1-yonghong.song@linux.dev>
References: <20260920054408.875401-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 20/20] selftests/bpf: Load an exception cleanup program from a light skeleton
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 06:31:51 +0000 (UTC)

--===============4972820713869885235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 7ea5ba1df29e..981cc2643049 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -523,7 +523,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
>  LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
>  	core_kern.c core_kern_overflow.c test_ringbuf.c			\
>  	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> -	test_ringbuf_overwrite.c
> +	test_ringbuf_overwrite.c exceptions_cleanup_light.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c
> new file mode 100644
> index 000000000000..de7ae478d67f
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
> +	bpf_preempt_disable();
> +	bpf_preempt_enable();
> +	bpf_unwind_resume();
> +}

Are the kfunc declarations in scope here? The file includes only
<vmlinux.h>, <bpf/bpf_helpers.h>, "bpf_misc.h", and
"exceptions_cleanup.h".

bpf_throw(), bpf_preempt_disable(), and bpf_preempt_enable() are
normally declared with __ksym in tools/testing/selftests/bpf/
bpf_experimental.h, which is not included. bpf_unwind_resume() has no
declaration in any userspace header in the tree.

Without __ksym == __attribute__((section(".ksyms"))), these become
implicit function declarations, and libbpf's bpf_object__collect_externs()
will reject any extern not in a ".ksyms" DATASEC when it tries to
relocate the calls in the inline asm below.

The __kfunc_btf_anchor() function exists specifically to produce extern
BTF FUNCs that libbpf can relocate for the 'call bpf_throw' and
'call bpf_unwind_resume' sites in the inline asm. If the declarations
are implicit, either the compile fails or bpftool rejects the object when
generating the light skeleton.

Should this file include "bpf_experimental.h" and add a declaration for
bpf_unwind_resume()? The identical pattern appears in
progs/exceptions_cleanup.c, progs/exceptions_cleanup_shapes.c, and
progs/exceptions_cleanup_ext_table.c from earlier commits in this series,
so the fix may need to be series-wide.

> +
> +__u64 pads_ran = 0;
> +
> +SEC("syscall")
> +__naked int entry_light(void)
> +{
> +	asm volatile (
> +	"call bpf_preempt_disable;"
> +	"r1 = %[cookie];"
> +"1:"	"call bpf_throw;"		/* cleanup region */
> +"2:"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"call bpf_preempt_enable;"
> +	PAD_RAN("%[ran]")
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	:
> +	: [cookie]"i"(THROW_COOKIE), [ran]"i"(RAN_LIGHT),
> +	  __imm_addr(pads_ran)
> +	: __clobber_all);
> +}
> +
> +char _license[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538
--===============4972820713869885235==--
