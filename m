Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1531F9B1;
	Sun, 14 Jun 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781468990; cv=none; b=hTQ34KVK/5irGLmii5JOdgS39udne++3j+NvNIadPL/pe/TKtt5fouiXvGH+nFHlsANlHcuj3TMPMWREX0BPhQHA4DFoa73COf8M30y8LeBJzyzZqyGZ7jeZxLt/lI93zEzYQqdsSc1NeGidqbt7Oygfh/B6v++bOVnBT6rBfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781468990; c=relaxed/simple;
	bh=xt/1SlqcvQVoUOqBcxXTlXWLXQLLabto2bWa1iYvCzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psElJ0lD8y011/i5qX7xJrDp/G0Y2/X0wnQzbhvxOoSmumVJu+BhuqKaFd4hS6fQ/tt33cHq9L39ut4om2FIG5MvpAjGxNOpAnqsxu6G897pYz0DIwOkkeV7e9/aMyWzTHl1JuX6TX0ITOGaotsSGWeAuluJLGKY4cGa4S3Wo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYDwSm03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYDwSm03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931491F000E9;
	Sun, 14 Jun 2026 20:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781468988;
	bh=cmUoJYqaVdVHGV7w7+TmyHFK+lvk5ocel9J4vmj8ogo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aYDwSm0383Gdgkg6dRBN6iou+Hh0+xVWh+A7/C9B1O+WfdGdJs/gZ2xxZ2mZFqQrG
	 3GRC3iiE++STQf19+vmj//iQnB2GlGhRi+lVqeC7AsCA7kZ5cjkmM82H19CBDRqJ+v
	 NFX5jO1S62yAnh9albUSwgXsIezzCbzQIDdSGMJtQXUmHurn3+mujGe+NHrCLD+Swf
	 f03DFhawbt9ZfNXpmeI6X2iKBw6TxVY9Ggfv6WMi8WdlGrAx8slDoWior29fxjbHb8
	 I+CsDpirW6/7E/qUt620Y41Lb7Mpty/4i37thGO6YCOHJBUCkpuu4DRe8JCUN9cDbb
	 wbRQXOn7xHBSw==
Date: Sun, 14 Jun 2026 10:29:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: Add ptep_try_set() for lockless empty-slot
 installs
Message-ID: <ai8PO0NThJeuQYzy@slm.duckdns.org>
References: <20260522172219.1423324-1-tj@kernel.org>
 <20260522172219.1423324-2-tj@kernel.org>
 <ai50IpfcvBiTZ7Ss@willie-the-truck>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai50IpfcvBiTZ7Ss@willie-the-truck>

Hello,

On Sun, Jun 14, 2026 at 10:28:02AM +0100, Will Deacon wrote:
> > +/*
> > + * Note: strictly-zero compare is narrower than pte_none(), but the gap is
> > + * harmless: a fresh kernel PTE has no software bits set.
> > + */
> 
> This comment really confused me :/
> 
> What is a "fresh" kernel PTE and why do you specifically call out "software
> bits" if the CAS requires all 64 bits to be 0? Why is that narrower than
> pte_none() given that pte_none() for arm64 is:
> 
> #define pte_none(pte)           (!pte_val(pte))

Yeah, that's complete non-sense for arm. The comment is about x86's
pte_none() excluding DIRTY and ACCESSED due to an erratum when testing none
and how that doesn't matter here. This shouldn't have been copied to arm.
I'll send a patch to remove that.

Thanks.

-- 
tejun
