Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998596;
	b=HjQhv5G7M6qdy9T/WEZFlBL1IOZiEVe1k2apgbV23GeqkIL7glZl918IpkZj61eqjxTD
	 8jTWGRBt6pwVXfGHc+EM3n8EIr3cgHxx3PAdMhpaGbspgEv3C5IClVQ24dyDvKqxt8F+G
	 3gtpx7x/V6Fsvim/l61Vz6vGFl15Aj06vqw9gx0T2t3MFDIUANgDej8ZEmIvC/zIIpcUw
	 kvPlrH73E6BfCcbn8yDVq+1cg/ARHestR4NR224ZjQS/PVbg1peLS1Fy6wvD/TMGO8Hf8
	 4mvZLU1sIvtAb9KkJXGt5i785t8z4TTLxpgx/pJqvybvxrfDvNDFszg9hWYmFc6bZtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998596;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=nCTjKoBXIdQnib56NT96nxkkq0Ed9HNtAzjdbvxg1vM=;
	b=a75FlVG+/K4jU5QOfVwWBm9f7QJ8bDltNnFCSeFMo2zU4hHANrjvARiuYQdSliJ6BKUH
	 G+57b+4y5g0nW7aeIMyFJQElxKQOi8nGnKfeQQ/9sJnlQqNCU18yVrKZRwPc4m2jjstAJ
	 NoxuT0N9XpVXxsxEkF493+kGo4kLtNWebL429d6o4y/HxJTc+mpfykl1wUdXyKM1ni0H9
	 Muk5ezPQT+XgzyqtuZw0NbnFeloIxIbzfdQpv11qIfJuBDcfgDP9N3vPxjsYcA9ET/vC9
	 jJUNLLDCLBf2W5y8VFg0BtPkUvW7ce2aWwzkZRZzNh3jB9zbO0KNCPM5x8ovGNXQgoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULSw1nRJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325F606A32C;
	Fri,  6 Nov 2026 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULSw1nRJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF761F0089F;
	Fri,  6 Nov 2026 20:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998596;
	bh=nCTjKoBXIdQnib56NT96nxkkq0Ed9HNtAzjdbvxg1vM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ULSw1nRJeIdVPu5m8k23tb5tXhXWcx0Z+3YVFReOPZNZHJUo42e5ISBoshhElnoP9
	 HSjHKLTUq++cm12ZZP522Oq8ijXtmyfRu2XKU2JlqMK/YSf1qfHqQQExWybYWfngFk
	 RN7Qox4gEtkxUyAdOLpq/UOZRt9qj9HYGR/rR00SITo7065oewf5flI262KdWTDFQR
	 lZ1kAEUJfXcyLZQdO1aC6qW5ywhxr/jGmnCIjH99zP6p23wreJXMEheJCGwamP/xB7
	 STZCyvKwX/0ftkUPO45T1opNzNU+9SSwxZ5PstEh2aagu9QDWJ80ZjFkkfuy7jPrNg
	 PrB4Cku7dEU1g==
Content-Type: multipart/mixed; boundary="===============1431297378942402890=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <183165d7c572e2e569b9384d6ffeac0992a968d887ef64f65e85d9931590634f@mail.kernel.org>
In-Reply-To: <20261106-lskel-struct-ops-v1-5-a4486ffc79cb@google.com>
References: <20261106-lskel-struct-ops-v1-5-a4486ffc79cb@google.com>
Subject: Re: [PATCH RFC bpf-next 5/7] libbpf: Implement bpf_gen__struct_ops_update_elem() for light skeletons
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,gprocida@google.com,nkapron@google.com,tweek@google.com,mripard@kernel.org,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 20:56:35 +0000 (UTC)

--===============1431297378942402890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Implement bpf_gen__struct_ops_update_elem() for light skeletons

TL;DR: In gen_loader.c, the 8-byte store of a prog fd at a variable offset may
be rejected by the verifier on strict-alignment kernels (e.g. riscv64), so
light skeletons with struct_ops callbacks could fail to load with -EACCES.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c

[ ... ]

> +void bpf_gen__struct_ops_update_elem(struct bpf_gen *gen, int map_idx,
> +				     struct btf *btf,
> +				     struct bpf_struct_ops *st_ops)
> +{

[ ... ]

> +		/* R2 = dynamic kernel member offset from off_slot */
> +		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +						 0, 0, 0, off_slot));
> +		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0));
> +		emit(gen, BPF_JMP_IMM(BPF_JLE, BPF_REG_2,
> +				      KERN_VDATA_MAX_SIZE - sizeof(__u64), 2));
> +		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -E2BIG));
> +		emit_check_err(gen);
> +
> +		/* R1 = kern_vdata_off + offset */
> +		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +						 0, 0, 0, st_ops->kern_vdata_off));
> +		emit(gen, BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2));

[ ... ]

> +		/* Store prog_fd (R0) into kern_vdata + offset (R1) */
> +		emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0));

Can this 8-byte store be rejected by the verifier on strict-alignment
configurations?

After the JLE check, R2 only has var_off = tnum_range(0, 4088), so the low
three bits are unknown.  R1 = blob + kern_vdata_off + R2 then goes through
check_ptr_alignment() -> check_generic_ptr_alignment():

    reg_off = tnum_add(reg->var_off, tnum_const(off));
    if (!tnum_is_aligned(reg_off, size)) {
            ... "misaligned %saccess off %s+%d size %d\n" ...
            return -EACCES;

strict is set for every program when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
is not enabled, which is the default on riscv64 (it is only selected by
RISCV_EFFICIENT_UNALIGNED_ACCESS, which depends on NONPORTABLE).  The light
skeleton loader is loaded without BPF_F_ANY_ALIGNMENT, so on such kernels a
light skeleton with a struct_ops callback would fail to load with -EACCES.

The other variable-offset blob access in gen_loader, emit_st_ops_member_val(),
passes the pointer to bpf_probe_read_kernel(), and helper memory arguments
are not alignment-checked.  Other direct blob stores use constant, 8-byte
aligned offsets.

Would masking the offset, e.g. BPF_ALU64_IMM(BPF_AND, BPF_REG_2, ~7), or
copying through bpf_probe_read_kernel() make the alignment provable?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42289585064
--===============1431297378942402890==--
