Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F03AB498;
	Thu, 10 Sep 2026 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067796; cv=none; b=TbWgyx1pETy37uGx2Mt1ntc9g+4nbYFAOJxRvlB97r3cHLs4eo13ZI6MawbF5mS4ocXeqgEdxDo5tBxoVk7Qf21x6EhfbRx3powSrHaEmTGTguXDU5L689vvGncQWMKTT4MAquERyaGXrTen9U/Jx0uzBlLwG8vy4axlaXXWVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067796; c=relaxed/simple;
	bh=BAdCt9RS3clpRWFXQ2FQLe4e57p616vRG6XQpvCmoiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bUv5T8dAh0BETo07Ktc/rKd88sP5/JsZW9Xqqe/mga03lUWycTTdPB8z3vVSrp8JsOAqvtzEkVrpKf5GK2pL1KqF3qoEdLZcKYXgzA12crP7KJkQ3t7WKG12xZylRV8sSH1DSbtuktWFX3qLafuhPkCAeSYeRsG6E+4Z5wLc4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3ZEWQ1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3ZEWQ1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7C21F00893;
	Thu, 10 Sep 2026 19:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067794;
	bh=jXfsaX1BfQOAVNb87FA7OjU8P/nSxR0EPutIjtn2a+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3ZEWQ1QIJRrcdLlqtLxokcmey9PCv7cLsA+OeWwc2Z5Wtrl68Al6V9WaL4hImpgb
	 XfeYN+hH8aycLhTeP/jiE6AFz+7e3o4i3vt2fRm8kVHEDb/TyB3n0NQ0oraePdHg10
	 Rijny+s8Oh83vPz1HSVnFOR/VQQlbqUnkzyDKZ8fLhRLUbD7OCxeQ/uVyQCrzcMfpK
	 YTnRTCbWMEVu7PfHS8CRtEBD7X+BJ+xPVYd9XpAmfT1t5nbYgfIQrjLKYAtTvFf9+0
	 E8tqd6fTk8Ru994+9n4iH3iI8/i/ybvqNdGiqZPpinZBic8a5/x2bgr85tT4Na9baz
	 s6Tsbefz0aUOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/13] kprobes: Let Tasks RCU recognise tasks
 preempted in an optprobe jump window
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260910-b4-rcu-tasks-preempt-qs-v1-4-d4469f4cc101@toxicpanda.com>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
 <20260910-b4-rcu-tasks-preempt-qs-v1-4-d4469f4cc101@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:16:33 +0000
Message-Id: <20260910191634.5D7C21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Massive performance overhead in the kernel preemption fast-path du=
e to unbounded hash table lookups.
- [High] kprobe_optimizer() frees kprobes without synchronize_rcu(), causin=
g a Use-After-Free when get_kprobe() is called from irqentry_preempt() on i=
dle CPUs.
--

commit c6c38cd5a975e6f9c2037bf63fa6d732d6cd1fab
Author: Josef Bacik <josef@toxicpanda.com>

kprobes: Let Tasks RCU recognise tasks preempted in an optprobe jump window

This patch adds kprobe_in_optimized_region() to determine if an instruction
pointer falls within the bytes of an optimized kprobe. It then updates
rcu_tasks_ip_in_trampoline() to use this check, allowing Tasks RCU to
recognize and hold off grace periods for tasks preempted within these jump
windows.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c

[ ... ]

> +bool kprobe_in_optimized_region(unsigned long addr)
> +{
> +	int i;
> +
> +	for (i =3D 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
> +		if (get_kprobe((kprobe_opcode_t *)addr - i))

[Severity: High]
Could this loop introduce significant overhead in the preemption fast-path?

On architectures like x86, this loop executes up to 18 times, querying the
kprobe hash table via get_kprobe() on each iteration. Since the hash table
can have long chains on systems with many active kprobes, this could result
in thousands of pointer dereferences during a preemption event.

Also, does this introduce a use-after-free risk for interrupted idle tasks?

kprobe_optimizer() unlinks kprobes and frees them after waiting only for
synchronize_rcu_tasks(). Because synchronize_rcu_tasks() explicitly ignores
idle tasks, an idle CPU that is interrupted could end up traversing the
kprobe_table here via get_kprobe() while the kprobe is concurrently freed,
as Tasks RCU will not wait for the idle task's traversal to finish.

> +			return true;
> +	return false;
> +}

[ ... ]

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h

[ ... ]

>  bool rcu_tasks_ip_in_trampoline(unsigned long ip)
>  {
> +	if (kprobe_in_optimized_region(ip))

[Severity: High]
Is it safe to place this expensive check unconditionally at the start of th=
is
function?

When CONFIG_RCU_TASKS_PREEMPT_QS is enabled, rcu_tasks_ip_in_trampoline()
is called on every kernel preemption via irqentry_preempt(). By placing
kprobe_in_optimized_region() before cheaper checks like
core_kernel_text(ip), every preemption event incurs the cost of the loop
and hash table lookups, which could severely degrade system performance.

> +		return true;
> +
>  	if (core_kernel_text(ip))
>  		return arch_rcu_tasks_ip_in_trampoline(ip);
>  	return !is_module_text_address(ip);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-b4-rcu-tas=
ks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com?part=3D4
