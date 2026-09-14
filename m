Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ECC382F1A
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409961; cv=none; b=SczAfcCS2ODu67k4Xh3BT5/jB1Xr6Yy1uQoCOrtGMpfpQH2ocNbzcbW6Vuk9fYCaEFz8CoTiIEvom3crC68pnJYzK6vfjCOcdEhaemQAWvevI5TXCr3YTipJRpqqmCamM/0CtRDGYDuKB4wnCoBfLqzocylb+i56SMf/iCI/go0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409961; c=relaxed/simple;
	bh=W0TYdT7KuZ0PMzJtv4eFNhb4WyLhiWKsQ8MnLZNUV0E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ICG9ZR8eWExY1CIcsZ+MVHoCeNJa6i4fDmuqzjvikQ3VS1iy0IDd6X97ejULK4Q4YTemzNXqYPh9/VFDpBES6oAhLT44br7Dc0aHJddzLGNeSClrxCH6xhv9DoRVWtCyMSZo4D+0nS7HCFNCr0x/iQlO0BWsaZLiG/lDCql22jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWKS1c07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWKS1c07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA581F00893;
	Mon, 14 Sep 2026 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409959;
	bh=Q8D6fmZvqKTlfPrPwBVeZ/+YNWoM90BApfeTiU96j6I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LWKS1c07+QHqgYFuiYS4w7VPgdfAI1HDoBUEeZLaQ2dpCXBqfHS8ywpZZMdnhQa/X
	 BplDExroATj/H67pRueLEvG6EHBvz/0ZM7pt5COosp8PsCgL7VCFvSGXVBMOcGZ77p
	 2aomi123ZdaE9YM+1eMY2snHVEP7JaLrESgtWdYzBsZMWMvht32EcpaJV6eFRTF6GD
	 KjXA9I/52TOFyEDdjtupbMzKfEKywzcOFYhASFdpAbYQrlu6puUTZRQ008Dof5Ont1
	 XIvIMHsUrpOh8FWBLTXct1MSeb+qz2Nd7p34ySEUq08f61o0gySQre+QhOWKmzBa4n
	 rWTUa20iDNwnA==
Content-Type: multipart/mixed; boundary="===============2499098142792978847=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <943d0ea6eb679a95e9c2e43ab4b3903b8a0df628225377a83b2d7582095d3ad3@mail.kernel.org>
In-Reply-To: <20260914170326.249953-12-daniel@iogearbox.net>
References: <20260914170326.249953-12-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 11/11] selftests/bpf: Add tests for gotox targets across prologue prepends
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 18:19:18 +0000 (UTC)

--===============2499098142792978847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index 9908e538c022b..f102435675c2b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> @@ -1376,77 +1376,161 @@ static void check_insn_array_stale_reuse(void)
>  		close(jt_fd);
> }
>
> +static void check_gotox_target_prologue_shift(void)
> +{
> +	struct bpf_insn insns[] = {
> +		/* insn 0: gotox target and subprog start */
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		/* may_goto +4 -> exit block, bounds the loop */
> +		BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 4, 0),
> +		/* r1 = &jt[0] (insns 2 and 3) */
> +		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE, 0),
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0), /* r1 = ips[0] */
> +		/* insn 5: gotox r1 -> insn 0 */
> +		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0),
> +		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS), /* insn 6: exit block */
> +		BPF_EXIT_INSN(),
> +	};
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
> +	struct bpf_insn_array_value val = {};
> +	int prog_fd = -1, map_fd;
> +	__u32 key = 0;
> +
> +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return;
> +
> +	val.orig_off = 0;
> +	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto cleanup;
> +
> +	opts.fd_array = &map_fd;
> +	opts.fd_array_cnt = 1;
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, ARRAY_SIZE(insns), &opts);
> +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &key, &val), 0, "bpf_map_lookup_elem"))
> +		goto cleanup;
> +	ASSERT_NEQ(val.xlated_off, 0, "gotox target retargeted past prepend");
> +	ASSERT_NEQ(val.xlated_off, (__u32)-1, "gotox target not INSN_DELETED");
> +	ASSERT_NEQ(val.jitted_off, 0, "gotox target has a jitted address");
> +cleanup:
> +	if (prog_fd >= 0)
> +		close(prog_fd);
> +	close(map_fd);
> +}
> +
> +static void check_gotox_target_ctx_prologue_shift(void)
> +{
> +	struct bpf_insn insns[] = {
> +		/* insn 0: gotox target and subprog start */
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, -8),
> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_7, 0x5a5a, 12), /* second visit exits */
> +		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0x5a5a),
> +		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1), /* r6 = ctx */
> +		BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_6, offsetof(struct __sk_buff, data)),
> +		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_6, offsetof(struct __sk_buff, data_end)),
> +		BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 1),
> +		BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 5),
> +		/* insn 9: direct packet write -> tc unclone prologue prepended at insn 0 */
> +		BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0),
> +		/* r5 = &jt[0] (insns 10 and 11) */
> +		BPF_LD_IMM64_RAW(BPF_REG_5, BPF_PSEUDO_MAP_IDX_VALUE, 0),
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_5, 0), /* r5 = ips[0] */
> +		/* insn 13: gotox r5 -> insn 0 */
> +		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_5, 0, 0, 0),
> +		BPF_MOV64_IMM(BPF_REG_0, 0), /* insn 14: exit block */
> +		BPF_EXIT_INSN(),
> +	};
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
> +	struct bpf_insn_array_value val = {};
> +	int prog_fd = -1, map_fd;
> +	__u32 key = 0;
> +
> +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return;
> +
> +	val.orig_off = 0;
> +	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto cleanup;
> +
> +	opts.fd_array = &map_fd;
> +	opts.fd_array_cnt = 1;
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SCHED_CLS, NULL, "GPL", insns,
> +				ARRAY_SIZE(insns), &opts);
> +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &key, &val), 0, "bpf_map_lookup_elem"))
> +		goto cleanup;
> +	ASSERT_NEQ(val.xlated_off, 0, "gotox target retargeted past prepend");
> +	ASSERT_NEQ(val.xlated_off, (__u32)-1, "gotox target not INSN_DELETED");
> +	ASSERT_NEQ(val.jitted_off, 0, "gotox target has a jitted address");
> +cleanup:
> +	if (prog_fd >= 0)
> +		close(prog_fd);
> +	close(map_fd);
> +}

