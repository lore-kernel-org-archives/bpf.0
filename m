Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA593AA504
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287751; cv=none; b=H7zTg1/CmjD5a4QHpygCk5HRAJOvvPsZddU2waOq/H/9d7ltND3cCWk5NGDCcLS3AST8J9obgA2d3lrlhQ7/hU/ppLPczlVsY15LWau92rZ4PkvWUVx9Ax834Up6/qEsAZftT7GSWDb/VKXbmuvupktxD0/Bp1A/d7Az6shEvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287751; c=relaxed/simple;
	bh=+cGPZJijrZMPEAsY3K4S7x5KFNPipICs8WY9vg2zTf8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=PBY5AYl5tsvqq52Ye8JexQaDRta7kGPyZZXLcBF7QBiXcr9/YWhvOq09kA1ldIVUfemCgytCfKB9FgQFbga0XwIeHZepnAlJgH1QVc8UMIjS9W0VxrOQboXSHx8lQn/X+wOo5uc17CnHAP0y9w3Wg8ytBJb2T6C+Ed6bCVj8c7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QiHOkRvY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QiHOkRvY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DBD364E414A6;
	Tue,  1 Sep 2026 18:35:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 924B56053C;
	Tue,  1 Sep 2026 18:35:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F90811C7923D;
	Tue,  1 Sep 2026 20:35:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788287743; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IVVVjY5GIfIUllZNpp9UN+vq3+MOSb+Sa1B+4GCYjwQ=;
	b=QiHOkRvYUiVi8oQkYMfea2fl9NUga/anYkT4pijcHKaJ7heyM9Nirv/pNxvvv28rfZJGeh
	C7BERSjLBo/3iMbzgFc15S654rJmmM5fw2j8M2Ey1jiIrdqzIAtjOpHZo499S5kYWwA2Xb
	c7gO8h7/a6Bmux1wUR5bB75Ni/+W7BTgp1dQOJX71WzHypzNdxzDTdiuWpHH3okK8r9eyN
	r3ILia9F1gd7MGSgjwu/62JltvMCMjIXQGixWPUf1a6yzl/7pBQXW3AQSA+vd0N7sEC8Rt
	tRC03W6Oiojjum1rUlZIE/owLNBHaie7mo4hTXLiZaINyBLDzv4wnonaiJDuAA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 20:35:34 +0200
Message-Id: <DL473FWBZ4S2.TDJVQT5A03JD@bootlin.com>
Subject: Re: [PATCH bpf-next v8 1/8] bpf: mark instructions accessing
 program stack
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, <hpa@zytor.com>, <shuah@kernel.org>, <mingo@redhat.com>,
 <andreyknvl@gmail.com>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <laoar.shao@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260828-kasan-v8-1-7c1c0fdb9d7f@bootlin.com>
 <e7bc1da93fb6f9fda0010ff5ad7b5b7fb4d07c3f491803c3332f288eb86f0aea@mail.kernel.org>
In-Reply-To: <e7bc1da93fb6f9fda0010ff5ad7b5b7fb4d07c3f491803c3332f288eb86f0aea@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Aug 28, 2026 at 12:30 PM CEST, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 004b06785521c..412a13a664fa3 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -725,6 +725,8 @@ struct bpf_insn_aux_data {
>>  	u16 const_reg_map_mask;
>>  	u16 const_reg_subprog_mask;
>>  	u32 const_reg_vals[10];
>> +	/* instruction can access non-stack memory */
>> +	bool non_stack_access;
>>  };
>
> The new field is placed at the very end of struct bpf_insn_aux_data, push=
ing
> the struct from 136 to 144 bytes due to alignment, which adds 8 bytes of
> aux data per BPF instruction. For a program at BPF_COMPLEXITY_LIMIT_INSNS
> this is roughly 8 MB of extra vmalloc space for one boolean.
>
> There is already a 3-byte padding hole before orig_idx and 27 unused bits
> in the adjacent u32 bitfield group (jmp_point:1 ... indirect_target:1).
>
> Would declaring non_stack_access as a bit in the existing u32 bitfield
> group avoid the size increase?

Yes, I should have gone directly with a bit-field here. I'll update
accordingly.

