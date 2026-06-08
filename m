Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA3353EF3
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951616; cv=pass; b=SG/is92oZOzexHzZ2+BTWO0XNOWN+O/ZM8j2PgRkTNMRYIDTtD8eYc4UShU0sKRumx40ZGrU2eM0073iQvw9shAKcDvbEkK1pBtOVJLtIRmmtXGq8Gg5GE+xDcvbl4vwQxBvPaC3eWV4d6NF08milu+ZSaqvFI11IyngLWOFThM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951616; c=relaxed/simple;
	bh=VkcZ55KTdEMhzAd9CZKpprqWDhoO/PUfmHma6XOXPHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUeufg7m6Q12UIiMBTYpiR6CIg/ecQcHClmbj64iFXTQ0w1B97u9pOqc6Xtm+h0/VWYSAfKQUHvpuC/IF6YdKVcOHiYRg9rESaPGgHIlSoZPB0DlBun1n8bWaSLctzQGt4wq7OIE5lNWS5N/UNIWGR8R/eMV5zti/4nVLDJtBAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI0HbSKc; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI0HbSKc"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d8b644473so4769182a91.3
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 13:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780951614; cv=none;
        d=google.com; s=arc-20240605;
        b=ayI2FTsruEopjrOUo56W7bBgnniGBbI5+Nu2erUCBmM4pGJiIV/awhpYeAkwtkmv4Z
         0j+pgZlrazrQCaYRPEDmiU+FMuGkUiOx/UQCdCvu74mx9fDMVXncF+UG3g3c3Dxtn0dx
         z2gxgKk3+bZK8RD4PhqrsDv5XmvogU26oxFS/mShAZ827vEIKKDdW4eIUisays8IGNcE
         1q7nDc4Oh3jdaJ99fVAP9YAhSNpUle+/9wJomrdYGU/c43nu4u7v3M+LOZ45HXd/u4uO
         pqLzKx3sjvqb813COXyfukzJ4hsARg9GFVEV1MOBO0GW4riEaXuFcAp9xtthwukeSjw6
         pHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bEyAmCN5izqc+BHw5LGWc/odGoJ+BdSkQDaB0mqnFRM=;
        fh=YvSOJznCKxq5FaMc033Wlbqdioiaal3kA+qnIDdZ/NE=;
        b=OOiUztLgRm1psuAR0WtFKRfutW7L26E+kxYX6Nd3my9yfUXnqVyrxFTZ47Eyc1SV1k
         7B3zuArIuus+Tgrpi9UB/6LvIdAFnQqPss9jERN56uNTYte+bdkX9fSjke25+D3jOGkJ
         o2aepbHXcYz8+j9xHE9sbyXs9wfG0G5BfusW5bC5tHf1JcHgGzQdB8P/deKdivD6QpTy
         1hMNpXKBSu/kX17h8CeAxH7m1xMHvIWs1eX4kOoxQ3IGAC5taMPt9FuMZI3T06FLpoTo
         D/gObE8paRJsOIg7XD9BRYudyKqRxhxrdioHu09Mg/q2mDcmzfXB9BE+oVWFd3m0PZhs
         YmbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780951614; x=1781556414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEyAmCN5izqc+BHw5LGWc/odGoJ+BdSkQDaB0mqnFRM=;
        b=EI0HbSKc1Xnfock0yqprt9Fz5j+7hB8KzBUZs2E3cPxvWJ8Z25VnzRJJOGsr+dmFqM
         azsx+xJsBam8dtWxV+pbdHlgIIkYSZuxPyHrtuUOsUbQ6avaQ0fSDZKPnXU9Aal5HeFx
         OkSJ+GmDq6+HqOGEH1kL+z7VLiVgBCCnUqoms4zvv7U2sqiyEYWF88pUAZ4sCn7FAgjN
         zwLWrdJ8i+eRV7/bdi6ANQrX3Tvk+d4+/n+pyEqMwvQHrzGGZyLoToA7SqpWHGPv5HJp
         x6OMZ6VsZ6xPNoOYIcg5Kce222bHG516XuEm99amQsPudH9V7Fkc7ZLDtK2PYfj2ZvZr
         Ocuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951614; x=1781556414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bEyAmCN5izqc+BHw5LGWc/odGoJ+BdSkQDaB0mqnFRM=;
        b=nNT6ny0n9P2fk6TBwwcZ1rFyHRPnPRIiM6esfIvYW44D6IoltWQm6NTkp9BhDAzz62
         KILhOE2ZAkOZE6ZplGAI6zvh4+ECyDOdHD0F3iNRk7fDDMXAksimFbYqlCfEBMDLFzLg
         nv+RGEDzslXY3PtPbx+dzkWQGa6GEegot7qNIvfH3YZOKPTH3Bj3qwUQ6ioq1X4nXw0j
         y7RLThU3YaiYRwp+dxKVAHaLlMg7DmgmLHClzmA+Iof1omFGVV82h5F2W2EyO3Ae1n0A
         EgNM3/uqbBD5xZxDAgtshy104VM6vI+raewX4lc+Ql0ZheP3kpbbtElLZEnFZvGwrAc6
         XyHA==
