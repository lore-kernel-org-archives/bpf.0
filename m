Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41063E2AAE;
	Thu, 21 May 2026 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370553; cv=none; b=aVnq05is9zd+Vjjpysgjq4O+zEeN+t6EaHSKOldzuT4cr74OItbl9fv2Sd3xgvi+kcZ59lePNydDNs+CJ1d8gcL8k2kLAOzK8UmjQL4Hd5a2zr44Jhr+YGxk+LtiIBJkGfwfhS2OiFhZNpByngzFCuwsG1bJ4bRHcqQ41Mkvw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370553; c=relaxed/simple;
	bh=e0YRWVd85jn/wGqmXtmozJELgTfvjFAJf5MAZPK+NBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeYNt4aYHiwl2d9xx9s+dpYcbpJtKD0v7VLg5Kil0dUxjE6vIPGX/IP05cWMda4g9SK/L2K/ekDV3uMQey20bP3wsdFCNQsw+QPOlI+sVpvlBzLfqEyqC/DE7mfWs0SqT4F1JuNayHNfeMr4fkKhHBovUAE4VWVl9uOYvknxnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e2LidEJI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e2LidEJI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WOsVhtwarq6BCeEd0Mb9AOJmRgZk4rPXE+CxRq/DV3s=; b=e2LidEJIzsOdy6vsJdrfY26voJ
	Oik4vlQbbYv5Enwxw6d/w4r7SBwQnPloe8wSVEUQ+sVV8YQMcOwdYrJaTEfUkRea8FpJCOQ2geamE
	tdy52iPyUR4Ul540qpmkApzdJmzt+rbfD4en8mxaby3tOxppBM38VOPSDLOeVLgK6d3FtGRlsOh4D
	lszQyVoDPFy9ch+CLosxBDEC2X4eVao7h6ER6gTiM+ntbo34AvzwFbgHxtq2ezeR2cRrEjdI3rk54
	L7Jmb+mwc2G4k6TNrMRu1rEJ2QBfkpD9zHX5ALQWHrHBnppcc1Faz/nash2OGnSD6kCbf6WhZatYG
	PliPRQjA==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3Yz-00000008XQl-0NGJ;
	Thu, 21 May 2026 13:35:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 887EC3005E5; Thu, 21 May 2026 15:35:48 +0200 (CEST)
Date: Thu, 21 May 2026 15:35:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 04/12] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <20260521133548.GK3126523@noisy.programming.kicks-ass.net>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-5-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521124411.31133-5-jolsa@kernel.org>

