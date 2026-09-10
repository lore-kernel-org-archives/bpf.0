Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7F49E158
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079599; cv=none; b=YtGmbKfQKuHeen4VACp5bJ6w8wBUARdu1OOHuO8BayFTxmJU6f3ibeqSeHKscTKyGYMUXq20cwW7P49Vr4EHTokI31yb3f49E4aTPZrd3RXyV+UjLTaSy2THVS0LjzOz2/+GfiYLVt8nud5X5fJMKjraoUr4Kx2i+tmSzs7TDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079599; c=relaxed/simple;
	bh=nE4YzJPBvXC2xF72Ej6BeUc96QFQgir7K9+nPVy/U4o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EO1oJ78GmLBJzmiBHhPMvLg7Or0VEiDhbs1C14LnyH3U0a8Cg5gMPRJNdD23umt1uDc0yrj3hvE4llseNLn0qrA4A8Dj055MJS/+jHzmXr92WCyt78BAplaHCmxZ/qkcM21GZUGNOleabPSGZwBzqmrA7H+kXibcAwxm7Jhs4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFSyj3Bc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFSyj3Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05F81F000FF;
	Thu, 10 Sep 2026 22:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789079597;
	bh=CU/b3tvTmFlqFI0K0MY3DjCLpUkAuh/ygzMUSspEBIk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SFSyj3BczWHh5AWZbLJNvG7uWvl0Dd7n0TuobjPHOU4/2BIJ2Rc9Y1gEreVwT3vbw
	 SM1r5V8qOszAf2qSyrDNjidzZWdBNVB/EJTu1yGmxWeiBoLajpYJIxqf6wbzuUPQ2K
	 u8WGB7A6x23SBRbEvpeYnGZVY1HT1FwwmZq+NfDtQ3HlaN7juKHEuQXto7sArPdtXs
	 BMrJE7qNk0bgSTyJNG1x2ieBkMeLfJGyflMaUv7hSthctnRh7j9/GOrrfcpPIfwQRn
	 G50XUPf+8OrlY19A5urAkB0VNlhlCzrV3Qp5xfFuYHESGsGdrZkkWsnvq58w9vhclx
	 sa3qOUN5mDWAA==
Content-Type: multipart/mixed; boundary="===============6653278619955552026=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ff35c7a25baaa4167d7440342358e90b18a30ac12136354dd42a4f0a0623b1ff@mail.kernel.org>
In-Reply-To: <20260910213510.49358-4-daniel@iogearbox.net>
References: <20260910213510.49358-4-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Add tests for the KF_PERFMON gates
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 22:33:16 +0000 (UTC)

--===============6653278619955552026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for the KF_PERFMON gates
>
> Add test cases where each one loads with CAP_BPF alone and checks that
> the program is correctly rejected.
>
>   # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_kfunc_perfmon
>   [...]
>   #627/1   verifier_kfunc_perfmon/rdonly_cast_noperfmon:OK
>   #627/2   verifier_kfunc_perfmon/rdonly_cast_noperfmon @unpriv:OK
>   #627/3   verifier_kfunc_perfmon/probe_read_kernel_dynptr_noperfmon:OK
>   #627/4   verifier_kfunc_perfmon/probe_read_kernel_dynptr_noperfmon @unpriv:OK
>   #627/5   verifier_kfunc_perfmon/stream_vprintk_noperfmon:OK
>   #627/6   verifier_kfunc_perfmon/stream_vprintk_noperfmon @unpriv:OK
>   #627/7   verifier_kfunc_perfmon/get_kmem_cache_noperfmon:OK
>   #627/8   verifier_kfunc_perfmon/get_kmem_cache_noperfmon @unpriv:OK
>   #627/9   verifier_kfunc_perfmon/arg_untrusted_read_noperfmon:OK
>   #627/10  verifier_kfunc_perfmon/arg_untrusted_read_noperfmon @unpriv:OK
>   #627     verifier_kfunc_perfmon:OK
>   Summary: 1/10 PASSED, 0 SKIPPED, 0/0 FAILED

