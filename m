Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFE32FE04E;
	Thu, 19 Mar 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943523; cv=none; b=M/ZL7/UVW2lqWtlD+OAxRGw0LVw2PX0qekiuor5a2lzh0eOLVSIWsxy4uodeXuhaA44NHYsvkQGrQPy/c0QePXN2wNzs2fp3j0efqgLrMuy85MDoTA2PeodnVNer+Y6TgkzY4UoJGEx8eya1fuF1jcO3HX9LZy9M23gdRBmM54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943523; c=relaxed/simple;
	bh=A7v99qTn7n6Y+7D4/+hynEK3V5D/D2HZPsLo4XAffAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QksGXEH+/EeU6J/H4L57wDWsKIbLLBQ4VYH3VktOa1N5/eYJ8yz0phWEyw6so9tt2wYmCbW7r/1L28eS1zedYSBantvSHkcKb053dpZf95kg0Fz0oyVToVMfbtcQgWhoBZlx/tpw2tUHt+1pCHxFpAH4RjFRXf9F5tCeBo0L7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4RQnt2N; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4RQnt2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773943522; x=1805479522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A7v99qTn7n6Y+7D4/+hynEK3V5D/D2HZPsLo4XAffAw=;
  b=X4RQnt2NjA7suOUepMPdqN1LKZc+gSJ81Z1I9UqP/BtcXCOXOKBpNf4i
   V/XT+aoH4RLEg0TchKrcA/yqV29Udpht2A7si83z3Dhebtl92VdmrNQeR
   2VFq+vHRF8UytF3iKkJVDioRSDPvrvIsSXDF5PgyoTSW4RIfzXLtrgFb+
   r9oQbW3ObFEJF4vOAvy/JSfkA6C+sCNHX7uvgCEvqQH5iLzJsYRnBrY3i
   fkAzaAfiUnn+2JDWJApXuyYO2wkib61Oewy9B0hd2CWc6IxKRY1U4mFz/
   rZoLZvRF5t49ClJDG2K7JEoH1OZiA1EF9l6pRyD1DCU/aRYZBORYlvA3m
   g==;
X-CSE-ConnectionGUID: /qIP/sxRSb6LEENN/VBWCw==
X-CSE-MsgGUID: ViZWq+A7SA6WWS1zerUwAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="77630713"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="77630713"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:05:20 -0700
X-CSE-ConnectionGUID: MVNrfnRkSEKpbU0POLjG2Q==
X-CSE-MsgGUID: 2DFpyhNsRCKdPC9TBD/Tug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="253517197"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:05:20 -0700
Date: Thu, 19 Mar 2026 11:05:14 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: bot+bpf-ci@kernel.org
Cc: x86@kernel.org, nik.borisov@suse.com, hpa@zytor.com,
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
Subject: Re: [PATCH v7 07/10] x86/vmscape: Use static_call() for predictor
 flush
Message-ID: <20260319180514.63l74goaku3nx6dg@desk>
References: <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
 <dfba37ee6cd5de8954bbc57d18af3e4865e35cdda8535d890ae6380e4a1cc0af@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfba37ee6cd5de8954bbc57d18af3e4865e35cdda8535d890ae6380e4a1cc0af@mail.kernel.org>

On Thu, Mar 19, 2026 at 04:56:52PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 68e2df3e3bf58..b75eda114503a 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -144,6 +144,17 @@ EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
> >   */
> >  DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
> >
> > +/*
> > + * Controls CPU Fill buffer clear before VMenter. This is a subset of
> > + * X86_FEATURE_CLEAR_CPU_BUF, and should only be enabled when KVM-only
> > + * mitigation is required.
> > + */
> > +DEFINE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
> > +EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);
> 
> cpu_buf_vm_clear is defined and exported here but appears to have no
> users. There is no declaration in any header, and nothing in this
> patch series references it.
> 
> The comment describes CPU fill buffer clearing before VMenter, which
> seems unrelated to the predictor flush static_call conversion that
> this patch is doing. Was this included by mistake, or is it intended
> for a follow-up series?

Agh, that is introduced by a wrong conflict resolution during rebase,
removed now.

> > +
> > +DEFINE_STATIC_CALL_NULL(vmscape_predictor_flush, write_ibpb);
> > +EXPORT_STATIC_CALL_GPL(vmscape_predictor_flush);
