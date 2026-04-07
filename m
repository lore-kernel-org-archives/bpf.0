Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5E1A682F;
	Tue,  7 Apr 2026 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775600878; cv=none; b=n/S0PmwFij0JEFojwbFNbS5uN2/l1Yy2+rLly/xbmOGWJDo0gOTk1zhZtbQMG0Op8V3d7x8Oy4snorm5bcEDDDzbHxNOY8225mVUACOmbKeIC27QFKFgEN775ZgRwhtrzAUYUaIB6SGjv8i8zalP2DPjeAEW7i0lBZVt0d39dI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775600878; c=relaxed/simple;
	bh=uK2so+449fVDewAkzhkLGh5pYpxj0JI8+AxRt8nkkc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMRSVAUrulTQbeSGwJ81TY6dA+kIRJ7ap1KEmHjPzN7nqObcaIR+1+sxjYl8PSW/dKzLHc/L1xqpM1hGB6G+Kb/HtOepp/5EQWkKmjqDYp0bZzYMn6xW4m5ubjmLs78+iq8N/brlfREvttBzvns2TPS4/YifWUokiWRusKZlWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQWHy4OB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQWHy4OB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775600876; x=1807136876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uK2so+449fVDewAkzhkLGh5pYpxj0JI8+AxRt8nkkc4=;
  b=FQWHy4OB+ha1vvzz4XFTmswpUMB9MtiRjBNY+gVyRJfDajyd00LoWGeY
   oYUvObvMdnEm/vCNUZU5Ps1rWG1LbQuBdBfPPqMZNYgueEa4QeLUnYKOy
   AZ8/jH9o7Oh3quOGwFvUEP8J/efXXSP27grH+nevABvSVj/a7HdV1K/Tk
   Es/AynSdW9RAJzHxSEUW8+WroIKQafOIHkHIddhzvHifMPLARwnt730Rr
   QVOlAMMgl4Ol9/byWB3A/yQ7FBSi2/5EdaO7hMuG+ksokwCWVTfbRPpMm
   XUDYLWwJjNPxGq6ePX8VhZjel6bDl2pSXQXJGhtiV6WMQampqXmopKKAz
   Q==;
X-CSE-ConnectionGUID: 52crIjU+SFCtuSue1K2n6w==
X-CSE-MsgGUID: s4h5QCiwS+i8KGLUUcQrmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="99202728"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="99202728"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 15:27:55 -0700
X-CSE-ConnectionGUID: wKZVC/j2R2W5foBwbNucVw==
X-CSE-MsgGUID: GW5EjqQCTQO1e/H8lgmmAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="258719236"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 15:27:54 -0700
Date: Tue, 7 Apr 2026 15:27:38 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jim Mattson <jmattson@google.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
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
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	chao.gao@intel.com
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260407222738.lrartp6evfp7yhti@desk>
References: <20260404002149.wtayv6a64vzuppgp@desk>
 <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk>
 <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk>
 <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk>
 <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk>
 <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>

On Tue, Apr 07, 2026 at 01:53:24PM -0700, Jim Mattson wrote:
> On Tue, Apr 7, 2026 at 12:11 PM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > On Tue, Apr 07, 2026 at 11:40:57AM -0700, Jim Mattson wrote:
> > > My proposal is as follows:
> > >
> > > 1. The (advanced) hypervisor can advertise to the guest (via CPUID bit
> > > or MSR bit) that the short BHB clearing sequence is adequate. This may
> > > mean either that the VM will only be hosted on pre-Alder Lake hardware
> > > or that the hypervisor will set BHI_DIS_S behind the back of the
> > > guest. Presumably, this bit would not be reported if BHI_CTRL is
> > > advertised to the guest.
> > > 2. If the guest sees this bit, then it can use the short sequence. If
> > > it doesn't see this bit, it must use the long sequence.
> >
> > Thats a good middle ground. Let me check with folks internally what they
> > think about defining a new software-only bit.
> >
> > Third case, for a guest that doesn't want BHI_DIS_S, userspace should be
> > allowed to override setting BHI_DIS_S. Then this proposed bit can indicate
> > that long sequence is required.
> 
> That case can be handled by the paravirtual mitigation MSRs, right?

Yes. But, that was the part that received the most pushback.
