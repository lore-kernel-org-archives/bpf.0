Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CBC33A717;
	Mon, 18 May 2026 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101004; cv=none; b=sMNln+AUg/0XAtisiVapoNns8m6WCEvT/6oc1DjpRvggieoVV+WjPu7slLrbjxrx+0pYiRymatVkUkaMrvRo1hN3bjXDTuE/xAlI4KWd6ZC8rL0q9A9rs4TI9TBr+OzQ0dVTpNsC0mcQbjCCA4hqO7UWlC8c+RBkx937c5QyZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101004; c=relaxed/simple;
	bh=2NhjxYRBxcXUSncpFcRjF45CLK7nNKc9Zu1f7G+ZwBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABArk7qZWSsr7s9IS2CxPq4VywK+8l7LK3GFQfQlyzKssLVDWmw6HE6Gj6cNz9rFAA4NSe0FZtNI2PP+oCEiuyOh2U0nkE4YCrGP1PpW86JlMfPq7vIjXwFD25eY+hiAdF2UgNr+xy1PvwvmmkhTPjYCabFl5aTo0MfsVSxz95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vXxyJs8+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vXxyJs8+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dJ5XIKQl59J8DrbBzzXCcVwZkYeS3cJ80gBNWoPVePY=; b=vXxyJs8+DFrwpc7bNWz52hMBvN
	A3v1MEdSyllEv1ta1eFYrx7xA8ApRzKGSgXx2qc6PnThwofWu7N996hCUXYl1xWo3IEHwD8H/bnWe
	i/pkdqgFIyIfbb7VKreo4lq8jcNqMelXKq2ih50AIDwIH2fyBH00HAjWMo4QjYx9ILUOmjK41bXxL
	2a4vuYr+MrBr3xCrIjMjrEfDjHU4jwlbWBvGf+l2JrErDYfnhM03VegmHbC49+r7+7e6CAIoMGwob
	W2Ey/MfdsHXqXqzyb2rvcrKdD1fsnt1KULnHqiARsdsne6ap0NUyaErrwTLRaMF/JoiWd2boZBxPl
	47cvTgIQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOvRE-00000004g5e-29kT;
	Mon, 18 May 2026 10:43:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEB973007A4; Mon, 18 May 2026 12:43:06 +0200 (CEST)
Date: Mon, 18 May 2026 12:43:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
Message-ID: <20260518104306.GU3102624@noisy.programming.kicks-ass.net>
References: <20260514135342.22130-1-jolsa@kernel.org>
 <20260514135342.22130-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514135342.22130-2-jolsa@kernel.org>


You seem to have forgotten to Cc LKML and x86 :-(

On Thu, May 14, 2026 at 03:53:36PM +0200, Jiri Olsa wrote:

> @@ -1017,17 +1030,32 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  			 unsigned long vaddr, unsigned long tramp)
>  {
> -	u8 call[5];
> +	u8 insn[OPT_INSN_SIZE], *call = &insn[LEA_INSN_SIZE];
>  
> -	__text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
> +	/*
> +	 * We have nop10 instruction (with first byte overwritten to int3),
> +	 * changing it to:
> +	 *   lea -0x80(%rsp), %rsp
> +	 *   call tramp
> +	 */
> +	memcpy(insn, lea_rsp, LEA_INSN_SIZE);
> +	__text_gen_insn(call, CALL_INSN_OPCODE,
> +			(const void *) (vaddr + LEA_INSN_SIZE),
>  			(const void *) tramp, CALL_INSN_SIZE);
> -	return int3_update(auprobe, vma, vaddr, call, true /* optimize */);
> +	return int3_update(auprobe, vma, vaddr, insn, OPT_INSN_SIZE, true /* optimize */);
>  }
>  
>  static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  			   unsigned long vaddr)
>  {
> -	return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* optimize */);
> +	/*
> +	 * We have optimized nop10 (lea, call), changing it to 'jmp rel8' to
> +	 * end of the 10-byte slot instead of restoring the original nop10,
> +	 * because we could have thread already inside lea instruction.

Inaccurate, RIP could be on CALL, not inside LEA. Writing NOP10 would
make it inside NOP10 though, and that would cause havoc IF you use the
normal NOP10.

Thing is, the encoding of NOP{8,9,10} would actually allow you to
preserve the CALL instruction :-)

That is, observe:

       PF1   PF2   ESC   NOPL  MOD   SIB   DISP32

NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x78, 0x56, 0x34, 0x12 -- cs nopw 0x12345678(%rax,%rbp,8)

Specifically the CALL opcode sits in the SIB byte and decodes like:

  e8 := 11 101 000

  scale = 11  (2^3 = 8)
  index = 101 BP
  base  = 000 AX

And the displacement is just that, a displacement.

So you *could* in fact, write back _A_ NOP10, just not the standard
NOP10.

> +	 */
> +	u8 jmp[OPT_INSN_SIZE] = { JMP8_INSN_OPCODE, OPT_JMP8_OFFSET };
> +
> +	return int3_update(auprobe, vma, vaddr, jmp, JMP8_INSN_SIZE, false /* optimize */);
>  }

