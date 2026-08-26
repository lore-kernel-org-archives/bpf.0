Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C468453A37
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772332; cv=none; b=n1S9s6sWC1Q2Xh2aNgf0143zjnpNZGQJXxH15tY/DU5Ny8D06+wZCjCb6+DNHropxMcvfRqw+6Ksk1zwor3GErscjTlo5WDg9b4JWzZ1u+pmA/7KbmW1g9DVvZ8tFOMnPBAKGX5yuChaWieKK0ZytcgWdv08LnZbTm59KKzjhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772332; c=relaxed/simple;
	bh=McwFDqTbttLzCMctYSJxtAIY72+/qOO/4GeXMlDtQnM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ncXelD1XKeSE5PERhHG5DWSV8VGsxxugtrPAUtKF6Kr7zxSYj12QPAkHC9yaIMo7v8JuTdQzropH4F5f2oVqIezlmbey9nA57dAOky194GKwFZIdhd4Hq6OlgRyd2LStkyKSZLz41HF3jVQF5APsbbdQgZsMUDjmpin6e8Ky3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRzN5+Y+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRzN5+Y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5061F00A3D;
	Wed, 26 Aug 2026 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787772322;
	bh=4WsM+8O+xmT4e3cdt9kJfzvEoddNFRS+jtYc1+oMM/0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nRzN5+Y+R0UzrJ0grFUFA7h+2XYPW2o+a8xz8IAj1R5p7OA3WgTedKWfKl71ZCGyi
	 EEj9t2VyH/o3m9IEYTqXPhdtuUag6hSxbcfAQgPjURnCBY8Luq0nw7nMo8DZ4Pe7o9
	 0RLNMMeO/FuiC1YvNbqBkXdC4xp2lW7krpCsM1s290sFCv4DhrADCDVPbU0KyM7x6Z
	 dpSrw4lxtH5lUjUeqdLPL193EnGVlLEisK79sxHW74hVRNMHS/a4aXfAbT4u+2VzC1
	 SeoLSNzJ7LWgM7J5NtJGSYUfm1V83Cv48R/U3HD9c55mVTgXMwBHrYKsmhpK8FnEKj
	 7xNwvgA1RNn2g==
Content-Type: multipart/mixed; boundary="===============9001334394806845660=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ad827eec215a17030e0dc3fd6aaa0d11f3449f4347523fdbf07dc9830ae13600@mail.kernel.org>
In-Reply-To: <20260826181825.1826541-6-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-6-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Cover BPF program dynamic loading
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 19:25:22 +0000 (UTC)

--===============9001334394806845660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/dynamicload.c b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
> new file mode 100644
> index 0000000000000..799c43034ff92
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dynamicload.c

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
> +	err = bpf_program__set_load_type(skel->progs.prog4, BPF_PROG_LOAD_TYPE_DISABLED);
> +	if (!ASSERT_OK(err, "set_load_type_disabled"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog4), BPF_PROG_LOAD_TYPE_DISABLED,
> +		       "prog4_load_type_overridden"))
> +		goto cleanup;
> +
> +	/* keep the other dynamic-load-only programs out of the way of this load */
> +	bpf_program__set_load_type(skel->progs.prog1, BPF_PROG_LOAD_TYPE_DISABLED);
> +	bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DISABLED);

The comment says prog1 and prog3 are "dynamic-load-only programs" that
need to be kept out of the way, but in test_dynamicload.c only prog4
has the __load_dynamic tag. prog1 and prog3 are plain
SEC("raw_tp/sys_enter") programs, so bpf_object__init_prog() assigns
load_type = BPF_PROG_LOAD_TYPE_AUTO to both. Without these calls they
would autoload alongside prog2, but that wouldn't affect the prog4
override assertion. Does the comment need updating?

Also, these two bpf_program__set_load_type() calls discard the return
value while all other calls in this function check them. Is the
inconsistency intentional?

> +
> +	err = test_dynamicload__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	/* prog4 was never loaded, so it cannot be loaded dynamically either */
> +	err = bpf_program__load_dynamically(skel->progs.prog4, 0);
> +	ASSERT_ERR(err, "load_dynamically_after_override");

[ ... ]

> +	/* reloading prog3 must fail as it was unloaded as a regular program */
> +	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
> +	ASSERT_ERR(err, "load_dynamically_after_regular_unload");

