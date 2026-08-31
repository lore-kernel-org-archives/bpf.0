Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76642D781B;
	Mon, 31 Aug 2026 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172997; cv=none; b=D0yaDZxsieOIrmdIcnEo0nFmY4dCacyAGiiO4tQxR0lOUz5B9soAf81sVMfpGataNz5mlEQUWAIgcpSGkpQojU5soAjTKYF+o2EnXm0Wx7BafT4p6RECt4bRWMzV3EqaLYxRdNg3lO1w1atk2YOStpaRwRPmAWARpMmhNyjRwTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172997; c=relaxed/simple;
	bh=lW+liWO8qmv4ZSh1ff1E2l311S9sZ5fYoySavkW1RJo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pXsbquLXk5TT8HQIbPaxsS53bSH9wI7YdPc4KhVdIkRYx+iImmaWm6JCPwpw6ghMjpu6Vctl+k0lTBuANzUS68wXEPGxDBj0hPQqidZV5P1sxnD+EX5J8EAzGfXytlwpHOd/aJDrXnlD+xN2ayyCaOX8r+pyGJUxHxIOb3OrFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9qx3Oy+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9qx3Oy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7AF1F000E9;
	Mon, 31 Aug 2026 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788172995;
	bh=1zRiZoEe+cziUvxkvj8KRKsW5kQ9BPFWyKQ48V5U48c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g9qx3Oy+sEirhBlaPWlATBQb6Wt+QnUbSr1uatSFzBcPbN+Hzm5139c6BIVUd405B
	 hQgDp6gBYQzjJPyxjPW6yEQLBcgIwAI9BY3Dp8HDsSgg9aG/aeiiqzvqU6dgypNN0v
	 +0qsyKBQb5pkem5mHcAPoDc3q0UlDA6jVm92NA5HUjdPbbzcZrvA5oANPXIsfpP18o
	 fRW99ndcB67wuop3tQ+nicsSUvSQxjPUVMk5Ba07fL3XD+iyGVelFq3vA4NJxBEasn
	 Y41838p1p4M4dXkpTI2b+G2zVHOpawy4qFAOrvvqtK8oUFmfeYnLWbU0/6TDjwhKnZ
	 aHrG2wtbCUAwQ==
Content-Type: multipart/mixed; boundary="===============6575441848940488516=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2163fb3e4198f7feac29b37aa7c659535eb5d11248f681bb25c3bc97838aa1b0@mail.kernel.org>
In-Reply-To: <20260831092305.42062-7-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-7-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: Mark linux_binprm->mm as trusted-or-null
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,linux-fsdevel@vger.kernel.org,viro@zeniv.linux.org.uk,brauner@kernel.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,utilityemal77@gmail.com,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 10:43:14 +0000 (UTC)

--===============6575441848940488516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Mark linux_binprm->mm as trusted-or-null
>
> Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
> can pass it to kfuncs after a NULL check. The linux_binprm owns this mm
> throughout the bprm_check_security hook and clears the pointer only after
> exec_mmap() installs the new address space.

Is the changelog's description of when bprm->mm is cleared accurate?

Enumerating every write to bprm->mm in the tree shows three places where
the pointer is cleared, not just "after exec_mmap()":

  fs/exec.c:bprm_mm_init()
      bprm->mm = mm = mm_alloc();          /* assign */
      ...
      bprm->mm = NULL;                     /* error path, before mmdrop */

  fs/exec.c:begin_new_exec()
      bprm->mm = NULL;                     /* after successful exec_mmap() */

  fs/exec.c:free_bprm()
      bprm->mm = NULL;                     /* before mmput() */

Two of these three are not accounted for by the changelog. The
bprm_mm_init() error path clears the pointer before mmdrop(), and
free_bprm() clears it before mmput(). The free_bprm() case is actually
load-bearing: it's what commit d3633d366b08f ("exec: Clear bprm->mm
before dropping its reference") in this same series was added for, and
that commit's changelog says it's "required for eBPF kfuncs where
bprm->mm is either NULL or points to a live mm_struct."

The real invariant this verifier change depends on is "bprm->mm is
always either NULL or a live mm," established across all of fs/exec.c.
The changelog instead asserts a narrower property that doesn't hold.

This matters because the marking isn't scoped to bprm_check_security.
Any BPF program with a trusted linux_binprm pointer (all five bprm_*
LSM hooks in include/linux/lsm_hook_defs.h, plus fentry/fexit/tp_btf on
any kernel function taking a linux_binprm) now gets a trusted mm.
Justifying it from one hook leaves a reviewer unable to check the other
attach points.

Could the changelog drop "only" and state the actual invariant, perhaps
something like: "bprm->mm is either NULL or points to a live mm_struct
at every point a BPF program can observe a linux_binprm: exec_mmap()
transfers ownership and begin_new_exec() then clears the field, and
free_bprm() clears it before dropping the reference (see the preceding
patch)"?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 386401fe051d4..584c79326b9c7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6012,6 +6016,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
>  {
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
                 ^^^^
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
>
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,

Does the patch ordering break bisect here?

The preceding commit in the series, 146a2bd992c3d ("selftests/bpf: Cover
trusted-or-null BTF pointer reads"), adds a test in
tools/testing/selftests/bpf/progs/verifier_lsm.c that expects this
marking to exist:

  SEC("lsm.s/bprm_check_security")
  __description("store through trusted-or-null bprm->mm is rejected")
  __failure
  __msg("R{{[0-9]+}} invalid mem access 'trusted_ptr_or_null_'")
  int BPF_PROG(store_through_trusted_or_null_bprm_mm,
               struct linux_binprm *bprm)
  {
          bprm->mm->task_size = 0;
          return 0;
  }

At commit 146a2bd992c3d, walking bprm->mm in a sleepable LSM program
takes the final else arm of check_ptr_to_btf_access() (flag =
PTR_UNTRUSTED) because in_rcu_cs() is false. The subsequent store fails
at the 'if (atype != BPF_READ && bpf_may_fault_on_deref(reg->type))'
check with "only read is supported" rather than "invalid mem access
'trusted_ptr_or_null_'". The __msg() assertion doesn't match and
'test_progs -t verifier_lsm' fails at that intermediate commit.

Swapping the order makes every commit in the series independently
testable. The ordering issue is present in the posted series as well
(lore message-ids 20260831092305.42062-6 and -7).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33379004067
--===============6575441848940488516==--
