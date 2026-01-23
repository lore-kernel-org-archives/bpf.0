Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DA2FCBF0
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160092; cv=none; b=A5gon0NhHzx6pcECLOzJQL8layyO/fV9j5Rn1khtWl/sz0CwUj/GTvH6vKcLEJ9RHvG+RE8Ug0BLdihTiTLQDW7ZIm4KrU2XvdvxRkXa9OmFs99vCGPEvfLoSAlqABzdy5kaumE13XJjhJxEqDgwRF0TEevwUKNPY5wSNPMbtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160092; c=relaxed/simple;
	bh=/qBBaxWhukWs4qJg+J65MwAsyajsVQ45yyS5jCwBNIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szgwidumhRooME3wXFUr4vD7vKSlRl8YPCeY8TwiPc0WZHlMhrBDZUi3D3ChDMd+zRQtS/rM4ckzEDZwcDaaXu9Kc1pCEDHk7fmP6BSDytHas2m2KH1Gt6rMz+p3zfJxNNkiBjVX5NwLXco+mJvDll3WEawzW8lTRpcM3YNCBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jlm/mnyR; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jlm/mnyR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769160079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ie5xJzmkxgG8lABACs468KKiagQngHba9qY5Hp3s314=;
	b=jlm/mnyRCmcsgiGagpUpgQ4MBZmziSqt6uQfpWP8SmNqjWD3De58XH7O8A/zaaOci5pEQE
	25DRGUR5DWUqw/xMMK+bynuy92kLBQ5l9cIXRrqHVS6X2B0+wRBMUgVIV0CSUekzYcDAx9
	635MTGLq1jYF/120nlROHPmByeg7C2c=
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
 Re: [PATCH bpf-next v11 02/12] bpf: use the least significant byte for the
 nr_args in trampoline
Date: Fri, 23 Jan 2026 17:21:06 +0800
Message-ID: <8632406.T7Z3S40VBb@7940hx>
In-Reply-To: <2250332.irdbgypaU6@7940hx>
References:
 <20260123073532.238985-3-dongml2@chinatelecom.cn>
 <d91544bd4b513290bf468386c0261f913b59b761c34405839c424f8eaf8b1d04@mail.kernel.org>
 <2250332.irdbgypaU6@7940hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/23 16:29 Menglong Dong <menglong.dong@linux.dev> write:
> On 2026/1/23 16:07 bot+bpf-ci@kernel.org write:
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 41bbed6418b5..b3f912ad18ba 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > 
> > [ ... ]
> > 
> > > @@ -23779,12 +23781,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > >  			    eatype == BPF_MODIFY_RETURN) {
> > >  				/* Load nr_args from ctx - 8 */
> > >  				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > > -				insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> > > +				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> > > +				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> > 
> > [ ... ]
> > 
> > > -				cnt = 6;
> > > +				cnt = 7;
> > >  			} else {
> > >  				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
> > >  				cnt = 1;
> > >  			}
> > >
> > >  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > 
> > [ ... ]
> > 
> > > 			delta    += cnt - 1;
> > 
> > Note that the bpf_get_func_ret block above correctly updates delta after
> > patching.
> > 
> > > @@ -23808,12 +23811,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > >
> > >  				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
> > >  				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
> > > +				cnt = 1;
> > >  			} else {
> > >  				/* Load nr_args from ctx - 8 */
> > >  				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > > +				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
> > > +				cnt = 2;
> > >  			}
> > >
> > > -			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
> > > +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> > >  			if (!new_prog)
> > >  				return -ENOMEM;
> > >
> > >  			env->prog = prog = new_prog;
> > >  			insn      = new_prog->insnsi + i + delta;
> > >  			goto next_insn;
> > >  		}
> > 
> > Should there be a "delta += cnt - 1;" before assigning env->prog in this
> > bpf_get_func_arg_cnt block? When cnt is 2 (non-RAW_TP path), the program
> > grows by one instruction, but delta is not updated. This could cause
> > subsequent bpf_patch_insn_data() calls to use incorrect offsets.
> > 
> > The bpf_get_func_arg block at the beginning of this patch has:
> > 
> >     delta    += cnt - 1;
> >     env->prog = prog = new_prog;
> > 
> > And the bpf_get_func_ret block similarly has delta updated. But this
> > bpf_get_func_arg_cnt block goes directly to env->prog assignment without
> > updating delta.
> 
> Ah, good point, I think this is a valid problem. The selftests didn't cover
> this case, and I think I'd better to use bpf_get_func_arg() and bpf_get_func_ret()
> in the exit path of fsession to cover it.

Oh, the problem doesn't have much impact. The only impact
is that the verifier will check the "r0 &= 0xFF" instruction redundantly.

I'll see if there is more comment before I send next version.

Thanks!
Menglong Dong

> 
> Will fix it in the next version.
> 
> Thanks!
> Menglong Dong
> 
> > 
> > 
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> > 
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21278745581
> > 
> 
> 
> 
> 
> 
> 




