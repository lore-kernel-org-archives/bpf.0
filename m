Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB3379993
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379493; cv=none; b=ZLsm64VLq8Zs4HEtS163TfO31XSvun4JA+GBGv9LS84ve7YD+nYhC40Mna/RszLNRSzA/w8ZAqJq0jpLQ3/1OzldV7wqjtRkpGwStv2v9x1ulHaRnwq8Y7A28wah/WtmjCJG+d77e2zLghggC9aae7eryVR39amJ179COrgaBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379493; c=relaxed/simple;
	bh=QnH1vIimESyZ2peW1iohZ3MwmBA4oBxKLRs7rK4wSqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ggxgkqFzE3B4lND3H3/xoRJ9Rw0U+HQ/q18by+vTa0KfWPOOLqbf9y6RPP/OHxjU/mZ0Znk+1FdgLoK0bTypiBHvRU3hXvpPejSWb9jyVi/wGOJm+5DwBVMH4s9rGLJtCfE4z/UlLafkQI0rjtpn/kVZ+QCDZ+/jRoV4ISC1Xeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VeIywNGF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VeIywNGF"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f7bec24fdso47220b3a.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776379491; x=1776984291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqyYEqZgyMpoZKxskZj0QRqQl7ttahHyrPikYOVHCGs=;
        b=VeIywNGFDT898urzHsB6Lhv0CzlE8C3vn6rrp3ax65KnTTLVOjOmQaJ+bco7wSJcEK
         Uy2LteuxTCZUjkfGmcCfIm4Fo2uEZTOoWx5DyDzyt9YbtQhMuczlsGBBysKy9fqF8fpu
         KecMu0Mc4aRkDSV5sL7F5BhQtELHwHFx5LOSL/h6sLPYcGPdO68JwgPnKMwqygpU5OsU
         wYtHN1iyi0qbTfX9FV81jWlwUJHqQnESeK1b9u3YR1ZmbdLLxZZNcW/3Swyvej0rCDDe
         9ZQDd3gYL35i9oiaMKBf1YXy9Vm18CoXnTB4wWFJQSeoqAdWfBeUctSDwor4lSHE2cal
         jfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776379491; x=1776984291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqyYEqZgyMpoZKxskZj0QRqQl7ttahHyrPikYOVHCGs=;
        b=Kp2uInOW4DakQ+y/rxOmgth5lJchfv/KXyz+7LnyGUfkcKV5oqpkYZ7vZ9KD3mN/76
         x8Lx1qBFOyp+9Abm2EFtYq/xajpbGjB4i1iAsWwOkQafQ/NFy93I2cSeOo2HpbUiK8dR
         dXqzrCOvcCTgnr5y7eUXEW6/ChdN3nBb8Vcku6I5KOoZF1+RUVxbn6VM/f9bSiBbFXTH
         ibJbd2tbLyMjf8fxSISak5RiOCH6l0KNgcEl4QXn4ZNY+T23eHMNYjgErpws9PEwa9AL
         Js1rdx/U66tk6+oJ1AMDL5qBcLdxAGgYdtBqALiSyKJfLex3jpv1EHyctv/HKV52qmvb
         FYZA==
X-Forwarded-Encrypted: i=1; AFNElJ9G5KYr+gAYre/AHQ6Sgj0zz/8jHVSqvjS85Ro1yf++f75frbwP0Nipr+PrTlhw8/KLJOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCh0iCRfp7g7elNOB2ZqwdjtsWp1n7PcSvv9WyVd5yxtbwlGY
	HmV8Qpz3Tj/i6Gk8RPlQ8diGeHsrjJUMu+ti7cYFJrMrKeWJXadCtcFy/Ta9yJIbJ+BZTNmHlMT
	WMEm//g==
X-Received: from pfbho13.prod.google.com ([2002:a05:6a00:880d:b0:7ba:8e68:3140])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:439b:b0:82f:8696:5a75
 with SMTP id d2e1a72fcca58-82f8c8bb700mr145981b3a.28.1776379491191; Thu, 16
 Apr 2026 15:44:51 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:44:49 -0700
In-Reply-To: <20260414-vmscape-bhb-v10-8-efa924abae5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com> <20260414-vmscape-bhb-v10-8-efa924abae5f@linux.intel.com>
Message-ID: <aeFmYd1ybZnVlAYW@google.com>
Subject: Re: [PATCH v10 08/12] kvm: Define EXPORT_STATIC_CALL_FOR_KVM()
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

