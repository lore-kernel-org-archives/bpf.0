Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2F39479B
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079538; cv=none; b=pYVm8v9tE2S+trUAAGTweGx5urOBX+/KdSaOVj/+LtkXZq1RBh7eQ5aZQqEkdy+g8hMGCp7q1b5pdO+qxvuyGWFRMuyrzPirYNLn3n8TIkv5gTFowV9mgynYmy5EK/G77SZEZOyOiLtNmWi8a4s0GutquQt9jvBxrAnww/97rso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079538; c=relaxed/simple;
	bh=Cw/r4gtd4OI5SmACpI5d9errnzMgY7OeHrVY93RuT/Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YauXpq7RPW90qzGFcTxjwxLHhlUQoW8uz/9/pnTbxTNoB2UtOJo+cvCMqkOycqPCVCKGn/yy0Ob/lZ6o/v2ZKKKADDOeZgZG9a+J3Qr41PW1IgRHX/nwSn60+yGD1t0x7Xp0FVJSXyLUnH4AYd9hluQIjLsGZD0ImcXNOX1+nF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrHrj02K; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrHrj02K"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so4386115f8f.1
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079535; x=1781684335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ySNomSuoOhQxNd9Yz08f3BU+RBs1JCr8A6QWQlp27so=;
        b=LrHrj02KzklNwHdZTsRebC0xBBltnDTxdqFEFEK8zICaHFjipphZLPUqlsGYtqU6FC
         z8Y0rr6cO9exga2xjkEr8qFd1g9+bGbOLNApkLK5B5bcrklR1+av7KFPtwLLrZH8aqMZ
         woNkDebkqR29YnVlpY/O/Uwi0jmvHF4PRswF6+gS92quH2eKO/lwJL5QUeaSHVggUmTp
         rq7NLzpqPCYtqbsf7bbbLvfrbUaiGJS2blRhGb1YpjLW26P2NOuJ6xOmNMUVCz4bPzlX
         haFWc+2buw8jDvakZ72jcBosc10wN2gJvy00FwdLsACZpoy2owtkzoFEe/ooS5fW5hF1
         FjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079535; x=1781684335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySNomSuoOhQxNd9Yz08f3BU+RBs1JCr8A6QWQlp27so=;
        b=DxyGhqdLyJXLUPfJ+c1WOrfIXZeNnuboqiABnrwqBoo8RxciscOngg1uoIfeyOTMSk
         iodD2D3t6FNryJy7VPo1bsNGCwL1j9B1avwTJeFoZadwlxT+1EjQ5E4ChieqtRujKZpT
         NrizJraYz0oKPnMzmOoDOaNT6u+alKGqq7VvARMrBg7AozE7xxQy5X9O2qFVY3eSc46m
         URXZxPthzqexT5tKLnOCyWt1zfkSkbfMl3k0Vb23kwk8FUZBBAg85PwUFT4tY7qpaj7x
         I8H3d/uC8iRvDVj0HurxwmIMketJnbSnicYICX5gVk8UVD07fy1WoTzZ09cZCPkCydjg
         va/w==
X-Forwarded-Encrypted: i=1; AFNElJ/+5g55qhE1P2zemjedSv+DKJ1O+Yn5YNQDsEfofp/OwFwWfRcWk9oEQPfmkdiNsu4fyYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgkiPDsL057hjAhsXmggaCNerdKMpejOADXmPk1KFwCVj3eWp0
	IzzFAPSBK0yuoaLWzs8wspd1Z0MRNrzZuGYa2ewBYpK1dSfBiIU0KvNO
X-Gm-Gg: Acq92OF3/VZioAEulM7B0LOpwA9/9+g/UxLzDpF1oY7SZ5RP5OvFlhoKSSIwrXpln1A
	H2Z3VF/6hWNo6BH3z7Y1/vHZsMdgmR4VzWUbT7TGkivv1vgDuF2gN9yjjOVMOM02oo3VR7LYLUY
	Dnae6Rwfi3/EeUEW5WpVAEwB9iBMmoXuETy+5691zWy7m2SgSFi0NvCi4DhFrJzaGG8j8MHxJ4I
	bgydDcg3mVwq0Ilhx0MBtkL0ueRweiZ5iKarP96X8zlBSWi940+tr/Z+++9LBnEXGlcfBqeueKf
	VKiro92MLeGC4xg327P17QFgvu4uK6x8Fb0B2VexSEeiMhFEsscxRtdHHrApgdZjjFKA/XEaydj
	LupN2FnNo6DQv6rsk9Sv4980TEytRZM16X6R42APSrBsKUo/n+FKeELmEbvNjEk5Uw6MnJnOFXC
	e4L+VAHSVghgFkcwYe89YFVA==
