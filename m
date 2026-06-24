Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EDC3AFCF4
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305963; cv=none; b=GrYw9gYYfXNTByLniF740xr8X2yFxhgm9z7qqNaTcNvIkYObXxgi7t7eJ6hueJmZbUFWDM+yYeOQ/0t0BmxkLQUCSjwCrKtQT/NFYwi8vHNpGrMvg+V478/7GzNcPFWKtH5EovnxYw3+7Z4vyEFP5bfYVk9vrkATUh3aTS57B1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305963; c=relaxed/simple;
	bh=KIjSj54IhmNbG/6muW0yzYkV0Zd2rYypz42VPKc1XXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2yhV49r4B4ifEytZft2ebVTwe1ufnToQeCAtoDh/73Bvc8H3gujPrmE65sigP+S18J9EqtGDUOfBu86uO/JDtl4UWmeadX0hl/byVQTSqE+7+g85ppbRat288DbqEviufrS+idxQ4wnWAgyK/84vKo8NuKRmZn2YobujhNk5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DITI9RO1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DITI9RO1"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c7edb8505dso3043895ad.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782305960; x=1782910760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9s2GS1cyGC2w26O6IYTgHnVJbBHockC5xshZabE2GCU=;
        b=DITI9RO1ohLs6PVBGwKckk6Qs+5b7K/i7c7F10WMyGksMPG+jt+W+tTVf1Hw4VeAJS
         iYaFlG6kPwRlhnKr8LDmgMwKDYDbSvdXXZ3+20s4BdlcZ8cBfsOxBOyBmNcRTiSaPyHk
         wEtDQyJDALz2o8bGMkLTVFF4dVG35T23d9o5G0rlGYvxqjp+F2LTZ6Q7/RfTMUz7vVWD
         Oppg1+BQjtw1ihDM4DiwvaaRw4iwNzr4IgPR82oiDPuH6cKKaIZ53oT3Mz8MDP9Nmyee
         bs3M+xzU4EkwgoK4RWu0TZyvpFkKNc4cSoEh7wwcXqiVGE/8pdpPLn02tShv/VoHwFuM
         BhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305960; x=1782910760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9s2GS1cyGC2w26O6IYTgHnVJbBHockC5xshZabE2GCU=;
        b=JWfhkPJOlDKe1SiSdfNrVOIg0bp3QAKKuIUzCC6HUkVEz/vovBc0rycxb0gmVJ+RML
         3KXP23OoaBKE9YMkuPcU5wwf0aA6oJju2NwOFo9RczTj2nmzaDgQPq1UOwaeVqxyCxVT
         gYNOVqxguz+CBe0FR8jy86WAZwVsMuy1TSVXUELRMDAvrNxDLxJvRXdJm4NLgvmgTnXp
         WVqBVJcrA4B1rmmeZjAcVBPlqORvemi2omt4If6OApIsDeBLB8oi+CkUeoWo1U0YVdGL
         d29xU+3ISLaAIe++DkUWOiIkEU0prthtmviykyDl81FhfcHGoBe3k78Xt/ouU+KrFOfi
         Aw8w==
X-Forwarded-Encrypted: i=1; AHgh+Rr382Rh0iZZJpnvxnyFLIB5J91ZJIyOepFqKojSJbKopmqvqY2e8G+wRkbMs3F2IHvscHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+ekdj63Paa4UfBDEu/VH4H1OV/UT18mI/9OMiAMwFJ7W1271
	HpEnKJmd8+5903SnvDekmy0/C3I2ru/G1Asls9ZQ1XJeQN3LNOlUH/4/Zjj5sg4l5p3JK1g6eIs
	7gGGYig==
