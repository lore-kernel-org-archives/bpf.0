Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4A480961
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512957; cv=none; b=RRj/DaMnJZdQXfdnO31r1vI1Q63eSiEdIEhgdqlCdCFn0cxBv+1+ERoHR6AbcW15RRj4/VgPQxtCFNvF0TkytnHPvc5AsaZ4XsxeQZ1aygCZ7pXnA6rbDonxYdtx0yRVwJOrxbU1S63+RcirEFgKebY1ieeNU8AKGrP02zwF1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512957; c=relaxed/simple;
	bh=DXFIu7fLoZ/yoaeYKVuLueB5MKwklVCGZNLU+uv9ZDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UbyIGV0PNE+5STnaJWnmY7CydjVRAt4abOyW83EwfurjLtwm/DiFIq3NXe/VFJTyKpyZbFiH0WM3pqpkvFaLHES9xq9oMZuyqFP22llxVY5r87NQEoCOCOBj/rhXl7qOAw5Kcysi0KkBNIU3SLtZnG98QcVNQUr77hFJmZo18p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvXXz+I+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvXXz+I+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5691F00893;
	Wed,  3 Jun 2026 18:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780512955;
	bh=7pw+Op1/DMkCe+Hq5Hcy/61WfoDPz5qUDwnA5L+rUdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kvXXz+I+ba2q5ii/FvEucxyUzXhKsBFyQbg65gyQPq71KfE3HzKHJNVhRPaxH/vke
	 DZ5XwdJaX5YxndA3EsusuSWPP7PrBK8j0cPctyA3mqOkXOFjQhH3btzNoU0UkXVqCd
	 dVJ4KxMn4syz6Itk4uD2a6ljxGxgAPfyWLCpufHAF8RonRV0q7K0jJ+1xwEqE7vwPz
	 p2oyj41RHerQjiYcpGQ9tiWBmUTguq+ngnzFVs+hGoXOv0NtH/8EXp3JkUL9z/6wZM
	 EJ+xiWESb8MYpw6VGMfFBoh9CWs4sYSPAFPfu5CfTVZmBDJAEpP4ya6mdswWlLKr6y
	 dgGvJ/1zGUsKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: libarena: parallel test
 harness and spmc parallel selftest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603182727.3922-4-emil@etsalapatis.com>
References: <20260603182727.3922-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 18:55:55 +0000
Message-Id: <20260603185555.8F5691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Worker threads can spin indefinitely without checking `test_abort`=
, causing a soft lockup.
- [Medium] Missing BPF FD Validation after manual program lookup.
- [Medium] Thread synchronization loops use a spin limit that is too low, c=
ausing flakiness.
- [Low] Returning a boolean flag as an error code.
--

commit 4565a6a5313dffad1dda425572fe86afb75dd583
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: parallel test harness and spmc parallel selftest
   =20
Add a parallel test for the SPMC Lev-Chase workstealing queue. The queue
is built to be wait-free even when there are multiple consumers, and
the parallel selftest provides a signal on whether the queue behaves
correctly when stress tested.

To support the test, this patch includes a test harness for parallel
selftests. The spmc selftest acts as an example of the naming and other
conventions expected by the harness.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel=
_spmc.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_=
spmc.bpf.c
> new file mode 100644
> index 0000000000000..3d9fe3f579c87
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.b=
pf.c
> @@ -0,0 +1,659 @@
[ ... ]
> +/*
> + * The test requires the stealers/owners to sometimes quiesce
> + * before continuing the benchmark. Normally we'd use something
> + * like a condition variable, but since the benchmark is short-lived
> + * and operations are wait-free we just spin around the quiescence
> + * point instead. If we time out, we just fail the benchmark.
> + */
> +#define TEST_SPMC_SYNC_SPINS (1U << 18)

[Severity: Medium]
Is this iteration limit sufficient for thread synchronization here?

Since a simple read loop of this size takes a fraction of a millisecond
in kernel space, if the OS delays scheduling the worker threads, could
this loop time out prematurely and incorrectly fail the test with -ETIMEDOU=
T?

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
> +
> +		ret =3D spmc_steal(spmc, &val);

[Severity: High]
If the owner thread fails and sets test_abort =3D true, could this loop spin
indefinitely because it doesn't check test_abort?

> +		if (!ret) {
> +			ret =3D spmc_update_stats(val, false);
> +			if (ret)
> +				return ret;
> +			continue;
> +		}
[ ... ]
> +static int spmc_wait_for_round_steals(u64 target)
> +{
> +	u64 i;
> +
> +	arena_subprog_init();
> +
> +	bpf_for(i, 0, TEST_SPMC_SYNC_SPINS) {
> +		if (test_abort)
> +			return test_abort;

[Severity: Low]
Does this unintentionally return 1 instead of a negative error code like
-EINTR?

> +		if (round_steals >=3D target)
> +			return 0;
> +	}
[ ... ]
> +static int spmc_burst_stealer(void)
> +{
> +	u64 round, val, active_epoch;
> +	int ret;
> +
> +	arena_subprog_init();
> +
> +	for (round =3D zero; round < TEST_SPMC_BURST_ROUNDS && can_loop; round+=
+) {
> +		active_epoch =3D round * 2 + 1;
> +
> +		/*
> +		 * Wait till the owner prefills the queue then
> +		 * start stealing.
> +		 */
> +		ret =3D spmc_quiesce_on_owner(active_epoch);
> +		if (ret)
> +			return ret;
> +
> +		while (owner_epoch =3D=3D active_epoch && can_loop) {

[Severity: High]
Could this loop also hang indefinitely if the owner thread fails and sets
test_abort =3D true without updating the epoch?

> +			ret =3D spmc_steal(spmc, &val);
> +			if (!ret) {
> +				ret =3D spmc_update_stats(val, false);
[ ... ]
> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/te=
sting/selftests/bpf/prog_tests/libarena.c
> index 81bdb084c2715..a42c1935eaf6e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
> @@ -27,6 +27,147 @@ static void run_libarena_test(struct libarena *skel, =
struct bpf_program *prog,
> =20
>  }
> =20
> +static void *run_libarena_parallel_prog(void *arg)
> +{
> +	struct bpf_program *prog =3D arg;
> +
> +	return (void *)(long)libarena_run_prog(bpf_program__fd(prog));

[Severity: Medium]
Should the file descriptor from bpf_program__fd() be validated here before
being passed to libarena_run_prog()?

Since run_libarena_parallel_test_workers() finds tdprog via a manual lookup
(bpf_object__find_program_by_name), it doesn't have the same guarantees as
skeleton fields. Could we use ASSERT_GE(fd, 0) to ensure we don't pass an
invalid FD?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603182727.3922=
-1-emil@etsalapatis.com?part=3D3
