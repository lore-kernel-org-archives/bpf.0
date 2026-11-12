Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490363;
	b=NscifPR/hORFY/Ba2KzMCwVzE/h9QqkFb8E5E5k9f+YX1IxQIe+LL8aSBXKERVdQ9Wx4
	 H/DsldcFKd6VgGCZBtrzYYXWEw2Qx3Ij6NYpCxLkY7wfatIxbF0ZPiahYMovF7IkVHtyf
	 zNmf07RMiBJmV5VZAMQvTPrW9m6UUFEIm8V784MJUbFKXwSpgWvyrXMWFtxxhwDkOq4qv
	 7OHxd5ApJHiYMHtEoF4Or5a6wKKywek36fa1TPKwAt8NXBZwZxbYzScs8uE/g2szno/BP
	 D/39AroJG6hQ8zJBHcUkkw7LJfdG2g7z21qCTD6qSAfsBZgM9yY3jeh32tvtf66DLNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490363;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eKMKE7XskBDbmVsMIKAhMC56PR/QzBT4TjX0HXJpmzU=;
	b=hb8a52P1tp43IohbFt5OecBgbAFBE/Yw6N7IJgDI83U/SwhuYXV9fLUwY4Tj7gszkkcu
	 bExs1EkbB8uj1mHJR2njzvfnod3PPUqmhMowV9DYuguSJhLV6shB12f48IMVs3/Q8uy/E
	 JnHsJSRvtLONES6oYTaVHnI9h2iGbxe36q4yiNypMEtbSQMvFXTup4Jd10kEHtYZhsR3w
	 3ZoH9dcEHNf72hs0WfYzJWBBaqR9f1SJ36KBilYTSpMuvHnnqqs4OvvhczSPhgZmMc0KT
	 tx5eoLWRRyAyqFTZ4YHfpWqyKeFKdR1BTtuXyygvIEl5pJmJqhb9by5BGJwmaN+bfgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtNNoa30;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9589606A323;
	Thu, 12 Nov 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtNNoa30
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB7C1F00A05;
	Thu, 12 Nov 2026 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490362;
	bh=eKMKE7XskBDbmVsMIKAhMC56PR/QzBT4TjX0HXJpmzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtNNoa30tV3jQrmx0bdCklDmMHae2uEtbiZES+EEzdGTX7Ss2Bc+qzx+vYdIui3z8
	 ZDNmO7XAlPFNlS8I6lTlHR2g2gByzawtbiyz3xnS79D6Zje/PwQW64P4ez3pPHmN5c
	 O95R2t4k9YlydsvSqWy7F5Y4Fcxl1KPvbsVA1doDvaDvrMt4ry3b5WDguSeCFiLGzm
	 0VfhQorwdbHrhRVVSe4xwejIV+55ynXyka/+CbrcRQ/9fopwdh7t1mNYsIjBzEtHyv
	 6LHiv4DaNqVl//RlmS+fvBf2TKWUt6hfyHQwukJLp1LlU20WT2MnWhi5zZRDV8N85+
	 hh2aMoofFfbEA==
Message-ID: <sashiko-outbox-211192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] sched_ext: Clear the built-in idle masks on CPU
 hotplug transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20261112130934.563321-7-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev>
 <20261112130934.563321-7-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:32:41 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] sched_ext: offline CPU re-sets idle mask bit after
  scx_idle_clear_cpu()
- [Medium] sched_ext: scx_idle_test_and_clear_cpu() claims inactive CPUs
  during hotplug
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] sched_ext: data race on shared idle_smts mask in
  scx_idle_test_and_clear_cpu() [1]
--

commit 0e2a7b76afc726a460e91d0e19897631e59a961f
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext: Clear the built-in idle masks on CPU hotplug transitions

This commit clears a hotplugged CPU from the built-in idle masks in
handle_hotplug() and rejects offline CPUs in scx_idle_test_and_clear_cpu().

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 7d7e2a2fc5ae8..984d9224ab59c 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4358,6 +4358,13 @@ static void handle_hotplug(struct rq *rq, bool onl=
ine)
>  	if (scx_enabled())
>  		scx_idle_update_selcpu_topology(&sch->ops);
> =20
> +	/*
> +	 * Keep the built-in idle masks in sync with the hotplug state: an
> +	 * offline CPU must stop being advertised as idle and a CPU coming
> +	 * back must not inherit a stale idle bit.
> +	 */
> +	scx_idle_clear_cpu(cpu);

