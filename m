Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67A15350B
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294492; cv=none; b=L2FK+k8SdTSQA85gWjF4Q+tY6IHKR2JW695c9wjigvcsyU2hDTMBmSTklAVD88XmkDPg0S81VHkJ1PnCTp6pRhdEBIbrbf/TBt/pDnreBvHGJoVVRvHoLUNViku42kJK2Pj90RrqJWt/2MuRsFwGBmyesJJUdjr2lswVIJlSkQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294492; c=relaxed/simple;
	bh=HwAC57/+o3yBK1fNOjYZMHSsosvk+2H+XN1Exl8ZpcY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bXlELtl2BKzzLmWnYzun6emTmgdUjjYGP6ukD1M/w+r1G8xpvUPkiy+HKMTjD9hbQ0rptBQfWXHbZBQi1DpCrjFu3chMyonT/If4trH9TcEZZpikVOmzFmkadxHVD6vcE1QHS3sNIvRvpsw5pyMaPMwkId4r9+6T3Q/uYAzZWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJCNTcN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJCNTcN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14CE1F000FF;
	Fri, 25 Sep 2026 00:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790294491;
	bh=a/adSJd8S2tB5nb3Qwqs80XPAdyw915D7mLgAjv/MVI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SJCNTcN3Rx68tO1jtvT5Y3ZRRq/TfODkUE5MAcDNag0AF8CuGIFLqDou0EU966b5I
	 PQF3dZM/XoZa9vmIy9Iracg2mSm9zwePwpWJ48KHJ4f7xRrQo48LbhpWiJ0XXHc717
	 QJhhC+OJnIZCpoXd8nASQIYDSAFepGhzNJTbyV8xRV6DJm6OVdTyoqOc1XwZs+Mc7Y
	 UP9wqHEtAAawSO1HAIkCl5zUgNyqskpNMZHtRp2PVf0Y35qoXs01RxSBsF2n0ngFIL
	 x8NNM99ZDB1+j/i9dV2gY3eRTl2q+PuFJgLVe5lrcCGRiaHF+BxHyp77vW9KiGlwoY
	 xd7ahcv6AEqzA==
Content-Type: multipart/mixed; boundary="===============5087231649816360489=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <33bcc2451681d52494c3e01a9b968271d55664d3d14bd1c99e7944090c9038cf@mail.kernel.org>
In-Reply-To: <20260924233130.1213812-7-alexei.starovoitov@gmail.com>
References: <20260924233130.1213812-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 6/8] selftests/bpf: Add tests for may_goto with far target
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 00:01:29 +0000 (UTC)

