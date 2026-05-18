Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4B48B389
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122358; cv=none; b=c3xCDx6wARldtZNTOCfaaQijySWlAsNMMECQiE7wGlsuafhc+D3q5zt2YBK1OUGiFinsNrvRutnbGnC1xXu69QELN91DPcbm4tQf26so4m7phKxqZZGzKGvNvoiqoH4zJ5q8+g5BvpxwVT5EBErkHTVpjMJh9Zc+6jECyNhnq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122358; c=relaxed/simple;
	bh=wtfm5s0cYEM0IzmHheJlIyC/xbWNf/mBPw/DEtmUof4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDMs55qRyTpC4ru02B31cbDjPTzaL5SmBsv4eF062BP87Ff7+1NxOurIKWLWTqqeSne7Q+/+z2YK3XDPvBnHcKOpPhyrJXMt/4Qp5vJKoQCFWd5m4lOPjbyJiEbUU53ZOdEnKHhfnSGSFC7BSgwcSD1jUB2SyrogtCwacSBnEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzEDG8dW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzEDG8dW"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-459bf19e87bso1495202f8f.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779122354; x=1779727154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDAuz36Ay6h7YMO6HB48q6LTLUi8+4QkMA1nwKPRRj8=;
        b=nzEDG8dWo5EnoyGy02jekBuEQUFH/RkPb+7ygZ1KRVmL2uJ2VrKZo5xuXrL/j0sIrW
         R1YDvEWZ9NV5k++Ab8ooHGbna4CYKU918lVp/ELhCFZIdfEqbM8yuJluiDsq4nDgnCl7
         5EC/9HlU5O1Xsj+f4aim95PrJv5V355DSJ0LaeKjscjl29F2Mc7wN0xaKcLM8cpHwv22
         qDFFLDlEjHIf3XOGLEboE/tda4lrx2vrQOVWkRbsxFFP23muTKnTx0MOdbI10mpjH+Md
         w4hAsEohSeCH1w64u9+gRTImADGYJrrsw1qizN5t/+OTKamxtrWOgLSe/F8zk2gfrVkb
         Y2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122354; x=1779727154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDAuz36Ay6h7YMO6HB48q6LTLUi8+4QkMA1nwKPRRj8=;
        b=ECzSOP9sH145Qqev0xiO4ZN7xMvkke0qxWKMfuCcmWrH3iJraPXD9prHFRjxDHZtK0
         plGRX24eaQb4CJXxYzv4yxt3x5/t9dqGoDAyw42oSLfsum8NfxAKnHxrSfwFsJ0hYvGv
         flGWyHj7TKK3ljBhRiuWQENa0ZWAc4w3AmoArNWUWlJoWkIW05uWhKfnz35mUhLaewcg
         TSlqX8VqHMYXNcdPnxOEcwsHMOzx2ZhG+CPqy321JKl+HrBqa7iD6+lxOd5fXjVgSpn7
         rVTcnq8v8bWwiBkRwzhOOLDaOqciLYolJWjW7TNjs4tbCHpWFovbZsaBezJTN9hV42A3
         qx4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+j+KfCL1m9wMv9Cm1WtjStAB0uwLE80hcnB5RlBEt6+Jq5iv9Uwc5HcsLQy9JTbl+9Yac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4+ahwIO8YUpICfO6pFzW5yG/PuYvjm4DTQetqNFzFq9hckim
	X5/62NoV5t+dYC4zxB/VWzIXPq25xXfWfdsWRo5j0lKx5QCl8tgenj97qemiRK0Y
