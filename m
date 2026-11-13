Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539186;
	b=KxXrwjugMyFV9WBt62B2ostZYJGG3G67k68IVenyKMxMySCUuCCbVVIcTa+c9cpE1RCd
	 msXtAcfOc2xdK2h2sJ0H2u0VAxy9X7dy4Wz3MyP2MmOldz65YwiPwkg2Ohxq2dHhWg4sf
	 RlBnRuBle+Xng6HKKTtAqdXlGG3S7jnJ7pt/zURYul1NWH+6ViwSDlkR1jj+0TwjBs/1j
	 tvIhQzVKVW1c3ECbiQqJ/lWbUphVFJimin/PKLs6QmtC9Ml3vGjxqREVQBDPrtm6S2D6T
	 8ha2qf3cWvEyjl3kR1ho6q3ZJUGyDIoAynkrGWLBQcwVa+2Lp0/uu5Krzb7NV8ZhZ4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539186;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F5XvvWXAj/ydcU2vfCIDHLVsusySc9K7FkKDwA8A1uY=;
	b=ILa99cYMBf16CnUFDYXIVWcMJnisix7kuZJIhqRSkWg1YhH7PMUXDzvJQ9fVE9lngZiA
	 eBhjZkHLnHwylI2F1bYnGprWeM89DxoDvxyjz5T1BmsBJZL4BIANalWoFP6pJe08VPsGe
	 /qpImM93p0dmbKjpxB2id5fhOX2DuoJHEpQFkNabzKQpiKZs0Uzhlic7GDxv+Lg6il3JN
	 uFZxrG5sZ1dpxKzT7LCkjVukKNETi827gE3mcUVu128N9y6ZIu9OyfX25JPFOZ4pVwxru
	 /CKY9c+/QH8UPmkBPyRd8mdcTcQc1sPwcJG/VYhA16wIYx+RcpGM3UhJZKBynQYCCmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMsk9dfO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A219606A31C
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMsk9dfO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE381F000C4;
	Fri, 13 Nov 2026 03:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794539186;
	bh=F5XvvWXAj/ydcU2vfCIDHLVsusySc9K7FkKDwA8A1uY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mMsk9dfOEHS8muvTgRe2oVQ0cS0TKuPYnJJpOc6xWQJVKUcVjtQd3oI/Dtj0qm2NE
	 yTTpgfY4zrEOEN5N6Pguy+jQLjSGFfzkINFoI7DFXqb1t0e7AX3EpENqhsC4Kc3KdF
	 qAPhWQLtZvdXgQB4wx2Vts3mUyPI/abNKDpEb6BU1NKWeocqWtHQ6b8EBLvqAZ7Qhx
	 7FrYtCfQ0/+s4MAu8LlUgwRoHduf+dW5H8tcfG73sIfDwmlrl+Y7/M2adsqILok/y7
	 3jZHRS38rplBoqdAd/NX8RLQNk0axy/bz7eJ9K6iRR74kM+7LH26v0QcUp4aqVZaiC
	 Oq5DJlNqt+LTw==
Message-ID: <sashiko-outbox-212121@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test that a drained task_vma
 iterator keeps returning NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kang Chen" <k.chen@smail.nju.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261113024500.922824-2-k.chen@smail.nju.edu.cn>
References: <20261113024500.922824-1-k.chen@smail.nju.edu.cn>
 <20261113024500.922824-2-k.chen@smail.nju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 03:06:25 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] selftests/bpf: short bpf_loop() spin in
  iter_task_vma_next_after_drain()
- [Low] selftests/bpf: missing acquire/release ordering in map_new_vma()
- [Low] selftests/bpf: mmap() at last_end in map_new_vma() fails at
  TASK_SIZE
- [Low] selftests/bpf: standalone task_vma_iter test instead of
  extending iters.c
--

commit 6861abec39a496e31db7f94849dcb9afd420ad9b
Author: Kang Chen <k.chen@smail.nju.edu.cn>

selftests/bpf: Test that a drained task_vma iterator keeps returning NULL

This commit adds a BPF selftest verifying that calling
bpf_iter_task_vma_next() on an already drained task_vma iterator continues
to return NULL even after a new VMA is mapped at the end of the address
space.

