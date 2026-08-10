Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FB3B9D9E
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357734; cv=none; b=V+fM4XEYDAsRiE8OFFWketoEqnl9zynToF4VRTp2WxVm4DNQLVXnJ4RuWcb1CrdsUcRqoWD0jQV31O6c8W7WnYhd6RYpJn9K75Ws6+/XPuvzC2TeOQmSzPPiXfynNfSZ4wxS8Sy22glsWGqu2D5cgYA8FZ5tReqwdyCUVHgeWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357734; c=relaxed/simple;
	bh=zmQScgEjG9CsApa5GlkMoPNpkm3Q+y93qUQzJokgLMY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ln9rJqOYr6ywLHFFVZlo0gOjb90W8JQ8IRzuJ2GfeS2UB5gIn9X4LXjYD5WconqjIo//7Tp0VLNz4VFBRWV1aiD/UcxGK68cMKxaaN/aD8cyfhL6XEfyF/DrsgYRhQgPu0HhgSmrMwh1CIIR3zSmky8115oEfNvKr6xSWCcZZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrB1ulLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrB1ulLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711F71F000E9;
	Mon, 10 Aug 2026 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357732;
	bh=N0JAyoHe+4+Ly2mzgQVev+NpWSf+pVd8kSlLh4E7a7Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KrB1ulLZ0a2DE45erjbpXrKfh5Jn6O403DfTIV+yXvo4dGNUe65GFiKS3e4gJI5Vh
	 L+U3wVyh79zG7jgVE983m3At21tbhqGrXYBHTLe08DCLfjFgiEr+wNzTSB6h/1GHLq
	 aNaKF+nAP3w7f4FpwsknFaOtc2NtmZURNIaFv/pXpRbs+v5tvFAViXBhYtQk6tbX3u
	 C8IwnOSUPF2ORV1KOoOln38RYhzqAY2k2SlrQbQGqM/ysm/XthBFg6F2sUpmF2IBaf
	 0IKEN0+c9bWUkFygNAZDwjmOOchEhYJYp80YM0a3YnrfZuyuSVMPct0rz9nhpsTGyB
	 c//CT/6gIpPWA==
Content-Type: multipart/mixed; boundary="===============1081492447678442428=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1763562d66c732f44aa04438cdab526cd76bd75d6bcd041ff8f1ef38c7b3e756@mail.kernel.org>
In-Reply-To: <20260810092814.2698521-2-chenyuan_fl@163.com>
References: <20260810092814.2698521-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix queue/stack map u32 index overflow
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 10:28:51 +0000 (UTC)

--===============1081492447678442428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Fix queue/stack map u32 index overflow
>
>     The queue/stack map addresses elements[] with the product of a u32
>     head/tail index and value_size, but the storage itself is allocated in
>     64-bit arithmetic. When max_entries * value_size exceeds U32_MAX, the
>     product wraps and push/peek/pop operate on the wrong element, corrupting
>     map data and leaking stale values to user space.
>
>     The original bound check was removed by commit c85d69135a91 ("bpf: move
>     memory size checks to bpf_map_charge_init()"), which migrated only the
>     bytes-to-pages conversion and dropped the overflow guard, so oversized
>     queue/stack maps can be created again.
>
>     Restore the bound in queue_stack_map_alloc_check(): reject maps whose
>     element storage would exceed U32_MAX bytes, keeping the u32 index
>     multiplication overflow-free. Also reject max_entries == U32_MAX, which
>     would make the u32 capacity counter qs->size (max_entries + 1) wrap to
>     0 and permanently break the map.
>
>     Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init()")
>     Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Is the attribution to c85d69135a91 right here?  The changelog says that
commit "migrated only the bytes-to-pages conversion and dropped the
overflow guard", but it looks like the guard was moved rather than
dropped.

It removed the check from queue_stack_map_alloc():

kernel/bpf/queue_stack_maps.c:queue_stack_map_alloc() {
	cost = queue_size = sizeof(*qs) + size * attr->value_size;
-	if (cost >= U32_MAX - PAGE_SIZE)
-		return ERR_PTR(-E2BIG);
-
-	cost = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;

	ret = bpf_map_charge_init(&mem, cost);
}

and the same commit added the equivalent check inside the callee:

kernel/bpf/syscall.c:bpf_map_charge_init() {
-int bpf_map_charge_init(struct bpf_map_memory *mem, u32 pages)
+int bpf_map_charge_init(struct bpf_map_memory *mem, size_t size)
 {
+	u32 pages = round_up(size, PAGE_SIZE) >> PAGE_SHIFT;
 	...
+	if (size >= U32_MAX - PAGE_SIZE)
+		return -E2BIG;
}

Since queue_stack_map_alloc() kept passing the full
sizeof(*qs) + (max_entries + 1) * value_size as cost, wouldn't oversized
queue and stack maps still have been rejected with -E2BIG right after
c85d69135a91?

The bound instead looks lost in a37fb7ef24a4 ("bpf: Eliminate
rlimit-based memory accounting for queue_stack_maps maps"), which deleted
the charge call entirely:

kernel/bpf/queue_stack_maps.c:queue_stack_map_alloc() {
-	ret = bpf_map_charge_init(&mem, cost);
-	if (ret < 0)
-		return ERR_PTR(ret);

	qs = bpf_map_area_alloc(queue_size, numa_node);
}

That leaves bpf_map_area_alloc() as the only limit on queue_size, and it
only rejects size >= SIZE_MAX on 64-bit.  Should the tag read:

  Fixes: a37fb7ef24a4 ("bpf: Eliminate rlimit-based memory accounting for queue_stack_maps maps")

with the middle paragraph reworded to match?

The difference also changes which trees the fix lands in.  As written the
tag points stable tooling at v5.3 and the v5.3..v5.10 trees, where the
check was still effective through bpf_map_charge_init(), while the
affected range appears to start at v5.11.

Given that the wrong element is addressed on push, peek and pop from
v5.11 onward, would a Cc: stable@vger.kernel.org line be appropriate as
well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31375986836
--===============1081492447678442428==--
