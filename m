Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4086329;
	Thu, 23 Apr 2026 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924950; cv=none; b=Sl2Fihc58ztEmpYO9wLUSgIb0IIKSaW672i2Yc7ZbbHdUqlxqMX6arZjkwSNTaSQGhXn+fpEpYpApGbvZyVnkTHrwZXv+xQg6WPMYMTSeDb6UlQXbjtErSrMqecDCTZZ6quaCIO998esVTVSKP+PqwNAZRchQXFRyXRWXShaavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924950; c=relaxed/simple;
	bh=mav5aDg8EwieFJ2WAvHM82MSHiRvIIrK2PTU0j5TFLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B64gWoaGR/jqDzwjSBY91lmn8CsGRKMSdCc/qHBnoSZNZ0ChD1XWNVVQioW6ZMwddEQ60wALvnXlExJRtmo7+FTlSM4g1B9Ks/HMEq1vfLYZ0udkXpfXcpXFni61Z7LtKrGr9e2Jx9biFXH6u2jWdfrwdRsmIbxB9Ac2/o74/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGfP9i3W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGfP9i3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776924949; x=1808460949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mav5aDg8EwieFJ2WAvHM82MSHiRvIIrK2PTU0j5TFLQ=;
  b=gGfP9i3WODZGupCQ7rcwuVPRwIwZCPnL0+QGaWt0Lz8ry5RSsreK50dE
   PaCSux7wwk8Bryp9TnwGaAksGw4XU7PYm35V7CiHw0xHklxjpDLrFpBC+
   1Q1LRc70h01ZnHEdYIVIGm2YHbg3Wo4Fph1PcJOQuRJFD0eikc7w5u9Il
   jCDfAXKaEZfupmNbxL70cnBndAxXp9wrSzenOStUMBlJWAfLxq1ZAPsdd
   Ryfw2iqKgcCOBWZRgOKAobbNP5EDRrHxVk90xGSmqJaD7BPYKdcFIlKO+
   jJ5AN8Di0rOyCoJ5vC8Dwgd2WhrbvoeAND9jfbE1H2UpcAReAprTutH0F
   A==;
X-CSE-ConnectionGUID: zjFbfx3BRnSw4/zTMllUrQ==
X-CSE-MsgGUID: mjJ2Rm3tTvOEgrEADI+tQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="65419653"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="65419653"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:15:47 -0700
X-CSE-ConnectionGUID: LzdT4yqhQCOdIYDRJVydrg==
X-CSE-MsgGUID: 06ow060aQIemTVFkt46tiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="237623816"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:15:47 -0700
Date: Wed, 22 Apr 2026 23:15:47 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Laight <david.laight.linux@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v11 04/12] x86/vmscape: Rename x86_ibpb_exit_to_user to
 x86_predictor_flush_exit_to_user
Message-ID: <20260422-vmscape-bhb-v11-4-b18e0cf32af4@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com>

With the upcoming changes x86_ibpb_exit_to_user will also be used when BHB
clearing sequence is used. Rename it cover both the cases.

No functional change.

Suggested-by: Sean Christopherson <seanjc@google.com>
Tested-by: Jon Kohler <jon@nutanix.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/entry-common.h  | 6 +++---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 arch/x86/kernel/cpu/bugs.c           | 4 ++--
 arch/x86/kvm/x86.c                   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index ce3eb6d5fdf9..c45858db16c9 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -94,11 +94,11 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	 */
 	choose_random_kstack_offset(rdtsc());
 
-	/* Avoid unnecessary reads of 'x86_ibpb_exit_to_user' */
+	/* Avoid unnecessary reads of 'x86_predictor_flush_exit_to_user' */
 	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER) &&
-	    this_cpu_read(x86_ibpb_exit_to_user)) {
+	    this_cpu_read(x86_predictor_flush_exit_to_user)) {
 		indirect_branch_prediction_barrier();
-		this_cpu_write(x86_ibpb_exit_to_user, false);
+		this_cpu_write(x86_predictor_flush_exit_to_user, false);
 	}
 }
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 157eb69c7f0f..0381db59c39d 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -533,7 +533,7 @@ void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
 		: "memory");
 }
 
-DECLARE_PER_CPU(bool, x86_ibpb_exit_to_user);
+DECLARE_PER_CPU(bool, x86_predictor_flush_exit_to_user);
 
 static inline void indirect_branch_prediction_barrier(void)
 {
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2cb4a96247d8..002bf4adccc3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -65,8 +65,8 @@ EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
  * be needed to before running userspace. That IBPB will flush the branch
  * predictor content.
  */
-DEFINE_PER_CPU(bool, x86_ibpb_exit_to_user);
-EXPORT_PER_CPU_SYMBOL_GPL(x86_ibpb_exit_to_user);
+DEFINE_PER_CPU(bool, x86_predictor_flush_exit_to_user);
+EXPORT_PER_CPU_SYMBOL_GPL(x86_predictor_flush_exit_to_user);
 
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd1c4a36b593..45d7cfedc507 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11464,7 +11464,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * may migrate to.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
-		this_cpu_write(x86_ibpb_exit_to_user, true);
+		this_cpu_write(x86_predictor_flush_exit_to_user, true);
 
 	/*
 	 * Consume any pending interrupts, including the possible source of

-- 
2.34.1


