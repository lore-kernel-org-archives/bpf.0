Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA72262FD0
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361950; cv=none; b=TWcUOJtEYT8oPuRbQ4PTb3z+5NLr7w+oO0jJB5wpJPWz5lb12GMQw9pMRPeABWZ58sZBDszdtsB3se7FfXDj1BbRY5WFL82UNmBrzUgQrT/4wU1agJtVgs8bgYimNjsfxKXablBQ/3hLDQMHEJrVy+IufZ6b5XjQbEoHtqFS3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361950; c=relaxed/simple;
	bh=3UwArNflnl5xpyETZDN8l6ax6dAX36nV//IdVyeDad0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q/SbkpTmd2K/A4Y8+ac5CnWmCNFtykHrdtMFDFXA9vGHhlVV2i9FkjlPsY1y2M0ipLCXfEJYOudN/m4h0i/5H3ceLIRqwWHf0fLHSNsIzyMtDixf4F8qM+nct6vweXnCAqGeuTlXpF47wiA88JBbeBrMXRlygibBNLrKUVV/K4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPD4NdN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPD4NdN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C02A1F000FF;
	Fri, 25 Sep 2026 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790361948;
	bh=9479l15p2JhEmoUcvt2PjFWogKVbvzP+JbqoKRxMk7k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cPD4NdN2pyI6DZCNss5ZLkmk1l1XI2bQj0E1Y7btN24Tr7z5gYyYJIhBmUG3pVOPG
	 2cnJ3ZfiaCuQeU17RFd9vmGa62zLKYbVVhd8pVtoSIosEXu9hhkVObjwsnL6eIPfij
	 FJaxaWTWe1y+WC3HBK4Dt9ASveBEcLqpNasQxYkdngDL9M5aySDUDUvHsDj0eP3iV1
	 rVRQyjv5/8HeCSFm1LFlzQNid/LCetxTbPHOKHW8uZZBcUzT+3+ENGPzzzh1o17s7d
	 jHfEP+mim6vXPZcnIJN7ZN6s++2w9vtVu9ya6/52wp6A+SMhcq/ODcbaCaipJ/nIV+
	 JKAcyewqjLfkg==
Content-Type: multipart/mixed; boundary="===============5560188129820593256=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6b4cc19fb663142521d0924841673471b03b245c4ded54c9a4c09ae09fe90c53@mail.kernel.org>
In-Reply-To: <20260925175244.1136329-14-daniel@iogearbox.net>
References: <20260925175244.1136329-14-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 13/16] selftests/bpf: Add tests for indirect jumps across subprograms
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,john.fastabend@gmail.com,memxor@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 18:45:48 +0000 (UTC)

--===============5560188129820593256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index 0222a9a5d076..40e183269fb6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c

[ ... ]

> +/*
> + * Load 'insns' with the two jump tables 'jt_a' and 'jt_b', in this order in
> + * fd_array, and check the outcome. 'fi' describes the subprograms when given.
> + */
> +static void check_gotox_two_maps(struct bpf_insn *insns, __u32 insn_cnt,
> +				 const __u32 *jt_a, __u32 a_cnt,
> +				 const __u32 *jt_b, __u32 b_cnt,
> +				 int btf_fd, struct bpf_func_info *fi, __u32 fi_cnt,
> +				 int expect_err, const char *expect_msg)
> +{
> +	int map_fd[2] = { -1, -1 };
> +	char *log;
> +	int err;
> +
> +	log = calloc(1, GOTOX_LOG_SZ);
> +	if (!ASSERT_OK_PTR(log, "calloc log"))
> +		return;
> +
> +	map_fd[0] = gotox_jt_create_offs(jt_a, a_cnt);
> +	if (map_fd[0] < 0)
> +		goto free_log;
> +	map_fd[1] = gotox_jt_create_offs(jt_b, b_cnt);
> +	if (map_fd[1] < 0)
> +		goto close_maps;
> +
> +	if (fi)
> +		err = gotox_prog_load_funcs(insns, insn_cnt, map_fd, 2, log,
> +					    btf_fd, fi, fi_cnt);
> +	else
> +		err = gotox_prog_load(insns, insn_cnt, map_fd, 2, log);

This isn't a bug, but is the if (fi) split needed here? Calling
gotox_prog_load_funcs() unconditionally looks equivalent, since it
already skips BTF setup for fi_cnt == 0, and that would make
gotox_prog_load() unnecessary.

> +	if (expect_err)
> +		ASSERT_EQ(err, expect_err, "program should have been rejected");
> +	else
> +		ASSERT_EQ(err, 0, "bpf(BPF_PROG_LOAD)");
> +	if (expect_msg)
> +		ASSERT_HAS_SUBSTR(log, expect_msg, "verifier log");
> +
> +close_maps:
> +	close(map_fd[0]);
> +	if (map_fd[1] >= 0)
> +		close(map_fd[1]);
> +free_log:
> +	free(log);
> +}

[ ... ]

> +#define GOTOX_SUB_START		4
> +#define GOTOX_MAIN_TGT		2
> +#define GOTOX_SUB_TGT		8
> +#define GOTOX_TWO_INSN_CNT	10
> +
> +static void gotox_two_subprogs_fill(struct bpf_insn *insns, __u32 jt_idx, __u32 jt_off)
> +{
> +	insns[0] = BPF_MOV64_IMM(BPF_REG_0, 0);
> +	insns[1] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0,
> +				GOTOX_SUB_START - 1 - 1);
> +	insns[GOTOX_MAIN_TGT] = BPF_MOV64_IMM(BPF_REG_0, 0);
> +	insns[3] = BPF_EXIT_INSN();
> +
> +	/* r1 = &jt[0], by index 'jt_idx' into fd_array */
> +	insns[GOTOX_SUB_START] = (struct bpf_insn) {
> +		.code = BPF_LD | BPF_DW | BPF_IMM,
> +		.dst_reg = BPF_REG_1,
> +		.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
> +		.imm = jt_idx,
> +	};
> +	insns[GOTOX_SUB_START + 1] = (struct bpf_insn) { .imm = 0 };
> +	insns[6] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, jt_off * 8);
> +	insns[7] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
> +	insns[GOTOX_SUB_TGT] = BPF_MOV64_IMM(BPF_REG_0, 1);
> +	insns[9] = BPF_EXIT_INSN();
> +}

[ ... ]

> +/* r1 = &jt[0], by index 'jt_idx' into fd_array; r1 = *r1; gotox r1; r0 = 0; exit */
> +static void gotox_sub_fill(struct bpf_insn *insns, __u32 start, __u32 jt_idx)
> +{
> +	insns[start] = (struct bpf_insn) {
> +		.code = BPF_LD | BPF_DW | BPF_IMM,
> +		.dst_reg = BPF_REG_1,
> +		.src_reg = BPF_PSEUDO_MAP_IDX_VALUE,
> +		.imm = jt_idx,
> +	};
> +	insns[start + 1] = (struct bpf_insn) { .imm = 0 };
> +	insns[start + 2] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
> +	insns[start + 3] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
> +	insns[start + 4] = BPF_MOV64_IMM(BPF_REG_0, 0);
> +	insns[start + 5] = BPF_EXIT_INSN();
> +}

This isn't a bug, but could gotox_two_subprogs_fill() reuse
gotox_sub_fill() for its subprogram half? The jt_off argument looks
like it is always 0 at every call site.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36171663872
--===============5560188129820593256==--
