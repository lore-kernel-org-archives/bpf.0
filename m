Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772A29405
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617625; cv=none; b=p22OgmpGBXb9GIdWl+A9j69HI/7jNsjawAcT5zMr6OVl/ziAeWx+joLIRAS4aWLtK94uM80DpnCzsW53KYdtwnuyFXIp4YUHb+kwhM7j5sl2thuODizNvC2K740hLuAcGjucCR0aRfgTvcdJQv37erm9iUwNfOdCFJxkge1ohO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617625; c=relaxed/simple;
	bh=5jGXAk+TzIh/rKKzK5miLoExCYrGKlwVyAGH6CMcQx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U6HGobnvwzPQ4VPQ05bZzbH1fRy4Jj+hvdLnLjk/TXaQ0JRRqhl9dfcoEg2JAGPJEd5CE4AbBh+6MxMpdwxomSu8ALi9cLhanyP8JJQ300s0uhVlf+5rYFTlzOMVZ2u74KQ5SZ31Ou9ccHuxo2Jcv4T3n/CLDeTU6Nq0z/x6LbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw/5hLOU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw/5hLOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9561F00893;
	Fri,  5 Jun 2026 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780617623;
	bh=CTbPkSOGBfluP1btwfkn1xF/pLXphDid+fQe9wLxeHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gw/5hLOUTmCttPXW2PO7bgGeKlwgXdtKuEKWcWT+BTGlMv8xnkCZRi7V1ov0P+Qqm
	 1lGgHLw18AWJIicaNS1jQp2wSjnmgcqjijV3IttE63SKiI4ufDk27T6XaVGnsCnWnA
	 sB1Om7vgIqBIGKrH8v8vuagV3hRaPUfUqs2TNChiH1CaJc2toPy+9+4lyioZ6r4ioy
	 dhh4cz7QBo5YvrF0bPGQT/UGbo9/5m/p9wUFFHAHxYcQQPUnYxcr6wtan4X4RDLS0T
	 uHOk1VMF9GlD1uubsatcfysY0E8XqxB8WPcwbSkv2ze1ApffsriwvDBpVsn7sypf46
	 DA+LHY2ddineQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: libarena: parallel test
 harness and spmc parallel selftest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604235016.20856-4-emil@etsalapatis.com>
References: <20260604235016.20856-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 00:00:23 +0000
Message-Id: <20260605000023.BE9561F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] Missing file descriptor validation for BPF programs retrieved vi=
a manual lookup.
- [Medium] The `spmc_burst_owner_round` function incorrectly ignores `-ETIM=
EDOUT` errors from `spmc_wait_for_round_steals`, masking failure root cause=
s.
- [Medium] The owner thread silently ignores the error return value of `spm=
c_singleval_tryconsume`.
- [Medium] Time-Of-Check to Time-Of-Use (TOCTOU) race in `spmc_resize_steal=
er` causes spurious test failures.
- [Medium] Flaky test execution due to extremely short timeout in fixed-ite=
ration spin-loops during cross-thread synchronization.
- [Low] `spmc_wait_for_steals` is defined but never used, resulting in dead=
 code.
--

commit fc468b1c5ad015597983d43b0aaf22db02e08b96
Author: Emil Tsalapatis <emil@etsalapatis.com>
Subject: selftests/bpf: libarena: parallel test harness and spmc parallel s=
elftest

This patch adds a parallel test for the SPMC Lev-Chase workstealing queue.
The queue is built to be wait-free even when there are multiple consumers,
and the parallel selftest provides a signal on whether the queue behaves
correctly when stress tested.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel=
_spmc.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_=
spmc.bpf.c
> new file mode 100644
> index 0000000000000..987537c0f7912
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.b=
pf.c

[ ... ]

> +__weak
> +int spmc_quiesce_on_owner(u64 epoch)
> +{
> +	u64 i;
> +
> +	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
> +		if (test_abort)
> +			return -EINTR;
> +		if (smp_load_acquire(&owner_epoch) >=3D epoch)
> +			return 0;
> +	}

