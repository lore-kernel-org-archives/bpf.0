Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452052248A0;
	Fri,  3 Apr 2026 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176313; cv=none; b=BbYSz1mQxOaHV29af7svzHdalG7tbOWUEtepBY/WwxYiMQtMScK99FJH6ZiX16XBZFgtztvS/apSt9fDLNKlc0qc6AQrYOJVQJmBGnY4K6bLsD6/8ZBBKYN1RzfoKucae06mzR/3Bpf5DERFvoJe+J2IpbLCtm12PjKULSsP3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176313; c=relaxed/simple;
	bh=Z+UBFYvZmhxdkKBWIZKrd5/Lkbp8grvu2K8zVnKyDK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWC3f1pnK2cTSd6RNJFUSMbKr8uFTaecWZ+gcAsUIjz6hbSXEqUL//AMINWaiRGsyaNg/rlW3RoOPI7ghfEyibpPscWBaAPx/5bcDYulmkpzIKpJPDazspR/1gfRr5yWtOd90f88Onm9+ygSDBhT9crpk2dQCHsiSEjARwffTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYRRCf4G; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYRRCf4G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775176312; x=1806712312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+UBFYvZmhxdkKBWIZKrd5/Lkbp8grvu2K8zVnKyDK0=;
  b=cYRRCf4GwjJajm0bUuOv0hXXMEu0pRPhFpWZzor5SNwEt0893cL+Bfz1
   /4TFsKOcS18t0vkORV6ZNbwAmJXqoD4d/H0zEcpsTK6qdh05ANO+hfARz
   a2io/MEwWnh2NyNOAHRsDkOYDX+K1OLBjCLxBIDEorPhgcj7sHd5ca1KR
   yd0hTRmHkTHqSs9aV2Jam2TPCdNrjeCmV0DFoGNEiPGzGJe9mUdVOdZZv
   p55rcRzzF9XIokhxZBDf7jpO+ARTVNObDX5dgcHR5baPYrX0984FYj7/W
   gwgZEt/WVKcPj7XdYY5QRfgl7MY14Xu+fkBU1twPKSGx5eOKuS9cFW/2e
   w==;
X-CSE-ConnectionGUID: WRkblJOBR3K19VQdmLqrHA==
X-CSE-MsgGUID: 25bwrgI3SpK7wVgqrmnmcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76435663"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76435663"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:31:51 -0700
X-CSE-ConnectionGUID: exHVTTouTzO/tuKwb+cNag==
X-CSE-MsgGUID: PqmrS9DSRQicWsnh68/igA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="226285626"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:31:52 -0700
Date: Thu, 2 Apr 2026 17:31:51 -0700
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
Subject: [PATCH v9 05/10] x86/vmscape: Move mitigation selection to a switch()
Message-ID: <20260402-vmscape-bhb-v9-5-94d16bc29774@linux.intel.com>
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

This ensures that all mitigation modes are explicitly handled, while
keeping the mitigation selection for each mode together. This also prepares
for adding BHB-clearing mitigation mode for VMSCAPE.

Tested-by: Jon Kohler <jon@nutanix.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 002bf4adccc3..636280c612f0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3088,17 +3088,33 @@ early_param("vmscape", vmscape_parse_cmdline);
 
 static void __init vmscape_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_VMSCAPE) ||
-	    !boot_cpu_has(X86_FEATURE_IBPB)) {
+	if (!boot_cpu_has_bug(X86_BUG_VMSCAPE)) {
 		vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
 		return;
 	}
 
-	if (vmscape_mitigation == VMSCAPE_MITIGATION_AUTO) {
-		if (should_mitigate_vuln(X86_BUG_VMSCAPE))
+	if ((vmscape_mitigation == VMSCAPE_MITIGATION_AUTO) &&
+	    !should_mitigate_vuln(X86_BUG_VMSCAPE))
+		vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
+
+	switch (vmscape_mitigation) {
+	case VMSCAPE_MITIGATION_NONE:
+		break;
+
+	case VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER:
+		if (!boot_cpu_has(X86_FEATURE_IBPB))
+			vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
+		break;
+
+	case VMSCAPE_MITIGATION_AUTO:
+		if (boot_cpu_has(X86_FEATURE_IBPB))
 			vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
 		else
 			vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
+		break;
+
+	default:
+		break;
 	}
 }
 

-- 
2.34.1