X-Received: from plfn11.prod.google.com ([2002:a17:902:e54b:b0:2b6:417:db8d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4405:b0:2c7:f123:6fdd
 with SMTP id d9443c01a7336-2c7f1237016mr6810025ad.33.1782305959958; Wed, 24
 Jun 2026 05:59:19 -0700 (PDT)
Date: Wed, 24 Jun 2026 05:59:19 -0700
In-Reply-To: <20260622-vmscape-bhb-v12-7-76cbda0ae3e5@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com> <20260622-vmscape-bhb-v12-7-76cbda0ae3e5@linux.intel.com>
Message-ID: <ajvUp_kPJBRZ7k_p@google.com>
Subject: Re: [PATCH v12 07/12] static_call: Define EXPORT_STATIC_CALL_FOR_MODULES()
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	David Laight <david.laight.linux@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>, 
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: multipart/mixed; charset="UTF-8"; boundary="dnmNnJAO7OucAamW"


--dnmNnJAO7OucAamW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2026, Pawan Gupta wrote:
> There is EXPORT_STATIC_CALL_TRAMP() that hides the static key from all
> modules. But there is no equivalent of EXPORT_SYMBOL_FOR_MODULES() to
> restrict symbol visibility to only certain modules.
> 
> Add EXPORT_STATIC_CALL_FOR_MODULES(name, mods) that wraps both the key and
> the trampoline with EXPORT_SYMBOL_FOR_MODULES(), allowing only a limited
> set of modules to see and update the static key.
> 
> The immediate user is KVM, in the following commit.
> 
> checkpatch reported below warnings with this change that I believe don't
> apply in this case:
> 
>   include/linux/static_call.h:219: WARNING: Non-declarative macros with multiple statements should be enclosed in a do - while loop
>   include/linux/static_call.h:220: WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  include/linux/static_call.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index 78a77a4ae0ea..b610afd1ed55 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -216,6 +216,9 @@ extern long __static_call_return0(void);
>  #define EXPORT_STATIC_CALL_GPL(name)					\
>  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
>  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
> +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
>  
>  /* Leave the key unexported, so modules can't change static call targets: */
>  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> @@ -276,6 +279,9 @@ extern long __static_call_return0(void);
>  #define EXPORT_STATIC_CALL_GPL(name)					\
>  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
>  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
> +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
>  
>  /* Leave the key unexported, so modules can't change static call targets: */
>  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> @@ -346,6 +352,8 @@ static inline int static_call_text_reserved(void *start, void *end)
>  
>  #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
>  #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
> +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods)
>  
>  #endif /* CONFIG_HAVE_STATIC_CALL */

Drat, I forgot about this.  Exporting static call trampolines for KVM came up in
another conversation[*].  I had already put together patches to effectively default
to exporting only the trampoline, and also to deduplicate this code so that the
CONFIG_HAVE_STATIC_CALL_INLINE=y / CONFIG_HAVE_STATIC_CALL=y / CONFIG_HAVE_STATIC_CALL=n
implementations don't need to copy+paste the same lines of code.

The attached patches touch a lot more code, and will conflict mightily with KVM
changes I want to land in 7.3 (more use of a static_call in KVM).  But if we get
them applied (to tip tree) shortly after 7.2-rc1 and provide a topic branch/tag,
then there shouldn't be too much juggling needed?

If we want to go with the more aggressive cleanup, I'll formally post the patches.

[*] https://lore.kernel.org/all/ahhoDGUz39KSGZ6o@google.com

--dnmNnJAO7OucAamW
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-static_call-Add-stub-for-ARCH_ADD_TRAMP_KEY-if-not-p.patch

From 415eb214ed200ef82244468a0682ac884b14c051 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 May 2026 08:09:56 -0700
Subject: [PATCH 1/4] static_call: Add stub for ARCH_ADD_TRAMP_KEY if not
 provided by arch

Add a dummy #define for ARCH_ADD_TRAMP_KEY if one is not provided by arch
code so that EXPORT_STATIC_CALL_TRAMP{,_GPL} can be used in arch-neutral
code.

No functional change intended.

Fixes: 73f44fe19d35 ("static_call: Allow module use without exposing static_call_key")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/static_call.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 78a77a4ae0ea..7539c82dd35f 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -210,6 +210,10 @@ extern long __static_call_return0(void);
 
 #define static_call_cond(name)	(void)__static_call(name)
 
+#ifndef ARCH_ADD_TRAMP_KEY
+#define ARCH_ADD_TRAMP_KEY(name)
+#endif
+
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))

base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced
-- 
2.55.0.rc0.799.gd6f94ed593-goog


--dnmNnJAO7OucAamW
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0002-KVM-x86-Don-t-export-static-call-keys-to-vendor-modu.patch

