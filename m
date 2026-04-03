Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817633D0917;
	Fri,  3 Apr 2026 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236352; cv=none; b=O05HecDAgiTAqUOiETYqIgedaJJhGK6pdID4dh+cYm/3Gl9IFfdzVXmZ/UDt366tcoAtY4Uw9eqbu0l12iwS32cyxkIHZnqQYm8AGdWKx3bONracFghqqw6JKUYXHn73bdpmQnzrw5EH3l0btI9s0jaRzzDxN/nxU3/gc8tUwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236352; c=relaxed/simple;
	bh=fVrIBw5Vas4Nlxh8fzTuiZw8BZ8DqhTsvxhfy1ry3WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXaFWnR93P4GfFFN7PAXOlVEUlhUHxue7XDmu5s9udnVQcRNFLY/b+6TTID1WhbMgwrpLe3Rat0CHevIzojFK48nRmA3DcW/KG+aH+ON6VeYmd3hx6RxXTw80pF+xdC+0XfmsI+YLNh4tP3LJr5CEuJ0dxrshOgob133X+bH10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Z7yYun9k; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z7yYun9k"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9E94F40E00DE;
	Fri,  3 Apr 2026 17:12:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OGwgTnufKYB0; Fri,  3 Apr 2026 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1775236343; bh=fF/bH0YV6SXfwCkNBOegEFdryWWQdJAU3GXAygSoFQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7yYun9kWI5p0Rzi7lwhMbJNjyZ/TZFO+3hY3DAiu0qBTfdUnfnpDJSPPpwPg6nKL
	 vZAvKHuh7Eh9ozTwr15ZoqWlKAHtqH8n5W2SrSuJCzRkJ1GzSdboAelLXNkleX/CHP
	 TooYm7X8R7M/Qgn6WlUgN4kBeXsY8fCsoqEGgQm+RT3Ew8DtYVChHj49WCqDTLLlf4
	 kFaL1ND+7/S/bY31oHg24/WTylBSGyUsEJyXcLnPZUzeltH2ZH+PYTdEQPrZeQI9/w
	 6aVrO6f5u4RAs8vbqj4Wa5HygKIaDZwz3IjFHDUjUzVTc9PefBJdPjt9MOACbc5E/8
	 Ce+Yj+8/2gOkoUbtZNlJCPmvqvqKs5pNttKX7KdTX28O0wwxDUnW3ybS2e46ne+3H1
	 MO+oOrjdU4Hr0Btgn+uOea2qt3aGUBehTS0hDX45VDCoC8kbS/U6c0UznIhrXFhU6t
	 wa6XhWGoG1jKTp+BNTyDBwWfaB86GbncobZDq3kCVtgbvLn/k6kW69CabknkaM4bi+
	 Tuto3kTKRL9NFAg3PPhGnbK5yZtF0dXYhpl4Am6ku6eK94Myr6I8bGX6umNPboPbn3
	 pGSV8cmCb87dKQKoY22Ao3r3aUq8caqFRuGVP+nfZRLHIPYrhi8CSb7eYsDlLoeIPG
	 TSxjtRvBN1vzIevSkedDBMcc=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4D0F240E0163;
	Fri,  3 Apr 2026 17:11:46 +0000 (UTC)
Date: Fri, 3 Apr 2026 19:11:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
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
Subject: Re: [PATCH v9 01/10] x86/bhi: x86/vmscape: Move LFENCE out of
 clear_bhb_loop()
Message-ID: <20260403171145.GFac_00XdoXprYJSM3@fat_crate.local>
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-1-94d16bc29774@linux.intel.com>
 <20260403151630.GWac_ZzhQZj5LUDlRf@fat_crate.local>
 <20260403164552.chdvvmdfaufcgxzo@desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403164552.chdvvmdfaufcgxzo@desk>

On Fri, Apr 03, 2026 at 09:45:52AM -0700, Pawan Gupta wrote:
> Thanks.

You don't have to say "thanks" to every review - we're one big family.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
