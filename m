Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C143F4B5;
	Fri, 25 Sep 2026 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364707; cv=none; b=Ajeb71TSB1PxVJoHSKdm3vboxOe2EOu1TgDBO9j/bg1P9AskampFTqns32lz2QIlo1uVG0poadzR7uCpEz7eDxjfWIzLZBqyeMCFNtLIekiUoNzWqoKqyHkGtKMx/FLkTtDXrlGR/jiBG9EoIwxwc57NaN1GqnZI5vRUXnsXoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364707; c=relaxed/simple;
	bh=xv8tRX5Q1JnCgNWQGG8l4ow+hHt+ufgxySyNR4AsvQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5lFMZneBdECb0J0wHnorezRltZYBNK4k0JhYhnME1Ot++0jKZ+LJhTZLWZvLf0guR9kztTl96LbqnubMzGp9abCZqyuokPf6oRA5M80NWrFPsLoN1OPXi5+1kdr8GMH57xe0UnnPz7x05T8ZSefLXOv6KT7DGz6UTd7vaKv3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut+mOWEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut+mOWEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E691F000FF;
	Fri, 25 Sep 2026 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364705;
	bh=zTM8+cryamcrZRkcMYA6NrIn8P9opWgTzixFEe7fRWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ut+mOWExPvvxUOWuoqfCKoZYuYl5NPiFnQ8JYbolEdqK+mQ/TQEtucKFQhE3BNX+w
	 9ZBRH5SsHwY8HOhyvXAbGiofkRgkIzU6F2zMX8y+yQKrv8w+rC3UengqNm8059mFWQ
	 Erv0drW6dXJn2BerZq5y5YaXu4IlmezthWIHAJrD3LQhStmn7Q/bCqhFCuwpRoBKke
	 SX11NI4xnZGM3W4x671wrdmHSYhp3wEbFUAKcWVl6dHTvjcVanLxX7lkNAdKOdoQKG
	 eDWoXT8vDSCtSWdqGEcIeQXsZJAM+K9UirkDGnk9B5wDRUI4UdWo4gltAzwVfY37uk
	 +Rv4P385nZtlg==
Message-ID: <cfabf4d6-3342-42bc-91c4-21c9d9f2ad18@kernel.org>
Date: Fri, 25 Sep 2026 20:31:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 0/2] bpftool: Batch hash map dumps with
 bounded buffers
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260925174412.2028749-1-hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260925174412.2028749-1-hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-26 02:44 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> Use lookup batches for ordinary hash maps while preserving output and
> bounding the combined key/value batch buffers to 4 MiB.
> 
> Changes in v6, addressing Quentin's review:
> - Extract a positive eligibility predicate and document the u32 HASH
>   bucket cursor. Keep ordinary HASH as the initial supported type.
> - Limit buffer growth rather than the map's maximum capacity. On ENOSPC
>   at the buffer cap, continue individual lookups from the last emitted key
>   instead of restarting from NULL. Keep existing non-atomic traversal
>   semantics and initial unsupported-operation fallback.
> - Add a sparse-map test with a maximum capacity above the buffer budget.
> - Rebase and refresh the performance measurements in patch 1.
> 
> Validation in an x86-64 VM:
> - All 12 bpftool_map_batch subtests pass.
> - Normal HASH, large sparse HASH and LRU_HASH fallback output matches the
>   baseline in plain and JSON modes.
> - Injected ENOSPC before and after output, including growth to the actual
>   4 MiB buffer cap: complete output matches the baseline without missing
>   or repeated entries. Initial unsupported-operation fallback also passes.
> - Injected EFAULT/EIO and late EINVAL remain fatal and leave valid partial
>   JSON, without processing invalid output buffers.
> - Matched-base /dev/null measurements show median elapsed-time reductions
>   of 37.2% (plain) and 40.7% (JSON); BPF syscalls remain 200,004 versus 395.
> 
> v5: https://lore.kernel.org/r/20260924163403.203491-1-hi@tychen.cc
> Review: https://lore.kernel.org/r/d5a5b5e7-4063-4511-acdc-46b2407565a7@kernel.org
> 
> Tianyi Chen (2):
>   bpftool: Use batch lookups for hash map dumps
>   selftests/bpf: Check bpftool batch map dump contents
> 
>  tools/bpf/bpftool/map.c                       | 123 ++++++++++-
>  .../bpf/prog_tests/bpftool_map_batch.c        | 191 ++++++++++++++++++
>  2 files changed, 306 insertions(+), 8 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
> 
> 
> base-commit: 7af653d4ebf8e2e17e288715cd67ccf7845f4631


Looks good to me, thank you.

Acked-by: Quentin Monnet <qmo@kernel.org>