X-Gm-Gg: Acq92OFCmLh0YGHJpKiHxv478Llp/dBw3EFFG0YHmX2ySFhgC0TmkRLDkc15WS+2gZQ
	DJXPLK289zMxOCRdfVvhaX5IZnJTAMJNXng+mJzQNslwLCUgjyT6aY6ADlqEFcowrAYqFgIeSHw
	C7sJUCUPb1zfBKpfnQDLM2VzGlXIsv6dsv4X6o6GmCsy4+UxVTLQ5H2yCZlYIpl6uQ8+TYLf0uO
	yEbBPRtgGvL7fqChNDfi88tdrU43aeALPF6RgUlTb6H55fqdzqGUf1MB1SZfx/HnuONkyoD1i5A
	hBQ/ExiqstrzGz6Tqkop8YNepLdzDQGKZYSz/lE4LiiZYaAMt0Qe1Kh6GCGtg7KZEVczTH297Lp
	Vevy0sIlko8a5Fmpshjt59pt+3arYW/k+vnZJLIVEIByKgCTyPNuqf19MMfTlOog5Svqsvp8atM
	YDoWFz3OlmRDX/uO2Bh4DTTg==
X-Received: by 2002:a5d:5885:0:b0:44e:902f:e341 with SMTP id ffacd0b85a97d-45e5c5bfbfcmr27408841f8f.20.1779122354393;
        Mon, 18 May 2026 09:39:14 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed30110sm42240417f8f.13.2026.05.18.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:39:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 May 2026 18:39:12 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
Message-ID: <agtAsCSJbrgJdSAM@krava>
References: <20260514135342.22130-1-jolsa@kernel.org>
 <20260514135342.22130-2-jolsa@kernel.org>
 <20260518104306.GU3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518104306.GU3102624@noisy.programming.kicks-ass.net>

