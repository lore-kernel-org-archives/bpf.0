Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6F38B7DC;
	Tue, 23 Jun 2026 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235989; cv=none; b=Mh2uAJYAmfWegHHd8hd0Z/OFc2DX6oCs7zIuGc3G17FCnBiZ5IcvsPIpP2dbuBd9xqK9teIMu/6lTjTSH3fTjVuB+n7g/vkhOV1Ps28gXxfATfiX5laZKxfZlj5gkbb5WjhX5PXN0Xk+rwDQ8qanV99lUiEvTKfum0zHsbvHL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235989; c=relaxed/simple;
	bh=FqPeAu2aXn50pK5Y76zeGXtcTS8WHY1hC22NrxzcURI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pryIcZ6imkscJ9TMNEo/MpuYjf/Cs/K7MuYOiisMmCjXEY1aca0BIiLOJIKvTkDJZntUbkAB8ah1rlmZCGQ22yzGULb3YBUL+STxObB7wkq/OPI4+eAu7DHMw5M8BiXdto3yQeW05w5NF/eh8G/921tqL7Ke5SPTpxC8+KbVjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFa+Bkjh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFa+Bkjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782235988; x=1813771988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FqPeAu2aXn50pK5Y76zeGXtcTS8WHY1hC22NrxzcURI=;
  b=CFa+Bkjhss9yKkfEkjAXoLkwNcnRZxaEAcbUK7wjMOYUyi46aOoSusY7
   bnFpX4u76eNt8sejlQ/yOpmiMTjCXmalwjwfFytFojrpuWGraaFJb/CEN
   G0tAooX8BuXgKdk1qO8Mu4vb+UNaKGBZOW6Hg9MIcYRKdKaD8nCh3TdSO
   iJcp5OApu4Ifol8Rvvjjzp9YczpVMc6ayqBItau/D05P8+zPQXnKtZeiA
   TVs9ttQF+0amDMLQH/lk5Y8x14gxFyoMVaKgsbsidMgIm2X2XlWj6a4IG
   GBaxH6HM/aWJ/pOxEL1qJsYlNFJpxHEtnp4cAJoD1yey01lqj/eqO1YSk
   Q==;
X-CSE-ConnectionGUID: edfUalfZSF6oCjhF7QaRDw==
X-CSE-MsgGUID: q4qcMT07RMCVOdDMLzAq3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100414824"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="100414824"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:33:08 -0700
X-CSE-ConnectionGUID: Nj7kMV99Q/iFc2psnBJV0A==
X-CSE-MsgGUID: 3zwjpVILRhyHzkyNiWFHkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="248700437"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:33:08 -0700
Date: Tue, 23 Jun 2026 10:33:07 -0700
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
Subject: [PATCH v12 02/12] x86/bhi: Make clear_bhb_loop() effective on newer
 CPUs
Message-ID: <20260622-vmscape-bhb-v12-2-76cbda0ae3e5@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>

As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
the Branch History Buffer (BHB). On Alder Lake and newer parts this
sequence is not sufficient because it doesn't clear enough entries. This
was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
in the kernel.

Now with VMSCAPE (BHI variant) it is also required to isolate branch
history between guests and userspace. Since BHI_DIS_S only protects the
kernel, the newer CPUs also use IBPB.

A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
But it currently does not clear enough BHB entries to be effective on newer
CPUs with larger BHB. At boot, dynamically set the loop count of
clear_bhb_loop() such that it is effective on newer CPUs too.

Introduce global loop counts, initializing them with appropriate value
based on the hardware feature X86_FEATURE_BHI_CTRL.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S            |  8 +++++---
 arch/x86/include/asm/nospec-branch.h |  2 ++
 arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3a180a36ca0e..bbd4b1c7ec04 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
 	ANNOTATE_NOENDBR
 	push	%rbp
 	mov	%rsp, %rbp
-	movl	$5, %ecx
+
+	movzbl    bhb_seq_outer_loop(%rip), %ecx
+
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call	1f
 	jmp	5f
@@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
 	 * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
 	 * but some Clang versions (e.g. 18) don't like this.
 	 */
-	.skip 32 - 18, 0xcc
-2:	movl	$5, %eax
+	.skip 32 - 20, 0xcc
+2:	movzbl  bhb_seq_inner_loop(%rip), %eax
 3:	jmp	4f
 	nop
 4:	sub	$1, %eax
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 70b377fcbc1c..87b83ae7c97f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
 extern void update_spec_ctrl_cond(u64 val);
 extern u64 spec_ctrl_current(void);
 
+extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
+
 /*
  * With retpoline, we must use IBRS to restrict branch prediction
  * before calling into firmware.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 83f51cab0b1e..2cb4a96247d8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2047,6 +2047,10 @@ enum bhi_mitigations {
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
 
+/* Default to short BHB sequence values */
+u8 bhb_seq_outer_loop __ro_after_init = 5;
+u8 bhb_seq_inner_loop __ro_after_init = 5;
+
 static int __init spectre_bhi_parse_cmdline(char *str)
 {
 	if (!str)
@@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
 		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
 	}
 
+	/*
+	 * Switch to long BHB clear sequence on newer CPUs (with BHI_CTRL
+	 * support), see Intel's BHI guidance.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
+		bhb_seq_outer_loop = 12;
+		bhb_seq_inner_loop = 7;
+	}
+
 	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
 	cpu_print_attack_vectors();

-- 
2.34.1


