Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194506;
	b=w38j0+UkcqGfXZWMV2hV1yd0GuvaWTvR4kgccRLTANXTWYTewq+u7oxEE+DWyx/kC6jj
	 J1nWWr8QDEup5GeiEwJFb566md8hm+aLTe/ugn6CJ0e44iqeMsFq8t0Re9GFtSferrYR3
	 jg+NtA0KLlrYvhHa91ggIFoVWJy6T/2DayOZoH2mBr+w7WOQY5dCp7qZ09qd5+Fo6TrlN
	 zqx+9yMVCOL5DMCtuJqIbBZQHLEYBxkTv2Y3XE3dL681mSOZFnrzIEqN/6uryNL72JSbZ
	 MS/0pIyRz1K6SUhMpsZzywaS/j900db2N4TnEt5TGgHPuyKs0jLwPSk4t89USMRggMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194506;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=57oS6m1b9doBy7H5rmfFkLclTYei+DSwfk/1lcfyc1c=;
	b=bRRK33EF5tiYndZJiXQl16bUfc/YPZK2eR5fwCF2ijBTyDDJNfTGBMNW0CEANlVb/U0f
	 j4XqBER12yPKvz4CcmtI9PkEutqsSUzo29sdCTo0B3Fo2LlgRo1/OpqpqGrmJ+c3PAy3o
	 U6AetUdbVWlhMwfvTglN+7u8LX/niE6CABF6gcONcoqCDrOMRSHk3SnYDtzHUsVzFSY0S
	 guS00WmatZmQQK/Fid8Op0JDHc76X4eBSXFdDq0LLBP3kNS2LjVw6UQuqWb6+Lg5pQekO
	 F+4FyRK9lJ8oOIjwAGtHETrCM5JgV0fgHA7UQx06bZgjAHQyWOhdpH/G+EiZ9UhQwGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPFtGz7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B13606A320;
	Mon,  9 Nov 2026 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPFtGz7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA1B1F0089F;
	Mon,  9 Nov 2026 03:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794194505;
	bh=57oS6m1b9doBy7H5rmfFkLclTYei+DSwfk/1lcfyc1c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GPFtGz7HiHr6oYZ0QNpfF+ZgxAbQ2GM/oFwn9mqtHe6QgSs7tF8wNOxDOSmqjPtu+
	 2W0Z0tBG75Cf3P0DW3WsUXKX0nSaoFE+jJLq0lWVz3uhDvhCHNz8ZHh9760xGakgAr
	 qg+EmSGZQ2q/RxqH/LwIAF580uYFck9KG73EXZcRzv+7hB0goVB7VqXlZDBx9JLrkw
	 TP/yYbQCUTMHDDXamTX1eUgz5gNFV9CskH3QRkUOQWsJNNOKqBDDSA/5E4gP/1h7Me
	 AUVHe/azjKhr0eYle8aRjjL9qZjZ6WLSOX1/42TAc3EIREOL/K7IRZIouV+iAJIKss
	 WD7zw+9OOQ6iw==
Content-Type: multipart/mixed; boundary="===============5952342031053075532=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <63803328eeb37398cdfa03e5991651c0fb151109c74648b599b29b9dd9508a1d@mail.kernel.org>
In-Reply-To: <tencent_6A1D611E2DA9545DA6E76ABCCA806BC39707@qq.com>
References: <tencent_6A1D611E2DA9545DA6E76ABCCA806BC39707@qq.com>
Subject: Re: [PATCH bpf v4] bpf: check cpu_possible() in per-cpu helpers and map callbacks
From: bot+bpf-ci@kernel.org
To: treebacker@foxmail.com,bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,netdev@vger.kernel.org,treebacker@foxmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 03:21:45 +0000 (UTC)

--===============5952342031053075532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: check cpu_possible() in per-cpu helpers and map callbacks

TL;DR: Not a bug, a design question: the new cpu_possible() check in the
bpf_map_lookup_percpu_elem() helper looks redundant, since every per-cpu map
callback now does the same check. Could it be dropped?

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -133,6 +133,10 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
>  BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
>  {
>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
> +
> +	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
> +		return 0;
> +
>  	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);
>  }

This isn't a bug, but is the extra check in the
bpf_map_lookup_percpu_elem() helper needed?

Every map_lookup_percpu_elem callback (percpu_array_map_lookup_percpu_elem(),
htab_percpu_map_lookup_percpu_elem() and
htab_lru_percpu_map_lookup_percpu_elem()) now rejects impossible CPUs
itself, and check_map_func_compatibility() only admits those three map
types for this helper.

When bpf_do_misc_fixups() patches the call into a direct call to the
callback, the helper body never runs.  So the helper-level check never
decides anything on either path.

Could it be dropped, to match bpf_map_lookup_elem() and friends, which
leave argument checks to the map ops?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42553704194
--===============5952342031053075532==--