X-Forwarded-Encrypted: i=1; AFNElJ/Lu3vjOuyBjoVJDllXqf5iXB3J8KdQFpbSGULJpY6W7bYacljjV0+swvqiknl9pYgZzOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbv/+cjW8/zLY9Snkcxtlg9V9FzRmupNAZU9IBleJJj7qACi2
	X5mKdMLmZ6UWwI3jTTBU8iU/i9iTzzLnOmy1LuzJ8fFPPq5Hxdzi4qctVimyRpTBCU8Zua0HUzl
	l7NqWx0WCwTEWK44VYh++SjQu/MDmMVo=
X-Gm-Gg: Acq92OFGq/ity7OFFIk5SS9JzDHeOI0RdCTqD+l0vHPC2AoPt6h04jFBd9KB0GQk4Bu
	t90/Bk8HI3l/UW+Pqm+ggtLg2UBESXQItCgz5oo1RFklSGsN3eagCEL8vtNKfrHaeYiJ6oPYKm/
	I9jUTf580eReBlvtgNy3fD8wa+9dC9vry1S5KsVLZ+JlZaPUW3UiiSHeV9j3v4givZ0Aj+9iiOG
	7xcwZVnd+XX+gMaqgjEWdHcrSmw8GEiLbYj2goEmTdB/IH9CtG/A+96KdfVKSR24Y8Y34Ip1QK7
	CYy4IGymqdZ6T06LyB0Jaj8dtT59abjOUmwztPms7BUJ2dTlHNiRZxezhMA1dZATAGYppH5h3I4
	pYZu1dd9a9LYcErUWS1/v4hr1UA==
X-Received: by 2002:a17:90b:3512:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-370ee82fa3cmr17358938a91.1.1780951614413; Mon, 08 Jun 2026
 13:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526205840.173790-1-jolsa@kernel.org> <20260526205840.173790-6-jolsa@kernel.org>
In-Reply-To: <20260526205840.173790-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jun 2026 13:46:39 -0700
X-Gm-Features: AVVi8CfRk6L2D7B6rQ3r0LikUw7cueXdxCQXSNM3PID6p4IbsR9995QvIqtVNp4
Message-ID: <CAEf4BzZiFUeFa4fdghuSGpqiEzyvJVxs6TDgJd5U4hSj--imiQ@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to nop10
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 1:59=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
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
> We use nop10 and following transformation to optimized instructions
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
>      After a previous unoptimization bytes 5..9 may still contain the
>      old call instruction, which remains valid for threads already there.
>
>   2) Rewrite the LEA tail and call displacement:
>       cc [8d 64 24 80 e8 d0 d1 d2 d3]
>
>      From offset 0 this traps on the uprobe INT3.  Bytes 1..9 are not
>      executable entry points while byte 0 is trapped.
>
>   3) Publish the first LEA byte:
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
>      Same as 3) above.
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
>      Tthere is only a single target uprobe-trampoline for the given nop10
>      instruction address, so the CALL instruction will not be changed acr=
oss
>      unoptimization/optimization cycles.
>      Therefore, any task that is preempted at the CALL instruction is gua=
ranteed
>      to observe that CALL and not anything else.
>
> Note as explained in [2] we need to use following nop10:
>        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs n=
opw 0x00000000(%rax,%rax,1)
>
> which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> attribute in is_prefix_bad function.
>
> Also changing the uprobe syscall error when called out of uprobe
> trampoline to -EPROTO, so we are able to detect the fixed kernel.
>
> The optimized uprobe performance stays the same:
>
>         uprobe-nop     :    3.129 =C2=B1 0.013M/s
>         uprobe-push    :    3.045 =C2=B1 0.006M/s
>         uprobe-ret     :    1.095 =C2=B1 0.004M/s
>   -->   uprobe-nop10   :    7.170 =C2=B1 0.020M/s
>         uretprobe-nop  :    2.143 =C2=B1 0.021M/s
>         uretprobe-push :    2.090 =C2=B1 0.000M/s
>         uretprobe-ret  :    0.942 =C2=B1 0.000M/s
>   -->   uretprobe-nop10:    3.381 =C2=B1 0.003M/s
>         usdt-nop       :    3.245 =C2=B1 0.004M/s
>   -->   usdt-nop10     :    7.256 =C2=B1 0.023M/s
>
> [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org=
/
> [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programmin=
g.kicks-ass.net/#t
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel=
.org/
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 255 ++++++++++++++++++++++++++++----------
>  1 file changed, 190 insertions(+), 65 deletions(-)
>

[...]

> @@ -943,13 +1026,31 @@ static int int3_update(struct arch_uprobe *auprobe=
, struct vm_area_struct *vma,
>         smp_text_poke_sync_each_cpu();
>
>         /*
> -        * Write first byte.
> +        * 3) Restore bytes 1..4 of the original NOP while keeping byte 0=
 trapped
> +        *    and byte 5 as CALL:
> +        *    cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> +        */
> +       ctx.expect =3D EXPECT_SWBP_OPTIMIZED;
> +       err =3D uprobe_write(auprobe, vma, vaddr + 1, insn + 1,
> +                          LEA_INSN_SIZE - 1, verify_insn,
> +                          true /* is_register */, false /* do_update_ref=
_ctr */,

tbh, it's quite subtle and non-obvious why is_register should be set
to true first two times (and especially that is_register and
do_update_ref_ctr are implicitly connected), not sure how to make it
cleaner, but maybe leave a short comment explaining this twice
register, once unregister sequence?

> +                          &ctx);
> +       if (err)
> +               return err;
> +
> +       smp_text_poke_sync_each_cpu();

[...]
