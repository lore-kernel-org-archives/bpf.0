Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A9388873;
	Fri, 21 Aug 2026 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355400; cv=none; b=jqv4RTBqL3Xn/nAwK9qvAiQ1m23U2zEvVyfEGXidW3drjTOHCJjNi1X3OqtgR+fLY4+1vZojGXbk7ik9bk41hFsto2sDCw1WfeK5+qJvsQNuJllHXn0YvJxA4MhGCwiRvh2vj/WiwPAGAUufw1fVNzNdYf2ihaCnWYEk7obqzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355400; c=relaxed/simple;
	bh=UfqxAZYxs7c8VxXLs+bw3WfAvwqG60jc+NRnplReJwM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ErfrIipI/Nkv7zunYjvI490ShAwBYiziHvqD3vzevVBXxDlFfIHOUAD8oRfVcsQEZ8I8mdTcurze8iUmi4lyZJsouqCMYgKJ7cQINLf8xIlw0oKZTyUz8pO6cCO3HCjq6XmSxSVdZPw86MwmYvr9yJ/Ke/3vwmiM4Z35pgQ5Khg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXEtYz14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXEtYz14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853C51F000E9;
	Fri, 21 Aug 2026 23:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355398;
	bh=C5K2lAWiiaggG0ogvzD/3koZ1ZRqZbGDwHl2aNHtW6s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lXEtYz14EYFsW8XUJxCoinZVyYrKTX3g1ebHYty9tjnaoA8hUCmH3vmnItYA2tZFj
	 eIXf6zh2K3Jeox148u8eJsNjKRRFZZzQSdcDrQPoJDJ7a+J4bcCqM+KbC6+Z3JXBkX
	 0l164ZUM44tNMAv804I3KE/FJWX/tArcLvpygQio0zMoKE1kzhZ59+GxZPKSeC14Mk
	 +CclD88qR0Ygb0vv18T7xOkdYydLjSzwCbF68MW822oxSnu1wBnOZkPHdyfnISV/a1
	 kT0RrITk+PKRioJM6SAxtPGm1WXDe9rI6xssnPaPMcaA9woajnK28W2CCRpCISPisP
	 U9cNfGN7tRd1w==
Content-Type: multipart/mixed; boundary="===============1285267459122665980=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <641ffc3f09c3aeb9d0f9285ed7975540246f8aee736403a70f1b3218c4288654@mail.kernel.org>
In-Reply-To: <20260822-kasan-v7-9-99afee6ef7fd@bootlin.com>
References: <20260822-kasan-v7-9-99afee6ef7fd@bootlin.com>
Subject: Re: [PATCH bpf-next v7 9/9] selftests/bpf: add tests to validate KASAN on JIT programs
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,laoar.shao@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 23:36:37 +0000 (UTC)

--===============1285267459122665980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add a basic KASAN test runner that loads and test-run programs that can
> trigger memory management bugs. The test captures kernel logs and ensure
> that the expected KASAN splat is emitted by searching for the
> corresponding first lines in the report, hence validated that the needed
> instrumentation has been inserted by the JIT compiler before the
> relevant memory accesses. To allow each test to trigger the expected
> report, the kernel must run with the kasan_multi_shot configuration.
>
> The runner covers different cases and settings: in the nominal case, it
> validates kasan reports on basic instructions (on all supported accesses
> sizes) but also when report _should not_ be emitted (eg: for accesses on
> program stack). The runner also comes with a few specialized tests that
> are then not executed for all sizes/locations:
> - specific atomic ops
> - test for instructions involving different verifier states, with some
>   states flagging memory as stack, and other states as non-stack memory
> - tests that validate the stack marking shifting when a patch is emitted
>   by the verifier (zext/rnd_hi32, constant blindind).
> Most of those tests are able to trigger kasan reports by altering the
> shadow memory (triggering faulty accesses is otherwise complex, because
> of the verifier). A few tests trigger actual faulty accesses (eg
> out-of-bound accesses)
>
> A few of those tests depends on cpuv4 (load_acquire and store_release).
>
>   # ./test_progs -a kasan
>   #171/1   kasan/st_1_not_on_stack:OK
>   #171/2   kasan/st_1_on_stack:OK

