Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36E4A33F6
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680896; cv=none; b=gOUz1k9h1BxG7qfQ8Dsymn9qNqD7xH/gdAs6RkhAmrhCG5t9l+8yYRj7l32zXQbBldN+5RH88mE6XMlOO7UJfwFE2OT49Sk6JM6X92Hv2VhGtOoi4WsuAPUHo3/CMOgMoBkhBEV4VOVAZnQ+GYYsIcGiub3tWHCIBBBZgaKssxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680896; c=relaxed/simple;
	bh=+8hp+VSOct2HK8RMfRA7RAtovC/v8Z86HcCWFPQhl1M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NqXWDYefJdLVgvlWT4ISvI4aL6XjA6DVcT25p4ERNtZotPE+2520SUMnoNit6ABLzF268dlvsUfZJPYJv+pNdgKDRyIFKkTtPoF+UtzhtZEeYCuBfezIYH/cLbVVoCdINHeNv+YBFQnpksmrzMCQYe6aze55XbTbX1omy/WKQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0+UCiFR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0+UCiFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82D11F00893;
	Thu, 17 Sep 2026 21:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680894;
	bh=vrK51JXeBAI1wLFyAlAR8niUuXWp61UziDH2sDMKRes=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f0+UCiFRcXm75vvy9OII4m9IlTRcspDxtviNl5dID39KeIX5aDIcUORlRvIKKv1H0
	 aY1E9fKOwYUvthaNyX2FPehf6dVb7uA0i/OgFdw/IhpJpqHorHN9Whf1JQ236pCT8U
	 5Em+twMWKS9AHVGnhO+pdHbj50rWcb3iYCuZ1ZHcPjRHmKNOVdOG2qala3uf9e0VjL
	 Rs5a2nmbSmRDtyucd6nBdeG15iK9X6ZPjpf5dzbxPN3lqTgEm1kbKalID4YHgZmYoF
	 3jgU+kAXGph/ZKBo3+8MrTTvIYUM+FAIk6jnd/sJvsE+9o+SB47jfPAPtn4MJ2weI+
	 jtjOXfnBB6QfA==
Content-Type: multipart/mixed; boundary="===============2738813043589874631=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9be54e5e5179851c986782facdda8e916b608ae2e1bb68501fc69f2a4c0c07c8@mail.kernel.org>
In-Reply-To: <20260917203040.3150212-7-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-7-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Cover BPF program manual loading
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:34:53 +0000 (UTC)

--===============2738813043589874631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/dynamicload.c b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
> new file mode 100644
> index 0000000000000..979bdc14f4ffd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <time.h>
> +#include "test_dynamicload.skel.h"
> +
> +#define READ_SZ 456

[ ... ]

> +static void dynamicload_verify_override(void)
> +{
> +	struct test_dynamicload *skel;
> +	int err;
> +
> +	skel = test_dynamicload__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	err = bpf_program__set_load_strategy(skel->progs.prog4, BPF_PROG_LOAD_STRATEGY_DISABLED);
> +	if (!ASSERT_OK(err, "set_load_strategy_disabled"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog4),
> +		       BPF_PROG_LOAD_STRATEGY_DISABLED, "prog4_load_strategy_overridden"))
> +		goto cleanup;
> +
> +	/* keep the other autoload programs out of the way of this load */
> +	bpf_program__set_load_strategy(skel->progs.prog1, BPF_PROG_LOAD_STRATEGY_DISABLED);
> +	bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_DISABLED);

Does this comment match the code? progs/test_dynamicload.c declares
prog1, prog2 and prog3 all as SEC("raw_tp/sys_enter"), meaning all three
are autoload programs. Only prog1 and prog3 are disabled here, so prog2
remains enabled and gets loaded by test_dynamicload__load() below.

Compare with dynamicload_verify_module_btf() which disables all three
(prog1, prog2, prog3) after an identical comment. Should prog2 be
disabled here too, or should the comment explain which programs are being
disabled and why prog2 is left enabled?

Also, neither of these two set_load_strategy() return values is checked,
so a future failure to disable prog1 or prog3 would go unnoticed.

> +
> +	err = test_dynamicload__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	/* prog4 was never loaded, so it cannot be loaded manually either */
> +	err = bpf_program__load_manually(skel->progs.prog4);
> +	ASSERT_ERR(err, "load_manually_after_override");

