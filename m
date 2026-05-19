Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5132E128
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231262; cv=none; b=urkqHsSJ+maKdKc7ddqVSy9V757qMILYzKXVphrRFbW7IdZy4O7j+Oq43RJEArxX4JVVzrShlX8tdVOhBpVkGhe2mQCRZyOCDME1dwvPD416ysnSpEreqC1pGR23lr1PkCEDeU+SkX/5mlWfIW0g03cPnPSKJIzDs4/6QqcBfcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231262; c=relaxed/simple;
	bh=maCKmj2jhr8gbJuQOa9X7/0M8ivxfG/WhXgHYSIHkic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aPNq0Eg06ctZUB/U3VvPKdzGV9tD9Vm2BBd5PXRdnZbepNbrev0Mq2EpJtzQCK9LiUPUoID3oIXMIV0bqt9jdVd6EM9BCVBCU0dvL/UBu9A1JNjVA+lOER+GGXa8VzbF1JzEwLl8Eyjq6np1mMUF8s6teF88d2rIaXmmWJkyZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBLKSkVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBLKSkVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBCC1F000E9;
	Tue, 19 May 2026 22:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779231261;
	bh=dhuWHhqgE+4S2bKdak3szmagWWb8OCf4rtM31WKEyxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VBLKSkVUSBLuvrNSQqb9m99+N1RnvIbBrQHVhZdHNmDJTuoMH2sjNc0SuNfd4vc28
	 NBn2gxl3HKbP0CAGhaPkHvGRbG/RP4MWG8ic5HAG4oc6IOV6mxk7SrY++/ldKbSbx1
	 6k3V/obQljkkdjZQBYeChHEPnWuRdq2OnAg9pn3eE4avTmv4CHlWLBq8CUkmxN5uSc
	 rs5yhtrMoRV/bSWuegnU0fFO9YMLUThjnAOlAzesRPKE03ZPNYVMS8AFffaoWkr17C
	 wpk4lVAPYj1hz/Fa5hZUSqcvmY0wxPp/7Xu/FLwjhVVlGHJUzvGep1nWCF7O0eRBLm
	 KUBSAUMdHr2iA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 02/12] bpf: Make struct_ops tasks_rcu grace
 period optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519215841.2984970-3-martin.lau@linux.dev>
References: <20260519215841.2984970-3-martin.lau@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 22:54:20 +0000
Message-Id: <20260519225421.3CBCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The patch incorrectly skips the Tasks RCU grace period (`synch=
ronize_rcu_tasks()`) before freeing executable trampoline memory for all `s=
truct_ops` except `tcp_congestion_ops`, leading to Use-After-Free of execut=
able memory.
- [High] RCU-001 violation: `bpf_struct_ops_map_dissoc_progs()` removes the=
 map from `prog->aux->st_ops_assoc` after the regular RCU grace period has =
already completed, leading to a Use-After-Free.
--

commit 85a451ad8aefbb364a1840344e08d2f34596b96c
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Make struct_ops tasks_rcu grace period optional

This commit makes the tasks RCU grace period optional during struct_ops map
freeing. It introduces a map_free_pre_rcu callback to remove ksyms before t=
he
regular RCU grace period. The tasks RCU grace period is now only explicitly
requested by tcp_congestion_ops.

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 08791180d71d9..28eab24ef0ed0 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -996,24 +1005,8 @@ static void bpf_struct_ops_map_free(struct bpf_map =
*map)
> =20
>  	bpf_struct_ops_map_dissoc_progs(st_map);

[Severity: High]
Does this violate the RCU remove-before-reclaim rule?

Because map->free_after_rcu_gp is set to true in bpf_struct_ops_map_alloc(),
the regular RCU grace period occurs before bpf_struct_ops_map_free() is cal=
led.
Leaving bpf_struct_ops_map_dissoc_progs() here means the map is removed
from prog->aux->st_ops_assoc after the grace period has already finished.

Could a concurrent execution of the BPF program acquire the RCU read lock, =
read
the still-valid aux->st_ops_assoc pointer, and then access the map after it=
 is
freed?

Should bpf_struct_ops_map_dissoc_progs() be moved to the new
bpf_struct_ops_map_free_pre_rcu() callback instead?

> -	/* The struct_ops's function may switch to another struct_ops.
> -	 *
> -	 * For example, bpf_tcp_cc_x->init() may switch to
> -	 * another tcp_cc_y by calling
> -	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> -	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> -	 * and its refcount may reach 0 which then free its
> -	 * trampoline image while tcp_cc_x is still running.
> -	 *
> -	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> -	 * to finish. bpf-tcp-cc prog is non sleepable.
> -	 * A rcu_tasks gp is to wait for the last few insn
> -	 * in the tramopline image to finish before releasing
> -	 * the trampoline image.
> -	 */
> -	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
> +	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
> +		synchronize_rcu_tasks();
> =20
>  	__bpf_struct_ops_map_free(map);
>  }

[Severity: Critical]
Does skipping the Tasks RCU grace period for other struct_ops cause a
use-after-free of executable trampoline memory?

All struct_ops programs are executed via dynamically generated trampolines.=
 When
the program returns, the RCU read lock is dropped and preemption is re-enab=
led.
If a task is preempted while still executing the trampoline epilogue, the
regular RCU grace period will not wait for it.

Without the Tasks RCU wait, could the executable trampoline image be freed
prematurely, causing preempted tasks to execute freed memory when they resu=
me?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519215841.2984=
970-1-martin.lau@linux.dev?part=3D2
