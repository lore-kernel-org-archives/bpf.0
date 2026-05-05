Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BB3AB27A
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010546; cv=none; b=qoRsqpbin2QfDp/nGpk7n+nEOmqSmPUfspdMsx9LEXudbyJ11qeuW/Q1ZlQA45eBr1Fvhi4LJyMqX6syzJBB187s3DxcX4kgXctiAqFXKc2yALje6wTiCTRKlY+3WvDsTL4n1Nfrpp0Rdniux/v9G2A0i8DMPxnunCviM9nCq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010546; c=relaxed/simple;
	bh=VeFPThJFfd/csWp0ZhdKuiEdkfEO62OKX5hm3f7ZLBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P6nyrR7RggYnzhBXKETSRXFBm8o8QI+bF2Ot6NSyV4Mr71NrvBA5N1X9EuombJLvMVr6mp9ULIl5DyCtgRZ2rZf24fsriQNVt53K2NL+Uu5EKWRIGMigspvR9MVw17+JrBrE2FrK6M6EEfvvtYF1z9FHSD3eIK6C0zWXdjCgbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqAeIWDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqAeIWDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536EAC2BCF4;
	Tue,  5 May 2026 19:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778010546;
	bh=VeFPThJFfd/csWp0ZhdKuiEdkfEO62OKX5hm3f7ZLBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JqAeIWDXB4GUFtXgFZ92Ta8J+h33R7JmnQZtnY2wiDmVSsoSlfTPQQg8ds5LV2lJR
	 xKfUAP+K5Dg6ApTjo2SMgSee3z3Tg4GDmNqKF66I2iIcM9nyOb15w+hnLheiEg1sk2
	 U++Mz/wmOrC1ga22riCWutYSCbbM+AB8Sm1zBwKjCUrR1u9kWirWDMx9XGe9Zrr+hV
	 QiU0BiSRrDCVf+2977ClR92n+fMNon1Z/SJt08lFmIppaeZYVzCVfWSx9K2J3IAPJ0
	 aYLfHJMEJ8NOvdKGYEuAQX8j22JWdyyPfBIp3bptD4T+gUbR7w2x5G2gaW+mrq6KQQ
	 jUPhcztBCWjaw==
From: sashiko-bot@kernel.org
Subject: Re: [bpf-next v2 1/2] bpf: Offload kptr destructors that run from
 NMI
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505150851.3090688-2-utilityemal77@gmail.com>
References: <20260505150851.3090688-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 19:49:05 +0000
Message-Id: <20260505194906.536EAC2BCF4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Multiple concurrent consumers on the lockless `bpf_dtor_kptr_i=
dle` list cause ABA memory corruption.
- [High] Unrestricted assignment to `env->insn_aux_data[insn_idx].kptr_has_=
dtor` causes mismatched JIT patching for subprograms.
- [High] Time-of-Check to Time-of-Use (TOCTOU) race in `bpf_kptr_offload_in=
c` under-allocates the job pool.
- [High] TOCTOU race in `bpf_dtor_kptr_trim` steals jobs from concurrent in=
sertions, leading to NMI deadlocks.
- [Medium] Preallocated offload jobs are never trimmed during non-NMI teard=
own, causing unbounded memory retention.
--

commit 274934ceea98ba86682bc3758a94297eee420620
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Offload kptr destructors that run from NMI

A BPF program attached to tp_btf/nmi_handler can delete map entries or
swap out referenced kptrs from NMI context. This patch introduces an
offload pool to let a worker invoke destructors after NMI exits.

Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@=
gmail.com/

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3b1f0ba02f613..162bfd4796ea0 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -65,6 +68,131 @@ static DEFINE_SPINLOCK(map_idr_lock);

[ ... ]

> +static struct bpf_dtor_kptr_work *bpf_dtor_kptr_pop_idle(void)
> +{
> +	struct llist_node *node;
> +
> +	node =3D llist_del_first(&bpf_dtor_kptr_idle);
> +	if (!node)
> +		return NULL;
> +
> +	return llist_entry(node, struct bpf_dtor_kptr_work, node);
> +}

Is this susceptible to an ABA issue resulting in list corruption?

The llist_del_first() function is strictly single-consumer because it lacks
ABA protection. Here, bpf_dtor_kptr_pop_idle() is accessed concurrently by
multiple consumers: bpf_dtor_kptr_offload() running in NMI context across
multiple CPUs, and bpf_dtor_kptr_trim() running in irq_work context.

If CPU 0 begins popping a node, is interrupted, and CPU 1 pops and re-pushes
nodes, could CPU 0's cmpxchg succeed but set the list head to a stale or
freed next pointer?

[ ... ]

