Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD739E9CF;
	Wed, 29 Jul 2026 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314134; cv=none; b=cN1IX/lzP7+aDH6aXx6LzYo2pw1DAjJTqF5Md+wTAjSfX6miIMR/80y4g875SFvIlxA5BmWoRnAdGnmuWoFv/bdZ+ja00szLvPCrWn8f0OMzVC21W1pgMX2Bj69JPxK+NwOdRN+owETTc0Mw+7TnOs8wAq0VdgwTvzIX3JUeJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314134; c=relaxed/simple;
	bh=qQum5Dpv4V8PjFZ8D+X+Nwd/wK6M2Kq2X1CyRKzmdP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hiyvtKQ/8Gh/kANVNNwZ/nY+WRZx5hZ8Wa9SP5DKfeEO1BM7HeWfNKyPjslrxDoqjsLN4SjMFo5epTprUZzcvOxjERhJluT/+DhuyZzE54Mv6Q4SlLAsx6f0SEdq0U+UDurCm7gGiH8iadFQMtlKT6+EEqdtsnUKkZnNdc5tgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKH/2E6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKH/2E6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E2B1F00A3D;
	Wed, 29 Jul 2026 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314131;
	bh=eFcRc5Tvt5zIshT2hM+gwbHE4VX2lg6HOcbGfx4QYrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cKH/2E6zxnPA92nYlcu1vj7TWIdZgS3hP1hViryAWh5Wxb6sJm7c6XenHXGNfwgjB
	 vpLwx0twqa4Eos/NVKUHa8/6vDNKcx5mCeR3XA272ceuwe0dvI6G9+zRjns6KhnHN+
	 9FDwkSe8ycWDWjMcZsgcuiZoGkWsk5HiXBuMBc6C2/u4addxoZF2ywFwmPoVbL/oyR
	 akm2KZ8f/mek5QYqNswPdPMDb2RZ93zZs0JGl2jAwFh8slucRhnEuMQBVvTeBUhZGi
	 MAaAtI+dcNliJn6LO1D7n0Dk9tvcevFgIH8Cmij2fXKK6SfzaLu00BYQ/BCN5ilk17
	 sBuimMm9ZzboQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] mm/slab, slub_kunit: register kprobe to trigger
 _nolock APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260729-kfree_rcu_nolock-v5-1-a28cdcda9673@kernel.org>
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
 <20260729-kfree_rcu_nolock-v5-1-a28cdcda9673@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:35:30 +0000
Message-Id: <20260729083530.B3E2B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Manual cleanup of global kprobe leads to stack Use-After-Free if t=
he KUnit test aborts.
- [Medium] Global kprobe registration causes concurrent data races and trig=
gers test allocations from unrelated system processes.
--

--- Patch [1]: [PATCH v5 1/8] mm/slab, slub_kunit: register kprobe to trigg=
er _nolock APIs ---
commit a8a477af9c0547e09308b4a325920cd9de52b25e
Author: Harry Yoo (Oracle) <harry@kernel.org>

    mm/slab, slub_kunit: register kprobe to trigger _nolock APIs
   =20
    Since kmalloc_nolock() always fails in NMI and hardirq contexts on
    PREEMPT_RT, slub_kunit cannot properly test _nolock() APIs.
   =20
    Register a kprobe pre-handler to invoke kmalloc_nolock() and
    kfree_nolock() in the middle of the slab allocator.
   =20
    Link: https://lore.kernel.org/linux-mm/20260427-nolock-api-fix-v2-0-a6b=
83a92d9a4@kernel.org [1]
    Link: https://lore.kernel.org/linux-mm/6edebc2b-5f5a-4b9c-9a4c-564310ac=
ee1b@kernel.org  [2]

> diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
> index fa6d31dbca166..8c2b9911471eb 100644
> --- a/lib/tests/slub_kunit.c
> +++ b/lib/tests/slub_kunit.c

[ ... ]

> +#if defined(CONFIG_KPROBES) && defined(CONFIG_SMP)
> +static int slab_kprobe_pre_handler(struct kprobe *p, struct pt_regs *reg=
s)
> +{
> +	struct test_nolock_context *ctx;
> +
> +	ctx =3D container_of(p, struct test_nolock_context, kprobe);
> +	test_nolock(ctx);

[Severity: Medium]
Will this handler execute unconditionally for any task that hits the kprobe?

The kprobe is registered globally on slab_attach_kprobe_locked(). Since this
function is inserted into slab_lockdep_assert_held(), which is heavily used
in the slab allocator's paths, any task on any CPU performing an allocation
can trigger the kprobe.

This allows unrelated system processes to execute the test logic concurrent=
ly.
Does this code need a check to restrict execution to the test thread, such =
as
verifying current against the test task?

Additionally, this can cause data races in test_nolock() since unrelated
system processes would perform unsynchronized read-modify-write operations =
on
the stack-allocated ctx variables:

lib/tests/slub_kunit.c:test_nolock() {
    ...
    if (objp)
        ctx->alloc_ok++;
    else
        ctx->alloc_fail++;
    ...
}

> +	return 0;
> +}
> +
> +static bool register_slab_kprobes(struct test_nolock_context *ctx)
> +{
> +	ctx->kprobe.symbol_name =3D "slab_attach_kprobe_locked";
> +	ctx->kprobe.pre_handler =3D slab_kprobe_pre_handler;
> +
> +	if (register_kprobe(&ctx->kprobe))
> +		return false;
> +	return true;
> +}

[ ... ]

> +static void test_kmalloc_kfree_nolock_kprobe(struct kunit *test)
> +{
> +	struct test_nolock_context ctx =3D { .test =3D test };
> =20
> -cleanup:
> -	perf_event_disable(ctx.event);
> -	perf_event_release_kernel(ctx.event);
> +	if (!register_slab_kprobes(&ctx))
> +		kunit_skip(test, "Failed to register kprobe, skipping");
> =20
> -	kunit_info(test, "callback_count: %d, alloc_ok: %d, alloc_fail: %d\n",
> -		   ctx.callback_count, ctx.alloc_ok, ctx.alloc_fail);
> +	test_kmalloc_kfree();
> =20
> -	if (alloc_fail)
> -		kunit_skip(test, "Allocation failed");
> +	unregister_slab_kprobes(&ctx);

[Severity: High]
Can this manual unregistration lead to a stack use-after-free if the KUnit
test aborts before completing?

If the test aborts (for example, due to a KUnit timeout which is possible
given the system-wide contention caused by the global kprobe), the thread
could exit and its stack memory would be freed, bypassing this manual
cleanup.

If the global kprobe remains active and continues to fire for other tasks,
would the pre-handler then dereference the ctx pointer, pointing to freed
stack memory?

Could kunit_add_action() be used to ensure the cleanup is always executed
even if the test aborts?

>  	KUNIT_EXPECT_EQ(test, 0, slab_errors);
>  }
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-kfree_rcu_=
nolock-v5-0-a28cdcda9673@kernel.org?part=3D1
