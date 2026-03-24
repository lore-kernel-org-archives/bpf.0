Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85383093BB;
	Tue, 24 Mar 2026 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381914; cv=none; b=R7ZFhKm7DyDwr//WxUsGebNuKPEspc3jcsil2W8Mccd2vcJI1csyja2ebnIlb10dFwHHI3WVCHcXkQpmFvSF1CjSz+WeOOqulE40qBnPAY2h6CE0Uu8WSL7ufChbGrtNbwp637wHspJmOVl7TQPg6BZ5YP3VAoC+cKGnyrHCBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381914; c=relaxed/simple;
	bh=9qUWq3HG5BEdyJlujwZ0hO/tBuUYXEGWeEuH09n4QVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKMzWgwhkrjISRrfS+dwpm1kvVATURoC+C5dImkfKwwfg9ivpYM3yAb4X6MsZo/GKVtxsQIsg3wANA9Wp/Byv6PoYEr7oOmhxLK1/wbfSYpH4/q0ejejj+WJ0gMq4DUbJH41I80/OHdoN3ZvNrGyQXNja/Xhz6SCqmDBRtbIAl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VY+c5yQU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VY+c5yQU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774381913; x=1805917913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9qUWq3HG5BEdyJlujwZ0hO/tBuUYXEGWeEuH09n4QVk=;
  b=VY+c5yQUoG0jO1mBS1gx9NQvgEUSd64ZoX/oQPmJQBEIOnRkyv77nQoh
   ZCl0rn8ssyDR5XHEf6O3gQ5RYFli0QeXfrDmYwCK/ZTPLqRG438cAxv1l
   UmpUyNBdor1VT2HBavNsKCuWH7Qr0CZnYWFz72UKnDkpWVCIxMaDBlC6F
   YhWLzvcy2cd1wTbWQKUCXwg2rkhu0CoUOmIT2wj64+Ina9dxdLcP5HQ9W
   e13Hf9ONGdyeLQVRS4Vd8tgum3DPCkl6SKycc8GtV53q9p6kzQT8vd7cQ
   tl56++IL118ITKH4wl+oBik8CNtuZOOH6bPpty0LHl6nl3nAVHhMxmxC0
   w==;
X-CSE-ConnectionGUID: KoQjtg0eQGK4QEUZ3YKFzA==
X-CSE-MsgGUID: trUSNI2VSRCxEzX3yvJcYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75381408"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75381408"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 12:51:52 -0700
X-CSE-ConnectionGUID: lU4K3NZTS3i673fsg3OZhA==
X-CSE-MsgGUID: zizVKckFR4q2TH6ISfKkQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221568862"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 12:51:50 -0700
Date: Tue, 24 Mar 2026 12:51:44 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: bot+bpf-ci@kernel.org
Cc: x86@kernel.org, jon@nutanix.com, nik.borisov@suse.com, hpa@zytor.com,
	jpoimboe@kernel.org, david.kaplan@amd.com, seanjc@google.com,
	bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	kpsingh@kernel.org, jolsa@kernel.org, davem@davemloft.net,
	david.laight.linux@gmail.com, luto@kernel.org, tglx@kernel.org,
	mingo@redhat.com, dsahern@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
	pbonzini@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, asit.k.mallick@intel.com, tao1.zhang@intel.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH v8 07/10] x86/vmscape: Use static_call() for predictor
 flush
Message-ID: <20260324195144.c6gaxewnyojsev2q@desk>
References: <20260324-vmscape-bhb-v8-7-68bb524b3ab9@linux.intel.com>
 <901294cad0355c079f343400e594daf91c8c07f0ad0ef41064c746d96e8907bd@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <901294cad0355c079f343400e594daf91c8c07f0ad0ef41064c746d96e8907bd@mail.kernel.org>

On Tue, Mar 24, 2026 at 07:09:31PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index dbe104df339b8..b4d529dd6d305 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -503,7 +503,7 @@
> >  #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
> > -#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
> > +/* Free */
> >  #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
> 
> Should the corresponding entry in
> tools/arch/x86/include/asm/cpufeatures.h also be updated to match?

No, because:

  "So its important not to touch the copies in tools/ when doing changes in
  the original kernel headers, that will be done later, when
  check-headers.sh inform about the change to the perf tools hackers."

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README