[Severity: Medium]
Will this hardcoded spin loop timeout cause flaky test failures?

The timeout is fixed to 1U << 18 iterations. In BPF, this can execute in a
fraction of a millisecond.

However, the userspace test runner sequentially spawns worker threads using
pthread_create(). Can the scheduling and thread creation overhead take
multiple milliseconds, causing early threads to exhaust the spin loop and
abort with -ETIMEDOUT before all peer threads have fully entered the BPF
execution context?

[ ... ]

> +static int spmc_singleval_owner(void)
> +{
> +	int ret;
> +	u64 i;
> +
> +	for (i =3D zero; i < TEST_SPMC_SINGLEVAL_ITERS && can_loop; i++) {
> +		ret =3D spmc_quiesce_on_stealer(i);
> +		if (ret)
> +			goto err;
> +
> +		ret =3D spmc_owned_add(spmc, i);
> +		if (ret)
> +			goto err;
> +
> +		__sync_fetch_and_add(&owner_epoch, 1);
> +
> +		spmc_singleval_tryconsume(i, false);
> +
> +		ret =3D spmc_quiesce_on_stealer(i + 1);

[Severity: Medium]
Does this silently ignore the error return value from
spmc_singleval_tryconsume()?

If the tryconsume function encounters an error, such as a mismatched value
indicating data corruption, it returns -EINVAL without automatically setting
the test_abort flag.

Since the stealer thread correctly validates this return value, should the
owner thread also check it to prevent the benchmark from continuing in a
corrupted state?

[ ... ]

> +__weak
> +int spmc_wait_for_steals(u64 target)
> +{
> +	u64 i;
> +
> +	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
> +		if (test_abort)
> +			return -EINTR;

[Severity: Low]
Is this function needed?

It appears spmc_wait_for_steals() is fully defined but never called anywhere
in the test file.

[ ... ]

> +static int spmc_resize_stealer(void)
> +{
> +	u64 val;
> +	int ret;
> +
> +	arena_subprog_init();
> +
> +	ret =3D spmc_quiesce_on_owner(1);
> +	if (ret)
> +		return ret;
> +
> +	__sync_fetch_and_add(&stealers_started, 1);
> +
> +	while (can_loop) {
> +		spmc_waste_time();
> +		if (test_abort)
> +			return -EINTR;
> +
> +		ret =3D spmc_steal(spmc, &val);
> +		if (!ret) {
> +			ret =3D spmc_update_stats(val, false);
> +			if (ret)
> +				return ret;
> +			continue;
> +		}
> +
> +		if (ret =3D=3D -EAGAIN)
> +			continue;
> +
> +		/* Only break if this was the last resize. */
> +		if (ret =3D=3D -ENOENT) {
> +			if (READ_ONCE(owner_epoch) >=3D 2)
> +				break;
> +			continue;
> +		}

[Severity: Medium]
Is there a Time-Of-Check to Time-Of-Use race condition here that could
cause spurious test failures?

If spmc_steal() returns -ENOENT, the thread evaluates owner_epoch.
However, if the thread is preempted after spmc_steal() finds the queue
empty, the owner could add its remaining items and update owner_epoch to 2.

When the stealer resumes, it will read owner_epoch >=3D 2 and break the loo=
p,
leaving newly added items unconsumed. Should the stealer re-verify the queue
state after observing the epoch change?

[ ... ]

> +__weak int
> +spmc_burst_owner_round(u64 round)
> +{
> +	u64 i, base, stolen, expected, val;
> +	int ret;
> +
> +	base =3D round * TEST_SPMC_BURST_BURST;
> +	round_steals =3D 0;
> +
> +	for (i =3D zero; i < TEST_SPMC_BURST_BURST && can_loop; i++) {
> +		ret =3D spmc_owned_add(spmc, base + i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	__sync_fetch_and_add(&owner_epoch, 1);
> +
> +	ret =3D spmc_wait_for_round_steals(TEST_SPMC_BURST_STEAL_TARGET);
> +	if (ret =3D=3D -EINTR)
> +		return ret;
> +
> +	__sync_fetch_and_add(&owner_epoch, 1);

[Severity: Medium]
Does this incorrectly ignore -ETIMEDOUT errors from
spmc_wait_for_round_steals()?

If the stealers are too slow, the wait function returns -ETIMEDOUT and sets
the global test_abort flag.

Because the check only explicitly looks for -EINTR, the owner will fall
through on -ETIMEDOUT, incorrectly increment owner_epoch, and initiate
another wait. Should this handle -ETIMEDOUT to properly catch the failure?

> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/te=
sting/selftests/bpf/prog_tests/libarena.c
> index 81bdb084c2715..a42c1935eaf6e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c

[ ... ]

> +static int run_libarena_parallel_fini(struct libarena *skel, const char =
*name,
> +				      size_t prefixlen)
> +{
> +	char tdname[MAX_PARTEST_NAME];
> +	struct bpf_program *fini_prog;
> +	int ret;
> +
> +	ret =3D snprintf(tdname, sizeof(tdname), "%.*s__fini", (int)prefixlen, =
name);
> +	if (!ASSERT_LT(ret, sizeof(tdname), "partest fini name"))
> +		return -ENAMETOOLONG;
> +
> +	fini_prog =3D bpf_object__find_program_by_name(skel->obj, tdname);
> +	if (!ASSERT_TRUE(fini_prog, "partest fini prog"))
> +		return -ENOENT;
> +
> +	ret =3D libarena_run_prog(bpf_program__fd(fini_prog));

[Severity: Medium]
Does this pass an unverified file descriptor to libarena_run_prog()?

According to the BPF selftests subsystem guidelines, manual lookup APIs like
bpf_object__find_program_by_name() can return a valid bpf_program pointer
even if the program failed to load, which results in a negative FD.

Should there be an explicit file descriptor validation (such as ASSERT_GE)
before using the FD?

[ ... ]

> +static int run_libarena_parallel_test_workers(struct libarena *skel,
> +		const char *name, size_t prefixlen)
> +{
> +	pthread_t *threads =3D NULL, *tmp_threads;
> +	char tdname[MAX_PARTEST_NAME];
> +	struct bpf_program *tdprog;
> +	uint32_t nthreads;
> +	void *thread_ret;
> +	int ret, err =3D 0;
> +	int i;
> +
> +	for (nthreads =3D 0; nthreads < UINT_MAX; nthreads++) {
> +		ret =3D snprintf(tdname, sizeof(tdname), "%.*s__%u", (int)prefixlen,
> +			       name, nthreads);
> +		if (!ASSERT_LT(ret, sizeof(tdname), "test worker name")) {
> +			err =3D -ENAMETOOLONG;
> +			break;
> +		}
> +
> +		/*
> +		 * We enumerate the worker threads for a given test with __0, __1,
> +		 * and so on. The suffixes always start from 0 and are contiguous,
> +		 * so if we don't find a program with the requested name we have
> +		 * discovered all available worker programs.
> +		 */
> +		tdprog =3D bpf_object__find_program_by_name(skel->obj, tdname);
> +		if (!tdprog)
> +			break;
> +
> +		/* Bump the alloc array to accommodate the new thread. */
> +		tmp_threads =3D realloc(threads, (nthreads + 1) * sizeof(*threads));
> +		if (!ASSERT_TRUE(tmp_threads, "realloc")) {
> +			err =3D -ENOMEM;
> +			break;
> +		}
> +		threads =3D tmp_threads;
> +
> +		ret =3D pthread_create(&threads[nthreads], NULL,
> +				     run_libarena_parallel_prog,
> +				     tdprog);

[Severity: Medium]
Similar to the fini program, run_libarena_parallel_prog() extracts the FD
from this manually looked-up program and uses it. Does it need file
descriptor validation to prevent passing a negative FD?

Additionally, pthread_create() is called here sequentially. Does this
scheduling overhead cause the spin loops in the BPF programs to time out and
abort, as mentioned earlier?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604235016.2085=
6-1-emil@etsalapatis.com?part=3D3
