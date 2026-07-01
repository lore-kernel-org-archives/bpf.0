Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E347AF68
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905552; cv=none; b=SVOhMyMUDVIvz9SuouYNnEV9CU5CPFsICt4MVhJHAQDzM9KvybWdUbCKxkK4hFhx2HDm7uSnC29wuNdnN0R0ahyWBRZ5G8U88450zT36H5TWTsaaORbMMEW0pLBuMK658/75ztx1GVY9Q4UASl6GcJTxFbszSFO0VPTI+MSlAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905552; c=relaxed/simple;
	bh=PD1txDY2R4+3SIG/X6X2ViL7065a3RkSWezwzKt5uus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r0ppozpEELzfX4rPeAuJDLRZefPbleY+8u7caBPTyGK08+adQyhuPjYrBK+zKkfRPRCTCwimToJdUck6pBKqBAQqhRQ8ZN+6GJMQ5blO8l1VhyMuO0fVYZWtdiuRGKvO51DUfreGmEaev13mlrfbQNQo30ic+iout82UetBZmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHB4dgNF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHB4dgNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F258E1F000E9;
	Wed,  1 Jul 2026 11:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782905551;
	bh=Co+EklIqaQueAD+HJu8eP5eQ1uRjkRkuUgqZn4FEz8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YHB4dgNFGbmQuH2cXVnuEJIN4f3K8XzWK8gQ9+l6qOeyJ1R4Ixjsk4gEFwsL6A2nI
	 CRDw+A6tZKbFye2EB1MeFiszYS94njvs16yFU3q1gSrf9M2yhW4e649MKVW8TcAOVL
	 sfGQerjEdptJ4yjlDRqZARbvWNcD4oEBURSEmZlT5cdm0Ep56Ug1iAbVkyxOg3TPXh
	 Nq6FLanPosSmHicFCgZWkO/M1pSADKX4eR4CRXlUbsEMe8Z4HCCozlWwCpq5xMJDVE
	 t/fYTwA09A/c38gXTQBjbUwv+MFbSQWuoVkCJiv6n2/lx+ImnfPYjN/qtvWO6wZZQ9
	 ZuyhsSFyEWprg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 01/13] uprobes/x86: Use proper mm_struct in
 __in_uprobe_trampoline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701111337.53943-2-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
 <20260701111337.53943-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:32:30 +0000
Message-Id: <20260701113230.F258E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing vma_start_write() before modifying page tables under mmap_=
write_lock() in uprobe modification paths.
--

commit e98c98f0853de23f35b1d0253c941b8b823e5967
Author: Jiri Olsa <jolsa@kernel.org>

uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline

This commit updates the unregister path to pass the correct mm_struct to
__in_uprobe_trampoline instead of relying on current->mm. It adds the
mm_struct argument and updates related callers to provide the proper
pointer in the tracer context.

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 7be8e361ca55b..c5bb040488b35 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing
issue in the uprobes subsystem regarding the per-VMA locks.

Does the uprobe registration and optimization path race with concurrent
per-VMA lock readers?

In arch_uprobe_optimize(), the code takes the mmap_write_lock but doesn't
call vma_start_write() on the target VMA:

arch/x86/kernel/uprobes.c:arch_uprobe_optimize() {
        ...
        mmap_write_lock(mm);
        ...
        if (__arch_uprobe_optimize(auprobe, mm, vaddr))
        ...
}

A similar sequence happens in register_for_each_vma():

kernel/events/uprobes.c:register_for_each_vma() {
        ...
        mmap_write_lock(mm);
        if (check_stable_address_space(mm))
                goto unlock;

        vma =3D find_vma(mm, info->vaddr);
        ...
        err =3D install_breakpoint(uprobe, vma, info->vaddr);
        ...
}

Both of these paths eventually call down to __uprobe_write(), which
modifies the page tables directly:

kernel/events/uprobes.c:__uprobe_write() {
        ...
        fw->pte =3D ptep_clear_flush(vma, vaddr, fw->ptep);
        ...
}

Since mmap_write_lock() alone does not drain existing per-VMA read lock
holders (its sequence counter only prevents new acquisitions), could this
cause a race where concurrent paths executing under the per-VMA lock
(like page faults or MADV_DONTNEED) read stale page table state while
__uprobe_write() clears and flushes the PTEs?=20

Should these paths call vma_start_write() to safely drain the per-VMA
readers before making page table modifications?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701111337.5394=
3-2-jolsa@kernel.org?part=3D1
