Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720C26E165;
	Tue, 23 Jun 2026 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236979; cv=none; b=BSNI8LLJrTO5AmLS0aVhPrcUabvQi3HrL5/ZJdqglHIUu5/cu0U9+5JiRUfEwUsi/dpRPbr9I4fg9o3OPCFU9KVZayYBPZ3nUXhwKRyI9wzfpaQbRY0i+mnkQEneuR9BLMN0KsfLDqwU7CINGziCfyCuhLHOgRIhoYPFKTVUKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236979; c=relaxed/simple;
	bh=g2y4wjRL+EF21fcYYfF51xqYTu/Iw6eL3J9ytA02wPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aTjCQnVFdKH8hMyIEVEZ0P3Scc4oJuHQLnTqW5TDrBaQ+k7B020XLE2XkMsHHaesY5MJXAGKA1teSpodrkl/wa56b8TfWeSZAxwVxfLIQnnTf7CRTQ+xd3Utey4duTZaxcn47RYJzl08PKaoErco0eq3+ZciAIGzE6FzbEkEVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyjKrXQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyjKrXQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F1F1F000E9;
	Tue, 23 Jun 2026 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236977;
	bh=m0BlYAjC4y1xPTA0tggkdt/va89eyWJsjZJi6vyGLCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iyjKrXQZotKQolK8ZFZPA2mVInwY/OyV9jqypSLnkN4Cc7k8ncklFkgfatnOxy7Mb
	 Pbn+Pbgwt0Bvj4LMGDCgKjVxnX7XyCJ77Z7E8yx0qst0cGM+aowQ8XT/wipJnPFrhs
	 pbmk5ll95WYd6EBDG6bn8cCrmMe/NOvCivDrqazNUIf5gxMcelCZb8fVx2S8P4QdAz
	 IEolODBnVoNbBoGO/d005u8DZY+tCC5SKPvDzk0QD7t3ZHiPM1NDTWr5a6JZjcyOTq
	 H5kmS9GgBGHQizQSHpNRu4jFNS61tM6eJi7l7GA7EMsBeRJSz0pvG9asYVtxyFqQwB
	 UvXe6Ru6o1Wow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/12] x86/vmscape: Deploy BHB clearing mitigation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260622-vmscape-bhb-v12-10-76cbda0ae3e5@linux.intel.com>
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-10-76cbda0ae3e5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:49:37 +0000
Message-Id: <20260623174937.A2F1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] VMSCAPE mitigation downgrades from IBPB to BHB clear without verif=
ying eIBRS is active, leaving host userspace vulnerable to BTB injection.
- [High] The BHB clearing sequence `clear_bhb_loop_nofence` lacks a specula=
tion barrier (LFENCE), allowing speculative bypass of the BHI mitigation.
--

commit 23a617eeb2c65912ce9fd14bc20dacfa19110ed4
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

x86/vmscape: Deploy BHB clearing mitigation
   =20
IBPB mitigation for VMSCAPE is an overkill on CPUs that are only affected
by the BHI variant of VMSCAPE. On such CPUs, eIBRS already provides
indirect branch isolation between guest and host userspace. However, branch
history from guest may also influence the indirect branches in host
userspace. To mitigate the BHI aspect, use the BHB clearing sequence.

> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/e=
ntry-common.h
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
[ ... ]
> @@ -84,6 +84,10 @@ static inline void arch_exit_to_user_mode_prepare(stru=
ct pt_regs *regs,
>  #endif
> =20
>  	if (unlikely(this_cpu_read(x86_predictor_flush_exit_to_user))) {
> +		/*
> +		 * Since the mitigation is for userspace, an explicit
> +		 * speculation barrier is not required after flush.
> +		 */
>  		static_call_cond(vmscape_predictor_flush)();

[Severity: High]
Does omitting the speculation barrier here allow the BHB clearing loop to be
speculatively bypassed?

Since SYSRET, IRET, and SWAPGS do not serialize the processor, it appears an
attacker could poison the branch predictor to predict an early exit from the
BHB clearing loop itself.

If the CPU speculatively bypasses the loop, wouldn't it speculatively
execute host userspace indirect branches with the guest's poisoned branch
history buffer still intact?

[ ... ]
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
[ ... ]
> @@ -3114,7 +3117,17 @@ static void __init vmscape_select_mitigation(void)
>  		break;
> =20
>  	case VMSCAPE_MITIGATION_AUTO:
> -		if (boot_cpu_has(X86_FEATURE_IBPB))
> +		/*
> +		 * CPUs with BHI_CTRL(ADL and newer) can avoid the IBPB and use
> +		 * BHB clear sequence. These CPUs are only vulnerable to the BHI
> +		 * variant of the VMSCAPE attack, and thus they do not require a
> +		 * full predictor flush.
> +		 *
> +		 * Note, in 32-bit mode BHB clear sequence is not supported.
> +		 */
> +		if (boot_cpu_has(X86_FEATURE_BHI_CTRL) && IS_ENABLED(CONFIG_X86_64))
> +			vmscape_mitigation =3D VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER;

[Severity: High]
Should vmscape_select_mitigation() also verify that eIBRS is currently
active before making this downgrade?

The commit message mentions that eIBRS already provides indirect branch
isolation. However, if a system boots with vmscape=3Dauto and spectre_v2 is
set to retpoline or off, this logic changes the mitigation from
IBPB to BHB_CLEAR based solely on the BHI_CTRL hardware capability.

Without eIBRS enabled, would this leave host userspace vulnerable to
guest-to-host BTB injection (the non-BHI variant of VMSCAPE)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-vmscape-bh=
b-v12-0-76cbda0ae3e5@linux.intel.com?part=3D10
