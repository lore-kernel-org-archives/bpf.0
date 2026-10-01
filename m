Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61883367288;
	Thu,  1 Oct 2026 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790815166; cv=none; b=GAGoGIlXacMHcg6vC31LgX3/IZd91IjTAYDkvtkc/h51GcpBd+fwcZjl5QclC0Dk0S4BI2EZ27mhBA36oVaoFfdRXPw+o5V6JCeMpNq66N82vDzIXgcxGm4+oj/QdJuFr+8+4cDs7uMtegi1rGGl1PuwLlRzf2VmOaayCxJhidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790815166; c=relaxed/simple;
	bh=gLcNXKvN5l1gLQ5/IPXxb1P7dwV1VTfDrTMXVvhDgvI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A1SST+7LsSND32uIjygwwe5NujA5Gkhsdzm32pwFLa5dsFolPV09PUxb5pYRW0PVIwJjHODfNoP5m+dyvBB9EXHSMM4rpBYftMqEcKuhOY58p04N99MxUY/qC3uarQavFGpR2X+2xEzDAFiKeb8+JnVPcrzo8j3Mdv6V865qzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jahA/JvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jahA/JvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EDD1F000FF;
	Thu,  1 Oct 2026 00:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790815164;
	bh=XgQTEzHx5pkCbzsSm+Q+21RjS2mD6HVxL2V8EVoHcIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jahA/JvTUyG43sRsQd/wapWzeIuJvqG7Iy0z/FEeW5QbzWaeyRjLdFUPMeI8h2jIR
	 lugTB4Dvr0GTUtXxrJNSLTnbgg4ttIeGvWzO97oOGVhNLeOTuZe4VvR5F1IsUtBDfC
	 0LBhbGMaBOzfpabjLRwPEETHSxUb6mcULg0t9nIeL1omqk0cW8gXm/PBOsq/GlWdmP
	 YpudE3QIYXnxhiBdO88qF77dNPUmliLknF5zmC4HB5/gAvh8S4XLSv1RjsbkSueczn
	 VIoW7OqJ3WqhAW31A9J7nUxc0LkbE57nPzhbXZNJ69trEgQIiJWX8SKiO0gzAZxiWD
	 hvS9TeTtwMTWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/1] kprobes: Make optprobe optimizer
 multi-generational and asynchronous
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179081404279.474106.13678745887307618561.stgit@devnote2>
References: <179081403098.474106.12959530220684805449.stgit@devnote2>
 <179081404279.474106.13678745887307618561.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 00:39:24 +0000
Message-Id: <20261001003924.A6EDD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kprobes: orphaned INT3 breakpoint and UAF on unregistered cool=
ing probes
--

commit 03a24f729b70417a26e91442518daed709d91828
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

kprobes: Make optprobe optimizer multi-generational and asynchronous

This commit replaces synchronize_rcu_tasks() with call_rcu_tasks() and
introduces a multi-generational ring to queue probe optimizations and
unoptimizations without blocking or dynamic allocations. Locks are now held
only briefly to patch instructions rather than across the entire Tasks RCU
grace period.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 4edd8ca5c6578..f92039e2561cf 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
[ ... ]
> @@ -624,67 +696,144 @@ static void do_free_cleaned_kprobes(void)
[ ... ]
> +static void optprobe_finalize_generation(struct optprobe_generation *gen)
> +{
> +	struct optimized_kprobe *op, *tmp;
> +
> +	lockdep_assert_held(&kprobe_mutex);
[ ... ]
> +	/* Finalize unoptimized kprobes whose quiescence period completed */
> +	list_for_each_entry_safe(op, tmp, &gen->cooling_list, list) {
> +		if (kprobe_unused(&op->kp)) {
> +			/*
> +			 * Unregistered while quiescence period was in flight.
> +			 * Move to cur_gen's freeing list for release afterwards.
> +			 */
> +			list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
> +			kick_kprobe_optimizer();

[Severity: Critical]
Does moving this unregistered probe to the freeing_list skip necessary clea=
nup
steps, leading to an orphaned INT3 breakpoint and a use-after-free?

When optprobe_finalize_generation() sees that the probe is unused and moves=
 it
to freeing_list here, it doesn't call arch_disarm_kprobe() or
hlist_del_init_rcu().

Later, when do_free_cleaned_kprobes() frees the struct via free_aggr_kprobe=
(),
the probe remains hashed and the breakpoint remains armed in the kernel tex=
t.
When the CPU executes the orphaned breakpoint, it will dereference the freed
kprobe struct, leading to a crash.

> +		} else {
> +			/* Still in use; now safely disarmed */
> +			list_del_init(&op->list);
> +			if (!kprobe_disabled(&op->kp))
> +				optimize_kprobe(&op->kp);
> +		}
> +	}
[ ... ]
> @@ -819,7 +1010,17 @@ static void unoptimize_kprobe(struct kprobe *p, boo=
l force)
>  				 * in the freeing list for release afterwards.
>  				 */
>  				force_unoptimize_kprobe(op);
> -				list_move(&op->list, &freeing_list);
> +				list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
> +				kick_kprobe_optimizer();
> +			}
> +		} else if (optprobe_queued_cooling(op)) {
> +			if (force) {
> +				/*
> +				 * Already unoptimized, move to freeing list for
> +				 * release afterwards.
> +				 */
> +				list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
> +				kick_kprobe_optimizer();
>  			}
>  		} else {

[Severity: Critical]
Does this logic correctly handle the case when force is false?

When force is false (which is the default when __disarm_kprobe() calls it),
this block does nothing, leaving the probe on the cooling_list.

Because the probe is left on the cooling_list, kprobe_queued() evaluates to
true during __disarm_kprobe(). This causes arch_disarm_kprobe() to be
skipped, deferring the removal of the INT3 breakpoint. Similarly,
__unregister_kprobe_top() skips hlist_del_rcu(), leaving the probe in the
global hash table.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179081403098.474106=
.12959530220684805449.stgit@devnote2?part=3D1
