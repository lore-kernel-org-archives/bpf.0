Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5D46AF04
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710277; cv=none; b=r6cSq9rykbvcwAzcYAAXv6DZ8urEWw95MJAu0zsrMIbF+6wWCUtKKm5gupaXKMrndaByI2b1GGBB92SJNqJVRzgPHyYf2/lhiDFuvErIelgmGbd+ZJ9hTlR7uPgR9ODZ2A2V3J15wkcbNhqWNc86JbzaskkLunt1eRaYVU/HZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710277; c=relaxed/simple;
	bh=gTvceO1EElryLa25xNl2l9R3mAqJ2ZWJUt+wd/TUE24=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tuPWjjkVpcKglkoZRvWzAvaf2eC+UHCTZ5YzBNJ2dNfCXf7+foTw9uLmJ4fxPE2FsDGSLpV+9WAtTF8Lh0/PlQajLUlL8fwiXLsE2dkars/vJCuh/uBDdwPf7w+q5zeCPZdZNQnwd4jvPufmAu5Yx8dMPHqLjLWK6+t/gZCfCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4nS7K6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4nS7K6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440AA1F00899;
	Fri, 18 Sep 2026 05:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789710275;
	bh=Fb3rv8+k5uUSGbdSoHtEY+6i5mY7kkWuge75g6cjBGE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d4nS7K6dbxe9PhmzV8TbP+ZQYl8FIu2PFw1nLngLpvNHQfMY9vnTTt6J2TXCY4zSQ
	 z8Hm+oR8zsOCtC8HA9muVVn5NFg7Z2SvHNeWD0+pp0feyc1XtJDzHWbGk2DBy0cc8r
	 8thOMbkChYBepvK6O55cAhR7dkjCslLZuGLhC7mtrRH10UFjxGkoDqZy6az9nPCeff
	 DRDaDp6PMqywVN3OSvvSg5caF7uLUjKVrVThfWGyrifAOz6ztji1ib4+d4pIGnkzqb
	 oe0ScWT0TuOW4b+1hXHn69QA2cnDol7FMaxhrbzVB7tmnMfAXimiE56kBiA2kusAL3
	 VqDWvVt+Pmlfg==
Content-Type: multipart/mixed; boundary="===============0151117559784617554=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <27a9f5239c8c6a1c6039433b29d55451480f745f023c5f1ba943542502dfd780@mail.kernel.org>
In-Reply-To: <20260918044337.3293731-1-yonghong.song@linux.dev>
References: <20260918044337.3293731-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 19/20] selftests/bpf: Cover the exception cleanup shapes the chain does not reach
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:44:35 +0000 (UTC)

--===============0151117559784617554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/testing/selftests/bpf/exceptions_cleanup.h
> index 630d2e207119a..5896cf83d15ee 100644
> --- a/tools/testing/selftests/bpf/exceptions_cleanup.h
> +++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
> @@ -4,6 +4,7 @@
>  #define __EXCEPTIONS_CLEANUP_H__
>
>  #define THROW_COOKIE		0x100
> +#define INNER_COOKIE		0x200
>
>  /* progs/exceptions_cleanup.c: one bit per frame that reports it ran. */
>  #define RAN_FOO3_PREEMPT	0x1

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> index d1e45b765af26..ffc0b95191681 100644
> --- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c

[ ... ]

> +static void test_shapes(void)
> +{
> +	struct exceptions_cleanup_shapes *skel;
> +
> +	skel = exceptions_cleanup_shapes__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "shapes open_and_load"))
> +		return;

[ ... ]

> +	/* A throwing subprog named by a BPF_PSEUDO_FUNC no helper is handed: the
> +	 * callback check has to look at the bpf_loop(), not at the ld_imm64.
> +	 */
> +	if (test__start_subtest("addr_taken_no_throw"))
> +		run_shape(skel, skel->progs.entry_addr_taken, 1, 2, 0);
> +	if (test__start_subtest("addr_taken_throw"))
> +		run_shape(skel, skel->progs.entry_addr_taken, 101, THROW_COOKIE,
> +			  RAN_ADDR_TAKEN);

Does this comment accurately describe what the addr_taken shape tests?

Looking at addr_taken_callee() in progs/exceptions_cleanup_shapes.c, the
function does hand cb_thrower to bpf_loop(). The ld_imm64 and the
bpf_loop() call are on the same path, after bpf_throw(). Since bpf_throw()
is not declared noreturn, LLVM keeps that tail, and what actually makes
the program load is that the verifier never reaches the bpf_loop() at all
(it is dead after the throw).

So push_callback_call() -> bpf_cleanup_check_callback() never fires.

The shape exercised is 'a BPF_PSEUDO_FUNC whose helper call the verifier
never reaches', not 'a BPF_PSEUDO_FUNC no helper is handed'. Could the
comment be rephrased to reflect what the verifier actually sees?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> new file mode 100644
> index 0000000000000..f5eb2ff15c896
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c

[ ... ]

