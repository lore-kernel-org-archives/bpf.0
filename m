Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A47380FD5
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409959; cv=none; b=b7irBb2fMFYHszXMyJt7te+1vCGIlEVvStuOuFJHe3cKgNv+SuB9JnFROcXP24Vp2kNxvH/i+Lk5+BIRnLivVE21aoCSzJRuIEocyPzBIERqjmFwocsjbEgpNwPLM4l5Qxcw0cciijI48JgJuMI06shn6+WirSXwwOhaeIDAb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409959; c=relaxed/simple;
	bh=zhnH8oxpPATLgdvSZdEim1b+/jTVuakxif3zrvvJYrc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=A2KiErjmHV/BgFZ4cPv0jGKj9KwUsqqkDeLFbBIWICS+JjxSS+YJMFLn0UDK8H2FU95l/LpWPtufNRTdhTt2SmF11YbKMrks4MxQulH6rJx3aDewCRNzoGrmo4oTx08sCzR/UAa1LoR2aUE+YQ5Y5mLHVoLPkhR4F1pX6GmlDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9A6l7Kp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9A6l7Kp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B691F000FF;
	Mon, 14 Sep 2026 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409957;
	bh=dLS1CXXUTAK33iumYrcEprVLIdVfycnwX9+S1hgTwk8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e9A6l7KpqgDQ2nhSIO/eE+ztiAejxKv//sTbZviyZ7lTDeezep6xtTWqdrAIjKpiB
	 MNy19CDpemHAKbFz8gQT2vFDM0q1bfGnne7fnTUa4CMqH2cU5ZadonroWPcKokeKyo
	 rWvPQtj8Zt6RknAOFYjRcr4ElE/iEXXjMRkU/r64C+xDZ7cjccF09mMXT8Ujk2WyhG
	 kBmv/6pMWTy8A2//JaAlhWHNfIWD46P/bQMkuURjsg9CnVvi8x9EfAQ9fqQI6qg24w
	 9usxjXIY4BClEbvLCO3GNvrT4QseSpIhpnM5g95HEdMlL1aNITcxa4FDv+04xTfy/c
	 sd9LSpDaIzrhw==
Content-Type: multipart/mixed; boundary="===============8725202408466311200=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4eaa75b390f52904714827ab729266de046542ffc0d2531ae3cd5f618ad14c92@mail.kernel.org>
In-Reply-To: <20260914170326.249953-11-daniel@iogearbox.net>
References: <20260914170326.249953-11-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 10/11] selftests/bpf: Add tests for gotox nop targets and insn array reuse
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 18:19:17 +0000 (UTC)

--===============8725202408466311200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index d6ebb4c37aea7..9908e538c022b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c

[ ... ]

> +static void check_gotox_target_nop(void)
> +{
> +	struct bpf_insn insns[] = {
> +		/* r1 = &jt[0] */
> +		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE, 0),
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
> +		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0), /* gotox r1 */
> +		BPF_JMP_IMM(BPF_JA, 0, 0, 0),		/* insn 4: the nop target */
> +		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
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
> +	val.orig_off = 4;
> +	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto cleanup;

This isn't a bug, but could this setup reuse gotox_jt_create_offs()
from earlier in the file?  The create/update/freeze sequence here is
what gotox_jt_create_offs() already does, so map_fd =
gotox_jt_create_offs((const __u32[]){ 4 }, 1); would express it in
one line.

> +
> +	opts.fd_array = &map_fd;
> +	opts.fd_array_cnt = 1;
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, ARRAY_SIZE(insns), &opts);
> +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &key, &val), 0, "bpf_map_lookup_elem"))
> +		goto cleanup;
> +	ASSERT_NEQ(val.xlated_off, (__u32)-1, "gotox target must not be INSN_DELETED");
> +	ASSERT_NEQ(val.jitted_off, 0, "gotox target must have a jitted address");
> +cleanup:
> +	if (prog_fd >= 0)
> +		close(prog_fd);
> +	close(map_fd);
> +}

[ ... ]

