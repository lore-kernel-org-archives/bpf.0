Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86E175A73;
	Thu,  9 Jul 2026 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601632; cv=none; b=TLO95Uu3594QZuPBMVz/I6oUHBLkS2iw2S6Q/xurAcnaQYcfvILyFiooIc1r4UvTwrK/zvukrodY65VasJtIyVFGIJJqmUlqqAAJbD4PG1zNoTfdC47LMzMEcr997i59sweZ9BbgVQ7Uo5y1dtKto7KkUdwIswLvfWIIIY8jJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601632; c=relaxed/simple;
	bh=UhNd1qyYkVLvCpT/UELRc02R+FO81RIZlTbnYq6g7Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntYEoNj/06+BjHc7pNE5xaWrLkZPt+nZil6KdpW/sruIo4Yc5a2wa3O9h5jjN6VoXQkVYv14OiMPD+RIyBKmbY3LeqEFzBO2DiGIf+ERYeJlZ9gF+3nEEJBbQWxoItlF8twQw/wK1uQjjTbyYi/ICwcUKYUiekUfuWt5NmOt9CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSx8KBYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSx8KBYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2261F000E9;
	Thu,  9 Jul 2026 12:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601631;
	bh=FC9MFe7HbooU5CANXSl1jvM6WkO22fSJR+L4v+f4h8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OSx8KBYAARHJO/liqXd0R569PzagVrb1uM/kqRz0PNASDSR/BOsJ0y0SVLS9s9m1Q
	 WwvZAtWT0X7xFbv437tEL6ZDcUCrA4EpOOIFWAs5+yo9OWe5lCSSYcvgUm2GQVeabS
	 0/1QU+O19hxO2DXBQ9OSClXbACeTtqh7NOOEGwXqV5ompy+lbfbWrY8s9wTdQFF4VF
	 8Hc/7X+7pIcVFv49Pjw/QE/Qs/Wrsc8DqeV83IlFZjtlyltYKvLzX8T7tv4oj+sR38
	 VPpmA3m4KLm75svMoUXXaO4qUd3WTuHp7OvWXFmOxnAu77K508OnlW8dM6bdQbtRU9
	 00ARzM/d9oz6Q==
Date: Thu, 9 Jul 2026 15:53:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 5/5] x86/bpf: enable EXECMEM_ROX_CACHE for BPF
 allocations
Message-ID: <ak-Z2mLTWFUbgMVF@kernel.org>
References: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
 <20260626-execmem-x86-rox-bpf-v0-v1-5-45a0b0ed4fe9@kernel.org>
 <20260626185945.2F7BB1F000E9@smtp.kernel.org>
 <DJJWUQWQ6Y6W.2J1E1SKVHQAPO@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJJWUQWQ6Y6W.2J1E1SKVHQAPO@gmail.com>

On Sat, Jun 27, 2026 at 07:44:44AM -0700, Alexei Starovoitov wrote:
> On Fri Jun 26, 2026 at 11:59 AM PDT, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> >
> > Pre-existing issues:
> > - [Critical] Pages freed from the ROX cache via vfree() are returned to the page allocator with Read-Only permissions, causing kernel panics on subsequent allocations.
> > - [High] The return value of execmem_restore_rox() is ignored in __execmem_cache_free(), potentially leaving cached memory as Non-Executable (NX) and crashing the kernel when BPF programs are executed.
> 
> The pre-existing issues sounds real and probably should be addressed
> before cleanups in this series? Or altogether?

Both are false positives.

-- 
Sincerely yours,
Mike.
