Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C43B3893;
	Mon, 15 Jun 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544663; cv=none; b=VKr5SgVPbOS+FQKGHjalYViz9K5iyI8kJZf5SzCgMdaEMwM3SmNOjHU8EfGuMUy0MUp1OJRfRswyhaKwaLfWHEDbISPDdCw0Gi+MtZ01hZqm16+SwNtMTAG5DXT/hJKOEA8R3Lh0j/XN+29nO8jpoxZ7lxvMk8pHdkoC7rquGAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544663; c=relaxed/simple;
	bh=wjTrDh1IYp4rFUTW3+q7qTPuVfhJVk8iFWhJhIbKVzE=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References; b=fWQxbkn4QLaA9EDi3p1qCgQeMSpOJP0rF4qGthnIvjKONro1epEV7JAB0Glp6blUnChACbqZVbPNTCNbI1uPGwAZVtZXSpmrpadQNjICbHVURcwR3+yXwvj2tMwJMHk64hmbI1z8qTDAaR9VaMKkusiQ9bMykHeYPQhB+XdLKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoam+ekJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoam+ekJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762D11F000E9;
	Mon, 15 Jun 2026 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781544662;
	bh=wjTrDh1IYp4rFUTW3+q7qTPuVfhJVk8iFWhJhIbKVzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eoam+ekJZ8hG/C57JLMcYP9+kxpo9xUz+JpGpJRAuTFMHRVCfDnK+wD8s59MgUnVu
	 ivErLfmIOPj6l741A9zGmpb8j46d5cSipkfXySONCDvt8tu/7vXZq7R6iCRqJfkwMh
	 ss09qyYEbeiU1T6GLih6b5AvGw2baikmwvqOpdzZIJ+5WaPP3FL/bw6uNvCj6auFeJ
	 sIfiVAj5X8t3b76GRBSuUWQUjXziD+HpPHmRk9CsOqKmDUlDzfpQFYnxnzfSAWZJxq
	 PkxDoTXLHTCt5/72CbkyzkJVAz345iYdyFT1KiKi0M5Pv4IfwpNEOEcPxFr2INPyeV
	 PJ4M6UMe8s0OA==
Message-ID: <31d1ac68dc230564301fc1e7dc748a1d@kernel.org>
Date: Mon, 15 Jun 2026 06:27:51 -1000
From: Tejun Heo <tj@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Will Deacon <will@kernel.org>,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 bpf@vger.kernel.org,
 x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: Add ptep_try_set() for lockless empty-slot installs
In-Reply-To: <f6e87467-2fa1-4edc-a739-9899be36196c@kernel.org>
References: <20260522172219.1423324-1-tj@kernel.org>
 <20260522172219.1423324-2-tj@kernel.org>
 <ai50IpfcvBiTZ7Ss@willie-the-truck>
 <ai8PO0NThJeuQYzy@slm.duckdns.org>
 <f6e87467-2fa1-4edc-a739-9899be36196c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello, David.

> Is BPF maybe picking up patches from other subsystems up too early
> without waiting for acks?

Do you mean the comment cleanup I just sent, or the original
ptep_try_set() merge?

The original went through several rounds, and you acked the patch that
introduced both problems (258df8fce42f) before it landed.

The barriers fix came from Catalin, he raised the issue and reviewed the
fix. The comment cleanup got picked up quickly. Maybe that's the bpf
folks wanting it in ahead of the merge window.

Thanks.

--
tejun