X-Received: by 2002:a05:6000:2083:b0:460:1378:7b0 with SMTP id ffacd0b85a97d-46032b6124bmr28994465f8f.5.1781079533500;
        Wed, 10 Jun 2026 01:18:53 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm67902866f8f.12.2026.06.10.01.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:18:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Jun 2026 10:18:51 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <aikd6-5HYhCnc0Ze@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-6-jolsa@kernel.org>
 <CAEf4BzZiFUeFa4fdghuSGpqiEzyvJVxs6TDgJd5U4hSj--imiQ@mail.gmail.com>
 <aif8jkUPst-tTskE@krava>
 <CAEf4BzbsB-PRZRqkz37YK5wYNR=ajZv2N7tEznpZM0rdyYC_xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbsB-PRZRqkz37YK5wYNR=ajZv2N7tEznpZM0rdyYC_xA@mail.gmail.com>

On Tue, Jun 09, 2026 at 09:43:15AM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 9, 2026 at 4:44 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jun 08, 2026 at 01:46:39PM -0700, Andrii Nakryiko wrote:
> > > On Tue, May 26, 2026 at 1:59 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Andrii reported an issue with optimized uprobes [1] that can clobber
> > > > redzone area with call instruction storing return address on stack
> > > > where user code may keep temporary data without adjusting rsp.
> > > >
> > > > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > > > instruction, so we can squeeze another instruction to escape the
> > > > redzone area before doing the call, like:
> > > >
> > > >   lea -0x80(%rsp), %rsp
> > > >   call tramp
> > > >
> > > > Note the lea instruction is used to adjust the rsp register without
> > > > changing the flags.
> > > >
> > > > We use nop10 and following transformation to optimized instructions
> > > > above and back as suggested by Peterz [2].
> > > >
> > > > Optimize path (int3_update_optimize):
> > > >
> > > >   1) Initial state after set_swbp() installed the uprobe:
> > > >       cc 2e 0f 1f 84 00 00 00 00 00
> > > >
> > > >      From offset 0 this is INT3 followed by the tail of the original
> > > >      10-byte NOP.
> > > >
> > > >      After a previous unoptimization bytes 5..9 may still contain the
> > > >      old call instruction, which remains valid for threads already there.
> > > >
> > > >   2) Rewrite the LEA tail and call displacement:
> > > >       cc [8d 64 24 80 e8 d0 d1 d2 d3]
> > > >
> > > >      From offset 0 this traps on the uprobe INT3.  Bytes 1..9 are not
> > > >      executable entry points while byte 0 is trapped.
> > > >
> > > >   3) Publish the first LEA byte:
> > > >       [48] 8d 64 24 80 e8 d0 d1 d2 d3
> > > >
> > > >      From offset 0 this is:
> > > >         lea -0x80(%rsp), %rsp
> > > >         call <uprobe-trampoline>
> > > >
> > > > Unoptimize path (int3_update_unoptimize):
> > > >
> > > >   1) Initial optimized state:
> > > >       48 8d 64 24 80 e8 d0 d1 d2 d3
> > > >      Same as 3) above.
> > > >
> > > >   2) Trap new entries before restoring the NOP bytes:
> > > >       [cc] 8d 64 24 80 e8 d0 d1 d2 d3
> > > >
> > > >      From offset 0 this traps. A thread that had already executed the
> > > >      LEA can still reach the intact CALL at offset 5.
> > > >
> > > >   3) Restore bytes 1..4 of the original NOP while keeping byte 0 trapped
> > > >      and byte 5 as CALL.
> > > >       cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> > > >
> > > >      From offset 0 this still traps. Offset 5 is still the CALL for any
> > > >      thread that was already past the first LEA byte.
> > > >
> > > >   4) Publish the first byte of the original NOP:
> > > >       [66] 2e 0f 1f 84 e8 d0 d1 d2 d3
> > > >
> > > >      From offset 0 this is the restored 10-byte NOP; the CALL opcode and
> > > >      displacement are now only NOP operands.  Offset 5 still decodes as
> > > >      CALL for a thread that was already there.
> > > >
> > > >      Tthere is only a single target uprobe-trampoline for the given nop10
> > > >      instruction address, so the CALL instruction will not be changed across
> > > >      unoptimization/optimization cycles.
> > > >      Therefore, any task that is preempted at the CALL instruction is guaranteed
> > > >      to observe that CALL and not anything else.
> > > >
> > > > Note as explained in [2] we need to use following nop10:
> > > >        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> > > > NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
> > > >
> > > > which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> > > > attribute in is_prefix_bad function.
> > > >
> > > > Also changing the uprobe syscall error when called out of uprobe
> > > > trampoline to -EPROTO, so we are able to detect the fixed kernel.
> > > >
> > > > The optimized uprobe performance stays the same:
> > > >
> > > >         uprobe-nop     :    3.129 ± 0.013M/s
> > > >         uprobe-push    :    3.045 ± 0.006M/s
> > > >         uprobe-ret     :    1.095 ± 0.004M/s
> > > >   -->   uprobe-nop10   :    7.170 ± 0.020M/s
> > > >         uretprobe-nop  :    2.143 ± 0.021M/s
> > > >         uretprobe-push :    2.090 ± 0.000M/s
> > > >         uretprobe-ret  :    0.942 ± 0.000M/s
> > > >   -->   uretprobe-nop10:    3.381 ± 0.003M/s
> > > >         usdt-nop       :    3.245 ± 0.004M/s
> > > >   -->   usdt-nop10     :    7.256 ± 0.023M/s
> > > >
> > > > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > > > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programming.kicks-ass.net/#t
> > > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > > > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > > > Assisted-by: Codex:GPT-5.5
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  arch/x86/kernel/uprobes.c | 255 ++++++++++++++++++++++++++++----------
> > > >  1 file changed, 190 insertions(+), 65 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > @@ -943,13 +1026,31 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > > >         smp_text_poke_sync_each_cpu();
> > > >
> > > >         /*
> > > > -        * Write first byte.
> > > > +        * 3) Restore bytes 1..4 of the original NOP while keeping byte 0 trapped
> > > > +        *    and byte 5 as CALL:
> > > > +        *    cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> > > > +        */
> > > > +       ctx.expect = EXPECT_SWBP_OPTIMIZED;
> > > > +       err = uprobe_write(auprobe, vma, vaddr + 1, insn + 1,
> > > > +                          LEA_INSN_SIZE - 1, verify_insn,
> > > > +                          true /* is_register */, false /* do_update_ref_ctr */,
> > >
> > > tbh, it's quite subtle and non-obvious why is_register should be set
> > > to true first two times (and especially that is_register and
> > > do_update_ref_ctr are implicitly connected), not sure how to make it
> > > cleaner, but maybe leave a short comment explaining this twice
> > > register, once unregister sequence?
> >
> > ok, I came up with comment below
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index de544516ea70..92449f34c005 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -1011,6 +1011,12 @@ static int int3_update_unoptimize(struct arch_uprobe *auprobe, struct vm_area_st
> >         int err;
> >
> >         /*
> > +        * Note the first two uprobe_write calls use is_register=true, because they
> > +        * are intermediate patching states while the probe is still active.
> 
> this doesn't really explain why is_register=true is the right one. It
> actually doesn't matter as long as do_update_ref_ctr=true, isn't that
> right? So maybe just to avoid a bit of confusion let's pass
> is_register=false and do_update_ref_ctr=false, and in the comment
> explain as you said that it's intermediate update and we don't want to
> update refctr just yet until the very last step?

apart from refctr update there's also different way the concerned
page is managed, IIUC:

with is_register=true we force to get exclusive anonymous page for
the update (or pin the existing one)

with is_register=false we try to zap the private anonymous page and
return the mapping to the original page

there are several comments on this in uprobe_write/__uprobe_write

how about the update below

jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index de544516ea70..09f5ff71227c 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1011,6 +1011,16 @@ static int int3_update_unoptimize(struct arch_uprobe *auprobe, struct vm_area_st
 	int err;
 
 	/*
+	 * Note the first two uprobe_write calls use is_register=true, because they
+	 * are intermediate patching states while the probe is still active, so
+	 * we force the exclusive anonymous page for the update.
+	 * Also we use do_update_ref_ctr=false because refctr was already updated by
+	 * the initial int3 install.
+	 *
+	 * The last uprobe_write to nop10 instruction is called with is_register=false
+	 * and do_update_ref_ctr=true to trigger the refctr update and to instruct
+	 * uprobe_write to zap the anonymous page if it now matches the file page.
+	 *
 	 * 1) Initial optimized state:
 	 *    48 8d 64 24 80 e8 d0 d1 d2 d3
 	 *
