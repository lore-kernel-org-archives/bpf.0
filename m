Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD72320A00
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061780; cv=none; b=M66+wZml5er2I2rTOrjl4HZ85MWVUICD9ikEw0WS5UZ+O/qF1tgVaTgrfGziYmu7nzf7rndpg0y3taymEGRPQsTRdScUTP1WdKx2ok6711+4/tv/qSaoOfJM7ghII7WLyP4uIo6yDkAu1k5e6QoRFHrPH8lsSkZ91HUeVLewQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061780; c=relaxed/simple;
	bh=avjedhz6tkBLvlvxpSR3BxPacf3+mELG40N9gZ1G09Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glBKMvx4qS8rCeXsENpZSJRb4OLI2GGyjuzeTPh05b3+ciY9HuUqDX/qhl/g7QRpGi2tc9XzxGc7MVSfCa2k8+6GkOdnyYly9iGQHT4C0FPtdDRiKwuSa4hYu8A1oAMmaorr+QedLP0y4PGRvmqeeQ7b48GqffeiiGZOCMAGQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei/P//Bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei/P//Bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8503D1F00893;
	Fri, 29 May 2026 13:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780061779;
	bh=tkl4sR7vzufgWkjQ1saXN08wf7PWrUa9x52UIeb6DXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ei/P//Bdo7LQH9SHf4hMwHCjs5/09N0sRrmYWFaUJmPLiYB/r2Ox3F+KotJwIopVY
	 tGzsfEs0PMxKRaMp/EK3dSintQMjamBdnhUchtjYb04yBqJQLTbm4XmmqBXQmkfPTP
	 r/1LedetR72P+I+dkeNIOb4J/guQMcE7PWHbS1S7ztVO+Pb+LJ4wgqouHmq/x8mXCu
	 hCpuPY6pCZOotBU90aqu3prcEBG9/XS5fRevVh3Ab41OkqzInJP5R3WMDoFZUtUVPW
	 3bH4I/ph6hpGGZWw5PM0qr3NO7r28ielMUBjIghzKvuYLwwpt8/LXaro+TwHpW0KXG
	 UHJfbSmDJOSEg==
Date: Fri, 29 May 2026 14:36:13 +0100
From: Will Deacon <will@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf-next v2 2/3] bpf, arm64: Add JIT support for stack
 arguments
Message-ID: <ahmWTbYokwcp1Lel@willie-the-truck>
References: <20260427234801.2104511-1-puranjay@kernel.org>
 <20260427234801.2104511-3-puranjay@kernel.org>
 <ahhGbFY_4Dai1NjR@willie-the-truck>
 <CANk7y0j6JecSuJVZg1phn2tSHrcHPDqqmoaDBy1LdnMo-1qsFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk7y0j6JecSuJVZg1phn2tSHrcHPDqqmoaDBy1LdnMo-1qsFg@mail.gmail.com>

On Thu, May 28, 2026 at 03:23:32PM +0100, Puranjay Mohan wrote:
> Thanks for your review.
> These patches have already landed in bpf-next tree as a part of this
> series: https://lore.kernel.org/all/20260513044949.2382019-1-yonghong.song@linux.dev/
> 
> I will take all your feedback and send fixes for all the required changes.

Thanks. My review backlog is huge, but I still try to look at stuff even
after it's been merged.

> > How does that work with kfuncs? I think the PCS means that they will
> > expect to pick the stack arguments starting at [SP+0]. Or are you
> > saying that SP == FP+16 on entry to the callee? It's hard to reconcile
> > that with the ASCII art in build_prologue() because neither "current
> > A64_FP" nor "BPF_FP" point below A64_SP and it's not clear which of them
> > you're referring to when you refer to "FP" on its own.
> 
> At entry to kfunc the arguments are starting at [SP+0] like a normal C
> callee function would expect.
> 
> The line "callee reads them from [FP+16], [FP+24]" is for a BPF callee
> which always emits a frame record.
> So the caller puts the arguments at SP+0, SP+8, .. and then the callee
> creates the frame record in the prologue which means the first
> argument is at FP+16, ....
> This is just an implementation detail about how the JITed BPF callee
> programs can read stack arguments from FP+16, ... easily.

That makes sense, but if you're able to rejig the diagram in
build_prologue() to mirror that then it would really help us to remember
it in future.

> > > @@ -1191,6 +1207,41 @@ static int add_exception_handler(const struct bpf_insn *insn,
> > >       return 0;
> > >  }
> > >
> > > +static const u8 stack_arg_reg[] = { A64_R(5), A64_R(6), A64_R(7) };
> > > +
> > > +#define NR_STACK_ARG_REGS    ARRAY_SIZE(stack_arg_reg)
> > > +
> > > +static void emit_stack_arg_load(u8 dst, s16 bpf_off, struct jit_ctx *ctx)
> > > +{
> > > +     int idx = bpf_off / sizeof(u64) - 1;
> > > +
> > > +     if (idx < NR_STACK_ARG_REGS)
> > > +             emit(A64_MOV(1, dst, stack_arg_reg[idx]), ctx);
> > > +     else
> > > +             emit(A64_LDR64I(dst, A64_FP, (idx - NR_STACK_ARG_REGS) * sizeof(u64) + 16), ctx);
> > > +}
> >
> > Is it worth asserting that bpf_off >= 8 here or can we rely on that? I
> > struggled to find any details about how bpf passes arguments on the
> > stack (beyond what you describe in the commit message) and grepping for
> > BPF_REG_PARAMS didn't help either.
> 
> This and other patches in this set has more information about this:
> https://lore.kernel.org/all/20260513045015.2385013-1-yonghong.song@linux.dev/

Thanks, that matches what I'd managed to figure out.

Will
