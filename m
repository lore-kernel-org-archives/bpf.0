Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAA61DEFE8;
	Tue,  2 Jun 2026 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438154; cv=none; b=nxEsJq+nLxTke8N691vbAsA3sxQZDVX5WxMrUsGMeAM9+30bHBb7a2WQIpJ/3L9JVQ+FWOR7SXMXckP+1o4wUuwXFYHO1bbX9nNnZNdlDvOQVy+HbH3vjTcKeG2iqHxYU5spgsEKYWmL+Fqy8+/+GUsR4mCqCg5GS1A2RLQPlnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438154; c=relaxed/simple;
	bh=GC8FjW8eAZZqSEHEtIR7QWUFGmOxnTJ1Nu6ikhwgeQA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SLcSrqtJOKocTBzje9AMR7udXd4oxOm1hxrQId8z3nTzsXXHtj1ladl+A80cRGxYY723Gf/TuqdSM4XWoUl1FMAijufiZpginbMIz9+4AY7UCGOIfGRtgfx1z6B/bgN6VB934zNUiEwXcRtmSENxRzg+L9+Oomg4z9+tsu1EK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LezzoyJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LezzoyJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D634F1F00893;
	Tue,  2 Jun 2026 22:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780438153;
	bh=GC8FjW8eAZZqSEHEtIR7QWUFGmOxnTJ1Nu6ikhwgeQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LezzoyJOYE8E5dHI2kTrX2OlVW8csGBo71kbltsEIXgUg7b3ekMDmNG6Bb/sOKisP
	 mBAFZPTtkKRnHQD4pmKo5hbhuMNRyNUbc3HkAm4ILzgTZJrmEO2mPVL83QV0lxShjh
	 p6zpwO8u9X+6fFWJDWQSKUAh5SKN43wkDR4DLRaQ00acWtw+On1hfmIWtMot7YOGsO
	 xUGHWBXkhk/Ujm73YVH8nRDI4SCq8HH8XZzGujRj1bbkqOfqznKCS52wriKePD8x2X
	 bcEt7+QCl4d/m8RdICey8u64NsLkzsUmcx99k6ZMKkmFyW+YpDiE98wvCCVl1FJfyo
	 gAdpWQlO7N+AQ==
Date: Tue, 02 Jun 2026 12:09:11 -1000
Message-ID: <8f133924fbf8d259340f3057e505f663@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: bot+bpf-ci@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	memxor@gmail.com
Cc: peterz@infradead.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	rppt@kernel.org,
	emil@etsalapatis.com,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Replace scratch PTE atomically when allocating arena pages
In-Reply-To: <f45f02410d23c99d14f3577da9b27a327816b5a0904bdeefc8e229eac760d1cf@mail.kernel.org>
References: <20260601183728.1800490-1-tj@kernel.org>
	<f45f02410d23c99d14f3577da9b27a327816b5a0904bdeefc8e229eac760d1cf@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, Jun 01, 2026 at 08:15:34PM +0000, bot+bpf-ci@kernel.org wrote:
> After the real page is installed without a flush, can that stale
> kaddr -> scratch_page translation persist, so that later kernel-side
> accesses at kaddr reach the shared per-arena scratch page instead of
> the freshly allocated page?

It can on x86, but it's harmless: that CPU faulted on an unallocated
address and got scratch-recovered, so reaching either the scratch or the
real page is fine. No flush needed.

Thanks.

--
tejun
