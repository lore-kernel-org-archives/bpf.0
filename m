Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BB7478
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338337; cv=none; b=bBDwbJgmqo0BmNWmzHaSkk5fsJQ1I44aajj2NiCzxCHpz0CgatAofsX1Q+wS33JFlvjB/3b6Qb9F/hOa8Dfqe7iwg+cdtZdeyf9VLd10eHerR+k6KOmPSCv9+NQw9tZxQiyCmh0g9CwavV3F0oEV5qZcpU+PQK70QftthZnvHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338337; c=relaxed/simple;
	bh=LDoYjg2IDUxz7lW9eEdYI2DUr07w7pKXFh8FgjXw4S4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VSbonDcd4UVJJlcPQ4xqPLkZOq2yZnkkMH+8rG/hxlNbwAo4DKpR0cXj1OLXJupVULtfh8GZ9LqfyVl39NV+iEho+BA2rC3JHMQjObsdMRoBSB3MqELwyRVO3OuoT2CvfptZaOKdusdY1vLmLukiqv54DewO9ez401wELlCY8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEhP5UQ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEhP5UQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D54C2BCB4;
	Tue, 28 Apr 2026 01:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777338337;
	bh=LDoYjg2IDUxz7lW9eEdYI2DUr07w7pKXFh8FgjXw4S4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oEhP5UQ9fQ8DzIQSQKtEKqqK52LpOAlfWZ9mwnsj7j44gl7gH9wyVhCZlMkXFBFpG
	 YCee8W/59xr+eW29q58GPJW1rXXcQAf4frq/2Q6zR5YlqkQkptdjbHMos+hhh9HTSo
	 5WvJIYqheby8a3v8eecmz4KE+yNJas3VI+fw4rHhaPABRNucq9pDwJw+4tzI7nXTc/
	 IMpSq22tN7bHnDpGRN5x4OVHrfQ7eWdpiyolBP06wVM3mzTnn68ztrHUpYer43AXI/
	 cN/q3d7+wbXHKJ6zCUgjowouq2/SUcDzBmUr3XMh9pXUMs1m+HCIRWH/oQ9tPYouVl
	 0Z8z+30Z8IwOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: Add XDP load-balancer BPF
 program
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427232313.1582588-6-puranjay@kernel.org>
References: <20260427232313.1582588-6-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 01:05:36 +0000
Message-Id: <20260428010537.21D54C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The `cold_lru` logic inside the benchmark loop's `reset` block t=
oggles the IP source address back and forth, breaking the benchmark's LRU c=
ache miss measurement.
--

commit 295ed705f4fdd57c01615b43803c47313840bbf1
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add XDP load-balancer BPF program

Add the BPF datapath for the XDP load-balancer benchmark, a
simplified L4 load-balancer inspired by katran.

> diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/tes=
ting/selftests/bpf/progs/xdp_lb_bench.c
> new file mode 100644
> index 000000000000..b9fd848c035d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
[ ... ]
> +SEC("xdp")
> +int xdp_lb_bench(struct xdp_md *xdp)
> +{
[ ... ]
> +	if (cold_lru) {
> +		__u32 *saddr =3D data + saddr_off;
> +
> +		batch_gen++;
> +		batch_hash =3D (batch_gen ^ bpf_get_smp_processor_id()) * KNUTH_HASH_M=
ULT;
> +		if ((void *)(saddr + 1) <=3D data_end)
> +			*saddr ^=3D batch_hash;
> +	}
> +
> +	return BENCH_BPF_LOOP(
> +		process_packet(xdp),
> +		({
> +			if (__bench_result =3D=3D XDP_TX) {
> +				if (strip_encap(xdp, &saved_eth))
> +					return XDP_DROP;
> +				if (rand_state)
> +					randomize_src(xdp, saddr_off, &rand_state);
> +			}
> +			if (cold_lru) {
> +				void *d =3D (void *)(long)xdp->data;
> +				void *de =3D (void *)(long)xdp->data_end;
> +				__u32 *__sa =3D d + saddr_off;
> +
> +				if ((void *)(__sa + 1) <=3D de)
> +					*__sa ^=3D batch_hash;

Does this code toggle the source IP back and forth on alternating iteration=
s?

Because batch_hash is computed outside the loop and remains constant, XORing
the source IP on every reset block will cause it to alternate between two
values.

Won't this allow the LRU cache to easily cache both addresses, leading to a
near 100% cache hit rate and defeating the purpose of measuring cold_lru ca=
che
misses?

> +			}
> +		})
> +	);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427232313.1582=
588-1-puranjay@kernel.org?part=3D5
