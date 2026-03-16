Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC11922FD;
	Mon, 16 Mar 2026 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702425; cv=none; b=RZyZXwzyzKXXq/pG2PXC5i8hpFAFQnlYHCSqsxyHzoblaEx8PUkNv8IVVaqXm36E25o70m8EkTaTY1/DWCoMJXHZn0En/g9nwtgcgVx+4CpPgCcduanyU9dPAmfFkyq4cnZWPlntd2RfGfM5kveHa7ulnDYZyC3wJyHjdfHdHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702425; c=relaxed/simple;
	bh=Xka1h8TMQNI7zUEdsjMYPgxiw84CKP5QZbK+OMaxUnQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gwiKVa2sry26umGHnwetu2muCDHiz6Mz+fpJun5nE2VQVUXIUGMNej5yASmGOkRQEXmnACejRVm/LHpspCZVbEh8oEixgaMIBe3wsQI0hbg0LwKJLWokMfSbUj/Va2qt30nt1TppkMlAOPFQuyU8kHJSG2Pv2XbXJdQpaWkAU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzUYkEyZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzUYkEyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE00C19421;
	Mon, 16 Mar 2026 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773702424;
	bh=Xka1h8TMQNI7zUEdsjMYPgxiw84CKP5QZbK+OMaxUnQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IzUYkEyZpJpWfKtfJGjbWrj2dH/eMzV90oaN9BdaMIBhpSMkZXQioeiLAxuDeQgYu
	 tlcgkjIAN9PFSW0PZIZwXeSc262OyyU7KzZ9yx5h4HBEMuxF9QghpxZxdCrfRynpav
	 kpMHdUMH70ITKt1gEFoo5y2ERAuZFa5LXtVAAuUszL95GqP1+bZLecQrwQ2DXl7CMk
	 FOKNZZjz6497mTYgAT6MMlVftdzlbWnx1psP9g2IITTUr8mYq+L7oytqFBEFgRXD/K
	 UX6OyQMEWYEPZxzX3b7iDXbFMNqWDnBEuv7wNDlLxGnrxiuMiKhW4WAsJDdegT/1fM
	 ao8A0UxEBklSA==
Content-Type: multipart/mixed; boundary="===============3650128742180216657=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f26b2e80adf36731785c913071bb4d86f2f1d73026c681395c07f2e5e5527d6a@mail.kernel.org>
In-Reply-To: <20260316222758.1558463-1-arighi@nvidia.com>
References: <20260316222758.1558463-1-arighi@nvidia.com>
Subject: Re: [PATCH] bpf: Always defer local storage free
From: bot+bpf-ci@kernel.org
To: arighi@nvidia.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: john.fastabend@gmail.com,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,ameryhung@gmail.com,tj@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Mar 2026 23:07:04 +0000 (UTC)

--===============3650128742180216657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c

[ ... ]

