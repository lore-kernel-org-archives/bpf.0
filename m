Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC64E80BD
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450766; cv=none; b=Zf0rAXAx6/VmdqdqOzNMDMIag+CHFvWpypTI5avE3fdfYfFZBCdvLjArQgAgkzeyp2h5zLLymmtbSKlKBMpi689VkLKcdUNH2goGSQBGexERSqPr5G1bGcKHbQgHR8aKIHo+uJYM0JocpRkSN5tINPGkPAB1pxuJT/xwy6f21E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450766; c=relaxed/simple;
	bh=asLBsOv/91IFXogFFHgUAODBTDWMwVTnVK02Sy4SWZc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uf9Tn7egaXv0aROaI8z90qAlTUV22cpxh+wzoAV/yJ2EWgT/RlWTKBowqszXvv/z5XZn0o7eD7dIgUjfAZJ1GbRbnpmjbuwoe/I4tPIXw4WQ8B+T2LHQOyFNebHHswwqsADn8zVi7xa/0qiEsKk06/YV94tS7mFFAXgLBlrjHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuHVw1rZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuHVw1rZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F691F000E9;
	Thu,  3 Sep 2026 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450765;
	bh=3TeZepYkGG2Jg568JsCOLQgdDx3pmoEogGs+HNAHy3w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UuHVw1rZHNBiEoffKv/i/qgTeFwLpLUR0nUz6ZBRyEV4F3wee06oxzcg7Zc1hClnI
	 GqpzLqwyBBYEsTvHT+eNgWQIC7lK3Bhof/5g3hdnzdBZ0L2Cim146aMddUWiDpcbhG
	 mQxcRUjoDbMCX3DDnk68FeH2A/KoQ4g1JoAL1v8pYLUkYG/bwaOc09STSevHwjG/ao
	 j5G6RY1n7/FrZh4uZvlObTGt7/UMZ3remxIAM8dizp5zCjgwd8HvrBs+ybHZD10I0R
	 1vaSNuvkUQOWBZ/yXEou4OEdQlJFb5WS2mjyXH3e2Rn30Phpt7cZ5d7eWjP0YoyjTi
	 Y1vnTho24hRPg==
Content-Type: multipart/mixed; boundary="===============1760477294720756391=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0fc7647498097b95fa93277a5b41cb0263c321747e7ec889a37b737dc3ab4764@mail.kernel.org>
In-Reply-To: <20260903144433.1716731-10-memxor@gmail.com>
References: <20260903144433.1716731-10-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 09/10] bpf: Mark syscall helpers as sleepable
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 15:52:44 +0000 (UTC)

--===============1760477294720756391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af0..c7bc9ba9b331f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6568,6 +6568,7 @@ EXPORT_SYMBOL_NS(kern_sys_bpf, "BPF_INTERNAL");
>  static const struct bpf_func_proto bpf_sys_bpf_proto = {
>  	.func		= bpf_sys_bpf,
>  	.gpl_only	= false,
> +	.might_sleep	= true,
>  	.ret_type	= RET_INTEGER,
>  	.arg1_type	= ARG_ANYTHING,
>  	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,

Does bpf_btf_find_by_name_kind() need the same treatment?

syscall_prog_func_proto() hands out four helpers to BPF_PROG_TYPE_SYSCALL.
This patch marks two of them. bpf_btf_find_by_name_kind_proto is used by
nothing else in the tree, so marking it has no collateral effect on other
program types.

It can sleep on the module-BTF path:

  bpf_btf_find_by_name_kind()
    -> bpf_find_btf_id()          /* module BTF hit */
    -> __btf_new_fd()
    -> anon_inode_getfd()
       -> alloc_file_pseudo()     /* kmem_cache_zalloc(filp_cachep, GFP_KERNEL) */
       -> get_unused_fd_flags()
          -> alloc_fd()
          -> expand_files()       /* kvmalloc(GFP_KERNEL_ACCOUNT) */

bpf_get_btf_vmlinux() additionally takes mutex_lock(&btf_vmlinux_lock)
(that branch is unreachable at run time because bpf_check() already
populated btf_vmlinux, so the fd-allocation path is the load-bearing one).

Reachability is identical to the case the changelog describes for
bpf_sys_bpf(): a SEC("syscall") program can call bpf_timer_set_callback(),
and the verifier checks that callback in a non-sleepable context while
retaining the syscall helper set. Without .might_sleep on the prototype,
the callback can invoke bpf_btf_find_by_name_kind() from hrtimer softirq
context and trigger the same scheduling-while-atomic failure.

The same issue applies to bpf_rcu_read_lock(), bpf_preempt_disable(),
bpf_spin_lock(), and irq-disabled regions, which in_sleepable_context()
also excludes.

The fourth helper, bpf_kallsyms_lookup_name(), is genuinely non-sleeping
(kallsyms_lookup_name() operates under RCU), so leaving that one unmarked
is correct.

> @@ -6593,6 +6594,7 @@ BPF_CALL_1(bpf_sys_close, u32, fd)
>  static const struct bpf_func_proto bpf_sys_close_proto = {
>  	.func		= bpf_sys_close,
>  	.gpl_only	= false,
> +	.might_sleep	= true,
>  	.ret_type	= RET_INTEGER,
>  	.arg1_type	= ARG_ANYTHING,
>  };

A subsystem pattern flags this as potentially concerning: freplace
(BPF_PROG_TYPE_EXT) programs that replace a global subprog of a syscall
program can no longer call bpf_sys_bpf() or bpf_sys_close(), where they
could before.

An EXT program is never sleepable: can_be_sleepable() does not list
BPF_PROG_TYPE_EXT, and check_attach_btf_id() rejects 'prog->sleepable &&
!can_be_sleepable(prog)' with 'Program of this type cannot be sleepable'.
Consequently do_check_common() sets state->in_sleepable = false for every
EXT program.

At the same time check_attach_btf_id() sets env->ops =
bpf_verifier_ops[tgt_prog->type] for EXT and resolve_prog_type() returns
the saved SYSCALL type, so such an EXT program does get
syscall_prog_func_proto() and previously loaded fine with a bpf_sys_bpf()
call in it.

After this patch that same program is rejected with 'sleepable helper
bpf_sys_bpf#166 in non-sleepable prog', even though the replaced subprog
only ever runs from the sleepable BPF_PROG_TEST_RUN body.

Mitigating context: this limitation already exists for every other
might_sleep helper (e.g. bpf_copy_from_user), no in-tree selftest does
freplace on a SEC("syscall") program, and rejecting is the conservative
direction. Worth a sentence in the changelog since it is a user-visible
loadability change?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33770534313
--===============1760477294720756391==--
