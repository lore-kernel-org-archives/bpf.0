Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5D283C93;
	Thu, 16 Apr 2026 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381170; cv=none; b=h6raE/hUlsn7BNvfMMrWlYZlGEAu7g4A29j5SbFzZGSrqR3cwza5umbKcAnSEsWi6h4EhV2hMbAxFWj7FMyCYNmlVAQrwZtAjJL/zrZL9q8uW+rZbNjDUMbu0OscDGRg1m/oj8Vr+LpR7cxbNxtaMWcauEZDzo3hG9RWsOtxJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381170; c=relaxed/simple;
	bh=mktI0GL8Ho68lYkNQM7lPXFpO5gRK+biY2qAS/eva+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzTsiE6a4X+YbOFZLm4HrkDsPqXEtatJMQlnnjGVpRCZ2UgUZNibNv9DOqmFywUn9fcmZDNGA2EWe4STw+AWVzrgxh1hxkQxyZXrC2zwbwHt7GWzRDc1eba/jSfNyHf4Fu59XY6J1g+C/WdhDq9fI/fJOlpea/Wrg3mRc84bYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUJ4lY8H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUJ4lY8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776381168; x=1807917168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mktI0GL8Ho68lYkNQM7lPXFpO5gRK+biY2qAS/eva+4=;
  b=nUJ4lY8Hk+tEuKIJe0nx+qM0bwGYoEJqstbiL4wP3T/vpci42QQK55ik
   xtvzLvKKjiJM+7ftv00TYo9OfITvkbRkC9+QLLf+wEcypt0O7tK6rGUeW
   xi5iQ0Vg/JanfuPnIMjgz2fKeUJ4bc9wg9xZ6HKqFWnY76tl4mfWOb9Ys
   ujZvKeoyC2iygrnAONnAxqCE99w2+vUAczylkHuBfcUTB9A2E8FsJ1f68
   jU/PPWQBlovC8MQIwaMkmaCZMndqqOYNHoGEP5ol9D3Gew4Ks8X51HhKt
   4Xzszl1n0yjo+D9KInWdFkv4j3exF47YodDeeRODgSXxZrKEiS6+DXcp0
   g==;
X-CSE-ConnectionGUID: egg2riftSl+kccWvlUQJ2A==
X-CSE-MsgGUID: 0Cy0D3nwTG2mGKWUFGHttA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77302291"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="77302291"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 16:12:47 -0700
X-CSE-ConnectionGUID: MPoatUXlRk+kaBEhXwEhrQ==
X-CSE-MsgGUID: r3QQ+mJlQkCflmgz+x26mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="231123970"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 16:12:47 -0700
Date: Thu, 16 Apr 2026 16:12:34 -0700
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
Subject: Re: [PATCH v10 08/12] kvm: Define EXPORT_STATIC_CALL_FOR_KVM()
Message-ID: <20260416231234.g6buu3rm2swih35z@desk>
References: <20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com>
 <20260414-vmscape-bhb-v10-8-efa924abae5f@linux.intel.com>
 <aeFmYd1ybZnVlAYW@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeFmYd1ybZnVlAYW@google.com>

On Thu, Apr 16, 2026 at 03:44:49PM -0700, Sean Christopherson wrote:
> I think I'd prefer to require EXPORT_SYMBOL_FOR_KVM and EXPORT_STATIC_CALL_FOR_KVM
> to come as a pair from arch code.  I can't think of a scenario where arch code
> should override one but not the other.

Right, will change as you suggested.
