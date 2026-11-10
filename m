Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354354;
	b=vqqNEPh34owPA+mvMSU/pSaLcnzJZ7j8HXoBdOXnGRsl7qZWQ5H7r/sd89NIsuzpnCaa
	 Fzfp+sXSOQ8PRZpgkeL6RLOLSGeu33hZoArQGZjHLKc9JPWSJ6Vj8KBGXTafgM0254Hq9
	 BTYz/UvmvjoAU0hAyMpGuRjMhY3GX0/k0oY+6EzhTgTHiQ3xe+2QAAuMMlNYZ3jP4AFch
	 IuOcBSmrYQ0x6dxK1cFCF0CGEL34JMVJj9vqBEtvyJSL2SZGY6CV5OFZeSPvnDLgPSfGP
	 7XH+l38j6aBMEPoqzwFQJHURL/MgCQQ0WO7LrCsnQJKJLNoTSCbfwjAoSOxwdLAOiCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354354;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h/gQGws3srqOcopCEPalDDlGB19mMPGEtbCy+9v/LjE=;
	b=Thl3HuBXgezsR2Patq2agIC5PR6lgtJo0OEmtOKPzA/UEeTXgQbZ8gc+7aY4TrwfL4Oq
	 AxtQoQGkOlgDjPBtKtAX16tbwjQWixdKYhd0oIA2YyBAzu9Sy/RdTWDdPq1iztixHSlru
	 sP6sdUPCmRul6IjwNmX/PKTWUKEe+dQhEG/qzzd/Am/+TpE6NXkYkcqqsl/kMPgH9LYmN
	 vBn/8mCb+Ok4dOjBHic+9Ln4fCFsZA9+Rssxd0EFsGtjMiWt7iGw8+XnzjW+uIPiD8XwC
	 0Qo7YGtH6RIFL49U7N5NxyzqnviJcVKfPlhWFbeCTQmFTT6qlGPe0PxTHPW7dwAnYOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cm0FtVVB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F974606A321;
	Tue, 10 Nov 2026 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cm0FtVVB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5721F0093C;
	Tue, 10 Nov 2026 23:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354353;
	bh=h/gQGws3srqOcopCEPalDDlGB19mMPGEtbCy+9v/LjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cm0FtVVBMkmO9+vN/9oaccy3Od9E+nHNU1lxuwJ031bDH3nasuYKwzrfROrLHsXj5
	 liN7djF4ddXyf0m1ZIsE7eOVZhKzL7eNYbVCA1468na82QG8lMTM1RyvqWByK97ejS
	 WxJK097qlD2GEcV7BEiP/cAjpxgUucJ0OKbZA0O/ROB7tAkS1L00uH84Tk1aVsdLp8
	 hmStlNC9Xr1Z15x9Cel7mgbn+/tvDV7hU2RWxeO+GrAAxVrYAafWVQGH+D1TEmjlYH
	 V26D2EUab3fZYntOiHcrq21ZBDN6yz3/eJ5Ocr8eoQHYH6IxsZbLnWr4hUMIs20s94
	 a5nd5WIh26jow==
Message-ID: <sashiko-outbox-207953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] kprobes: Maintain an rbtree of registered probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261109195517.1090787-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109195517.1090787-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 23:45:53 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] kprobes: double rb_erase() in kprobe_tree_erase() via
  freeing_list
It also noticed 2 related pre-existing issues this patch does not
introduce:
- [Critical] kprobes: missing cooling delay on forced unoptimization in
  unoptimize_kprobe() [1]
- [Critical] kprobes: premature optinsn slot free in
  kill_optimized_kprobe() [2]
--

commit 8d3f55a56b4caad208426449cba53c9ca99b1316
Author: Jiri Olsa <jolsa@kernel.org>

kprobes: Maintain an rbtree of registered probes

