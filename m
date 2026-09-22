Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36C25A321
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102984; cv=none; b=eJFzdKFat+cN8YLoOOJL0bhrMEY793TSngXntY4cO/mBBQfJufcj0aP7QkEOfhLD6uzuqnWu1NIdli3k/58wbLiSdc9fuzIxdx2DjobA/KcO/X4vkFQ0ZyeaDXC6o3Cs+be34hgKof9TdSJKiwZ+kSy5FA/uaPUq5nI+xcdnIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102984; c=relaxed/simple;
	bh=XQl8frOik7ulP/RtDMVLfi0/GxRHd1Pwd78Xgl/q1xI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qy3Nr3E1+h0fpPv9/Ctpw16Tg1jUOWe57bcWBNkUcV60TxQF2czCOZYVwANXT83NCuufuVty5DAbaLW1BVyBcHS7cdPTBsuPyH9tM9jemb/4Oas49BeQgpTDUyAc2ig2w8vXRkg0mXb6HtOyr4wlc8pBUNDJIwKCZ+xKfthfuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnSNWB6I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnSNWB6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68E11F000FF;
	Tue, 22 Sep 2026 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102981;
	bh=AORGnkwzgCm8JyLyYQLm1Or85e9bE08fv3KNPMTuib4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YnSNWB6IchOxdiKz2WRnpbyIX87Q/d7K1LP3sf1gs+e3nVYjt5O+xPc/ExMjc7hWP
	 qdizq1rRL78Ov6se8aj+HWOb+N9qmt+NSSCurjVY4kXcf9aUEOL3aBtWfhuxuhA54h
	 NzIu/j4a4lsxj33l3s10+IusQnY36FxKOZjMRMQstyd2tx4zv+LDMI8mgEGVGd54Pg
	 eHUhnQKyzcDNcEZ1/VjLLYSaszgPkeKNWjtr/V+rZPqeeoL6K9iLvSSOosW1A0IKpT
	 jAMCjGUQrkAdKoMY3/F4zldiCOMzHQq2boEitFZ+wY1STOtLwy1/TGTcnlEA5uT8uq
	 sU1ptuah4CEFA==
Content-Type: multipart/mixed; boundary="===============5896563083281024244=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e113bef9bbbda76049908bf67625be4f11363ccd22ba1620208854cf480c83f2@mail.kernel.org>
In-Reply-To: <20260922-hashtab_fast_hashfn-v3-1-b7b0e9bc33ac@meta.com>
References: <20260922-hashtab_fast_hashfn-v3-1-b7b0e9bc33ac@meta.com>
Subject: Re: [PATCH bpf-next v3] bpf: Speed up htab lookups for u32/u64 keys
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com
Cc: yatsenko@meta.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 18:49:39 +0000 (UTC)

--===============5896563083281024244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Speed up htab lookups for u32/u64 keys
>
> Four- and eight-byte keys are common enough to warrant specialized htab
> lookups. Use jhash_1word() and jhash_2words() for these key sizes instead
> of the generic jhash2() path.
>
> For JITed BPF_MAP_TYPE_HASH lookups, htab_map_gen_lookup() also knows the
> map's fixed key size. Select u32- and u64-specific lookup entry points so
> the compiler can specialize both hashing and key comparison. Other key
> sizes continue to use the generic lookup entry point.
>
> This preserves the jhash2() result and lookup semantics while avoiding
> generic length handling.
>
> Measure this with six runs of:
>
>   ./bench -w3 -d10 -a bpf-hashmap-lookup \
>       --key_size KEY_SIZE --max_entries MAX_ENTRIES \
>       --nr_entries NR_ENTRIES --nr_loops NR_LOOPS \
>       --map_flags 0x40
>
> inside a vng guest with two vCPUs and 4 GiB of RAM. Run the baseline
> first and the optimized kernel second. Use these workloads:
>
>              max_entries   nr_entries    nr_loops
>   small              512          256   8,388,608
>   medium          10,000        5,000   8,000,000
>   large          100,000       50,000   8,000,000
>
> Mean throughput in million lookups per second is:
>
>   Baseline:
>                          key size (bytes)
>                       1        4        8       10
>     small         89.45    91.21   103.40    91.74
>     medium       125.97    80.25    91.94    78.52
>     large        140.67    53.56    58.68    47.31
>
>   Optimized:
>                          key size (bytes)
>                       1        4        8       10
>     small         86.95   197.77   168.65    90.88
>     medium       124.97   147.48   137.76    77.51
>     large        131.06    78.51    76.04    47.25
>
>   Change:
>                          key size (bytes)
>                       1        4        8       10
>     small         -2.79% +116.83%  +63.11%   -0.94%
>     medium        -0.79%  +83.78%  +49.83%   -1.28%
>     large         -6.84%  +46.58%  +29.58%   -0.12%
>
> The u32 specialization improves lookup throughput by 47-117%, and the
> u64 specialization improves it by 30-63%. Ten-byte controls remain
> within a 1.3% slowdown. One-byte controls range from -6.8% to -0.8%.

This isn't a bug, but would the changelog read a little tighter if the
derived 'Change:' table or the paragraph that restates it were dropped,
keeping just the before/after numbers and the one-line summary of the win?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35765147830
--===============5896563083281024244==--