On Mon, May 18, 2026 at 12:43:06PM +0200, Peter Zijlstra wrote:
> 
> You seem to have forgotten to Cc LKML and x86 :-(
> 
> On Thu, May 14, 2026 at 03:53:36PM +0200, Jiri Olsa wrote:
> 
> > @@ -1017,17 +1030,32 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  			 unsigned long vaddr, unsigned long tramp)
> >  {
> > -	u8 call[5];
> > +	u8 insn[OPT_INSN_SIZE], *call = &insn[LEA_INSN_SIZE];
> >  
> > -	__text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
> > +	/*
> > +	 * We have nop10 instruction (with first byte overwritten to int3),
> > +	 * changing it to:
> > +	 *   lea -0x80(%rsp), %rsp
> > +	 *   call tramp
> > +	 */
> > +	memcpy(insn, lea_rsp, LEA_INSN_SIZE);
> > +	__text_gen_insn(call, CALL_INSN_OPCODE,
> > +			(const void *) (vaddr + LEA_INSN_SIZE),
> >  			(const void *) tramp, CALL_INSN_SIZE);
> > -	return int3_update(auprobe, vma, vaddr, call, true /* optimize */);
> > +	return int3_update(auprobe, vma, vaddr, insn, OPT_INSN_SIZE, true /* optimize */);
> >  }
> >  
> >  static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  			   unsigned long vaddr)
> >  {
> > -	return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* optimize */);
> > +	/*
> > +	 * We have optimized nop10 (lea, call), changing it to 'jmp rel8' to
> > +	 * end of the 10-byte slot instead of restoring the original nop10,
> > +	 * because we could have thread already inside lea instruction.
> 
> Inaccurate, RIP could be on CALL, not inside LEA. Writing NOP10 would
> make it inside NOP10 though, and that would cause havoc IF you use the
> normal NOP10.
> 
> Thing is, the encoding of NOP{8,9,10} would actually allow you to
> preserve the CALL instruction :-)
> 
> That is, observe:
> 
>        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> 
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x78, 0x56, 0x34, 0x12 -- cs nopw 0x12345678(%rax,%rbp,8)
> 
> Specifically the CALL opcode sits in the SIB byte and decodes like:
> 
>   e8 := 11 101 000
> 
>   scale = 11  (2^3 = 8)
>   index = 101 BP
>   base  = 000 AX
> 
> And the displacement is just that, a displacement.
> 
> So you *could* in fact, write back _A_ NOP10, just not the standard
> NOP10.
> 
> > +	 */
> > +	u8 jmp[OPT_INSN_SIZE] = { JMP8_INSN_OPCODE, OPT_JMP8_OFFSET };
> > +
> > +	return int3_update(auprobe, vma, vaddr, jmp, JMP8_INSN_SIZE, false /* optimize */);
> >  }
> 
> Changelog wants significant update to explain this scheme.
> 
> So we have:
> 
>   NOP10 -+-> LEA -0x80(%rsp), %rsp, CALL foo -> JMP.d8 +8
>          |                                          |
>          `------------------------------------------'
> 
> And you want to belabour the point of how you ensure re-writing the CALL
> instruction isn't a problem (because I'm not convinced).
> 
> Note that the above results in:
> 
> initial:
> 0: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
> 
> optimize-int3:
> 1: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- int3
> optimize-tail:
> 2: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> optimize-finish:
> 3: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- lea -0x80(%rsp),%rsp; call 0x78563412
> 
> unoptimize-int3:
> 4: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> unoptimize-tail:
> 5: 0xcc, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> unoptimize-finish:
> 6: 0xeb, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- jmp.d8 +8; call 0x78563412
> 
> optimize-int3:
> 7: 0xcc, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> optimize-tail:
> 8: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; call 0x12345678
> optimize-finish:
> 9: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; call 0x12345678
> 
> Note that from step 7 to step 8, you re-write the CALL instruction
> without going through INT3. This means it is entirely possible for a
> concurrent execution to observe a composite instruction.
> 
> This is NOT sound!
> 
> However, I think it can be salvaged, if instead of only writing INT3 at
> +0, you also write INT3 at +5. The sequence then becomes:
> 
> initial:
> 0: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
> 
> optimize-int3:
> 1: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xcc, 0x00, 0x00, 0x00, 0x00 -- int3; int3
> optimize-tail(s):
> 2: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xcc, 0x12, 0x34, 0x56, 0x78 -- int3; int3
> optimize-finish-1:
> 3: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> optimize-finish-2:
> 3: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- lea -0x80(%rsp),%rsp; call 0x78563412
> 
> unoptimize-int3:
> 4: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> unoptimize-tail:
> 5: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> unoptimize-finish:
> 6: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x12, 0x34, 0x56, 0x78 -- cs nopw 0x78563412(%rax,%rbp,8); call 0x78563412
> 
> optimize-int3:
> 7: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xcc, 0x12, 0x34, 0x56, 0x78 -- int3; int3
> optimize-tail(s):
> 8: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xcc, 0x78, 0x56, 0x34, 0x12 -- int3; int3
> optimize-finish-1:
> 9: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; call 0x12345678
> optimize-finish-2:
> 9: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- lea -0x80(%rsp),%rsp; call 0x12345678

sorry I missed this reply.. awesome, I'll check how to do this

> 
> > @@ -1095,14 +1125,25 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  		  unsigned long vaddr)
> >  {
> >  	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
> > -		int ret = is_optimized(vma->vm_mm, vaddr);
> > -		if (ret < 0)
> > +		uprobe_opcode_t insn[OPT_INSN_SIZE];
> > +		int ret;
> > +
> > +		ret = copy_from_vaddr(vma->vm_mm, vaddr, &insn, OPT_INSN_SIZE);
> > +		if (ret)
> >  			return ret;
> > -		if (ret) {
> > +		if (__is_optimized((uprobe_opcode_t *)&insn, vaddr)) {
> >  			ret = swbp_unoptimize(auprobe, vma, vaddr);
> >  			WARN_ON_ONCE(ret);
> >  			return ret;
> >  		}
> > +		/*
> > +		 * We can have re-attached probe on top of jmp8 instruction,
> > +		 * which did not get optimized. We need to restore the jmp8
> > +		 * instruction, instead of the original instruction (nop10).
> > +		 */
> > +		if (is_swbp_insn(&insn[0]) && insn[1] == OPT_JMP8_OFFSET)
> > +			return uprobe_write_opcode(auprobe, vma, vaddr, JMP8_INSN_OPCODE,
> > +						   false /* is_register */);
> 
> Coding style wants { } on any multi-line statement, even if its only one
> statement.

will fix

thanks,
jirka
