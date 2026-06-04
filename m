Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79573353EE0
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555695; cv=none; b=nvVhybNEhfpFj0523WXIc0nuHOGbh/HCzQoWQHXdOyJVfD3c/QGq7uhSlPjGNJ5W5QkcFQ4Ajl+CGJYYt5NyoACt8qbPU7V/UiLxZNGJT9mHjud3OEKVmVH0E98rOmu/ZMgHlNXffsUx4wKBDWsWD9pbSEs/dTeVyp0mL0xthKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555695; c=relaxed/simple;
	bh=20EwMvNv1HLsog2J5vXSmEaqytURpureVSWsOYl/Zas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IV2MSUU2jPkNI3oNcWVAlNgRXWlesOtaOKYgorGXEoQJ1odfJnl5B8cJBtYUdMPXRZRj10mUx1hFrD2tf3xtUXFDX9bUTJjotxgbymXW8TT/mFWWgpZbkCDMDxzoVvvagmheS+Z5xrwv/+Nyj/DfaHRZwWQqnvucTIpEUQBBWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGxxZT/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGxxZT/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E141F00893;
	Thu,  4 Jun 2026 06:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780555694;
	bh=uebIlTMAhFtxeQaWjGmcEQYw6ZYmIv8lLsaEGulYdQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGxxZT/SslRa4azhnIC+lwARuKuH0xA71doaN4/gg/Y+MsrNF9JZXv9yUFouFdxQJ
	 PVgSqdUL7boQMZ1/hUfVhSBXJ5AdOUUx57une47i0sKn2FnI975MzS8p8uHy/Qh6QU
	 5hg2d4sbfgP4fXEkP2qXyQy9yxUO92hyu/HBYd4Q0Itp2jUZsgDpJc2vsbL74vun7k
	 43hh0rmsO06DpBMRsL9aLt7L629biErDuqCVkzX40Wd5TMlY1SCSjRtIQWv1/fTuwS
	 Kfqrz4DnpTWJbIXBglSch2bmNxoQMwAG/XGKseLQfcVUffIwOfIboh3Q7jECzcnd/q
	 /e+FobQneVnDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/4] selftests/xsk: Introduce mmap_size in
 umem struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tushar Vyavahare" <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603060327.298389-5-tushar.vyavahare@intel.com>
References: <20260603060327.298389-5-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 06:48:13 +0000
Message-Id: <20260604064814.07E141F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Worker thread calls `pthread_barrier_wait` on an uninitialized bar=
rier during single-thread tests.
- [High] Async-signal-unsafe call to `pthread_exit()` in `SIGUSR1` handler =
exposes the framework to deadlocks.
- [High] Single-thread tests are instantly aborted and completely bypass th=
eir testing logic.
- [Medium] Missing `pthread_join()` on the `pthread_barrier_destroy()` erro=
r path leads to a use-after-free race.
- [Medium] Missing error check for `pthread_create` leads to undefined beha=
vior.
- [Low] Unmapped memory leak when `xsk_configure_umem` fails.
--

commit 154c93204cd9eb3588c96c98454860ecbe0e819c
Author: Tushar Vyavahare <tushar.vyavahare@intel.com>
Subject: selftests/xsk: Introduce mmap_size in umem struct

This patch stores the final mapping length in xsk_umem_info as mmap_size
when the UMEM mapping is created. This value is then used during teardown,
avoiding duplicated size arithmetic in cleanup. It also joins the RX worker
thread before cleanup in the single-thread path.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index f1730466ffd9c..e94c38a1faf47 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -1595,10 +1595,15 @@ static int thread_common_ops(struct test_spec *te=
st, struct ifobject *ifobject)
>  	if (ifobject->shared_umem)
>  		umem_sz *=3D 2;
> =20
> -	bufs =3D mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
> +	mmap_sz =3D umem->unaligned_mode ?
> +		ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE : umem_sz;
> +
> +	bufs =3D mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
>  	if (bufs =3D=3D MAP_FAILED)
>  		return -errno;
> =20
> +	umem->mmap_size =3D mmap_sz;
> +
>  	ret =3D xsk_configure_umem(ifobject, umem, bufs, umem_sz);
>  	if (ret)
>  		return ret;

