Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738C3E0C46;
	Thu, 19 Mar 2026 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934901; cv=none; b=cgSsdIpJv7NO2LaH6dal8P9ulk7DJtMRTXV4oAkKBT7NwHmFS//aH3LGnA+qZXIKUSpj3LRcKWfxrhv9WRI2NfpQpMQIqZOj9fnHbZ1DfTmmNa4cHYSLufUm/lSqBzAL64puB5yFLTsezCbPg+IYERQclroMKZKeZ4liy9paNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934901; c=relaxed/simple;
	bh=7cJ6sjEbP/Ga7TlX9Dfhyujzs7TDJzczjuzBKjjVTK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqsHtidkCN/2I7ehH66YBmBvwaJZirxtvoore+xbuNa3eI40HaYBaWsvDEGeM4/txN9rtZF9uTYiYVXS//MdjBUj1elGDU2QEUweKJqYo1QHXpbrr7ySqvuxg/+7kI+sjx8aoL8XUBKSsyX47rt44zOyQ0JA7kVFMS2OtKvMCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5XmzWK2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5XmzWK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773934900; x=1805470900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7cJ6sjEbP/Ga7TlX9Dfhyujzs7TDJzczjuzBKjjVTK0=;
  b=R5XmzWK2ToT5Ya7e177Bk9dJD74dO61Y4AlzrPdUNlGhMid6mARTqOz7
   1wtTTWfnVRMMskte7u/sI4XqxfrA21n3LCEKOZJMd1f5G/tfxlFEcCk8j
   VvHa4GE96YK0iu2+Sh7yUvXnls+t4fhrVJU/2rnBk/TEPbl+A06S7+ECp
   FkHrYxkKj+iCCvEvnwaj+tVlAG+++RHKbdQPDFJtqZPHwL1NdYSy62MUT
   ax0gOvNrx27FdCWf2ItTlhkwwDEzf4mvZzrb7E8xzcjiXQF1Qr8LLre3u
   7Bj3Oi1LAZga07oAknebB4rwDnTBF+xk++G/xGRRxmc9yazm4Bebi9Qb2
   w==;
X-CSE-ConnectionGUID: KRCzkpvpRnKKMJFQ2OjXjQ==
X-CSE-MsgGUID: kZWEodNPQRKsc5pfJn6T5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75042364"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="75042364"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:41:39 -0700
X-CSE-ConnectionGUID: unimm9lNSfmIRC64LA6/7w==
X-CSE-MsgGUID: 3RiMqjzASVSWLcSRVoY3+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="253469380"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:41:39 -0700
Date: Thu, 19 Mar 2026 08:41:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Nikolay Borisov <nik.borisov@suse.com>,
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
Subject: [PATCH v7 06/10] x86/vmscape: Use write_ibpb() instead of
 indirect_branch_prediction_barrier()
Message-ID: <20260319-vmscape-bhb-v7-6-b76a777a98af@linux.intel.com>
X-Mailer: b4 0.15-dev
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>

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


