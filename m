Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ADD27144B
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789395; cv=none; b=sPrkfYtlGWkJumiwyWlJMUwz3lH9Mv+/rwlPMTtUgQ/cH+aEhpBC2NJL3CVGpPKHMwPEBQZUmJGokAQTkQo6wVsVUM7CpHo9GxK4nJagTeVRAAGtTnPHicYjukKyU57YFVapnMHuXEZe1qDrAptBd0g4fE86Bvf8GbSMo/nDoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789395; c=relaxed/simple;
	bh=wmAT7oOP/vwT9mP/MZRJBXWOiCFdYiaRXlaxXIF3x48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZDN3kSy7HYsMIsNg9TiMFHGZhzPcI3ysAiD2mzOhIFo4PyQvyikixtLWhtTYhKfXFu7J+Z1owmaJrhQvaoyMIWrtElJBUiWL7oKDROkMQsI6bBK61n6g7LFja66FjVkiE1EFWj+npJS1dI+2kRDY8f4wSpPBGimRuIXilqrL66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vewvwlvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vewvwlvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE7C1F000E9;
	Tue, 30 Jun 2026 03:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782789393;
	bh=+gSbod73Sq2w7PYR2N+ds4nQeqsp0uMSvca5Of9moic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vewvwlvg8+Uz/5ZVt+sZnQFx4qEqf+iZmpwmRtXhlwut+6e43SlY/rimhBRps/B6t
	 dG22DYHN0/lBvmzwZdbb0WSzw57NR/48umJri+eTx7JACBkCrTNtwFGZ4GVAEo3OXO
	 EoVH1gIqL84udExEVtL1ud0ONluDh4F7BjWgOgqKC+7FOYHs0VqCwxF4LAt8sFCbAV
	 AQ1SgJNQX2lvclFROUM1ISBHY4RbjrtK8iq+tcBvkTr5x+uHLd680EbmHGTzz9mFcn
	 9L4QjfIjU91THNCEIhoJQ0vXdejkNiIcKp45808rdA/VLk02O1p7gitK683KW8KSq7
	 JvIVOi9kGYPBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Skip libarena when the BPF backend
 lacks 32-bit arena cmpxchg
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630025809.74043-1-dongtai.guo@linux.dev>
References: <20260630025809.74043-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 03:16:33 +0000
Message-Id: <20260630031633.7AE7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch misdiagnoses the root cause of the Clang crash and imple=
ments a workaround that incorrectly skips `libarena` tests instead of fixin=
g the underlying build configuration.

Pre-existing issues:
- [High] The patch fails to apply the new 32-bit cmpxchg guard to the ASAN =
variant of `libarena`, leaving the selftests build vulnerable to the exact =
same compiler crash it attempts to fix.
--

commit e34c5b107c762422f1dc3835420230ecdcd78708
Author: George Guo <guodongtai@kylinos.cn>

selftests/bpf: Skip libarena when the BPF backend lacks 32-bit arena cmpxchg

This patch introduces a feature probe to detect if the BPF backend supports
32-bit arena cmpxchg operations. It skips building libarena and its
dependent tests if the operation is unsupported to prevent build aborts.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b642ee489ea64..0098d892cb39e 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -91,6 +91,17 @@ CLANG_HAS_ARENA_ASAN :=3D $(shell echo 'int x;' | \
>  	-mllvm -asan-shadow-addr-space=3D1 \
>  	-x c -c - -o /dev/null 2>/dev/null && echo 1)
> =20
> +# The arena qspinlock used by libarena performs a 32-bit atomic cmpxchg =
on an
> +# arena (address space 1) pointer. Not every LLVM BPF backend can select=
 it;
> +# older releases bail out with "unsupported atomic operation, please use=
 64 bit
> +# version", which aborts the whole selftests build. Probe for the operat=
ion and
> +# skip libarena (and its dependent tests) when the backend cannot handle=
 it.
> +CLANG_HAS_ARENA_CMPXCHG32 :=3D $(shell printf '%s\n' \
> +	'struct s { int counter; };' \
> +	'int f(struct s __attribute__((address_space(1))) *l, int o, int n)' \
> +	'{ return __sync_val_compare_and_swap(&l->counter, o, n); }' | \
> +	$(CLANG) --target=3Dbpf -O2 -x c -c - -o /dev/null 2>/dev/null && echo =
1)
> +

[Severity: High]
Does this feature probe artificially fail by omitting the -mcpu=3Dv4 flag?

Because the probe runs against the default BPF CPU target (which lacks 32-b=
it
atomic support), it will falsely report that the backend lacks support and
unnecessarily skip the tests.

Could the actual root cause of the build failure be that libarena's
BPF_CFLAGS in tools/testing/selftests/bpf/libarena/Makefile is missing
the -mcpu=3Dv4 flag?=20

For example, test_progs-cpuv4 successfully compiles progs/arena_spin_lock.c
because it explicitly passes -mcpu=3Dv4. Would adding -mcpu=3Dv4 to the
libarena Makefile fix the compilation error natively instead of skipping
the tests entirely?

>  # Order correspond to 'make run_tests' order
>  TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test_pr=
ogs \
>  	test_sockmap \

[ ... ]

> @@ -835,10 +846,13 @@ LIBARENA_BPF_DEPS :=3D $(wildcard libarena/Makefile=
		\
>  				 libarena/selftests/*		\
>  				 libarena/*.bpf.o)
> =20
> +ifneq ($(CLANG_HAS_ARENA_CMPXCHG32),)
>  LIBARENA_SKEL :=3D libarena/libarena.skel.h
> +CFLAGS +=3D -DHAS_BPF_ARENA
> =20
>  $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
>  	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
> +endif
> =20
>  ifneq ($(CLANG_HAS_ARENA_ASAN),)
>  LIBARENA_ASAN_SKEL :=3D libarena/libarena_asan.skel.h

[Severity: High]
This is a pre-existing issue, but doesn't the ASAN variant of libarena
also need protection from this compiler crash?

The LIBARENA_ASAN_SKEL build is only guarded by CLANG_HAS_ARENA_ASAN, which
checks for ASAN flag support but not 32-bit cmpxchg support.=20

Since the ASAN build compiles the exact same buddy.bpf.c source code
containing the 32-bit arena cmpxchg, the compiler will still crash here
with the exact same "Cannot select: AtomicCmpSwap" error if the target
lacks 32-bit atomics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630025809.7404=
3-1-dongtai.guo@linux.dev?part=3D1
