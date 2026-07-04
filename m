Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099921EDA32
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783125303; cv=none; b=VV+0llOwJu7Tq6Uk3Ywj4Wsl7B3DEokbufs+chAbQ5BsIRPOhv8h2gG5fLUAgTZzPuRij3QcV6ujjw6bC/o5V8OELGuM5nKx7kqMzNrRdfS4nrXK1HAwB2Ko98Szkvo2WydKddREzqY2SbwixhXbjbtOgnPXN542H2ukhZra5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783125303; c=relaxed/simple;
	bh=GqDamSSNlxKO7QjljpHve5LA9dwBxNcfbMiZD//8q/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JCAc7HK4Pe6/n8xMa0sFllVKoPRBrAPsQjxgroSj+dLBKFPXZ1U4rYqvtDI1Gqy+LbJSUyF2S3wA4dYhxQcKsmv/UkhOAOQJeonPWiAsQe/BGHlB8tSzYzc7T3GODPaS9pLRJw0s5nahYJoLTNU36TK3WLz7lmDSRLMt9AbaHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlzmSUK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlzmSUK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7692A1F000E9;
	Sat,  4 Jul 2026 00:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783125301;
	bh=lWlrDhoa4AP+qbeq8mYa68KgcIT638OSV7GRZck9v54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YlzmSUK4cfXHtiO8adS7iJErwNM2PrZkRV54pFO5W8mji1npnaFot1IpQYxQwt1/f
	 2Ll5o8xi/hIxEp57lRSQAgYgGa2QjxKURFoNOO2250sOclNvRDcUT+E1G/brYRDERA
	 Ppna646rK8J8EmETAe3HovSGEr/ty9Q6LKJ2woZTjZE0bcTSrhbDh05peDKSFmrSlo
	 oVu1lwbtJdMhsV2ibyzZwGxxdNJKIt+nw6eYSCWbSKtsmPaXZirQWjaWDiXioPvI9N
	 8713xgF1k93jMBGEB3Dn+yTqjM7RAxsqprnpW4O24aIWkufZvTPL/d+NnzOi120X/B
	 gY5dVyN/jzt5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/5] x86/cpu: Don't reset boot CPU cpuinfo in
 identify_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260704002046.3859585-6-ihor.solodrai@linux.dev>
References: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
 <20260704002046.3859585-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 00:35:00 +0000
Message-Id: <20260704003501.7692A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch deliberately leaves 32-bit systems vulnerable to the exa=
ct same interrupt window race condition that it fixes for 64-bit systems.
--

commit 7225f9ebac0ba182d1da83ea9f37319d7bdecfdb
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

x86/cpu: Don't reset boot CPU cpuinfo in identify_cpu()

This patch moves the init_cpu_info() call out of identify_cpu() into its
callers and skips it for the boot CPU on 64-bit systems. This prevents a wi=
ndow
where interrupts can observe cleared CPU capabilities. 32-bit systems still
reset capabilities in identify_boot_cpu() to maintain the no-CPUID default.

Link: https://lore.kernel.org/bpf/20260610175651.647515-1-ihor.solodrai@lin=
ux.dev/

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 93ad02ceacc24..01d07b1f30788 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c

[ ... ]

> @@ -2156,6 +2154,13 @@ static void identify_cpu_32(struct cpuinfo_x86 *c)
> =20
>  static __init void identify_boot_cpu(void)
>  {
> +	/*
> +	 * The boot CPU's capabilities were already scanned in early_identify_c=
pu().
> +	 * However 32-bit still needs to init_cpu_info() here for the no-CPUID
> +	 * cpuid_level default.
> +	 */
> +	if (IS_ENABLED(CONFIG_X86_32))
> +		init_cpu_info(&boot_cpu_data);

[Severity: High]
This is a pre-existing issue, but does leaving the call to init_cpu_info() =
here
leave 32-bit systems vulnerable to the exact same interrupt window race con=
dition
that this patch fixes for 64-bit?

Because start_kernel() calls local_irq_enable() before arch_cpu_finalize_in=
it()
calls identify_boot_cpu(), an interrupt can fire immediately after
init_cpu_info() clears the capabilities:

arch/x86/kernel/cpu/common.c:init_cpu_info() {
    ...
    memset(&c->x86_capability, 0, sizeof(c->x86_capability));
    ...
}

If a timer tick or other hardware interrupt fires right after this memset,
and the interrupt handler dynamically evaluates boot_cpu_has(), won't it
falsely observe missing capabilities and potentially cause a crash or
incorrect behavior during boot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704002046.3859=
585-1-ihor.solodrai@linux.dev?part=3D5
