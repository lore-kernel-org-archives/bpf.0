Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E392DA756;
	Thu, 21 May 2026 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348494; cv=none; b=oDDDgCc9gTeKgosv4ISZlyK/eAkESDUqrS7ROddpS7nJ3ejtpGMZCNAAWCGtLFERruonoirUAQhZs8kqL9U1IiLZoPNJa4/FTVPAqC0AGoRu6AX1LbqTMwt7NH9ZitrWrsYOD652psZWBgdS1K6znXrsOQpu/QpYEl6J9HIsils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348494; c=relaxed/simple;
	bh=dEV5Zt1S6CmNiERsf9vkxCuHhB8Dh03SNF+mDaPEoXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uje8wshdjz6ZmwbdEiNqQuqF+LtXp3XtMKzWZLT+LlVdhIFIk9WHnrzB3MlyMAfOVm1d064B9tqjPBTFWSu0rWfcZJqlZ6MJ0XhYa5mXk0w7D2rDG6OMOFHI+vmj9cLV5d24CC+Cjq5twchYs6xrex61bPMUPp29y757NHJoqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NuYmaioJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NuYmaioJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vbyMl+Arkun9SbcO90HXYgu4HO67jHkSgeXx2LBS3m8=; b=NuYmaioJKno6vrD57wWAFGzu97
	Xpm7PhVYjLakc5/UmsHEMtvegZDmh5IuEbrd2aZWRGQ6zfv01YLNjzWtpbXGbmc2lw5uUh/KgEZfw
	jsWTz3KyJsaRVoL8fdb03VrEb2mDJNQqTZCa6rF5DgaOfjILiaLmq7FOSUOjMaTdud+k2uX5PWgwU
	9MYrVHHuihZI32a7nlDTmEGqFc2fZrVybmeTIZ3NBUXKNLeUqRtXUI97HSuDd7VciapoBadUrGKOO
	HTawXdDsylVaXmsw/+IIPYQ/63Vte5zuwFl1P1h1pdyBbnL9wk1K+ZZZq+XNLrUQHJ+7DRSQceILp
	CHV3rAtw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPxoy-000000015I7-0W0W;
	Thu, 21 May 2026 07:27:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BD703300446; Thu, 21 May 2026 09:27:54 +0200 (CEST)
Date: Thu, 21 May 2026 09:27:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
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
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] sched_ext: Sub-allocator over kernel-claimed BPF
 arena pages
Message-ID: <20260521072754.GF3126523@noisy.programming.kicks-ass.net>
References: <20260517211232.1670594-1-tj@kernel.org>
 <20260517211232.1670594-8-tj@kernel.org>
 <20260518072042.GP3102624@noisy.programming.kicks-ass.net>
 <agtt2dEjS4Qg7a_P@slm.duckdns.org>
 <DIM6W7GRZK2N.14AH43S1XTFCG@gmail.com>
 <eaeb316b7a45956ed5f335050e6e9538@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaeb316b7a45956ed5f335050e6e9538@kernel.org>

On Wed, May 20, 2026 at 01:47:32PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, May 18, 2026 at 04:26:11PM -0700, Alexei Starovoitov wrote:
> > Well, this gen_pool based allocator of arena memory is a temporary hack.
> > It's ok for rare allocation like in this at scx init time, but not suitable
> > for active arena management. We don't need to expose it beyond scx.
> 
> I see. Peter, as Alexei is already prototyping a slab-based arena
> allocator, how about keeping the gen_pool layer scx-local for now? Once
> the proper allocator lands, scx can switch to it and the custom piece
> goes away.

OK.
