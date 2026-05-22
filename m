Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E303624D7
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475875; cv=pass; b=Mt+n+8LYOgSBqkHc8ucCi6inWvvWunH7yHRmzeKFGuob/mWKV69wt+9dO22MTcg/YH0Kf9JOgG6Cze8WbtvEN8DlwumZYioz8erLMHcXTsGtULX+SdApuMAZ12SmhcXxmDg8VPHq4F52YpCJ1gf5vIyfd1neUQHBBO1XowCBriw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475875; c=relaxed/simple;
	bh=JaBGoCYwezsnixmOukVsH8GgD/tq9XpRuZEs8+Wy6SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5IcZAfgKYo2kgAcBXOEa7njcfR1ChnJNMzLydFoutOcohjCLR02kTVhc5EKJNTK76NxOh/lWxsi0EshdCPINqlJp1NE1qjVpA4G7ZoLIdfMGmIGvY9Q6bzEDsQK4Okc3TNBxSuGmLQ/T5RID6AvKmRWNTAEnKzA08e31kwLvn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWDbvOch; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWDbvOch"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-369002b26f4so4376942a91.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779475873; cv=none;
        d=google.com; s=arc-20240605;
        b=iCjkk4X7RbTfcoJUEPrTKZvmGc/a6MPrughkg4F7CSMVNiqg/XhJXqTZLfH3F2qMFX
         hLn/ReT3o4C0NDHf2M5p8L+Qh1MS0jaCFj7CRYvHR1apVYbj8MLNlV2AqHaiBMkPdkze
         I9/qymq9fiD9LwA1fvVS06K7lNqPdXGNPWxq1qpdrMWRO0qXzXzGDeGiXkDDZxE1JA0/
         v0n00qESEKV005LyPvr6i2NeUK4PiOw+QzBdxA41O59vGc1wosKjSNzqKfLrkPetwQat
         oVv0TqUkp594g9t/9ZjyMdd6jcXoamuHVeJeLV0UEAcwOFtrW7kqn27kOYu2SD1CzqkY
         lqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6G6i+Fkjhl2lN9eRmaouZpm4AkLpzjfLxsFAm90rP9g=;
        fh=bA7AStxkEA9q2MAINPGi2HY7vmlasLQjSWBNXgydJok=;
        b=eKniT+lfc/s1NYZUxIgXhkN0fe4y7QOY3BazI2GWPHHoHe2hVPi7Si2xdrC+I6tKyy
         3FzrVzOQCwCuIuZ+Bh/bo5BAWLmhOX2GDFeUwxM08ud32sj4X0V7eCmLGxHlxhSPr6ro
         QssS05ls5vhmtlyAUIazsz8y0B/mFmEAW7tQEOjtLQyJIHxXFqhggnOdhE/gEdwelKSg
         5kKfwj00AOF8lcikMOJToV/F/m292e6Q5+84d4tqw006qkwPelAqD+gCERn30JGsZtWi
         ISIyrMU7mUHyBMMFBe6URQeieiZI6CMe0z3WvOLjPzO0sqOMYlfHaDiMGNI/mhxV1bcN
         cFlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475873; x=1780080673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G6i+Fkjhl2lN9eRmaouZpm4AkLpzjfLxsFAm90rP9g=;
        b=OWDbvOch7Gs3mWr4iaRpuL3Dnaf8z7dPMJvFW+pwnNjOdhqJQLb8uXrTU1sHLWTW+1
         pEhId2A9M5uP0KIaTkQnEVmlzSt23I/QELYq/MObxOBR6XvAuAKSZQQQvijYRcnlmMB6
         P3bBCdRuweIIonroBXb2rghws9rdPNjX/xJbR50HIHuVGD2qBtlw9K7XrJSDXHR+Dj3n
         VTQtmSl1+FjvsWDZ1scDMMcromGEnkwXA/EpybfW+KkzmY8BtcQEIo4zIhMwrUBrETbl
         tUn0K6EBGWGgLZL23lGO5/1wcCUy3MqfzKPElIf4jmrqhPj6mnk4DFgNqYD3UVhJnr3T
         2GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475873; x=1780080673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6G6i+Fkjhl2lN9eRmaouZpm4AkLpzjfLxsFAm90rP9g=;
        b=gjKHF5k2tXg+kDqAMSgT/5anf59KIJLx3BI4Q30Tq21xY8a9o6ZKqDj+Xq/Soes+4y
         YfgKfaGYyIyQZDdrocNZKax8H/CfLoiD2aqfUL4QfZs6l9R7KMMY03zCIUnmHDGjAg/H
         QT7F56n3Ldpv+4LkOPkxwnvQ1iwk5rFzjJv48q3zy9vqX43MIko5yXAWlE+bJlfOGS9d
         gjgXNOR4MWh6BBoiVNHGP0UajZNyh4XpdwH24UYPxVrq4kKoi6NW+DqN5Wt9Fv7g04Mp
         x6imju1gTaZYg0verC1esxP9+cKfVa4TTTBxM410B+Jd8oPE1ykQZdls6jtl08/C7gum
         XhxA==