> [ ... ]
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 65b441e4a3517..edcb0cbbb13de 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -208,12 +208,25 @@ static int get_callee_stack_depth(struct bpf_verif=
ier_env *env,
>>  }
>>  #endif
>>
>> +static bool is_mem_insn(struct bpf_insn *insn)
>> +{
>> +	if (BPF_CLASS(insn->code) !=3D BPF_ST &&
>> +	    BPF_CLASS(insn->code) !=3D BPF_STX &&
>> +	    BPF_CLASS(insn->code) !=3D BPF_LDX)
>> +		return false;
>> +
>> +	return (BPF_MODE(insn->code) =3D=3D BPF_MEM ||
>> +		BPF_MODE(insn->code) =3D=3D BPF_MEMSX ||
>> +		BPF_MODE(insn->code) =3D=3D BPF_ATOMIC);
>> +}
>
> Does is_mem_insn() correctly handle the speculation barrier
> pseudo-instruction BPF_ST_NOSPEC()?
>
> BPF_NOSPEC is defined as 0xc0, the same mode value as BPF_ATOMIC (0xc0),
> and BPF_ST_NOSPEC() encodes code =3D BPF_ST | BPF_NOSPEC (0x02 | 0xc0 =3D=
 0xc2).
> The class test passes (BPF_ST) and the mode test passes via the
> BPF_MODE(insn->code) =3D=3D BPF_ATOMIC arm, so is_mem_insn() returns true=
 for
> an instruction that performs no memory access at all.
>
> Every Spectre v1/v4 mitigation patch in do_misc_fixups() inserts such a
> barrier through bpf_patch_insn_data(), so on any program that requires a
> nospec barrier the barrier slot is given non_stack_access =3D true by the
> new marking code in adjust_insn_aux_data().
>
> On x86-64 the consumer added later in the series handles case BPF_ST |
> BPF_NOSPEC in a separate switch arm that emits an LFENCE and never reache=
s
> the load/store instrumentation path, so there is no functional
> misbehaviour on x86 today.
>
> However, the helper's stated contract ('is this a memory instruction') is
> wrong, the flag is set on non-memory slots, and any future or other-arch
> consumer of non_stack_access that dispatches on class/mode alone will
> inherit the confusion.
>
> Should the helper exclude BPF_ST | BPF_NOSPEC explicitly, for example by
> testing insn_is_nospec() or handling the BPF_ST case separately?

True. The omission does not affect the final instrumentation, but I'll
add it for correctness.

