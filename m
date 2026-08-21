Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88D381EAA
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336483; cv=pass; b=ERCNgp8V5dBoIvaNpz4RUGPEOfw4PPnIdIs31PtYi4XYbtNmgVcDvL9XOEv+I8R562VFO1Nsg/UQWEeLF8RT7UmG/u88EdN8bHQav3OZ/Codu7JtH2uEHIeKLj3BS4wD+dU0QKM/xt5K66sZYHUFXXOOoiMaxGoBpA1tsNn+RPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336483; c=relaxed/simple;
	bh=rLm4c6qWrB8VARmDkI8hA7qZfJuXosVGkLjFJHXnw7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6jA2sYxLGkdqmgIDPY4Hx2hVPI4UPJsre13sh4wfNBL1xK3HUD1fuiQ+SM8IaDmJoDciu4tVMkBr6RSP3f6lT7/Xx+oQkgXMMYL8s1rT9QS9PTPKYV6ft9mbqbLd+tWOCFvzUF7DhBe5s5isyy7j474iO85z11s77RDLhyAJoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHXqcGS6; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHXqcGS6"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso942143a12.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 11:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787336481; cv=none;
        d=google.com; s=arc-20260327;
        b=FBiLpINLGZUpfsGKGhIAI0NLMahNQx56lKqE3gglHdFgKG0rGx4cGwMjVevfoBGMoa
         Wa/LniB0kvPRcTRQ2Cqc7RdrKNSihY+ch01xpgKVNiCUT15gvDdVNQdRA8dg4FL7oGTk
         JqILa/3DHenEN2JA3xSrr1Rx/C20nJ3rnuQm4QVz7LOZGEJBt23axoaoW4kyOLO5IGfK
         91eWvRR4DZikhLHqSW2kg5Uwltnj3298JeP0v+4bHU5SFN6tAVAMTpZIMqZltkVZ4jN6
         y/acvqNjPVveuTghof+0fmkrlhWT9pir4vtuRw4H2CL6SrOXrDMZ4gQeNYuP78KwvdVG
         TG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y4pm4Efnph1LwJVw44Q2KkGS5TChGFX2Q9mvZxnSIAQ=;
        fh=YOhelolkHlW6baIBh2jAHZkKty18GQjkvaLeNidi2C4=;
        b=ZhjfouCvtfLpMgfLzWr3h8j4Heu7o5AijUVe/pvkl4sujXn/CPz7HksPfcl4R3Zde7
         qFT4uuY44rglFIFWY9LmKtgHL74eMa9vk1aw6JV/QrlshZJjXP4QVokZ1royGErlTb7q
         CogJg6KLSoZD2jFdc/HGGpnZVTrLdn8v9bk6j/ezJkk3eg4MyI3owkbY9SIyx7MF4pKh
         f9yay/75b67PA+YW2YqpFJGpEBNtfdmuEYEbw1YlTFu0dFaOdL5IWQmiHrEX9sLWh4CD
         BPLO2GuZ40r5e6BzmgKKekz27nus0NOzXWZ5Mnvopyv+hiE/rCKDhsCEDi9UsLrtNnL3
         ePFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787336481; x=1787941281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4pm4Efnph1LwJVw44Q2KkGS5TChGFX2Q9mvZxnSIAQ=;
        b=bHXqcGS6FL2FnV7K7+ZQqgTtojYk9cOnCsEbcYQjm2tmigxiPB9f1lTdL3EIIBjOux
         IqkFJgE0EGdHmJAeMCc7P0B579auNu12O4ymcXn1+Bt//aJAhZ8QHE6x0H7qDuzAivj+
         1dR/sferrZL6EFOHb7UTULe4FN5yaTYg4BvLvgHpSF6+5fDpSR+MTFr44bjWtpRjEeUi
         5iBPL9lEQ7lSdpOqk2aNHmK3S3KuBpMlgRoLurAU2f2G7EEFjiwyKjyVEwM2l915WEK7
         kkBou+V2XWTGF1hLsHVE7SpufX7NskSHBjlji1Ke8CmA+JriEMo5HO2kjXwt6b2wu9aG
         eaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787336481; x=1787941281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4pm4Efnph1LwJVw44Q2KkGS5TChGFX2Q9mvZxnSIAQ=;
        b=LIvTO5Hb5XtSCrwhDdtSIbunlnnxzMLJxZ3DU0dgnE8jMFEuCB/9bWyW00xzZR6gGK
         5tFTEXXbSR9cbSM5xARix+22ZUe6KPneaDteiR9NrppC0btIavNwZN1vKU7BGkoaLWSD
         Yaj6phNF1Cu5zWgynQeeudAzeDyey0qXBmq1Tem0E4pQFODHu9C2paPxtIk9MJfzD4FD
         nAmV2hIFz6w8BcBGCO4kxx2sX/OtAWSFzGjC18lU5+uSH5R9HeJsMEuydlE/li15dAxz
         OwcMNYqToeyqvrrYyjOQndx3TGRZ+Fxs8l5FGpuig+Pb6369J/HswbYKeMm5OVGxdjEj
         B7tQ==