Is this comment accurate? Looking at bpf_program__load_manually() in
libbpf.c (added by 41c79ac032fd4), it rejects prog4 because its strategy
is BPF_PROG_LOAD_STRATEGY_DISABLED:

    if (prog_is_subprog(obj, prog) ||
        prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL)
        return libbpf_err(-EINVAL);

The reason for rejection is the strategy value, not "was never loaded."
In fact, a MANUAL program is also never loaded by the bulk pass, yet
bpf_program__load_manually() succeeds for it - which test_dynamicload()
demonstrates for this exact program at the "prog4_load_manually"
assertion later. Would it be clearer to say that prog4 was overridden to
DISABLED and manual load is only permitted for MANUAL programs?

[ ... ]

> +static void dynamicload_verify_module_btf(void)
> +{
> +	struct test_dynamicload *skel;
> +	struct bpf_link *link;
> +	int err;
> +
> +	if (!env.has_testmod) {
> +		test__skip();
> +		return;
> +	}

Does test__skip() work correctly here? This helper runs outside any
test__start_subtest() scope, so test_progs.c skips the *entire*
dynamicload test rather than just the module-BTF scenario.

Looking at test_progs.c test__skip() implementation:

    void test__skip(void)
    {
        if (env.subtest_state)
            env.subtest_state->skipped = true;
        else
            env.test_state->skip_cnt++;
    }

dynamicload.c defines no subtests - test_dynamicload() calls these three
helpers as plain function calls - so env.subtest_state is NULL and
test_state->skip_cnt is incremented. print_test_result() then reports:

    else if (skipped_cnt == subtests_cnt || !subtests_cnt)
            fprintf(env.stdout_saved, "SKIP");

With subtest_num == 0 and skip_cnt == 1, the !subtests_cnt arm fires and
the test prints SKIP. This means on any host without bpf_testmod,
'#N dynamicload' is reported as SKIP even though the main manual
load/attach/reload cycle, the imperative-override scenario, and the
prepare-only scenario all ran and passed.

Every neighbouring testmod-dependent test uses the same test__skip()
snippet from *inside* a subtest helper reached via test__start_subtest()
(module_attach.c, ksyms_module.c, btf_module.c, bpf_cookie.c, iters.c,
tp_btf_ids.c). Wrapping the three scenarios in test__start_subtest()
("override", "prepare_only", "module_btf") would scope the skip correctly
and prevent an early failure in test_dynamicload()'s main body from
skipping all three scenarios via goto cleanup. Would that pattern work
here?

[ ... ]

> +void test_dynamicload(void)
> +{
> +	struct bpf_link *link;
> +	struct test_dynamicload *skel;
> +	int err;
> +
> +	skel = test_dynamicload__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;

[ ... ]

> +	/*
> +	 * verify regular unload for manually loaded program,
> +	 * unload prog3 as a regular program
> +	 */
> +	bpf_program__unload(skel->progs.prog3);
> +
> +	/* reset the call flags after unload */
> +	skel->bss->prog2_called = false;
> +	skel->bss->prog3_called = false;
> +
> +	usleep(1);
> +
> +	ASSERT_TRUE(skel->bss->prog2_called, "prog2_called");
> +	ASSERT_FALSE(skel->bss->prog3_called, "prog3_called");
> +
> +	/* reloading prog3 must fail as it was unloaded as a regular program */
> +	err = bpf_program__load_manually(skel->progs.prog3);
> +	ASSERT_ERR(err, "load_manually_after_regular_unload");

Does bpf_program__load_manually() actually detect that a program was
unloaded with the plain bpf_program__unload() API? Looking at
bpf_program__load_manually() in libbpf.c (added by 41c79ac032fd4), its
only rejections are obj->state < OBJ_PREPARED, prog_is_subprog(),
load_strategy != MANUAL, and prog->fd >= 0.

After bpf_program__unload(), the fd is -1 and prog->insns is still
intact, so the reload is actually attempted and reaches the kernel. It
only fails because bpf_program__unload() (libbpf.c:800) zeros the
pointers:

    void bpf_program__unload(struct bpf_program *prog)
    {
            zclose(prog->fd);
            zfree(&prog->func_info);
            zfree(&prog->line_info);
            zfree(&prog->subprogs);
    }

but leaves func_info_cnt / line_info_cnt / *_rec_size set. So
bpf_object_load_prog() passes load_attr.func_info = NULL with
func_info_cnt = 1 and the kernel's check_btf_func() returns -EFAULT.

Two consequences: (a) this assertion is conditional on the func/line-info
triple being submitted - bpf_object_load_prog() only fills it in if
obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(FEAT_BTF_FUNC) -
so on a build/kernel where object BTF is not loaded the reload succeeds
and this subtest fails; (b) any cleanup of bpf_program__unload() that
also zeroes the stale counts silently flips this from a passing to a
failing test. Should either the contract be stated and enforced in
bpf_program__load_manually(), or this assertion dropped?

[ ... ]

> +	test_dynamicload__destroy(skel);
> +
> +	/* separate scenario: imperative override of the declarative marker */
> +	dynamicload_verify_override();
> +
> +	/* separate scenario: prepare()-only is sufficient for manual load */
> +	dynamicload_verify_prepare_only();
> +
> +	/* separate scenario: deferred manual load with a module BTF attach target */
> +	dynamicload_verify_module_btf();
> +	return;
> +
> +cleanup:
> +	test_dynamicload__destroy(skel);
> +}

Would these scenarios benefit from test__start_subtest() wrappers? The
four scenarios are invoked inline, so the test registers zero subtests.
When dynamicload_verify_module_btf() calls test__skip() because
env.has_testmod is false, test_progs' print_test_result() reports the
entire dynamicload test as SKIP even though the main manual
load/attach/reload scenario plus the override and prepare-only scenarios
all ran and passed.

With subtest_num == 0 and skip_cnt == 1, the !subtests_cnt arm in
print_test_result() fires and the pass is silently converted into a skip.
A failure in one scenario also cannot be attributed to a specific
scenario. Wrapping each scenario in test__start_subtest() would keep the
skip scoped to the module-BTF case and report it as "OK (SKIP: 1/4)".

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_dynamicload.c b/tools/testing/selftests/bpf/progs/test_dynamicload.c
> new file mode 100644
> index 0000000000000..156c90afe73e9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_dynamicload.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +bool prog1_called = false;
> +bool prog2_called = false;
> +bool prog3_called = false;
> +bool prog4_called = false;
> +__u32 prog5_sz = 0;
> +
> +SEC("raw_tp/sys_enter")
> +int prog1(const void *ctx)
> +{
> +	prog1_called = true;
> +	return 0;
> +}
> +
> +SEC("raw_tp/sys_enter")
> +int prog2(const void *ctx)
> +{
> +	prog2_called = true;
> +	return 0;
> +}
> +
> +SEC("raw_tp/sys_enter")
> +int prog3(const void *ctx)
> +{
> +	prog3_called = true;
> +	return 0;
> +}

A subsystem pattern flags this as potentially concerning: this new BPF
object duplicates progs/test_load_type.c, which the immediately preceding
commit (c7c06b9e606e1, "selftests/bpf: Cover BPF program load strategy
transitions") added in the same series.

The three globals bool prog1_called/prog2_called/prog3_called and the
three SEC("raw_tp/sys_enter") bodies prog1/prog2/prog3 are byte-identical
in the two files. test_dynamicload.c only adds prog4
(SEC("!raw_tp/sys_enter")), prog5 (SEC("?fentry")), prog5_sz and the
extra #include <bpf/bpf_tracing.h>.

Both tests exercise the same new load-strategy API (load_type.c covers
the strategy transitions, dynamicload.c the manual load/attach/reload
cycle), so the series ends up building and shipping two nearly identical
BPF objects and two skeletons for one feature.

The two test files do cover distinct behavior of the new API, and keeping
the manual-load scenarios in their own object avoids one test's
set_load_strategy() calls perturbing the other's. On that reading the
duplication is only the BPF-side scaffolding (about 20 lines) rather than
duplicated test coverage. Still, would it make sense to add prog4/prog5
to progs/test_load_type.c (and the subtests to prog_tests/load_type.c)
instead of adding a second object with a copy of the same three programs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35272462686
--===============2738813043589874631==--
