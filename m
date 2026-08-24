Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D971D432BC1;
	Mon, 24 Aug 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586154; cv=none; b=fcATk1/Mcaandr15lioDl+kOrZHfI1QB484tJJw0GDGJSTYuX0BfGZLX+0yPaqmdk2sOajiHS201ScdvhhNVsPnyPmvTXV2lqYHmHOkqHXiLeiveFhZ8+CSrLGgeGK0rWl8p6tUD69VZFSPXF2pxnWCia4BCPcqTR242uuIyZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586154; c=relaxed/simple;
	bh=CDRP4gpzUsluUAF7MS5tPXjvTozOS+POpWSlIvrPn18=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ECf1punK+DDYJg/wb37WCm0BfnC+rv2nBZMNC4Ws6En3ImRBBz24PKZkr9Lr6wvgULiQzUIEIJgiL8t9SvdZI26Rhw3KDyTTzt2YLNkbdLKclhWwLGlZd9GXhHSjjNPFo/bYGSPMALRIJ+OS5spe5znK+M0tlZc3wX2/SIVEwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g11qAZlT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g11qAZlT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959191F00A3E;
	Mon, 24 Aug 2026 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586143;
	bh=kpPtmU1Onj8DRaxmofLIIStTgTFjuXkztqouUkk0qt0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g11qAZlTEiN8hoaWzzmflsSUWzpxzjnqQD8qiLMS5+7n3t8zbe0xT4js826bKG0v7
	 pDtUzQeU5qVEWLeTLwyYcpb6C7tz4ultLjumjv40wV0KoHJNsTfrHe1+XisiN2JZ9y
	 M7gDOfS1Sx9L7d1QP02zEc8irC06AJz4yuGGOf9dtuYVHYB2SR6DG3Z71JnEgFUfKT
	 02ljP6U9ntrJt8hB/OnFgmA5PHPECWPDmBKr1k2FtGl9rOLTnR2njM0zZEgzbzbowN
	 K/+Ma1+2tqTDWgdgL8LoiPaH/VqTEYkTPJjjhkoJ6UeXdiag3NLYzC3gYcuw+wmbTu
	 7E43bAmrZLoLg==
Content-Type: multipart/mixed; boundary="===============5325228425749837176=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5145190152118190974936dc5749fc562d898f27e212a6bfe12fcf08460198ff@mail.kernel.org>
In-Reply-To: <20260824143621.2098856-4-chenyuan_fl@163.com>
References: <20260824143621.2098856-4-chenyuan_fl@163.com>
Subject: Re: [PATCH 3/4] selftests/bpf: Test rhtab kptr recycle from NMI context
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,gnq25@mails.tsinghua.edu.cn,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 15:42:22 +0000 (UTC)

--===============5325228425749837176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c b/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
> new file mode 100644
> index 000000000000..13158d74cbc1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
> @@ -0,0 +1,146 @@

[ ... ]

> +	skel = rhtab_kptr__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	/* Create the element and stash a referenced task kptr in it. */
> +	if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.rhtab),
> +					   &key, &zero, BPF_ANY), "create_elem"))
> +		goto out;

Does this code pass the correct value size to bpf_map_update_elem()?

The map value type is struct val_t which contains an 8-byte kptr and a
u32 magic field, making sizeof(struct val_t) == 16 bytes (with 4 bytes
of trailing padding). The code passes &zero where zero is a single __u64
(8 bytes).

kernel/bpf/syscall.c:map_update_elem() copies the full 16 bytes from
&zero via kvmemdup_bpfptr(), reading 8 bytes past the end of the stack
variable. This has two consequences: the test performs an out-of-bounds
read of its own stack, and the element's magic field gets initialised
with whatever stack garbage followed zero.

The same undersized buffer is used again for the recreate_elem call
further down. Would declaring a correctly sized buffer fix this?

