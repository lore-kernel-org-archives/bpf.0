Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC138F629;
	Mon, 18 May 2026 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134015; cv=none; b=jtEr9wK1oeN85FrLMoOa+uwrPN5GCmGO1kv+mj1yYil/ari1+bOFwRx8ukjDL/U/7B8EIS7cexB+dHVZ3YQpP78I+hNPVBPLGjG5OUMAkLWVOtkIXmSwnrwcsR2vmGuLC16pA3p/P4HWGprE6jMsK2m/xFX/KtqThsCI8xX/U48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134015; c=relaxed/simple;
	bh=nZ0D31rkJ58LmFaS2W1jBidt3T9eg8DSZrXA9r0f9Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykw6oVVxp7n6980qeeRHQr6vvFgXU0B5NJmSUSxmVfeCbeDJ0Bn+LISrtbW2v8274RkPpLZh8fQM5YqRxnK4UDPs0PaiYBDCsM4EcH/3bAOghP6UEOhJy9gYrU6HP80peMN/2277jJqwgXHXg0ls8wfmiq7D9JwY0yFYSavZ9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7U/5SfC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7U/5SfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245BFC2BCC6;
	Mon, 18 May 2026 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779134015;
	bh=nZ0D31rkJ58LmFaS2W1jBidt3T9eg8DSZrXA9r0f9Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7U/5SfC8PP4wcXOspJBnyLZb8fjuk1HP3PEPyF0HIn2Ol0sAqvYeirvFb76FXTEV
	 7bP5b9jtSmSp0lbLozkGPZzV2ePN+x3oKsnbmcjC3dGCgssQwrpbZEcc4f+Yrh9Zua
	 DriwYDD0PKgwef2oYAWjf8kFFx4pIo645Am5zxDzXKIwL0mUfQWQn+WqmrU6EUuGMC
	 4oHyw0BCaJQeh3JHzSX28eKEPukAnj95j2ZxM40kb+iIrvhAqcNHOH2uXrsebtcEn+
	 cLD/nrjnJYs4zdQz08NAjMpyWK/YGQqSjN2NP8c+cBNlGfIOS3hLZ4dA+dGnlzn/sI
	 j6XR/xgodjqmA==
Date: Mon, 18 May 2026 09:53:34 -1000
From: Tejun Heo <tj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: Add ptep_try_install() for lockless empty-slot
 installs
Message-ID: <agtuPrgIDNKSu2Oo@slm.duckdns.org>
References: <20260517211232.1670594-1-tj@kernel.org>
 <20260517211232.1670594-2-tj@kernel.org>
 <9ba50fd2-077e-4291-9276-9adb18186873@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba50fd2-077e-4291-9276-9adb18186873@kernel.org>

Hello,

On Mon, May 18, 2026 at 10:06:29AM +0200, David Hildenbrand (Arm) wrote:
> On 5/17/26 23:12, Tejun Heo wrote:
> > +static inline bool ptep_try_install(pte_t *ptep, pte_t new_pte)
> > +{
> > +	return false;
> > +}
> > +#endif
> 
> Ehm, what?
> 
> This is a very, very, very bad generic idea/interface.
> 
> On which ptes is this supposed to be used? User ptes or kernel ptes?
> 
> Surely we don't want this on user ptes.

Yeah, this is only for the BPF arena PTEs which are already managed in their
own way. I'd be happy to place / gate it however appropriate.

Thanks.

-- 
tejun