[ ... ]

>   #171/29  kasan/simple_atomic_fetch:OK
>   #171/30  kasan/simple_atomic_fetch:OK

The test output pasted here does not match the code being committed. It
shows two subtests both named kasan/simple_atomic_fetch (entries #171/29
and #171/30). With the code in this patch, the simple_atomic_fetch spec
has skip_on_stack_testing = false, so run_subtest_with_size_and_location()
applies the location suffix:

	snprintf(subtest_name, SUBTEST_NAME_MAX_LEN, "%s%s",
		 test->prog_type,
		 test->skip_on_stack_testing ? "" :
		 on_stack		     ? "_on_stack" :
					       "_not_on_stack");

The actual names would be simple_atomic_fetch_not_on_stack and
simple_atomic_fetch_on_stack. The same duplication appears for ldx_patched
(#171/47 and #171/48). Regenerating the test output against this version
of the code would remove the duplicate names, which is important because
duplicate subtest names would make test_progs -t kasan/<name> unable to
select individual cases.

>   #171/47  kasan/ldx_patched:OK
>   #171/48  kasan/ldx_patched:OK

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testing/selftests/bpf/prog_tests/kasan.c
> new file mode 100644
> index 000000000000..2b424767a0f3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kasan.c

[ ... ]

> +#define SUBTEST_NAME_MAX_LEN	128
> +#define PROG_NAME_MAX_LEN	128

[ ... ]

> +struct test_ctx {
> +	__u8  prog_tag[BPF_TAG_SIZE];
> +	struct bpf_object *obj;
> +	int *access_size;
> +	bool skip_load_acq_store_rel;
> +	struct bpf_program *prog;
> +	char prog_name[SUBTEST_NAME_MAX_LEN];
> +	int klog_fd;
> +};

The prog_name buffer is declared with SUBTEST_NAME_MAX_LEN but is written
with PROG_NAME_MAX_LEN as the bound (at run_subtest_with_size_and_location
and run_blinding_subtest). Today both macros are 128, but they are
independent defines with no static assertion linking them. If
PROG_NAME_MAX_LEN were raised (or SUBTEST_NAME_MAX_LEN lowered), the two
writers would overflow into the next struct member. Could the buffer be
sized with the same macro used to bound the writes, or would
sizeof(ctx->prog_name) work at the call sites?

[ ... ]

> +static void run_subtest_with_size_and_location(struct test_ctx *ctx,
> +					       struct test_spec *test,
> +					       int access_size,
> +					       bool on_stack)
> +{
> +	char subtest_name[SUBTEST_NAME_MAX_LEN];
> +
> +	if (test->skip_multi_size_testing) {
> +		snprintf(subtest_name, SUBTEST_NAME_MAX_LEN, "%s%s",
> +			 test->prog_type,
> +			 test->skip_on_stack_testing ? "" :
> +			 on_stack		     ? "_on_stack" :
> +						       "_not_on_stack");
> +	} else {
> +		snprintf(subtest_name, SUBTEST_NAME_MAX_LEN, "%s_%d_%s",
> +			 test->prog_type, access_size,
> +			 on_stack ? "on_stack" : "not_on_stack");
> +	}
> +
> +	snprintf(ctx->prog_name, PROG_NAME_MAX_LEN, "%s%s", test->prog_type,
> +		 test->skip_on_stack_testing ? "" :
> +		 on_stack		     ? "_on_stack" :
> +					       "_not_on_stack");

[ ... ]

> +static void run_blinding_subtest(void)
> +{
> +	struct test_spec blinding_spec = {
> +		.prog_type = "st_blinded",
> +		.is_write = true,
> +	};
> +	char bpf_jit_harden = '2';
> +	struct kasan_harden *skel;
> +	struct test_ctx *ctx;
> +
> +	if (!test__start_subtest("st_blinded"))
> +		return;
> +
> +	ctx = calloc(1, sizeof(*ctx));
> +	if (!ASSERT_OK_PTR(ctx, "alloc blinding ctx"))
> +		return;
> +	ctx->klog_fd = -1;
> +
> +	if (set_bpf_jit_harden(&bpf_jit_harden))
> +		goto free_ctx;

run_blinding_subtest() starts the subtest with test__start_subtest() but
then bails out on set_bpf_jit_harden() failure without recording the
result:

	if (!test__start_subtest("st_blinded"))
		return;
	...
	if (set_bpf_jit_harden(&bpf_jit_harden))
		goto free_ctx;

There is no ASSERT_*() and no test__skip() on that path, so
test__end_subtest() sees error_cnt == 0 and skipped == false and takes the
success branch. The subtest reports OK when the blinded program was never
loaded or run. set_bpf_jit_harden() returns -1 when
open("/proc/sys/net/core/bpf_jit_harden", O_RDWR|O_NONBLOCK) fails or the
read/write fails, which happens in containers or VMs with /proc/sys
read-only, or without privileges to write that sysctl. The only other
caller of this helper, check_blindness() in prog_tests/bpf_insn_array.c,
treats the identical failure as an assertion. Should this do the same
(ASSERT_OK, or an explicit test__skip() with a reason)?

[ ... ]

> +void test_kasan(void)
> +{
> +	struct kasan_write_val val;
> +	struct test_spec *test;
> +	struct test_ctx *ctx;
> +	struct kasan *skel;
> +	__u32 key = 0;
> +	int i, ret;
> +
> +	ctx = calloc(1, sizeof(struct test_ctx));
> +	if (!ASSERT_OK_PTR(ctx, "alloc test ctx"))
> +		return;
> +
> +	if (!is_jit_enabled() || !get_kasan_jit_enabled() ||
> +	    !get_kasan_multi_shot_enabled()) {
> +		test__skip();
> +		goto end;
> +	}

test_kasan() is registered as a parallel-capable test (the entry point is
test_kasan, not serial_test_kasan), yet through run_blinding_subtest() it
does a read-modify-write swap of the machine-global sysctl
net.core.bpf_jit_harden:

	char bpf_jit_harden = '2';
	...
	if (set_bpf_jit_harden(&bpf_jit_harden))   /* writes '2' */
		goto free_ctx;
	...
	set_bpf_jit_harden(&bpf_jit_harden);       /* restores old value */

Under test_progs -j, other worker processes JIT-compile programs
concurrently, so the raised hardening level leaks into unrelated tests
while the window is open. Constant blinding rewrites the emitted JIT
image, which breaks any test that inspects jited output.

More concretely, this patch adds a second racer on that sysctl:
check_blindness() in prog_tests/bpf_insn_array.c performs the same
read-modify-write swap, and test_bpf_insn_array is also a plain test_.
Interleaving the two loses a restore permanently, e.g.

  A reads 0, A writes 2
  B reads 2, B writes 2
  A restores 0
  B restores 2      <- bpf_jit_harden left at 2 after test_progs exits

leaving JIT hardening enabled system-wide after the run, which then
perturbs every subsequent test invocation on that machine. The test also
scans the global /dev/kmsg ring, which other concurrently running tests
are free to write into. Renaming the entry point to serial_test_kasan()
would close both the cross-test interference and the lost-restore
interleaving.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/selftests/bpf/progs/kasan.c
> new file mode 100644
> index 000000000000..ea29197646b0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kasan.c

[ ... ]

> +SEC("tcx/ingress")
> +int stx_on_stack(struct __sk_buff *skb)
> +{
> +	struct kasan_test_val val;
> +
> +	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_test_val));
> +	switch (access_size) {
> +	case 1:
> +		val.data_1 = access_size;
> +		break;
> +	case 2:
> +		val.data_2 = access_size;
> +		break;
> +	case 4:
> +		val.data_4 = access_size;
> +		break;
> +	case 8:
> +		val.data_8 = access_size;
> +		break;
> +	}
> +	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_test_val));
> +	return 0;
> +}

In stx_on_stack and stx_not_on_stack, the value stored is access_size -
the same variable the enclosing switch selects on. Inside case 1: the
compiler knows access_size == 1, so the store degenerates to a
store-immediate.

Specifically, access_size is a plain global in .bss, the switch load and
the re-load in the case arm are separated by no call or store, so GVN CSEs
the second load into the switch condition, and GVN's switch handling
propagates the case value into the successor. The store operand becomes
the literal 1/2/4/8, and clang emits BPF_ST|BPF_MEM, not BPF_STX|BPF_MEM.

That is exactly the distinction the st_* vs stx_* program pair is meant to
cover: arch/x86/net/bpf_jit_comp.c gains two independent emit_kasan_check()
call sites in this series, one under case BPF_ST | BPF_MEM and one under
case BPF_STX | BPF_MEM. If the stx programs compile to BPF_ST they merely
re-run the st tests, and no program in this file covers BPF_STX|BPF_MEM
instrumentation. Nothing fails because the emitted BPF_ST is instrumented
with the same __asan_storeN, so the loss of coverage is invisible. Storing
a value the compiler cannot correlate with the switch selector would pin
the BPF_STX encoding.

[ ... ]

> +SEC("tcx/ingress")
> +int simple_atomic_fetch_on_stack(struct __sk_buff *skb)
> +{
> +	struct kasan_test_val val;
> +
> +	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_test_val));
> +	__sync_fetch_and_or(&val.data_8, 8);
> +	bpf_kfunc_kasan_unpoison(&val, sizeof(struct kasan_test_val));
> +	return 0;
> +}
> +
> +SEC("tcx/ingress")
> +int simple_atomic_fetch_not_on_stack(struct __sk_buff *skb)
> +{
> +	struct kasan_test_val *val;
> +	__u32 key = 0;
> +
> +	val = bpf_map_lookup_elem(&test_map, &key);
> +	if (!val)
> +		return 0;
> +
> +	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_test_val));
> +	__sync_fetch_and_or(&val->data_8, 8);
> +	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_test_val));
> +	return 0;
> +}

