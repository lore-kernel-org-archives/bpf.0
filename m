Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC731714B
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270470; cv=none; b=ekwhdpwJr6+nt4B5e22aIwk8N0HUdtYPZx7fJQTHAz8mOSxL1zU8HAnp5y5XIX1FGlNGKs2DQQIZHL6TfRPWaLDi4G85UGQrnggUMqE3qKot0HKER8l9apNruRN0bLFRYNNtPL71bfLK4/sI6eW4tafvwRlldL+RvDv8Vd5B5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270470; c=relaxed/simple;
	bh=VUm1O/b+QF1Wo67L7R87WmtkTVSdiEE8t+wYjdbfd4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuGPNB/F8Gq8Grjwf3+y1K2+2cD3YRtMA2yD5CV8NcqNujxx3LYoFi34T2RyCoXwZuhxNrG+4fTMXERMjEYla1j5lsTY4PohU4dzn1ZOp7/CkrYdNKhjFQRpw2azreWrmSfRscT0+oE/Ki21gvASmgi22kH+GvqKRphUHElGReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZFH5xRO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZFH5xRO"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso755534766b.1
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270467; x=1788875267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75dTyssho5yOZ2Ol9cFz07ZdqIck/7W4LH9NbnU734I=;
        b=XZFH5xROuPxx1OzAxnOehvfX7uWa4YlkjhpM56EabbwSlbBR0eo+53knHSX2EtKCxI
         SFluRnyJk4CUFBzOia1RqDHoFlfrt0B93CIxdoRqoywjaVwJuaRDE8Q5fuICYPRmcFUe
         tAL3JvCsCCdj33IaNAyZu4LkCAH7y0H9CCSgrM84T8/lC5m+CW4WPme8hN7xjGfVsJB4
         wfgOe0RK39otWoOOKuxKUAvm7AEiwO39lIePuNxb0JmWFA9/1IXSTEBNF3wK0ch+o9Q7
         LxVbzB+PsENmzqGuDc/ujXG0UIqYN0uTnSs6iwS4CI2TDNkyT/ReNGucHMcnQEDrdv8a
         P62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270467; x=1788875267;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75dTyssho5yOZ2Ol9cFz07ZdqIck/7W4LH9NbnU734I=;
        b=s37K8HRDbGUzHYC3rHf+t6ewJEmhQhxv/mN0GBPdqclX9tm8HrgMv1oE60C2a3bFxo
         w9w7KlItc0it367KuZjA+Kvt2Ak0lOwUo3qXyJ38KpZVH6Dulo2UxkZUbA5t+0izj9Pe
         cyDEfS/Tr/p/1XPDeLzXZC84bKXmHtRW7Z+2qTnufvzLzQyO6S69BuPTAfWyTuaLNd9Q
         zhp/rTAZ3fZznvdWv4GGF5iTSn2o6l2BU+Zu/8EOgUglJ9z3IR6pgsm9tz/hpAGKtxxS
         siwlK5zMKX2GPfOJJioeNo/hspeUP7NWBgsk9zN41P0p9bKsi11lwDleMJllVnVDmdhi
         KCUw==
X-Forwarded-Encrypted: i=1; AHgh+RpxnbMZKjOaVBlg/mHwuD1uaXaOc/0AjEIhxzMz0Yg461vdfNhwghkbu1Q/aI/FTFx4Iec=@vger.kernel.org
X-Gm-Message-State: AFuF++kymrsNBE/3fF7ZskuX+xuFuke0yCYRBR4VM6x2SFxAF5HZC7fZ
	UNI/fxM2OTJoSUzQwb7tsSdbUEMGux+DxKuYs9r//xe+lYJtJrnLSjirG6blPg==
X-Gm-Gg: AR+sD13TJlWBWTcTVHj14hPhq8PdFU97hkry3pibUziJp2XcsjIl6vNaFVoOqI3AHdg
	78XfRC7FxTYB9W23J56Y3BxfAiUrPAcOevakpkWwis0DVYx8ERX3GtxsEfwjz2KJ5MYf/d+lHlz
	rGW1lak+EFnpoTi/VAjqEE5vr3D8x+RGJM3t+bTwglDeNunEkdIN72J5L8OdvekleT2qvlNOxkL
	yfJNBzB/GZs+sPW/JaG0MM4cbFSnEXtN9LEOr/qHQWmDiEzS1RSkCPsesZ0a95HUeTKCK95c2oO
	ydfg4Shqxo5VujTbhBYSJoCry6ADJjLxc16adIf3mIchnIdtTCdCw7+J+ABQ0eY6i159YxNZZ22
	8LXS3K0kxAxcEyZ4wajN/JuZnJDvxagVhXxPu3XwE8v1mcuUD3vK9tWzcdkw1lM/H0pPtes5bUi
	XcF5zPe8zVUBTv6pDelVMPI228bkJ1ZLP6UxpePh/i4016VGJxx53/EEYwKpQbKW9AvVxZ
