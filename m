Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15003019CB
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958646; cv=pass; b=BupmAoA0tcAvmuVj7UyeirXQ3UFtqedjO9s2Z4CChabGZnQ5MdWCG25BU8K1AfMQ/7zb/39WQbSvHSFr4mmPyijwwflsHfpLIsV5IrTA4Z5YlqcbqS1FTTIDMwd9J9dIrZSL+/D7z0tbtaLMT4qGQ3amCVvp/CizqeJZE9t8k9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958646; c=relaxed/simple;
	bh=EIWzZ5jX2cohcG2lxevNFzEcN0fEaLcLGIGxMCA3c5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYvp4vFe/fPL5pkTy57oYRVYhE+4QuzuMoxlT2v8pjtWH/1rjQfEID7tGYxNO6Gi8P3ZRGfmj593iG32ctsf7vgpUS4cqEmhcXBII2orKHHgxeQsDVU9w4m+XgnTtmlumHGfP3TACiNZU/AnMSbKFhGgu5hzUGNs+fHsax998K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG6Dxcbh; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG6Dxcbh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso455525a91.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:24:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768958644; cv=none;
        d=google.com; s=arc-20240605;
        b=KxqXqvuIgSWJygMh9K+nFxTiuFxxYrrGElmiFuRjHHvfHsQBmSVitIrKv25Ukt1UEZ
         nWx18v7hMIzB3dXujFnhiyFAqHSjaVfEv67uI4euxnAsmfEfpWcaHNNZI75nZypjGf8M
         x3vkQpuhvgoinAtZnRlyMfDo4jdBWTFKLcoksp0ln92/D6C9CwmQtgZO6vjWN0n/rEVe
         2h/JhF8hnaqEq7qklAVdbQwT3At8W/6N96FrdNUT9lvQofX5l7SOu8KL30L99VRrNiVz
         SyfnASzxZ5Zr8AtM8CdhpRwFzzhnoVCMoGA9IXVxCQx78bjTwOOz03KbVSJ68BReFCv6
         QtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UmBrHYTJV6y7h6t7FL2AXk+XsrZAdnAaWIQHj3E6LrQ=;
        fh=ZmbKjH47xw3auXO0GfMpRRDM5osqaip8G+SjBEZs1z4=;
        b=jIpEf0r1FhPUdDpNYWDtrEfqafvnrWsXyP3r2NSD3xmppyD42sTU+rcgNtvHb/uUtE
         2LjdUrxc31WBYIpX5YMP7wbk+ly+pJTGgUALysUlKbfKD9b97q59qyMFJ70HlJddqhla
         L+qUu5cXVhutG+5ZOaGeKqQzdYYrs53SNKtrxZR3e1+xX/p4LMwrbAIwa5L4vqp2EoAj
         4EGEjRP06d3ZpekZO72M/Y1UJ3oXG33XvtKqqPszQpYVIoYSm2xarSL7cwzM8wdKI6iv
         aAnYVJQ5ptrXMoGEBEKmTGkQkR3Me6iDswnk3JyOsWNGLP90l6coG4Sl2D6F/qnVVIPb
         qo3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768958644; x=1769563444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmBrHYTJV6y7h6t7FL2AXk+XsrZAdnAaWIQHj3E6LrQ=;
        b=OG6DxcbhYTktLo6ucznajK4LFiWJBUqreLVpV4aMqU8f+A/snutBJWMdYSj1gxlYiv
         JkwJR3/XVKHHAdpSn12bBWC9vs+7ngvcCxm7b0EnANe1MUx8L1u1u2PiMttwaInCaXij
         GcU6FGOB2qRaTfr4429VxDEE2Xlmab8BGnZQTIwRI/u1wqCwMNIFR+MpH53vCETWX4wb
         jxNUDoEl8T5iY32q202y3e60noLnAfdwzsZ3wYxzX2iDbvxYo+pit5bZH57IJdADrmrC
         aZxxjbKv7UGTyzdRwkJGesYCkCIb96+qeM0KVGYsXweQyAUHTIqLSxsn9ll5WdaW2Lgx
         RTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768958644; x=1769563444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmBrHYTJV6y7h6t7FL2AXk+XsrZAdnAaWIQHj3E6LrQ=;
        b=KSMP07ynjTxWP4JzDUzRgIb6cSjH36aEmoBrpEn+b6+atGFPV3fkcUrQnQeVS2DKMN
         ytzvXK4/g2m03ImKfwgbsdM4yxFs0V3gukdiVowPIf7zPjyDC/mol9EcE4OJOZdcPUtD
         bTHvy+O621p5ttsy3UKJ+L1xfaTD2tE2E87VnarCeHBC/Uj0FTKeaTfp1a0dso/ykXbZ
         paP+1NowjLr3NXiGqagw72FDfj3k2k4yo8th1GyTliMpMJ4pMf7yR9lqyHg63x8fHEjw
         rr1H9xiVdDM3xfRDAsdpQBmcG0jm5uY8rQGfwT135M/ABFq5CuFzI99wxjXM3ic9hDLu
         bU+g==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6YihAwv/OakRdTj4DlZowbQ7h/m2xpi7eBeEq7UAbjA2wCjgXC3tnYr/epv3TBsoVb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtL1oDP2ojOgj+8R7euV79VRd/CgJVV7thr96EcuLz6/iDxB5
	QdVDmebaeDuPYiSu01rxpesOTT4t248FOdjH84X+g+KYRMmiuOXah7DWsF7rz0xAiu3tOTG3RsU
	KvF86C5anfed56jy/1hicIwZA7oZRdBU=
