Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794944C4E3;
	Mon, 24 Aug 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586152; cv=none; b=G0FC9rNpJ+2xzk5Hh6wv/xHMig3sR5RHiCIIrbvMqYTKsRMLcV9AWQqzbp6KO0ssNrCarjC5QANoMAj0cjESaJ8DtGQl5Qovf1QK5SXCyaQsYun1gqnV1/svPdwaTZSu1akXDBjD2W0O7+x1QJPvOm45iIr+GWasOce2YG8Qs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586152; c=relaxed/simple;
	bh=PvyzodrdFvixXE6EDBp/1EK6jSvLtlZ1x2kE2DaESgY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YXjKWtUjNUJnRAs7Zh9fnPVZ0dgQiuViuwG3BwnDi5pVwi4DsoU7ngcmmdPvbNFNShHq15JfzKw8AwM5Qqo1gCPGhR5gyBAfkDPRq7GcavcjeYNMr610YgoDM5juIdlFoHoFHO5OijG8OuVYIKf9sH9eaCZvjSkXn9RQ/QNM188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiYZ9bCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiYZ9bCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF801F00A3F;
	Mon, 24 Aug 2026 15:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586144;
	bh=n8EekAtIXzdxe+B9XX2755FWpb2SomWsIMyY12oi6F0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PiYZ9bCMt5LaRbh1mKOcSk8JAoATQFoAqC100qvoVH//FwYKs8AGsg+Jo+ZQVzkPc
	 FyghZfY5vRnexIPiPkS808kI0jdH3koTdq3z+tuPLTAWRUohToawf0Jo2I6Wvd3sNv
	 dHGsmmkKT2trSPxDPcmLNyZh2KnIFSU8/cF5tNDxkGhu+vaimUqXLeSBCELGQQxaok
	 MhKfpL4jgf9Zkgrpqjz3/01E5R8qZXosiTzF4/Voxny7/mhxIcotbZbWJJrbjZSLYm
	 g0J4OR+zozAWzMZRSCRR03n7OXqLp7p3JsnyHI+NrNlUC9g10Kagrw5rOvkIRx9/id
	 C2QeS1NOi9/TA==
Content-Type: multipart/mixed; boundary="===============3130900610336689776=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d89fc04e61dddf9661a334b4ce9142b3bc081ab11fb287ce1ea2aee0661b6e7a@mail.kernel.org>
In-Reply-To: <20260824143621.2098856-5-chenyuan_fl@163.com>
References: <20260824143621.2098856-5-chenyuan_fl@163.com>
Subject: Re: [PATCH 4/4] selftests/bpf: Test rhtab special-field combinations
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,gnq25@mails.tsinghua.edu.cn,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 15:42:24 +0000 (UTC)

--===============3130900610336689776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c b/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
> new file mode 100644
> index 000000000000..29de05bcbd4b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c

[ ... ]

> +static void subtest_timer(struct rhtab_fields *skel)
> +{
> +	u64 zero = 0;
> +	u32 key = 0;
> +	int fired, map_fd;
> +
> +	map_fd = bpf_map__fd(skel->maps.tmap);
> +	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &zero, BPF_ANY),
> +		       "create_elem"))
> +		return;

Does this read past the end of the zero variable?  The tmap value type
is struct timer_val which is 24 bytes (16-byte bpf_timer plus 8-byte
data field), but zero is only 8 bytes.  The syscall copies value_size
bytes from the user pointer in kernel/bpf/syscall.c:

    value_size = bpf_map_value_size(map);
    value = kvmemdup_bpfptr(uvalue, value_size);

so it appears 16 bytes above zero on the stack would be read.  The same
pattern is also used later when recreating the element.

> +
> +	if (!ASSERT_OK(run_prog(skel, "arm_timer"), "arm_timer_first"))
> +		return;
> +	usleep(300000);
> +	if (!ASSERT_GT(skel->bss->timer_fired, 0, "timer_fired_first"))
> +		return;
> +
> +	/* Deleting the element must cancel the timer. */
> +	fired = skel->bss->timer_fired;
> +	if (!ASSERT_OK(bpf_map_delete_elem(map_fd, &key), "delete_elem"))
> +		return;
> +	usleep(300000);
> +	ASSERT_EQ(skel->bss->timer_fired, fired, "timer_cancelled_after_delete");

Can this assertion actually verify timer cancellation?  Looking at
arm_timer() in progs/rhtab_fields.c, it arms the timer with a 50us
expiry (50000ns), and the callback doesn't re-arm.  The test waits
300ms before the delete, and the preceding ASSERT_GT confirms the timer
has already fired.  So by the time bpf_map_delete_elem() runs, the
timer has been inactive for ~300ms.  Whether or not the delete path
cancels the timer field, timer_fired cannot advance during the second
sleep, so the assertion would pass even on a kernel that doesn't cancel
the timer at all.

The commit message says "delete the element and verify the timer is
cancelled" - to actually test cancellation, wouldn't the timer need to
still be pending at delete time?  For example, arming it with a delay
longer than the deletion (say 200ms), deleting immediately, then
sleeping past the original expiry and checking that timer_fired did not
change.

> diff --git a/tools/testing/selftests/bpf/progs/rhtab_fields.c b/tools/testing/selftests/bpf/progs/rhtab_fields.c
> new file mode 100644
> index 000000000000..85335f19f172
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rhtab_fields.c

[ ... ]

> +struct timer_val {
> +	struct bpf_timer timer;
> +	__u64 data;
> +};