Does this assertion test the rule the comment describes? Looking at
bpf_program__load_dynamically() in libbpf.c (d8626c4dc022c), it only
rejects three things: obj->state < OBJ_LOADED, prog_is_subprog(), and
prog->load_type != DYNAMIC. After line 175's bpf_program__unload(),
obj->state is still OBJ_LOADED and prog3->load_type is still DYNAMIC,
so both gates pass.

bpf_program__unload() (libbpf.c:799) doesn't touch prog->load_type:

    void bpf_program__unload(struct bpf_program *prog)
    {
        if (!prog)
            return;

        zclose(prog->fd);

        zfree(&prog->func_info);
        zfree(&prog->line_info);
        zfree(&prog->subprogs);
    }

The reload only fails because zfree() NULLs prog->func_info but leaves
prog->func_info_cnt non-zero. bpf_object_load_prog() then copies that
inconsistent pair into the load attrs:

    if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
        load_attr.prog_btf_fd = btf__fd(obj->btf);
        load_attr.func_info = prog->func_info;      /* NULL */
        load_attr.func_info_rec_size = prog->func_info_rec_size;
        load_attr.func_info_cnt = prog->func_info_cnt;  /* still 1 */

and BPF_PROG_LOAD fails with -EFAULT in check_btf_func()'s
copy_from_user(). So the test is really asserting that the kernel
rejects NULL func_info with non-zero func_info_cnt, not that a
regularly-unloaded program cannot be dynamically reloaded.

Two consequences: (1) the assertion is environment-dependent. The
func_info block above is conditional on obj->btf having a valid kernel
fd and FEAT_BTF_FUNC being supported, and prog->func_info_cnt is only
set when obj->btf_ext exists. If BTF fails to load or .BTF.ext is
absent, func_info_cnt is 0, the reload succeeds, and ASSERT_ERR()
fails. The test then reports a kernel regression that doesn't exist.
(2) Zeroing func_info_cnt/line_info_cnt in bpf_program__unload() is
the natural fix for the NULL-pointer/non-zero-count inconsistency;
doing so makes this reload succeed and breaks the test.

Should the series implement the rule the comment describes, perhaps by
having bpf_program__unload() reset prog->load_type, or by adding an
explicit 'unloaded, data released' state that
bpf_program__load_dynamically() checks? Otherwise this assertion and
comment should be dropped.

> +
> +	/* run prog4 (declaratively tagged) through the same dynamic
> +	 * load/attach/trigger/detach/unload cycle as prog3
> +	 */
> +	err = bpf_program__load_dynamically(skel->progs.prog4, 0);
> +	if (!ASSERT_OK(err, "prog4_load_dynamically"))
> +		goto cleanup;
> +
> +	link = bpf_program__attach(skel->progs.prog4);
> +	if (!ASSERT_OK_PTR(link, "prog4_attach"))
> +		goto cleanup;
> +
> +	usleep(1);
> +
> +	if (!ASSERT_TRUE(skel->bss->prog4_called, "prog4_called"))
> +		goto cleanup;
> +
> +	err = bpf_link__destroy(link);
> +	if (!ASSERT_OK(err, "prog4_link_destroy"))
> +		goto cleanup;
> +
> +	err = bpf_program__unload_dynamically(skel->progs.prog4);
> +	ASSERT_OK(err, "prog4_unload_dynamically");
> +
> +	test_dynamicload__destroy(skel);
> +
> +	/* separate scenario: imperative override of the declarative tag */
> +	dynamicload_verify_override();
> +	return;
> +
> +cleanup:
> +	test_dynamicload__destroy(skel);
> +}

dynamicload_verify_override() only runs on the fully-successful path.
test_dynamicload() has 21 'goto cleanup' exits (lines 59, 61, 74, 78,
91, 96, 101, 106, 121, 126, 131, 136, 150, 155, 160, 165, 170, 195,
199, 204, 208), and every one jumps past dynamicload_verify_override()
to the cleanup label. So any single failure anywhere in the prog3
lifecycle silently removes coverage for the declarative-tag override
behaviour that commit 5bddcc170b310 introduced, the scenario the
comment itself calls "separate".