X-Gm-Gg: AZuq6aKhO37Q54rfbuWFxZb6G08eMO2CW0Wx0JOrWBGkQ2U4Y+zAjoVmWqYdTvHmhcV
	OZMNS7nabHPFr8hMuQLrEH6Lc+et7hHZCLuVyW+Z5R46wXryo8/vdfjQ91bWM+VvD8qRLwOVfxm
	68FrbVXYahJF7iduyOisreEp08CrYW9svpMuFKu8aJ4b0cSwo4Wq0nzEKdBdHmNT91S1+Gg0soI
	zkB1z+P8tJ7cMdKX1DegYbnAAZpnSwvFUizbxV/khS9HKr++gEpYMSNLdMC/8VtDCOwgqcSWQQ/
	2d/0LsYDBQs=
X-Received: by 2002:a17:90a:d44d:b0:34a:b8fc:f1d1 with SMTP id
 98e67ed59e1d1-352c4047fa0mr3551606a91.24.1768958644182; Tue, 20 Jan 2026
 17:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn> <20260120070555.233486-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260120070555.233486-2-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 17:23:51 -0800
X-Gm-Features: AZwV_QgFmLgMGRrdAreJF-3TXb4tPle_8L1zaJFMbiizqknDQChynGxGQ7niugo
Message-ID: <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
> v5:
> - don't support the !CONFIG_SMP case
>
> v4:
> - handle the !CONFIG_SMP case
>
> v3:
> - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
>   x86_64 JIT.
> ---
>  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9de0ec0c3ed9..c4e2ffadfb1f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17739,6 +17739,10 @@ static bool verifier_inlines_helper_call(struct =
bpf_verifier_env *env, s32 imm)
>         switch (imm) {
>  #ifdef CONFIG_X86_64
>         case BPF_FUNC_get_smp_processor_id:
> +#ifdef CONFIG_SMP
> +       case BPF_FUNC_get_current_task_btf:
> +       case BPF_FUNC_get_current_task:
> +#endif

Does this have to be x86-64 specific inlining? With verifier inlining
and per_cpu instruction support it should theoretically work across
all architectures that do support per-cpu instruction, no?

Eduard pointed out [0] to me for why we have that x86-64 specific
check. But looking at do_misc_fixups(), we have that early
bpf_jit_inlines_helper_call(insn->imm)) check, so if some JIT has more
performant inlining implementation, we will just do that.

So it seems like we can just drop all that x86-64 specific logic and
claim all three of these functions as inlinable, no?

And even more. We can drop rather confusing
verifier_inlines_helper_call() that duplicates the decision of which
helpers can be inlined or not, and have:

if (env->prog->jit_requested && bpf_jit_supports_percpu_insn() {
    switch (insn->imm) {
    case BPF_FUNC_get_smp_processor_id:
        ...
        break;
    case BPF_FUNC_get_current_task_btf:
    case BPF_FUNC_get_current_task_btf:
        ...
        break;
    default:
}

And the decision about inlining will live in one place.

Or am I missing some complications?

And with all that, should we mark get_current_task and
get_current_task_btf as __bpf_fastcall?


  [0] https://lore.kernel.org/all/20240722233844.1406874-4-eddyz87@gmail.co=
m/

>                 return env->prog->jit_requested && bpf_jit_supports_percp=
u_insn();
>  #endif
>         default:
> @@ -23319,6 +23323,24 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         insn      =3D new_prog->insnsi + i + delta;
>                         goto next_insn;
>                 }
> +
> +               /* Implement bpf_get_current_task() and bpf_get_current_t=
ask_btf() inline. */
> +               if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn->=
imm =3D=3D BPF_FUNC_get_current_task_btf) &&
> +                   verifier_inlines_helper_call(env, insn->imm)) {
> +                       insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(un=
signed long)&current_task);
> +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_0, 0);
> +                       cnt =3D 3;
> +
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    +=3D cnt - 1;
> +                       env->prog =3D prog =3D new_prog;
> +                       insn      =3D new_prog->insnsi + i + delta;
> +                       goto next_insn;
> +               }
>  #endif
>                 /* Implement bpf_get_func_arg inline. */
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
> --
> 2.52.0
>
