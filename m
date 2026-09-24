Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC83C37AF;
	Thu, 24 Sep 2026 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266967; cv=none; b=V1XB1ECwi4hq1euah15UGjx67WYfhbrx1jWfEtOmhiItfbmC6f1pDJ4XnqnVUQ1pw8XEkP0D2Bz94btgTBJQWmWiG/RbtgvKh8APj7hLoyrVMa6lcSVqBdqLF3uLh1dP2YlMjfMiYZSynYyxJTS6p6S9ot33+85StjfhIZkjrao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266967; c=relaxed/simple;
	bh=NC4XmsVdM1DFQWj7caGmEajsAkIX+vR6LZS7ZVXL3Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=om8UmOk6yr7spwODutfHW11qxazJkkxXlUpGQwMWp8YFBrL2RQ/kOpH+S+8BIbxbkb9S8CfB0SasAYoeHDXCMM948ED7PtOvlCAc+K9SMDlUkeff9i7TBba5tpvIM9UQgZEHnUygks4Mw9HwCimPWNoe2Kj7HyuHIASfQ5VjCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J99rlKDh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J99rlKDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4791F000FF;
	Thu, 24 Sep 2026 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266966;
	bh=kbN7emt1o2cvSh3aBS0ZDrU9gW2N5PjdNWCJdl0VfWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J99rlKDhhYTYxqyfen3c7X/7W82JbZXoJWkC5J6JSwmxok6gZmphySuA4R/2eV+Yn
	 TvEgo90FZ5rCTTcSa5OyC+RgEEckDKomrhw2FIbIO9Supp/cPOn81bu6ufF5z98lav
	 jsDp+LD7rbUFTHvAghBvDxuL/b9WSIk7oo783JczGSccttQ8lGCTKv1mXWKQl4MLXe
	 gMBkOpnW8ZezTbTKrdtYjQngMzxasGQ8EQ+9B743yDJEgl1gEDOerQHvtVMH3F39ee
	 zRvcKZLG2mpC3hEWf98VmW3OIER+QlEsIi+aL8xj4HSsUaqxwX0trOzWlh3a4RRYUp
	 PFcO4YYzsQWzQ==
Message-ID: <141264c9-2d05-4c05-a76a-306818e854ba@kernel.org>
Date: Thu, 24 Sep 2026 17:22:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/2] bpftool: Batch bounded hash map dumps
To: Tianyi Chen <diannaaav@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260911034732.219752-1-diannaaav@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260911034732.219752-1-diannaaav@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-11 11:47 UTC+0800 ~ Tianyi Chen <diannaaav@gmail.com>
> Use lookup batches for ordinary hash maps whose maximum key/value
> storage fits within 4 MiB, with selftests for complete output around
> batch boundaries, short keys, odd-sized values and BTF formatting.
> 
> Changes in v4:
> - Name MAP_DUMP_BATCH_FALLBACK at both return sites and the caller,
>   replacing the literal 1 while preserving the existing control flow.
> 
> The helper retains three outcomes: zero for completion, -1 for error,
> and the named fallback result. Internal errno values are normalized
> before return, so EPERM does not escape as the fallback result.
> A separate output parameter is unnecessary for this distinction.
> 
> v3: https://lore.kernel.org/r/20260911025130.191011-1-diannaaav@gmail.com
> Review: https://lore.kernel.org/r/7aea07c4220781305b7e972abfa9d2e4776276a64bc4837b80325d177799a371@mail.kernel.org
> 
> Validation:
> - Rebuilt bpftool, its manual pages and the focused selftest runner.
> - All 11 bpftool_map_batch subtests passed. The three revised series
>   were tested together: 52 subtests passed with no skips or failures in
>   an x86-64 KVM guest running Linux 7.3.0-rc2 from bpf/master, with
>   LLVM 20-built BPF test objects.
> - Bash syntax, bpftool synchronization checks and diff checks passed.
> - The generated patches apply cleanly to current bpf-next.
> 
> This was a focused run. Unrelated selftests requiring unavailable kernel
> features were excluded from the build with PERMISSIVE=1.
> 
> Tianyi Chen (2):
>   bpftool: Use batch lookups for bounded hash map dumps
>   selftests/bpf: Check bpftool batch map dump contents
> 
>  tools/bpf/bpftool/map.c                       | 117 ++++++++++-
>  .../bpf/prog_tests/bpftool_map_batch.c        | 187 ++++++++++++++++++
>  2 files changed, 296 insertions(+), 8 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
> 
> 
> base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e


Hi, could you rebase this series please? It doesn't apply cleanly any
more - probably due to my response time, apologies for that.

When you do, can you also please add your performance numbers in the
first patch's description? Speaking of: I'm surprised that the syscall
reduction you mentioned (200,004 to 395) results in a 5% perf
improvement, I suppose we spend a lot of time writing to stdout. Could
you please try re-running your performance test, redirecting the output
to /dev/null?

Thanks,
Quentin
