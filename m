Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B47F42048
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777081232; cv=none; b=tZlVgIsoIyJa2xB2+phLDCZgUd838rkHoasMQTmBzuArBl1hUlq9kuOpWtJtOD31w4QfOV7RSFAAwW9eJAkLnO6ca6ARDEdVwqy0mH7NKteFPSGTIZVLBr0Zbd0ABOmeYz3+BEU3dRwHCgHeyKug9V1R+XYx4xeTbQ2sjPuVZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777081232; c=relaxed/simple;
	bh=ySe/cgb21F6lTXYHNrj0wRvlJG87yBn5QC0rsiAeLPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BiOlNJBLBqlCB0rxg99TsiKOqPy1wfZkXSUrR7o8QrBCk/0cX6rvOB2LQatc1IXkFJvmCDN/EPrv9lTUrY0memtxvST59lKjxjaa0TKqK8gqHz1mm86HER6ymUhYtXx75thi/8NaDNaRhScCi3ADR88AXHfw0wtZGL9de4uyvgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk2N3DV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk2N3DV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A058EC19425;
	Sat, 25 Apr 2026 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777081231;
	bh=ySe/cgb21F6lTXYHNrj0wRvlJG87yBn5QC0rsiAeLPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nk2N3DV4g78V4KvXrrRe+hiYr3n8KAnAubjoqPzXwYxPiSOB4Lg0wOeyh1y+MFejM
	 MhvKcBWddJabipUYIyDwNHemGUQBGuw8134BKMD2V5rz0xvHAt6keHmoeh2Szb9gep
	 xUfzG+9ys+DY5orcK3bWqSLkYKdoo9Owh6Yc1zmPAn2p5V4BwsvJuBOg87J5H3xATL
	 w8Ba04Lr9wyvBfU/woRVh5cQW4vcrMMRS0RluIUx1V3NeQAJbinzPRd6EEIgVStCE4
	 XExVKxuUll4Zbz0lqu5dCb4MGjIdVRYk0ssJdMqVJY7WuVqiP8NKvnOe/X7gqJob9C
	 5IVbcNm/p0eXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/12] x86/vmscape: Use static_call() for predictor
 flush
Reply-To: sashiko@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260422-vmscape-bhb-v11-9-b18e0cf32af4@linux.intel.com>
References: <20260422-vmscape-bhb-v11-9-b18e0cf32af4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 01:40:30 +0000
Message-Id: <20260425014031.A058EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Performance regressions in highly sensitive fast paths due to repl=
aced zero-overhead checks.
- [Low] Missing `<linux/static_call.h>` header inclusion in `arch/x86/inclu=
de/asm/entry-common.h`.
- [Low] Out-of-sync tools ABI header.
--

commit e665a60c1a2370dfaa4dba80cd6f14bfe1c7e97b
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

x86/vmscape: Use static_call() for predictor flush

This commit replaces the flag-based mitigation selector for VMSCAPE with a
static_call to the mitigation function. This avoids adding multiple checks
for different mitigation options at exit-to-userspace.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
[ ... ]
> @@ -503,7 +503,7 @@
>  #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to T=
SA-SQ */
>  #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to T=
SA-L1 */
>  #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers usi=
ng VERW before VMRUN */
> -#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-=
userspace, see VMSCAPE bug */
> +/* Free */
>  #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring =
Counters */

This isn't a bug, but freeing the feature flag here without updating
tools/arch/x86/include/asm/cpufeatures.h might trigger ABI header sync
warnings during tools builds. Is a follow-up planned for the tools header?

> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/e=
ntry-common.h
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -4,6 +4,7 @@
> =20
>  #include <linux/randomize_kstack.h>
>  #include <linux/user-return-notifier.h>
> +#include <linux/static_call_types.h>

Does this code need to include linux/static_call.h directly?

Using static_call_cond below relies on the macro definition from
linux/static_call.h. Depending on transitive includes might lead to
implicit function declaration or macro expansion errors.

[ ... ]
> @@ -94,10 +95,8 @@ static inline void arch_exit_to_user_mode_prepare(stru=
ct pt_regs *regs,
>  	 */
>  	choose_random_kstack_offset(rdtsc());
> =20
> -	/* Avoid unnecessary reads of 'x86_predictor_flush_exit_to_user' */
> -	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER) &&
> -	    this_cpu_read(x86_predictor_flush_exit_to_user)) {
> -		write_ibpb();
> +	if (unlikely(this_cpu_read(x86_predictor_flush_exit_to_user))) {
> +		static_call_cond(vmscape_predictor_flush)();
>  		this_cpu_write(x86_predictor_flush_exit_to_user, false);
>  	}
>  }

Does removing the alternative-patched cpu feature check introduce a
performance regression here?

By dropping the zero-overhead check, it appears an unconditional per-cpu
memory read is now evaluated on every exit to userspace. This seems to
reverse the explicitly documented optimization to avoid unnecessary reads.

Could a static key or static branch be used to maintain the zero-overhead
path when the mitigation is disabled?

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -11463,7 +11463,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	 * set for the CPU that actually ran the guest, and not the CPU that it
>  	 * may migrate to.
>  	 */
> -	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
> +	if (static_call_query(vmscape_predictor_flush))
>  		this_cpu_write(x86_predictor_flush_exit_to_user, true);
> =20
>  	/*

Will replacing the cpu feature check with static_call_query add overhead on
the KVM VM-exit fast path?

Looking at linux/static_call.h, static_call_query reads a global function
pointer.

Would it be better to use a static key here to avoid the memory read when
the mitigation is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422-vmscape-bh=
b-v11-0-b18e0cf32af4@linux.intel.com?part=3D9
