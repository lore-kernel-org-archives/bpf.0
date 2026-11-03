Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711194;
	b=B5PmeNOYcibUQeUX3z+AJQjiayhKp9+nSbMNHM9L1nZZ29+ffn0Zh2zlJ8Med7/DSWm/
	 oaIO4ywgkjzV8xExwTimNZXHUhR9nT1f3R1IHCpHQcZEKzR1HVjO8FaZ0O6YFQlz24FOt
	 ASlqFawQt071PqvAiHTPNYNlNVGUuv2hS1++cduvgDIa4/dlWT0lrOEqVwXyOO1rgpy7K
	 n2Y8Wdcmo8H4N42jKWtcXTfatztS8BFtWvIl5WnFBNfitGuWlCgE5vNiuFk7SULPyUO1u
	 ccJ73T599LjWb4/m6K8Uerz17cheUCm0rtg10KzdXuCCn0Em8WipprLTaE8qTJNbj7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711194;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=OzPkh/h1y4FlAWewko9a2X5rAD5Iv3sK77DXRtpbWnY=;
	b=w9VtOfXoNVyM+cFq2qmoZE/HcWIdhhLNCyClBM+dWYn+zlIqt2AN9JbGkSUuenDDonKo
	 TxFTayGTYkqJ59PRID+ORtsyp9g5l5FSI+/+PMEDAElvLCPlRbreNI22oS9ZMlMNIvR5L
	 iRtXLUvsK/Y6RfgTkKOsao5EpJ3Bu4LnCHcRYJpGZT7cICCx3YHCydcXbZ+H7JToNYlCQ
	 53u8b1HNLB39rC+j/Y1ihhp23+3/VdM2vIwTcsV8agQuAdsu9gUsg763kbHqbd6Oo/FQr
	 L7xj9tQkzNCQvKurQ2Wf+bLucPFLuawIr6sFNSsfflTxAM4xllKQ1g6IhzaoDF4uh8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAX+0ViG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B90606D82C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAX+0ViG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CAC1F00919;
	Tue,  3 Nov 2026 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793711193;
	bh=OzPkh/h1y4FlAWewko9a2X5rAD5Iv3sK77DXRtpbWnY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kAX+0ViGCb8YdaUtQcaXj6MrlGmUmk3DUDfIK9n9fcicwz/5GGxqZr9onGIW9xJVU
	 NREM+vA4UAMCLpufd6Dg+3A2zTN4mC2/GN22tExPH0riODOI+0dgoXtefUdZ2Y7wxi
	 dX5C/Yf5QIRid5tpsoWpxab6ufniXO0PzQS8mUwvAaCCsf0Sfsa7V/eJnjHz4vS15S
	 gnFvhKYSUHBwc/lp9DPb+09GgmlQ0wjGCRfSm6umX4LngiI4QMJI/lYjUpfjDdnRjR
	 1J7BF56pr5VmC6LR/sW025lUSh7NGziNunNLk/mUqAd7DEKYn/l9MbonrZfp3UY1CH
	 nGUgyuvxWQARQ==
Content-Type: multipart/mixed; boundary="===============9106216301166266597=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <eadd9b884e7ca42ebd241f55d6bfd3dd1c9628927b1425e46db2f7197efaeecc@mail.kernel.org>
In-Reply-To: <20261103122733.1383002-21-daniel@iogearbox.net>
References: <20261103122733.1383002-21-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 20/20] selftests/bpf: Extend the JIT instruction tests for arm64 encodings
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: puranjay@kernel.org,memxor@gmail.com,xukuohai@huaweicloud.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 13:06:33 +0000 (UTC)

--===============9106216301166266597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Extend the JIT instruction tests for arm64 encodings

TL;DR: Test issue: test_tail_call's 8-byte XDP packet load may be rejected as
misaligned on kernels without efficient unaligned access (LoongArch, MIPS,
some riscv64), failing the subtest; BPF_F_ANY_ALIGNMENT may fix it.

> diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> --- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
> +++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c

[ ... ]

> @@ -3103,6 +3491,94 @@ static void test_helper_calls(void)
> +static void test_tail_call(void)
> +{
[ ... ]
> +	LIBBPF_OPTS(bpf_prog_load_opts, lopts,
> +		.log_buf = log,
> +		.log_size = sizeof(log),
> +	);
[ ... ]
> +	insns[n++] = BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 5);
> +	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_2, 0);
> +	insns[n++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
[ ... ]
> +	fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, n, &lopts);
> +	if (!ASSERT_GE(fd, 0, "tail call")) {

Can this program load on kernels built without
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS?

The program reads the 8-byte index from offset 0 of the XDP packet and is
loaded with no prog_flags.  Without that config option, bpf_check() forces
strict alignment:

    env->strict_alignment = !!(attr->prog_flags & BPF_F_STRICT_ALIGNMENT);
    if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
        env->strict_alignment = true;
    if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
        env->strict_alignment = false;

check_pkt_ptr_alignment() then adds NET_IP_ALIGN to the offset, so the
BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_2, 0) is checked as offset 2 and
the verifier rejects it with "misaligned packet access off 2+0+0 size 8".
The ASSERT_GE(fd, 0, "tail call") then fails the subtest.

That configuration is the default on LoongArch (ARCH_STRICT_ALIGN) and
MIPS, and it is the default on riscv64 unless
RISCV_EFFICIENT_UNALIGNED_ACCESS is enabled.  x86, arm64 and s390 select
the option, which hides this there.  The commit message says "The tests
check results, so they run on every JIT", and every other subtest in this
file uses BPF_PROG_TYPE_SYSCALL with ctx loads, so test_tail_call is the
only one affected.

At run time the packet data is aligned, so would setting
.prog_flags = BPF_F_ANY_ALIGNMENT in lopts be enough to let the program
load everywhere?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41637976292
--===============9106216301166266597==--
