Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133DCA52;
	Tue, 24 Mar 2026 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376280; cv=none; b=fgsrk0cIwU2yq+15kHqBhmo8biN3/7kUUeUlCdibJXRuYtzyWuxB3Fka28STTNgcTnWb/KHFpj8GKYOPQ8IX5vI29YUy+pBj6SY9DJl+7Tzc9tkEsN8yxz4wyudD++iYLUq38wXtTyCvwGEtAGlUgLsui3YY5X37yNibOvwiJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376280; c=relaxed/simple;
	bh=7cJ6sjEbP/Ga7TlX9Dfhyujzs7TDJzczjuzBKjjVTK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRyyy4nJptEqtU/GfjjPgfyzvLyxMJitscUvd5FqCQMAed+fo7OY9jiSch2kgM+P2/Q/MgDNiO84VaS05WdzFuFLNUVSJPhDIYRUTtaNQa6JPnx1bCgadmjpcsHVC+8LzdDs9GMS93Gr56Oeodm7tYu1Q1JYWJjlMZATfEVxWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge1nEx1Z; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge1nEx1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774376278; x=1805912278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7cJ6sjEbP/Ga7TlX9Dfhyujzs7TDJzczjuzBKjjVTK0=;
  b=ge1nEx1ZFNCVLKLjTc35iESeTGJmHtdk0A4ZAT3ewBRcOh4V9hy1qp1r
   2a+5XXhOuuFRUSDjGPpON7To2KzVg33l5KPhBwODN7z6E7NB+8lquU35j
   0DlAgph+1nLcpvd7UY2SmE3m9oQTLLakhbJDFhly/a8d3Qv2a3imP5Mz6
   4zVKvZgzq3agMtCu4A/eJwYQGGhqfiuVhY2QonuWT2YuVtHtdQwyuL+0r
   1s0Y3QNjy06YuN/gKR/LbddLAmqWDNtvfGcdb9BQVTPHoPAhAG7Lt8uFs
   2WNwZ7i5oVxD95jkSkCQN90XmVmV6UTlkwk7JkMdhaGkGcs3AHFkqQwmb
   g==;
X-CSE-ConnectionGUID: B0K68buAQP2Vq6/cHR2bQA==
X-CSE-MsgGUID: tfL3yuS8TrS7oQtvCAIrMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79000951"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79000951"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:17:57 -0700
X-CSE-ConnectionGUID: OjpqPBbaQei+bNjUoRhz1g==
X-CSE-MsgGUID: uwRdaqKcTP+zWrxosEGgtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224443620"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:17:59 -0700
Date: Tue, 24 Mar 2026 11:17:58 -0700
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
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v8 06/10] x86/vmscape: Use write_ibpb() instead of
 indirect_branch_prediction_barrier()
Message-ID: <20260324-vmscape-bhb-v8-6-68bb524b3ab9@linux.intel.com>
X-Mailer: b4 0.15-dev
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>

indirect_branch_prediction_barrier() is a wrapper to write_ibpb(), which
also checks if the CPU supports IBPB. For VMSCAPE, call to
indirect_branch_prediction_barrier() is only possible when CPU supports
IBPB.

Simply call write_ibpb() directly to avoid unnecessary alternative
patching.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index c45858db16c9..78b143673ca7 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -97,7 +97,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	/* Avoid unnecessary reads of 'x86_predictor_flush_exit_to_user' */
 	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER) &&
 	    this_cpu_read(x86_predictor_flush_exit_to_user)) {
-		indirect_branch_prediction_barrier();
+		write_ibpb();
 		this_cpu_write(x86_predictor_flush_exit_to_user, false);
 	}
 }

-- 
2.34.1


