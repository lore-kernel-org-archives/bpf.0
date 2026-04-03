Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758929B799
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227947; cv=none; b=MzE36OFRd4Lw/L9d4yGksH+me7mG6cWlzax1+rP38a0y1t4DBxeF8pGBmBziXkETgRLcqxMoQdhwpn41ChCr62LIRw/+jx4NVj22WduNtyF0DaYJcDEoAWVSSfibXkMkWE1qHiAktu7vucg6fam46RkuVDkHC3nw3bzIMiLGnLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227947; c=relaxed/simple;
	bh=CTRwpPkY5I/XQFDvpz3aZ16aVXK374cBhoFBuuzohBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MKDipIQooAXJF94wFL3yHgm+P+sv5hYef5hPm/Ed8VFa7UDC2x7nYCU+sJpm1yVT5s7znm6fnnE7IWFpQmZ9B68E+vTKsZw2hLMrzrKQm6LEsI/32u6dSFv4A0keUQRdu/AvxW+plvLEXUtn+ldoIi1UWtyUVSz2uLd9iK0YiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pb/E0rBe; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pb/E0rBe"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b6db8bb2so949332a12.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775227945; x=1775832745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DiuRvpeeoOLs6ih2ypPx8qDY3zNqJzQtKD09MDbtleo=;
        b=pb/E0rBe2VtJDHyiiYkaye+2q2uqM2fMcC9khj7OKTmr5qprdUk++Tut+pjMRLt58R
         F1j36ZpLAIWzt5UGrKHpjMCtApP+pA1Rrxj/gNnDO4NGvswlLPXdB0M2JSfPqdHdrQla
         tSdCpOhSCdnyNrxBkAysGyRY9TyS/1ohVDWbM1UHvCO2oQRLQ19THmeJVQFz9hDm2W/k
         VnQwKp5SCVZrXNpfgdl25tY/Is9cQGsMk5Bx05GdKCp/3cxtt9OiWbqd+cKWQa8GLKpq
         +vIn8GuWuFs6RWcBIBziKykrtBXXXnzkswWq3941XRcE2tMduMNmo5CP++qQ28eJxNK9
         FpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775227945; x=1775832745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiuRvpeeoOLs6ih2ypPx8qDY3zNqJzQtKD09MDbtleo=;
        b=TeKwNr1WcmZRxDCjtT1fly+1HP2HgK9pDoi+53xW1sUHDdEsl1s4hvPhtwmgAnmY9U
         9ViZXyJFvqaS5qQRbQiCeH9ytDPpgxycLUYqzmW46XJ4LDaoZ+CJvpBLtoy/5w/WT2LH
         UsmplwoEoybipbfPYPH4LlZpT5t6wD70tiwVqT6hcSco5cQnDfC4wCaXsn4lvMI6ow87
         VULOLk9UDRONcAhP4+8M7Rs7E0gGXLXGlH98kFNKc6u71iF0TNNcSVrPI0h+dg2M826f
         n67l1AMRSlf1ySg1CXMv08wRC5yCeCusgJK1gOdH4yiFgTwErd9tb/Ju+cFXLMcPj5rN
         7qig==
X-Forwarded-Encrypted: i=1; AJvYcCUtZrukJRd1e+KlE3/P5ox3TzDh5SIjLM2er6Q+xVUPRp8IUM4SSeiBq2V/7N1nOt3p/t8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5L3TqNZZuJMYt4PJypI1hX6a1vQY+K/tj87cANjA/eunKkYQ
	WNWImQQ0aSWSA8A0zH6IA41nPHVdVx2bW2qPF8XZMG1ihrgUDnjVn/hVpEJZ62tF6is0uX4HriO
	D91/CPA==
X-Received: from pjuf5.prod.google.com ([2002:a17:90a:ce05:b0:35c:2d1e:7123])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc3:b0:359:f825:5700
 with SMTP id 98e67ed59e1d1-35de68688f0mr3098585a91.10.1775227945130; Fri, 03
 Apr 2026 07:52:25 -0700 (PDT)
Date: Fri, 3 Apr 2026 07:52:23 -0700
In-Reply-To: <20260402-vmscape-bhb-v9-7-94d16bc29774@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com> <20260402-vmscape-bhb-v9-7-94d16bc29774@linux.intel.com>
Message-ID: <ac_UJx99kDJY8j3t@google.com>
Subject: Re: [PATCH v9 07/10] x86/vmscape: Use static_call() for predictor flush
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
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, Pawan Gupta wrote:
> Adding more mitigation options at exit-to-userspace for VMSCAPE would
> usually require a series of checks to decide which mitigation to use. In
> this case, the mitigation is done by calling a function, which is decided
> at boot. So, adding more feature flags and multiple checks can be avoided
> by using static_call() to the mitigating function.
> 
> Replace the flag-based mitigation selector with a static_call(). This also
> frees the existing X86_FEATURE_IBPB_EXIT_TO_USER.

...

