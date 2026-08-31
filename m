Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499E3B71DA;
	Mon, 31 Aug 2026 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173009; cv=none; b=sWA3pEwwRitR9MbthbCItGW2pNWBSa5QRbeBKWZP5DCvgiGt1rz3GW2JMOc+zWGx0L1euFpP9d/UEnw9SVKxq3mCFsxKM8r2U5urksKL6QGRRZUeI6hKsKnlFiQJhs4C0XbkWcUTCdTSqgXHJ/T6PFulOh7KOw3dButSRWgcGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173009; c=relaxed/simple;
	bh=1W4wCCuvMFL45fDOYUsC1vcT2PZXHKB2ci0CQpdpVSI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gcmOunudjGo5r31P1RxOF9WvX1nCxI0T20xPJQa4prJI2NU4K+0SesJRiGuskgaOQMdubUfxZEwwbAlwGIhTKLgcDKo/ddytsPcPeETLVUs5khouTKpfEjMLeaZUFzl2673mYY5XjDFkamHiwKXYvem15AmQtbLC4tO/GbpyVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDvpYveJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDvpYveJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2281F00A3F;
	Mon, 31 Aug 2026 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788173002;
	bh=4A6rVmZ4kXsT9r+WYDtkSaIU7jzFhtTA68G3dKhDy+8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CDvpYveJfDwfFRCpZc0xZE3uPNrncqqnDF+aPMZ1MpImzzLt27PEl+xWCpfTgW5FK
	 0bKquH9D+eT0uYVUnDPXvSyRM6vrrMNLaUS86g4gYACm1Gw+ZWylB6CDSYt70JiKGz
	 GOJemDTTlkmp0S8EFPQW+En11jImLCVVsbK9hXCU71WquGUP2vUDn5JgUufYDPfpxq
	 +l3wGWbDoo8DCZevAvk+0nHbHREph9aBi4lK9gItHpuXbDy1tfkmfOu9DPIaU/gmbu
	 yrZj/TWy19LEmlT+yDrGKI37MUEEFlpS36XLlnRFqVVWUwN0x5bbZjL1iNLUQs/B75
	 yqVvssCw1UEDQ==
Content-Type: multipart/mixed; boundary="===============8374567278503569975=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9e411feb9558d5759bd8927b9b2e95751f19b11981be87e6cb9757c2e9f65852@mail.kernel.org>
In-Reply-To: <20260831092305.42062-6-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-6-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/7] selftests/bpf: Cover trusted-or-null BTF pointer reads
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-fsdevel@vger.kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,utilityemal77@gmail.com,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 10:43:21 +0000 (UTC)

--===============8374567278503569975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Verify that pointer arithmetic, stores, atomic RMW operations, and
> BPF_LOAD_ACQ accesses remain prohibited. Assert that a BTF pointer
> derived from an unchecked trusted-or-null load is PTR_UNTRUSTED.

Does the patch actually verify atomic RMW operations and BPF_LOAD_ACQ
accesses?

Looking at the diff, pointer arithmetic is covered by
handle_tp_btf_nullable_arith in progs/test_tp_btf_nullable.c with the
expected verifier message "pointer arithmetic on trusted_ptr_or_null_
prohibited". Stores are covered by store_through_trusted_or_null_bprm_mm
in progs/verifier_lsm.c.

But there is no test for an atomic RMW operation (such as
__sync_fetch_and_add through a trusted-or-null pointer) or for a
BPF_LOAD_ACQ access (such as __atomic_load_n with __ATOMIC_ACQUIRE).
Running grep over the diff for "atomic", "load_acq", or "__sync_fetch"
only matches the commit message text itself.

The underlying kernel behaviour is correct: is_load_acq_unsafe() rejects
BPF_LOAD_ACQ on a may-fault pointer, and an atomic RMW is rejected by
the BPF_WRITE pass of check_mem_access(). So this is a coverage gap
rather than a functional bug.

> diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
> index 0d58114a4955c..45df28c0a25ed 100644
> --- a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
> +++ b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
> @@ -2,14 +2,18 @@
>  /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>
>  #include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bpf_misc.h"
>
>  char _license[] SEC("license") = "GPL";
>
> +extern struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
> +extern void bpf_task_release(struct task_struct *p) __ksym;
> +
>  /* Ensure module parameter has PTR_MAYBE_NULL */
>  SEC("tp_btf/bpf_testmod_test_raw_tp_null_tp")
> -__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
> +__success
>  int test_raw_tp_null_bpf_testmod_test_raw_tp_null_arg_1(void *ctx) {
>      asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
>      return 0;

Flipping these two tests from __failure to __success leaves their
comments describing an assertion that no longer exists, and drops the
only compile-time proof of nullability marking for these tracepoint
arguments.

Both programs now load whether or not the argument carries
PTR_MAYBE_NULL: after this series a read through a trusted-or-null
pointer is allowed, and a read through a plain trusted pointer was
always allowed. So if a future change accidentally stopped marking the
module tracepoint argument or the sched_pi_setprio argument as
maybe-null, these __success tests would keep passing while the comments
still claim otherwise. The file name raw_tp_null_fail.c is likewise now
inaccurate for the two leading tests.

Mitigating factors: progs/raw_tp_null.c plus prog_tests/raw_tp_null.c
still prove the module tracepoint argument is maybe-null at runtime via
ASSERT_EQ(skel->bss->i, 3), and the new trusted_or_null_walk_is_untrusted
test indirectly proves the marking for sched_pi_setprio because its
expected verifier message only holds if the argument was trusted-or-null.

Would retaining an explicit assertion (such as __log_level(2) plus
__msg("trusted_ptr_or_null_")) or updating the comments to reflect the
new test semantics preserve the intent?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
> index c724bf389f5c6..c912215579c92 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c

[ ... ]

> @@ -188,6 +188,17 @@ int BPF_PROG(null_check, struct file *file)
>  	return 0;
>  }
>
> +SEC("lsm.s/bprm_check_security")
> +__description("store through trusted-or-null bprm->mm is rejected")
> +__failure
> +__msg("R{{[0-9]+}} invalid mem access 'trusted_ptr_or_null_'")
> +int BPF_PROG(store_through_trusted_or_null_bprm_mm,
> +	     struct linux_binprm *bprm)
> +{
> +	bprm->mm->task_size = 0;
> +	return 0;
> +}

Can this new negative test actually pass at this commit?

The test relies on bprm->mm being loaded as a trusted-or-null pointer.
But struct linux_binprm is not in the BTF_TYPE_SAFE_TRUSTED_OR_NULL()
allow-list at this commit.

Looking at the list in kernel/bpf/verifier.c (around line 5957), at
146a2bd it contains only struct dentry {d_inode}, struct socket {sk},
and struct vm_area_struct {vm_mm, vm_file}.
BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm {struct mm_struct *mm;})
is only added two commits later, by 83008d7d1f94b ("bpf: Mark
linux_binprm->mm as trusted-or-null") which is outside this commit.

Consequently, in this sleepable (lsm.s) program in_rcu_cs() is false and
neither type_is_trusted() nor type_is_trusted_or_null() matches, so
bprm->mm is walked as PTR_TO_BTF_ID | PTR_UNTRUSTED. The store then hits
the earlier guard in check_ptr_to_btf_access():

    if (atype != BPF_READ && bpf_may_fault_on_deref(reg->type)) {
        verbose(env, "only read is supported\n");
        return -EACCES;
    }

The program is still rejected, so __failure holds, but the log says
"only read is supported" instead of "R<n> invalid mem access
'trusted_ptr_or_null_'". test_loader's __msg match therefore fails and
the verifier_lsm subtest reports failure at this commit and at the
immediately following commit; it only starts passing at 83008d7d1f94b.

Either the linux_binprm marking must be ordered before this selftest
commit, or the test must use a type that is already trusted-or-null here
(such as struct socket {sk} or struct vm_area_struct {vm_mm}).

> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
> index 55398c04290a8..2827a16507274 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> index 8f0c45421f893..2a0813258183e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> @@ -159,18 +159,4 @@ int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
>  	return 0;
>  }
>
> -SEC("lsm.s/inode_rename")
> -__failure __msg("invalid mem access 'trusted_ptr_or_null_'")
> -int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
> -	     struct inode *new_dir, struct dentry *new_dentry,
> -	     unsigned int flags)
> -{
> -	struct inode *inode = new_dentry->d_inode;
> -	ino_t ino;
> -
> -	ino = inode->i_ino;
> -	if (ino == 0)
> -		return -EACCES;
> -	return 0;
> -}
>  char _license[] SEC("license") = "GPL";