>>
>>  /* single env->prog->insni[off] instruction was replaced with the range
>>   * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copyin=
g
>>   * [0, off) and [off, end) to new locations, so the patched range stays=
 zero
>>   */
>>  static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>> -				 struct bpf_prog *new_prog, u32 off, u32 cnt)
>> +				 struct bpf_prog *new_prog, u32 off, u32 cnt,
>> +				 struct bpf_insn *original_insn)
>>  {
>>  	struct bpf_insn_aux_data *data =3D env->insn_aux_data;
>>  	struct bpf_insn *insn =3D new_prog->insnsi;
>> @@ -227,8 +240,15 @@ static void adjust_insn_aux_data(struct bpf_verifie=
r_env *env,
>>  	 */
>>  	data[off].zext_dst =3D bpf_insn_def32(new_prog, insn + off + cnt - 1) =
>=3D 0;
>>
>> -	if (cnt =3D=3D 1)
>> +	if (cnt =3D=3D 1) {
>> +		/*
>> +		 * A non-memory accessing insn could have been replaced by a
>> +		 * memory accessing insn, systematically mark it for non-stack
>> +		 * access
>> +		 */
>> +		data[off].non_stack_access =3D is_mem_insn(insn + off);
>>  		return;
>> +	}
>>  	prog_len =3D new_prog->len;
>>  	env->insn_aux_data_len =3D prog_len;
>>
>> @@ -239,8 +259,25 @@ static void adjust_insn_aux_data(struct bpf_verifie=
r_env *env,
>>  		/* Expand insni[off]'s seen count to the patched range. */
>>  		data[i].seen =3D old_seen;
>>  		data[i].zext_dst =3D bpf_insn_def32(new_prog, insn + i) >=3D 0;
>> +		if (!memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
>> +			data[i].non_stack_access =3D
>> +				data[off + cnt - 1].non_stack_access;
>> +			data[off + cnt - 1].non_stack_access =3D false;
>> +		} else if (is_mem_insn(insn + i)) {
>> +			data[i].non_stack_access =3D true;
>> +		}
>>  	}
>>
>> +	/*
>> +	 * Last slot instruction could be a newly generated
>> +	 * BPF_ST/BPF_LDX/BPF_STX, systematically mark it for non-stack access
>> +	 * if it is not the original instruction, otherwise keep the
>> +	 * original marking
>> +	 */
>> +	if (is_mem_insn(insn + off + cnt - 1) &&
>> +	    memcmp(insn + off + cnt - 1, original_insn, sizeof(struct bpf_insn=
)))
>> +		data[off + cnt - 1].non_stack_access =3D true;
>
> The 'inherit the original marking' logic is driven purely by memcmp() of
> the raw instruction bytes against original_insn, which makes the result
> depend on how many copies of an identical encoding a patch buffer happens
> to contain. A subsystem pattern flags this as potentially concerning:
>
> If a patch buffer legitimately contains the original instruction twice (o=
r
> contains a newly generated instruction that happens to encode identically
> to the original, which is easy for a repeated BPF_LDX_MEM/BPF_STX_MEM wit=
h
> the same regs/offset/size), the first match consumes the marking and
> clears data[off + cnt - 1].non_stack_access. Every later identical copy
> falls into the else if (is_mem_insn()) arm and is set to true, but the
> memcmp arm is actually taken again for those slots and now copies an
> already-cleared value, silently under-marking a real non-stack access.

I am not sure to understand how multiple consecutive BPF_LDX/BPF_STX
could confuse the patching logic, as each individual instruction will
have its own patch.
>
> Conversely, a genuinely new instruction that coincidentally matches
> original_insn byte-for-byte is exempted from the 'systematically mark new
> memory insns' rule by the trailing memcmp.
>
> Neither case is reachable via a patch site in this tree (all current
> multi-instruction patches place the original instruction exactly once,
> either first or last), so this is latent fragility rather than an
> observable bug today.

I could actually be somewhere in the middle of the newly generated patch
as well, as observed in the previous revisions.

> Should the identity of an instruction be tracked by position instead of b=
y
> content comparison, since the patch sites all know where they put the
> original?

And so no, all the patch sites do no systematically know where the
original instruction is, sometimes the concept of "original instruction"
even becomes irrelevant, depending on the inserted patch. I've tried
this "tracking by position" in previous revisions, and it has proved to
be way too invasive, imprecise, and error-prone. So this memcmp may
indeed not be bulletproof, but that's a best effort. And again, the
"risk" of missing this stack marking is about inserting an undesired
stack check: this is just a slight overhead (which may be negligeable
compared to the whole kasan instrumentation overhead), not a potential
crash.

> [ ... ]
>
> Verifier-generated instructions that provably access the program stack ar=
e
> marked as non-stack accesses, which is precisely the case the feature
> exists to exclude, and the over-marking is systematic rather than
> incidental. A subsystem pattern flags this as potentially concerning:
>
> Concrete reachable instances:
>
> (1) The ARG_PTR_TO_CTX save inserted by do_misc_fixups():
>
> kernel/bpf/fixups.c:do_misc_fixups() {
> 	insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
> 				      -subprogs[0].stack_depth);
>
> This is a frame-pointer-relative store, and since it is not the original
> instruction it is marked non_stack_access =3D true by the loop above.
>
> (2) The matching frame-pointer load emitted by gen_epilogue callbacks,
> for example:
>
> net/sched/bpf_qdisc.c:bpf_qdisc_gen_epilogue() {
> 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off)
>
> This gets the same treatment when the epilogue is patched in, so every
> struct_ops qdisc reset/destroy program is affected.
>
> (3) bpf_jit_blind_constants() in kernel/bpf/core.c rewrites a BPF_ST |
> BPF_MEM store into {MOV AX, XOR AX, BPF_STX_MEM(...)}, so with
> bpf_jit_harden enabled every blinded stack store loses its stack-only
> marking.
>
> The commit message acknowledges over-instrumentation of 'a few memory
> accessing instructions' as an accepted trade-off, but these cases are
> trivially detectable (dst_reg/src_reg =3D=3D BPF_REG_10) and, for the
> KASAN-in-JIT consumer added later in the series, they mean pointless
> instrumentation on the hottest prologue/epilogue accesses.
>
> Would filtering on BPF_REG_FP in is_mem_insn() or adjust_insn_aux_data()
> remove this class of false positives?

I can possibly skip kasan instrumentation when dst_reg =3D=3D BPF_REG_FP (o=
r
src_reg, if LDX) directly in JIT compiler, similarly to what I have
proposed for BPF_REG_PARAMS in the review on patch 4/8.

>> @@ -306,6 +343,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_veri=
fier_env *env, u32 off,
>>  {
>>  	struct bpf_prog *new_prog;
>>  	struct bpf_insn_aux_data *new_data =3D NULL;
>> +	struct bpf_insn original_insn;
>>
>>  	if (len > 1) {
>>  		new_data =3D vrealloc(env->insn_aux_data,
>> @@ -318,6 +356,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_veri=
fier_env *env, u32 off,
>>  		env->insn_aux_data =3D new_data;
>>  	}
>>
>> +	memcpy(&original_insn, env->prog->insnsi + off, sizeof(struct bpf_insn=
));
>>  	new_prog =3D bpf_patch_insn_single(env->prog, off, patch, len);
>>  	if (IS_ERR(new_prog)) {
>>  		if (PTR_ERR(new_prog) =3D=3D -ERANGE)
>> @@ -326,7 +365,7 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_veri=
fier_env *env, u32 off,
>>  				env->insn_aux_data[off].orig_idx);
>>  		return NULL;
>>  	}
>> -	adjust_insn_aux_data(env, new_prog, off, len);
>> +	adjust_insn_aux_data(env, new_prog, off, len, &original_insn);
>>  	adjust_subprog_starts(env, off, len);
>>  	adjust_insn_arrays(env, off, len);
>>  	adjust_poke_descs(new_prog, off, len);
>
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e036ae20bf6b9..364332eb41859 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3272,6 +3272,11 @@ static void mark_indirect_target(struct bpf_verif=
ier_env *env, int idx)
>>  	env->insn_aux_data[idx].indirect_target =3D true;
>>  }
>>
>> +static void mark_non_stack_access(struct bpf_verifier_env *env, int idx=
)
>> +{
>> +	env->insn_aux_data[idx].non_stack_access =3D true;
>> +}
>> +
>
> [ ... ]
>
>> @@ -6416,6 +6421,7 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, struct b
>>  			    int value_regno, bool strict_alignment_once, bool is_ldsx)
>>  {
>>  	struct bpf_reg_state *regs =3D cur_regs(env);
>> +	enum bpf_reg_type ptr_type =3D reg->type;
>>  	int size, err =3D 0;
>>
>>  	size =3D bpf_size_to_bytes(bpf_size);
>
> [ ... ]
>
>> @@ -6654,6 +6660,10 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
>>  				clear_scalar_id(&regs[value_regno]);
>>  		}
>>  	}
>> +
>> +	if (!err && ptr_type !=3D PTR_TO_STACK)
>> +		mark_non_stack_access(env, insn_idx);
>> +
>>  	return err;
>>  }
>
> Does the unconditional marking at the tail of check_mem_access() handle
> callers that are not load/store instructions?
>
> check_mem_access() is called with the call instruction's index from
> process_dynptr_func(), process_iter_arg(), check_helper_call(), and
> process_irq_flag(), where it is used to validate a helper/kfunc argument
> pointer rather than an actual BPF memory instruction.
>
> Because those argument pointers are typically PTR_TO_MAP_VALUE, PTR_TO_ME=
M,
> PTR_TO_BTF_ID etc. (i.e. !=3D PTR_TO_STACK), the aux entry of the call
> instruction is marked. The flag then no longer means 'this load/store
> instruction may touch non-stack memory' for those slots; it means nothing=
,
> since a call performs no direct memory access.
>
> Consumers that only look at load/store opcodes are unaffected, but the
> marking is semantically wrong and, combined with the BPF_ST_NOSPEC issue
> above, means non_stack_access can be true for aux entries whose
> instruction is not a memory access.
>
> Should the marking be gated on the instruction class actually being
> BPF_LDX/BPF_STX/BPF_ST, or should the mark be done by the load/store
> callers rather than inside check_mem_access()?

Hmmm, I missed this specificity. And I guess is_mem_insn could be useful
here as well, then.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