Is the data field used anywhere?  I don't see it read or written in
any of the programs or in the test harness.  Compare struct
lock_kptr_val::magic which exists for a similar purpose (plain bytes
alongside a special field) and is actually exercised by lk_upd/lk_probe
to verify plain bytes round-trip through recycled elements.

The field does affect the value_size (making it 24 bytes instead of
16), which creates a mismatch with prog_tests/rhtab_fields.c where
subtest_timer() seeds the map from an 8-byte local (u64 zero).

> +} counters SEC(".maps");
> +
> +/* 0: lk init ok, 1: lk probe xchg non-NULL, 2: lk probe xchg NULL,
> + * 3: lk probe magic ok, 4: u init ok, 5: u probe ptr non-NULL,
> + * 6: pc init ok, 7: pc probe xchg non-NULL, 8: pc probe xchg NULL
> + */

This isn't a bug, but the comment style here differs from the file
header above.  The BPF subsystem prefers the opening /* on its own
line:

    /*
     * 0: lk init ok, 1: lk probe xchg non-NULL, ...
     */

> +static __always_inline void bump(u32 idx)
> +{
> +	u64 *v = bpf_map_lookup_elem(&counters, &idx);
> +
> +	if (v)
> +		(*v)++;
> +}
> +
> +extern struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
> +extern void bpf_task_release(struct task_struct *p) __ksym;
> +
> +int timer_fired;
> +
> +/* Map 1: spin lock + referenced kptr + plain data. */
> +
> +SEC("syscall")
> +int lk_init(void *ctx)
> +{
> +	struct lock_kptr_val *val;
> +	struct task_struct *task, *old;
> +	u32 key = 0;
> +
> +	val = bpf_map_lookup_elem(&lkmap, &key);
> +	if (!val)
> +		return 1;
> +	task = bpf_task_acquire(bpf_get_current_task_btf());
> +	if (!task)
> +		return 2;
> +	old = bpf_kptr_xchg(&val->tsk, task);
> +	if (old)
> +		bpf_task_release(old);
> +	bump(0);
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int lk_del(void *ctx)
> +{
> +	u64 key = 0;
> +
> +	bpf_map_delete_elem(&lkmap, &key);
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int lk_upd(void *ctx)
> +{
> +	struct lock_kptr_val val = { .magic = 0x52484142 };
> +	u32 key = 0;
> +
> +	bpf_map_update_elem(&lkmap, &key, &val, BPF_ANY);
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int lk_probe(void *ctx)
> +{
> +	struct lock_kptr_val *val;
> +	struct task_struct *old;
> +	u32 key = 0;
> +
> +	val = bpf_map_lookup_elem(&lkmap, &key);
> +	if (!val)
> +		return 1;
> +	old = bpf_kptr_xchg(&val->tsk, NULL);
> +	if (old) {
> +		bpf_task_release(old);
> +		bump(1);
> +	} else {
> +		bump(2);
> +	}
> +	if (val->magic == 0x52484142)
> +		bump(3);
> +	return 0;
> +}

A subsystem pattern flags this as potentially concerning: the
lk_init/lk_del/lk_upd/lk_probe quartet appears to re-implement a test
that the immediately preceding commit in this same series (81f409ba449d)
just added to the same directory.  progs/rhtab_kptr.c already covers
the rhtab referenced-kptr recycle path with an identical four-program
template over the same map type.

The shared scaffolding is duplicated as well: bump() and the extern
bpf_task_acquire/bpf_task_release declarations are byte-identical
between the two files.

Given that rhtab_fields.c adds the spin-lock, timer, untrusted-kptr,
and per-cpu-kptr combinations that rhtab_kptr.c doesn't cover, while
rhtab_kptr.c covers the NMI (perf_event) update path that
rhtab_fields.c doesn't, neither file strictly subsumes the other.
Should the two files share a header for the common helpers, or would it
make sense to merge them into one test that covers all field
combinations including the NMI case?

> +
> +/* Map 2: bpf_timer. */
> +
> +static int timer_cb(void *map, void *key, struct timer_val *value)
> +{
> +	timer_fired++;
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int arm_timer(void *ctx)
> +{
> +	struct timer_val *val;
> +	u32 key = 0;
> +
> +	val = bpf_map_lookup_elem(&tmap, &key);
> +	if (!val)
> +		return 1;
> +	/* 1 == CLOCK_MONOTONIC */
> +	if (bpf_timer_init(&val->timer, &tmap, 1))
> +		return 2;
> +	bpf_timer_set_callback(&val->timer, timer_cb);
> +	if (bpf_timer_start(&val->timer, 50000, 0))
> +		return 3;
> +	return 0;
> +}

Does arming a one-shot timer with a 50us expiry make the timer subtest's
delete-cancellation assertion unfalsifiable?  The callback doesn't
re-arm, so the timer fires exactly once.  The consumer in
prog_tests/rhtab_fields.c waits 300ms (6000x the expiry) and confirms
the timer has already fired before calling bpf_map_delete_elem().  The
hrtimer is therefore inactive at delete time, so timer_fired cannot
change during the second sleep regardless of whether the delete path
actually cancels anything.

The existing convention in this directory is to arm a long timer so
it is still pending at delete time - progs/timer_start_delete_race.c
uses bpf_timer_start(&value->timer, 100000000, 0) (100ms) for exactly
this delete-vs-pending-timer scenario, and progs/timer.c uses
1ull << 35 (~34s) as its 'must not fire' expiry.  Would arming with an
expiry longer than the arm-to-delete window make the assertion able to
fail?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32741782570
--===============3130900610336689776==--