The simple_atomic_fetch_{on,not_on}_stack programs discard the result of
__sync_fetch_and_or(), so clang emits the noreturn atomic form
BPF_ATOMIC|BPF_OR, not BPF_OR|BPF_FETCH. The in-tree convention proves
this: progs/atomics.c deliberately keeps two variables per operation,
or64_result = __sync_fetch_and_or(&or64_value, ...) for the fetching
encoding and a separate __sync_fetch_and_or(&or_noreturn_value, ...) whose
only difference is that the result is dropped.

That matters because the fetching encoding is the only thing these two
subtests exist for. In arch/x86/net/bpf_jit_comp.c the fetch case is a
separate, delicate code path:

  bool is_atomic_fetch = (insn->imm == (BPF_AND | BPF_FETCH) ||
                          insn->imm == (BPF_OR  | BPF_FETCH) ||
                          insn->imm == (BPF_XOR | BPF_FETCH));
  if (is_atomic_fetch) {
          pprog = prog;
          emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
          ...
          ip += (prog - pprog);
  }

The CMPXCHG-loop retry target is moved to sit after the injected KASAN
call, and ip is manually re-adjusted so that emit_call() computes a
correct relative displacement. None of that is exercised: with BPF_OR (no
FETCH) is_atomic_fetch is false, so the extra ip accounting and the
branch_target placement are never reached. The subtest still passes,
because a non-fetch 8-byte atomic OR is instrumented with __asan_store8
and produces the same Write of size 8 report the runner greps for, so the
gap is silent. Consuming the result (__sink(__sync_fetch_and_or(...)) as
the ldx programs in this same file already do) is what forces the
BPF_OR|BPF_FETCH encoding the test is named after.

