Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FECE33E346
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693431; cv=none; b=CPPTETTb1ZoulJayJraaN6FyjgQ0FlvjdafPuODzSi3uZUFdp5gsdWytv8HhYy7PK60HOIVo42qwaerTYNipDdUn3pM6tqDNgW77Nmg4TlWZCxUN6f8SP98NYUYL7MiA7a6iY9O4YZpJrN2NuVkuV0K2CqmEukUPbQ5O3cnS5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693431; c=relaxed/simple;
	bh=oJUuUrZNx15t1ilt7COZioRMx6g62mzO+ZkikZcdM3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BHGio+HGA7PG+UQeaQnIC5//rKn7eA5P6PzkajfU4niYdSx7R03w8AKQ+MZ/kEus++QKh8wA4UPoHqv6Q70STI8fzHuqXjxPiTroUA/Jr7aMZI0ZktExEofg79/Is/sJjiaqBjjkQx4SwZ7TuMX+9kZm/uE71WpNA2BrggvbLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HASieAmB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HASieAmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22028C19425;
	Mon, 20 Apr 2026 13:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776693431;
	bh=oJUuUrZNx15t1ilt7COZioRMx6g62mzO+ZkikZcdM3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HASieAmBK+moU4ysUUjdFA5WlqXA1YL1nADlDdCQdvUocPh3heXMkW4qBH6oDUi4U
	 LpV/y87iLWlaO4kIhjJTYfori5R2He9gixy8TYaQXFgBs55RnBpb39Io7+nMSy99/I
	 8a7VFSZQD/BwKkEiQstv/nGQSnETZMJdxkER4N5tH1ADBDl6fOie/l7/6ttiBfjmMc
	 d6lVRbtL8EBfdlH+RFy5tnYOm8hBM2BUj3Cm7PhGJwQUMa8WwNVD+3IKRq+mCBrHDE
	 OPp8TEP33NLSHnBqfnQG7bC0CbcC4PT6uZFRSF2U8E1gmWtaJlq2UsnhRqDjcTN/0N
	 bfpXC/a/15yvg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 4/6] selftests/bpf: Add XDP load-balancer
 BPF program
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420111726.2118636-5-puranjay@kernel.org>
References: <20260420111726.2118636-5-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 13:57:10 +0000
Message-Id: <20260420135711.22028C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The `cold_lru` logic toggles the source IP using a constant `bat=
ch_hash` inside `BENCH_BPF_LOOP`, failing to simulate a cold LRU cache.
--

commit bb32650934d99141c2338de7bad7c3586c22bdd3
Author: Puranjay Mohan <puranjay@kernel.org>
selftests/bpf: Add XDP load-balancer BPF program

This commit adds the BPF datapath for the XDP load-balancer benchmark,
implementing a simplified L4 load-balancer. It includes L3/L4 parsing,
VIP lookup, and an LRU connection table.

> diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/tes=
ting/selftests/bpf/progs/xdp_lb_bench.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c

[ ... ]

> +	if (cold_lru) {
> +		__u32 *saddr =3D data + saddr_off;
> +
> +		batch_gen++;
> +		batch_hash =3D (batch_gen ^ bpf_get_smp_processor_id()) *
> +			     KNUTH_HASH_MULT;
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
> +					randomize_src(xdp, saddr_off,
> +						      &rand_state);
> +			}
> +			if (cold_lru) {
> +				void *d =3D (void *)(long)xdp->data;
> +				void *de =3D (void *)(long)xdp->data_end;
> +				__u32 *__sa =3D d + saddr_off;
> +
> +				if ((void *)(__sa + 1) <=3D de)
> +					*__sa ^=3D batch_hash;

Does this code accurately simulate a cold LRU cache?

Inside BENCH_BPF_LOOP, the source IP address is XORed with a constant
batch_hash on every iteration. Since batch_hash does not change within the
loop, the IP address will simply toggle back and forth between two unique
values.

Because the LRU cache is large enough to hold both IPs, this will result
in continuous cache hits after the first two iterations, instead of the
cache misses intended by the cold_lru simulation.

Should a different random or incrementing value be used for each iteration
to ensure a continuous stream of unique addresses?

> +			}
> +		})
> +	);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420111726.2118=
636-1-puranjay@kernel.org?part=3D4