> @@ -3133,8 +3139,14 @@ static void __init vmscape_update_mitigation(void)
>  static void __init vmscape_apply_mitigation(void)
>  {
>  	if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
> -		setup_force_cpu_cap(X86_FEATURE_IBPB_EXIT_TO_USER);
> +		static_call_update(vmscape_predictor_flush, write_ibpb);
> +}
> +
> +bool vmscape_mitigation_enabled(void)
> +{
> +	return !!static_call_query(vmscape_predictor_flush);
>  }
> +EXPORT_SYMBOL_FOR_KVM(vmscape_mitigation_enabled);
>  
>  #undef pr_fmt
>  #define pr_fmt(fmt) fmt
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 45d7cfedc507..e204482e64f3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11463,7 +11463,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	 * set for the CPU that actually ran the guest, and not the CPU that it
>  	 * may migrate to.
>  	 */
> -	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
> +	if (vmscape_mitigation_enabled())

This is pretty lame.  It turns a statically patched MOV

  11548		if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
  11549			this_cpu_write(x86_ibpb_exit_to_user, true);
     0x000000000003c57a <+858>:	movb   $0x1,%gs:0x0(%rip)        # 0x3c582 <vcpu_enter_guest+866>

into a function call and two sets of conditional branches.  And with mitigations
enabled, that function call may trigger the wonderful unret insanity

  11548		if (vmscape_mitigation_enabled())
     0x000000000003c575 <+853>:	call   0x3c57a <vcpu_enter_guest+858>
     0x000000000003c57a <+858>:	test   %al,%al
     0x000000000003c57c <+860>:	je     0x3c586 <vcpu_enter_guest+870>

  11549			this_cpu_write(x86_predictor_flush_exit_to_user, true);
     0x000000000003c57e <+862>:	movb   $0x1,%gs:0x0(%rip)        # 0x3c586 <vcpu_enter_guest+870>


  3166	{
     0xffffffff81285320 <+0>:	endbr64
     0xffffffff81285324 <+4>:	call   0xffffffff812aa5a0 <__fentry__>

  3167		return !!static_call_query(vmscape_predictor_flush);
     0xffffffff81285329 <+9>:	mov    0x13a4f30(%rip),%rax        # 0xffffffff8262a260 <__SCK__vmscape_predictor_flush>
     0xffffffff81285330 <+16>:	test   %rax,%rax
     0xffffffff81285333 <+19>:	setne  %al

  3168	}
     0xffffffff81285336 <+22>:	jmp    0xffffffff81db1e30 <__x86_return_thunk>

While this isn't KVM's super hot inner run loop, it's still very much a hot path.
Even more annoying, KVM will eat the function call on kernels with CPU_MITIGATIONS=n.

I'd like to at least do something like the below to make the common case of
multiple guest entry/exits more or less free, and to avoid the CALL+(UN)RET
overhead, but trying to include linux/static_call.h in processor.h (or any other
core x86 header) creates a cyclical dependency :-/

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 20ab4dd588c6..0dc0680a80f8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -36,6 +36,7 @@ struct vm86;
 #include <linux/err.h>
 #include <linux/irqflags.h>
 #include <linux/mem_encrypt.h>
+#include <linux/static_call.h>
 
 /*
  * We handle most unaligned accesses in hardware.  On the other hand
@@ -753,7 +754,11 @@ enum mds_mitigations {
 };
 
 extern bool gds_ucode_mitigated(void);
-extern bool vmscape_mitigation_enabled(void);
+
+static inline bool vmscape_mitigation_enabled(void)
+{
+       return !!static_call_query(vmscape_predictor_flush);
+}
 
 /*
  * Make previous memory operations globally visible before
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 366ebe1e1fb9..02bf626f0773 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -148,6 +148,7 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
  * sequence. This defaults to no mitigation.
  */
 DEFINE_STATIC_CALL_NULL(vmscape_predictor_flush, write_ibpb);
+EXPORT_STATIC_CALL_GPL(vmscape_predictor_flush);
 
 #undef pr_fmt
 #define pr_fmt(fmt)    "mitigations: " fmt
@@ -3162,12 +3163,6 @@ static void __init vmscape_apply_mitigation(void)
                static_call_update(vmscape_predictor_flush, clear_bhb_loop_nofence);
 }
 
-bool vmscape_mitigation_enabled(void)
-{
-       return !!static_call_query(vmscape_predictor_flush);
-}
-EXPORT_SYMBOL_FOR_KVM(vmscape_mitigation_enabled);
-
 #undef pr_fmt
 #define pr_fmt(fmt) fmt
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1fbbab08291..117c60d00758 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11545,7 +11545,9 @@ static noinline int vcpu_enter_guest(struct kvm_vcpu *vcpu)
         * set for the CPU that actually ran the guest, and not the CPU that it
         * may migrate to.
         */
-       if (vmscape_mitigation_enabled())
+       if (IS_ENABLED(CONFIG_CPU_MITIGATIONS) &&
+           !this_cpu_read(x86_predictor_flush_exit_to_user) &&
+           vmscape_mitigation_enabled())
                this_cpu_write(x86_predictor_flush_exit_to_user, true);
 
        /*