[ ... ]

> +SEC("tcx/ingress")
> +int ldx_oob(struct __sk_buff *skb)
> +{
> +	struct bpf_testmod_oob *val;
> +	struct kasan_test_val volatile tmp;
> +
> +	val = bpf_testmod_oob_alloc();
> +	if (!val)
> +		return 0;
> +
> +	switch (access_size) {
> +	case 1:
> +		tmp.data_1 = (__u8)val->redzone_1;
> +		break;
> +	case 2:
> +		tmp.data_2 = (__u16)val->redzone_2;
> +		break;
> +	case 4:
> +		tmp.data_4 = (__u32)val->redzone_4;
> +		break;
> +	case 8:
> +		tmp.data_8 = (__u64)val->redzone_8;
> +		break;
> +	}
> +	bpf_testmod_oob_free(val);
> +	return tmp.data_1;
> +}

ldx_oob() returns tmp.data_1, but tmp.data_1 is only ever assigned on the
access_size == 1 path. In struct kasan_test_val the fields sit at offsets
0, 2, 4 and 8, so the case 2/4/8 stores never touch offset 0. The runner
exercises exactly those sizes: the ldx_oob spec has
skip_on_stack_testing = true and no skip_multi_size_testing, so
run_subtest() calls run_subtest_with_size() for sizes 1, 2, 4 and 8
(subtests ldx_oob_2/4/8_not_on_stack in the commit log). Because tmp is
declared volatile, the compiler cannot substitute the stored value or elide
the load, so on those three subtests the program performs a real read of an
uninitialized BPF stack slot and returns whatever was left there.

