Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6334A3AC
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873972; cv=none; b=DEUi+MoB40TI7CG8AxXUHIekq1UjkHyZZ2zpV2UYsFbTShmKab1zR4PC6wHvg339YfG931n751zn++Sp85Li7azK/UFgPIFuCit8auXkbUXd7KdTGzFrMD+lKAuPUuElufKc69WRSdOf6SpGKRoKjY2Ijkmu5AYTmAWsAcfKh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873972; c=relaxed/simple;
	bh=8nrncI0b3MfZ0b4cQQe2KIvUt8Ue5oypaj72/hFZA6E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PxS/1LiJZYPHCC7VyTiCCwy25IKbTjtNKqJygE0MxNQ77ty3b0stmXMqSMLoAzQUlMMAnxr5doCxhqiT9cAL33WzLOdx49ccsbCzbSBr8CaGEcXhnDhVPzaymt/7w++egGZ6MJxqkxMnSgEH6PQnPvF76XbzxNMhnITndkpkc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8rfD/Ke; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8rfD/Ke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F33C19425;
	Wed, 22 Apr 2026 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776873972;
	bh=8nrncI0b3MfZ0b4cQQe2KIvUt8Ue5oypaj72/hFZA6E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=I8rfD/KeOTX1uZPEWfwQAVB/oJiNBaXYk5hzIOVAbIcjmYVD6bwGdqQpNyo1rGKFP
	 PbVNob7aZneoYNz+ugUOPrmL7rDlm94LgupAgErtSJqoGsfkNQoqIBFnGt2sS5EArY
	 vcKALC+jU9gVkyN8TvURUQW3yzzuES4oO/28s36UCLB2GCt/JyWXBzb8gYFgqFcmUq
	 /fdIEAgftu/LtkVvHziE7lJ/Y8LgJYGdz1srTc0gHdVxbyfODLDUCFLQtnT9lIs8nC
	 MeI/lBmygW7KjZ3sH4qbrnle737Ou9bRuqHcUpJoK5R5Dfnrale9d7jvbTE47Cw/Mv
	 6wMilORsCJJFA==
Content-Type: multipart/mixed; boundary="===============2422465214652397599=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e93b3ecc3e3406ac70466f8083544d896295f6fbb3f07c8e5a059fa25f8f19b2@mail.kernel.org>
In-Reply-To: <20260422-sleepable_tracepoints-v12-2-744bf0e3b311@meta.com>
References: <20260422-sleepable_tracepoints-v12-2-744bf0e3b311@meta.com>
Subject: Re: [PATCH bpf-next v12 2/6] bpf: Add bpf_prog_run_array_sleepable()
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,peterz@infradead.org,rostedt@goodmis.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Apr 2026 16:06:12 +0000 (UTC)

--===============2422465214652397599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3079,6 +3079,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>  void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
>  void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
>
> +static __always_inline u32
> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
> +			     const void *ctx, bpf_prog_run_fn run_prog)
> +{
> +	const struct bpf_prog_array_item *item;
> +	struct bpf_prog *prog;
> +	struct bpf_run_ctx *old_run_ctx;
> +	struct bpf_trace_run_ctx run_ctx;
> +	u32 ret = 1;
> +
> +	if (unlikely(!array))
> +		return ret;
> +
> +	migrate_disable();
> +
> +	run_ctx.is_uprobe = false;
> +
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +	item = &array->items[0];
> +	while ((prog = READ_ONCE(item->prog))) {
> +		/* Skip dummy_bpf_prog placeholder (len == 0) */
> +		if (unlikely(!prog->len)) {
> +			item++;
> +			continue;
> +		}
> +
> +		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> +			bpf_prog_inc_misses_counter(prog);
> +			bpf_prog_put_recursion_context(prog);
> +			item++;
> +			continue;
> +		}
> +
> +		run_ctx.bpf_cookie = item->bpf_cookie;
> +
> +		if (prog->sleepable) {
> +			guard(rcu)();
> +			ret &= run_prog(prog, ctx);
> +		} else {
> +			ret &= run_prog(prog, ctx);
> +		}

The sleepable/non-sleepable branches appear inverted relative to
bpf_prog_run_array_uprobe(). In the uprobe sibling at
include/linux/bpf.h:2491-2526, classic RCU is acquired only for
non-sleepable programs:

  while ((prog = READ_ONCE(item->prog))) {
      if (!prog->sleepable)
          rcu_read_lock();
      run_ctx.bpf_cookie = item->bpf_cookie;
      ret &= run_prog(prog, ctx);
      item++;
      if (!prog->sleepable)
          rcu_read_unlock();
  }

Here, the condition takes classic RCU (guard(rcu)() expands to
rcu_read_lock()/rcu_read_unlock() via DEFINE_LOCK_GUARD_0 in
include/linux/rcupdate.h:1181) around sleepable programs while taking no
RCU read-side lock for non-sleepable ones.

Sleepable BPF programs are designed to fault and sleep. Executing them
inside a classic RCU read-side critical section violates the RCU
requirement that classic readers must not block. On CONFIG_PREEMPT_RCU=n
kernels this can cause RCU stalls.

Meanwhile, non-sleepable BPF programs often rely on classic-RCU-protected
structures (like classic RCU-protected map entries). Invoking them with no
classic RCU read-side critical section weakens protection. The caller added
in the subsequent commit 864dee5d55d1 holds only guard(rcu_tasks_trace)(),
so no outer classic RCU protects these accesses.

Should the condition be inverted to match the uprobe pattern?

This was raised by Alexei Starovoitov in v11 review:
https://lore.kernel.org/bpf/DHZ4I3RWVVCU.16XRZX1HPFI8K@gmail.com/

Alexei suggested in his April 21st comment:

  "Why grab rcu_read_lock() and undo it?
  imo it would be cleaner and faster to do
  bpf_prog_get_recursion_context() here ...

  ... and then here:
  if (!prog->sleepable) {
    guard(rcu)();
    ret &= run_prog(prog, ctx);
  } else {
    ret &= run_prog(prog, ctx);
  }"

Was this feedback addressed in v12?

> +
> +		bpf_prog_put_recursion_context(prog);
> +		item++;
> +	}
> +	bpf_reset_run_ctx(old_run_ctx);
> +	migrate_enable();
> +	return ret;
> +}
> +
>  #else /* !CONFIG_BPF_SYSCALL */
>  static inline struct bpf_prog *bpf_prog_get(u32 ufd)
>  {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24787752194
--===============2422465214652397599==--