> +/*
> + * 2. A callee called from both a covered and an uncovered site: the pad is
> + * recorded on the call site, not on the callee. The lock sits between the two
> + * calls because the frame really would leak it if the uncovered call unwound.
> + */
> +static __used __noinline __u64 shared_callee(__u64 x)
> +{
> +	if (x > 100)
> +		bpf_throw(THROW_COOKIE);
> +	return x + 1;
> +}
> +
> +static __used __naked __noinline __u64 shared_frame(void)
> +{
> +	asm volatile (
> +	"r1 = %[input] ll;"
> +	"r6 = *(u64 *)(r1 + 0);"
> +	"r1 = 0;"
> +	"call shared_callee;"
> +	"call bpf_rcu_read_lock;"
> +	"r1 = r6;"
> +"1:"	"call shared_callee;"		/* cleanup region */
> +"2:"
> +	"r6 = r0;"
> +	"call bpf_rcu_read_unlock;"
> +	"r0 = r6;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"r7 = r0;"
> +	"call bpf_rcu_read_unlock;"
> +	PAD_RAN("%[ran]")
> +	"r1 = r7;"
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	:
> +	: [ran]"i"(RAN_SHARED), __imm_addr(input), __imm_addr(pads_ran)
> +	: __clobber_all);
> +}

Does the uncovered call site verify that the pad wouldn't be wrongly
dispatched if an exception occurred there?

The uncovered site is reached with the constant 0 in r1, and shared_callee
only throws when x > 100, so the verifier proves that call cannot throw
and no unwind ever leaves the uncovered site - at verification time or at
run time.

The structural half of the property (only the second call's return address
falls inside the record's native range) is exercised, but the behavioral
half is not: a kernel that wrongly matched the uncovered site's return
address against the record and ran the pad would go unnoticed, because
that site never unwinds.

[ ... ]

> +/*
> + * 6. A tail call that is really taken: the target is a program in its own
> + * right, so the walk ends there and this frame's pad does not run. The callee
> + * can also throw on a path never taken, which keeps the pad out of the sweep.
> + */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +	__uint(max_entries, 1);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +} taken_table SEC(".maps");
> +
> +SEC("syscall")
> +int tc_target(void *ctx)
> +{
> +	bpf_throw(THROW_COOKIE);
> +	return 0;
> +}
> +
> +static __used __noinline __u64 tc_taken_callee(void *ctx, __u64 x)
> +{
> +	/* Never true at run time; the verifier cannot know that, and its
> +	 * unwind out of here is what keeps the caller's pad alive.
> +	 */
> +	if (x == 7)
> +		bpf_throw(THROW_COOKIE);
> +	bpf_tail_call_static(ctx, &taken_table, 0);
> +	return 0;
> +}
> +
> +SEC("syscall")
> +__naked int entry_tail_taken(void)
> +{
> +	asm volatile (
> +	"*(u64 *)(r10 - 8) = r1;"	/* the context, straight from entry */
> +	"r1 = %[input] ll;"
> +	"r2 = *(u64 *)(r1 + 0);"
> +	"if r2 < 101 goto 8f;"
> +	"r1 = *(u64 *)(r10 - 8);"
> +"1:"	"call tc_taken_callee;"		/* cleanup region */
> +"2:"
> +	"exit;"				/* the cookie, delivered at tc_target */
> +"8:"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad: must not run */
> +	PAD_RAN("%[ran]")
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	:
> +	: [ran]"i"(RAN_TC_TAKEN), __imm_addr(input), __imm_addr(pads_ran)
> +	: __clobber_all);
> +}

Can the tail_call_taken subtest fail if the kernel wrongly continues the
walk past the tail-call boundary?

entry_tail_taken narrows the argument before the covered call:

  "r2 = *(u64 *)(r1 + 0);"       /* r2 = input */
  "if r2 < 101 goto 8f;"         /* fallthrough => r2 in [101, U64_MAX] */

tc_taken_callee is a static subprog, so check_func_call() copies the
caller's r1-r5 verbatim into the callee frame. x therefore arrives with
umin_value == 101, and is_branch_taken() resolves 'if (x == 7)' to
never-taken, so the verifier never explores the bpf_throw(). Nothing then
unwinds into entry_tail_taken during verification, the landing pad at
label 3 is never marked seen, and opt_remove_dead_code() removes it.

fixups.c then clears the annotation for any call site whose cleanup_pad
falls inside the removed window:

    if (env->cleanup_info_cnt) {
            for (i = 0; i < env->insn_aux_data_len; i++) {
                    u32 pad = aux_data[i].cleanup_pad;
                    if (pad > off + cnt) aux_data[i].cleanup_pad = pad - cnt;
                    else if (pad > off)  aux_data[i].cleanup_pad = 0;
            }
    }

so no native range is emitted for the region at all. The program still
loads (mark_subprog_might_throw() is a static analysis, so bpf_check_cfg()
still sees the pad edge and check_cleanup_info() runs before the sweep),
and pads_ran stays 0 unconditionally. A kernel that wrongly continued
bpf_stack_walker() past the tail-call boundary into entry_tail_taken's
frame would find no record to match and would still leave pads_ran == 0,
so the subtest passes on a correct and on a broken kernel alike.

The in-code comment is also wrong on both clauses: the verifier CAN know
x != 7 here, and consequently the unwind out of tc_taken_callee is NOT
what keeps the caller's pad alive - nothing does.

Contrast with shape 7 (entry_freplace, lines 862-878), the analogous 'walk
ends in the callee's frame' shape, which deliberately passes the
unnarrowed input value to fr_callee() with no 'if r1 < 101' guard, keeping
fr_callee's identical 'if (x == 7) bpf_throw()' live. Dropping the
'if r2 < 101 goto 8f' guard from entry_tail_taken (or otherwise passing a
value the verifier cannot exclude 7 from) would make the pad survive and
give the subtest something to fail on.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711
--===============0151117559784617554==--
