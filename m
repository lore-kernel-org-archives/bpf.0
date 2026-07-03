Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8173B2FD8
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083260; cv=none; b=Mjz5FNYFl9t5YJ4OtVa+p+nHiTGW0qMTUX35ToxA/d/hvNH0WHv7QKgkb2oR3xzIznAgKWE6R7Ex6EDMkv+xLNX1fsNYsCrVOvYL6MHaDOF3eeWAyyH5nClrWi29WSdk0thvckH5dX2v3tuo18tpZAH+VOIhJXV3o4aRZawblNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083260; c=relaxed/simple;
	bh=uqGZwy2bKlDXwy2jVhl36f0qmPXX0hv7kk/8RotZ/yA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BY6R4rrRAuRdCkN2Ci46IDz+LgCGW0mV/SXovr5Nvi6RExm0rt0oA1INTdEEVJT4BJxuQ2HdkJoh8uXBANkarvxWc1WYSoMGPj+Btu/utwH0InVL4l2j56KRysIIiV2WfrUMG26LHdBlO/+JKPZNNbbiYWLdfpqj4azfttIrRfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duz7a4Bc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duz7a4Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573231F000E9;
	Fri,  3 Jul 2026 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783083258;
	bh=TWE+Y0CPhYP/4rukQPBGRLIHyNQYPzfSXBEDvxQEbZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=duz7a4Bc0ZpyyZBVyXGt4jZ/TH2G0VFP/RdrrO4I6i/kPpYiGwmo3Kr032I1kTQVS
	 dD5AT4g6PrjiLOGGAnATJlUriAUODE3ctE4fQCu0SX+cDaE8frEmZATK0B/IOr1+PP
	 spCIuI3AfPfF2RepyWtp+Z6fjXY2MbzDeMN05leJtAyuixmJBmVwObmqsnaw4b2NQk
	 S0pNDKaBZljDRcxFonlE+L5HiLO0u4wy9M7JNXegsg6yRHPiAd3ED7CzNjSNXFoh4w
	 /xTd2zBudccZanU5kd7h6cA4Lzgzx4dMqKX2hs92eiFzvKbV1QKWdYT1SV6crpxiCf
	 TeUjPUa4EGDOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] riscv: store percpu offset into thread_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260703122832.15984-4-cuiyunhui@bytedance.com>
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
 <20260703122832.15984-4-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:54:17 +0000
Message-Id: <20260703125418.573231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing initialization of `pcpu_offset` in `arch_cpuhp_kick_ap_ali=
ve` causes secondary CPUs to use the boot CPU's per-cpu data during early b=
oot, leading to memory corruption.
--

commit cfb659978a0a1c24330d1d94b1f3e36871d66657
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv: store percpu offset into thread_info
   =20
RISC-V percpu addressing currently derives the base offset from the CPU
number and __per_cpu_offset[]. Cache the current CPU percpu offset in
thread_info so percpu accesses can load it directly. Keep the cached value
up to date for the boot CPU, context switches and secondary CPU bringup.

Link: https://lists.riscv.org/g/tech-privileged/topic/risc_v_tech_arch_revi=
ew/113437553?page=3D2

> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index f6ef57930b50a..7876854d16279 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c

[ ... ]

> @@ -191,6 +191,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *ti=
dle)
>  {
>  	int ret;
>  	tidle->thread_info.cpu =3D cpu;
> +	tidle->thread_info.pcpu_offset =3D per_cpu_offset(cpu);
> =20

[Severity: High]
Does this code also need to update arch_cpuhp_kick_ap_alive() for the
CONFIG_HOTPLUG_PARALLEL case?

If CONFIG_HOTPLUG_PARALLEL is enabled, secondary CPUs are booted via
arch_cpuhp_kick_ap_alive() instead of __cpu_up(). Because the idle thread
is forked from init_task, it inherits CPU 0's pcpu_offset.

Without initializing tidle->thread_info.pcpu_offset in
arch_cpuhp_kick_ap_alive(), the secondary CPU will start executing with
CPU 0's per-cpu offset.

Any per-cpu access before __my_cpu_offset is explicitly re-initialized
in smp_callin() will concurrently modify CPU 0's per-cpu state without
locking, which could lead to memory corruption.

>  	ret =3D start_secondary_cpu(cpu, tidle);
>  	if (!ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703122832.1598=
4-1-cuiyunhui@bytedance.com?part=3D3
