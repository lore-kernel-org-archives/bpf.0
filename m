Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B42571DD;
	Mon, 18 May 2026 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133915; cv=none; b=fVY6sRubuU/4PnzwhBu8608loGEKNZgBZGGTS/lMMtGlT61Ew4ay266L0pExrbz0hIMCoI8Gca4mTWJSrmqtOfjt5QZ9VFp/2sh1XscaY1GJaJKFGhFoMDh2IcxhTV2sUmrU4m+6F4CFPSJASwfZDmAG37w2yteL21i5gMg6d+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133915; c=relaxed/simple;
	bh=0EDZC3hd1XIo9RQYnoioqSdk6FylXyXD32g6lc8WK80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5CXlHRsGs3ZOgNANOheOfwDifoYjpVu6UCsmKTL1f6mp6Toxan5VJvDTRnjdBCT3iyLskpD0CoNz9Ayp3mRvPxGJx3mH5iwrjuntZ8yXmxcjLb5iDaKfOj7/M5YBmJvFeof+LzB9RAErvbpbkiUwyxBcnD8ErSlgm4QfV1kh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3KTXS+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3KTXS+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71871C2BCB7;
	Mon, 18 May 2026 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779133914;
	bh=0EDZC3hd1XIo9RQYnoioqSdk6FylXyXD32g6lc8WK80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3KTXS+Q/AEBoZ4uNfNUsQ0k+ej9XaXq69rCQFPw1ygtZW43gGcEuMye/wWE45zdM
	 YMDY+mI9YFi+aDyqPtX65ur9P0c1QLANOG7IYdZsxcU5O4TksyH0HhEMICOGFtEsDu
	 NbqOY4ZUq2HB4h+bfnVdA26kN4pBS4xYv5DFT9gazLd16W7FbrqAVkcww8+KXOp2eb
	 jkLATaJa7wZKYa7Y3RhuUVAq34sssOBxg9XNnYenpE4Kl2gYVnA293XdgSXNGs1/Y7
	 aOE88cBDoObjjaZ5K6sWE4I1ly4Ftfz3HR+tVZRTJvCijUZ6tVmR9iJuQl7V3aRIho
	 Az/hnaRVwWgCA==
Date: Mon, 18 May 2026 09:51:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] sched_ext: Sub-allocator over kernel-claimed BPF
 arena pages
Message-ID: <agtt2dEjS4Qg7a_P@slm.duckdns.org>
References: <20260517211232.1670594-1-tj@kernel.org>
 <20260517211232.1670594-8-tj@kernel.org>
 <20260518072042.GP3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518072042.GP3102624@noisy.programming.kicks-ass.net>

Hello,

On Mon, May 18, 2026 at 09:20:42AM +0200, Peter Zijlstra wrote:
...
> Should this really be part of scx rather than be part of the bpf-arena
> thing proper?

It's just a layer on top of arena. If bpf folks are okay with it, I don't
see why it can't be a common utility thing on the bpf side.

Thanks.

-- 
tejun
