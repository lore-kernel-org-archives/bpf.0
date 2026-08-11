Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC529BDB5;
	Tue, 11 Aug 2026 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452013; cv=none; b=ZakTERiel+77znx8ExCrXrQO6pP5p7aRjMcDzU6Y0FEoVwhvTopfBHigeF4NGMjuMjKs8nl2xa+RvpuWcUeXOhQXZ4scxQLAgWd3CLVLJPkFr42ttXtpyr7VsDyXa82fQyBQLqIgVndX5THMvoOzLz51hRpFYuSn/rZ5uchDcCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452013; c=relaxed/simple;
	bh=v9BqAViXWhOijZuropR9+zJijlh6aPigdQ+mocQ/kTg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X23f6BuxxSXEk9Ksc0IeAAAz1mdyqcA0kYcVeXvbqz+VJUh5K9eG426yfs5b4+M/GpZFAh1xM0vkjF5VryUNWMJgBn5SaljKINW+lOfAxJEwhlhbbTBQ3JLOPHHsIbN998fHiCsvT3VGBqHgEydD/heZNU7w9fc/55yG93bHWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce8Hn+YN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce8Hn+YN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CFF1F00A3A;
	Tue, 11 Aug 2026 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786452011;
	bh=J0tZSTnKs2BtcMVfQ5nw/+/GWpAWReRo2gArGUALO5I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ce8Hn+YN8KW+67LVYZqbXHYHtaffjIzUa5S0+w4ACQH6/KstGWEpSbj/eEzdgbxH2
	 rkIMpmB6XZvq2b3rfaGTFWUD23VcntdohZI1bV2p8mogs+RyYsxmu/zIxLUWAB5xoI
	 mw76YHfqYINXo+NTgo1QGlKbE2wdp3P7O7qh2GmA1Sd3jOyHao7BK4ftcX5CqMSZgN
	 WYRTkZ730b8+WivpsgtjUdY14cZ0iU8vB9C7VSFz8MKGVxhR/CAQ4u9/5rCf7hRYE/
	 DPLnHkIaCWmi+T5nNdTdtVYHG71jF3wdyPfPi3dK2OKL6Q3CNYEsbKz5pAAjsyWDMd
	 BepAKDR1fmEjQ==
Content-Type: multipart/mixed; boundary="===============2459636574471727467=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2cd0c943fb35dab000f00272d28669dffa60007c9e1c939e2f2b77bd0f4dc81f@mail.kernel.org>
In-Reply-To: <20260811112154.94053-4-tasos.papagiannnis@gmail.com>
References: <20260811112154.94053-4-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: Mark linux_binprm->mm as trusted-or-null
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,akpm@linux-foundation.org,david@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,song@kernel.org,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 12:40:10 +0000 (UTC)

--===============2459636574471727467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index add3affc57035..8bdcb65618d01 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5682,6 +5682,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
>  	struct inode *d_inode;
>  };
>
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
> +	struct mm_struct *mm;
> +};
> +

Does this break the BPF load-compatibility guarantee documented in
Documentation/bpf/bpf_design_QA.rst?

Before this patch, walking bprm->mm produced a dereferenceable register
in every program type. In sleepable programs, in_rcu_cs() is false, so
check_ptr_to_btf_access() sets flag = PTR_UNTRUSTED. In non-sleepable
programs, in_rcu_cs() is true but mm is not in any __safe_rcu* list, so
clear_trusted_flags() produces a plain PTR_TO_BTF_ID.

Both PTR_TO_BTF_ID and PTR_TO_BTF_ID|PTR_UNTRUSTED satisfy the guard in
check_mem_access():

  } else if (base_type(reg->type) == PTR_TO_BTF_ID &&
             !type_may_be_null(reg->type)) {
          err = check_ptr_to_btf_access(env, regs, reg, argno, off, size, t,
                                        value_regno);

so bprm->mm->arg_start loads with no NULL check.

After this patch, btf_nested_type_is_trusted() matches
linux_binprm__safe_trusted_or_null.mm, so check_ptr_to_btf_access() sets
flag |= PTR_TRUSTED | PTR_MAYBE_NULL. Now type_may_be_null() is true, the
arm above is skipped, and control falls to the final else:

  } else {
          verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
                  reg_type_str(env, reg->type));
          return -EACCES;
  }

Any existing program that reads through bprm->mm without an explicit NULL
check now fails bpf_prog_load() with -EACCES.

> @@ -5732,6 +5736,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
>  {
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
>
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
> diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
> index 7de173daf27b6..7441d66c080c9 100644
> --- a/tools/testing/selftests/bpf/progs/lsm.c
> +++ b/tools/testing/selftests/bpf/progs/lsm.c
> @@ -113,6 +113,7 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
>  {
>  	__u32 pid = bpf_get_current_pid_tgid() >> 32;
>  	struct inner_map *inner_map;
> +	struct mm_struct *mm;
>  	char args[64];
>  	__u32 key = 0;
>  	__u64 *value;
> @@ -121,7 +122,9 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
>  		bprm_count++;
>
>  	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
> -	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
> +	mm = bprm->mm;
> +	if (mm)
> +		bpf_copy_from_user(args, sizeof(args), (void *)mm->arg_start);
>
>  	value = bpf_map_lookup_elem(&array, &key);
>  	if (value)

The selftest rewrite above shows the problem: the old form
bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start) now
requires a NULL check. Out-of-tree BPF LSM and tracing programs that read
bprm->mm the same way will stop loading on kernel upgrade with no source
change on their side.

The bpf_design_QA.rst compatibility guarantee states: "The bpf development
process guarantees that the future kernel versions will accept all bpf
programs that were accepted by the earlier versions."

The tracing-program exception in that document does not cover this case:
struct linux_binprm's layout is unchanged, the program source is unchanged,
and the in-tree casualty is a BPF LSM program, not a bpf_probe_read()-based
tracing program.

Should the changelog mention the compatibility impact and document that
programs dereferencing bprm->mm now need a NULL check?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31488001112
--===============2459636574471727467==--
