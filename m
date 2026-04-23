Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700891FE47B;
	Thu, 23 Apr 2026 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924965; cv=none; b=UwuGQCmu0P1NYA9oX0+GIwgoie5VbCOTIPOy9okGOPVs5XB/mZfeM9FSzujzlIphvH9z6b5pH3i1HgfbE5GFpms9Dv6aZzziWoNJlzfwxUYuokMsZO5dqLlsxJi7Rvk67Iw73A/9XPooQwP5XbFZoKWOyIx2yDBYFyfAcFm8YO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924965; c=relaxed/simple;
	bh=Z+UBFYvZmhxdkKBWIZKrd5/Lkbp8grvu2K8zVnKyDK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkjvOgUNNo37vUeGB0JoQogiuMFKxLR4dE7mMP/s9ZGSITgvBVdhSOug2Cp85mOzizy4ZzA2gRgux3bGF3m4cdRgQNxevv8s9DcQhnrvjUVlObz5cHlOnyWMnK3txijkhlOZic9oM07Xr4UZjoQvjvfzJYP1aqQxrzEsQp59Qd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Exblg3AG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Exblg3AG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776924964; x=1808460964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+UBFYvZmhxdkKBWIZKrd5/Lkbp8grvu2K8zVnKyDK0=;
  b=Exblg3AGYLcGww4+Tx52lnsHknG7Q0JsMzujIw0UxDPIFY3OtFHMw5e2
   uf47RNa+S+xh0YnOGuROUbKiQTP7RudT9DPVNjUMdmFpPsX9zHOZdF621
   yK+Y5om8FSyXAxyTthZPCw0hX5iEhy15HtgeRGkVSZjLx98PyTRFXIFxR
   ltzXlevbDgHaJFcI483VzQ/zFpww+m+XhXfRzQjiwdvJ8vtalJHQjhHkX
   q8gP9ktfhlJ7bC+d/zLs2pUVOe8QXbRSpRklECwmh1Xyrw0L3IZkwPSuh
   Rk3WqrSRc+uJT85F6VhlOjIUmTtD34YjmBYVZ6Ea9j55TT3UxIZC/AjIL
   Q==;
X-CSE-ConnectionGUID: QbWuaUZrQX+bXA5PgE3yXQ==
X-CSE-MsgGUID: yrgCS/3BQWix/RzfbhOh6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77947588"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77947588"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:16:03 -0700
X-CSE-ConnectionGUID: /p5o7N/cQ5SRvm4VbwrMPw==
X-CSE-MsgGUID: fo4HVhffRFW5i3eqn2WaBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="229385064"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:16:02 -0700
Date: Wed, 22 Apr 2026 23:16:02 -0700
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
Subject: [PATCH v11 05/12] x86/vmscape: Move mitigation selection to a
 switch()
Message-ID: <20260422-vmscape-bhb-v11-5-b18e0cf32af4@linux.intel.com>
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