This isn't a bug, but would it be worth saying in the changelog which gates
are covered? The changelog describes only the rejection half (CAP_BPF alone
correctly rejects), but each program also carries __success so it asserts
the privileged load still succeeds. The series gates roughly 30 kfuncs plus
one mem-access path, and this new file exercises four kfuncs
(bpf_rdonly_cast, bpf_probe_read_kernel_dynptr, bpf_stream_vprintk,
bpf_get_kmem_cache) and __arg_untrusted read. Could the changelog mention
this coverage, perhaps also adding a stream_print_stack case alongside
stream_vprintk_noperfmon since it sits in the same helpers.c hunk with the
same flags?

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index 64ac49ad67e6..ec9e3907c75d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -53,6 +53,7 @@
>  #include "verifier_iterating_callbacks.skel.h"
>  #include "verifier_jeq_infer_not_null.skel.h"
>  #include "verifier_jit_convergence.skel.h"
> +#include "verifier_kfunc_perfmon.skel.h"
>  #include "verifier_ld_ind.skel.h"
>  #include "verifier_ldsx.skel.h"
>  #include "verifier_leak_ptr.skel.h"
> @@ -216,6 +217,7 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
>  void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
>  void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
>  void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
> +void test_verifier_kfunc_perfmon(void)        { RUN(verifier_kfunc_perfmon); }
>  void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
>  void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
>  void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_perfmon.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_perfmon.c
> new file mode 100644
> index 000000000000..76c39ef30e96
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_perfmon.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +void *user_ptr;
> +char dynptr_buf[8];
> +u64 kaddr;
> +
> +extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym;
> +
> +SEC("socket")
> +__success
> +__caps_unpriv(CAP_BPF)
> +__failure_unpriv
> +__msg_unpriv("bpf_rdonly_cast is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
> +int rdonly_cast_noperfmon(void *ctx)
> +{
> +	char *p = bpf_rdonly_cast(0, 0);
> +
> +	return p[0x7fff];
> +}
> +
> +SEC("socket")
> +__success
> +__caps_unpriv(CAP_BPF)
> +__failure_unpriv
> +__msg_unpriv("bpf_probe_read_kernel_dynptr is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
> +int probe_read_kernel_dynptr_noperfmon(void *ctx)
> +{
> +	struct bpf_dynptr dptr;
> +
> +	bpf_dynptr_from_mem(dynptr_buf, sizeof(dynptr_buf), 0, &dptr);
> +	bpf_probe_read_kernel_dynptr(&dptr, 0, sizeof(dynptr_buf), user_ptr);
> +	return 0;
> +}

This isn't a bug, but could probe_read_kernel_dynptr_noperfmon() use kaddr
(or a separate kernel-address global) rather than user_ptr? The same file
already uses kaddr for the other two kernel-address kfuncs
(stream_vprintk_noperfmon and get_kmem_cache_noperfmon). A kernel-read
kfunc taking an argument named user_ptr inverts the meaning of the name.
This doesn't affect the test outcome since the KF_PERFMON check fires before
any argument is validated, but it makes the case harder to read.

> +
> +SEC("socket")
> +__success
> +__caps_unpriv(CAP_BPF)
> +__failure_unpriv
> +__msg_unpriv("bpf_stream_vprintk is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
> +int stream_vprintk_noperfmon(void *ctx)
> +{
> +	bpf_stream_printk(BPF_STDOUT, "%pB", (void *)kaddr);
> +	return 0;
> +}
> +
> +SEC("socket")
> +__success
> +__caps_unpriv(CAP_BPF)
> +__failure_unpriv
> +__msg_unpriv("bpf_get_kmem_cache is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
> +int get_kmem_cache_noperfmon(void *ctx)
> +{
> +	return !!bpf_get_kmem_cache(kaddr);
> +}
> +
> +__weak int subprog_untrusted_read(void *p __arg_untrusted)
> +{
> +	return *(char *)p;
> +}
> +
> +SEC("socket")
> +__success
> +__caps_unpriv(CAP_BPF)
> +__failure_unpriv
> +__msg_unpriv("rdonly_untrusted_mem access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
> +int arg_untrusted_read_noperfmon(void *ctx)
> +{
> +	return subprog_untrusted_read(0);
> +}
> +
> +char _license[] SEC("license") = "GPL";

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34534885787
--===============6653278619955552026==--
