Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B62310777;
	Thu, 23 Apr 2026 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776925075; cv=none; b=jXFCBIvivshCYQPR2n95uk0TBjctDc3hgQAhY7dN/TFeFFaNwv1C9oX4DvF+nqQYBj+DUsOOSwyFhIpclUujf3u2EKSLMxAOb/RjRoFVSeLMiI4dgBZrQ7yGiVnuS97odp/hDp4hxzsj4DIhXKBIX5NPPsoaBMT+x2BvytzHf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776925075; c=relaxed/simple;
	bh=b6MuRVTf/ZgA9L22eiHzgpdsNzUtE5SipssmAjn0OuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5ziba7oKYUFVGaP7jrd+VeXjyqyMZt+ovYGo9LF5sd1095OF/LG4j71J+G87qPQrGFCU2EYlmatHqUtRGlzJ6CibBkxaD/EM6Kr20+E4mUEWTcMkUM3BE+FZx6PI/wEy1QPqhdCKgVeHnylRxEgVKXPSf2H34TPL9pZReCdRlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCj3YTNO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCj3YTNO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776925074; x=1808461074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b6MuRVTf/ZgA9L22eiHzgpdsNzUtE5SipssmAjn0OuY=;
  b=bCj3YTNOJJ+0bpJZbCMlkL2fCcPybdY6VP56M0YVzUXVDG4T2jDLhWr1
   4x2tRTBzHZzTu5TS5+870ntFcd7jLrceDUnGp0RpZjT1RDlqPlr0gqB09
   bIVyexesLw1Sh34n33kgSSxs1MMQ+A/dtABUv+uuoaMV4KGOzL9K1l+fa
   mdNB1oFKeTfOTdKPwg6fAwveXOf7vIXmkzz64GsxINQnw2hh2aJzNcs96
   yC255KgLFuoePoXI3klMl8g5oCsn/CA/3R/s33FqGiwBD+ITfHTqTqgfq
   OA29AgZAWOXwTUSlvDJzzaomMstw8Jc1ns1Xf/C4KR/WHP/mtoxGKuuCc
   g==;
X-CSE-ConnectionGUID: RDG7+Fw9SwKy91R9WQ55TA==
X-CSE-MsgGUID: fUtcQbmTT4ij4CWLdm14OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="100539497"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="100539497"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:17:53 -0700
X-CSE-ConnectionGUID: S+yNJqCWSamNx0R/Nab0pw==
X-CSE-MsgGUID: ldGozOmnSMCeaNdo8u1hhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="229899249"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:17:52 -0700
Date: Wed, 22 Apr 2026 23:17:52 -0700
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
Subject: [PATCH v11 12/12] x86/vmscape: Add cmdline vmscape=on to override
 attack vector controls
Message-ID: <20260422-vmscape-bhb-v11-12-b18e0cf32af4@linux.intel.com>
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

In general, individual mitigation knobs override the attack vector
controls. For VMSCAPE, =ibpb exists but nothing to select BHB clearing
mitigation. The =force option would select BHB clearing when supported, but
with a side-effect of also forcing the bug, hence deploying the mitigation
on unaffected parts too.

Add a new cmdline option vmscape=on to enable the mitigation based on the
VMSCAPE variant the CPU is affected by.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 Documentation/admin-guide/hw-vuln/vmscape.rst   | 4 ++++
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 arch/x86/kernel/cpu/bugs.c                      | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/hw-vuln/vmscape.rst b/Documentation/admin-guide/hw-vuln/vmscape.rst
index 7c40cf70ad7a..2558a5c3d956 100644
--- a/Documentation/admin-guide/hw-vuln/vmscape.rst
+++ b/Documentation/admin-guide/hw-vuln/vmscape.rst
@@ -117,3 +117,7 @@ The mitigation can be controlled via the ``vmscape=`` command line parameter:
 
    Choose the mitigation based on the VMSCAPE variant the CPU is affected by.
    (default when CONFIG_MITIGATION_VMSCAPE=y)
+
+ * ``vmscape=on``:
+
+   Same as ``auto``, except that it overrides attack vector controls.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3853c7109419..98204d464477 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8383,6 +8383,8 @@ Kernel parameters
 					  unaffected processors
 			auto		- (default) use IBPB or BHB clear
 					  mitigation based on CPU
+			on		- same as "auto", but override attack
+					  vector control
 
 	vsyscall=	[X86-64,EARLY]
 			Controls the behavior of vsyscalls (i.e. calls to
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fbdb137720c4..4e0b77fb21dd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3088,6 +3088,8 @@ static int __init vmscape_parse_cmdline(char *str)
 	} else if (!strcmp(str, "force")) {
 		setup_force_cpu_bug(X86_BUG_VMSCAPE);
 		vmscape_mitigation = VMSCAPE_MITIGATION_ON;
+	} else if (!strcmp(str, "on")) {
+		vmscape_mitigation = VMSCAPE_MITIGATION_ON;
 	} else if (!strcmp(str, "auto")) {
 		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
 	} else {

-- 
2.34.1


