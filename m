Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89246D091;
	Tue,  1 Sep 2026 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248253; cv=none; b=eDfuuA5BrmLeoU875R6pSxCsDVc2Ysi7d515OtuyqxpGxtytTWX8DlcQ3JnR284iKc9LM/ZxoWbVhNM502X1pzGdmzbEAWjKoUJdUKRmbeqQs/mNZEsXuhmoMRTu8ilEqmAt1qYb45yNHWHmKKX7hgQJub4j1MQJeXvfYNDD+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248253; c=relaxed/simple;
	bh=poFkR/dTHAGC4tlUmYQp+Bc+x6OjdXKFD9zkRavCGF4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NiPW0ZmNzVpn93AiRtjKGA68GIawo+h1Fgrx9PuFFuEbx8FACQK22EJZJWHaOF+hKJA7ny+KiyhCcqlUsIRem2n3vy2tXCcHAStLT1x1Z3nLrlDMnDUCiy786/LvUTs34ErP4Knos1XyBICEj5DGPKNDMAIAbVKyCayIAo42hNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6aOGNBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6aOGNBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B291F000E9;
	Tue,  1 Sep 2026 07:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788248251;
	bh=hZpQkJxGJ75nMV5xlwvvSqj+jIOFS1AumKEfS4z9RRw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F6aOGNBhfcj8YB3BQJNv7sv86xlWPTt5g5lb5my1MKSVjBK62owARLbbQoABxRowF
	 lCpxaK81/uDoEoVvWHtqI5+MUXNY2TQdYjO1+nyio4fRrkMUV5NJOxfecYRCNVei1F
	 P/+nfHAlVJO469qicS7xhJxqsCc0cEGu4GAQ74FkfbgbEhgQKXpNm2M8OU8OsKjMtU
	 a2+UoGiAzrfOiecqUEelyLbhUY5c+NxV6fmQvcSJhrvDYRwM/Khuog31NARG1qS/tj
	 XrFcp29KWe9EqkNBcpT3q9hjiRSPs94LtnzUd/RcCSHiEhxy5j2U+gTLjq4zSe7ArR
	 nujL/u7kOPX2w==
Content-Type: multipart/mixed; boundary="===============4286650453017191177=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fc4a709b9afbe51da6bcd877476866331e90a957d6904e70ec2c648de8925f49@mail.kernel.org>
In-Reply-To: <20260901062845.1379760-5-chenyuan_fl@163.com>
References: <20260901062845.1379760-5-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Test rhtab special-field combinations
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,mykyta.yatsenko5@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,gnq25@mails.tsinghua.edu.cn,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 07:37:30 +0000 (UTC)

--===============4286650453017191177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> BPF_MAP_TYPE_RHASH allows spin locks, timers, workqueues, task_work,
> kptrs (referenced, untrusted, per-cpu) and refcounts in map values.
> The recycle fix only changes kptr slot handling, so verify each field
> combination end to end:

The commit message says it verifies "each field combination" from the
enumerated list of seven special-field kinds (spin locks, timers,
workqueues, task_work, kptrs, refcounts). However, test_rhtab_fields()
only dispatches four subtests covering five field types: BPF_SPIN_LOCK,
BPF_TIMER, BPF_KPTR_REF, BPF_KPTR_UNREF and BPF_KPTR_PERCPU.

Three field kinds listed in the message are never exercised: BPF_WORKQUEUE
(struct bpf_wq), BPF_TASK_WORK (struct bpf_task_work) and BPF_REFCOUNT
(struct bpf_refcount). These are supported configurations that the recycle
path must handle - map_check_btf() explicitly whitelists BPF_MAP_TYPE_RHASH
for all three in kernel/bpf/syscall.c.

Could the commit message be narrowed to match the actual coverage (e.g.
"verify the spin-lock, timer and kptr combinations")?

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c b/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
> new file mode 100644
> index 0000000000000..93e8cbacca656
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
> @@ -0,0 +1,337 @@

[ ... ]

> +/* Userspace view of the lkmap value. The BPF side owns the real layout;
> + * the spin lock and the kptr are special fields that value copies skip,
> + * so only the plain bytes actually matter here.
> + */