X-Received: by 2002:a17:906:3c51:b0:c25:58e:83ff with SMTP id a640c23a62f3a-c25b3c318bfmr444354266b.10.1788270466513;
        Tue, 01 Sep 2026 06:47:46 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1fc58fsm599604966b.50.2026.09.01.06.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:47:46 -0700 (PDT)
Date: Tue, 1 Sep 2026 13:58:24 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: sidchintamaneni@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, puranjay@kernel.org,
	rlmenge@gmail.com, hargar@microsoft.com, apais@microsoft.com,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test terminal gotox
 instructions
Message-ID: <apbaAHkjpsgJMtk0@mail.gmail.com>
References: <20260831223314.89787-2-sidchintamaneni@gmail.com>
 <882f92965fedba779d677b2b8600682bb0ea33673121e42b81a430d3a3636745@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882f92965fedba779d677b2b8600682bb0ea33673121e42b81a430d3a3636745@mail.kernel.org>

On 26/08/31 11:26PM, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > index 5b18c9a27717b..89067ab7baaa4 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > @@ -47,6 +47,67 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
> >  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
> >  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
> >
> > +SEC("socket")
> > +__success __retval(0)
> > +__naked void jump_table_terminal_gotox(void)
> > +{
> > +	asm volatile ("						\
> > +	.pushsection .jumptables,\"\",@progbits;		\
> > +jt0_%=:							\
> > +	.quad ret0_%= - socket;					\
> > +	.size jt0_%=, 8;					\
> > +	.global jt0_%=;						\
> > +	.popsection;						\
> > +								\
> > +	r0 = jt0_%= ll;						\
> > +	r0 = *(u64 *)(r0 + 0);					\
> > +	goto end_%=;						\
> > +ret0_%=:							\
> > +	r0 = 0;							\
> > +	exit;							\
> > +end_%=:							\
> > +	.8byte %[gotox_r0];					\
> > +"	:
> > +	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,
> > +					    BPF_REG_0, 0, 0, 0))
> > +	: __clobber_all);
> > +}
> > +
> > +static __naked __noinline __used
> > +void terminal_gotox_subprog(void)
> > +{
> > +	asm volatile ("						\
> > +	.pushsection .jumptables,\"\",@progbits;		\
> > +jt0_%=:							\
> > +	.quad ret0_%= - .text;					\
> > +	.size jt0_%=, 8;					\
> > +	.global jt0_%=;						\
> > +	.popsection;						\
> > +								\
> > +	r0 = jt0_%= ll;						\
> > +	r0 = *(u64 *)(r0 + 0);					\
> > +	goto end_%=;						\
> > +ret0_%=:							\
> > +	r0 = 0;							\
> > +	exit;							\
> > +end_%=:							\
> > +	.8byte %[gotox_r0];					\
> > +"	:
> > +	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,
> > +					    BPF_REG_0, 0, 0, 0))
> > +	: __clobber_all);
> > +}
> 
> This isn't a bug, but terminal_gotox_subprog() differs from
> jump_table_terminal_gotox() above only in the jump-table base symbol
> (- .text vs - socket). The file elsewhere factors similar shapes into
> macros (DEFINE_SIMPLE_JUMP_TABLE_PROG, DEFINE_INVALID_SIZE_PROG,
> DEFINE_JUMP_TABLE_USE_REG). Would a small macro parameterised on the
> base read better here?
> 
> Also, since libbpf appends the only called subprogram last, this
> subprogram's gotox ends up as the final instruction of the whole loaded
> program. Would adding a further subprogram after it give coverage of the
> fall-through-into-the-next-subprog case that the relaxed check in
> check_subprogs() guards?

If you add a macro as robot suggested, then the
jump_table_terminal_gotox_subprog() below can call two subprogs
(same, with different names).

Otherwise, looks good to me!

> > +
> > +SEC("socket")
> > +__success __retval(0)
> > +__naked void jump_table_terminal_gotox_subprog(void)
> > +{
> > +	asm volatile ("						\
> > +	call terminal_gotox_subprog;				\
> > +	exit;							\
> > +"	::: __clobber_all);
> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33447655511