This commit adds an address-ordered rbtree for registered kprobes and
keeps it synchronized with kprobe_table across probe insertion, removal,
and aggregator replacement.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2441b9e393438..6be1430a4ebe9 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
[ ... ]
> @@ -395,6 +396,45 @@ struct kprobe *get_kprobe(void *addr)
>  }
>  NOKPROBE_SYMBOL(get_kprobe);
> =20
[ ... ]
> +static void kprobe_tree_erase(struct kprobe *p)
> +{
> +	lockdep_assert_held(&kprobe_mutex);
> +	rb_erase(&p->rb_node, &kprobe_tree);
> +	RB_CLEAR_NODE(&p->rb_node);
> +}
[ ... ]
> @@ -643,6 +683,7 @@ static void do_unoptimize_kprobes(struct list_head *u=
nopt_list,
>  			 * (reclaiming is done by do_free_cleaned_kprobes().)
>  			 */
>  			hlist_del_init_rcu(&op->kp.hlist);
> +			kprobe_tree_erase(&op->kp);
>  		} else {
>  			/*
>  			 * Keep on cooling_list until the quiescence period
> @@ -722,6 +763,7 @@ static void optprobe_finalize_generation(struct optpr=
obe_generation *gen)
>  			 * it will be reclaimed after the next quiescence period.
>  			 */
>  			hlist_del_init_rcu(&op->kp.hlist);
> +			kprobe_tree_erase(&op->kp);
>  			list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
>  			kick_kprobe_optimizer();
>  		} else {

[Severity: High]
Can this regression call rb_erase() twice on &op->kp.rb_node and corrupt
kprobe_tree?

When an unused optimized_kprobe is queued onto freeing_list (for example in
optprobe_finalize_generation(), unoptimize_kprobe(), or
kill_optimized_kprobe()), it calls hlist_del_init_rcu(&op->kp.hlist) and
kprobe_tree_erase(&op->kp).  When optprobe_dispatch_generation() later
dispatches that generation, do_unoptimize_kprobes() walks freeing_list and
calls both functions again on the same probe.

Unlike hlist_del_init_rcu(), which checks !hlist_unhashed(),
kprobe_tree_erase() does not check !RB_EMPTY_NODE(&p->rb_node) before
calling rb_erase().  Because the first erase leaves stale child pointers in
rb_node and sets its parent to itself, the second rb_erase() links live
kprobe_tree nodes to the about-to-be-freed op->kp.rb_node.

> @@ -1006,6 +1048,7 @@ static void unoptimize_kprobe(struct kprobe *p, boo=
l force)
>  					if (!kprobe_gone(&op->kp))
>  						arch_disarm_kprobe(&op->kp);
>  					hlist_del_init_rcu(&op->kp.hlist);
> +					kprobe_tree_erase(&op->kp);
>  					list_move(&op->list, &cur->freeing_list);
>  				} else {
>  					list_move(&op->list, &cur->cooling_list);
> @@ -1021,6 +1064,7 @@ static void unoptimize_kprobe(struct kprobe *p, boo=
l force)
>  				if (!kprobe_gone(&op->kp))
>  					arch_disarm_kprobe(&op->kp);
>  				hlist_del_init_rcu(&op->kp.hlist);
> +				kprobe_tree_erase(&op->kp);
>  				list_move(&op->list, &cur->freeing_list);
>  				kick_kprobe_optimizer();
>  			}

[Severity: Critical]
This problem wasn't introduced by this patch, but in unoptimize_kprobe()
[1], can forced unoptimization of an already-optimized probe free
the probe and its detour trampoline before preempted tasks exit it?

kernel/kprobes.c:unoptimize_kprobe() {
	...
	if (!kprobe_optimized(p))
		return;

	/* Optimized kprobe case */
	if (force) {
		/* Forcibly update the code: this is a special case */
		force_unoptimize_kprobe(op);
	} else {
		list_add(&op->list, &cur->unoptimizing_list);
		kick_kprobe_optimizer();
	}
}

Once a probe finishes optimizing, KPROBE_FLAG_OPTIMIZED is set and op->list
is empty.  When unoptimize_kprobe(p, true) runs (such as from
add_new_kprobe() or disarm_all_kprobes()), force_unoptimize_kprobe(op)
patches the jump back to a breakpoint and clears KPROBE_FLAG_OPTIMIZED,
leaving op->list empty instead of queueing op onto cur->cooling_list.

A subsequent unregister_kprobe() sees kprobe_disarmed(ap) evaluate to true
in __unregister_kprobe_top(), unhashes and erases ap immediately, and waits
only for synchronize_rcu() before freeing struct optimized_kprobe and its
trampoline slot without waiting for a Tasks RCU grace period.  If a task was
preempted inside the detour trampoline before the jump was patched, it
triggers a use-after-free when it resumes.

> @@ -1076,6 +1120,7 @@ static void kill_optimized_kprobe(struct kprobe *p)
>  		if (kprobe_unused(p)) {
>  			if (optprobe_queued_unopt(op) || optprobe_queued_cooling(op)) {
>  				hlist_del_init_rcu(&op->kp.hlist);
> +				kprobe_tree_erase(&op->kp);
>  				list_move(&op->list,
>  					  &optprobe_gens[optprobe_cur_gen].freeing_list);
>  				kick_kprobe_optimizer();

[Severity: Critical]
This problem wasn't introduced by this patch, but in
kill_optimized_kprobe() [2], can killing an aggregator probe that
still has child probes free its optinsn slot while tasks are still
preempted inside the trampoline?

kernel/kprobes.c:kill_optimized_kprobe() {
	...
	if (!list_empty(&op->list)) {
		if (kprobe_unused(p)) {
			...
		} else {
			list_del_init(&op->list);
		}
	}
	op->kp.flags &=3D ~KPROBE_FLAG_OPTIMIZED;

	if (!optprobe_queued_freeing(op) && !optprobe_queued_unopt(op) &&
	    !optprobe_queued_cooling(op))
		arch_remove_optimized_kprobe(op);
}

When kill_kprobe() is called on an aggregator probe that is queued on
unoptimizing_list or cooling_list and still has child probes
(!kprobe_unused(p)), the else branch runs list_del_init(&op->list).  Because
optprobe_queued_unopt() and optprobe_queued_cooling() check queue membership
by walking those lists, detaching op->list first makes both checks return
false.  arch_remove_optimized_kprobe() then frees the detour buffer
immediately without waiting for the pending Tasks RCU grace period.

[1] https://sashiko.dev/#/bug/linux-f9b316b8-64c0-4c88-8de2-81f70a772f7b
[2] https://sashiko.dev/#/bug/linux-cc62e94b-a020-483a-84cb-52080d1d23a0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109194916.1089=
703-1-jolsa@kernel.org?part=3D4