[Severity: Low]
This isn't a bug introduced by this patch, but does this leak the memory
mapped into bufs if xsk_configure_umem() fails?

If xsk_umem__create() fails inside xsk_configure_umem(), umem->buffer is
never assigned. The teardown logic in testapp_clean_xsk_umem() will later
call munmap(NULL, mmap_size) which fails with EINVAL, leaking the memory.

While a test suite memory leak is minor, could repeated failures exhaust
hugepages across test runs?

[ ... ]

> @@ -1706,15 +1711,9 @@ void *worker_testapp_validate_rx(void *arg)
>  static void testapp_clean_xsk_umem(struct ifobject *ifobj)
>  {
>  	struct xsk_umem_info *umem =3D ifobj->xsk->umem;
> -	u64 umem_sz =3D umem_size(umem);
> -
> -	if (ifobj->shared_umem)
> -		umem_sz *=3D 2;
> -
> -	umem_sz =3D ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE;
> =20
>  	xsk_umem__delete(umem->umem);
> -	munmap(umem->buffer, umem_sz);
> +	munmap(umem->buffer, umem->mmap_size);
>  }
> =20
>  static void handler(int signum)

[Severity: High]
This is a pre-existing issue, but does this async-signal-unsafe call to
pthread_exit() in the SIGUSR1 handler expose the framework to deadlocks?

pthread_exit() is explicitly documented by POSIX as async-signal-unsafe.
The test suite uses SIGUSR1 to asynchronously kill worker threads. If a
thread is interrupted while holding an internal libc lock (e.g., during
malloc(), mmap(), or BPF map ops), the lock is abandoned.

When the main thread subsequently runs clean_sockets() and calls free(),
it could deadlock trying to acquire the same lock.

[ ... ]

> @@ -1857,8 +1856,7 @@ static int __testapp_validate_traffic(struct test_s=
pec *test, struct ifobject *i
> =20
>  	if (!ifobj2)
>  		pthread_kill(t0, SIGUSR1);
> -	else
> -		pthread_join(t0, NULL);
> +	pthread_join(t0, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but are single-thread tests being
instantly aborted and bypassing their testing logic?

For single-interface scenarios (ifobj2 =3D=3D NULL), __testapp_validate_tra=
ffic()
spawns t0 and immediately executes pthread_kill(t0, SIGUSR1). The worker
thread is terminated instantly before it can run its test logic (such as
waiting for poll() to time out in testapp_poll_rxq_tmout).

Since test->fail defaults to false, does this cause the test to return a fa=
lse
positive success, providing zero coverage?

[Severity: High]
This is also a pre-existing issue, but could worker threads call
pthread_barrier_wait() on an uninitialized barrier during single-thread tes=
ts?

In __testapp_validate_traffic(), barr is only initialized if (ifobj2).
However, single-thread tests (like testapp_poll_rxq_tmout) invoke
worker_testapp_validate_rx() via t0, which unconditionally calls
pthread_barrier_wait(&barr).

Is waiting on an uninitialized barrier undefined behavior that could cause
memory corruption or deadlocks?

[Severity: Medium]
Another pre-existing issue here: is there a use-after-free race on the
pthread_barrier_destroy() error path higher up in
__testapp_validate_traffic()?

If pthread_barrier_destroy(&barr) fails, the RX thread (t0) is signaled via
pthread_kill() but not joined before clean_sockets() and clean_umem() are
invoked:

	if (pthread_barrier_destroy(&barr)) {
		pthread_kill(t0, SIGUSR1);
		clean_sockets(test, ifobj1);
		clean_umem(test, ifobj1, NULL);
		return TEST_FAILURE;
	}

Could the worker thread still be running or executing its signal handler
while its resources are torn down?

[Severity: Medium]
This is also a pre-existing issue, but does the framework call
pthread_create() for t0 and t1 without checking the return value in
__testapp_validate_traffic()?

If thread creation fails (e.g., due to EAGAIN), the pthread_t variable is
left uninitialized. The code subsequently passes this uninitialized ID to
pthread_kill() and pthread_join().

Could this invoke undefined behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603060327.2983=
89-1-tushar.vyavahare@intel.com?part=3D4
