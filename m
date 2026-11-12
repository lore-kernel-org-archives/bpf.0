Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489977;
	b=tKhC2mPR/ArJcJFbH9bSYEeCNiqXnlj4veLBkYcmUGzzknujgmhsrmB1wwNAiG6xUnW4
	 8OsAjM1d4piNwgXKIzvLRxgV4lFJdBMgAr+rzXt7rB7ojkYQwxm0/jSqwE+WYPrSbaSlj
	 2QqRSdEB26QQoZi/2d1+O6sMnMNGqirQ04cs6McLQWQeil4zpPcU0r0QO5tdYfAuhGflG
	 VOi6efNIU9UJOTPTFf4FctWLx4+fT8yxRjwredF760f47m8HgLT7RUTcXusOhc9x4dq6z
	 IF8ymMMfdWAjXCBj5GaiAQuD+m8pOjeK6c96EO6P11y8Rj2M+yrzIPHSOloNNxd3pDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489977;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=igf95Krua7UgMjmbH7P6vnjzRdRidkRE+YlT5u31rRs=;
	b=nSYJ9GeV31xhPQzueNlb6JE7ecQF90jA3MEx9nh79Hj/zoUl4Ntcv0TWoyPnXXUbMKA7
	 c+LGZEC7CEwhdjilmqB6Npc5IFIwso7C2S+khLClfKJhIY2uxV1ngsX8q0yW8VXRrffIB
	 SRTyOIOPfexVB5m0hJVBEd+MM4gKs3Doc0nyN4o5VqGqeDUOfODInUyVexCFn8i/D3L4F
	 GSFKPWlX9Glw+dbm0ZONzt5KbfM8gEGmtgr50POq9XG4miXbSpTNRl21T/Jwht8TwO0Ca
	 3qoqn2maitS2vLjqPgNIqf8xqb95/VxLH1iu+rJYhpAF7hRPlgOQzjC2v6YIDYzm9hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLV8ZHWQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B8606A321;
	Thu, 12 Nov 2026 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLV8ZHWQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763DB1F00A05;
	Thu, 12 Nov 2026 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794489976;
	bh=igf95Krua7UgMjmbH7P6vnjzRdRidkRE+YlT5u31rRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eLV8ZHWQaX0RM3qtYia866BYNgAmQIGP0By6cZFBsJ+Aza7LrouqSM6YoaSOVkIHb
	 K1itxE9lpTIXaElgh7qm87Sfh9k0VrAiTjJEGGavdORvktNCTwvyui6yNaGQVlpicu
	 Gd8SFqmKiy6cTpeveHyK1cb6B87Kn+4aOmhoTvnjR6pk3nXALz73YRARhw3QHNvoYz
	 dN5mVRGCYgF0qAbdMfhi9AdH7wpjTlJInPFCDx6nySjNgW8w79Yadv6eoNpZ/P/Y+A
	 PizfwO+ybaw0hpAPU3jJyzc/0HT8/RpM+3VIIWfXBhpmZhDaHkj56TX7uMdVtmasqi
	 MSMMa5T1AuDrg==
Message-ID: <sashiko-outbox-211177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] tools/sched_ext: scx_flatcg: Don't strand a cgroup
 on the ENQ_RACE path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20261112130934.563321-6-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev>
 <20261112130934.563321-6-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:26:16 +0000
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
- [Medium] sched_ext: scx_flatcg: cgroup stranding in cgrp_enqueued()
  retry loop
- [Medium] sched_ext: scx_flatcg: 1024-iteration spin in cgrp_enqueued()
  after PNC_RACE
--

commit 183b4752d1564aee66142be30c8948ab1d3f9a90
Author: Tao Cui <cuitao@kylinos.cn>

tools/sched_ext: scx_flatcg: Don't strand a cgroup on the ENQ_RACE path

This commit adds a bounded retry loop in cgrp_enqueued() when
bpf_kptr_xchg(&stash->node, NULL) returns NULL, polling for either the
stashed cgv_node or a non-empty cgroup DSQ before returning.

> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatc=
g.bpf.c
> index 1d168d492203c..5f2b9d0b867a7 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -285,11 +285,24 @@ static void cgrp_enqueued(struct cgroup *cgrp, stru=
ct fcg_cgrp_ctx *cgc)
>  		return;
>  	}
> =20
> -	/* NULL if the node is already on the rbtree */
> +	/* NULL if the node is on the rbtree or in the picker's hands */
>  	cgv_node =3D bpf_kptr_xchg(&stash->node, NULL);
>  	if (!cgv_node) {
> +		/*
> +		 * The node is either back on the rbtree or in the
> +		 * picker's hands; bailing out strands the cgroup. Wait
> +		 * for the picker to resolve and retry.
> +		 */
>  		stat_inc(FCG_STAT_ENQ_RACE);
> -		return;
> +		bpf_repeat(CGROUP_MAX_RETRIES) {
> +			cgv_node =3D bpf_kptr_xchg(&stash->node, NULL);
> +			if (cgv_node)
> +				break;
> +			if (scx_bpf_dsq_nr_queued(cgid) > 0)
> +				break;
> +		}

[Severity: Medium]
Can breaking out of the retry loop on scx_bpf_dsq_nr_queued(cgid) > 0
still strand the cgroup when try_pick_next_cgroup() has already checked
scx_bpf_dsq_nr_queued(cgid) or when the queued task is consumed before it
does?

In try_pick_next_cgroup(), clearing cgc->queued, checking
scx_bpf_dsq_nr_queued(cgid), and stashing cgv_node are not atomic:

tools/sched_ext/scx_flatcg.bpf.c:try_pick_next_cgroup() {
    ...
	__sync_val_compare_and_swap(&cgc->queued, 1, 0);

	if (scx_bpf_dsq_nr_queued(cgid)) {
		bpf_spin_lock(&cgv_tree_lock);
		bpf_rbtree_add(&cgv_tree, &cgv_node->rb_node, cgv_node_less);
		bpf_spin_unlock(&cgv_tree_lock);
		stat_inc(FCG_STAT_PNC_RACE);
	} else {
		cgv_node =3D bpf_kptr_xchg(&stash->node, cgv_node);
    ...
}

If try_pick_next_cgroup() observes an empty DSQ before a second enqueue
completes its deferred DSQ insert, cgrp_enqueued() sees the second task in
the DSQ and bails out while the picker proceeds to stash cgv_node:

CPU0                       CPU1                         CPU2
try_pick_next_cgroup()
  cmpxchg(&cgc->queued,
          1, 0)
  dsq_nr_queued(cgid) =3D=3D 0
                           fcg_enqueue(T0)
                             cgrp_enqueued()
                               cmpxchg(&cgc->queued,
                                       0, 1)
                               kptr_xchg(&stash->node,
                                         NULL) =3D=3D NULL
                                                        fcg_enqueue(T1)
                                                          cgrp_enqueued()
                                                            cgc->queued =3D=
=3D 1
                                                        <T1 inserted in DSQ>
                               dsq_nr_queued(cgid) > 0
                               return;
  kptr_xchg(&stash->node,
            cgv_node)  <-- cgroup stranded

The same stranding happens if T1 is already in the DSQ when CPU1 checks
scx_bpf_dsq_nr_queued(cgid), and another CPU with an active slice for
cgid consumes T1 via scx_bpf_dsq_move_to_local() in fcg_dispatch() before
CPU0 reaches its scx_bpf_dsq_nr_queued(cgid) check.  In both cases
cgv_node ends up in stash->node with cgc->queued left at 1 and tasks in
the DSQ, so subsequent enqueues hit FCG_STAT_ENQ_SKIP and the watchdog
terminates the scheduler with SCX_EXIT_ERROR_STALL.

> +		if (!cgv_node)
> +			return;
>  	}

[Severity: Medium]
Does this loop spin through all CGROUP_MAX_RETRIES (1024) iterations
whenever cgv_node is already on cgv_tree with cgc->queued =3D=3D 0 and an
empty DSQ?

When try_pick_next_cgroup() hits FCG_STAT_PNC_RACE, it clears cgc->queued
to 0 and re-adds cgv_node to cgv_tree without setting cgc->queued back to
1.  Once the queued tasks in that DSQ are consumed, cgv_node remains on
cgv_tree (so stash->node is NULL), the DSQ is empty, and cgc->queued is 0.
On the next fcg_enqueue() for this cgroup, cgrp_enqueued() sets
cgc->queued to 1 and enters the retry loop, but because the current task's
DSQ insertion is deferred until fcg_enqueue() returns, neither
bpf_kptr_xchg(&stash->node, NULL) nor scx_bpf_dsq_nr_queued(cgid) > 0 can
succeed, burning 1024 atomic exchanges and kfunc calls under the rq lock
and widening the window for a concurrent picker to pop and stash cgv_node
after the retries expire.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112130934.5633=
21-1-cui.tao@linux.dev?part=3D5