From 0166d0df57a43f20a24f5b75a6c34929221c1f30 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 May 2026 07:01:36 -0700
Subject: [PATCH 2/4] KVM: x86: Don't export static call keys to vendor modules

Export only the trampoline, not the full trampoline+key, of KVM's static
calls that are also used by vendor modules, to harden KVM against unwanted
modifications of the static calls, i.e. to allow vendor code to invoke the
static call, but not redirect it.

Use static_call_mod() instead of the vanilla static_call(), which is
required by the objtool magic to glue things together when exporting only
the trampoline.

No functional change intended.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Closes: https://lore.kernel.org/all/20260528091357.GB343181@noisy.programming.kicks-ass.net
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/pmu.h              | 2 +-
 arch/x86/kvm/x86.c              | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index eee473717c0e..55d674c647e6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2061,7 +2061,7 @@ extern bool __read_mostly enable_ipiv;
 extern bool __read_mostly enable_device_posted_irqs;
 extern struct kvm_x86_ops kvm_x86_ops;
 
-#define kvm_x86_call(func) static_call(kvm_x86_##func)
+#define kvm_x86_call(func) static_call_mod(kvm_x86_##func)
 
 #define KVM_X86_OP(func) \
 	DECLARE_STATIC_CALL(kvm_x86_##func, *(((struct kvm_x86_ops *)0)->func));
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index a5821d7c87f9..77cdee3e4aa6 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -54,7 +54,7 @@ struct kvm_pmu_ops {
 	const u32 MSR_STRIDE;
 };
 
-#define kvm_pmu_call(func) static_call(kvm_x86_pmu_##func)
+#define kvm_pmu_call(func) static_call_mod(kvm_x86_pmu_##func)
 
 #define KVM_X86_PMU_OP(func) \
 	DECLARE_STATIC_CALL(kvm_x86_pmu_##func, *(((struct kvm_pmu_ops *)0)->func));
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9d51803b7b2..792f402f493f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -148,9 +148,9 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
 #define KVM_X86_OP_OPTIONAL KVM_X86_OP
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
-EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
-EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
-EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
+EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_get_cs_db_l_bits);
+EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_cache_reg);
+EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_get_cpl);
 
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, 0644);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


--dnmNnJAO7OucAamW
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0003-static_call-Restrict-exporting-of-static-call-key-to.patch

From 87068920d63a87235ae9a1e62529a4d897bd6c6c Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 May 2026 07:03:24 -0700
Subject: [PATCH 3/4] static_call: Restrict exporting of static call *key* to
 tracepoints

Rename the export macros for static call trampolines and keys so that the
"default" EXPORT_STATIC_CALL{,_GPL}() exports only the trampoline, and full
exports of trampoline+key pairs is restricted to tracepoints (by naming
convention).  Most developers are blissfully unaware of the gory details of
static calls, and so don't understand the implications of using the
innocuous-looking "vanilla" macros.

Effectively defaulting to exporting the key is undesirable as there is no
known use case for allowing a module to change an export static call's
target, outside of tracepoints.

Opportunistically massage the macro magic to deduplicate the
CONFIG_HAVE_STATIC_CALL_INLINE=y vs. CONFIG_HAVE_STATIC_CALL=y vs.
CONFIG_HAVE_STATIC_CALL=n implementations.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/amd/brs.c      |  2 +-
 arch/x86/kernel/apic/init.c    |  4 +--
 arch/x86/kernel/cpu/mshyperv.c |  2 +-
 arch/x86/kernel/traps.c        |  2 +-
 arch/x86/kvm/x86.c             |  6 ++--
 arch/x86/xen/enlighten.c       |  2 +-
 include/linux/static_call.h    | 59 +++++++++++++---------------------
 include/linux/tracepoint.h     |  4 +--
 kernel/sched/core.c            |  8 ++---
 9 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 06f35a6b58a5..b9a246989bd4 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -424,7 +424,7 @@ void noinstr perf_amd_brs_lopwr_cb(bool lopwr_in)
 }
 
 DEFINE_STATIC_CALL_NULL(perf_lopwr_cb, perf_amd_brs_lopwr_cb);
