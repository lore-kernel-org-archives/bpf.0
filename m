Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2112472AF
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788650614; cv=none; b=TINByeEMStBnVt+IlvJZ0hRqCHBH+9x1DOgIEL7wTBKPuvlVQ9ITd/q+aDWBuBBDFrfT3Bzra1u1CVUGu6T2ZuGAzhaWr0J+6Skzrs+RDjJhUu9HK2y5F0vBZoqOKWko5eGv6ifC7nUz4SIAikt0NbwQ+GYP9aoQRyaF4/jMrwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788650614; c=relaxed/simple;
	bh=SG4i/TROud4eMLwGmfZHiObq15BUwSZiwgRCEKqFGtw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fEHff5dEnJ2S6e7Wi3I3oU3kk4sfILetGJfrdCtgtQrHQBNiLQ9DZatr8ahiNKQ5F0gvMunNxveNhQXNg7xNBhXuCbhT1gEMKQsBVWPendIL8HHqwf2bd8nodlsdIg10/QLubXxpzXm54FlpoKxdcjCcuP8RII1naFEp22oJtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFH4tnyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFH4tnyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FD71F00A3A;
	Sat,  5 Sep 2026 23:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788650612;
	bh=/bAOfXsbA6xyVE6ckOPbEeCMgXQcJH33JDcJjseIAVs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lFH4tnybhF0UmPom7bpWZR0+ZcvGu4vk24NXEX3N2FCZvKQeR6ept+dShuN+zo5eo
	 irSjHgykDQDpYriObb1mjvh1vlvAHBkI59bR3uWoDYULN9zGTiH2w48B1qiS31vke/
	 m8WjjlwBaVwRypgPG/mCWEu2eEFOvnmC4HZhOsigy9ZDTjpYBSqiiqdJbqkGNkl1ku
	 ezhcRFxq7QSiGdUqqBlvsA/Esb8z54K/mFHgTtJpjPCe4PD02yz8k7+tK5W+eh4PmH
	 vV+hPTHetvcleSbhBnmn7wXIDQSbsSxn5ChLT2JEv9P4qYD1jNygdgTTDWOKI/80lK
	 227EAg3nczgBQ==
Content-Type: multipart/mixed; boundary="===============7160845502092433502=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <58079fda8b9a98ec66a54e8c1cb80e4eaedf82cc5fda7f8cebef10fb1b4e266d@mail.kernel.org>
In-Reply-To: <20260905220117.922028-19-ameryhung@gmail.com>
References: <20260905220117.922028-19-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 18/22] bpf: Admit kfunc argument registers through check_reg_type()
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 23:23:31 +0000 (UTC)