X-Forwarded-Encrypted: i=1; AFNElJ+nyXlxPR5oMHJELa8LWNHDnRU7pZkgsiqTvyHvDumDSc5rkVaaE8+kDdf5TKy8sj08KjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkA+zrhC19xFz5xy/vFfZNV6EL6wvTkBybwITk836ApH1T4V4P
	6ptRxUMvMwzyXoe4g/vLapXpzRQoQy1f2BS6z+NH69HrEhUXp/aLGi1pUaZTtcIEX4BwmXatJUK
	HVMeidkrmTlRrKofto4Mo063UcE2B4CA=
X-Gm-Gg: Acq92OHwss2MTBvkTvczQA8GUejb9Fq6NPr8mKua9vENiIJO/E5vgkE+T+MaX9uCd1V
	dWHDEkpPW28DpTxkTVBml0KMo/sB2A7fo1IBhaLkzzNMRO9yCWyPL0XTmZNa4C6ii9y7/ReAzKZ
	G07ww+l8P1JmYiCWBLPquVC3ZSYxmnlGFLvuocQFpVZdDUtOuM9nQrZyg5tuI9AjlY6SlWTyR4U
	csShkOYf9r9MrCmq6vetnBC+RuA5MN4jgbkK+E+L54NAE+nUM55HKUbI9e9NfR6XLHH0Cbe4ybS
	+nZa/ZxQN4gzTRuUejDCHm0=
X-Received: by 2002:a17:90a:d886:b0:36a:4074:9aa6 with SMTP id
 98e67ed59e1d1-36a676f061fmr4828318a91.6.1779475873188; Fri, 22 May 2026
 11:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-4-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:50:54 -0700
X-Gm-Features: AVHnY4JGBKgO-D9rh-r2mLuvpt2Gi6GNwx6KmQza1ziCp-WvOj25OuoFjc-AZSo
Message-ID: <CAEf4BzYo-8PAXFJt9MHoUn9ux1O2YVxJADC0tGSsacVu_R8Stw@mail.gmail.com>
Subject: Re: [PATCHv3 03/12] uprobes/x86: Allow to copy uprobe trampolines on fork
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:44=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> When we do fork or clone without CLONE_VM the new process won't
> have uprobe trampoline vma objects and at the same time it will
> have optimized code calling that trampoline and crash.
>
> Fixing this by allowing vma uprobe trampoline objects to be copied
> on fork to the new process.
>
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 6824376e253d..11ec6b89b135 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -701,7 +701,7 @@ static struct vm_area_struct *get_uprobe_trampoline(u=
nsigned long vaddr)
>                 return ERR_PTR(vaddr);
>
>         return _install_special_mapping(current->mm, vaddr, PAGE_SIZE,
> -                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
DONTCOPY|VM_IO,
> +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
IO,

so on fork we'll get sys_uprobe invocations which will go into uprobe
trampoline and syscall will just keep returning -EPROTO, is that
right?

what would happen in the similar situation for process with int3
uprobe being forked/cloned? Will it inherit int3 as well, and then
will keep hitting interrupts that would just do nothing?

is there a way to restore original memory page for clones? this
behavior (unless I'm misunderstanding) seems suboptimal
performance-wise

>                                 &tramp_mapping);
>  }

>
> --
> 2.53.0
>