On Thu, May 21, 2026 at 02:44:03PM +0200, Jiri Olsa wrote:
> Andrii reported an issue with optimized uprobes [1] that can clobber
> redzone area with call instruction storing return address on stack
> where user code may keep temporary data without adjusting rsp.
> 
> Fixing this by moving the optimized uprobes on top of 10-bytes nop
> instruction, so we can squeeze another instruction to escape the
> redzone area before doing the call, like:
> 
>   lea -0x80(%rsp), %rsp
>   call tramp
> 
> Note the lea instruction is used to adjust the rsp register without
> changing the flags.
> 
> We use nop10 and following transofrmation to optimized instructions
> above and back as suggested by Peterz [2].
> 
> Optimize path (int3_update_optimize):
> 
>   1) Initial state after set_swbp() installed the uprobe:
>       cc 2e 0f 1f 84 00 00 00 00 00
> 
>      From offset 0 this is INT3 followed by the tail of the original
>      10-byte NOP.
> 
>   2) Trap the call slot before rewriting the NOP tail:
>       cc 2e 0f 1f 84 [cc] 00 00 00 00
> 
>      From offset 0 this traps on the uprobe INT3.  A thread reaching
>      offset 5 traps on the temporary INT3 instead of seeing a partially
>      patched call.
> 
>   3) Rewrite the LEA tail and call displacement, keeping both INT3 bytes:
>       cc [8d 64 24 80] cc [d0 d1 d2 d3]
> 
>      From offset 0 and offset 5 this still traps.  The bytes between
>      them are not executable entry points while both traps are in place.
> 
>   4) Restore the call opcode at offset 5:
>       cc 8d 64 24 80 [e8] d0 d1 d2 d3
> 
>      From offset 0 this still traps.  From offset 5 the instruction is
>      the final CALL to the uprobe trampoline.
> 
>   5) Publish the first LEA byte:
>       [48] 8d 64 24 80 e8 d0 d1 d2 d3
> 
>      From offset 0 this is:
>         lea -0x80(%rsp), %rsp
>         call <uprobe-trampoline>
> 
> Unoptimize path (int3_update_unoptimize):
> 
>   1) Initial optimized state:
>       48 8d 64 24 80 e8 d0 d1 d2 d3
>      Same as 5) above.
> 
>   2) Trap new entries before restoring the NOP bytes:
>       [cc] 8d 64 24 80 e8 d0 d1 d2 d3
> 
>      From offset 0 this traps. A thread that had already executed the
>      LEA can still reach the intact CALL at offset 5.
> 
>   3) Restore bytes 1..4 of the original NOP while keeping byte 0 trapped
>      and byte 5 as CALL.
>       cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> 
>      From offset 0 this still traps. Offset 5 is still the CALL for any
>      thread that was already past the first LEA byte.
> 
>   4) Publish the first byte of the original NOP:
>       [66] 2e 0f 1f 84 e8 d0 d1 d2 d3
> 
>      From offset 0 this is the restored 10-byte NOP; the CALL opcode and
>      displacement are now only NOP operands.  Offset 5 still decodes as
>      CALL for a thread that was already there.
> 
> Note as explained in [2] we need to use following nop10:
>        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
> 
> which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> attribute in is_prefix_bad function.
> 
> The optimized uprobe performance stays the same:
> 
>         uprobe-nop     :    3.129 ± 0.013M/s
>         uprobe-push    :    3.045 ± 0.006M/s
>         uprobe-ret     :    1.095 ± 0.004M/s
>   -->   uprobe-nop10   :    7.170 ± 0.020M/s
>         uretprobe-nop  :    2.143 ± 0.021M/s
>         uretprobe-push :    2.090 ± 0.000M/s
>         uretprobe-ret  :    0.942 ± 0.000M/s
>   -->   uretprobe-nop10:    3.381 ± 0.003M/s
>         usdt-nop       :    3.245 ± 0.004M/s
>   -->   usdt-nop10     :    7.256 ± 0.023M/s
> 

> @@ -893,48 +918,134 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
>  }
>  
>  /*
> + * Modify the optimized instruction by using INT3 breakpoints on SMP.
>   * We completely avoid using stop_machine() here, and achieve the
>   * synchronization using INT3 breakpoints and SMP cross-calls.
>   * (borrowed comment from smp_text_poke_batch_finish)
>   *
> + * The way it is done for optimization (int3_update_optimize):
> + *   1) Start with the uprobe INT3 trap already installed
> + *   2) Add an INT3 trap to the call slot
> + *   3) Update everything but the first byte and the call opcode
> + *   4) Replace the call slot INT3 by the call opcode
> + *   5) Replace the first INT3 by the first byte of the LEA instruction
> + *
> + * The way it is done for unoptimization (int3_update_unoptimize):
> + *   1) Start with the optimized uprobe lea/call instructions
> + *   2) Add an INT3 trap to the address that will be patched
> + *   3) Restore the NOP bytes before the call opcode
> + *   4) Replace the first INT3 by the first byte of the NOP instruction
> + *
> + * Note that unoptimization deliberately keeps the call opcode and displacement
> + * in bytes 5..9. Those bytes become operands of the restored 10-byte NOP.
>   */

One important thing to note is that (as earlier noted by Andrii) the
CALL address is never changed. A new optimization pass will not change
the CALL instruction again.

If you noted this anywhere, I failed to find it. This is crucially
important for the correctness of the scheme and should not be emitted.

That is, please add something like:

  "Since there is only a single uprobe-trampoline, the CALL instruction
  will not be changed across unoptimization/optimization cycles.
  Therefore, any task that is preempted at the CALL instruction is
  guaranteed to observe that CALL and not anything else."