--===============5087231649816360489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/may_goto_far.c b/tools/testing/selftests/bpf/prog_tests/may_goto_far.c
> new file mode 100644
> index 000000000000..8d0ff30bd068
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/may_goto_far.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <linux/filter.h>
> +
> +#define MAY_GOTO(off)	BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, off, 0)
> +#define FILL_CNT	33000
> +
> +static struct bpf_insn *fill(struct bpf_insn *insn, int cnt, int reg)
> +{
> +	while (cnt--)
> +		*insn++ = BPF_MOV64_REG(BPF_REG_0, reg);
> +	return insn;
> +}
> +
> +/*
> + * Syscall prog that loops until may_goto expires. Its target is 'off' insns
> + * away:
> + *
> + *	r6 = r7 = 0, but not a constant for the verifier
> + *	r8 = 2
> + *	r9 = 0
> + *	r0 = r8		x FILL_CNT or 1
> + * 1:	if r6 == r9 goto +1
> + *	exit
> + *	r6 = r8
> + *	r0 = r9		x N when off is negative
> + *	if r7 != r9 goto 3f
> + * 2:	may_goto off	(1b or 4f)
> + *	goto 2b
> + * 3:	r0 = r8		x N when off is positive
> + * 4:	exit
> + *
> + * The prog returns 0 when may_goto jumps to its target and 2 when
> + * it lands in one of 'r0 = r8' areas. There are no constants between
> + * may_goto and its target to keep the distance when constants are blinded.
> + */
> +static void test_far(int off)
> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts, .prog_flags = BPF_F_SLEEPABLE);
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	int front = off < 0 ? 1 : FILL_CNT;
> +	int mid = off < 0 ? -off - 5 : 1;
> +	int back = off < 0 ? FILL_CNT : off - 1;
> +	struct bpf_insn *insns, *insn;
> +	int fd, err;
> +
> +	insns = calloc(front + mid + back + 16, sizeof(*insns));
> +	if (!ASSERT_OK_PTR(insns, "calloc"))
> +		return;
> +
> +	insn = insns;
> +	*insn++ = BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns);
> +	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_0);
> +	*insn++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_6, 63);
> +	*insn++ = BPF_MOV64_REG(BPF_REG_7, BPF_REG_0);
> +	*insn++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_7, 63);
> +	*insn++ = BPF_MOV64_IMM(BPF_REG_8, 2);
> +	*insn++ = BPF_MOV64_IMM(BPF_REG_9, 0);
> +	insn = fill(insn, front, BPF_REG_8);
> +	*insn++ = BPF_JMP_REG(BPF_JEQ, BPF_REG_6, BPF_REG_9, 1);
> +	*insn++ = BPF_EXIT_INSN();
> +	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_8);
> +	insn = fill(insn, mid, BPF_REG_9);
> +	*insn++ = BPF_JMP_REG(BPF_JNE, BPF_REG_7, BPF_REG_9, 2);
> +	*insn++ = MAY_GOTO(off);
> +	*insn++ = BPF_JMP_A(-2);
> +	insn = fill(insn, back, BPF_REG_8);
> +	*insn++ = BPF_EXIT_INSN();
> +
> +	fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, NULL, "GPL", insns, insn - insns, &opts);
> +	free(insns);
> +	if (!ASSERT_GE(fd, 0, "prog_load"))
> +		return;
> +
> +	err = bpf_prog_test_run_opts(fd, &topts);
> +	ASSERT_OK(err, "test_run");
> +	ASSERT_EQ(topts.retval, 0, "retval");
> +	close(fd);
> +}
> +
> +void test_may_goto_far(void)
> +{
> +	if (test__start_subtest("32762"))
> +		test_far(32762);
> +	if (test__start_subtest("32767"))
> +		test_far(32767);
> +	if (test__start_subtest("-32767"))
> +		test_far(-32767);
> +	if (test__start_subtest("-32768"))
> +		test_far(-32768);
> +}

A subsystem pattern flags this as potentially concerning: this adds a
new standalone prog_tests file for one narrow variant of may_goto
behaviour, specifically testing targets far enough away that the
expansion in may_goto_expand() falls back to the 'if AX != 0 goto +1;
gotol' path.

General may_goto coverage already exists in
progs/verifier_may_goto_1.c, which is run by prog_tests/verifier.c.
That file includes runtime cases with __retval checks, including a
SEC("syscall") test. The pc-relative fix earlier in this series also
added its new may_goto cases to verifier_may_goto_1.c. Large
inline-asm programs are already an established pattern in the same
tree: progs/verifier_gotol.c uses '.rept 40000' for a far gotol, and
progs/verifier_call_large_imm.c uses '.rept 32765' and '.rept 32768'.

Could the four offsets (32762, 32767, -32767, -32768) be __naked
__retval(0) cases in verifier_may_goto_1.c instead of a new file?

One reason for a separate file might be that generating the program at
runtime from 'off' derives all four fill counts from one formula, while
the inline-asm form would need four hand-counted .rept programs and a
raw-encoded may_goto for each offset. However, it would be helpful to
understand if that convenience justifies the separate file, or if the
precedent of keeping related may_goto tests together in
verifier_may_goto_1.c takes priority.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36073900100
--===============5087231649816360489==--