> +static void bpf_dtor_kptr_trim(void)
> +{
> +	struct bpf_dtor_kptr_work *job;
> +	long total;
> +	long needed;
> +
> +	for (;;) {
> +		total =3D atomic_long_read(&bpf_dtor_kptr_total);
> +		needed =3D atomic_long_read(&bpf_dtor_kptr_refs) +
> +			 atomic_long_read(&bpf_dtor_kptr_active);
> +		if (total <=3D needed)
> +			return;
> +
> +		job =3D bpf_dtor_kptr_pop_idle();
> +		if (!job)
> +			return;
> +
> +		if (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_total, &total, total - 1))=
 {
> +			bpf_dtor_kptr_push_idle(job);
> +			continue;
> +		}

Can a concurrent bpf_kptr_offload_inc() cause this to violate the
total >=3D refs + active invariant?

If bpf_dtor_kptr_trim() reads needed, and then another CPU increments refs
in bpf_kptr_offload_inc():

CPU1
bpf_dtor_kptr_trim()
   needed =3D refs + active;

CPU2
bpf_kptr_offload_inc()
   atomic_long_inc_return(&bpf_dtor_kptr_refs);
   bpf_dtor_kptr_reserve() observes the old high total and skips allocation

CPU1 would see the cmpxchg succeed because total hasn't changed, successful=
ly
freeing the job. Does this lead to an empty idle list when the kptr is later
freed in an NMI?

[ ... ]

> +int bpf_kptr_offload_inc(void)
> +{
> +	long needed;
> +	int err;
> +
> +	if (unlikely(!bpf_global_ma_set))
> +		return -ENOMEM;
> +
> +	/*
> +	 * Read active before incrementing refs so a free path moving one slot =
from
> +	 * refs to active cannot shrink the reservation snapshot below the stea=
dy
> +	 * state we need to cover. Racing results worst case in a larger reserv=
ation.
> +	 */
> +	needed =3D atomic_long_read(&bpf_dtor_kptr_active);
> +	needed +=3D atomic_long_inc_return(&bpf_dtor_kptr_refs);
> +	err =3D bpf_dtor_kptr_reserve(needed);

Could an NMI interrupting this sequence result in under-allocating the job
pool?

If an NMI free occurs precisely after active is read but before refs is
incremented:

CPU1
bpf_kptr_offload_inc()
   needed =3D atomic_long_read(&bpf_dtor_kptr_active);
   // NMI interrupts CPU1
   bpf_dtor_kptr_offload()
      atomic_long_inc(&bpf_dtor_kptr_active);
      // pops job
   bpf_kptr_offload_dec()
      atomic_long_dec(&bpf_dtor_kptr_refs);
   // NMI exits
   needed +=3D atomic_long_inc_return(&bpf_dtor_kptr_refs);

In this scenario, needed is calculated with the old active value and the new
refs value, making it 1 less than the true requirement. Would a subsequent
NMI free encounter an empty job list?

[ ... ]

> +void bpf_kptr_offload_dec(void)
> +{
> +	long val;
> +
> +	val =3D atomic_long_dec_return(&bpf_dtor_kptr_refs);
> +	if (!WARN_ON_ONCE(val < 0))
> +		return;
> +
> +	/*
> +	 * Clamp a mismatched decrement back to zero without overwriting a
> +	 * concurrent increment that already repaired the counter.
> +	 */
> +	do {
> +		val =3D atomic_long_read(&bpf_dtor_kptr_refs);
> +		if (val >=3D 0)
> +			break;
> +	} while (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_refs, &val, 0));
> +}

When kptrs are deleted from normal process or softirq contexts, does this c=
ode
cause unbounded memory retention?

Since bpf_dtor_kptr_trim() is exclusively invoked by the irq_work worker
during NMI teardown, the global idle list might never be trimmed for non-NMI
teardowns. This could cause the pool memory to stay at the high-water mark =
of
concurrent kptrs indefinitely.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 11054ad89c14d..2c7b21bda666a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -9950,6 +9950,8 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
>  		if (err)
>  			return err;
>  	}
> +	env->insn_aux_data[insn_idx].kptr_has_dtor =3D
> +		func_id =3D=3D BPF_FUNC_kptr_xchg && !!meta.kptr_field->kptr.dtor;
> =20
>  	err =3D record_func_map(env, &meta, func_id, insn_idx);
>  	if (err)

Does this unrestricted assignment cause mismatched JIT patching for subprog=
rams?

If a BPF static subprogram contains a bpf_kptr_xchg instruction and is call=
ed
twice by the main program - once with a map containing a destructor kptr,
and once without - the verifier will simulate the subprogram twice. The
second pass will blindly overwrite kptr_has_dtor for that instruction.

If the last simulated path had no destructor, the JIT patches the instructi=
on
to bpf_kptr_xchg_nodtor. At runtime, would the path with a destructor execu=
te
this un-instrumented variant, skipping bpf_kptr_offload_inc() and causing
an NMI deadlock when freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505150851.3090=
688-1-utilityemal77@gmail.com?part=3D1