[Severity: Medium]
Does the dying CPU re-set its bit in idle_cpus right after
scx_idle_clear_cpu() clears it?

During CPU teardown, handle_hotplug() runs at CPUHP_AP_ACTIVE, before
take_cpu_down() runs at CPUHP_TEARDOWN_CPU and parks migration/N.  When
migration/N parks and switches the dying CPU back to rq->idle so do_idle()
can halt it, set_next_task_idle() -> __scx_update_idle() calls
update_builtin_idle(cpu, true), which does not check whether the CPU or
runqueue is online and sets the bit in idle_cpus again.

Because normal tasks have their affinity restricted to online CPUs and BPF
schedulers typically pass task affinities to scx_bpf_pick_idle_cpu(), the
claim path in scx_idle_test_and_clear_cpu() is not reached for the offline
CPU.  Read-only consumers such as scx_bpf_get_idle_cpumask() and the
!cpumask_empty(idle_cpumask(waker_node)->cpu) check in scx_select_cpu_dfl()
therefore still see the offline CPU marked idle for the entire offline
window.  Gating idle=3Dtrue updates in __scx_update_idle() or
update_builtin_idle() on the CPU/rq online state would prevent the dying
CPU from re-setting the bit.

> diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
> index 922fbc3065ccf..ff0c5402886e6 100644
> --- a/kernel/sched/ext/idle.c
> +++ b/kernel/sched/ext/idle.c
> @@ -107,6 +107,18 @@ static bool scx_idle_test_and_clear_cpu(int cpu)
>  			__cpumask_clear_cpu(cpu, idle_smts);
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but nothing serializes
[1] concurrent updates to the shared idle_smts mask in
scx_idle_test_and_clear_cpu().  Both cpumask_andnot() and
__cpumask_clear_cpu() perform non-atomic read-modify-write operations on
the bitmap words:

CPU0                                CPU1
scx_idle_test_and_clear_cpu()       scx_idle_test_and_clear_cpu()
  cpumask_andnot()                    cpumask_andnot()
    val =3D *word;                        val =3D *word;
    val &=3D ~smt0;                       val &=3D ~smt1;
    *word =3D val;                        *word =3D val;  <-- CPU0 clear lo=
st

A lost clear leaves a core that is no longer wholly idle marked in
idle_smts, causing SMT-aware idle selection to place tasks on busy sibling
threads instead of idle cores.

> +
> +	/*
> +	 * An offline CPU is never an idle candidate, but its bit can
> +	 * linger past @cpu going offline: the dying CPU keeps re-picking
> +	 * its idle task until it halts, which can happen after the
> +	 * hotplug paths have already run. Drop the stale bit and refuse
> +	 * the claim.
> +	 */
> +	if (unlikely(!cpu_online(cpu))) {
> +		cpumask_clear_cpu(cpu, idle_cpus);
> +		return false;
> +	}
> +
>  	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
>  }

[Severity: Medium]
Can scx_idle_test_and_clear_cpu() still claim a CPU while it is inactive
during hotplug transitions?

On teardown, sched_cpu_deactivate() clears cpu_active(cpu) and
handle_hotplug() clears SCX_RQ_ONLINE at CPUHP_AP_ACTIVE, while
cpu_online(cpu) stays true until __cpu_disable() runs at
CPUHP_TEARDOWN_CPU.  Likewise on bringup, cpu_online(cpu) is set before the
CPU reaches CPUHP_AP_ACTIVE and sets cpu_active(cpu) and SCX_RQ_ONLINE.  If
cpuhp/N blocks during either window (for example in synchronize_rcu() or a
sleepable ops.cpu_offline() / ops.cpu_online() callback), switching to
rq->idle marks the CPU in idle_cpus, and scx_idle_test_and_clear_cpu() will
allow claiming it because cpu_online(cpu) is true.  select_task_rq() then
rejects the pick via !is_cpu_allowed() (which requires cpu_active(cpu) for
non-kthreads) and falls back with SCX_EV_SELECT_CPU_FALLBACK.  Checking
cpu_active(cpu) (or scx_rq_online(cpu_rq(cpu))) here would avoid claiming
CPUs that cannot accept tasks yet.

[1] https://sashiko.dev/#/bug/linux-ca6a3761-220e-4ce4-924a-d7356268acdd

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112130934.5633=
21-1-cui.tao@linux.dev?part=3D6