Changelog wants significant update to explain this scheme.

So we have:

  NOP10 -+-> LEA -0x80(%rsp), %rsp, CALL foo -> JMP.d8 +8
         |                                          |
         `------------------------------------------'

And you want to belabour the point of how you ensure re-writing the CALL
instruction isn't a problem (because I'm not convinced).

Note that the above results in:

initial:
0: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)

optimize-int3:
1: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- int3
optimize-tail:
2: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
optimize-finish:
3: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- lea -0x80(%rsp),%rsp; call 0x78563412

unoptimize-int3:
4: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
unoptimize-tail:
5: 0xcc, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
unoptimize-finish:
6: 0xeb, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- jmp.d8 +8; call 0x78563412

optimize-int3:
7: 0xcc, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
optimize-tail:
8: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; call 0x12345678
optimize-finish:
9: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; call 0x12345678

Note that from step 7 to step 8, you re-write the CALL instruction
without going through INT3. This means it is entirely possible for a
concurrent execution to observe a composite instruction.

This is NOT sound!

However, I think it can be salvaged, if instead of only writing INT3 at
+0, you also write INT3 at +5. The sequence then becomes:

initial:
0: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)

optimize-int3:
1: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xcc, 0x00, 0x00, 0x00, 0x00 -- int3; int3
optimize-tail(s):
2: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xcc, 0x12, 0x34, 0x56, 0x78 -- int3; int3
optimize-finish-1:
3: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
optimize-finish-2:
3: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- lea -0x80(%rsp),%rsp; call 0x78563412

unoptimize-int3:
4: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
unoptimize-tail:
5: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
unoptimize-finish:
6: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x12, 0x34, 0x56, 0x78 -- cs nopw 0x78563412(%rax,%rbp,8); call 0x78563412

optimize-int3:
7: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xcc, 0x12, 0x34, 0x56, 0x78 -- int3; int3
optimize-tail(s):
8: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xcc, 0x78, 0x56, 0x34, 0x12 -- int3; int3
optimize-finish-1:
9: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; call 0x12345678
optimize-finish-2:
9: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- lea -0x80(%rsp),%rsp; call 0x12345678

> @@ -1095,14 +1125,25 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		  unsigned long vaddr)
>  {
>  	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
> -		int ret = is_optimized(vma->vm_mm, vaddr);
> -		if (ret < 0)
> +		uprobe_opcode_t insn[OPT_INSN_SIZE];
> +		int ret;
> +
> +		ret = copy_from_vaddr(vma->vm_mm, vaddr, &insn, OPT_INSN_SIZE);
> +		if (ret)
>  			return ret;
> -		if (ret) {
> +		if (__is_optimized((uprobe_opcode_t *)&insn, vaddr)) {
>  			ret = swbp_unoptimize(auprobe, vma, vaddr);
>  			WARN_ON_ONCE(ret);
>  			return ret;
>  		}
> +		/*
> +		 * We can have re-attached probe on top of jmp8 instruction,
> +		 * which did not get optimized. We need to restore the jmp8
> +		 * instruction, instead of the original instruction (nop10).
> +		 */
> +		if (is_swbp_insn(&insn[0]) && insn[1] == OPT_JMP8_OFFSET)
> +			return uprobe_write_opcode(auprobe, vma, vaddr, JMP8_INSN_OPCODE,
> +						   false /* is_register */);

Coding style wants { } on any multi-line statement, even if its only one
statement.

>  	}
>  	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
>  				   false /* is_register */);
