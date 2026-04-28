Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F01F4C8E
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335499; cv=none; b=teo19h2YRVMb0t0/jWP7MhXkZMSK44cREuygJI8W6QZawDWUIfR6fYratzJPEmEc8stjJtTANjRSC2yaymDOQRQCDrbB1lKVTKw4nidQTq7H3oe372vSJE1aEcVnyeB9zKevI6IR8FZqldPJ/wR/1v1cmHnW+FQDV0X/Ke/PZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335499; c=relaxed/simple;
	bh=rs/loKSPCrCwJx0wqWu4OKxF9+shK5VUCGshR1wav0o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nxPtc/VFFw5+v0ma/Tsh+03Bn2oLGOPe5/zYVD7m7CAhEQ7xhOqSkyuNTo/qM/8xQKbJWJ68DzpjXMpEDIBMW2x8EZsT+fGDgve4219mQEZFskxPO4cHY3H1PNLkXW9y6SobiDKOnatQwgeGRZDe3L5chq6NHm6+5EBPpHVdr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Odxpre11; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odxpre11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283B1C2BCB4;
	Tue, 28 Apr 2026 00:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335499;
	bh=rs/loKSPCrCwJx0wqWu4OKxF9+shK5VUCGshR1wav0o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Odxpre11FA4zWCRPYnLJt5zhe+zr5tWh5P7+54Qyhu8FZcw9Q8Be81f9tonrkk0Ze
	 KWeUFiDMzkdt7dcGQ4LiF4FbsBLQzfTq8FQPVJFayv+XoM2hfDyASUqGVi2GKbHdoX
	 /FQMywHlf223llkzFAseQ7DkvMorDkrJ0udZvaEl4anER7PckN8iKTf+fKl1NVCxXb
	 oO2SR7Iw4dnauBBDSVfNM5/X5J4ELrFdAql1edYx6x5X5eufTV08qigJmr7JIXCZNa
	 07C2MFUr6k+0hfNjpa6e0Ij4fqQP0pu0e7MXh0l4owUmd5eXeCfanG7/YwdNkT4nCU
	 +V9ArfW6/E7NA==
Content-Type: multipart/mixed; boundary="===============6557608411247539606=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bd9153900ca619eb806074142bc6cb1eb2e224b3a00cf6cd70f471363e88d3fc@mail.kernel.org>
In-Reply-To: <20260427232313.1582588-6-puranjay@kernel.org>
References: <20260427232313.1582588-6-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: Add XDP load-balancer BPF program
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,feichen@meta.com,taragrawal@meta.com,ndixit@meta.com,tehnerd@tehnerd.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Apr 2026 00:18:19 +0000 (UTC)

--===============6557608411247539606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> new file mode 100644
> index 000000000000..b9fd848c035d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> @@ -0,0 +1,647 @@

[ ... ]

> +SEC("xdp")
> +int xdp_lb_bench(struct xdp_md *xdp)
> +{
> +	void *data     = (void *)(long)xdp->data;
> +	void *data_end = (void *)(long)xdp->data_end;
> +	struct ethhdr *eth = data;
> +	struct ethhdr saved_eth;
> +	__u32 rand_state = 0;
> +	__u32 batch_hash = 0;
> +	int saddr_off = 0;
> +	bool is_v6;
> +
> +	if (eth + 1 > data_end)
> +		return XDP_DROP;
> +
> +	__builtin_memcpy(&saved_eth, eth, sizeof(saved_eth));
> +
> +	is_v6 = (saved_eth.h_proto == bpf_htons(ETH_P_IPV6));
> +
> +	saddr_off = sizeof(struct ethhdr) + (is_v6 ? offsetof(struct ipv6hdr, saddr) :
> +					     offsetof(struct iphdr, saddr));
> +
> +	if (flow_mask)
> +		rand_state = bpf_get_prandom_u32() | 1;
> +
> +	if (cold_lru) {
> +		__u32 *saddr = data + saddr_off;
> +
> +		batch_gen++;
> +		batch_hash = (batch_gen ^ bpf_get_smp_processor_id()) * KNUTH_HASH_MULT;
> +		if ((void *)(saddr + 1) <= data_end)
> +			*saddr ^= batch_hash;
> +	}
> +
> +	return BENCH_BPF_LOOP(
> +		process_packet(xdp),
> +		({
> +			if (__bench_result == XDP_TX) {
> +				if (strip_encap(xdp, &saved_eth))
> +					return XDP_DROP;
> +				if (rand_state)
> +					randomize_src(xdp, saddr_off, &rand_state);
> +			}
> +			if (cold_lru) {
> +				void *d = (void *)(long)xdp->data;
> +				void *de = (void *)(long)xdp->data_end;
> +				__u32 *__sa = d + saddr_off;
> +
> +				if ((void *)(__sa + 1) <= de)
> +					*__sa ^= batch_hash;
                                     ^^^^

Does the cold_lru simulation actually generate the intended cache misses?

Inside BENCH_BPF_LOOP, the source IP address is XORed with the constant
batch_hash value on every iteration. Since batch_hash does not change
within the loop, this XOR operation will toggle the IP address between
only two unique values.

If the LRU cache is sized to hold both IP addresses, after the first two
iterations the system will continuously hit cached entries rather than
experiencing the cache misses that the cold_lru simulation is intended to
produce.

Would using a different random or incrementing value for each iteration
ensure a continuous stream of unique addresses?

This concern was raised by sashiko-bot in the RFC v1 patch series but
remains unaddressed in v2.

> +			}
> +		})
> +	);
> +}
> +
> +char _license[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25025533577
--===============6557608411247539606==--
