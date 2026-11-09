Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210085;
	b=iCnctwZ1awMQERiBhq/X/FgymIR1LAcaiFfucjlWBGNQgKszYr7D/gORaq5lMaKEm3S1
	 ik93S6I1TBxkMyiY433U20Q6tLJWlax4GKBX/iJUMJ5E0kE3ymrvcvl5rGoByYoWSTMmx
	 XNPOmGNSkkFfA0J69eCeJ4ursWe1wjvuVraLdvLMgpoNssk9NAjtP6HSbBMxLxh+ppqPo
	 eDZNmoJFSLLIwb6+JsfTfoh5+jZkTTF2IosUAFQ54+sg6nRwXtIdPrPlytvAhgQKjhBGu
	 iR9dOpP0WFMLdfOkDDsC87wKmqI0Fl6qCCJwKSzmD73r24wp/0cPpr+14ZU4R2T/PbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210085;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s9+DSrwEBWLngENxBdAcbMbTmFeRmxvdFIdMWtV6e84=;
	b=xARyJzzNX8xLWOA1t7+xq11C0p5JAb3qvbJwWN65+IPBckZcQu2ikedyUUFOBqkGJqQB
	 T76TPW5rVrNKQSKWE20jfSIl7DJXFR1L/ymzo7sjpLrHFdI7v8k7PSlUB+85a+e579vbC
	 8pNZboS1rkOcDXRfWFyOD1nPyN+9a/cpaHlJeXmSlJRYYzyeVyEeUUfiAMbL104M1V1gU
	 izGdEfcK/id1/uFxJ0CKhbdESJPTJF+Q9r8G6jAbOzXfGQa+LFf01lmSjWUqEDFDt7YL3
	 i5xWltMJ6HF0nghIilkrwlUIltVVkD4bxidQzPTkaGjqU40oNb/zRR+NMoN5Q6gTHRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMz8orjg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B1D606A334
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMz8orjg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856D01F0089F;
	Mon,  9 Nov 2026 07:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794210084;
	bh=s9+DSrwEBWLngENxBdAcbMbTmFeRmxvdFIdMWtV6e84=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cMz8orjgo75Fd8PbxWr1Csg/JaQUmKuLXCt+kwOqPunOE+NmqZgqVKjozXtF5vLRx
	 b1Y1043mRVvSJ1jYHozV9yOLp5WAKUGFoa+4YTDfLiayjxfT98HNK1VCIMq36sqMa8
	 /Sw3/O8EFDCqqe+GzEu5/gWYR6QGOGDrn07ZyIF6jaFIo6cy5+W0hH2QI8OqrTb4V2
	 SqbW1zpdm72jMKLnCKAKXHGliH7/X4Xs49awX6aoVIMeHaevOYBYRbLjq9isQAcsRT
	 zngbc5vzPqJqsLgw7bFjFglc5Ba0aqqdKF1qs3LtyLbp7FDvcCecyaC1SMgCnZhj43
	 0Gng4buvGC6gQ==
Message-ID: <sashiko-outbox-204548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 12/26] bpf: Refine registers linked by scalar
 evolution at conditional jumps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261109064715.2382452-13-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
 <20261109064715.2382452-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 07:41:24 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] bpf: false verifier_bug_if() in check_special_kfunc() for
  slice_slots
- [Medium] bpf: missing tnum_overlap() check in refine_linked_regs()
--

commit 99b81d82029ad28c10234130c05d5b0dee306874
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Refine registers linked by scalar evolution at conditional jumps

This commit uses scalar evolution to find live registers and stack slots
that hold a tested register plus a constant offset on every path to a
conditional jump, and refines their bounds in the main verifier pass.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 83249ecbdfb1d..d980e2c608050 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -16054,6 +16060,12 @@ static int check_special_kfunc(struct bpf_verifi=
er_env *env, struct bpf_call_arg
>  		regs[BPF_REG_0].buf =3D meta->slice_buf;
>  		if (meta->slice_buf.size)
>  			env->seen_stack_slice =3D true;
> +		if (verifier_bug_if(meta->slice_buf.size &&
> +				    !type_is_rdonly_mem(regs[BPF_REG_0].type) &&
> +				    !bpf_scev_in_slice_slots(env, meta->slice_buf.off,
> +							     meta->slice_buf.size),
> +				    env, "slice buffer is not in scev slice_slots"))
> +			return -EFAULT;
>  	} else {
>  		return 0;
>  	}

