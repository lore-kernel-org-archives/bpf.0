Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F244595750
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989663; cv=none; b=lKySwKyBs/ukFnuKSYmv/AyR0kX5Qd40rUJMhJpBnSZNbMlTn5cWExMvludfi6yBRCLys4aWPuPngQaCCm3TE3H2Xg4nqqEZutPYFZh4Db7zT+MDdGXMTChP24UaQx47CYpZuJvY56z9NH9TqnTEMblTuNNv5WCRHNtNY7Skibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989663; c=relaxed/simple;
	bh=xBqWE7wnNOTu9XxPWVQgyk2Lr547K10BLpcUT+AeeSY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GdaEST1234D7+nDsAJ8dtlrKHaTGob2CmBHC/vShkUUTds5r1EHvs669Znq2VScZrgMAj7eKKevx585pm7dir4CHkgYbKd0n5/Rf82omrgFryI2GhPm10L57EoO5hpWTJ5Z4/8eLrVvqCQF+I9ab8sn9C2dtTGW/u2X3+1PxmaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKQW0TXm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKQW0TXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E991F00898;
	Wed,  9 Sep 2026 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788989654;
	bh=jsIiU1QT5nH1NU8z/qhIkJNmH/UAj7XXv3/Gz13IfXE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EKQW0TXmjs8qPvOvnrcTDOQZKVAGXQCcpEHu/+FeIaseANKRhGhRGuZ3dN8x5gVMB
	 lE+qdvObrZ7DBRGw1VCeb4RmFubVD+cfUSH4erl2L+i4WenMaG3apFvz9iFZpf3IXb
	 XXMmna85GJJg7WeB/lsvGpKJsfZ94GJgbt8Wu3Lg6SINEzvw0ttQ5h/Joi6OE+sMeB
	 VsB/4ANYoyMPSotUo+zvR8v/9FkTgq4Q5R1Yqq86L0Em5PcgZB8uIMeWeh00qUekiE
	 7ANkNgDdLLHPIuhdqGAGBv/ExSeQ2/RzZ4zY6DNMYsZziAHjSUttcLqNqWBcyDL4iv
	 mWoBxgW2XUXJQ==
Content-Type: multipart/mixed; boundary="===============6845118619444232626=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <618b8374365d2061357a550bae31ad573a93c55efe12d71177b5221cf0389155@mail.kernel.org>
In-Reply-To: <20260909204035.24289-6-daniel@iogearbox.net>
References: <20260909204035.24289-6-daniel@iogearbox.net>
Subject: Re: [PATCH bpf 6/6] selftests/bpf: Add tests for indirect jumps across subprograms
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 21:34:13 +0000 (UTC)

--===============6845118619444232626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for indirect jumps across subprograms
>
> Add various gotox corner case tests to improve corner case coverage.
>
>   # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- \
>       ./test_progs -t bpf_insn_array,verifier_gotox,signed_loader
>   [...]
>   #24/13   bpf_insn_array/gotox-tracker-map:OK
>   #24/14   bpf_insn_array/gotox-jt-spans-subprogs:OK
>   #24/15   bpf_insn_array/gotox-jt-spans-with-own-table:OK
>   #24/16   bpf_insn_array/gotox-target-without-cfg-edge:OK
>   #24/17   bpf_insn_array/gotox-target-other-subprog:OK
>   #24/18   bpf_insn_array/gotox-jt-per-subprog:OK
>   #24/19   bpf_insn_array/gotox-span-unreached-entry:OK
>   #24/20   bpf_insn_array/gotox-target-subprog-from-main:OK
>   #24/21   bpf_insn_array/gotox-index-slice-other-subprog:OK
>   #24/22   bpf_insn_array/gotox-target-other-global-subprog:OK
>   #24/23   bpf_insn_array/gotox-callback-leaves-subprog:OK
>   #24      bpf_insn_array:OK
>   [...]
>   #616     verifier_gotox:OK
>   Summary: 3/79 PASSED, 0 SKIPPED, 0/0 FAILED

