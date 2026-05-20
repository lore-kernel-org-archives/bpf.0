Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B33FB7FC;
	Wed, 20 May 2026 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302317; cv=none; b=W5LUGYLBh20DQZdyxHQWaQ6fwk3USsZBx94TsCyPlnRmNSsrWgVbhLl+Wv2HdbB3e19fZ4Qr8JA67S2stPg8euRg9ooRv+FCpEB0QRNJBXR6+HTqyFkEwNZZ+UfLu1an4U+URJfBtL3Q1OOBA/+WigTHuYVDzsX24nS9XTN2O3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302317; c=relaxed/simple;
	bh=6iKhk6kqS6966lAvCAmiLAgYgzRg3kBxAZjQFm+TTLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbx6cGg+Jc4RmhiQ+wzwX3OSnnYwguGXtuZhpSIlqMVPH7FiPYmMjR7t7NsJOOEWjQT2ENyJOZaIX7KNRdT24JqRlbZdjBcxedYNGzYBbUyuW9F9Y7ne+O5tTbkDN/8LVLUeb8zKsORzv3d/0KN4BY32+RB/j3W6b76EsWGCMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeP7kErD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeP7kErD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65FB1F000E9;
	Wed, 20 May 2026 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302315;
	bh=P6e4oDBvRxPvtNdyfdL/0JuA1B/r6cjRvn2dqESw1JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OeP7kErD5FN4x7H3jRQ0qLenYDpJZWNSC8tVoPmuXHTpwPTAQ48hShAKKEor0cmpn
	 otH8fOPqr5siqoGpZBoIrjd0DotVi3hInBPD+on2at+SCW4JUXmQ2K59y7Zi7Nb9+z
	 GDuDs7+CT+xCWf3lflOSuYnA/yBaBPfQQmM5VP/NG1ZzYpK5jEUv6wD97K9dHFMQG9
	 VqxokuhqSCrOe7MjFswSc4vITW1uDCKOGG1n8wA9mwCG3xIj8i8x7qtI21x+NoZf0E
	 MzjHqv1paEtjF8zEW5XeoEe6QpfC5Rk68G9rCR/B+xVKctkjhArQfZKZcshzMSYpQ7
	 fgqv9cwx0mSbA==
Date: Wed, 20 May 2026 08:38:34 -1000
From: Tejun Heo <tj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
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
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] mm: Add ptep_try_install() for lockless empty-slot
 installs
Message-ID: <ag3_qpKObFOLKgbR@slm.duckdns.org>
References: <20260517211232.1670594-2-tj@kernel.org>
 <9ba50fd2-077e-4291-9276-9adb18186873@kernel.org>
 <agtuPrgIDNKSu2Oo@slm.duckdns.org>
 <2f02d90d-cdc9-48ef-abe3-99e00f22595f@kernel.org>
 <297658c4ae2d6e7103f5968efc936224@kernel.org>
 <04b03066-86d3-4c0b-b077-307fd0f3bc9c@kernel.org>
 <5590fd3d-dae1-4070-b52f-bc40982ac678@kernel.org>
 <agyZxmHoueGwBAQg@slm.duckdns.org>
 <CAADnVQJt0p7hSn2G074QZRh2LEdthy3RKYJ9j3w5yeJ-e8UQLw@mail.gmail.com>
 <fb889bfc-af0e-491e-a69f-38c2abf88d22@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb889bfc-af0e-491e-a69f-38c2abf88d22@kernel.org>

On Wed, May 20, 2026 at 10:41:15AM +0200, David Hildenbrand (Arm) wrote:
> And that should be carefully documented.

Will do.

> > The fault handler has to install _some_ page and let kernel continue.
> > Scratch page or arena page doesn't matter. Potentially different CPUs
> > will see different page. It's not a concern at all.
> > bpf prog is buggy, but the kernel will continue to work without a glitch.
> > bpf runtime will disable and unload misbehaving prog.
> 
> Having one page table walker overwrite a scratch page on race is just rather ...
> questionable locking design, that just screams for problems long-term, really.
> 
> At least in apply_range_clear_cb() one could similarly switch to
> ptep_try_install() to at least have both these paths handle races in a
> reasonable way. (having to handle when ptep_try_install() is not really implemented)

Hmm... wouldn't that be more confusing on apply_range_clear_cb() side?
Whether it maintains the current behavior (if collide with scratch, try
again with scratch as the original value) or flip the behavior (fail if
scratch), that extra logic is spurious, and those tend to confuse people as
they force asking why it has to be that specific way. If the goal is
documenting the subtlety, wouldn't a detailed comment serve the purpose
better?

> Anyhow, the documentation of ptep_try_install() must clearly spell out that this
> must be used very carefully, and only in special kernel page tables, never user
> page tables. There are likely other scenarios we should document (caller must
> prevent concurrent page table teardown somehow, and must be prepared to handle
> races if other code is not using atomics).
> 
> To highlight that, we should likely consider adding a "kernel" in the name, like
> "ptep_try_install_kernel()".
> 
> I am also not sure if "install" is the right terminology and whether it should
> instead be "ptep_try_set()". (set_pte_at is the non-atomic interface right now)

So, ptep_try_set_kernel()?

> Further note that last time I talked to Linus about arch helpers, he preferred
> 
> #define ptep_try_install ptep_try_install
> 
> over __HAVE_ARCH_PTEP_TRY_INSTALL

Will do.

Thanks.

-- 
tejun
