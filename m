Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4753822AC
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451184; cv=none; b=MKZ0eESfLXJcLhi2jgjXWebi4iOsffho9BqTIhwt3ljCsZFid5IcrAvY/k89e8spklA/lhW2Li4OIYhlti/YmjMSP/vchXMXOaHNCXBAOthjhrkb+PU342lFIBh8A3oPJojYd4tM6fPvjUsa2OzXZ1QBmCxMuruLAEYoX6+0wiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451184; c=relaxed/simple;
	bh=7jIBeNKu+8tPTCwb60TC8j02L1hMFqxu4kKiqLvjkIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsZbgnh+T9WI2wl7VZuWyknlza49vGCR9lqDyiq75Rhwk/NHxmZj2Kx7L6Eki4pdzqmH9Q4BG9rr+C2F3UY9ypqsiqOt8qMb4g6KtuF2HLzhJ9bwAjiQnVQE0IPkgYoBPfDy3n/mFa+n4EgvhSpnSEdMSSWE1vGFJAWTQKip+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pEZ+oK7x; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pEZ+oK7x"
Message-ID: <2be310e1-798c-4dfb-b5a6-ecd226397b7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780451179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CchvACxV5VKToCEFIbVy0OoT4R3wOh5Ea/BB2ifzf14=;
	b=pEZ+oK7xgVePXcfZCvVyywL/Q4klHcEqtgUx5nXOmLkkHtShvRpuGs20wdjyYTGrkrHDVi
	HzVMVkSyYjlQUHoIzwSkkUYZmoZicWjB7nE7GqKd8WHcs1RnLIxm0J7zUE5fm8+4QZERHN
	J3Fobd92KvM6m+RlYg+pc7XjuNLRD8E=
Date: Wed, 3 Jun 2026 09:45:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpftool: Use libbpf error code for flow dissector
 query
Content-Language: en-US
To: Woojin Ji <random6.xyz@gmail.com>, yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 qmo@kernel.org, sdf@fomichev.me, song@kernel.org
References: <22ab9375-e7e6-4929-a80c-0ee9cc74a907@linux.dev>
 <20260603003339.33791-1-random6.xyz@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260603003339.33791-1-random6.xyz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/6/26 08:33, Woojin Ji wrote:
> bpf_prog_query() returns a negative errno on failure.
> query_flow_dissector() currently closes the namespace fd and then reads
> errno to decide whether -EINVAL means that the running kernel does not
> support flow dissector queries.
> 
> That errno check controls behavior, not just diagnostics: -EINVAL is
> handled as a non-fatal old-kernel case, while any other error makes bpftool
> net fail.
> 
> The namespace fd is opened read-only, so close() is not expected to
> commonly fail in normal use. Still, the BPF_PROG_QUERY error is already
> available in err, and reading errno after an intervening close() is
> fragile. If close() does change errno, the compatibility branch may be
> based on close()'s error instead of the BPF_PROG_QUERY result.
> 
> This was reproduced with an LD_PRELOAD fault injector that forced
> BPF_PROG_QUERY for BPF_FLOW_DISSECTOR to fail with EINVAL and then
> forced close() on the netns fd to fail with EIO. The unpatched bpftool
> reported "can't query prog: Input/output error". With this change, the
> same injected failure is handled as the intended non-fatal EINVAL
> compatibility case.
> 
> Use the libbpf-returned error code instead. Keep the existing errno reset
> in the non-fatal path to preserve batch mode behavior. The success path
> is unchanged.
> 
> Fixes: 7f0c57fec80f ("bpftool: show flow_dissector attachment status")
> Assisted-by: ChatGPT:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> ---
The commit message seems verbose.

Other than that:

Acked-by: Leon Hwang <leon.hwang@linux.dev>

[...]