This isn't a bug, but could the changelog say a sentence or two about
which rejection paths these 11 subtests pin down? The current form just
repeats itself ("various gotox corner case tests to improve corner case
coverage") and then pastes the test_progs output. The names of the
subtests are listed, but the message doesn't explain which verifier
behaviour each group exercises - things like targets leaving the
subprog, targets missing from the CFG jump table, one jump table shared
across subprogs, or callback cases. The sibling patch in this series
("selftests/bpf: Add tests for the indirect jump edge limit") does
state the shape of the program it builds and why, so the shorter form
here stands out within the series.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index c69d44cd4607..d5a831a75d82 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c

[ ... ]

> @@ -710,6 +725,669 @@ static void check_gotox_edges_across_subprogs(void)
>  	free(log);
>  }
>
> +static int gotox_jt_create_offs(const __u32 *offs, __u32 cnt)
> +{

[ ... ]

> +/*
> + * An insn_array map is not necessarily a jump table: one that tracks
> + * instruction offsets covers the whole program and is of no subprog. Such a
> + * map must not keep a program with a gotox elsewhere from loading.
> + */
> +static void check_gotox_tracker_map(void)
                                                   ^^^^

This isn't a bug, but would it be worth rewording "is of no subprog"
here? Looking at compute_subprog_jts() in kernel/bpf/cfg.c, it does
attribute the map to the subprog containing its first entry and sets
jt_spans_subprogs there:

    subprog = bpf_find_containing_subprog(env, jt_cur->items[0]);
    if (!subprog) { ...continue; }
    if (jt_cur->items[jt_cur->cnt - 1] >= (subprog + 1)->start) {
        subprog->jt_spans_subprogs = true;
        ...continue;
    }

Since valid_offsets() already guarantees every entry is less than
prog->len, the !subprog branch is effectively unreachable. A spanning
map doesn't become any subprog's jump table, but it does mark the
subprog holding its first entry. In the three tests using this pattern
(check_gotox_tracker_map, check_gotox_span_unreached_entry,
check_gotox_target_without_cfg_edge), that subprog happens to be main
and the gotox sits in the other subprog, which is why the outcomes are
what the tests assert. Had the spanning map's first entry landed in the
gotox's own subprog, check_gotox_tracker_map would fail to load and
check_gotox_target_without_cfg_edge would be rejected with the "spans
multiple subprogs" message instead. Would wording like "does not become
any subprog's jump table" make that dependency clearer?

> +{

[ ... ]

> +static void check_gotox_target_subprog_from_main(void)
> +{
> +	const __u32 jt_own[] = { GOTOX_FWD_OWN_TGT };
> +	const __u32 jt_leaves[] = { GOTOX_FWD_SUB_START };
> +	struct bpf_insn insns[GOTOX_FWD_INSN_CNT];
> +	int map_fd[2] = { -1, -1 };
> +	char *log;
> +	int err;
> +
> +	log = calloc(1, GOTOX_LOG_SZ);
> +	if (!ASSERT_OK_PTR(log, "calloc log"))
> +		return;
> +
> +	gotox_from_main_fill(insns);
> +
> +	map_fd[0] = gotox_jt_create_offs(jt_own, ARRAY_SIZE(jt_own));
> +	if (map_fd[0] < 0)
> +		goto free_log;
> +	map_fd[1] = gotox_jt_create_offs(jt_leaves, ARRAY_SIZE(jt_leaves));
> +	if (map_fd[1] < 0)
> +		goto close_maps;
> +
> +	err = gotox_prog_load(insns, ARRAY_SIZE(insns), map_fd, 2, log);
> +	ASSERT_EQ(err, -EINVAL, "program should have been rejected");
> +	ASSERT_HAS_SUBSTR(log, "indirect jump from insn 11 to 14 leaves the subprog [0,14)",
> +			  "verifier log");
> +
> +close_maps:
> +	close(map_fd[0]);
> +	close(map_fd[1]);
> +free_log:
> +	free(log);
> +}

This isn't a bug, but could these nine near-identical function bodies
share a small table-driven helper? The same roughly 20-line body
(calloc log, fill insns, two gotox_jt_create_offs() calls, load,
assert, close_maps/free_log labels) is repeated verbatim across
check_gotox_tracker_map, check_gotox_target_other_subprog,
check_gotox_jt_per_subprog, check_gotox_span_unreached_entry,
check_gotox_target_subprog_from_main, check_gotox_jt_spans_subprogs,
check_gotox_jt_spans_with_own_table, check_gotox_target_without_cfg_edge,
and check_gotox_index_slice_other_subprog. The only differences are the
two offset arrays, the fill helper, and the final assertion.

This file's own idiom already factors out that kind of boilerplate -
try_load_gotox_prog() and check_gotox_limit_hit() were introduced for
exactly that purpose in the preceding patch. A small helper taking
(fill, jt_a, jt_b, insn_cnt, expected_err, expected_msg), or a table of
cases, would collapse most of these bodies.

A side effect of the duplication is that the copies drifted:
check_gotox_jt_per_subprog is the only positive test that uses
ASSERT_EQ(err, 0, "bpf(BPF_PROG_LOAD)") and does not print the verifier
log on failure, while check_gotox_tracker_map and
check_gotox_span_unreached_entry both do 'if (!ASSERT_OK(err, ...))
fprintf(stderr, "verifier log: %s\n", log);', and it's also the only
new test without an explanatory comment.

[ ... ]

> +static void check_gotox_target_other_global_subprog(void)
> +{
> +	const __u32 starts[] = { 0, GOTOX_SUB_START };
> +	const __u8 linkage[] = { BTF_FUNC_GLOBAL, BTF_FUNC_GLOBAL };
> +	const __u32 jt_main[] = { GOTOX_MAIN_TGT };
> +	const __u32 jt_sub[] = { GOTOX_SUB_TGT };
> +	struct bpf_insn insns[GOTOX_TWO_INSN_CNT];
> +	int map_fd[2] = { -1, -1 };
> +	struct bpf_func_info fi[2];
> +	struct btf *btf = NULL;
> +	int btf_fd;
> +	char *log;
> +	int err;
> +
> +	log = calloc(1, GOTOX_LOG_SZ);
> +	if (!ASSERT_OK_PTR(log, "calloc log"))
> +		return;
> +
> +	gotox_two_subprogs_fill(insns, 0, 0);
> +
> +	btf_fd = gotox_btf_create(starts, linkage, ARRAY_SIZE(starts), fi, &btf);
> +	if (btf_fd < 0)
> +		goto free_log;
> +
> +	map_fd[0] = gotox_jt_create_offs(jt_main, ARRAY_SIZE(jt_main));
> +	if (map_fd[0] < 0)
> +		goto free_btf;
> +	map_fd[1] = gotox_jt_create_offs(jt_sub, ARRAY_SIZE(jt_sub));
> +	if (map_fd[1] < 0)
> +		goto close_maps;
> +
> +	err = gotox_prog_load_funcs(insns, ARRAY_SIZE(insns), map_fd, 2, log,
> +				    btf_fd, fi, ARRAY_SIZE(fi));
> +	ASSERT_EQ(err, -EINVAL, "program should have been rejected");
> +	ASSERT_HAS_SUBSTR(log, "indirect jump from insn 7 to 2 leaves the subprog [4,10)",
> +			  "verifier log");
> +
> +close_maps:
> +	close(map_fd[0]);
> +	close(map_fd[1]);
> +free_btf:

This isn't a bug, but check_gotox_target_other_global_subprog() looks
line-for-line identical to check_gotox_target_other_subprog() - same
gotox_two_subprogs_fill(insns, 0, 0), same jt_main/jt_sub contents,
same asserted error string "indirect jump from insn 7 to 2 leaves the
subprog [4,10)". The only delta is the BTF func_info that makes subprog
1 BTF_FUNC_GLOBAL, plus the extra btf_fd/free_btf plumbing. Would a
single helper taking the jump tables, the optional BTF/func_info and
the expected log substring read better than the two near-copies?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34404843294
--===============6845118619444232626==--
