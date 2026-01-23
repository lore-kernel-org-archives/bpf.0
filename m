Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6D3164D3
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156171; cv=none; b=R4sy6d4GSgaEAqSMjUAdoRiOR+spGk6zIsWrLeZg2gI5jqonJDIBRCH8T2JssoVM/+Ar0Ypy6Nvh3H3U4L2R/xHlvN18T44rnPMeT8Lwe2cJt3tHKg3IftuomrIbnBSCOZagnQAo7sPHRARY9ErsQ6ozWT4Pako7vAlVKI61/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156171; c=relaxed/simple;
	bh=BsTbk9PK/Dho8o57iGK8Ji2OTakuElTTQ+Nej8bohjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0hUazD8mEjHjLPhoZiHjpbG1he8QsaI/1Zy+QDchiSn1cSkEYKmCdkVDWFgNqag4PG4WSU9t9CnyB6iNlFW2NrCK1XJUMI0VEwza7kVs5NFUWYcH5Ch1v6s5nAreJJZ2/VcgNiLtt734wI4KE3xA5IY8QLObA4CIcGrWkVXEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vEr63Vax; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vEr63Vax"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769156166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5/gOBon1dhydrWDZXwZcbC1y+hCYJIaCL2aKChxtag=;
	b=vEr63VaxWe8PUFcQkZqOMUJb88ZZobeFvXZ5re+ha18e8e9XToG54pm+B9mgR7TndTRpnJ
	Z7CVTe8VJw3ADiCjhwMTFmn0grkAqkpjTbh0cwXrBd9nJSv49ToBnt+4fI2m0lDhU4G1WJ
	RifQIWCxdui44PHAXUK/JzfCSAiJUHE=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, andrii@kernel.org, bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v11 04/12] bpf: support fsession for
 bpf_session_is_return
Date: Fri, 23 Jan 2026 16:15:50 +0800
Message-ID: <5071572.31r3eYUQgx@7940hx>
In-Reply-To:
 <ccb153dc349dfbbced71546e26de91c4e8094a0c515c3e2a9336dfa1a2f0a607@mail.kernel.org>
References:
 <20260123073532.238985-5-dongml2@chinatelecom.cn>
 <ccb153dc349dfbbced71546e26de91c4e8094a0c515c3e2a9336dfa1a2f0a607@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/23 16:07 bot+bpf-ci@kernel.org write:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 41228b0add52..29eecd79352e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1229,6 +1229,8 @@ enum {
> >  #endif
> >  };
> >
> > +#define BPF_TRAMP_IS_RETURN_SHIFT	63
> > +
> >  struct bpf_tramp_links {
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 19fd16697262..2ae8f29b854f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23011,6 +23011,19 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
> >  		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> >  		*cnt = 1;
> > +	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
> > +		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
> > +		/*
> > +		 * inline the bpf_session_is_return() for fsession:
> > +		 *   bool bpf_session_is_return(void *ctx)
> > +		 *   {
> > +		 *       return (((u64 *)ctx)[-1] >> BPF_TRAMP_IS_RETURN_SHIFT) & 1;
> > +		 *   }
> > +		 */
> > +		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_IS_RETURN_SHIFT);
> > +		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
> > +		*cnt = 3;
> > +	}
> 
> The inline implementation reads bit 63 of ctx[-1] to check the is_return
> flag. However, looking at the x86 trampoline code in
> arch/x86/net/bpf_jit_comp.c, the trampoline only stores nr_regs in ctx[-1]:
> 
>     emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
>     emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
> 
> The is_return flag (bit 63) is never set by the current trampoline code.
> This means bpf_session_is_return() will always return 0 for fsession
> programs, even when executing at the return point.
> 
> I see this is fixed later in the series by commit ba766b26e776 ("bpf,x86:
> add fsession support for x86_64") which adds:
> 
>     func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
>     if (bpf_fsession_cnt(tlinks))
>         emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
> 
> Should this commit be squashed with the x86 trampoline changes to ensure
> the feature works correctly at each point in the series?

As I said before, this patch implement the common part of the fsession.
and we implement the architecture specific code for x86_64 in the later
patch.

> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21278745581
> 




