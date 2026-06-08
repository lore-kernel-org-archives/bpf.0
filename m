Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6832C937
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916010; cv=none; b=awB8s2z5Ee/Z/5opVTedeqejSALW465UhfRBjejqgwreEKd4pmCAHjQCMB93u1n9fOZ7Y6EJdTSN3PqQi/pJ7SS3FK7lwpNHWFdHnaXPwTPTmaRpC6kQnTtqGkvKZWFpUxjWWStFPkd90aZpYrfSoxd42j3XPW9Lc4sYmYakJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916010; c=relaxed/simple;
	bh=pCwTjSCT/9GFTK+HEiTidCCaftIxG+xQ45L57KEF4vk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sTUoctwz7p7Ec5iseLOONpm1yB/Qxh7cgTTUe2Mpu6uBC/V76AI2iNQRhDQwvcPBiUqaAMVDTzwfC4bBsmYIaMYy3tHu7xJ/9BMAOQTbDHpVOqdFAaRzz2D0Pt5Alx7YC24QQBH5hm1WV3Eht9vIxHaDGtJDnibpb42V+dE6SVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS46jPXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS46jPXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610981F00893;
	Mon,  8 Jun 2026 10:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780916009;
	bh=4NSngJuDniZ4szW5vHGDmPnPy0Wq8AfgpqVDGtP8kAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hS46jPXlnsM9Nlv9OHijeV/6ns9ncuUlCqVu1cBLjwa5h1sJDHN30UqlChMA9am2e
	 pKPFyqbRXy7FMlcFRgmj0vkjL2xvRLYs/U957z0uOh+TZ9TfOvnb6HbZvLx9WnKmIR
	 SfL9UX8aFk5hNV7qfwbOJDip9T/X/ErHU7fdl3QiVXPyyeK57qKgvFTXklXJbn/VKH
	 tHrNvG5dy8AMLhyaJuijfs4YJBVnHbkzXXIPZylrUu3fXgqz5BrLtbg8aX1dgBJrn7
	 LvUN4k8JksAHZPwXsxIWEV8qLbm2HSPkFqpTDltVGEPymUREIxanjYWL48qEN+wKGS
	 M45q6q48t9pow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608103516.20643-2-yangtiezhu@loongson.cn>
References: <20260608103516.20643-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 10:53:28 +0000
Message-Id: <20260608105329.610981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] On 32-bit LoongArch builds, `__switch_to` incorrectly leaks a =
biased `task_struct` pointer into the `$tp` register, corrupting the `curre=
nt` pointer and causing immediate kernel panics in subsequent C code execut=
ion.
--

commit a9c9267b3c429867d4c30c28e5fbb4f25cae8346
Author: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK

This commit selects THREAD_INFO_IN_TASK for LoongArch, moving thread_info
off the stack into task_struct. It introduces the cpu_tasks per-CPU variable
and updates the $tp register to point to task_struct directly, decoupling
it from the stack pointer.

> diff --git a/arch/loongarch/include/asm/current.h b/arch/loongarch/includ=
e/asm/current.h
> new file mode 100644
> --- /dev/null
> +++ b/arch/loongarch/include/asm/current.h
> @@ -0,0 +1,30 @@
[ ... ]
> +register struct task_struct *current_thread_pointer __asm__("$tp");
> +
> +static __always_inline struct task_struct *get_current(void)
> +{
> +	return current_thread_pointer;
> +}
> +
> +#define current get_current()

[ ... ]

> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switc=
h.S
> --- a/arch/loongarch/kernel/switch.S
> +++ b/arch/loongarch/kernel/switch.S
[ ... ]
> @@ -33,11 +33,12 @@ SYM_FUNC_START(__switch_to)
>  	LONG_SPTR	t8, t7, 0
>  #endif
> =20
> -	move	tp, a2
> +	move	tp, a1

[Severity: Critical]
Does this leave a biased task_struct pointer in the $tp register on 32-bit
builds?

Since the current macro is now directly mapped to $tp in
arch/loongarch/include/asm/current.h:

register struct task_struct *current_thread_pointer __asm__("$tp");
#define current get_current()

If a1 (next) has TASK_STRUCT_OFFSET added to it to bypass assembly immediate
offset limitations on 32-bit builds, this move instruction places that bias=
ed
pointer into $tp without unbiasing it before returning.

When __switch_to() returns to C code, wouldn't evaluating the current macro
dereference a pointer shifted by TASK_STRUCT_OFFSET (2000 bytes on 32-bit)
and cause immediate memory corruption or kernel panics during context switc=
h?

>  	cpu_restore_nonscratch a1
> =20
> -	li.w		t0, _THREAD_SIZE
> -	PTR_ADD		t0, t0, tp
> +	LONG_LPTR	t0, tp, (TASK_STACK - TASK_STRUCT_OFFSET)
> +	PTR_LI		t1, _THREAD_SIZE
> +	PTR_ADD		t0, t0, t1
>  	set_saved_sp	t0, t1, t2
> =20
>  	LONG_LPTR	t1, a1, (THREAD_CSRPRMD - TASK_STRUCT_OFFSET)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608103516.2064=
3-1-yangtiezhu@loongson.cn?part=3D1