Verification of this program depends on env->allow_uninit_stack. All four
switch arms are explored at load time, so the verifier sees a path where
the 8-byte slot at fp-16 is STACK_INVALID when it is read;
check_stack_read_fixed_off() rejects that unless allow_uninit_stack is set,
and bpf_allow_uninit_stack() requires CAP_PERFMON. The program therefore
only loads for a sufficiently privileged caller.

The intent is clearly just to keep the load from being optimized away, and
the sibling programs in this same file already use the established idiom
for that - __sink(val->data_1) etc. Using __sink() here would drop the
volatile stack struct, the uninitialized read and the CAP_PERFMON
dependency in one go.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/kasan_harden.c b/tools/testing/selftests/bpf/progs/kasan_harden.c
> new file mode 100644
> index 000000000000..a2756bbfd529
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kasan_harden.c

A subsystem pattern flags this as potentially concerning: progs/kasan_harden.c
is a new 42-line BPF object file whose only program, st_blinded(), is a
verbatim copy of the access_size == 1 arm of st_not_on_stack() in
progs/kasan.c:

	val = bpf_map_lookup_elem(&test_map, &key);
	if (!val)
		return 0;

	bpf_kfunc_kasan_poison(val, sizeof(struct kasan_test_val));
	val->data_1 = 0xAA;
	bpf_kfunc_kasan_unpoison(val, sizeof(struct kasan_test_val));

The new file also re-declares struct kasan_test_val, the test_map ARRAY
map and both bpf_kfunc_kasan_poison/unpoison externs, all of which already
exist in progs/kasan.c. Nothing in the program text differs from the
existing test; the only new variable is on the runner side, where
run_blinding_subtest() raises the bpf_jit_harden sysctl to 2 before
loading it so the BPF_ST|BPF_MEM imm store gets rewritten by
bpf_jit_blind_insn(). That makes this a second copy of an existing case,
kept in sync by hand, that exists purely to be loaded under a different
sysctl value.

In BPF selftests one skeleton per progs/*.c is the normal structure, and
the blinding subtest genuinely needs a separately-loaded object:
bpf_jit_harden must be raised before load, and reloading the whole kasan
object (14 programs) under raised harden would slow the test and change
the JIT for every other program in it. A dedicated single-program object
is the cheapest way to get that. The duplicated struct/map/extern
declarations are also unavoidable without introducing a shared header,
since each progs/*.c is compiled independently. The concrete downside is
only maintenance: if struct kasan_test_val or the st_* body changes in
progs/kasan.c, this copy must be updated in lockstep or the two tests
quietly diverge. Could a comment pointing at st_not_on_stack help track
the relationship?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32534828209
--===============1285267459122665980==--
