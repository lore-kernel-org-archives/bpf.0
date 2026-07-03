Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F323C3C0E
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081621; cv=pass; b=YFGG5HPVoBmYQDXhhMxYpGJ1N8ilgm67QaIpVMsD2wKpZ80g0ewOEZYUvNPhsdvFM9QlEYiQZhB49UR2G2DNf+Tn3AmXsr3DFX4iJW2oyj9VAosGphb9SqhbkzOcohCRto3toQjCXJVFSJEme6ELwQ4zaPNPQwbXd0hfIQAm3+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081621; c=relaxed/simple;
	bh=GUfkYu7J9XEsKoG+enQvpADK4Syud+mLtRMB/3CPQ1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPalEobqu3lswOVPOyVvJJM1mwzuqfVaMCUTfrzqDJQMKLbUe5d67Miy0NJIAGL+UogMlBNC3I4N5fain5Dsa7YahwQfdgdxv8GnqzoVuajrvT5IUOF2OY1Ze3hV29m61ItYMC3Iw7F/23Zwy9OHzTe/H46b1ay1xHsucgniZ3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EDDCeHeU; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EDDCeHeU"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-497deab2d66so364621b6e.0
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2026 05:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783081616; cv=none;
        d=google.com; s=arc-20260327;
        b=e5p5xyp8VTC6yvOYzfr3wMch2Y8xEWgszFqaPnJ7y5yLfyrjXmzGhNHi+BOZHnLlmw
         lmfwQLlMPy38TmoNVjc3ztvCu8crZ3iWO1FElfSs6gyyPbdtU7dLlY0AYK/1TciOqq8c
         GtwHPs3ZC2E3Fn8odYw9XnzDtSpc7tjBI28Eiq+51wmV0NpnLTsFni5PTKa0GMxGm6YU
         ySkLDW5uOkF8QrTL8JpCUXxcKT/EyXCW84sdPz1iYQffM/jtfy7H74MSFOe7XOx0jj0s
         3RLZXNYnsNOpYJoKFFQZ7iTVPfC3UC4M01Obn8h0HrUISg/LG7ujmUwAlPjiuriPCcSr
         RGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mkcwegeSHRA8Rtq4C78mf0gL9tHt8vO0ljYRm2yfd08=;
        fh=slQxfYKjp+sMsPWI/1qFQe8M6gVlbSLwc4J/HqGLztk=;
        b=Nf8LMfYn4dfSs043A6/kWijpafKoUwSU6O2+6jU0+Hi/XL850U9l4RQnuozeDIizrA
         2bJUVl57vLItP3Mm+pn4RoCFR88JFuQJ+xh8UdD6oPvvsXOe32ZPoxQO81khMhAAUI/g
         zgK3kXW631tEFArrxrKHKyTiW4gqA3qhDzMnNTPpsflx1lVtOrLji70HcuoLEyGXSE7Y
         MFpt0BiSJUzPP77hCNLjJVUkIJ37n9nRiN9iPM0lDFERUf8NCULpWwihDAsl6W0PlIWS
         UJH1xsejnz/0t5AKbdmq1aVs0iM2r/uFGP2llsOneAb4YlLzbCtTqCq0h/+yhzu0ClIr
         /wgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1783081616; x=1783686416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkcwegeSHRA8Rtq4C78mf0gL9tHt8vO0ljYRm2yfd08=;
        b=EDDCeHeU3IjGB8uXKaPOqkOyviCmbJPY7p2pbDIqwQEe0+KtVv7lfnrxuhvjVFlV9p
         /JDQeetqNkKxW3fSNyG2ynovcsT3oEAojrmBRYF3Rhn3c3IRXAi11Qd4+IXy+iiyUAOX
         Ee2M5MPv779EwtfMQiL/m4T/aT+wo0aRIGgmMoY1CcKKkiUNlLcRL1TaquaB9v0BNIo1
         DcwZ7Rsh22dQs9m4NHeNFR3cRnmRyEg/pUmLHxy3p1Z8Bm9YpYh8taMs1xYz4ntg43DK
         lKVqnUCTnS2UXH+1lAwF8ZiVjQgz3pxWzmOe6Q1Fbwa+1gz1gBB8U5IgxiWPymXmVj1c
         CYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081616; x=1783686416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mkcwegeSHRA8Rtq4C78mf0gL9tHt8vO0ljYRm2yfd08=;
        b=O2MhFlLYb0GgBN4fsXFc0rt8Uivd544LZ4o8OjvMNlgg5t4KCWOEOH2eKulWEwQ+8g
         LAkETfAs9vK0TD0ykWoaLqOOZqseOw2LhNBn3xVuGaDu3lHUvB5wzQBpYiIiXEUWLTjp
         vDyhv+iWHa+CpqqdSS2W+tOrJvyq5ut2WGREjZkOiwREoaV0sZsV6NxagLSRAaDz+lzw
         N4s+xFGi+fwRn1oIiEgFtZMQWDD9y8SPbP40njQweJWHy/IjzMaCq9nzR5VltLaHxfUF
         z9noRNEIiKQAzamfTmxSc/rL1tt37ftSqWBFapiQijUXVxoAolGIqqVvE/0m4K3BNbeM
         9gGg==
