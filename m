Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E8175A60
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968665; cv=none; b=jMN9OmX3KqP/sJ93yRsBvYQvbL9OlPyoMk50uzIBEaEgVVhJvQfa4YjK/NYeLaGTlem+iCtYP4nRMM/z9RKpw0xmzVAKCnD+oCAepzkMEI0aS/jlXK3iz2o5WtJNioHhMLk1fRER/LBFhVmcFS6d4dzojY44z5SMHhJcxqsuaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968665; c=relaxed/simple;
	bh=tvgIu9SQCqFBNvVQPIVYoBq/CIhmAcgMw3wTJDM5FVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KDuTOuKZEt3loSQ/oRnmCYLQ1pGdLbAIShgLUneuUI9g0Ko5cYbhwpXnd8yGuMiptQhvOWQ4jIUFEKq4W5swHzKsdPkVGQiUMpkJZH+8UCP69lXoEHInN0nZPv2VF/ktuuLMCr3AfOIcnNr15fP1QOtFql+/Se0IrH6ZRWyfvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O44wjTQf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O44wjTQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC7AC2BCB4;
	Tue,  5 May 2026 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777968664;
	bh=tvgIu9SQCqFBNvVQPIVYoBq/CIhmAcgMw3wTJDM5FVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=O44wjTQfbouloQLro0IAbDdt8A2dcGLajbZL90neFyx/9cacmOet804jTahF5XXDZ
	 TzVCVL1Dw13Eossykmnp0eGRcn5+vVcP05/vsz3nHzkQ92KrFZ18C22/890jpzX5L6
	 xuqG40KKy15v5dqqQ4gY4pGxPD+NEElCaMR/7pbFdmXqmd4gz8UXhLrNhOyHlqzmRm
	 OEvFmajOB9G8a9MRK/HGsJWedwjDTRq2fcgcs3X2EtVRbtnMk8yN5iIrnoknK4p9e5
	 9fDTALwLS3AUh2HZzV6kElFG+otEyJqf2aZ44vrNg8CsAcwAgW/EqLPOBnOPSItu2p
	 pz3aGwlR+vj/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] riscv: store percpu offset into thread_info
Reply-To: sashiko@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505062026.91724-4-cuiyunhui@bytedance.com>
References: <20260505062026.91724-4-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 08:11:04 +0000
Message-Id: <20260505081104.AFC7AC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Secondary CPUs run with the boot CPU's `pcpu_offset` during early =
boot, leading to concurrent lockless access to per-CPU data.
--

commit 9630a483e2d689234bf576230edd1da2035ea88b
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv: store percpu offset into thread_info

This commit moves the percpu offset calculation to be directly stored in
and retrieved from the thread_info structure. This speeds up percpu variable
reads and writes by reducing the number of access instructions.

Link: https://lists.riscv.org/g/tech-privileged/topic/risc_v_tech_arch_revi=
ew/113437553?page=3D2

> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index d85916a3660c3..9e95c068b966b 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c

[ ... ]

> @@ -234,6 +239,8 @@ asmlinkage __visible void smp_callin(void)
>  	mmgrab(mm);
>  	current->active_mm =3D mm;
> =20
> +	__my_cpu_offset =3D per_cpu_offset(smp_processor_id());
> +

Could this lead to concurrent lockless access to the boot CPU's per-CPU
data during early boot of secondary CPUs?

When the idle task for a secondary CPU is created via fork_idle(), it
copies the parent's task_struct and thread_info. As a result, the new
idle task inherits the parent's (the boot CPU's) pcpu_offset.

When the secondary CPU boots, it sets the tp register to this idle task
and begins executing C code without going through switch_to(). This
means any per-CPU access prior to the reassignment here in smp_callin()
will incorrectly access the boot CPU's per-CPU area.

Before this patch, __my_cpu_offset resolved dynamically using
thread_info->cpu, which was already correctly initialized on the boot
CPU via __set_task_cpu(), ensuring safe early access.

Now, for example, ftrace/kprobe hooks on function prologues, lockdep
checks, or mmgrab() itself could trigger a per-CPU access before this
assignment, leading to data races and potential memory corruption.

Would it be safer to initialize task_thread_info(tidle)->pcpu_offset =3D
per_cpu_offset(cpu) from the boot CPU in __cpu_up() prior to starting
the secondary CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505062026.9172=
4-1-cuiyunhui@bytedance.com?part=3D3
