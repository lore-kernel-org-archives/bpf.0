Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B6400DFB
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005462; cv=none; b=iY602P2gOc+eGo20FVdsTTyYM/EYy4LiZ7JBNj12O2PZgYTCNNECw6lD1IAOiw1XYjf6P1cGYCjp6pWy5Y5x4NwuUOdnORpwWRLD938Mn7NDHsoaFSk0Dez0jLtCvWi+LxP3iSDmMagQrGzxc7iw0Gmn0HZRBSzW6h+Hd6NG+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005462; c=relaxed/simple;
	bh=W34tW+TL1fVpTZsQAz7hrtAMDWwpsV8907Q0DNpW7Pg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxcBMnvNhDSNRMBb6nn297jOTLHIcovuBInihr4+tk0UpkyegzwdreV8tnRGw78IvDsUMgLET/bC6o+agv5KhR68J7QGRYmFnWtt5El7YXCZdWNv/nHpdL2R8JZ+u+IkjQFk5xfWzhJDe+puSEY3XwSW3lsZuZvO7QAcZeIUeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IISkgHsB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IISkgHsB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4908b92904fso62421585e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781005457; x=1781610257; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=78g+kaugjg6eGXzQYKhL68a4cErx8U1dVjePqpr+p18=;
        b=IISkgHsBlESSQR4az4NZO1mW1fHV7fBxXkGYh5uSRA1FqFVh8PfT7FkJuOfwyU5FRK
         +DOT6djo6LInDS9uhFWs0wzJi/4CJN5MzFFDJzeH5dnUkFMeJkY0TLiwz5Qe+LVWurkp
         DsR7BVUHSk4IGWzwqq64MlbqDKW2M9JuLEET6EfH1hCKAkwf7H8HDo/vDS3bCnOjAGEX
         m2jQVlytJCwSX6LvQ8JmEcNw9VmEZlz5d+DKo7qi1YUR3ITuoVHRtqZL5nZRIJrstW/l
         LdpR7xSp/SbQd0EZvXwX5I9XHbGRhvmsHHP2a1AZQ/okLTLxt06ZbiSa4eJ4sfPf/y/E
         Fi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005457; x=1781610257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78g+kaugjg6eGXzQYKhL68a4cErx8U1dVjePqpr+p18=;
        b=E6rEcP76WSP7aOLRUkk+L/pjT7Kr/bY9LqnJbYmvQXysgO8vQUQQMhvDxtjyGXqYx7
         8itrG7aLfhgTxGUo40O5TVO9zNib07TN0oSSCytyVniSc1oSS3qeWujTL2alqNofr4vf
         DqALkVyI1ulOue3vsB6FTt3g13ni8/aoJ4/60qhTO5dFiSHXP4PdFsXnaQ6RYOd7/c2P
         oB/ZBew2ukkkMpW32TVFk0QoMBCIYCj5S0uccryj6q4gnXgAZ0PnDzENZwfTA7/JZDzs
         OAIJyJMlGU7XYVufVMTPo3LrBMnYk3dKMPdClFW9LmfVH3DxW6N1eyhcjeelVtQhGCGN
         thxA==
X-Forwarded-Encrypted: i=1; AFNElJ+EWrKd2ikiMB7WUF9SAHY0DbtpJoT/f21IpJ2RnERMmHR/A22cAtUMhBmWeFz3ZWbWtfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrw8nAWf9wKvzxNBATeHyIbcYq/S0XPt8jR7Ys6kKF3NYgOKU5
	d0ln/rsb54R7o6ryKcd2uD4EQK2N58sP2w3lrkxmWtulBntgrQm8iUxv
X-Gm-Gg: Acq92OF373qIDqspqP4LGqzZEkLVJsSg7zTA/9m7LrTwCsvvxcvHyXm9A93HvR95Jvo
	zDDOKXGGzFCx5ANtmdYrBSFV2SnQ+eAY9o98p4QZtv1r0EsXowdAOVVf3XAY1Eu6M8feSxFmyHg
	h5qwPOR7ThwIFEprKDCWajQOmbJ4n5YmbhwBFuEdp1EQzw/yvCfjzLvPucufMBLFHKzas6D0SAq
	KgPolfq1221PMH0Gldy5YZx814NXPUVIqFLCuhBhGpjqNSjhoRnewcORJ53seP2Zsh+nUFRQaC1
	xTdhlrWSiAwMzMuY1XmgU9KxvFa8MytvJCjnr8/tIDs1uM31XWKejiHJL/gcUAmC3cfv4D0s6+X
	xOpCEUqHsZpJFRiYStebNWE88kqQVw+k7APFaOUeJWsN9kq0x6lQ6LbU0LIdTU1cPm6/hpJuwdu
	dlWe7r+b31wPiiib+tqG4LhtCLrsCYSRR/m2fB