The two scenarios are independent: dynamicload_verify_override() opens
its own skeleton and shares no state with the caller. Would
test__start_subtest() let each scenario have its own pass/fail line in
the test_progs output instead of hiding one behind the other's success?

> diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
> new file mode 100644
> index 0000000000000..fc91f6666c506
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/load_type.c

[ ... ]

> +	/* leaving DYNAMIC for AUTO must restore autoattach (regression test for
> +	 * the autoattach residue bug: set_dynamicload() clears autoattach, and
> +	 * nothing used to restore it on exit)
> +	 */
> +	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_AUTO);
> +	if (!ASSERT_OK(err, "set_load_type_auto"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog3), BPF_PROG_LOAD_TYPE_AUTO,
> +		       "prog3_load_type_auto"))
> +		goto cleanup;
> +
> +	if (!ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog3), "prog3_autoattach_restored"))
> +		goto cleanup;
> +
> +	/* the same residue can relay through DISABLED and resurface on a later
> +	 * DISABLED -> AUTO transition, so the fix must cover both exit edges
> +	 */
> +	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DYNAMIC);

Does this comment match the code? The implementation in 677f95c8adc52
restores autoattach with a single guard keyed off the source state:

    case BPF_PROG_LOAD_TYPE_AUTO:
    case BPF_PROG_LOAD_TYPE_DISABLED:
        if (prog->load_type == BPF_PROG_LOAD_TYPE_DYNAMIC)
            prog->autoattach = true;

So the DYNAMIC -> DISABLED step already clears the residue; there is
nothing left to "relay through DISABLED", and the subsequent DISABLED ->
AUTO step cannot "resurface" it because prog->load_type is no longer
DYNAMIC. There is also no second "exit edge" for the fix to cover: AUTO
and DISABLED share one fall-through arm.

Without the fix, the assertion at line 102 would fail for the same
single reason as line 84 (autoattach never restored on leaving DYNAMIC),
not because of a distinct DISABLED->AUTO path. Does the comment claim
coverage of a code path that doesn't exist?

[ ... ]

> +	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
> +	if (!ASSERT_OK(err, "load_dynamically_1"))
> +		goto cleanup;
> +
> +	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
> +	if (!ASSERT_OK(err, "load_dynamically_2"))
> +		goto cleanup;

The test calls bpf_program__load_dynamically(prog3, 0) twice in a row
with no intervening bpf_program__unload_dynamically() and asserts both
calls succeed, but there is no comment saying what the second call is
meant to prove.

In libbpf (d8626c4dc022c) bpf_program__load_dynamically() unconditionally
calls bpf_object_load_prog(obj, prog, ..., &prog->fd), and
bpf_object_load_prog() ends with a bare *prog_fd = ret; -- it never
inspects or closes an existing prog->fd. So the second call creates a
second kernel BPF program and overwrites prog->fd, leaking the first fd
and pinning the first program instance in the kernel for the remaining
lifetime of the test_progs process. bpf_object__close() only closes the
current prog->fd.

Peer test prog_tests/dynamicload.c does the reload case correctly
(unload_dynamically() then load_dynamically(), lines 148-155), which
makes the unqualified double load here look like a copy/paste rather
than intentional coverage. Does the second call need to be preceded by
bpf_program__unload_dynamically(), or should it be expected to fail? If
the assertion is intentional, it codifies "reload without unload silently
leaks the previous program" as expected API behaviour.

[ ... ]

Andrii Nakryiko raised fundamental concerns in v1 about the complexity
of adding a third autoload state (dynamic) to libbpf. From the review
at https://lore.kernel.org/bpf/CAEf4BzYWe0KCzA4-qwAGp5n_ydJ0_zyLSO=Crr_vewFHzZ0t6Q@mail.gmail.com/:

  "I don't want to complicate bpf_object internals with this third
  autoload state, as this creates tons of non-obvious gotchas that
  have to constantly be checked whenever any new feature is added to
  bpf_object (or even during refactorings)."

He proposed alternative approaches: (1) splitting BPF objects with map
sharing, or (2) a new bpf_object__prepare() API to split load into
prepare/load steps. The patch series proceeded with the dynamic loading
approach without addressing these architectural concerns. Are the
alternative approaches not viable for the use case, or is there a plan
to revisit the design?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33000627295
--===============9001334394806845660==--