> +static void bpf_selem_unlink_defer_free(struct hlist_head *selem_free_list,
> +					struct bpf_local_storage *local_storage,
> +					bool free_local_storage)
> +{
> +	struct bpf_local_storage_elem *s;
> +	struct hlist_node *n;
> +	struct hlist_head *deferred_selem = this_cpu_ptr(&bpf_deferred_selem_free_list);
> +	struct hlist_head *deferred_storage = this_cpu_ptr(&bpf_deferred_storage_free_list);
> +	struct bpf_deferred_free_rcu *deferred_rcu = this_cpu_ptr(&bpf_deferred_free_rcu);
> +
> +	hlist_for_each_entry_safe(s, n, selem_free_list, free_node) {
> +		hlist_del(&s->free_node);
> +		hlist_add_head(&s->free_node, deferred_selem);
> +	}
> +
> +	if (free_local_storage)
> +		hlist_add_head(&local_storage->deferred_free_node, deferred_storage);

Can these per-CPU lists be corrupted by concurrent access?

This function is called from bpf_selem_unlink() after releasing
local_storage->lock with raw_res_spin_unlock_irqrestore(), so IRQs
are restored. The BPF program context provides migrate_disable()
(keeping the CPU stable for this_cpu_ptr), but IRQs are not masked.

A BPF tracing program (kprobe, perf_event) running at hardirq or
NMI level can interrupt this function mid-hlist_add_head() and call
bpf_selem_unlink() -> bpf_selem_unlink_defer_free() on the same
CPU, modifying the same per-CPU list concurrently. hlist_add_head()
is a multi-step, non-atomic operation, so this interleaving can
lose list entries or corrupt the list pointers.

The same race exists between bpf_deferred_free_work_fn() (running
in process context on the workqueue) and
bpf_selem_unlink_defer_free() called from any BPF program that
interrupts it.

Would something like an llist (lock-free linked list that is safe
against concurrent producers) or local_irq_save/restore around
the list operations be needed here?

> +
> +	if (atomic_cmpxchg(this_cpu_ptr(&bpf_deferred_free_pending), 0, 1) == 0) {
> +		deferred_rcu->cpu = smp_processor_id();
> +		call_rcu(&deferred_rcu->rcu, bpf_deferred_free_rcu_callback);
> +	}
> +}

[ ... ]

> +static void bpf_deferred_free_work_fn(struct work_struct *work)
> +{
> +	struct bpf_deferred_free_work *deferred_work =
> +			container_of(work, struct bpf_deferred_free_work, work);
> +	int cpu = deferred_work->cpu;
> +	struct hlist_head *selem_list = per_cpu_ptr(&bpf_deferred_selem_free_list, cpu);
> +	struct hlist_head *storage_list = per_cpu_ptr(&bpf_deferred_storage_free_list, cpu);
> +	struct bpf_local_storage_elem *selem;
> +	struct bpf_local_storage *local_storage;
> +	struct hlist_node *n;
> +
> +	atomic_set(per_cpu_ptr(&bpf_deferred_free_pending, cpu), 0);
> +
> +	hlist_for_each_entry_safe(selem, n, selem_list, free_node) {
> +		hlist_del_init(&selem->free_node);
> +		bpf_selem_free(selem, true);
> +	}
> +
> +	hlist_for_each_entry_safe(local_storage, n, storage_list, deferred_free_node) {
> +		hlist_del_init(&local_storage->deferred_free_node);
> +		bpf_local_storage_free(local_storage, true);
> +	}
> +}

Does passing reuse_now=true here change the RCU synchronization
domain?

Previously, bpf_selem_unlink() called bpf_selem_free(selem, false),
which for use_kmalloc_nolock elements used
call_rcu_tasks_trace() to wait for a Tasks Trace RCU grace period
before freeing. This is needed because sleepable BPF programs hold
rcu_read_lock_trace() (see __bpf_prog_enter_sleepable()) and can
retain pointers to sdata across sleep points.

With this change, the work function calls bpf_selem_free(selem, true),
which uses regular call_rcu() instead. The full chain becomes:

  bpf_selem_unlink_defer_free()
    -> call_rcu()        [regular RCU grace period]
      -> queue_work_on()
        -> bpf_selem_free(selem, true)
          -> call_rcu()  [regular RCU grace period]
            -> kfree_nolock()

Two regular RCU grace periods do not substitute for one Tasks Trace
RCU grace period -- they are different synchronization domains. A
sleepable BPF program sleeping inside rcu_read_lock_trace() will
not block regular call_rcu() callbacks.

The reuse_now=true path (regular call_rcu) was previously only used
from bpf_selem_unlink_nofail() in the map_free/destroy paths, where
synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace) had already been
called to cover both domains. In this new usage, no Tasks Trace RCU
synchronization occurs before the free.

The same applies to bpf_local_storage_free(local_storage, true)
which similarly changes from call_rcu_tasks_trace() to call_rcu().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23169312812
--===============3650128742180216657==--
