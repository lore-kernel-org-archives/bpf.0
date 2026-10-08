Received: from mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92744493D3B
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466092; cv=none; b=gwE0AHunIxNaxvHzMNLjcuu8caKneO94Rlhy1fRkOMex1mcr2nRQzIFMv/i/XQKqFH9BEDJnIMARu2TBHGqAqpfKd3xwwLnhN2OgGvT6sGGjyLNeMybIJgMfKUSDCKqy21mVeGC63v8kR90/ZqAEqTjfrQK6aTbzpxHQd08N2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466092; c=relaxed/simple;
	bh=g+hoe6ERaB/Zv07gVkZ8ZqDRbf+iRJJQAODDubsagnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNBBYkbHCEEpPBcw1qtAwtWPq+FnziMZHzokR6KQwLQPReem50N9BAG5l6JKw8KR2zoZBI3iWp/l4uj8y6rFwSp8y2a2aU9tsVtkoHOv8C5qb2nSP+fRLHpgHAdW2Bs04eTo0cJCB5KF6tMXWD993nlPR6igGe1VyhCZaanC190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5o+TOxs; arc=none smtp.client-ip=95.215.58.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5o+TOxs"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=g+hoe6ERaB/Zv07gVkZ8ZqDRbf+iRJJQAODDubsagnY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791466087; v=1; x=1792070887;
 b=C5o+TOxs0rjnwJ76O8oyi4Yd6V5gjl4vN2xImp51jrSx5gED1DAykffd84ZHo0w+8D4Sd5Ru
 TTRllVl2l9ULUarHslUVHP1Zhor4JfSt4nF77k422DhgOnM8pRKzPPGKYwr+CigvZDswIwUUnZb
 ktG0YlVCeV4914h3cgFvXIso=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 127a244004bc9bdb;
	Thu, 08 Oct 2026 13:28:07 +0000
X-Mizu-Trace-ID: 127a244004bc9bdb
X-Migadu-Flow: FLOW_OUT
Message-ID: <2ae7b3d0-6350-4145-a5da-7a9a81a845d4@linux.dev>
Date: Thu, 8 Oct 2026 21:28:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 3/3] selftests/bpf: add tests for percpu map flags
 combination
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com
References: <20261008120734.1565972-1-maghasi@disroot.org>
 <20261008120734.1565972-4-maghasi@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261008120734.1565972-4-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/8 20:07, Masoud Aghasi wrote:
> All possible combinations of (BPF_EXIST, BPF_NOEXIST) and
> (BPF_F_ALL_CPUS, BPF_F_CPU) flags are covered for all percpu map types.
> 
> As BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE does not support BPF_NOEXIST and
> also in order to reduce the amount of code duplicates, I added its
> new test scenarios to the existing cpu_flag_percpu_cgroup_storage test.
> 
> But for other percpu map types, I added new tests to be able to
> exercise all flag combinations and the edge cases such as percpu LRU
> unnecessary deletion issue.
> 
> Signed-off-by: Masoud Aghasi <maghasi@disroot.org>

Two concerns below, others lgtm.

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> ---
>  .../selftests/bpf/prog_tests/percpu_alloc.c   | 254 ++++++++++++++++++
>  1 file changed, 254 insertions(+)
> 

[...]

> +
> +	if (map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH)
> +		goto out;
> +
> +	/* Percpu LRU hash map should not delete old entries unnecessarily */
> +	flags = BPF_F_ALL_CPUS | BPF_NOEXIST;
> +	key = 2;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem lru_percpu_hash all_cpus|noexist"))
> +		goto out;

Update values[0] before update_elem(), and verify_map_value_all_cpus()?

Also update values[0] before the below update_elem().

> +
> +	flags = BPF_F_ALL_CPUS | BPF_EXIST;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem lru_percpu_hash all_cpus|exist"))
> +		goto out;
> +
> +	key = 0;

Why do you use 'k = 0' instead of '2'?

I think we should update and verify using the same key.

Thanks,
Leon


> +	verify_map_value_all_cpus(map_fd, &key, values, elem_sz, first_value, nr_cpus);
> +
> +out:
> +	close(map_fd);
> +	free(values);
> +}
> +

[...]