> diff --git a/tools/testing/selftests/bpf/prog_tests/task_vma_iter.c b/too=
ls/testing/selftests/bpf/prog_tests/task_vma_iter.c
> new file mode 100644
> index 0000000000000..bb9feb840a277
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/task_vma_iter.c
> @@ -0,0 +1,89 @@

[ ... ]

> +static void *map_new_vma(void *arg)
> +{
> +	struct map_ctx *ctx =3D arg;
> +	struct task_vma_iter *skel =3D ctx->skel;
> +	void *addr;
> +
> +	while (!__atomic_load_n(&skel->bss->drain_done, __ATOMIC_RELAXED))
> +		sched_yield();
> +
> +	if (!skel->bss->new_ret) {
> +		addr =3D (void *)(unsigned long)skel->bss->last_end;

[Severity: Low]
Can map_new_vma() observe drain_done =3D=3D 1 before the stores to last_end
and new_ret are visible on weakly-ordered architectures?

iter_task_vma_next_after_drain() writes last_end, new_ret, and drain_done
with plain stores, while map_new_vma() polls drain_done with
__ATOMIC_RELAXED instead of __ATOMIC_ACQUIRE.  Similarly, map_new_vma()
sets go with __ATOMIC_RELEASE, but wait_for_go() reads go with a plain
load.  If the stores are reordered, mmap() with MAP_FIXED_NOREPLACE can
use a stale last_end address and fail the test.

> +		ctx->addr =3D mmap(addr, getpagesize(), PROT_READ | PROT_WRITE,
> +				 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE,
> +				 -1, 0);
> +		if (ctx->addr =3D=3D MAP_FAILED)
> +			ctx->err =3D errno;
> +	}

[Severity: Low]
Can mmap() at last_end fail with ENOMEM when the highest VMA ends at
TASK_SIZE?

iter_task_vma_next_after_drain() records vm_end of the final VMA in the
process.  On architectures where STACK_TOP equals TASK_SIZE, the stack
VMA's vm_end is TASK_SIZE whenever ASLR is disabled (such as
kernel.randomize_va_space=3D0 or under gdb) or when randomize_stack_top()
picks a zero offset, leaving no unmapped user address space at last_end.

[ ... ]

> +void test_task_vma_iter(void)
> +{
> +	if (test__start_subtest("next_after_drain"))
> +		test_task_vma_iter_next_after_drain();
> +}

[Severity: Low]
This isn't a bug, but tools/testing/selftests/bpf/prog_tests/iters.c and
tools/testing/selftests/bpf/progs/iters_task_vma.c already test the
open-coded bpf_iter_task_vma iterator.  Could this subtest be added there
instead of introducing standalone task_vma_iter files?

> diff --git a/tools/testing/selftests/bpf/progs/task_vma_iter.c b/tools/te=
sting/selftests/bpf/progs/task_vma_iter.c
> new file mode 100644
> index 0000000000000..9159aa7fc48e4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_vma_iter.c
> @@ -0,0 +1,53 @@

[ ... ]

> +	/* Let user space map a new VMA at last_end before the extra next(). */
> +	drain_done =3D 1;
> +	bpf_loop(1000000, wait_for_go, NULL, 0);
> +	go_seen =3D go;

[Severity: Medium]
Can bpf_loop(1000000, wait_for_go, NULL, 0) finish before map_new_vma()
runs and sets go?

wait_for_go() is inlined into a tight loop of 1,000,000 reads that
completes in roughly 1 to 3 ms inside bpf_prog_test_run_syscall() with
migration disabled.  test_task_vma_iter_next_after_drain() starts the
syscall program immediately after pthread_create() without waiting for
map_new_vma() to start.  On a single-CPU system (especially under
!CONFIG_PREEMPT where the kernel loop is not preempted) or under parallel
test_progs load where thread startup and mmap() take more than a few
milliseconds, bpf_loop() exhausts its iterations before go is set and fails
the go_seen assertion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113024500.9228=
24-1-k.chen@smail.nju.edu.cn?part=3D2
