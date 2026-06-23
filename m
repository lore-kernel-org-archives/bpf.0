Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60DA38B150;
	Tue, 23 Jun 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236836; cv=none; b=ozg29KJRhRC4UUiekS62YjL5hOtgFWMGdbGed0acBXxQH6yO1/qNLNyESWrpYiFX3GIKHb0U+JDdjjud1zSTJvI3djVMO1aBDgVTiHKTvLp/XMCXZ3TQFxk8e4NmRWqE4lJfcq/VurtQBp93DAhwoK3Qiw6BHr14zRMVdhegnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236836; c=relaxed/simple;
	bh=luxajsNjZsUbxrGJGK2OJmkO9pmiwrgoF40lM0gV2p0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gcfOoagmN6y2Bm3+Zw2UKH/SGOVkgMIVLeB6PcMloeMDKDZEFFJ4Hmwvo9/XRj197wAWmtkbtbW4TvFbqlNA3gYkmlMZQyAejjK9EtS1fzhUbmzk7IUb+w0/WEb1jpg/aam6Avo3gAG+85LIyRZMB+iU8TTnzFViWXUDFWwacWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/2iA8mW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/2iA8mW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B501F000E9;
	Tue, 23 Jun 2026 17:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236835;
	bh=/V+SueDvc6LfehwgOUdNFUz8FmtvDhyvsKHe7e2pCUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/2iA8mWjkiKTw839AhMzkD6Y6oli8jlh0QCIEH9aEIoTrj44M3M4jZBCeqNZYzAt
	 5jvv7xNoG9yXBB1OgGREhGnchBhKz5gGaA+uN9vR1f7sDWUCInqDLx9eRijzkQU432
	 1o6XmC+aoRDJJmX7UI53KREATePYY7GGMI4CeeRYnl/KFQL0ualj6mxJ/WP7tpo81l
	 wy/F1QGqij3tW8NnTpjehpX6Hc0mx2JGPzLU9UULo6gQ99LDpK+axgaohAefsflltN
	 7JVDjRFT3s6g1b7hrh4XHwl4webAdnt12ZF2KaequZphFa0tZjERtmQcEUhAGRDqiX
	 9/9SSVJmkusSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 09/12] x86/vmscape: Use static_call() for predictor
 flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: kvm@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260622-vmscape-bhb-v12-9-76cbda0ae3e5@linux.intel.com>
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-9-76cbda0ae3e5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:47:14 +0000
Message-Id: <20260623174715.48B501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The patch introduces unconditional memory reads on the highly se=
nsitive kernel-to-user exit and KVM VM-enter fast paths, penalizing all sys=
tems where the VMSCAPE mitigation is disabled.
- [Low] The removal of `X86_FEATURE_IBPB_EXIT_TO_USER` from the kernel CPU =
features header was not mirrored to the corresponding tools header, causing=
 code drift.
- [Low] Usage of `static_call_cond()` without including `<linux/static_call=
.h>` makes the header non-self-contained.
--

commit 6813e9ba3f5da52dd0859a742860cd03837d50a7
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

x86/vmscape: Use static_call() for predictor flush

This patch replaces the flag-based mitigation selector for VMSCAPE with a
static_call() to the mitigating function. This avoids adding more feature
flags and multiple checks, freeing the X86_FEATURE_IBPB_EXIT_TO_USER flag.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 1d506e5d6f46a..09f956b72637c 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -504,7 +504,7 @@
>  #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to T=
SA-SQ */
>  #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to T=
SA-L1 */
>  #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers usi=
ng VERW before VMRUN */
> -#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-=
userspace, see VMSCAPE bug */
> +/* Free */

[Severity: Low]
Does this removal also need to be synced to the tools copy in
tools/arch/x86/include/asm/cpufeatures.h? Leaving them out of sync typically
triggers a 'Kernel ABI header differs' build warning when compiling tools
like perf.

[ ... ]

> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/e=
ntry-common.h
> index 3be6d4c356ed2..d5b390c76f000 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -4,6 +4,7 @@
> =20
>  #include <linux/randomize_kstack.h>
>  #include <linux/user-return-notifier.h>
> +#include <linux/static_call_types.h>

[Severity: Low]
Should this include <linux/static_call.h> instead? The static_call_cond()
macro is used below but isn't defined in static_call_types.h, which could
cause build failures if relying on implicit dependencies from downstream C
files.

> =20
>  #include <asm/nospec-branch.h>
>  #include <asm/io_bitmap.h>
> @@ -82,10 +83,8 @@ static inline void arch_exit_to_user_mode_prepare(stru=
ct pt_regs *regs,
>  	current_thread_info()->status &=3D ~(TS_COMPAT | TS_I386_REGS_POKED);
>  #endif
> =20
> -	/* Avoid unnecessary reads of 'x86_predictor_flush_exit_to_user' */
> -	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER) &&
> -	    this_cpu_read(x86_predictor_flush_exit_to_user)) {
> -		write_ibpb();
> +	if (unlikely(this_cpu_read(x86_predictor_flush_exit_to_user))) {

[Severity: Medium]
Will this unconditional per-CPU memory read add overhead on the kernel to
user exit fast path for unaffected CPUs? The previous cpu_feature_enabled()
check used alternative patching to compile out to zero instructions when the
mitigation was disabled.

> +		static_call_cond(vmscape_predictor_flush)();
>  		this_cpu_write(x86_predictor_flush_exit_to_user, false);
>  	}
>  }

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 721ff7667dc0b..fcd61c47653fa 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11556,7 +11556,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	 * set for the CPU that actually ran the guest, and not the CPU that it
>  	 * may migrate to.
>  	 */
> -	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
> +	if (static_call_query(vmscape_predictor_flush))

[Severity: Medium]
Does replacing cpu_feature_enabled() with static_call_query() penalize the
KVM VM-enter fast path for unaffected hosts by introducing an unconditional
global memory read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-vmscape-bh=
b-v12-0-76cbda0ae3e5@linux.intel.com?part=3D9