X-Forwarded-Encrypted: i=1; AFNElJ9FyY4fdN61ECQzjhsrxrI5JiqJLnMU5q+F0vaFCEISaTtKY8S37/agm1SaL1ntBfMK8Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6O/J4CjkpW5zk7MHOFwEmsm4rD5MQYIYhaoZP84rFaAVBA/ux
	ABOt4zWV6SlYV0eK1UWmPUSCvTnJqWXkiZu/bxlIpE3BMysa65PD4jgFCi54X1usqM3vR5TxCg+
	syyOxHVQOHxupTjXz7Vv0RkQ3uXPvnjLeTXk3lG8Sfw==
X-Gm-Gg: AfdE7cnfzFJPI350rlSZY2iAQynW6pel0JLliCIfFAKIBkznUDjOTiR42kzjzEsKlF+
	e5NJjH4iCFPCjW7O96ZOyOh6q/JpGN9FSDXySiRy7BS0b822hPis7QWPGSdkftF7LPI0nl8Mkha
	KEBw1BxORcBEnhYl/w3Mh6JbxC/yBQF74wG5g6/+DGmVmGPGm0jIqDc/uH6HS9w+I/HjRure2Eq
	BvjrGNclALqzecom1jZzmtd090PYIhV7lCa3o9iJs6m9MG0kZX6Kwq8LYBBo1A3ROtqoXzgfV4V
	AseaAJCn0dj98A==
X-Received: by 2002:a05:6809:6:20b0:496:100e:35f8 with SMTP id
 5614622812f47-497e1e43cedmr1478072b6e.21.1783081615982; Fri, 03 Jul 2026
 05:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702025443.83389-4-cuiyunhui@bytedance.com> <cee66b78b5bad62e6107ce7579d7e613ad05a258aef8d0ab279b706543651a13@mail.kernel.org>
In-Reply-To: <cee66b78b5bad62e6107ce7579d7e613ad05a258aef8d0ab279b706543651a13@mail.kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 3 Jul 2026 20:26:44 +0800
X-Gm-Features: AVVi8CcDmMKspGUBCgXqug4CkmXz20IK78kFtcg22LCfN8fJHodpSJeX2_dNFaw
Message-ID: <CAEEQ3wmTJU1-5e81fy0wnv6gCP4n0cdydOW-Hj7pFJxhFj+6MA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 3/3] riscv: store percpu offset into thread_info
To: bot+bpf-ci@kernel.org
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, 
	thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, 
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, 
	conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com, 
	seanwascoding@gmail.com, andybnac@gmail.com, menglong8.dong@gmail.com, 
	cyrilbur@tenstorrent.com, wangruikang@iscas.ac.cn, atishp@rivosinc.com, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn, 
	llvm@lists.linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi bot+bpf-ci,

On Thu, Jul 2, 2026 at 12:08=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.=
h
> > index e9e8ba83e632..137a49488325 100644
> > --- a/arch/riscv/include/asm/asm.h
> > +++ b/arch/riscv/include/asm/asm.h
> > @@ -91,11 +91,7 @@
> >
> >  #ifdef CONFIG_SMP
> >  .macro asm_per_cpu dst sym tmp
> > -     lw    \tmp, TASK_TI_CPU_NUM(tp)
> > -     slli  \tmp, \tmp, RISCV_LGPTR
> > -     la    \dst, __per_cpu_offset
> > -     add   \dst, \dst, \tmp
> > -     REG_L \tmp, 0(\dst)
> > +     REG_L \tmp, TASK_TI_PCPU_OFFSET(tp)
> >       la    \dst, \sym
> >       add   \dst, \dst, \tmp
> >  .endm
>
> This isn't a bug, but asm_per_cpu was the only reader of TASK_TI_CPU_NUM,
> and it now loads TASK_TI_PCPU_OFFSET(tp) instead.
>
> > diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-of=
fsets.c
> > index af827448a609..fbf53b66b0e0 100644
> > --- a/arch/riscv/kernel/asm-offsets.c
> > +++ b/arch/riscv/kernel/asm-offsets.c
> > @@ -38,6 +38,7 @@ void asm_offsets(void)
> >       OFFSET(TASK_THREAD_SUM, task_struct, thread.sum);
> >
> >       OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
> > +     OFFSET(TASK_TI_PCPU_OFFSET, task_struct, thread_info.pcpu_offset)=
;
> >       OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_co=
unt);
> >       OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
> >       OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>
> A tree-wide search now finds TASK_TI_CPU_NUM only at its definition in
> asm_offsets():
>
>         OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>
> with no remaining users (TASK_TI_CPU is a separate symbol still reference=
d
> by entry.S).  Could this OFFSET() line be dropped as well?

 Thanks, will fix in v8.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/285624=
50933

Thanks,
Yunhui