> +	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.init_elem),
> +					      &topts), "test_run_init") ||
> +	    !ASSERT_EQ(topts.retval, 0, "init_ret"))
> +		goto out;
> +
> +	pmu_fd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, 0);
> +	if (pmu_fd >= 0) {
> +		skel->links.nmi_update = bpf_program__attach_perf_event(skel->progs.nmi_update,
> +									pmu_fd);
> +		if (!ASSERT_OK_PTR(skel->links.nmi_update, "attach_perf_event")) {
> +			close(pmu_fd);
> +			goto out;
> +		}
> +
> +		/* Let the NMI handler overwrite the element, and make sure it
> +		 * actually ran before probing (otherwise the probe would pass
> +		 * vacuously even on an unfixed kernel).
> +		 */

This isn't a bug, but the opening /* of a multi-line comment should sit
on its own line per BPF subsystem style. The file's other block comments
already follow that form.

> +		for (i = 0; i < 20 && read_counter(skel, 1) == 0; i++)
> +			usleep(100000);
> +		ASSERT_GT(read_counter(skel, 1), 0, "nmi_update_ran");

Can this assertion fail for environmental reasons on an otherwise correct
kernel?

The perf event is opened with pid == -1 and cpu == 0, so it only samples
CPU 0. PERF_COUNT_HW_CPU_CYCLES does not advance while a core is in a
deep C-state, and the polling thread is not pinned to CPU 0. On an
otherwise idle host the counter can stay at 0 and the test hard-fails
here, even though nothing is wrong with the kernel.

Contrast lru_lock_nmi.c, which makes the same assertion safe by attaching
on every CPU and running busy threads pinned per CPU during the sampling
window.

> +
> +		bpf_link__destroy(skel->links.nmi_update);
> +		skel->links.nmi_update = NULL;
> +		close(pmu_fd);

Does this code close pmu_fd twice?

bpf_program__attach_perf_event() takes ownership of the perf fd on
success: libbpf stores it in bpf_link_perf::perf_event_fd and
bpf_link_perf_detach() closes it. So bpf_link__destroy() above already
closed pmu_fd, and this explicit close() closes an fd number that is no
longer owned by the test.

The file gets the ownership rule right on the failure path: it closes
pmu_fd only because the attach failed. The neighbouring NMI test
lru_lock_nmi.c documents it explicitly at lines 203-206. Today nothing
allocates a descriptor between the destroy and close so the stray close()
just returns EBADF, but a double close in a test that later grows an
intervening open()/socket()/map creation will silently close an unrelated
descriptor.

[ ... ]

> +		ASSERT_EQ(read_counter(skel, 2), 1, "xchg_non_null");
> +		ASSERT_EQ(read_counter(skel, 3), 0, "xchg_null");
> +	} else {
> +		test__skip();
> +	}

Does calling test__skip() in a test that defines no subtests make the
whole test report SKIP even though the second phase still runs?

test_progs.c:print_test_result() reads the subtests_cnt and with
subtest_num == 0, a single test__skip() turns the entire test into
'#N rhtab_kptr:SKIP'. On the common BPF CI setup (QEMU without a vPMU)
perf_event_open() always fails, so this test would permanently print SKIP
while silently exercising the delete/re-insert recycle path - a failure
there is still reported, but a pass is indistinguishable from nothing ran.

The neighbouring lru_lock_nmi.c wraps each phase in test__start_subtest()
so that skips and passes are accounted per phase.

A subsystem pattern flags this as potentially concerning: the NMI phase is
skipped with a bare test__skip() that records no reason, so a reader of
the CI log cannot tell whether the PMU was absent, perf_event_paranoid
blocked the open, or something else failed. errno from the failed
perf_event_open() is discarded. The guide warns about tests that skip
silently with no message, though test__skip() takes no reason argument and
this is the dominant idiom across prog_tests/.

[ ... ]

> +	for (i = 0; i < 2000; i++) {
> +		topts.retval = 0;
> +		err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.init_elem),
> +					     &topts);
> +		if (err || topts.retval) {
> +			/* Element may be gone; recreate and retry once. */
> +			if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.rhtab),
> +							   &key, &zero, BPF_ANY),
> +				       "recreate_elem"))
> +				goto out;

Same value-size issue here as the earlier create_elem call.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/rhtab_kptr.c b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
> new file mode 100644
> index 000000000000..fd6bd63cb405
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rhtab_kptr.c
> @@ -0,0 +1,132 @@

[ ... ]

> +} counters SEC(".maps");
> +
> +/* 0: init ok, 1: nmi update ok, 2: probe xchg non-NULL, 3: probe xchg NULL,
> + * 4: probe saw expected magic value
> + */

This isn't a bug, but the opening /* of a multi-line comment should sit on
its own line. The file's own header comment already uses the correct form,
so this is inconsistent with its own neighbours as well as with the
subsystem style.

> +static __always_inline void bump(u32 idx)
> +{
> +	u64 *v = bpf_map_lookup_elem(&counters, &idx);
> +
> +	if (v)
> +		(*v)++;
> +}

[ ... ]

> +SEC("syscall")
> +int upd_elem(void *ctx)
> +{
> +	struct val_t val = { .magic = 0x52484153 }; /* "RHAS" */
> +	u32 key = 0;
> +
> +	bpf_map_update_elem(&rhtab, &key, &val, BPF_ANY);
> +	return 0;
> +}

Can upd_elem() and del_elem() communicate map operation failures to the
userspace loop?

Both discard the return value of bpf_map_update_elem() and
bpf_map_delete_elem() and unconditionally return 0. The userspace loop
only checks bpf_prog_test_run_opts() and never inspects topts.retval for
these two programs.

rhtab_map_update_elem() has several real failure returns reachable from
this loop - -ENOMEM from bpf_mem_cache_alloc(), -EBUSY when
rhtab->freeing_internal is set, and -E2BIG/insert errors - and
rhtab_map_delete_elem() returns -ENOENT. If any of them fires, the
following probe_elem() returns 1 early, so neither counter 2/3 nor counter
4 is bumped, and the only symptom is the final ASSERT_EQ for
recycle_magic_roundtrip reporting an off-by-N count with no indication of
which operation failed or why.

The sibling programs init_elem()/probe_elem() already use the return value
as a status code, so propagating the map-op error here would turn a silent
count mismatch into a diagnosable failure.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32741782570
--===============5325228425749837176==--
