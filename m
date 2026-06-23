Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F538C421;
	Tue, 23 Jun 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236145; cv=none; b=P6iglxOqESqb6ItA5Lx5mif7s9bQh7LsgcGQSVcfUnxmBkvaTrrQeriB/FYxPgLNmWBZYutXGi7nojucYum4g4pK52aOji1tQL0JfOn0kLoITr6A47jYmFI/KzAV4+nSKaJtcFG17Jzh7ZLx4s44zWpnqpc1z9CZMtIXxZE0kKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236145; c=relaxed/simple;
	bh=94D0wGLu9lcd5K0S96Sl3+6gcUnzDIU3puBcw/u2nY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezUNUy1RX5dP1R+TWJ6SjAqf8up2TQJfy8UD7VlbnOaORoB/yMF3dL6fHUKPnhw0s7JUDR1MQAEiwDlaQU3quFcaPM/XJuAPqOnndyN/vPSZf9MIabVKFTWU/MVuVBE+lclwrf80TTDxaEcTF8uRzn3iG02n8TQ9RMyvPAmeXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AclBI/fJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AclBI/fJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782236144; x=1813772144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=94D0wGLu9lcd5K0S96Sl3+6gcUnzDIU3puBcw/u2nY0=;
  b=AclBI/fJZ0248jHGU0RkGiNHLyqYK2CtiPbnySqHjdJmBeEl0lQVmN/8
   II56n20o87NbpE0kZR2itbLWpGkmt5285geSXH0EP1Og7pFcc1ojQyPII
   wqT5fHbrVFcIxNIUl/N1YjbqbYodxEm1IIoqxKW7YIbxmKINQ/4Thy8mw
   HpVeBIme1jiZk+Ta5CAwOQKeEmnbZ8OQeiRTNBZXMZ7CT/0etJHPeTu9T
   PxHftVMhqK5MQLO9cRaLBChwSzVWlqA6cLnNdj+2yTmWPSGLSzDzNoY9e
   Z5YmmWzQOWGbVCsBzHT17CIaBn/kBj+XUeWcKyDY1KF3b/xxSGkFGuZEC
   A==;
X-CSE-ConnectionGUID: DoIjqlqpSgm5Fu2WdnYaCQ==
X-CSE-MsgGUID: YF4pKXCEQ9uhnYrEVrWnOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82989466"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="82989466"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:35:43 -0700
X-CSE-ConnectionGUID: 5cmpgFLhTPuCgwM+dDNdxQ==
X-CSE-MsgGUID: r2lf2r41Qsq4OAltcWDl6Q==
X-ExtLoop1: 1
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:35:42 -0700
Date: Tue, 23 Jun 2026 10:35:42 -0700
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
Subject: [PATCH v12 12/12] x86/vmscape: Add cmdline vmscape=on to override
 attack vector controls
Message-ID: <20260622-vmscape-bhb-v12-12-76cbda0ae3e5@linux.intel.com>
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
index 38594df8859f..1320baf9264c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8342,6 +8342,8 @@ Kernel parameters
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