> +static void check_insn_array_stale_reuse(void)
> +{
> +	/* helper of a different prog type, to set the prog array's owner */
> +	struct bpf_insn sf[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	/*
> +	 * prog1 binds the insn array (entry points at a real insn, so the JIT
> +	 * fills it in) and tail calls a prog array whose owner is now a
> +	 * different type, which fails in the post-JIT compatibility check.
> +	 */
> +	struct bpf_insn prog1[] = {
> +		BPF_LD_IMM64_RAW(BPF_REG_2, BPF_PSEUDO_MAP_IDX, 1), /* r2 = prog array */
> +		BPF_MOV64_IMM(BPF_REG_3, 0),			   /* r3 = index */
> +		BPF_EMIT_CALL(BPF_FUNC_tail_call),
> +		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),		   /* insn 4: real entry */
> +		BPF_EXIT_INSN(),
> +	};
> +	/*
> +	 * prog2 reuses the insn array as a tracker. Its entry points at a nop
> +	 * that the nop pass removes, so the entry becomes INSN_DELETED and the
> +	 * JIT skips it -- exactly the slot a stale pointer would linger in.
> +	 */
> +	struct bpf_insn prog2[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
> +		BPF_JMP_IMM(BPF_JA, 0, 0, 0),		/* nop */
> +		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
> +		BPF_JMP_IMM(BPF_JA, 0, 0, 0),		/* nop */
> +		BPF_JMP_IMM(BPF_JA, 0, 0, 0),		/* insn 4: tracked nop */
> +		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
> +		BPF_EXIT_INSN(),
> +	};
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
> +	int jt_fd = -1, pa_fd = -1, sf_fd = -1, prog_fd = -1;
> +	struct bpf_insn_array_value val = {};
> +	int fd_array[2];
> +	__u32 key = 0;
> +
> +	jt_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
> +	if (!ASSERT_GE(jt_fd, 0, "insn_array create"))
> +		return;
> +	val.orig_off = 4;
> +	if (!ASSERT_EQ(bpf_map_update_elem(jt_fd, &key, &val, 0), 0, "insn_array update"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(bpf_map_freeze(jt_fd), 0, "insn_array freeze"))
> +		goto cleanup;

This isn't a bug, but could this setup also reuse gotox_jt_create_offs()?
The same create/update/freeze sequence appears here as well.

> +
> +	pa_fd = bpf_map_create(BPF_MAP_TYPE_PROG_ARRAY, "pa", 4, 4, 1, NULL);
> +	if (!ASSERT_GE(pa_fd, 0, "prog_array create"))
> +		goto cleanup;
> +	sf_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", sf, ARRAY_SIZE(sf), NULL);
> +	if (!ASSERT_GE(sf_fd, 0, "owner prog load"))
> +		goto cleanup;
> +	/* insert a non-XDP prog to pin the prog array owner to another type */
> +	if (!ASSERT_EQ(bpf_map_update_elem(pa_fd, &key, &sf_fd, 0), 0, "prog_array update"))
> +		goto cleanup;
> +
> +	fd_array[0] = jt_fd;
> +	fd_array[1] = pa_fd;
> +	opts.fd_array = fd_array;
> +	opts.fd_array_cnt = 2;
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", prog1, ARRAY_SIZE(prog1), &opts);
> +	if (!ASSERT_LT(prog_fd, 0, "prog1 must fail the post-JIT tail call check"))
> +		goto cleanup;
> +
> +	/* prog1 reached the JIT before failing, so the entry is now populated */
> +	if (!ASSERT_EQ(bpf_map_lookup_elem(jt_fd, &key, &val), 0, "lookup after prog1"))
> +		goto cleanup;
> +	if (!ASSERT_NEQ(val.jitted_off, 0, "prog1 should have filled the jitted address"))
> +		goto cleanup;

A subsystem pattern flags this as potentially concerning: the negative
load of prog1 is only checked with ASSERT_LT(prog_fd, 0), so the test
accepts any failure.

The assertion immediately after it (ASSERT_NEQ(val.jitted_off, 0)) is
only meaningful if prog1 failed specifically in the post-JIT
bpf_check_tail_call() stage in __bpf_prog_select_runtime(). Any earlier
failure also satisfies ASSERT_LT, and the test then reports "prog1
should have filled the jitted address" instead of the real cause.

For example, if the JIT is off, prog1 hits -ENOTSUPP from:

kernel/bpf/core.c:__bpf_prog_select_runtime() {
    ...
    if (!fp->jited && jit_needed)
        return -ENOTSUPP;
    ...
}

Or if a future change moves the prog_array owner-type check into
check_map_prog_compatibility(), the verifier would reject prog1 before
it reaches the JIT.

Every other negative case in this file pins the code instead. In
check_gotox_target_other_subprog():

ASSERT_EQ(err, -EINVAL, "program should have been rejected")

And in check_no_map_reuse():

ASSERT_EQ(prog_fd, -EINVAL, ...)

Would asserting prog_fd == -EINVAL here keep the test self-diagnosing?

On the tree as of this commit, prog1 does fail exactly at
bpf_check_tail_call(), so the test is correct today. The question is
whether it remains self-diagnosing if the kernel behavior changes.

> +
> +	opts.fd_array_cnt = 1;
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", prog2, ARRAY_SIZE(prog2), &opts);
> +	if (!ASSERT_GE(prog_fd, 0, "prog2 reuse load"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bpf_map_lookup_elem(jt_fd, &key, &val), 0, "lookup after prog2"))
> +		goto cleanup;
> +	ASSERT_EQ(val.xlated_off, (__u32)-1, "reused entry should be INSN_DELETED");
> +	ASSERT_EQ(val.jitted_off, 0, "stale jitted address must be cleared on reuse");
> +cleanup:
> +	if (prog_fd >= 0)
> +		close(prog_fd);
> +	if (sf_fd >= 0)
> +		close(sf_fd);
> +	if (pa_fd >= 0)
> +		close(pa_fd);
> +	if (jt_fd >= 0)
> +		close(jt_fd);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34875126886
--===============8725202408466311200==--