X-Gm-Message-State: AFuF++kfRtQwLkPO3boNE1jOyWNgv8Y8/XpAUyEvzq6TsNDmHHyRKMCx
	dq1N/Pmr3LvuIxpQZP7WJKAW8z7UlNMWlYqlGC0OGpQAluuDq+kTlHRfoUk++/nsp9ax6/CTMCz
	Ev8dsdYhrttUljwLsDl3d7fu+HHhBaGs=
X-Gm-Gg: AR+sD10frWqc7IX2DdE8/tDBBWkDMzz5q2rlSfPSkk9pmiPUYDZxKdhjd2jv16WUBSY
	0Sp/CuNn2hCvIs9i6XGxwHvXNHvzgbjbDp7ZFRE5c8SNQMK8Ss9+9kp/OVXiE6Jr6UcIdUjABNO
	3LqiMn5dLubJZlm5+6KvPZ+TFfB4VkoAu+UTDwFUQhRYDKG4VE6N9f4NHgyDWKuXJKn57Cn5gar
	7nSrz8Q6um9J6r4XlKFIpE5RDLB+iMLMUEEoox+NAJba1AS1Qlt/ty3vN5H8b7rRQPXdby4KLv4
	DkGWO3MiJzGPJEtq/SFbzTP8/mRzymoENas1hlmu5IY/qwt1hsxytVIgS7PL/2nWj/3IJQNOiNi
	Lrfwt7IFNoIYA4/OSjFnBVG9pDQ==
X-Received: by 2002:a05:6a21:3b89:b0:3c3:7a0a:18a6 with SMTP id
 adf61e73a8af0-3cd4bca353cmr1338253637.18.1787336481571; Fri, 21 Aug 2026
 11:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819124324.43162-1-adi.sharma@zohomail.in>
In-Reply-To: <20260819124324.43162-1-adi.sharma@zohomail.in>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 11:21:09 -0700
X-Gm-Features: AcwNN1WDmxyrzCmTLnKIj2iYAKI5fmDjGKmx62pcNxBl-puTKL1PVvJkVxPoAnQ
Message-ID: <CAEf4BzZY6uWdobXVyS1WrdtmRw_SLJsodm7d_c+Bhsw=chpJ+A@mail.gmail.com>
Subject: Re: bpf: Is the nmi_uaccess_okay() check needed for bpf_send_signal_task()?
To: Aditya Sharma <adi.sharma@zohomail.in>, yonghong.song@linux.dev
Cc: bpf@vger.kernel.org, song@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, puranjay@kernel.org, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 5:44=E2=80=AFAM Aditya Sharma <adi.sharma@zohomail.=
in> wrote:
>
> Hi,
>
> I hit this from a bpf_timer callback that signals a userspace task: the
> signal was not delivered some of the time. It turned out that
> bpf_send_signal_task() was returning -EPERM depending on which task the
> softirq happened to interrupt, and the source is this check in
> bpf_send_signal_common():
>
> bpf_trace.c:872:        if (unlikely(task->flags & (PF_KTHREAD | PF_EXITI=
NG)))
> bpf_trace.c:873:                return -EPERM;
> bpf_trace.c:874:        if (unlikely(!nmi_uaccess_okay()))
> bpf_trace.c:875:                return -EPERM;
>
> Is the nmi_uaccess_okay() check necessary in the bpf_send_signal_task()
> case?
>
> When commit 6280cf7 ("bpf: Implement bpf_send_signal_task() kfunc")
> made the function take a task, the PF_KTHREAD and is_global_init()
> started testing task, while nmi_uaccess_okay() kept testing current.

Yeah, this is weird, at the very least it should be checking it for
the provided task. But I also am not sure why we have to check this...

Yonghong, do you remember why this was necessary? Can we just drop this?

>
> As far as I can tell the path here does no user memory access, so
> there is nothing for the check to guard.
>
> Also, it compiles to true outside x86 (include/asm-generic/tlb.h:26),
> so if it were necessary here the kfunc would be broken on every other
> architecture.
>
> Thus, whether a signal can be sent depends on the caller's context,
> rather than the task it is to be sent to. And at the bpf_timer callback,
> we never know deterministically whether the signal would go through,
> or it would get rejected here.
>
> A quick reproducibility test by Claude Opus 5 (the issue I was facing
> from the timer callback context was not reproducible deterministically):
>
> SEC("tp_btf/workqueue_execute_start")   /* current is a kworker   */
> SEC("tp_btf/sys_enter")                 /* current is a user task */
>
> static __always_inline int probe(void)
> {
> struct task_struct *t;
> int ret;
>
> t =3D bpf_task_from_pid(target_pid);
> if (!t)
>   return -ESRCH;
> /* sig =3D=3D 0: permission check only, nothing is delivered */
> ret =3D bpf_send_signal_task(t, 0, PIDTYPE_TGID, 0);
> bpf_task_release(t);
> return ret;
> }
>
> On bpf-next commit f79066c7 (selftests/bpf: Add tests for a store
> on a fault prone qdisc pointer), x86_64 under qemu:
>
> bpf_send_signal_task() from kworker context : -1  (-EPERM)
> bpf_send_signal_task() from syscall context :  0
>
> Same result on v6.18.29, x86_64, bare metal.
>
> I may be missing the reason for it to be there as well. If this check
> is intentional, what is it protecting in the _task case?
>
> Thanks,
> Aditya Sharma
