Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C14A387D;
	Mon,  5 Oct 2026 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209821; cv=none; b=ErOEHxCtrqHEYu9UBmF+AYqny5J3Fz9pqZQ2Xh6wF10XQS7loksjb06EwGCirwTJPkiXAPOm3hYkWD6U5AZPXQzg+akdOsBD0mrNkXnte4X2MPu1z1JX4EZn46ioTMkAuCpufNRIFE1KtynvWTwWxs03tWqPV2gqBqAFtamBZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209821; c=relaxed/simple;
	bh=g/PvErAkWqPLLMhfdp6s6oupiEeHn6mW6CPEnvMmZuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP9dapSPb9iCkBZVckS+hcutgls6Tbns/+JDPFGxWlV3w9ByXXBJZNo+KHnb76knDWjWgKyAxm4tWw07pZ1dSOFSHZT9ow8NCheZkfpjn0vGe+0rURKXh+NGC7IjaADX1Ol10IKs530tNyUuQVrksTpORRX5hgbHM+NP44egoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bgzHUU6f; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bgzHUU6f"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1826F152B;
	Mon,  5 Oct 2026 07:16:50 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7F253F66F;
	Mon,  5 Oct 2026 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791209813; bh=g/PvErAkWqPLLMhfdp6s6oupiEeHn6mW6CPEnvMmZuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgzHUU6flQh4WV6N8wrHBOjkrnfRN1RjtIvlMsJTgnfprNOTNrWuI3ZbDwgLxQR6u
	 v7S8MV4n/CktpjfTJ9ZhjsMfIcAKAAGxPtN1AqraVPnHJIKph8wN59edTO4IJ6CtLR
	 dvUlUakISZh2+PUjuHQ8j7SIV0IRr3EekSiHKrfE=
Date: Mon, 5 Oct 2026 15:16:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>,
	"open list:MEMORY MANAGEMENT - CORE" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] arm64: Batch PSTATE.TCO handling in kernel nofault
 loops
Message-ID: <asOxRkayznzX-K4c@arm.com>
References: <20260824160523.3907021-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824160523.3907021-1-usama.anjum@arm.com>

On Mon, Aug 24, 2026 at 05:04:45PM +0100, Muhammad Usama Anjum wrote:
> With Hardware Tag-Based KASAN in asynchronous or asymmetric mode, kernel
> nofault loops currently set and clear PSTATE.TCO around every access.
> 
> Introduce bare nofault accessors, batching hooks, and an internal scope
> guard. Convert maccess page-fault cleanup to scoped form. Skip
> page-fault setup for zero-sized kernel nofault copies and zero-length
> BPF string operations. Then use bare primitives in the maccess and BPF
> loops. For non-empty operations, this reduces the code-derived dynamic
> MSR TCO execution count from 2N to 2. Two-string BPF comparisons fall
> from 4N to 2.
> 
> The BPF changes and an earlier maccess implementation with explicit
> cleanup were tested with QEMU arm64 using Hardware Tag-Based KASAN in
> synchronous, asynchronous, and asymmetric modes. All nine arm64 MTE
> kselftests passed in each mode, as did the 138 focused BPF string_kfuncs
> and varlen subtests. The focused BPF tests also passed with the default
> non-MTE arm64 CPU model. Both final maccess scoped-guard patches were
> arm64 cross-built. Runtime tests have not been rerun after that
> conversion.

TBH, I fail to see the benefit. There's a reduction in the number of
MSR instructions executed in async/asymm mode but does it result in any
improved benchmark numbers? Which workload hits these loops often enough
to matter? They are mostly used by tracing and debug code.

AFAIK, most people wanting to use KASAN in a non-debug environment want
to go for sync mode, where there is no MSR and this series only saves a
few NOPs. We might as well go for a config option to force sync mode (or
off) and remove the unnecessary NOPs, *if* you can show any performance
improvement.

-- 
Catalin