X-Received: by 2002:a05:600c:c165:b0:490:a2fd:e1e5 with SMTP id 5b1f17b1804b1-490c2623527mr380298985e9.17.1781005457181;
        Tue, 09 Jun 2026 04:44:17 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm50544318f8f.32.2026.06.09.04.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:44:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Jun 2026 13:44:14 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <aif8jkUPst-tTskE@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-6-jolsa@kernel.org>
 <CAEf4BzZiFUeFa4fdghuSGpqiEzyvJVxs6TDgJd5U4hSj--imiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZiFUeFa4fdghuSGpqiEzyvJVxs6TDgJd5U4hSj--imiQ@mail.gmail.com>

On Mon, Jun 08, 2026 at 01:46:39PM -0700, Andrii Nakryiko wrote:
> On Tue, May 26, 2026 at 1:59 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
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
> > We use nop10 and following transformation to optimized instructions
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
> >      After a previous unoptimization bytes 5..9 may still contain the
> >      old call instruction, which remains valid for threads already there.
> >
> >   2) Rewrite the LEA tail and call displacement:
> >       cc [8d 64 24 80 e8 d0 d1 d2 d3]
> >
> >      From offset 0 this traps on the uprobe INT3.  Bytes 1..9 are not
> >      executable entry points while byte 0 is trapped.
> >
> >   3) Publish the first LEA byte:
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
> >      Same as 3) above.
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
> >      Tthere is only a single target uprobe-trampoline for the given nop10
> >      instruction address, so the CALL instruction will not be changed across
> >      unoptimization/optimization cycles.
> >      Therefore, any task that is preempted at the CALL instruction is guaranteed
> >      to observe that CALL and not anything else.
> >
> > Note as explained in [2] we need to use following nop10:
> >        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> > NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
> >
> > which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> > attribute in is_prefix_bad function.
> >
> > Also changing the uprobe syscall error when called out of uprobe
> > trampoline to -EPROTO, so we are able to detect the fixed kernel.
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
> > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programming.kicks-ass.net/#t
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Assisted-by: Codex:GPT-5.5
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 255 ++++++++++++++++++++++++++++----------
> >  1 file changed, 190 insertions(+), 65 deletions(-)
> >
> 
> [...]
> 
> > @@ -943,13 +1026,31 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >         smp_text_poke_sync_each_cpu();
> >
> >         /*
> > -        * Write first byte.
> > +        * 3) Restore bytes 1..4 of the original NOP while keeping byte 0 trapped
> > +        *    and byte 5 as CALL:
> > +        *    cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> > +        */
> > +       ctx.expect = EXPECT_SWBP_OPTIMIZED;
> > +       err = uprobe_write(auprobe, vma, vaddr + 1, insn + 1,
> > +                          LEA_INSN_SIZE - 1, verify_insn,
> > +                          true /* is_register */, false /* do_update_ref_ctr */,
> 
> tbh, it's quite subtle and non-obvious why is_register should be set
> to true first two times (and especially that is_register and
> do_update_ref_ctr are implicitly connected), not sure how to make it
> cleaner, but maybe leave a short comment explaining this twice
> register, once unregister sequence?

ok, I came up with comment below

thanks,
jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index de544516ea70..92449f34c005 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1011,6 +1011,12 @@ static int int3_update_unoptimize(struct arch_uprobe *auprobe, struct vm_area_st
 	int err;
 
 	/*
+	 * Note the first two uprobe_write calls use is_register=true, because they
+	 * are intermediate patching states while the probe is still active.
+	 *
+	 * The last uprobe_write to nop10 instruction is called with is_register=false
+	 * and do_update_ref_ctr=true to trigger the refctr update.
+	 *
 	 * 1) Initial optimized state:
 	 *    48 8d 64 24 80 e8 d0 d1 d2 d3
 	 *
