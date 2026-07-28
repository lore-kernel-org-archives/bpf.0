Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BD2BEC23;
	Tue, 28 Jul 2026 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275044; cv=none; b=F8HVvgoWd97LExgYeun28cgHYcMhi+vAnZkpMJw7iKgh3XNDC+jGxwwbAm5y5mO6qc2i/PqFEdqjr5OPORDAFQBT80eypF0V8l5NiVJbEUCPId3I8e3j3/illJMpCOmWKcCRQyzaiw6h0mx7Rd4M/Sg7/hnaWr+CQJHIHlmuQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275044; c=relaxed/simple;
	bh=ttO3jUQOcykznZwM5kwrVGObJj5pau9iJ/uwxTGbFGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTboYDYLk5aE33yBZezLG53IZn6wPbkw6Be4E5aXDoa5+AV5xbLr3cVeyDARCVrLFBZf8YArNWMRpmE21sml4pdL3EVoloMl80hpC6mtq2vwhQh/cgel9hcTvL2hSiin+VKFLGboOtTRmpAmPpsoPvCqkWf2OQeppwnoZ5gjRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPhHLZmB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPhHLZmB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785275042; x=1816811042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ttO3jUQOcykznZwM5kwrVGObJj5pau9iJ/uwxTGbFGg=;
  b=FPhHLZmBo+aNq8KKEWaei0mpxVyTMoqtzzkiQuHrNRrSOio7hyIn1A/r
   e+UmNbUAj6L8V4by3y3jNdeTwpKR9AYq7QeDbr8jxGlbCNWjnMOk8I8Tz
   NZdUKN4tZgKEM2hG/OTjyXwmQlfJg0Mo4jYYAP+F1vedNF2dMXtuuFvyS
   4bL7AtmPyjSUA/mmWJYU7VK7xAMilZpxKeeoLdG9F1g8hxWs5f6iMmcaP
   cY7KqAx+D8KqAUMbjrxxhN9yxkA8YGVXLhaoacvVVKQbO6BMW0XWQPFHx
   L7L1RDoguAeom8Pe+9m5pDDCLzEmCnL9OfZPVkvgA5DolgAwDQordrbNB
   g==;
X-CSE-ConnectionGUID: tgVoHBfoRj2+IxNXvHF0ng==
X-CSE-MsgGUID: AlKfOYCHSjiSr+v8i87UuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86065488"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="86065488"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:44:01 -0700
X-CSE-ConnectionGUID: rYbvIuCXRVGjCBGBY1Z7NA==
X-CSE-MsgGUID: qvIerpoSSS6fi7ir/MAg1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="256484577"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:44:00 -0700
Date: Tue, 28 Jul 2026 14:43:43 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>, 
	Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>, 
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 07/12] static_call: Define
 EXPORT_STATIC_CALL_FOR_MODULES()
Message-ID: <4cemrcri4enbau4wfv7rmdbnzxi24j2b7cmkjlczbdzhq36fmk@nrnfjspbd7ns>
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-7-76cbda0ae3e5@linux.intel.com>
 <ajvUp_kPJBRZ7k_p@google.com>
 <amj6eYOs70WUPGDG@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amj6eYOs70WUPGDG@google.com>

On Tue, Jul 28, 2026 at 11:52:41AM -0700, Sean Christopherson wrote:
> On Wed, Jun 24, 2026, Sean Christopherson wrote:
> > On Tue, Jun 23, 2026, Pawan Gupta wrote:
> > > There is EXPORT_STATIC_CALL_TRAMP() that hides the static key from all
> > > modules. But there is no equivalent of EXPORT_SYMBOL_FOR_MODULES() to
> > > restrict symbol visibility to only certain modules.
> > > 
> > > Add EXPORT_STATIC_CALL_FOR_MODULES(name, mods) that wraps both the key and
> > > the trampoline with EXPORT_SYMBOL_FOR_MODULES(), allowing only a limited
> > > set of modules to see and update the static key.
> > > 
> > > The immediate user is KVM, in the following commit.
> > > 
> > > checkpatch reported below warnings with this change that I believe don't
> > > apply in this case:
> > > 
> > >   include/linux/static_call.h:219: WARNING: Non-declarative macros with multiple statements should be enclosed in a do - while loop
> > >   include/linux/static_call.h:220: WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > > 
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > ---
> > >  include/linux/static_call.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> > > index 78a77a4ae0ea..b610afd1ed55 100644
> > > --- a/include/linux/static_call.h
> > > +++ b/include/linux/static_call.h
> > > @@ -216,6 +216,9 @@ extern long __static_call_return0(void);
> > >  #define EXPORT_STATIC_CALL_GPL(name)					\
> > >  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
> > >  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> > > +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> > > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
> > > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
> > >  
> > >  /* Leave the key unexported, so modules can't change static call targets: */
> > >  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> > > @@ -276,6 +279,9 @@ extern long __static_call_return0(void);
> > >  #define EXPORT_STATIC_CALL_GPL(name)					\
> > >  	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
> > >  	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
> > > +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> > > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods);		\
> > > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_TRAMP(name), mods)
> > >  
> > >  /* Leave the key unexported, so modules can't change static call targets: */
> > >  #define EXPORT_STATIC_CALL_TRAMP(name)					\
> > > @@ -346,6 +352,8 @@ static inline int static_call_text_reserved(void *start, void *end)
> > >  
> > >  #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
> > >  #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
> > > +#define EXPORT_STATIC_CALL_FOR_MODULES(name, mods)			\
> > > +	EXPORT_SYMBOL_FOR_MODULES(STATIC_CALL_KEY(name), mods)
> > >  
> > >  #endif /* CONFIG_HAVE_STATIC_CALL */
> > 
> > Drat, I forgot about this.  Exporting static call trampolines for KVM came up in
> > another conversation[*].  I had already put together patches to effectively default
> > to exporting only the trampoline, and also to deduplicate this code so that the
> > CONFIG_HAVE_STATIC_CALL_INLINE=y / CONFIG_HAVE_STATIC_CALL=y / CONFIG_HAVE_STATIC_CALL=n
> > implementations don't need to copy+paste the same lines of code.
> > 
> > The attached patches touch a lot more code, and will conflict mightily with KVM
> > changes I want to land in 7.3 (more use of a static_call in KVM).  But if we get
> > them applied (to tip tree) shortly after 7.2-rc1 and provide a topic branch/tag,
> > then there shouldn't be too much juggling needed?
> > 
> > If we want to go with the more aggressive cleanup, I'll formally post the patches.
> 
> *sigh*
> 
> So the patches build, but they aren't fully functional.  If kvm.ko is built as a
> module, trying to load a vendor module will fail due to the trampoline => key table
> only tracking built-in symbols.
> 
> Given that all of this is KVM, and that it's far easier to export the static calls
> if and only if there are vendor modules, and only for those vendor modules, I'm
> going to drop the aggressive cleanup and abandon converting KVM's exports to only
> export trampolines, at least until someone else works up the motivation to add
> support for modules.

Thanks for the update. Keeping this patch in the series.
