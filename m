Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B4415F07
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270643; cv=none; b=rYuL0SgbQIgIvBSK7QB5aQWb4l3n2ORFkzIH1u5y7BYac5eus3u3VzpC2M3pxMrz34J3+xA+p51JxmRAdAsv5gBdxeIyziLeTIg4yQkYQihlp2MrvTPOzSJeZtcLJFzSrSTazJPE8TUmP8NDnHvj8oQzC5KH94S9PWPd/o9gwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270643; c=relaxed/simple;
	bh=fNIwVcgHFU2qHtr3w++DhN9CJTCCBwH65Ug7TwwItEc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MM4GaCS/xeboGtIcTsxGGAT2pGzQTNNZf4HHV+2z1xO5dOONFhQJ71dv2AZKMP6RNCshBJ+OroLZsOQ3iERytSUAKNGVVwFhmsIrHV89XHRN292uxEnNpMPwREH/jq99+KkfFRlNNf5oRpCOspx7fQNyQNqV12EA2PSj/g1TVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM8ULo9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM8ULo9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA4B1F000FF;
	Thu, 24 Sep 2026 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270641;
	bh=NXBk+5UE0cPNcHlgU3nVdTpDPpA1lM7AqgZ4MdlktBQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gM8ULo9+pjuyoWKd8AW7DnWNoQELUZKJ+dibFNTCNdUpUEtd11kkU6tpjvoE4RtrY
	 QAqtcdjD+hU3xX8FjqPQeoPBJU8IRQgn6FRiiK5TM2iEjzP3Pul01Z2bg+vyVa7ZPo
	 RojchCl3CV8tfzTmCyUrKQM2tzwWWuBv0BoRVIRvbDmjOM4ljRofAG5vzHemc8+OvT
	 Jx8srAseexuonkT4U5mnTsMtO5W2Q40FLPqSdq+SsrZTlZMLC8u8sC7qjnF9Zg873H
	 vmaCkQLK2WtNAnYKIS7+83VzF5771l1MSfAU1lsRx0rhl7Uact5IfkJXS4LMvMR9zk
	 i6ID52Zuqxnng==
Content-Type: multipart/mixed; boundary="===============4135117493470358329=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d2eef34ce2684bcc39a82067f94c7eefab1d794f2a0b04dfa252871d93ff1f7f@mail.kernel.org>
In-Reply-To: <20260924162858.2435106-3-puranjay@kernel.org>
References: <20260924162858.2435106-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add bpf_call_rcu tests for hash and LRU hash maps
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 17:23:59 +0000 (UTC)

--===============4135117493470358329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add bpf_call_rcu tests for hash and LRU hash maps
>
> Each of these checks the element a callback was armed on is still the one
> it runs on, by the value it sees.
>
> hash_delete arms, deletes, then inserts another key, which would be handed
> the freed element straight back off the freelist. hash_np does the same on
> a BPF_F_NO_PREALLOC map, which frees to bpf_mem_alloc instead.
> hash_replace replaces the key twice, which is how a preallocated map
> recycles through its per-CPU spare. reuse arms an element that has already
> been deleted and recycled. lru_evict floods a two-entry map and checks the
> armed element was not evicted. hash_chain checks a re-arm from the callback
> of a deleted element is refused.

Does the opening sentence accurately describe all the tests listed?  The
claim "Each of these checks the element a callback was armed on is still
the one it runs on, by the value it sees" holds for hash_delete, hash_np,
hash_replace, and lru_evict, which assert the callback value matches the
armed value (hash_cb_val == 0xbadc0de or lru_cb_val == 0xfeedface).

However, test_call_rcu_reuse() only checks that the arm succeeds
(ASSERT_OK(skel->bss->reuse_arm2)), and reuse_cb() is just `return 0;`
with no value check.

test_call_rcu_hash_chain() asserts hash_chain_err == -EBUSY and
hash_callbacks == 1, but never checks hash_cb_val.

The stress test (stress_reclaim) only counts callbacks and never looks at
the value either.

Could the opening sentence be narrowed to the four tests it actually
describes (hash_delete, hash_np, hash_replace, lru_evict)?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/call_rcu.c b/tools/testing/selftests/bpf/progs/call_rcu.c
> index 505008647fd6..f3ad92729800 100644
> --- a/tools/testing/selftests/bpf/progs/call_rcu.c
> +++ b/tools/testing/selftests/bpf/progs/call_rcu.c

[ ... ]

> +/* Arm a hash element, then delete it before the callback can run. */
> +SEC("syscall")
> +int arm_hash_then_delete(void *ctx)
> +{
> +	struct elem init = {};
> +	__u32 key = 7;
> +	struct elem *e;
> +
> +	init.val = 0xbadc0de;
> +	if (bpf_map_update_elem(&hash, &key, &init, BPF_ANY))
> +		return 1;
> +
> +	e = bpf_map_lookup_elem(&hash, &key);
> +	if (!e)
> +		return 2;
> +
> +	arm_err = bpf_call_rcu(&e->rh, &hash, hash_reclaim);
> +	if (arm_err)
> +		return 3;
> +
> +	if (bpf_map_delete_elem(&hash, &key))
> +		return 4;

Can a grace period elapse between the arm and the delete?  The program is
SEC("syscall"), which runs from bpf_prog_test_run_syscall() under
rcu_read_lock_trace() and bpf_prog_run_pin_on_cpu().  That only disables
migration, not preemption.

With CONFIG_PREEMPT=y (set in tools/testing/selftests/bpf/config.x86_64),
the task can be preempted between the bpf_call_rcu() and the
bpf_map_delete_elem().  If the grace period completes in that gap,
hash_reclaim() runs on a live element.  Its re-arm succeeds, hash_chain_err
becomes 0, and hash_callbacks goes to 2.  The delete then claims the
re-armed element.  The second callback runs and only then gets -EBUSY.

The test would then fail when it checks:

prog_tests/call_rcu.c:test_call_rcu_hash_chain():
    ASSERT_EQ(skel->bss->hash_chain_err, -EBUSY, "chain_refused");
    ...
    ASSERT_EQ(skel->bss->hash_callbacks, 1, "hash_callbacks");

The same window affects arm_lru_then_evict().  If lru_reclaim() completes
before or during the bpf_for() flood, the element is no longer busy.
htab_lru_map_delete_node() evicts it, lru_still_present becomes 0, and the
assertion fails:

    ASSERT_EQ(skel->bss->lru_still_present, 1, "lru_still_present");

The existing arm() program in this file already guards against this:

progs/call_rcu.c:arm():
    e->val = 0xdeadbeef;
    /* Keep a grace period from elapsing between the two arms. */
    bpf_rcu_read_lock();
    arm_err = bpf_call_rcu(&e->rh, &arr, reclaim);
    ...
    bpf_rcu_read_unlock();

Should arm_hash_then_delete() and arm_lru_then_evict() hold
bpf_rcu_read_lock() from the arm through the delete or the eviction loop,
so the tests are deterministic rather than timing-dependent?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36029594826
--===============4135117493470358329==--