Does the deletion of this test leave struct dentry's d_inode field
without a type assertion?

The deleted test was the only place in the tree that asserted struct
dentry's d_inode field is typed PTR_TO_BTF_ID|PTR_TRUSTED|PTR_MAYBE_NULL.
Its __msg("invalid mem access 'trusted_ptr_or_null_'") named the reg
type explicitly, so it failed if d_inode ever stopped being listed in
BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) in kernel/bpf/verifier.c.

The replacement in verifier_vfs_accept.c is a bare __success program:

    SEC("lsm.s/inode_rename")
    __success
    int BPF_PROG(inode_rename_no_null_check, ...)
    {
            ino_t ino = new_dentry->d_inode->i_ino;
            ...
    }

This program loads identically whether d_inode is
PTR_TRUSTED|PTR_MAYBE_NULL (the intended marking, read via BPF_PROBE_MEM),
plain PTR_TRUSTED (normal load), or plain PTR_TO_BTF_ID. The other
d_inode test in the same file (inode_rename at line 88, which
NULL-checks first) is also __success and equally indiscriminate.

A grep of tools/testing/selftests/bpf/progs for d_inode finds no other
type assertion (only local_storage.c and profiler.inc.h, neither of which
checks reg types). So after this patch nothing detects a regression in
the trusted-or-null marking of dentry->d_inode.

Would adding __log_level(2) __msg("R{{[0-9]+}}=trusted_ptr_or_null_inode")
to the new accept test (the style already used by raw_tp_null_fail.c and
verifier_global_ptr_args.c), or keeping a __failure store/arithmetic case
on new_dentry->d_inode, restore the lost discrimination?

[ ... ]

> diff --git a/tools/testing/selftests/sched_ext/maybe_null.c b/tools/testing/selftests/sched_ext/maybe_null.c
> index aacf0c58ca4fa..8fec296c31bd3 100644
> --- a/tools/testing/selftests/sched_ext/maybe_null.c
> +++ b/tools/testing/selftests/sched_ext/maybe_null.c
> @@ -25,11 +25,11 @@ static enum scx_test_status run(void *ctx)
>  	maybe_null__destroy(skel);
>
>  	fail_dsp = maybe_null_fail_dsp__open_and_load();
> -	if (fail_dsp) {
> -		maybe_null_fail_dsp__destroy(fail_dsp);
> -		SCX_ERR("Should failed to open and load maybe_null_fail_dsp skel");
> +	if (!fail_dsp) {
> +		SCX_ERR("Failed to open and load maybe_null_fail_dsp skel");
>  		return SCX_TEST_FAIL;
>  	}
> +	maybe_null_fail_dsp__destroy(fail_dsp);

Flipping the maybe_null_fail_dsp arm from expected-failure to
expected-success removes the only check that .dispatch's second argument
is nullable.

The program under test is:

    void BPF_STRUCT_OPS(maybe_null_fail_dispatch, s32 cpu,
                        struct task_struct *p)
    {
            vtime_test = p->scx.dsq_vtime;
    }

That is a single scalar BPF_READ, which now loads regardless of whether
p carries PTR_MAYBE_NULL. In other words, it loads identically if
kernel/sched/ext/ext.c ever loses the prev__nullable suffix on
sched_ext_ops__dispatch(). The sibling positive test
(maybe_null.bpf.c maybe_null_success_dispatch, which does if (p != NULL))
also loads either way, so the .dispatch nullability marking becomes
entirely untested.

Only the .yield arm still discriminates, and it does so incidentally,
because bpf_printk("... %s ...", to->comm, ...) performs pointer
arithmetic on to (rejected), not because of a null-check requirement.

Consequently the test's own description is now inaccurate:

    struct scx_test maybe_null = {
            .name = "maybe_null",
            .description = "Verify if PTR_MAYBE_NULL works for .dispatch",

Making maybe_null_fail_dsp.bpf.c do something that is still prohibited
through a trusted-or-null pointer (pointer arithmetic on p, or a store
such as p->scx.dsq_vtime = 0) would keep the arm a real negative test.
The fail_dsp file/struct_ops names (maybe_null_fail, .name =
"maybe_null_fail_dispatch") and the description also need updating if it
stays a success case.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33379004067
--===============8374567278503569975==--
