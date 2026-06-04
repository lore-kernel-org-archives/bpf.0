Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D35E3C09F8
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554417; cv=none; b=i3whuNwIegn02GeikkssJ8MyQ5avfi4qJAQxEp8peWRw10W7Gk2ucrCL92gcR7tyluvcR0B6i0v0hwyDjqBHkT95wpjrPL8UZGi8LPGPTZQIL0jGzl4SM1pcuWUKdGyI+PQjcr0I7sZiStpRso3oxgGPrvjNfznqKk2rcD59ly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554417; c=relaxed/simple;
	bh=TlvkZXdGbj7XL+TvZrTGldEikuGASraGH9+3eY7n/qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kc4EaBvSK8EgvAvFY+5hsRpTdAyIr6Uii6wXpluw09DJNZqsP7rPy+u60+D3BcFnxVQhL8XteYduZ/PErg2g6BN1wB4QcSe6fTRILqEo5VdN0uncw4Mt344/8xbeptl99dDJ8bXMQX9FUdxgIE1sPXpRQeazO2Y9tSFEapxZxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH5OM0M0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH5OM0M0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82F91F00898
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 06:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780554415;
	bh=IVIfCPYFLkPnJSSr4b1JAXayttg+yDdWuao24uaOeic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AH5OM0M0+BjDmmU3rGE0aCH8BDZing8zkjlwovG5kevTth448ql0LBiY94nv5Tx/6
	 vH2pAAZK6tzEgn59bgLJZoZprOVbXvEaBjMBE1sRfHNF2ZM9GWFjgXqG5TXPvm0JB7
	 h5xklW3wn30YYk4/FRJ3Sf+FRZDMz1CSbGL3L+Br7fF7s38jiB/b/Bcd/CI9gMmSfH
	 mQwZXHPCB4vqBC34TlhjPlKCWvuAXG+oHWoICF7SQ+1vAkc9LzIQX2c0cxwfNRnIoA
	 C5DwhMVJkl0t5PeF1n1UgBM9z1zB4xGyiJlHFFIKB70gcRf9VChCBRirx+ce35YAYp
	 76RZO6rGd02fQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bed4f2f0898so40788966b.3
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 23:26:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+qy5HTuDiEM3clMJ9EUvM4tNkce6Sdm9v4erJlecTWyxl6uDgDcf6cgED76WZZZ89GscA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvfc2vZ3FncrAydwWexma3kKtUfFaRehjS1150rkiY5I6/HJ6C
	sSQhs2iswy+C1xZnJrV2GLRzh3DNuDfX/zCUAF3CedE0dd/7Z3/W0uikE02A0toZzh3nuwcF3cv
	9TzOf0EcMi/BGll7CSm6n9NLdWyztMj0=
X-Received: by 2002:a17:907:2716:b0:bcb:8b03:9fc2 with SMTP id
 a640c23a62f3a-bf0b16d642bmr255594566b.15.1780554414604; Wed, 03 Jun 2026
 23:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428072021.7289-1-yangtiezhu@loongson.cn> <20260428072021.7289-2-yangtiezhu@loongson.cn>
 <CAAhV-H5tLpXtnMJOx=b5MCDY71jMNkQ5pv1YhgCf72FV=ewcxg@mail.gmail.com>
 <0def4127-3850-1114-d576-42748456f400@loongson.cn> <CAAhV-H51mJpbYjQJYo_a_8mWuG9CSbvbvQNHrpV1G3jmp0Vkaw@mail.gmail.com>
 <9fe9a1f4-bdd0-d6b4-6b76-269e4ffdbc7e@loongson.cn>
In-Reply-To: <9fe9a1f4-bdd0-d6b4-6b76-269e4ffdbc7e@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Jun 2026 14:26:40 +0800
X-Gmail-Original-Message-ID: <CAAhV-H76bD-bsw_btJuxw7sciQn8o5AwXEuQ7+rT-jBX6dHZjA@mail.gmail.com>
X-Gm-Features: AVHnY4Kz8XPnCkuAy8bb6qeD8yFUrGs9RADllEaDvBRnS_sBUnnSAXn54Mx2Tzc
Message-ID: <CAAhV-H76bD-bsw_btJuxw7sciQn8o5AwXEuQ7+rT-jBX6dHZjA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:26=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2026/6/3 =E4=B8=8B=E5=8D=8810:24, Huacai Chen wrote:
> > On Wed, Jun 3, 2026 at 10:30=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
>
> ...
>
> >> For static structures like init_task, any uninitialized fields are
> >> automatically zeroed out by the compiler according to the C standard.
> >> Stripping away dozens of lines of ".field =3D 0" complies with modern
> >> Linux kernel code-cleaning standards. It makes the macro much shorter
> >> and highlights the only field that actually requires a special
> >> runtime value (the kernel stack top in .reg03).
> > I know it is the same for compilers, I mean the current way gives more
> > information for humans.
> >
> > In addition, without reg02, this piece completely has no relationship
> > with CONFIG_THREAD_INFO_IN_TASK, so please drop it.
>
> Do you mean keep the original INIT_THREAD as is? No any changes for it?
> ".reg03 =3D (unsigned long)&init_stack + sizeof(init_stack)," is not
> necessary?
>
> That is to say, do not modify arch/loongarch/include/asm/processor.h?
Yes.

>
> >> For reference, please see how INIT_THREAD is defined in other major
> >> architectures, where they only initialize what is strictly necessary:
>
> ...
>
> > None of these commits remove current_pt_regs. Some of them has no
> > current_pt_regs before THREAD_INFO_IN_TASK, and ARM32 still has its
> > own implementations in arch/arm/include/asm/ptrace.h now which is
> > nearly the same as LoongArch.
>
> If you think it should keep current_pt_regs() as is, I am OK, will do
> it in the next version.
>
> That is to say, do not modify arch/loongarch/include/asm/ptrace.h?
Yes.

>
> >>>>    /* Helpers for working with the user stack pointer */
>
> ...
>
> > set_current() is a very good friend of get_current(). Though "$tp" is
> > enough for get_current(), from the x86 implementation we know that it
> > can also get from the per-cpu array (but suboptimal).
> >
> > Move set_current() to current.h also don't need to include
> > <linux/percpu.h> and <linux/sched.h>, it only need to forwarding
> > declare "task_struct" and include <asm/percpu.h>, which is exactly
> > done in the x86 implementation.
> >
> > And you needn't worry about the compiling, I have tested before I comme=
nt.
>
> If you think this is proper, I am OK.
>
> Replace __entry_task with current_task (x86) or cpu_tasks (uml)?
> Replace entry_task_switch() with set_current()? or something else?
It seems you want to avoid "current", then please use "cpu_tasks"
rather than "current_task", but "set_current" is a friend of
"get_current", just use it.



Huacai

> It seems a little strange for the following code in smp.c:
>
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 4b74409a98a3..3afdeca7bc2a 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -665,7 +665,7 @@ asmlinkage void start_secondary(void)
>          set_my_cpu_offset(per_cpu_offset(cpu));
>
>          cpu_probe();
> -       entry_task_switch(current);
> +       set_current(current);
>          constant_clockevent_init();
>          loongson_init_secondary();
>
> Thanks,
> Tiezhu
>
