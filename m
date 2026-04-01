Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F6313293;
	Wed,  1 Apr 2026 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031237; cv=none; b=RN8NZpY+fOFYIt4wUPMvoGijyBPCU4a1T4lfJQ0Z4wQTPjzcaaASj06QHW2QVOK9LfTh6ty9qAwLvwFpg6S87YLw+8vk2cFMyxGtJy8xZbHcJlXan0pZrRbuJkpHcbea6B8qD5i/F9bNIx4ZvlSllHvkkEjbCBY3ZCVPbqLcfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031237; c=relaxed/simple;
	bh=pKfBEcybALzZFL9h7jJzIO8omtnH+z8QFMPiH8hqRq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp5qhGJK8kloRS4sh73OD/H2KOHvKt4qWWnVIrU+gvVU87bMYCgTCFCC2mdJf/BXzsmQKPcUpvuM88X4eBIATn9nFx1CIBUtFYJACOakfIU6EY4GRCaJKanhw2QcDBY/WLNIIdnxyQ4M4De6g5wlj7aybOR/PetsRHyCR69j//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1oeOcm6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1oeOcm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775031236; x=1806567236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pKfBEcybALzZFL9h7jJzIO8omtnH+z8QFMPiH8hqRq0=;
  b=U1oeOcm6Dc7VsCHD0J2pyGq/rgbjtCumUbHG1xJr87gpTVXsmtNezTj5
   xUojFh+efYtuJMbxufWNzr1IMaihdOwM/+0lf7xmiBFJXXjeK0dxSTRd6
   npR945E8FZ/+dOJk7Ujho1b6J0dW6i7r6qC5M2EpiJZMJAvN7Zw8RI5Ha
   SuUJP7zVrgFs7tTgeeUUsoSa69UHCa3CU+a5BieBKg98ka/iuYHcdSLdF
   3cH4wz8rWktvQWoH8TYvCBY9UBfvFMw8srtFOvxzQmYW3lebhF3829DEl
   UJhx8HLI710poLvXwJSc36lBVpHxWCo3ELIi9eV/P/zqdobaTLlm2v/89
   A==;
X-CSE-ConnectionGUID: I5sd8vFmRKe6R1TBfcjxRw==
X-CSE-MsgGUID: WOXEgvwORru8B8O79Zdvdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87137772"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="87137772"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:13:55 -0700
X-CSE-ConnectionGUID: WWWEyMSfRqi1fazbT+7RqQ==
X-CSE-MsgGUID: nPzOmMCkTAqzSEss4p1HsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223728622"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:13:54 -0700
Date: Wed, 1 Apr 2026 01:13:47 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>, Borislav Petkov <bp@alien8.de>,
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
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 04/10] x86/vmscape: Rename x86_ibpb_exit_to_user to
 x86_predictor_flush_exit_to_user
Message-ID: <20260401081347.cfw6blo56i5vk2ji@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <20260324-vmscape-bhb-v8-4-68bb524b3ab9@linux.intel.com>
 <acwJVUeW9KoLft4d@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acwJVUeW9KoLft4d@google.com>

On Tue, Mar 31, 2026 at 10:50:13AM -0700, Sean Christopherson wrote:
> On Tue, Mar 24, 2026, Pawan Gupta wrote:
> > With the upcoming changes x86_ibpb_exit_to_user will also be used when BHB
> > clearing sequence is used. Rename it cover both the cases.
> > 
> > No functional change.
> > 
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> 
> Acked-by: Sean Christopherson <seanjc@google.com>

Thanks.
