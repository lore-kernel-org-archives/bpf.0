Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895B495538;
	Tue,  9 Jun 2026 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019781; cv=none; b=flRVrrBia2GeTnCR4O+4txWhza8IO/mjcNHn1FFuAWvpjmzBHCyQmYk6SMyoli2jbdQodlJIBGuXQvp4RKqXKu8bPZmSLHM1AfVS2NXgjZcz2Ts/OFYtwz3ifEoCKt3KT6zGCeRjN9YHxeUUD+mMgrW0z2l6ur0O83svY0StPj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019781; c=relaxed/simple;
	bh=8yofiJ1eFYG4Jqvzncg29KqSB3SmhFW1e7C9CWj5B30=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=u5YJKHF7yu5L1Tl5Ljqxs+SUe8X/+uHnmz6v1IjBj13imtK/oiEkvy4VnRPiZOuGC/9lhCs6RfZj8+GcrtaVciB9IBS/9mXbVnQAEI9aA6vYEfKQiGQVFJgFhQkavHmZhk/Tdk2JM9rdbcFQ/mnaL0z0ExyPdlZ2DyYyim+ijTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ45kTlh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ45kTlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DBC1F00898;
	Tue,  9 Jun 2026 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781019780;
	bh=obffWUKIpafxLcPMRjiocaOnJohFIkkthJyGKz2SivM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IJ45kTlh5MYgbEReXgSWzduopctYiewcx4TcIZBcxkf8vAee2xZP+zAKPdlz/Yh24
	 Xz63ea2KshTOc/0N1e9OFPmtVoB8Kyj2ApyeXZj0SwzuvjlgjjwF9Qz9NMiKwzlkjq
	 78OWWsSAMyXojLLxMSS/GuFv36lwmA6iR884HF64iV6gBzpnW+i0Vqt78ILfCmZ9RF
	 qW/2nZhD29XZoZ+4Flq41E5IX6RkdhiPaddckBod2paQwp/qh8LJ59Jta2g13fmMaV
	 IZCjc/dEdjD7qdKT+RCibcY9ofx2izr8QWPMZmYL8zjAC2bZsP3SGkRexYncREanS4
	 RAqJBIYLR9oQQ==
Content-Type: multipart/mixed; boundary="===============1319065846985096385=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7db7d22d03daf1180d1cc3eea42588ff47ddad6d589cf3e2cef8517ed23d826b@mail.kernel.org>
In-Reply-To: <20260609-f01-02-gotox-bpf-next-v1-2-b441d63a1559@mails.tsinghua.edu.cn>
References: <20260609-f01-02-gotox-bpf-next-v1-2-b441d63a1559@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add cross-subprog gotox target coverage
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,a.s.protopopov@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,gnq25@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 15:42:59 +0000 (UTC)

--===============1319065846985096385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> index 73dc63882b7d..866b4a14ccb7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c

[ ... ]

> @@ -393,6 +417,52 @@ reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, int off1, int off2, int o
>  		close(prog_fd);
>  }
>
> +static void
> +check_cross_subprog_gotox_target(struct bpf_gotox *skel __always_unused)
> +{
> +	struct bpf_insn insns[] = {
> +		/* main subprog [0,14) */
> +		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0, 12),
> +		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6, 0),
> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_7, 0, 4),
> +		BPF_LD_IMM64_RAW(BPF_REG_2, BPF_PSEUDO_MAP_VALUE, 0),
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, 0),
> +		BPF_JMP_A(3),
> +		BPF_LD_IMM64_RAW(BPF_REG_2, BPF_PSEUDO_MAP_VALUE, 0),
> +		BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2, 0),
> +		BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_2, 0, 0, 0),
> +		BPF_MOV64_IMM(BPF_REG_0, 1),
> +		BPF_EXIT_INSN(),
> +
> +		/* static subprog [14,16) */
> +		BPF_MOV64_IMM(BPF_REG_0, 42),
> +		BPF_EXIT_INSN(),
> +	};
> +	int good_fd, bad_fd, prog_fd;
> +
> +	good_fd = create_jt_map_with_target(12);
> +	if (!ASSERT_GE(good_fd, 0, "create_good_jt_map"))
> +		return;
> +
> +	bad_fd = create_jt_map_with_target(14);
> +	if (!ASSERT_GE(bad_fd, 0, "create_bad_jt_map")) {
> +		close(good_fd);
> +		return;
> +	}
> +
> +	insns[4].imm = bad_fd;
> +	insns[8].imm = good_fd;
> +
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
> +				insns, ARRAY_SIZE(insns), NULL);
> +	if (!ASSERT_EQ(prog_fd, -EACCES, "cross_subprog_gotox_prog_load"))
                                 ^^^^^^^

Does this test expect the correct error code? The kernel fix in commit
8f33cb405e13 ("bpf: Fix gotox target validation against CFG") rejects an
unmodeled gotox target with -EINVAL when the CFG jump table check fails:

kernel/bpf/verifier.c:check_indirect_jump() {
    for (i = 0; i < n; i++) {
        if (!is_cfg_indirect_jump_target(env, env->gotox_tmp_buf->items[i])) {
            verbose(env, "gotox target %u from map id=%d is not in the CFG jump table\n", ...);
            return -EINVAL;
        }
    }
}

This -EINVAL propagates unchanged through do_check() -> do_check_common() ->
bpf_check() -> the BPF_PROG_LOAD syscall handler.

The existing reject_offsets() tests in this file legitimately expect -EACCES
because they fail in check_map_access (the INSN_ARRAY read path for bad size
or map-value access checks), a different code path. This new program is
structurally valid through all the loads and only fails at the gotox
instruction's CFG-jump-table check.

Should the assertion compare against -EINVAL instead of -EACCES?

> +		close(prog_fd);
> +
> +	close(bad_fd);
> +	close(good_fd);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27216356316
--===============1319065846985096385==--