This isn't a bug, but the ~30-line body after the insns[] array in
check_gotox_target_ctx_prologue_shift() is a verbatim copy of the same
block in check_gotox_target_prologue_shift() above. The only differences
are BPF_PROG_TYPE_SCHED_CLS vs BPF_PROG_TYPE_XDP and the wrapping of the
bpf_prog_load() call.

The file's earlier check_gotox_target_nop() test (added in the same
series) is a third near-copy of the same
map-create/update/freeze/load/lookup/assert/cleanup sequence, differing
only in orig_off and the assertion labels. The file otherwise tends to
factor this kind of setup out with helpers like map_create(), prog_load(),
gotox_jt_create(), gotox_prog_load(), and __check_success().

Could these three tests share a small helper - something like
check_gotox_target(prog_type, insns, insn_cnt, orig_off) - instead of
repeating the map create/freeze/load/lookup/cleanup sequence a third time?

>
> static void __test_bpf_insn_array(void)
> {
>  	/* Test if offsets are adjusted properly */
> -
>  	if (test__start_subtest("one2one"))
>  		check_one_to_one_mapping();
> -
>  	if (test__start_subtest("simple"))
>  		check_simple();
> -
>  	if (test__start_subtest("deletions"))
>  		check_deletions();
> -
>  	if (test__start_subtest("deletions-with-functions"))
>  		check_deletions_with_functions();
> -
>  	if (test__start_subtest("blindness"))
>  		check_blindness();
> -
>  	/* Check all kinds of operations and related restrictions */
> -
>  	if (test__start_subtest("incorrect-index"))
>  		check_incorrect_index();

[ ... ]

> -
>  	if (test__start_subtest("insn-array-stale-reuse"))
>  		check_insn_array_stale_reuse();
> +	if (test__start_subtest("gotox-target-prologue-shift"))
> +		check_gotox_target_prologue_shift();
> +	if (test__start_subtest("gotox-target-ctx-prologue-shift"))
> +		check_gotox_target_ctx_prologue_shift();
> }

This isn't a bug, but besides adding the two new subtests, the patch drops
the blank line between every existing subtest in __test_bpf_insn_array(),
which accounts for 44 of the 130 changed lines. It is a pure reflow with
no bearing on the new tests, and it also removes the blank line that used
to set the two grouping comments apart, so '/* Test if offsets are
adjusted properly */' and '/* Check all kinds of operations and related
restrictions */' now abut the surrounding calls and no longer read as
section headers.

Would it be worth splitting the blank-line cleanup in
__test_bpf_insn_array() into its own patch, so the diff for the two new
subtests stays small - and keeping a blank line before the two grouping
comments so they still stand out?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34875126886
--===============2499098142792978847==--
