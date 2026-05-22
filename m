Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACBB29B77C
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484755; cv=none; b=XvbE/ndxqkM8RMwbS+BdxYimZPtbeUyu49x2B6IgQpAd052ikhac5mRmwFioH79bs4bl29lT3l7BEpyQb2ldhmeCN7JjqQFuFPqdCy6Pjjq4jr2vksq+oXnNAttI2qt7oXm+1zkKgO/ltWau0R8rWk70TcSYk4ysoyKnC+bD+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484755; c=relaxed/simple;
	bh=SWHGmaOap2PKjMGDCKJVlLVkE0j7GKOfRcMR5mWAkHw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSoQkD5mVQV3/cQRi0bfivXavjZPpidnaBs27Yjos745VSbyXwPkp9zNP5dpbdIQaHBhTgcRXawdyk+AA6gKHyk6JXDlxm99Zn3/A9xywVk/aMaVZ1yG/HOiAHywVs6vcHl5iDnYcsYLGJgsmmdtUsLDi3OfKlGdIGlNLM1eOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFVOufrp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFVOufrp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so22973845e9.2
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779484752; x=1780089552; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bPsJePlpXkwldlATZIqerUWLRE6sY0lNvTBYPhByiV8=;
        b=QFVOufrpNg0qBNAXmyDuwBYOe8jfEKurP/7+vke3Phhio/e8Io+obRchSn1jlrLHeN
         6XTcmqWltVoSyrE3khMhPmp0NG58mg0S63/7jy7jzGlwQEDxx7kee9OgaCAzh7Q1Mm4+
         8YctC7HY0Vve2Uni9JhkfriW1Oxc7Y+3g6478ePa3EtJrXv4BFLpOzy+R+RE7PbHNcAS
         4t4tfejrDpx6aJmjJVvTPp6Caj8dd4jb3DoVm0ZNUymEZz/kIs1XmpQ5toeL4vAfue2D
         J4BcN3TfWGoQSQj/xqHddNdon8yAFquU1qz9KDz2VD6XnzJiFt+UhUlBtiZnL/ZcnTqb
         5u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484752; x=1780089552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPsJePlpXkwldlATZIqerUWLRE6sY0lNvTBYPhByiV8=;
        b=F4n2mC/mcGgiNP6cky/bTfbAt0d4WnPw+6MHgZXRt6xRGrJpToq0a0NUKHAYgYxdZ/
         pQwwgwNtKamxGjpmaTGs2c38rfoPATi7KS5gRstp4G+iwvhfDU6KEJkSbfLau22SM0OQ
         E3BR/+zHy3PwQg4s2F2A2V4b8NMnHRmjf+F5nVFgQuH6VgeVGSJYnXv2p3jNPLmI8Nm1
         kbAW+0aBSRTSV3pkKCeOGslzxn97FO2nLJasXfotmTpV5HG3kAByFWO85B6Lz2LMqcS8
         jnZ6vX9lBVVxueEGMBkaMB4zUDyhWwGCQ/7eYYQjQv5T+SVzcfhT+PMx3wO7EANAPNzS
         4xng==
X-Forwarded-Encrypted: i=1; AFNElJ8J5Joflxmkt3IY8K8TU3K4Hf3q+nG+u1pbqVb0ljltvm8ZCuit939A1OHZffoGJ7iakEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9pMIZ2EriPUliXTQsYs+t/05mf6jW7IJLsrA5zDspvoCRCg6
	nMPTzNb8KBsw3Pwg61RXz16vqtI3/Cbc3rmWtDOmI6IWi1Nd+Fj0KfoEUf2tjNiV
X-Gm-Gg: Acq92OH1C1F6PG0q6YcA1XE2VhWg4E/Q31zXywG67p5t4neffOZZunSKguJPQRAtgHz
	X1fNgNvEKEADLIUv1M/mYT0eE7d2KRQ+NgAgLHrFEwwVj3eWC1h/QTiLtNwQBBfKbrUIL+R4nL4
	BP+0auyG3H2qcqGrmjvXlOFpOAyhQbpJPgAij0/gcKY4d7o/C6ft/xRwms82fl+Ubi86MMJAY7i
	wEEy9n8YCSOt/3ueY7fSNCmK0u4gM+iTlhF1slT6P9oKcKwt7GU8SCbmMndXI8bw+8mGkIPnS+4
	ZdCKz9F9PhZN4TJTF+teuWnjZZ7NbTocaeJLkRiv0rlrv4Awv1yZsCz+MYma+jn+DVNt3z0VEv7
	xXKDNj4mBUVMouHqTv8xq/0jngzPaKaqH3xkKsvNW8z+b97hFbnvIvsFtURs6ANq641zAkDugU+
	DXhEvs5OZeLA0=
X-Received: by 2002:a05:600c:4ecc:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-490426cbba2mr76216895e9.22.1779484752004;
        Fri, 22 May 2026 14:19:12 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b9asm66237055e9.11.2026.05.22.14.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:19:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 May 2026 23:19:09 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 04/12] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <ahDITRWELu0ZT5Gv@krava>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-5-jolsa@kernel.org>
 <20260521133548.GK3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521133548.GK3126523@noisy.programming.kicks-ass.net>