-EXPORT_STATIC_CALL_TRAMP_GPL(perf_lopwr_cb);
+EXPORT_STATIC_CALL_GPL(perf_lopwr_cb);
 
 void __init amd_brs_lopwr_init(void)
 {
diff --git a/arch/x86/kernel/apic/init.c b/arch/x86/kernel/apic/init.c
index 821e2e536f19..933b8d2d3af5 100644
--- a/arch/x86/kernel/apic/init.c
+++ b/arch/x86/kernel/apic/init.c
@@ -30,8 +30,8 @@ DEFINE_APIC_CALL(wakeup_secondary_cpu);
 DEFINE_APIC_CALL(wakeup_secondary_cpu_64);
 DEFINE_APIC_CALL(write);
 
-EXPORT_STATIC_CALL_TRAMP_GPL(apic_call_send_IPI_mask);
-EXPORT_STATIC_CALL_TRAMP_GPL(apic_call_send_IPI_self);
+EXPORT_STATIC_CALL_GPL(apic_call_send_IPI_mask);
+EXPORT_STATIC_CALL_GPL(apic_call_send_IPI_self);
 
 /* The container for function call overrides */
 struct apic_override __x86_apic_override __initdata;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b5b6a58b67b0..9adfc12be1db 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -333,7 +333,7 @@ static void __init x86_setup_ops_for_tsc_pg_clock(void)
 
 #ifdef CONFIG_X86_64
 DEFINE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
-EXPORT_STATIC_CALL_TRAMP_GPL(hv_hypercall);
+EXPORT_STATIC_CALL_GPL(hv_hypercall);
 #define hypercall_update(hc) static_call_update(hv_hypercall, hc)
 #endif
 #endif /* CONFIG_HYPERV */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 0ca3912ecb7f..df05ad454414 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -218,7 +218,7 @@ static inline unsigned long pt_regs_val(struct pt_regs *regs, int nr)
 
 #ifdef HAVE_ARCH_BUG_FORMAT_ARGS
 DEFINE_STATIC_CALL(WARN_trap, __WARN_trap);
-EXPORT_STATIC_CALL_TRAMP(WARN_trap);
+EXPORT_STATIC_CALL(WARN_trap);
 
 /*
  * Create a va_list from an exception context.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 792f402f493f..d9d51803b7b2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -148,9 +148,9 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
 #define KVM_X86_OP_OPTIONAL KVM_X86_OP
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
-EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_get_cs_db_l_bits);
-EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_cache_reg);
-EXPORT_STATIC_CALL_TRAMP_GPL(kvm_x86_get_cpl);
+EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
+EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
+EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
 
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, 0644);
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 23b91bf9b663..ec14d2017909 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -23,7 +23,7 @@
 #include "xen-ops.h"
 
 DEFINE_STATIC_CALL(xen_hypercall, xen_hypercall_hvm);
-EXPORT_STATIC_CALL_TRAMP(xen_hypercall);
+EXPORT_STATIC_CALL(xen_hypercall);
 
 /*
  * Pointer to the xen_vcpu_info structure or
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 7539c82dd35f..c2c667baf8fe 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -26,7 +26,7 @@
  *   static_call_update(name, func);
  *   static_call_query(name);
  *
- *   EXPORT_STATIC_CALL{,_TRAMP}{,_GPL}()
+ *   EXPORT_STATIC_CALL{,_GPL}()
  *
  * Usage example:
  *
@@ -121,14 +121,6 @@
  *   completely eliding any function call overhead.
  *
  *   Notably argument setup is unconditional.
- *
- *
- * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
- *
- *   The difference is that the _TRAMP variant tries to only export the
- *   trampoline with the result that a module can use static_call{,_cond}() but
- *   not static_call_update().
- *
  */
 
 #include <linux/types.h>
@@ -214,19 +206,8 @@ extern long __static_call_return0(void);
 #define ARCH_ADD_TRAMP_KEY(name)
 #endif
 
-#define EXPORT_STATIC_CALL(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_GPL(name)					\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
-
-/* Leave the key unexported, so modules can't change static call targets: */
-#define EXPORT_STATIC_CALL_TRAMP(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
-	ARCH_ADD_TRAMP_KEY(name)
-#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
+#define __EXPORT_STATIC_CALL(name, scope)				\
+	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name));			\
 	ARCH_ADD_TRAMP_KEY(name)
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
@@ -274,18 +255,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 extern long __static_call_return0(void);
 
