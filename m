Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0038F259
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776522275; cv=none; b=iKYeCD9x8ZPRgXenP0HfDBVY/KPqU/aokZ3U5Yh59MZ7GrOccHsG/n/t4f0rQbRNRnMc5c/NJc6TSKwT6HTckObX1NjEZTIRQAKLuDcRPTQegv/z8ECIWDgXTWvVmZeaKU+lmz2LyXYbknWciEMrZANMjeswQMJ5NBiIgUMEjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776522275; c=relaxed/simple;
	bh=WRf9TN9KVck4Xj/gzfVMHtyGPisG/Ew3Ab4dsrQfJEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vDPrOYXAIB24NmCdgdu39oHHHWvOQafGlzzY0ZfkKUNoIve6HMgFzrregpSipKFRJR+0zyI+qOy8eRdnomPBOoLAiQc72qa9K1sb946DKBYNf1J2P6QIiHklUrRIElvwrGHz92UBtJwgGL7EZM4GWopyZ06MTvQk2k2b8Ku42zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d70vRW9W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d70vRW9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4507BC19424;
	Sat, 18 Apr 2026 14:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776522275;
	bh=WRf9TN9KVck4Xj/gzfVMHtyGPisG/Ew3Ab4dsrQfJEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d70vRW9WobqAbhhmUXdp64hKJ2j6ctMLwsM1JNVbR2iVwlmfth+ptFFW0PdeV8m5z
	 4gZtip5nbY053xxa4weHrF3AWbskP39HCI9pQjS+giXZMB4a18oVwN4UpOQRyWeu0J
	 kri2u91T6Y3lSo68XGfQRl4hOp5xKd09NhdxWgj3gHMbQ0tY4+ecJ9neiZ5fmFOgVj
	 lGYXOeYVEF8nxTOBIqyldGoocSDTfQv9oVbF/A1pEzQA+Ula7pxxse0ZVAzMdnvo6k
	 tO7oA3riWCPoKoUf/AcfHtJh7vIeaFzr/N73pG3giCfRBPUSAEM8CcUbj3l4cxQV9G
	 xGgAqtw0vioJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 2/6] bpf: add bpf_get_cpu_time_counter
 kfunc
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418131614.1501848-3-puranjay@kernel.org>
References: <20260418131614.1501848-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 14:24:34 +0000
Message-Id: <20260418142435.4507BC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Type confusion in `bpf_jit_inlines_kfunc_call` breaks fastcall opt=
imization and hides a TOCTOU register corruption vulnerability.
- [High] The `bpf_get_cpu_time_counter()` kfunc returns inconsistent physic=
al units (CPU cycles vs. nanoseconds) depending on JIT execution.
- [Medium] Missing memory barrier for `RDTSC` allows speculative out-of-ord=
er execution on certain CPUs.
--

commit e2ed941037816a39f712a14ccb3383436319583d
Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>

bpf: add bpf_get_cpu_time_counter kfunc

This commit adds a bpf_get_cpu_time_counter kfunc to return an
ARCH-specific timecounter, bypassing the usual ktime_get_ns() overhead.
It implements an inlined x86_64 JIT version using RDTSC, and falls back
to ktime_get_raw_fast_ns() in C.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ea9e707e8abff..7cda5589107bf 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -2445,6 +2446,40 @@ st:			if (is_imm8(insn->off))
> =20
>  			/* call */
>  		case BPF_JMP | BPF_CALL: {
> +			u8 *ip =3D image + addrs[i - 1];
> +
> +			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> +			    imm32 =3D=3D BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
> +			    bpf_jit_inlines_kfunc_call(imm32)) {
> +				/* The default implementation of this kfunc uses
> +				 * ktime_get_raw_ns() which effectively is implemented as
> +				 * `(u64)rdtsc_ordered() & S64_MAX`. For JIT We skip

Does this JIT implementation return inconsistent time units compared to the=
 C
fallback?

The inline RDTSC emits hardware CPU cycles, but the fallback
bpf_get_cpu_time_counter() calls ktime_get_raw_fast_ns(), which returns
nanoseconds. If a BPF program calculates a delta using the fallback path and
later converts it, won't the nanosecond value be multiplied again, resulting
in incorrect metrics?

[ ... ]

> +				emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
> +				if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
> +					EMIT_LFENCE();
> +				EMIT2(0x0F, 0x31);

The kernel's standard rdtsc_ordered() implementation ensures serialization =
by
checking both X86_FEATURE_LFENCE_RDTSC and X86_FEATURE_MFENCE_RDTSC.

Does this code need to check for MFENCE as well? On older AMD CPUs that rely
on MFENCE, omitting it could result in out-of-order execution across the
measured code block.

[ ... ]

> @@ -4081,3 +4116,13 @@ bool bpf_jit_supports_fsession(void)
>  {
>  	return true;
>  }
> +
> +/* x86-64 JIT can inline kfunc */
> +bool bpf_jit_inlines_kfunc_call(s32 imm)
> +{
> +	if (imm =3D=3D BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
> +	    cpu_feature_enabled(X86_FEATURE_TSC) &&
> +	    using_native_sched_clock() && sched_clock_stable())
> +		return true;
> +	return false;
> +}

Is it safe to evaluate sched_clock_stable() dynamically for fastcall
optimizations?

If sched_clock_stable() returns true during verification, the verifier
could strip the caller-saved register spills. If the clock later transitions
to false before JIT compilation, the JIT will emit a standard C call
instead of inlining, which could silently clobber BPF registers R1-R5.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f7..b8d26e1bff481 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17035,7 +17035,9 @@ bool bpf_get_call_summary(struct bpf_verifier_env=
 *env, struct bpf_insn *call,
>  			/* error would be reported later */
>  			return false;
>  		cs->num_params =3D btf_type_vlen(meta.func_proto);
> -		cs->fastcall =3D meta.kfunc_flags & KF_FASTCALL;
> +		cs->fastcall =3D (meta.kfunc_flags & KF_FASTCALL) ||
> +			       (meta.btf =3D=3D btf_vmlinux &&
> +				bpf_jit_inlines_kfunc_call(call->imm));
>  		cs->is_void =3D btf_type_is_void(btf_type_by_id(meta.btf, meta.func_pr=
oto->type));
>  		return true;
>  	}

In the verifier, call->imm holds the kfunc's BTF ID, but the x86 JIT
implementation of bpf_jit_inlines_kfunc_call() compares it against
BPF_CALL_IMM(bpf_get_cpu_time_counter), which is a relative memory offset.

Since a BTF ID will never match this memory offset, won't this always
return false during verification, defeating the fastcall optimization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418131614.1501=
848-1-puranjay@kernel.org?part=3D2
