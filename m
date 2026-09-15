Received: from mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3CA4B049D
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493647; cv=none; b=C18R982WNdxS5sQ7PJkfI4c378t8Wka9FbKd5dAoM8xnw5wuDtqZf8KrNQ8K6UO5YtigJe8z0Yxk6szQRRKOglFvP9MUekv+nqParpbScwn9CXh+1DdW5AVsNZ4jzzR0PmJFdYznzA5OZTFB8hw/c2ABnZkWkTCX3WyJqmqEwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493647; c=relaxed/simple;
	bh=Ny8gsx/+aib1LL/z4GtATlgXdDqmpbtNu+AdXrRe4y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9rZeGfvg+nmj2C6tIHFz9iahcBSb7mvwiRBiV32hAcsClF42FsuKXIZjqRohfEfgzwJJ6mHgSzBdMSCGfxacXyFDGa7MNap7vZ8hjvCDwppfn6L4ImqjBw2lV3WHTr8pQUTTFFUAeskOVuZ5aWtx2NRhIoedR2fcvs1WUnRDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ATUjGByI; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ATUjGByI"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ny8gsx/+aib1LL/z4GtATlgXdDqmpbtNu+AdXrRe4y8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789493643; v=1; x=1790098443;
 b=ATUjGByI2+VF6GY0inbQrN6K5+Re57pPgbh40dV8JE6eHV1NPYFk4hyADTE4ETZcqxsekadY
 vPtvp6V9zqDbDZbTrmWqpn7gdXX+6M1TR51lBni2pisNwKO4PrU2k1MADZTBcEpsGq7d8oEoHf1
 SOm/5Wh+6MhDjYEaH3i+h5lo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 70d28aa2d60e653d;
	Tue, 15 Sep 2026 17:33:53 +0000
X-Mizu-Trace-ID: 70d28aa2d60e653d
X-Migadu-Flow: FLOW_OUT
Date: Tue, 15 Sep 2026 10:33:47 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v11 2/2] selftests/bpf: Add memcg async reclaim
 test
Message-ID: <aqmBRjy07jIYdl-7@linux.dev>
References: <cover.1789475073.git.zhuhui@kylinos.cn>
 <93289af4317b57caa4e393d73fe6c786b24a4c2a.1789475073.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93289af4317b57caa4e393d73fe6c786b24a4c2a.1789475073.git.zhuhui@kylinos.cn>

On Tue, Sep 15, 2026 at 08:29:36PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> Add a test for BPF-driven async proactive reclaim: a BPF program
> watches the refault stats of a memory-pressured cgroup and, once they
> grow, reclaims another cgroup from a bpf_wq callback through
> bpf_proactive_reclaim(). Reclaim is verified through the reclaim_calls
> and reclaimed_bytes counters; the workload timings are only logged, as
> they are a benchmark rather than a pass/fail criterion. Setting
> TEST_MEMCG_ASYNC_RECLAIM_BENCH=1 adds a baseline run without the BPF
> program.
> 
> A second test covers a dying target: bpf_cgroup_from_id() keeps
> returning a cgroup until its last reference is dropped, so the program
> checks the css flags and skips reclaim once the target is offlined or
> dying, and the test removes the target while reclaim is in flight and
> verifies that reclaim stops. Each attempt reports its outcome through
> a ringbuf, so the test waits for events rather than polling counters.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

Comments from bpf-bots seems serious. Let's address those and then I think we
are good with this series.

