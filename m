Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DEA4F798B;
	Tue, 19 May 2026 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210697; cv=none; b=eIsMMLM715pdAPsFO48Jynl7WQO6ZL0QyMjjFmcueyZyH+2t4oNvVI7al5zrMdsurmnOpVVi/mkNZiECP6k+m3FfpSRbGEKy5gDDYirDNT4gFwZYNskeQavk+iJXrmQ9kGQZaDBtopAuUH6UkL9pRH9wm8HEHqNX9/2p/6EvlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210697; c=relaxed/simple;
	bh=62vx8mX+NUzIAl4O0uDmSYpMMtEoa4nb7RMkDjQFU9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXcyDxaBESblOb9doyhv032vtE9HLw/NfrAsXLQUCMLbQBf6RApZ6F4I+oV2gnDTueop/3uQ+xMPgqg3lAJE8H+Yk/emu6SkdLxk5SD8efp/9DGm5qTodvVeVOvZZSjl+ZJ60VuB1mhxQCR7TAeBkOSxfyN1tDJ1cAPk2ACpkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRUJWOs7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRUJWOs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6DFC2BCC6;
	Tue, 19 May 2026 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779210695;
	bh=62vx8mX+NUzIAl4O0uDmSYpMMtEoa4nb7RMkDjQFU9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRUJWOs7kfmxRw1IyuEx9VNmI+HtBY+RUHfIO4Wrcr7Z60Py1vJdh8cqsfX/MI9sX
	 85wED6Nhx+Wv8GGEbyqmzcIWf2zSmFf29XHERwlPl2D9pT49EizsxHThcfKl4WkAb/
	 NEkW74HrJMDH7B/47xhcIIDNSgYxQemoqodDbhMlMd9EoW7InETveW2nAc3hRkWplH
	 9Jj86eOqcU0sCrYlJNdX/JUkiyfP8GHwb3i40GL5hWX8Fawr8nkqGdKfOyVPFq5e+5
	 88qkzSaYK7+TLbI968s35OlA318ZNtHjcN8Bvq6zXPiOtOSWC7E+W+RbtMTW07doeJ
	 vJqxr1j+6uXqA==
Date: Tue, 19 May 2026 07:11:34 -1000
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
Message-ID: <agyZxmHoueGwBAQg@slm.duckdns.org>
References: <20260517211232.1670594-1-tj@kernel.org>
 <20260517211232.1670594-2-tj@kernel.org>
 <9ba50fd2-077e-4291-9276-9adb18186873@kernel.org>
 <agtuPrgIDNKSu2Oo@slm.duckdns.org>
 <2f02d90d-cdc9-48ef-abe3-99e00f22595f@kernel.org>
 <297658c4ae2d6e7103f5968efc936224@kernel.org>
 <04b03066-86d3-4c0b-b077-307fd0f3bc9c@kernel.org>
 <5590fd3d-dae1-4070-b52f-bc40982ac678@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5590fd3d-dae1-4070-b52f-bc40982ac678@kernel.org>

On Tue, May 19, 2026 at 11:40:48AM +0200, David Hildenbrand (Arm) wrote:
> On 5/19/26 11:05, David Hildenbrand (Arm) wrote:
...
> >> The only requirements are that the kernel doesn't oops and the
> >> violation gets caught. Beyond that, behavior at the address is
> >> unspecified, and which installer wins the race doesn't matter as
> >> long as kernel integrity holds.
> > 
> > You'll have inconsistent TLB state.

Wouldn't it still be either or with both cases being okay?

> > I really don't like that approach.
> > 
> > We should really try to just take the lock, and remove any code under the lock
> > that could trigger such unpleasant deadlocks.
> > 
> > Is that feasible?
> 
> ... or can we run into similar problems with kprobes? (I am obviously no bpf
> expert ...)

Yeah, I mean, that was just the first TP I found scanning the code. Any
kprobes or other TPs in the path would behave the same.

When this fault triggers, the BPF program has already malfunctioned, so it's
not going to be a high frequency path and performance isn't a primary
consideration. So, anything that can ensure that the kernel doesn't crash or
lock up would be fine. Any better ideas?

Thanks.

-- 
tejun