[Severity: Medium]
Can bpf_scev_in_slice_slots() return false here and trigger a false
verifier_bug_if() when bpf_dynptr_slice_rdwr() is called with a
variable-offset PTR_TO_STACK buffer?

bpf_scev_in_slice_slots() requires every slot in
[meta->slice_buf.off, meta->slice_buf.off + meta->slice_buf.size) to be
set in env->scev->slice_slots, which find_slice_slots() populates from
bpf_may_write_mask():

kernel/bpf/verifier.c:check_kfunc_call() {
    ...
		if (buf->type =3D=3D PTR_TO_STACK) {
			meta.slice_buf.frameno =3D buf->frameno;
			meta.slice_buf.off =3D reg_smin(buf);
			meta.slice_buf.size =3D reg_smax(buf) - reg_smin(buf) +
					      meta.arg_constant.value;
    ...
}

When arg_track tracks discrete stack offsets (such as fp-128 and fp-96)
that merge into a range in the main pass, record_stack_access() only sets
may_write_mask for those discrete slots, leaving the intermediate gap
slots (fp-120..fp-104) unset; unlike check_may_write_mask() with
fixed_off =3D=3D false, bpf_scev_in_slice_slots() rejects the gap slots and
fails verification with -EFAULT.

Similarly, if buffer__szk (meta.arg_constant.value) is 0 and buf has
reg_smax(buf) > reg_smin(buf), record_arg_access() returns early on
!info.size without setting any bits in may_write_mask, while
meta.slice_buf.size is still non-zero.

> @@ -19730,6 +19742,82 @@ static void sync_linked_regs(struct bpf_verifier=
_env *env, struct bpf_verifier_s
[ ... ]
> +static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_=
verifier_state *vstate,
> +			       int idx, u32 regno)
> +{
> +	struct bpf_func_state *frame =3D vstate->frame[vstate->curframe];
> +	struct bpf_reg_state *reg, implied, saved;
> +	u32 pos, linked_regno, fill_off, bits;
> +	s64 delta;
> +
> +	if (frame->regs[regno].type !=3D SCALAR_VALUE)
> +		return;
> +	for (pos =3D 0;
> +	     bpf_scev_next_linked_reg(env, idx, regno, &pos, &linked_regno, &fi=
ll_off, &delta,
> +				      &bits);
> +	     pos++) {
> +		reg =3D scev_reg_for_fill(frame, linked_regno, fill_off, bits);
> +		if (!reg || reg->type !=3D SCALAR_VALUE)
> +			continue;
> +
> +		implied =3D frame->regs[regno];
> +		add_scalar_to_reg(&implied, delta);
> +		if (regs_fit_in_bits(reg, &implied, bits))
> +			bits =3D 64;
> +		if (bits < 32)
> +			continue;
> +		saved =3D *reg;
> +		regs_refine_cond_op(reg, &implied, BPF_JEQ, bits =3D=3D 32);
> +		reg_bounds_sync(reg);
> +		if (reg_is_empty(reg) || const_tnum_range_mismatch(reg) ||
> +		    const_tnum_range_mismatch_32(reg)) {
> +			*reg =3D saved;
> +			continue;
> +		}

[Severity: Medium]
Does refine_linked_regs() need to check tnum_overlap() before calling
regs_refine_cond_op(reg, &implied, BPF_JEQ, bits =3D=3D 32)?

tnum_intersect() assumes its operands overlap and ORs conflicting known 0
and known 1 bits into known 1 bits rather than producing an empty state.
On an infeasible branch where reg and implied have overlapping cnum
ranges but disjoint var_off tnums (for instance, r1 =3D (u8)r0 refined to
even values in [0, 4] while r0 is refined to odd values in [1, 5] on the
taken branch of 'if r0 & 1'), regs_refine_cond_op() turns r1 into odd
values in [1, 3] without triggering reg_is_empty() or
const_tnum_range_mismatch*(), corrupting reg instead of restoring saved.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109064715.2382=
452-1-alexei.starovoitov@gmail.com?part=3D12
