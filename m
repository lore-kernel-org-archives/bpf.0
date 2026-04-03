Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A520B810;
	Fri,  3 Apr 2026 00:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176328; cv=none; b=dLFbrqKe6bLvTCnRo0aDJ6DfZsB/++bnEcNMH9XPD8wpUapGIViI+JRxMkFPA3Tf3NfZ4k+CTSPRAg0zGiVMsNMZvfHlNEZZGikzRx4sJnCBsv77mmtDDnjafqt5RboILKqFjGYMXJ0NaQnVwE2EzT1pQTaFeWAiskLmbFBX+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176328; c=relaxed/simple;
	bh=YsdvlQqeVior0g/k+WAElPcnRGxse6gI8p2joQTg8Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THNY2WCE0X2lC51NU2L5Sc0jaj5YXTqZkEi9Liey1sGsglvl4HvLLlZOrqCBmbANu/kmR04HS/9axaCcNyLEkuXhbFv+llbg7TEnmxMqHXjnHhgTC4WZ0cF07k/oZCrjW4pnrujJUMdAW9EPMVGmhMdtkjWEKsH4LNXO0MDdbPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgxCfpVq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgxCfpVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775176327; x=1806712327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YsdvlQqeVior0g/k+WAElPcnRGxse6gI8p2joQTg8Fc=;
  b=YgxCfpVqn/igi6pL+mpc4WnwS0rywOj91Um1Q6u9CNKBAgfi+7TiPBed
   psJv3oBVzo0UNsAZ2ALAW234FV/qPBamxs6U2Xy/ArbiWN/suScBvuZAO
   nUb+AGFNukt45g+4fnq0XjfQSwrh4qUO85jVGdJRKk3jLAQEAD4xgwEXL
   MzvJ5m9cEXZvpKv/s7/viinvQwDcvtKprB47c8+Isfc/zTxl2iNdb6jQ2
   8a2DGc5Ta4bJ50xzYT5Y/FmBPWLVHnHkU+jJyft2rC7tQBQ3rr91JrKLG
   Y1HLw2ohITfG8x3pTFEyv88lOfpZcQjIaJTWh8HBSltV0WFS+5QLq+amP
   A==;
X-CSE-ConnectionGUID: u0NjkD4jT96+2zhK6uMIsw==
X-CSE-MsgGUID: j8dbFPA8TXy/9mQ1RN3Asw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76435689"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76435689"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:32:06 -0700
X-CSE-ConnectionGUID: u2pkypy3T9yl3B3o+Um16Q==
X-CSE-MsgGUID: 0PR9yuJqQEW/18W95KbrNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="226285665"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:32:07 -0700
Date: Thu, 2 Apr 2026 17:32:06 -0700
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
Subject: [PATCH v9 06/10] x86/vmscape: Use write_ibpb() instead of
 indirect_branch_prediction_barrier()
Message-ID: <20260402-vmscape-bhb-v9-6-94d16bc29774@linux.intel.com>
X-Mailer: b4 0.15-dev
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>

indirect_branch_prediction_barrier() is a wrapper to write_ibpb(), which
also checks if the CPU supports IBPB. For VMSCAPE, call to
indirect_branch_prediction_barrier() is only possible when CPU supports
IBPB.

Simply call write_ibpb() directly to avoid unnecessary alternative
patching.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Jon Kohler <jon@nutanix.com>
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


