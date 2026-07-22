Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFD30D40D
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730071; cv=none; b=dH06Ry52VvsK85f6s0DPtNYWDUP0aD/KcfIAPuaLgYPxdqHRmXEHyEQ07F2MmDweA384b866/YZA0rPAANhIEVQOOwuFoXOvZRiTeINTmzYGaBwcOxyhedYb0ywMJGUSAL5emXaHlWQYzsoX/96//ySQSDfALCu/cvH0jS6jgfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730071; c=relaxed/simple;
	bh=Wsu7SLs1zyfsG8Of7WizFmS2m8fKyvP+8Pv4faVY47g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WWh3bDV38pdN20hyXm2VrI8cqBUUKAHlLhdXr5nb3cHQT9c8mOPX0jTccqyFLVwxvzw5jlbSwe5XjvJ294XgFft5g+1tJbqXVPYmAWuxLMPBXteIPkLJXmEH5asq4gOtAeFrv0DMKwBhTbYiLOuafzCHNRxyMymxrEWStrURDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHPDF/RX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHPDF/RX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA991F000E9;
	Wed, 22 Jul 2026 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784730070;
	bh=GYOQ6XnwhhH3RZBrByxBCPGg/TW0mBUH7YqsxKm4lGQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LHPDF/RXsHp3cxxwwwY7iKE6QaZjBVL05XEKJEgr2jkLHAljbH7s/+7bt+5T5Ib2/
	 +I+uSEoP4nXJD1UvxlAswnGcj3+qcL1tidknhcYM6mkPMJ6So+xo5ZHQ+yxdoly2vu
	 WUdWLqNGCtrdCIdqFhYAEndSEbwLokfP7EY8hJ61ZJ2OJDJIAPd1CBo0q2rtehNqKc
	 BtpQLIjdjEdxjPXZWhI+hTlV67hY2+F4i8bumfk71MOghDn1rcdjE0pqIB+4INqCmW
	 ZRORt25yQdnCeLc2RfNUqMvFvcd/xOs3vB1FNdGdqPPRFdLeEfIfCkMqJMzr6gw0Vw
	 NHKTr265hyvHA==
Content-Type: multipart/mixed; boundary="===============4182586529210164508=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <19a993d6b34ccda8ca5861f41799ab85c9daee8250c9ef393ec3fc5ae4802669@mail.kernel.org>
In-Reply-To: <20260722132424.450230-3-puranjay@kernel.org>
References: <20260722132424.450230-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Inline bpf_iter_num_next() kfunc
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Jul 2026 14:21:08 +0000 (UTC)

--===============4182586529210164508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ff76a1ed04556..6fb8fdd5d5b21 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19807,6 +19807,34 @@ static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
>  	return i;
>  }
>
> +/*
> + * Inline bpf_iter_num_next(). R1 holds the pointer to the iterator. Keep in sync with the
> + * kfunc in kernel/bpf/bpf_iter.c.
> + */
> +static int inline_bpf_iter_num_next(struct bpf_insn *insn_buf)
> +{
> +	int i = 0;
> +
> +	/*
> +	 * s->cur and s->end are int, so the (s64)(s->cur + 1) >= s->end check is equivalent to a
> +	 * signed 32-bit comparison of (s->cur + 1) against s->end and needs no sign extension.
> +	 */
> +	insn_buf[i++] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0);
> +	insn_buf[i++] = BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1);
> +	insn_buf[i++] = BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 4);
> +	/* if ((s32)(s->cur + 1) >= (s32)s->end) goto done; */
> +	insn_buf[i++] = BPF_JMP32_REG(BPF_JSGE, BPF_REG_0, BPF_REG_2, 3);
> +	/* s->cur++; return &s->cur; */
> +	insn_buf[i++] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0);
> +	insn_buf[i++] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> +	insn_buf[i++] = BPF_JMP_A(2);
> +	/* done: s->cur = s->end = 0; return NULL; */
> +	insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +	insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, 0);
> +
> +	return i;
> +}
> +
>  int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
> @@ -19938,6 +19966,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		*cnt = 6;
>  	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_new]) {
>  		*cnt = inline_bpf_iter_num_new(insn_buf);
> +	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
> +		*cnt = inline_bpf_iter_num_next(insn_buf);
>  	}
>
>  	if (env->insn_aux_data[insn_idx].arg_prog) {

The commit message explains the performance motivation for this change, but
could you provide more detailed analysis about how this was determined?

What perf counters or measurements were used to validate the improvement on
ARM64? The explanation focuses on the theoretical benefit of removing a
function call, but it would be helpful to understand the actual measured
impact.

Additionally, how does this compare against can_loop in terms of overhead?
Understanding the relative performance would help evaluate whether this
optimization is addressing the right bottleneck.

Reference: https://lore.kernel.org/bpf/DK55I184SHNJ.37QBB1WKDWOEZ@gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29924758865
--===============4182586529210164508==--
