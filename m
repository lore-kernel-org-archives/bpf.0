Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2924028D1;
	Fri, 29 May 2026 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078359; cv=none; b=ipMvVo6B+aKuGWSiR5AeMxWWXk3NxNi1pSpGBiy3KH7aGxjUz3Uh7DAcINzQkFJjxdL11vhz8ikBn2eang17YGpv08PVZ3J4nHzYJeCEvhQQnYi1XWRAseh7ziY8FpI6vNE7GqAZkeXTOTl8uAc3+wV/oSowlBD0Jdps62VbUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078359; c=relaxed/simple;
	bh=WjF3Brf6cRxJkzPL/ipfulgSkES6dK/SaDc1kkuFm9w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qnohSEVj2tNbNzJHx9z+i4/FWZj0NrUJ5OGkw9Ph/fGwOgGgw27wv0NAj4UcOhUOqGQkbYP7lxI+KzdeAITEkqzBedmMcpbOzUNOGjj8dVCQTyODO7CEH5J1U0vgpilhiijQfnX+n2Hs1aiU6+2VZ6v3P9vvCjx0mIDvjXBFL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UecRj9nC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UecRj9nC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6141F00893;
	Fri, 29 May 2026 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780078356;
	bh=WjF3Brf6cRxJkzPL/ipfulgSkES6dK/SaDc1kkuFm9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UecRj9nCTx6y0yJqMUOAJoOTqbT9S71bZ/5V6yr5lUgZLmSRRZ+b9yZ32/KlvirZF
	 2D+cZ98qJc23CtZ9PRjAUBJ05fv1yAGnSt4G8o4qyhI5QjO4amK32O1MnklaEoPG5F
	 0rhA0SwYNTPzDsqn+5qjm81KTsfzrLPwpSndxwYSfNyT5+Uca/5J2ROvfC8a43rwOv
	 J6Eu/RvYDqKD4e4ABWzwPqZ6GI17kHnR+mUPYsupQCGdjiIsdJZgofv1Cyq1vnsG0w
	 xm2jCd8A1EbQh6ovD04PtWDhkOfsswYua4dYZa6gGkWJyPK5z4Xh8hbKM3C/OlPknV
	 HXYPui3QG45FA==
Date: Fri, 29 May 2026 08:12:35 -1000
Message-ID: <3901fe0537edee9d7acdfd91695ead28@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Hildenbrand <david@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 bpf@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
In-Reply-To: <DIUMP21RASZI.2VNQV45RIL209@gmail.com>
References: <20260522172219.1423324-1-tj@kernel.org>
 <20260522172219.1423324-3-tj@kernel.org>
 <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org>
 <DIUMP21RASZI.2VNQV45RIL209@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

> It should do set_pte_at() unconditionally.

I think two concerns are tangled here.

1. The racing write. set_pte_at() and the scratch installer's
ptep_try_set() hit the same PTE with no common lock. On x86-64 and arm64
set_pte_at() is a single atomic store, so it can't tear against the
cmpxchg, but a plain store racing a cmpxchg isn't atomic in general.
David, is that the worry - an arch where set_pte_at() is split and could
tear - or something else?

2. The SEGV. It's a BPF program failure propagating out as a SEGV. Maybe
not ideal, but as long as we surface the BPF error properly, it doesn't
necessarily seem broken to me.

Thanks.

--
tejun
