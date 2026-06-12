Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6737FF50
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227786; cv=none; b=Y+s4QhXALkS8UPBqLbpoGggSgpoWEsMKJin+zuSR19m1PP02xyX/XUz3Yz9C8OrJCRCi9B2YjAOCjInqlc9z3SoGawk3qNgpBi3ERBjiwku6/ZKC6cm6p48hRZVW8V1RHQzDSXIxxJiXGV6M7WrEoBVv4tInGB6INe2/fHQ4BvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227786; c=relaxed/simple;
	bh=pjRcid3h2CVqWiNDjjmW6uNQ9Wlu1Eh2AKWTaKpGEx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rcKOuDzGBpWIGD+JrnC9TtSkrL8vQEu7wUx0PdDthR7CUFHnjy3k7kqXE5HBmOqwngyZ80XhXFhixlEoSdTcRo8pjl4TkLGXGT92RA7MCBV67zCGdAIZhRKYX/v8wBNwyk9YWxmWO56oT+vDVOaPdFO4PtQvKtocgn6QHpZOL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLiVpVl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLiVpVl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB951F000E9;
	Fri, 12 Jun 2026 01:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781227785;
	bh=aIyGHboZOsW4oEd57vk+1+NOepV8U1ECGTSH8zGhGgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLiVpVl6KlKOjsgdWcz9S+tzVL4Pr8l8KyYxDQi0Z2qaqhA72X7VsKGyDQIoHGQQ8
	 0QY1tc+IEiILhUXBpTsADbSA+crDrPQB2wL6NHqcy5C9K/m8JrSFV6yXK+Cl7B8RLv
	 Rcxm01Cx+yz9paJiR2QI+PfnRLlQ1nEklkjE+YXmL4l1ovywHhZ0uchyEmTyiNyjls
	 LhRfOigqaZ0LgIR2q5Rdf4flrw9Rk5LwhoKbmWVGsqFIdS2WSpIzykSCgbqJjqXyp7
	 BIpyDftayT661f8+Ie6CznNMGHd0U3vjJsnA0KI4DBsXifBUdJcUM/FsD5O/TFfZCV
	 Ko1lz7gVHlvWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612011616.27771-2-yangtiezhu@loongson.cn>
References: <20260612011616.27771-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:29:44 +0000
Message-Id: <20260612012945.1CB951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Temporary biased `$tp` on 32-bit LoongArch causes infinite recursi=
ve faults during panic/exceptions, breaking stack traces and debuggability.
--

commit 031d5abd58aa95ea089ae24763bb03c5e684dbc3
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK

Select THREAD_INFO_IN_TASK for LoongArch to move thread_info off the
stack into task_struct. This updates the thread pointer recovery path
and context switch logic to adapt to the new layout.

> In the context of __switch_to(), local interrupts are disabled, and the
> kernel is in a critical switching phase where handling any synchronous
> exception is practically impossible and prohibited.
>
> If any synchronous exception or watchpoint does trigger in this narrow
> window, it constitutes a fatal double fault and the kernel is expected
> to die/panic immediately anyway. Therefore, the temporary biased value
> in $tp is safe and acceptable here.

[Severity: High]
Could this temporary biased value in $tp on 32-bit kernels prevent the
system from printing the expected panic trace and instead cause an
infinite recursive fault?

If an exception like a hardware watchpoint, NMI watchdog, or machine
check triggers in this window, the unwinder calls show_stacktrace(),
which defaults to current:

arch/loongarch/kernel/traps.c:show_stacktrace() {
        if (!task)
                task =3D current;

        if (!try_get_task_stack(task))
                return;
...

Because current is derived from $tp, and $tp is offset by 2000 bytes
(TASK_STRUCT_OFFSET), accessing the task stack refcount inside
try_get_task_stack() will trigger a page fault.

The page fault handler then calls die(), which calls show_stacktrace()
again. This creates an infinite recursive fault and stack overflow
without printing the intended panic trace.

> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switc=
h.S
> index f377d8f5c51a6..d6e0d05d6fd39 100644
> --- a/arch/loongarch/kernel/switch.S
> +++ b/arch/loongarch/kernel/switch.S
[ ... ]
> @@ -33,11 +33,12 @@ SYM_FUNC_START(__switch_to)
>  	LONG_SPTR	t8, t7, 0
>  #endif
> =20
> -	move	tp, a2
> +	move		tp, a1
>  	cpu_restore_nonscratch a1

[Severity: High]
Is there an alternative way to handle the structural pointer bias for
32-bit kernels without temporarily storing an invalid pointer in $tp,
so that panic handling and debuggability remain intact?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612011616.2777=
1-1-yangtiezhu@loongson.cn?part=3D1