-#define EXPORT_STATIC_CALL(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_GPL(name)					\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
-
-/* Leave the key unexported, so modules can't change static call targets: */
-#define EXPORT_STATIC_CALL_TRAMP(name)					\
-	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
-	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+#define __EXPORT_STATIC_CALL(name, scope)				\
+	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name))
 
 #else /* Generic implementation */
 
@@ -348,9 +319,25 @@ static inline int static_call_text_reserved(void *start, void *end)
 	return 0;
 }
 
-#define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
-#define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
+#define __EXPORT_STATIC_CALL(name, scope)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
+#define __EXPORT_TRACEPOINT_STATIC_CALL(name, scope)			\
+	EXPORT_SYMBOL##scope(STATIC_CALL_KEY(name));			\
+	__EXPORT_STATIC_CALL(name, scope)
+#define EXPORT_TRACEPOINT_STATIC_CALL(name)				\
+	__EXPORT_TRACEPOINT_STATIC_CALL(name, )
+#define EXPORT_TRACEPOINT_STATIC_CALL_GPL(name)				\
+	__EXPORT_TRACEPOINT_STATIC_CALL(name, _GPL)
+
+/*
+ * For non-tracepoint usage, leave the key unexported, so modules can't change
+ * static call targets, i.e. can only invoke the static call.
+ */
+#define EXPORT_STATIC_CALL(name)					\
+	__EXPORT_STATIC_CALL(name, )
+#define EXPORT_STATIC_CALL_GPL(name)					\
+	__EXPORT_STATIC_CALL(name, _GPL)
+
 #endif /* _LINUX_STATIC_CALL_H */
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 2d2b9f8cdda4..1b64dcaf683e 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -423,12 +423,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	TRACEPOINT_CHECK(name)						\
 	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
 	EXPORT_SYMBOL_GPL(__traceiter_##name);				\
-	EXPORT_STATIC_CALL_GPL(tp_func_##name)
+	EXPORT_TRACEPOINT_STATIC_CALL_GPL(tp_func_##name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)					\
 	TRACEPOINT_CHECK(name)						\
 	EXPORT_SYMBOL(__tracepoint_##name);				\
 	EXPORT_SYMBOL(__traceiter_##name);				\
-	EXPORT_STATIC_CALL(tp_func_##name)
+	EXPORT_TRACEPOINT_STATIC_CALL(tp_func_##name)
 
 
 #else /* !TRACEPOINTS_ENABLED */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c6..c4d0db00d036 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7403,7 +7403,7 @@ EXPORT_SYMBOL(preempt_schedule);
 #   define preempt_schedule_dynamic_disabled	NULL
 #  endif
 DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
-EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
+EXPORT_STATIC_CALL(preempt_schedule);
 # elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule);
 void __sched notrace dynamic_preempt_schedule(void)
@@ -7476,7 +7476,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 #   define preempt_schedule_notrace_dynamic_disabled	NULL
 #  endif
 DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
-EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
+EXPORT_STATIC_CALL(preempt_schedule_notrace);
 # elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule_notrace);
 void __sched notrace dynamic_preempt_schedule_notrace(void)
@@ -7723,12 +7723,12 @@ EXPORT_SYMBOL(__cond_resched);
 #  define cond_resched_dynamic_enabled	__cond_resched
 #  define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(cond_resched);
+EXPORT_STATIC_CALL(cond_resched);
 
 #  define might_resched_dynamic_enabled	__cond_resched
 #  define might_resched_dynamic_disabled ((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(might_resched);
+EXPORT_STATIC_CALL(might_resched);
 # elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
 int __sched dynamic_cond_resched(void)
-- 
2.55.0.rc0.799.gd6f94ed593-goog


--dnmNnJAO7OucAamW
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0004-static_call-Add-FOR_MODULES-static-call-exports-use-.patch

From 05623900bddabdc47e6797b72a610b1d4f825e1d Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 May 2026 07:32:41 -0700
Subject: [PATCH 4/4] static_call: Add FOR_MODULES static call exports, use 'em
 in KVM

Add EXPORT_STATIC_CALL_FOR_MODULES(), along with KVM-specific variants,
and use the KVM-internal variants to export KVM's internal static calls
only to KVM's vendor modules (if any exist).

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c          |  2 +-
 arch/x86/kvm/x86.c          |  6 +++---
 include/linux/kvm_types.h   |  8 ++++++++
 include/linux/static_call.h | 12 +++++++-----
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b92dd2e58335..7e4f6e5ff436 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -100,7 +100,7 @@ static struct kvm_pmu_ops kvm_pmu_ops __read_mostly;
 #define KVM_X86_PMU_OP_OPTIONAL KVM_X86_PMU_OP
 #define KVM_X86_PMU_OP_OPTIONAL_RET0 KVM_X86_PMU_OP
 #include <asm/kvm-x86-pmu-ops.h>
-EXPORT_STATIC_CALL_GPL(kvm_x86_pmu_pmc_is_disabled_in_current_mode);
+EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(kvm_x86_pmu_pmc_is_disabled_in_current_mode);
 
 void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9d51803b7b2..6df084d827b8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -148,9 +148,9 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
 #define KVM_X86_OP_OPTIONAL KVM_X86_OP
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
-EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
-EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
-EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
+EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(kvm_x86_get_cs_db_l_bits);
+EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(kvm_x86_cache_reg);
+EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(kvm_x86_get_cpl);
 
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, 0644);
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..3bf9d113b001 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -13,8 +13,14 @@
 	EXPORT_SYMBOL_FOR_MODULES(symbol, __stringify(KVM_SUB_MODULES))
 #define EXPORT_SYMBOL_FOR_KVM(symbol) \
 	EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
+#define EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(symbol) \
+	EXPORT_STATIC_CALL_FOR_MODULES(symbol, __stringify(KVM_SUB_MODULES))
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol) \
+	EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
 #else
 #define EXPORT_SYMBOL_FOR_KVM_INTERNAL(symbol)
+#define EXPORT_STATIC_CALL_FOR_KVM_INTERNAL(symbol)
+
 /*
  * Allow architectures to provide a custom EXPORT_SYMBOL_FOR_KVM, but only
  * if there are no submodules, e.g. to allow suppressing exports if KVM=m, but
@@ -23,8 +29,10 @@
 #ifndef EXPORT_SYMBOL_FOR_KVM
 #if IS_MODULE(CONFIG_KVM)
 #define EXPORT_SYMBOL_FOR_KVM(symbol) EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm")
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol) EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm")
 #else
 #define EXPORT_SYMBOL_FOR_KVM(symbol)
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol)
 #endif /* IS_MODULE(CONFIG_KVM) */
 #endif /* EXPORT_SYMBOL_FOR_KVM */
 #endif
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index c2c667baf8fe..9b38f82b35c4 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -206,8 +206,8 @@ extern long __static_call_return0(void);
 #define ARCH_ADD_TRAMP_KEY(name)
 #endif
 
-#define __EXPORT_STATIC_CALL(name, scope)				\
-	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name));			\
+#define __EXPORT_STATIC_CALL(name, scope, ...)				\
+	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name), ##__VA_ARGS__);	\
 	ARCH_ADD_TRAMP_KEY(name)
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
@@ -255,8 +255,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 extern long __static_call_return0(void);
 
-#define __EXPORT_STATIC_CALL(name, scope)				\
-	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name))
+#define __EXPORT_STATIC_CALL(name, scope, ...)				\
+	EXPORT_SYMBOL##scope(STATIC_CALL_TRAMP(name), ##__VA_ARGS__)
 
 #else /* Generic implementation */
 
@@ -319,7 +319,7 @@ static inline int static_call_text_reserved(void *start, void *end)
 	return 0;
 }
 
-#define __EXPORT_STATIC_CALL(name, scope)
+#define __EXPORT_STATIC_CALL(name, scope, ...)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
@@ -339,5 +339,7 @@ static inline int static_call_text_reserved(void *start, void *end)
 	__EXPORT_STATIC_CALL(name, )
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	__EXPORT_STATIC_CALL(name, _GPL)
+#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)				\
+	__EXPORT_STATIC_CALL(name, _FOR_MODULES, mods)
 
 #endif /* _LINUX_STATIC_CALL_H */
-- 
2.55.0.rc0.799.gd6f94ed593-goog


--dnmNnJAO7OucAamW--