On Thu, May 21, 2026 at 03:35:48PM +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2026 at 02:44:03PM +0200, Jiri Olsa wrote:
> > Andrii reported an issue with optimized uprobes [1] that can clobber
> > redzone area with call instruction storing return address on stack
> > where user code may keep temporary data without adjusting rsp.
> > 
> > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > instruction, so we can squeeze another instruction to escape the
> > redzone area before doing the call, like:
> > 
> >   lea -0x80(%rsp), %rsp
> >   call tramp
> > 
> > Note the lea instruction is used to adjust the rsp register without
> > changing the flags.
> > 
> > We use nop10 and following transofrmation to optimized instructions
> > above and back as suggested by Peterz [2].
> > 
> > Optimize path (int3_update_optimize):
> > 
> >   1) Initial state after set_swbp() installed the uprobe:
> >       cc 2e 0f 1f 84 00 00 00 00 00
> > 
> >      From offset 0 this is INT3 followed by the tail of the original
> >      10-byte NOP.
> > 
> >   2) Trap the call slot before rewriting the NOP tail:
> >       cc 2e 0f 1f 84 [cc] 00 00 00 00
> > 
> >      From offset 0 this traps on the uprobe INT3.  A thread reaching
> >      offset 5 traps on the temporary INT3 instead of seeing a partially
> >      patched call.
> > 
> >   3) Rewrite the LEA tail and call displacement, keeping both INT3 bytes:
> >       cc [8d 64 24 80] cc [d0 d1 d2 d3]
> > 
> >      From offset 0 and offset 5 this still traps.  The bytes between
> >      them are not executable entry points while both traps are in place.
> > 
> >   4) Restore the call opcode at offset 5:
> >       cc 8d 64 24 80 [e8] d0 d1 d2 d3
> > 
> >      From offset 0 this still traps.  From offset 5 the instruction is
> >      the final CALL to the uprobe trampoline.
> > 
> >   5) Publish the first LEA byte:
> >       [48] 8d 64 24 80 e8 d0 d1 d2 d3
> > 
> >      From offset 0 this is:
> >         lea -0x80(%rsp), %rsp
> >         call <uprobe-trampoline>
> > 
> > Unoptimize path (int3_update_unoptimize):
> > 
> >   1) Initial optimized state:
> >       48 8d 64 24 80 e8 d0 d1 d2 d3
> >      Same as 5) above.
> > 
> >   2) Trap new entries before restoring the NOP bytes:
> >       [cc] 8d 64 24 80 e8 d0 d1 d2 d3
> > 
> >      From offset 0 this traps. A thread that had already executed the
> >      LEA can still reach the intact CALL at offset 5.
> > 
> >   3) Restore bytes 1..4 of the original NOP while keeping byte 0 trapped
> >      and byte 5 as CALL.
> >       cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> > 
> >      From offset 0 this still traps. Offset 5 is still the CALL for any
> >      thread that was already past the first LEA byte.
> > 
> >   4) Publish the first byte of the original NOP:
> >       [66] 2e 0f 1f 84 e8 d0 d1 d2 d3
> > 
> >      From offset 0 this is the restored 10-byte NOP; the CALL opcode and
> >      displacement are now only NOP operands.  Offset 5 still decodes as
> >      CALL for a thread that was already there.
> > 
> > Note as explained in [2] we need to use following nop10:
> >        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> > NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
> > 
> > which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> > attribute in is_prefix_bad function.
> > 
> > The optimized uprobe performance stays the same:
> > 
> >         uprobe-nop     :    3.129 ± 0.013M/s
> >         uprobe-push    :    3.045 ± 0.006M/s
> >         uprobe-ret     :    1.095 ± 0.004M/s
> >   -->   uprobe-nop10   :    7.170 ± 0.020M/s
> >         uretprobe-nop  :    2.143 ± 0.021M/s
> >         uretprobe-push :    2.090 ± 0.000M/s
> >         uretprobe-ret  :    0.942 ± 0.000M/s
> >   -->   uretprobe-nop10:    3.381 ± 0.003M/s
> >         usdt-nop       :    3.245 ± 0.004M/s
> >   -->   usdt-nop10     :    7.256 ± 0.023M/s
> > 
> 
> > @@ -893,48 +918,134 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
> >  }
> >  
> >  /*
> > + * Modify the optimized instruction by using INT3 breakpoints on SMP.
> >   * We completely avoid using stop_machine() here, and achieve the
> >   * synchronization using INT3 breakpoints and SMP cross-calls.
> >   * (borrowed comment from smp_text_poke_batch_finish)
> >   *
> > + * The way it is done for optimization (int3_update_optimize):
> > + *   1) Start with the uprobe INT3 trap already installed
> > + *   2) Add an INT3 trap to the call slot
> > + *   3) Update everything but the first byte and the call opcode
> > + *   4) Replace the call slot INT3 by the call opcode
> > + *   5) Replace the first INT3 by the first byte of the LEA instruction
> > + *
> > + * The way it is done for unoptimization (int3_update_unoptimize):
> > + *   1) Start with the optimized uprobe lea/call instructions
> > + *   2) Add an INT3 trap to the address that will be patched
> > + *   3) Restore the NOP bytes before the call opcode
> > + *   4) Replace the first INT3 by the first byte of the NOP instruction
> > + *
> > + * Note that unoptimization deliberately keeps the call opcode and displacement
> > + * in bytes 5..9. Those bytes become operands of the restored 10-byte NOP.
> >   */
> 
> One important thing to note is that (as earlier noted by Andrii) the
> CALL address is never changed. A new optimization pass will not change
> the CALL instruction again.
> 
> If you noted this anywhere, I failed to find it. This is crucially
> important for the correctness of the scheme and should not be emitted.
> 
> That is, please add something like:
> 
>   "Since there is only a single uprobe-trampoline, the CALL instruction
>   will not be changed across unoptimization/optimization cycles.
>   Therefore, any task that is preempted at the CALL instruction is
>   guaranteed to observe that CALL and not anything else."
> 

nope I did not mention it, will add

thanks,
jirka

