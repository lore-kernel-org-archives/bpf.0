Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F83CF673;
	Wed, 24 Jun 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323402; cv=none; b=hBcBXakCflAg71E9e2n+uhSBWeWFvtxHIvd4xcmkvisEsTNMgkXnERlWel9T12p5dwlvU9Bw8N/Bz4j0jA2JyJwW+3t8v0yIV3mb8MbMtl4eOZFve2be2X321cs49jQYwZGnJUTrCvYLICW0uIOf0um8+1VWHdeqxBS8/3ybZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323402; c=relaxed/simple;
	bh=pvnvhqZtttLgUh/iGaCD+Nf+Eujn/MfYhSCE8ekvYsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PATWUdP2VYfb/X4V2zxVRnr33HqJgXod+BgI7jT9QQce6kE09IgMU9nYpiZAC1cHe6t3F+vLX0bGchKjbXB7U24X8c2DxPVFMi3g1lBAElH9VTT3MA7fRTVBcJE0I9Uky2CHynJbWDyL/KOQrBuGiIqkAJgD/NY8o9GoG+SDRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAEjwEuR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAEjwEuR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782323401; x=1813859401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pvnvhqZtttLgUh/iGaCD+Nf+Eujn/MfYhSCE8ekvYsM=;
  b=HAEjwEuR/Aw56lJysbJSZY2/VAJTF4NZZ9OtcVVd4u+mMctWZUELGFmX
   CqNnJpP7caFUIs3JpNgJzO/h/ozYi3E4md+OrUcuypW4xoRmT2nzG1IaE
   fiocqT2gGd3gp+FXwC8ML8is7rWYiz5W9sGVb+UDXfwz71j+Lf79reTKJ
   2iGO8vS2wUl1XR98oKXnf1Uk+d3J9wgEAv20Gzh2vrRdPtweZ5dGhOmbR
   bLRLqZFiWwMbKMM4/wouZk5gNye/KtoJXQMr/xgNptYh4rGw5fhZ3sGVL
   E1UjN9ntN+U5idm6IRvBIvjcXeZCKLAAm85TfAQK3CM04VTGGL9kIucvG
   g==;
X-CSE-ConnectionGUID: 5pkuWLGnSAm1AGtRZ+Wfeg==
X-CSE-MsgGUID: hOjwPh7iTkqB4Q2B5IukQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82864226"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="82864226"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 10:50:00 -0700
X-CSE-ConnectionGUID: yQf/hKEzTpyJ5iZ4NKPyOg==
X-CSE-MsgGUID: ErkjsEOgSnmTKFZsTBza9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="249796254"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 10:49:59 -0700
Date: Wed, 24 Jun 2026 10:49:49 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
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
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 02/12] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260624174949.zdcawcbjnlqsimo6@desk>
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-2-76cbda0ae3e5@linux.intel.com>
 <171efe97-fd87-45c1-9913-ff62eacab400@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171efe97-fd87-45c1-9913-ff62eacab400@suse.com>

On Wed, Jun 24, 2026 at 03:12:28PM +0300, Nikolay Borisov wrote:
> 
> 
> On 23.06.26 г. 20:33 ч., Pawan Gupta wrote:
> > As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
> > the Branch History Buffer (BHB). On Alder Lake and newer parts this
> > sequence is not sufficient because it doesn't clear enough entries. This
> > was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
> > in the kernel.
> > 
> > Now with VMSCAPE (BHI variant) it is also required to isolate branch
> > history between guests and userspace. Since BHI_DIS_S only protects the
> > kernel, the newer CPUs also use IBPB.
> > 
> > A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
> > But it currently does not clear enough BHB entries to be effective on newer
> > CPUs with larger BHB. At boot, dynamically set the loop count of
> > clear_bhb_loop() such that it is effective on newer CPUs too.
> > 
> > Introduce global loop counts, initializing them with appropriate value
> > based on the hardware feature X86_FEATURE_BHI_CTRL.
> > 
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> 
> Although AI brings up a valid argument about whether guests should be
> pessimized and fallback to the longer sequence ?

I don't disagree, but at the same time BHI mitigation for guest migration
is a different beast that should be addressed separately. A series that
adds virtual-SPEC_CTRL support is in the works. Expect the RFC to be posted
in a couple of weeks.
