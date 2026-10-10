Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896136F911;
	Sat, 10 Oct 2026 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791616369; cv=none; b=mWg+/FYcRdtCzvtqlM2wqZF1eFzCghgMYjJA2ve4xrYunq1x0WXBQzaNNRPij/+tixgk4kKWk8NbZuPWeCB3V2H99CTL3ZNhObRvfAzLFp+9bldXZwY30YIkehVWNHnZpwL5aRHv+e5OolAwvw4qsiLk4oD0mjzWB4AN47vuoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791616369; c=relaxed/simple;
	bh=RhAjYseecgmquDdNkSU+RBLZLf9ZvOzPVrFTM8UdEhI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E+Tm0fEVvbbqtF92FuR/fEFiqmVdRoifMDJFliMUQD4qQlKtqXHlAI24Cb3TN7Zlid7UCcknUWQtCcjmSp31KJu9ataMx/rcdN4Afjmuf/71ZSIhafE7n8xZi+xP3y9+ZtnrByxuIl26jXXXwT7/L75WJukSKdvl4CAlt2ZFn38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNC84y/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNC84y/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBEA1F000FF;
	Sat, 10 Oct 2026 07:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791616368;
	bh=QMcgnnuWgqpbS2VoYj7i+y0eQKVMONCmXNCk4hNAjoM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YNC84y/lmQV5ndDsmGdJW70Oj+7t80giQMLxNGmVDFey2oVsrGz0c5tQwatXGiCCl
	 Hj54RY4/SoFDbwCnfbwA3WtsUnGbiBeNxyKQrRJK8BCMCOZ7nmzbbTw5kSpHft3xtX
	 OzIkUThGW76okfhTTqxIHHGPSLrugXT1RCIF2Pup14U0q76qua0t2xrR2GcT7hy3UW
	 kMoWrDvZGh9jZ5aywnAWEJiX9hyFCt2RIf8WdfVI2SX5rQrLxfnwk/PQdmv4qbACH+
	 vbjRo+udCVN7ledr3LWCVnGsfU2CShj50xVEAbY1OG4ZkVwrJVgVyK07oFm8sXsgHn
	 Zc8WuE5E6kKOQ==
Content-Type: multipart/mixed; boundary="===============1321710191781011159=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9588d40e70791e4231860ceda453a8fa80c46a5c841107ab59ad0ca7c5d03c38@mail.kernel.org>
In-Reply-To: <20261010-selftests-bpf-struct-ops-assoc-timer-v2-1-d7a43896dbf1@gmail.com>
References: <20261010-selftests-bpf-struct-ops-assoc-timer-v2-1-d7a43896dbf1@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Defer freeing a struct_ops map until its progs are done
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,ameryhung@gmail.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 10 Oct 2026 07:12:46 +0000 (UTC)

--===============1321710191781011159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Defer freeing a struct_ops map until its progs are done

TL;DR: Possible use-after-free of struct_ops kdata/trampoline: the deferred
free uses call_rcu(), which doesn't wait for rcu_read_lock_trace readers
(bpf_wq, task_work, sleepable progs); always using call_rcu_tasks_trace() may
fix it.

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c

[ ... ]

> @@ -1050,7 +1070,15 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>  	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
>  		synchronize_rcu_tasks();
>
> -	__bpf_struct_ops_map_free(map);
> +	/*
> +	 * A prog may have read the association before it was cleared above,
> +	 * e.g. from a timer callback, and may still be running the struct_ops.
> +	 * Free the map only after a grace period that waits for such a prog.
> +	 */
> +	if (map->free_after_mult_rcu_gp)
> +		call_rcu_tasks_trace(&st_map->free_rcu, bpf_struct_ops_map_free_rcu_gp);
> +	else
> +		call_rcu(&st_map->free_rcu, bpf_struct_ops_map_free_rcu_gp);
                ^^^^

Does this grace period wait for every reader of the association?

The commit message says the grace period is "a tasks trace one if the progs
of the map may sleep", but the code does not look at whether the progs may
sleep.  It tests map->free_after_mult_rcu_gp, which is copied from
st_ops->free_after_mult_rcu_gp in bpf_struct_ops_map_alloc().  git grep
finds no in-tree struct_ops that sets that flag (bpf_tcp_ca only sets
free_after_tasks_rcu_gp), so every in-tree struct_ops map, including
bpf_testmod's multi_st_ops and sched_ext, takes the call_rcu() branch.

bpf_prog_get_assoc_struct_ops() reads aux->st_ops_assoc under
bpf_rcu_lock_held(), which also accepts rcu_read_lock_trace().  Async
callbacks of a struct_ops prog run with only that lock held:

  static void bpf_wq_work(struct work_struct *work)
  {
      ...
      rcu_read_lock_trace();
      migrate_disable();
      callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
      migrate_enable();
      rcu_read_unlock_trace();
  }

bpf_task_work_callback() works the same way (guard(rcu_tasks_trace)() plus
migrate_disable()), and is_async_cb_sleepable() in verifier.c says "bpf_wq
and bpf_task_work callbacks are always sleepable".  The bpf_wq kfuncs are
in common_btf_ids, which is registered for BPF_PROG_TYPE_UNSPEC, and
bpf_kfunc_multi_st_ops_test_1_assoc() is registered for
BPF_PROG_TYPE_STRUCT_OPS.

Can this sequence occur on a CONFIG_PREEMPT_RCU kernel, with the
st_ops_assoc_in_timer_free test written with bpf_wq_start() instead of
bpf_timer_start()?

kworker (bpf_wq_work, rcu_read_lock_trace only)
    st_ops = bpf_prog_get_assoc_struct_ops(aux)
        -> &S->kvalue.data
    <preempted, or after __bpf_prog_exit()'s rcu_read_unlock() in the
     trampoline tail>

free path
    bpf_map_put(S) -> ... -> bpf_struct_ops_map_free()
        dissoc_progs();
        call_rcu(&st_map->free_rcu)
    GP ends: this reader is not an RCU reader
    bpf_struct_ops_map_free_rcu_gp() -> queue_work()
        __bpf_struct_ops_map_free()
            bpf_struct_ops_map_free_image();
            bpf_map_area_free(st_map)

kworker
    st_ops->test_1(args)    <- reads freed kdata, or returns into the
                               freed trampoline

sched_ext looks affected the same way, since scx_prog_sched() reads
ops->priv from the kdata that bpf_prog_get_assoc_struct_ops() returns.

struct_ops progs take no reference on the map when they are associated;
bpf_prog_assoc_struct_ops() calls bpf_map_inc() only for non-struct_ops
progs.  So the grace period here is the only thing keeping the map alive,
and call_rcu() does not wait for rcu_read_lock_trace() sections.

This also seems to fix less than the code before the Fixes: commit.  Before
5db69b0fbdc8, bpf_struct_ops_map_free() ran
synchronize_rcu_mult(call_rcu, call_rcu_tasks) after the dissoc, which also
waited for preempted tasks and so covered the trampoline tail for these
preemptible readers.

Since 57b23c0f612d ("bpf: Retire rcu_trace_implies_rcu_gp()") a tasks trace
grace period implies a regular RCU grace period.  Would always using
call_rcu_tasks_trace() here cover all of the readers: BH (bpf_timer), plain
RCU, and tasks trace (bpf_wq, bpf_task_work, sleepable progs)?

The two later commits in the series (49210cd1ca6f and 17c1f2ff6e23) only
change selftests and do not address this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38031235772
--===============1321710191781011159==--
