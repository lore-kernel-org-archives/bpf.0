Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2693C1090
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648184; cv=none; b=uroeiqo1N2p6P+RUkrU/htxOYOqWdKdR0y8e0kdnPJxeLS2UJx+SOB0Bev0NVarpALJjJXwiTwtj64NxySq2V5pFHUYHZI8iIz5TWlNy2Frzr+TAh9lXRU4RTrM+39C6ZvFcN9YTeIWKBNrf2/rlVMsCTg86G/vGS4CCsl52SOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648184; c=relaxed/simple;
	bh=vhs7QIGVo6wj0w9s+D3Wqfx1FDicNGuerP9i2XSIdxA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uPZNmgBb+up7huuukHwMbtusVgeh2jNwmFAv9our0egvGsF+W7ixBKSD35TIN06lpzPUsYP4yyYXU2hlRFLEkMpYhZGRiS6HBUTLLLYh1cEC5tVfGUDuxzK/rouqCsXRn7Fd/NcBljNJVbO3ueQ8E49gxri73E1CO3n1INdHYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfGdPctG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfGdPctG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ED21F00899;
	Thu, 17 Sep 2026 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789648171;
	bh=h3aRx7MM5ghCaVuATUN0FGewUDoZRbDPl4VvMBNHYmk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VfGdPctGcsJK54/XUcfEkhytXjDBL/Gmea/Bzw/d755YiAmdUdudqUyJJ9fEd+vEb
	 Wzd5MJS84gUKnz+0Wf86X0IJqPLwIW4FXq5AgvEr4OMZU43zWmjYCAJBsZxyKPOZpZ
	 dHOzp2v1WKPFKH1h0IF4NFNilEt78Wet9hXJws7hre5wPoVCzDALB1Vm/gEutHmmBf
	 YKvAT+bsCDWW3nweoNr38ZF1Fp/01bkRheIIqAU/JyZErNf7PKmVqAd/E5P5g60yKi
	 55WzDbZ2uFYnhOyfPeMPTK4Fe8e5aQh4dbUlhjz4AHKPMxA7nzeB8nnpzh/b7u0Ty8
	 s4mHIQi/+u3Zw==
Content-Type: multipart/mixed; boundary="===============0461046882908637368=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b935a7858877d13aa4ab8b6c63f8950e00225b9e8c8fce034b34c6dcdf64b19c@mail.kernel.org>
In-Reply-To: <20260917111127.3780880-6-memxor@gmail.com>
References: <20260917111127.3780880-6-memxor@gmail.com>
Subject: Re: [PATCH bpf v6 05/10] selftests/bpf: Test early in-kernel CO-RE relocation
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 12:29:30 +0000 (UTC)

--===============0461046882908637368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> index a18d3680fb169..ee267289fd88e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> @@ -14,6 +14,129 @@
>
>  static char log[16 * 1024];
>
> +static int load_core_relo_insns(int btf_fd, struct bpf_insn *insns, int insn_cnt,
> +				struct bpf_func_info *funcs, int func_cnt,
> +				int enum_id, int access_str_off, int insn_idx,
> +				bool relocate)
> +{

[ ... ]

> +static void test_early_core_relo(void)
> +{
> +	struct test_btf {
> +		struct btf_header hdr;
> +		__u32 types[18];
> +		char strings[64];
> +	} raw_btf = {
> +		.hdr = {
> +			.magic = BTF_MAGIC,
> +			.version = BTF_VERSION,
> +			.hdr_len = sizeof(struct btf_header),
> +			.type_off = 0,
> +			.type_len = sizeof(raw_btf.types),
> +			.str_off = offsetof(struct test_btf, strings) -
> +				   offsetof(struct test_btf, types),
> +			.str_len = sizeof(raw_btf.strings),
> +		},
> +		.types = {
> +			BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4), /* [1] int */
> +			BTF_FUNC_PROTO_ENC(1, 0),	/* [2] int (*)(void) */
> +			BTF_FUNC_ENC(5, 2),		/* [3] main_fn */
> +			BTF_FUNC_ENC(13, 2),		/* [4] sub_fn */
> +			BTF_TYPE_ENC(20, BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), /* [5] enum */
> +			BTF_ENUM_ENC(45, 0),		/* value = 0 */
> +		},
> +		.strings = "\0int\0main_fn\0sub_fn\0core_relo_poison_missing\0value\0" "0",
> +	};
> +	struct bpf_func_info funcs[] = {
> +		{ .insn_off = 0, .type_id = 3 },
> +		{ .insn_off = 3, .type_id = 4 },
> +	};
> +	struct bpf_insn core_only[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	struct bpf_insn subprog[] = {
> +		BPF_CALL_REL(2),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int access_str_off = 51, enum_id = 5;
                            ^^

This isn't a bug, but could the magic number 51 use an inline comment
like the one in the test_bad_local_id() function below? The
pre-existing test annotates its string offset with /* offset of "0" */,
which makes it clear what access_str_off points at in the BTF string
section.  Here, 51 is the offset of the trailing "0" access string in
.strings, but nothing in the code says so.  Any future edit to an
earlier string would silently break the relocation.

> +	int btf_fd, prog_fd = -1;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
> index 78f19c255f20b..9ac732c142d02 100644
> --- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
> +++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
> @@ -50,6 +50,14 @@
>  	.errstr = "invalid bpf_ld_imm64 insn",
>  	.result = REJECT,
>  },
> +{
> +	"test5 ld_imm64: truncated",
> +	.insns = {
> +	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, 0, 0, 0),
> +	},
> +	.errstr = "invalid bpf_ld_imm64 insn",
> +	.result = REJECT,
> +},

Does this test case provide the coverage its placement in the commit
suggests?  The changelog mentions adding a verifier case "to cover the
early structural check that protects relocation processing," referring
to the new truncated-ldimm64 check added in the preceding kernel commit
(dd4db8b6b10cf in bpf_check()).

However, this case carries no core_relos or prog_btf_fd, and the
asserted string "invalid bpf_ld_imm64 insn" is emitted by the
pre-existing check in check_and_resolve_insns(). probe_filter_length()
yields insn_cnt == 1 for this program because the opcode word is
non-zero, so the truncated ldimm64 is submitted as-is and rejected by
that older check.

Reverting the new early check doesn't change this case's outcome, and
the case doesn't exercise the out-of-bounds insn[i+1] read that the
early check exists to prevent, which requires a CO-RE relocation
pointing at the truncated ldimm64.  The case is harmless as a general
ldimm64 boundary test, but it doesn't appear to discriminate between
kernels with and without the new early check.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35216153389
--===============0461046882908637368==--