On Tue, Apr 14, 2026, Pawan Gupta wrote:
> EXPORT_SYMBOL_FOR_KVM() exists to export symbols to KVM modules. Static
> calls need the same treatment when the core kernel defines a static_call
> that KVM needs access to (e.g. from a VM-exit path).
> 
> Define EXPORT_STATIC_CALL_FOR_KVM() as the static_call analogue of
> EXPORT_SYMBOL_FOR_KVM(). The same three-way logic applies:
> 
>   - KVM_SUB_MODULES defined: export to "kvm," plus all sub-modules
>   - KVM=m, no sub-modules: export to "kvm" only
>   - KVM built-in: no export needed (noop)
> 
> As with EXPORT_SYMBOL_FOR_KVM(), allow architectures to override the
> definition (e.g. to suppress the export when kvm.ko itself will not be
> built despite CONFIG_KVM=m). Add the x86 no-op override in
> arch/x86/include/asm/kvm_types.h for that case.
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/include/asm/kvm_types.h |  1 +
>  include/linux/kvm_types.h        | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_types.h b/arch/x86/include/asm/kvm_types.h
> index d7c704ed1be9..bceeaed2940e 100644
> --- a/arch/x86/include/asm/kvm_types.h
> +++ b/arch/x86/include/asm/kvm_types.h
> @@ -15,6 +15,7 @@
>   * at least one vendor module is enabled.
>   */
>  #define EXPORT_SYMBOL_FOR_KVM(symbol)
> +#define EXPORT_STATIC_CALL_FOR_KVM(symbol)
>  #endif
>  
>  #define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index a568d8e6f4e8..c81f4fdba625 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -13,6 +13,8 @@
>  	EXPORT_SYMBOL_FOR_MODULES(symbol, __stringify(KVM_SUB_MODULES))
>  #define EXPORT_SYMBOL_FOR_KVM(symbol) \
>  	EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
> +#define EXPORT_STATIC_CALL_FOR_KVM(symbol) \
> +	EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
>  #else
>  #define EXPORT_SYMBOL_FOR_KVM_INTERNAL(symbol)
>  /*
> @@ -27,7 +29,16 @@
>  #define EXPORT_SYMBOL_FOR_KVM(symbol)
>  #endif /* IS_MODULE(CONFIG_KVM) */
>  #endif /* EXPORT_SYMBOL_FOR_KVM */
> -#endif
> +
> +#ifndef EXPORT_STATIC_CALL_FOR_KVM
> +#if IS_MODULE(CONFIG_KVM)
> +#define EXPORT_STATIC_CALL_FOR_KVM(symbol) EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm")
> +#else
> +#define EXPORT_STATIC_CALL_FOR_KVM(symbol)
> +#endif /* IS_MODULE(CONFIG_KVM) */
> +#endif /* EXPORT_STATIC_CALL_FOR_KVM */
> +
> +#endif /* KVM_SUB_MODULES */

I think I'd prefer to require EXPORT_SYMBOL_FOR_KVM and EXPORT_STATIC_CALL_FOR_KVM
to come as a pair from arch code.  I can't think of a scenario where arch code
should override one but not the other.  The end result is slightly less ugly :-)

---
 arch/x86/include/asm/kvm_types.h |  1 +
 include/linux/kvm_types.h        | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_types.h b/arch/x86/include/asm/kvm_types.h
index d7c704ed1be9..bceeaed2940e 100644
--- a/arch/x86/include/asm/kvm_types.h
+++ b/arch/x86/include/asm/kvm_types.h
@@ -15,6 +15,7 @@
  * at least one vendor module is enabled.
  */
 #define EXPORT_SYMBOL_FOR_KVM(symbol)
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol)
 #endif
 
 #define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..be602d3f287e 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -13,6 +13,8 @@
 	EXPORT_SYMBOL_FOR_MODULES(symbol, __stringify(KVM_SUB_MODULES))
 #define EXPORT_SYMBOL_FOR_KVM(symbol) \
 	EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol) \
+	EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
 #else
 #define EXPORT_SYMBOL_FOR_KVM_INTERNAL(symbol)
 /*
@@ -23,11 +25,17 @@
 #ifndef EXPORT_SYMBOL_FOR_KVM
 #if IS_MODULE(CONFIG_KVM)
 #define EXPORT_SYMBOL_FOR_KVM(symbol) EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm")
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol) EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm")
 #else
 #define EXPORT_SYMBOL_FOR_KVM(symbol)
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol)
 #endif /* IS_MODULE(CONFIG_KVM) */
+#else
+#ifndef EXPORT_STATIC_CALL_FOR_KVM
+#error Must #define EXPORT_STATIC_CALL_FOR_KVM if #defining EXPORT_SYMBOL_FOR_KVM
+#endif
 #endif /* EXPORT_SYMBOL_FOR_KVM */
-#endif
+#endif /* KVM_SUB_MODULES */
 
 #ifndef __ASSEMBLER__
 

base-commit: 56b7ace84970ff647b095849e80bc36c094760aa
--