--===============7160845502092433502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bd3fea62aa02..cad49ea5fdfa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8251,7 +8239,7 @@ static const struct bpf_reg_types mem_types = {
>  	},
>  };
>
> -static const struct bpf_reg_types spin_lock_types = {
> +static const struct bpf_reg_types map_value_or_alloc_obj_types = {
>  	.types = {
>  		PTR_TO_MAP_VALUE,
>  		PTR_TO_BTF_ID | MEM_ALLOC,

[ ... ]

> @@ -8280,7 +8268,29 @@ static const struct bpf_reg_types percpu_btf_ptr_types = {
>  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
>  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
>  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> -static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
> +static const struct bpf_reg_types map_value_types = { .types = { PTR_TO_MAP_VALUE } };
> +static const struct bpf_reg_types arena_types = {
> +	.types = {
> +		PTR_TO_ARENA,
> +		SCALAR_VALUE,
> +	}
> +};
> +
> +static const struct bpf_reg_types alloc_obj_types = {
> +	.types = {
> +		PTR_TO_BTF_ID | MEM_ALLOC,
> +		PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU,
> +	}
> +};
> +
> +static const struct bpf_reg_types alloc_obj_or_non_own_ref_types = {
> +	.types = {
> +		PTR_TO_BTF_ID | MEM_ALLOC,
> +		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF,
> +		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU,
> +	}
> +};

Does alloc_obj_or_non_own_ref_types need a diagnostic improvement?
reg_type_str() has no textual prefix for MEM_ALLOC or NON_OWN_REF and
renders PTR_TO_BTF_ID as the bare stem "ptr_". The first two entries both
render as "ptr_" and the third as "rcu_ptr_", giving users the
non-actionable list "ptr_, ptr_, rcu_ptr_". The selftest updates confirm
this is what users see:

  rbtree_fail.c: __msg("R2 type=scalar expected=ptr_, ptr_, rcu_ptr_")
  refcounted_kptr_fail.c: __msg("R1 type=ctx expected=ptr_, ptr_, rcu_ptr_")

These replace specific messages like "R1 is neither owning or non-owning
ref". The changelog claims "The reason continues to report the actual
register type and all accepted register types", which is literally true but
not useful here: three distinct ownership states collapse to two
indistinguishable strings, and "ptr_" is a dangling stem. Either
reg_type_str() needs prefixes for MEM_ALLOC/NON_OWN_REF, or
ARG_PTR_TO_REFCOUNTED_KPTR / ARG_PTR_TO_LIST_NODE / ARG_PTR_TO_RB_NODE
should keep an ownership-specific message.

> @@ -8310,16 +8320,32 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  #endif
>  	[ARG_PTR_TO_SOCKET]		= &fullsock_types,
>  	[ARG_PTR_TO_BTF_ID]		= &btf_ptr_types,
> -	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
> +	[ARG_PTR_TO_SPIN_LOCK]		= &map_value_or_alloc_obj_types,
>  	[ARG_PTR_TO_MEM]		= &mem_types,
>  	[ARG_PTR_TO_RINGBUF_MEM]	= &ringbuf_mem_types,
>  	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
>  	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
>  	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
>  	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
> -	[ARG_PTR_TO_TIMER]		= &timer_types,
> +	[ARG_PTR_TO_TIMER]		= &map_value_types,
>  	[ARG_KPTR_XCHG_DEST]		= &kptr_xchg_dest_types,
>  	[ARG_PTR_TO_DYNPTR]		= &dynptr_types,
> +	/* Argument kinds only a kfunc can have. */
> +	[ARG_SCALAR]			= &scalar_types,
> +	[ARG_CONST_SCALAR]		= &scalar_types,
> +	[ARG_CONST_MEM_SIZE]		= &scalar_types,
> +	[ARG_PTR_TO_ALLOC_BTF_ID]	= &alloc_obj_types,
> +	[ARG_PTR_TO_REFCOUNTED_KPTR]	= &alloc_obj_or_non_own_ref_types,
> +	[ARG_PTR_TO_ITER]		= &stack_ptr_types,
> +	[ARG_PTR_TO_LIST_HEAD]		= &map_value_or_alloc_obj_types,
> +	[ARG_PTR_TO_LIST_NODE]		= &alloc_obj_or_non_own_ref_types,
> +	[ARG_PTR_TO_RB_ROOT]		= &map_value_or_alloc_obj_types,
> +	[ARG_PTR_TO_RB_NODE]		= &alloc_obj_or_non_own_ref_types,
> +	[ARG_PTR_TO_RES_SPIN_LOCK]	= &map_value_or_alloc_obj_types,
> +	[ARG_PTR_TO_WORKQUEUE]		= &map_value_types,
> +	[ARG_PTR_TO_TASK_WORK]		= &map_value_types,
> +	[ARG_PTR_TO_IRQ_FLAG]		= &stack_ptr_types,
> +	[ARG_PTR_TO_ARENA]		= &arena_types,
>  };

Does ARG_PTR_TO_MEM need to admit allocated objects for kfuncs? Running
check_reg_type() on kfunc arguments makes mem_types the admission gate for
ARG_PTR_TO_MEM, but mem_types lists only PTR_TO_BTF_ID | PTR_TRUSTED among
the BTF-backed register types. Before this commit check_kfunc_args() had no
reg-type test in its ARG_PTR_TO_MEM / ARG_MEM_SIZE cases (the commit
removes tests from ten other cases but adds none here), so a kfunc memory
argument was validated only by check_mem_reg()/check_mem_size_reg() ->
check_helper_mem_access(), which accepts any BTF-ID register:

  case PTR_TO_BTF_ID:
    return check_ptr_to_btf_access(env, regs, reg, argno, 0,
                                   access_size, access_type, -1);
    /* kernel/bpf/verifier.c:7097-7099, switch is on base_type(reg->type) */

Kfunc memory arguments are checked with BPF_READ | BPF_WRITE
(verifier.c:13243 and 13289), and check_ptr_to_btf_access() has an explicit
carve-out that permits exactly those writes for BPF-allocated objects:

  /* Writes are permitted with default btf_struct_access for
   * program allocated objects (which always have id > 0).
   */
  if (atype != BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
    verbose(env, "only read is supported\n");
    return -EACCES;
  }
  /* kernel/bpf/verifier.c:6093-6099 */

check_func_arg_reg_off() likewise enumerates PTR_TO_BTF_ID | MEM_ALLOC and
PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF as register types that legitimately
reach argument checking with a fixed offset (verifier.c:8567-8578). So a
program that does

  struct foo *f = bpf_obj_new(typeof(*f));
  ...
  some_kfunc(&f->buf, sizeof(f->buf));  /* void *p, u32 p__sz */

or passes such a pointer to a fixed-size scalar-pointer kfunc argument
(get_kfunc_arg_type() verifier.c:12321, ARG_PTR_TO_MEM | MEM_FIXED_SIZE)
loaded before this commit and is now rejected at check_reg_type() with
-EACCES: "R1 type=ptr_ expected=fp, pkt, pkt_meta, map_key, map_value, mem,
ringbuf_mem, buf, trusted_ptr_, ctx".

Since mem_types already excluded PTR_TO_BTF_ID | MEM_ALLOC for helpers, the
write-to-allocated-object carve-out in check_ptr_to_btf_access() was
reachable from the argument path only through kfuncs; after this commit it
is unreachable from any argument path.

This is a third, undocumented behaviour change. The changelog states "Two
behavior changes fall out of running admission first" and lists only the
ARG_CONST_MEM_SIZE precision fix and the ARG_CONST_MAP_PTR
type_may_be_null() removal. No selftest covers passing an allocated object
as a kfunc memory argument, so the capability is removed silently. Forward
search over the supplied range 8f65640265e8..a490f49b0c4e shows no change
to mem_types. If the narrowing is intended it should be stated in the
changelog (and the now-dead carve-out comment in check_ptr_to_btf_access()
updated); otherwise mem_types needs PTR_TO_BTF_ID | MEM_ALLOC (and the
NON_OWN_REF form).

[ ... ]

> @@ -13002,25 +13015,20 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  		if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
>  			ref_id = *meta->fn->arg_btf_id[i];
>
> -		ret = resolve_func_arg_type(env, reg, i, meta, insn_idx, &arg_type, &arg_size);
> +		ret = resolve_func_arg_type(env, reg, i, meta, &arg_type, &arg_size);
>  		if (ret < 0)
>  			return ret;
> +
> +		ret = check_reg_type(env, reg, argno, arg_type, meta);
> +		if (ret < 0)
> +			return ret;
> +
>  		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
>  		if (ret < 0)
>  			return ret;
>
>  		switch (base_type(arg_type)) {
>  		case ARG_CONST_SCALAR:
> -			if (reg->type != SCALAR_VALUE) {
> -				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
> -				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
> -						      "Pass an integer scalar value for this argument, not a pointer or resource object.",
> -						      "the kfunc expects an integer scalar, but %s is %s",
> -						      reg_arg_name(env, argno),
> -						      bpf_diag_reg_type_plain(env, reg->type));
> -				return -EINVAL;
> -			}
> -
>  			ret = process_const_arg(env, reg, argno, meta);
>  			if (ret < 0) {
>  				if (ret == -EINVAL)

[ ... ]

> @@ -11845,24 +11874,8 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
>  		ref_t = btf_type_skip_modifiers(btf, ref_id, &ref_id);
>  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>
> -		if (!btf_type_is_scalar_struct(env, btf, ref_t)) {
> -			enum bpf_reg_type reg2btf_type = lookup_reg2btf_ids(ref_id);
> -			const char *expected_type;
> -
> -			verbose(env, "%s is %s expected %s %s",
> -				reg_arg_name(env, argno), reg_type_str(env, reg->type),
> -				btf_type_str(ref_t), ref_tname);
> -			if (reg2btf_type != NOT_INIT)
> -				verbose(env, " or %s", reg_type_str(env, reg2btf_type));
> -			verbose(env, "\n");
> -			expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
> -			bpf_diag_call_arg_fmt(env, insn_idx, argno, meta->func_name,
> -					      "Pass a verifier-tracked pointer to the expected kernel object type, not a pointer to stack storage or another memory buffer.",
> -					      "the function expects a pointer to %s, but this argument is %s and cannot be used as that kernel object pointer",
> -					      expected_type,
> -					      bpf_diag_reg_type_plain(env, reg->type));
> -			return -EINVAL;
> -		}
> +		if (!btf_type_is_scalar_struct(env, btf, ref_t))
> +			return 0;

Does this break existing selftests? The patch deletes the only producer of
the "R1 is fp expected STRUCT prog_test_fail1" diagnostic from
resolve_func_arg_type(), replacing it with a bare `return 0;`. It updates
verifier/calls.c line 79 but leaves three other cases in the same file
still asserting the removed message:

  calls.c:34  .errstr = "R1 is fp expected STRUCT prog_test_fail1"
  calls.c:49  .errstr = "max struct nesting depth exceeded\nR1 is fp
               expected STRUCT prog_test_fail2"
  calls.c:64  .errstr = "R1 is fp expected STRUCT prog_test_fail3"

All three are reached: bpf_kfunc_call_test_fail1/2/3 take pointers to
struct prog_test_fail1 (has pointer member), prog_test_fail2 (nesting depth
> 4) and prog_test_fail3 (flexible array), so btf_type_is_scalar_struct()
returns false for each and the removed verbose() used to fire. After the
patch, resolve_func_arg_type() returns 0 with arg_type still
ARG_PTR_TO_BTF_ID; check_reg_type() then rejects R1 (PTR_TO_STACK) against
btf_ptr_types and prints "R1 type=fp expected=ptr_, trusted_ptr_, rcu_ptr_"
instead. The asserted substrings never appear, so these three test_verifier
cases fail.

These three sites are not fixed anywhere later in the series either: `git
show a490f49b0c4e:tools/testing/selftests/bpf/verifier/calls.c` still
contains all three stale strings, and no commit in 8f65640265e8..a490f49b0c4e
touches verifier/calls.c.

Do the test expectations in other files also need updating? Three more BPF
selftests assert the "is fp expected STRUCT ..." message that this commit
removes from resolve_func_arg_type():

  tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c:67
    __msg("R1 is fp expected STRUCT cgroup")
  tools/testing/selftests/bpf/progs/task_kfunc_failure.c:53
    __msg("R1 is fp expected STRUCT task_struct")
  tools/testing/selftests/bpf/progs/verifier_vfs_reject.c:31
    __msg("R1 is fp expected STRUCT task_struct")

struct cgroup and struct task_struct are not scalar structs, so each of
these used to hit the deleted verbose(); after the patch check_reg_type()
emits "R1 type=fp expected=ptr_, trusted_ptr_, rcu_ptr_" and the assertions
fail.

This is confirmed by the series itself: commit a490f49b0c4e ("bpf: Check
helper and kfunc arguments in one path"), four commits later, updates
exactly these three lines to __msg("R1 type=fp expected=ptr_, trusted_ptr_,
rcu_ptr_"). Those test-expectation updates belong in this commit, which is
the one that changes the message; as it stands the tree is bisect-broken
for 4 commits (test_progs cgrp_kfunc/task_kfunc/verifier_vfs_reject).

Does this lose test coverage for the ownership check?
rbtree_fail.c:182 and rbtree_fail.c:206 were the only two selftests
asserting the verifier check at kernel/bpf/verifier.c:13183:

  verbose(env, "%s can only take non-owning or refcounted bpf_rb_node
  pointer\n", func_name);

Both tests invalidate a non-owning ref across bpf_spin_unlock() (the
register becomes SCALAR_VALUE) and then call bpf_rbtree_remove(). With
check_reg_type() now running before the switch, SCALAR_VALUE is rejected by
ARG_PTR_TO_RB_NODE's alloc_obj_or_non_own_ref_types table first, so the
ownership check is no longer reached and the new expectations only assert
the generic register-class error. `grep -r "can only take non-owning or
refcounted" tools/testing/selftests/bpf/` now returns nothing: the check
has zero test coverage after this patch.

Worth double-checking whether that check is still reachable at all. The
only register types that can now reach it are PTR_TO_BTF_ID|MEM_ALLOC,
|NON_OWN_REF and |NON_OWN_REF|MEM_RCU; the NON_OWN_REF forms satisfy
type_is_non_owning_ref(), and a plain owning MEM_ALLOC register whose
reference has been released is invalidated by
release_reference()/mark_reg_invalid(). If no reachable register type
remains, the check is dead and should be dropped rather than left
uncovered; if it is reachable, the two repurposed tests should be kept (or
a replacement added) so the ownership rule stays guarded.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============7160845502092433502==--