Three multi-line comments in this file start their text on the opening
'/*' line instead of putting '/*' on its own line (here at line 14, line
114, and line 272). The BPF subsystem's comment style guide requires the
opening '/*' on its own line even in selftests, and the same file already
uses this style correctly elsewhere (lines 30, 57, 160, 211). Could these
three be adjusted to match?

[ ... ]

> +static void recycle_loop(struct rhtab_fields *skel, int map_fd,
> +			 const char *init, const char *del,
> +			 const char *upd, const char *probe,
> +			 int *retries)
> +{

[ ... ]

> +	for (i = 0; i < RECYCLE_LOOPS; i++) {
> +		if (run_prog_ok(skel, init) != 0) {
> +			/* init fails only if the element is missing, which
> +			 * must not happen in this single-threaded loop. Count
> +			 * it so a rhtab bug cannot be absorbed silently; the
> +			 * caller asserts the count is zero.
> +			 */
> +			(*retries)++;

The comment states "init fails only if the element is missing" and says
the caller asserts the count is zero, but run_prog_ok() has already
reported the failure through ASSERT_OK()/ASSERT_EQ() which call test__fail(),
so by the time (*retries)++ executes the subtest is already marked failed.

The subsequent ASSERT_EQ(retries, 0, "no_unexpected_recreate") can only add
a second failure line for an already-failed test, and the recreate+retry
recovery merely lets the loop continue after a hard failure.

Also, run_prog_ok() returns non-zero not only when the element is missing,
but also when bpf_object__find_program_by_name() returns NULL, when
bpf_prog_test_run_opts() fails with any errno, or when the BPF program
returns any non-zero value. The BPF-side init programs return 2 on
bpf_task_acquire()/bpf_percpu_obj_new() failure, not only on a missing
element.

Should this branch be dropped and the loop return on first failure (as the
neighboring prog_tests/rhtab_kptr.c effectively does), or should the
failure path not assert before deciding to retry?

[ ... ]

> +static void subtest_lock_kptr(struct rhtab_fields *skel)
> +{
> +	struct lock_kptr_val_user val = {};
> +	struct lock_kptr_val_user out = {};

[ ... ]

> +	val.magic = LK_MAGIC;
> +	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &val, BPF_F_LOCK),
> +		       "locked_update"))

The syscall value buffers are sized by the userspace mirror struct (24
bytes) while the kernel writes map->value_size bytes. If the BPF-side value
struct in progs/rhtab_fields.c ever grows, the test will overrun its own
stack rather than failing cleanly.

create_zero_elem() has the right guard - ASSERT_LE(bpf_map__value_size(map),
sizeof(zero_val), "value_size_fits") - but only for the shared 64-byte
zero_val buffer, not for val/out. The two _Static_assert()s at lines 26-27
only check the mirror against itself.

Would adding an ASSERT_LE(bpf_map__value_size(skel->maps.lkmap),
sizeof(val), ...) make the contract explicit?

[ ... ]

> +static void subtest_timer(struct rhtab_fields *skel)
> +{

[ ... ]

> +	/*
> +	 * 2. The real cancellation test: arm a long-delay timer on a freshly
> +	 * recycled element and delete the element while the timer is still
> +	 * pending. If the delete failed to cancel it, the callback would run

The timer subtest documents itself as exercising the recycle path (the
comment says "arm a long-delay timer on a freshly recycled element", and
step 3's comment at line 235 says "A recycled element can arm and fire a
fresh timer again"), but the element can never be recycled.

rhtab_delete_elem() frees via bpf_mem_cache_free_rcu() -> unit_free_rcu(),
which puts the object on c->free_by_rcu then c->waiting_for_gp. unit_alloc()
pops only from c->free_llist, and alloc_bulk() refills only from
c->free_by_rcu_ttrace / c->waiting_for_gp_ttrace - an object reaches
free_by_rcu_ttrace only after a full RCU grace period.

The subtest deletes and immediately re-creates the element with no grace
period in between, and each rhtab map owns its own bpf_mem_alloc, so tmap
has only ever freed one or two elements. The re-inserted element is
therefore always a fresh allocation, not a recycled one.

This means steps 2 and 3 verify only that delete cancels a pending timer and
that a new element can arm a timer - both useful, but neither is the recycle
behaviour the comments and the commit message claim. Unlike the kptr
subtests, which loop RECYCLE_LOOPS=2000 times and therefore do get recycled
elements, the timer subtest has no loop and no mechanism to force reuse.

Should the timer subtest either loop like the kptr tests do, or have its
comments and the commit message adjusted to reflect that it does not
actually test recycle?

[ ... ]

The immediately preceding commit in the same series (b51e79dfbe300) added
prog_tests/rhtab_kptr.c with largely identical infrastructure. A subsystem
pattern flags adding a new selftest file for a narrow variant of behavior
an existing test already covers: this file's percpu-counter summation helper
read_counter(), its run_prog_ok() wrapper, and its 2000-iteration recycle
loop with the identical retries+recreate_elem recovery block all appear in
rhtab_kptr.c with the same assertion strings ("no_unexpected_recreate",
"recycle_magic_roundtrip", "recycle_xchg_non_null").

The new kptr_untrusted and kptr_percpu cases are variants of coverage that
rhtab_kptr.c provides for referenced kptrs, and the lock/timer cases are
field variants of the same map type the pre-existing rhash.c in this
directory already covers.

Worth asking whether these should be additional subtests and BPF programs in
rhtab_kptr.c or rhash.c, with one shared helper set and one common header,
rather than a third parallel file? The current arrangement means any change
to the recycle-loop helper has to be made in two places.

> diff --git a/tools/testing/selftests/bpf/progs/rhtab_fields.c b/tools/testing/selftests/bpf/progs/rhtab_fields.c
> new file mode 100644
> index 0000000000000..f8bcd88b7f345
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rhtab_fields.c
> @@ -0,0 +1,378 @@

[ ... ]

> + *  1. lkmap: bpf_spin_lock + referenced kptr + plain data in one value.
> + *     After every recycle the spin lock must still be usable (initialized by
> + *     the alloc path), the referenced kptr must be inherited instead of

The comment says the spin lock of a recycled element is "initialized by the
alloc path". Nothing in the recycle path initializes it.

rhtab_map_update_elem() performs no special-field initialization - commit
8244b62c3a5ed in this same series removed check_and_init_map_value() and
documents that fresh elements come zeroed from the allocator but recycled
elements are not re-initialized. copy_map_value() skips every special-field
offset. bpf_obj_cancel_fields() only touches timer, workqueue and task_work,
not BPF_SPIN_LOCK. __alloc() in kernel/bpf/memalloc.c uses __GFP_ZERO only
for fresh slab memory, not for objects from the per-cpu free list.

So for "after every recycle" - the case this sentence is about - the alloc
path contributes nothing. The lock word is unlocked on a recycled element
only because no one held it when the element was deleted, not because
anything initialized it. The parenthetical asserts an invariant enforced by
initialization when it is only a consequence of the delete-time state.

Could the parenthetical be reworded to say the lock word is left untouched
by the recycle, so it must still be unlocked?

[ ... ]

> +/*  0: lk init ok,       1: lk probe xchg non-NULL,  2: lk probe xchg NULL,
> + *  3: lk probe magic ok,
> + *  4: u init ok,        5: u probe ptr non-NULL,    6: u probe ptr NULL,
> + *  7: pc init ok,       8: pc probe xchg non-NULL,  9: pc probe xchg NULL,
> + * 10: pc probe data roundtrip
> + */

Seven new multi-line comments in this file start their text on the opening
'/*' line instead of on the following line: here at line 98 (counter
legend), line 117 (timer_delay_ns), line 152 (lk_del), line 167 (lk_upd),
line 186 (lk_probe), line 304 (pc_init), and line 352 (pc_probe).

The file's own top-of-file comment (lines 4-28) and the new shared header
rhtab_fields_common.h both already use the required style, so the seven
sites are inconsistent even within this patch. The BPF subsystem comment
style guide explicitly extends the "opening /* on its own line" rule to
selftests even if surrounding code uses the old style.

Could these seven be adjusted to match the file's own top comment?

[ ... ]

The immediately preceding commit in this series added progs/rhtab_kptr.c
with nearly identical init/delete/update/probe program quartets. lk_init/
lk_del/lk_upd/lk_probe here are near-verbatim re-implementations of
init_elem/del_elem/upd_elem/probe_elem there, down to the comment prose. For
example rhtab_kptr.c has upd_elem() with the same body structure as lk_upd()
here, just a different map and struct.

The genuinely new coverage in this patch is the spin-lock/timer/
untrusted-kptr/percpu-kptr field combinations; the plumbing around them is
duplicated. A subsystem pattern flags this: a new selftest file added for a
narrow variant of behavior an existing test already covers more generally.

Worth asking whether rhtab_fields should have been additional map/prog cases
inside the existing rhtab_kptr test (or whether the two files should share a
helper/macro) rather than a second parallel test binary?

[ ... ]

> +SEC("syscall")
> +int lk_upd(void *ctx)
> +{
> +	struct lock_kptr_val val = { .magic = LK_MAGIC };
> +	u32 key = 0;
> +
> +	/* BPF_ANY is safe even though the value holds a spin lock: value
> +	 * copies skip special fields, so the lock word is never written and
> +	 * the prog side does not need to take the lock for an update.
> +	 */
> +	bpf_map_update_elem(&lkmap, &key, &val, BPF_ANY);
> +	return 0;
> +}

All three update programs (lk_upd at line 171, u_upd at line 265, pc_upd at
line 337) discard the bpf_map_update_elem() return value and unconditionally
return 0.

The error is reachable - rhtab_map_update_elem() allocates the element
through bpf_mem_cache_alloc() and returns -ENOMEM on allocation failure (and
-E2BIG when the map is full). Because the prog returns 0 anyway, the
userspace run_prog_ok() wrapper cannot see the failure; it only surfaces one
step later as the following *_probe() returning 1 from its lookup NULL
check, i.e. as a misattributed failure in a different program.

The equivalent function added by the preceding commit in this series does
check it (progs/rhtab_kptr.c upd_elem(): 'if (bpf_map_update_elem(&rhtab,
&key, &val, BPF_ANY)) return 1;'). Could these three match upd_elem() and
return non-zero on failure?

[ ... ]

> +SEC("syscall")
> +int lk_probe(void *ctx)
> +{
> +	struct lock_kptr_val *val;
> +	struct task_struct *old;
> +	__u32 magic;
> +	u32 key = 0;
> +
> +	val = bpf_map_lookup_elem(&lkmap, &key);
> +	if (!val)
> +		return 1;
> +	/* Take the lock directly: a recycled element that came back with a
> +	 * corrupted lock word deadlocks here instead of passing. Helpers are
> +	 * forbidden while the lock is held, so the xchg stays outside.
> +	 */
> +	bpf_spin_lock(&val->lock);

The comment accurately describes the intended behaviour on failure: "a
recycled element that came back with a corrupted lock word deadlocks here
instead of passing". That makes a hard lockup the test's designed failure
signal.

bpf_spin_lock() resolves to __bpf_spin_lock(), which disables preemption
and then spins in arch_spin_lock() with no timeout, no trylock fallback and
no other wake condition. A recycled element whose lock word is non-zero
hangs that CPU inside a BPF program with preemption disabled - the machine
wedges (hard lockup watchdog at best) rather than the selftest reporting a
failure. RECYCLE_LOOPS is 2000, so a bad iteration will be hit.

This matters specifically because, as the FILE-3-CHANGE-1-R1 issue documents,
nothing in the recycle path re-initializes the lock word: bpf_obj_cancel_
fields() does not touch BPF_SPIN_LOCK, copy_map_value() skips it, and only
fresh mem-allocator memory is __GFP_ZERO'd. So the exact regression this
subtest is meant to detect is the one that hangs the box instead of failing.

Would a bpf_spin_lock-free check (reading val->magic plainly, or driving the
locked read from userspace via BPF_F_LOCK as subtest_lock_kptr() already
does) report a failure instead of potentially taking the machine down?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33478386254
--===============4286650453017191177==--
