Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE34EA397
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209500; cv=none; b=Yi4ryXxNnLROzj8rIJyqzowgft4iHB8dODEJnHyrQvLmbGcBwn4VLrAncju9/gntnRMDTHlB5zTx9XBt6zKZtwrF2B0N4uSHrhf6eKsBmZk+ScPCETZcyxpzrc7vW7S5gBeCMd3ugJThZKJ8WUjPfchgi2Ln3X5xUB1I9GfSbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209500; c=relaxed/simple;
	bh=N01SU6YDoFkzdTnXUKmXX4Rd/sGkSQCTOMunTPuW4AQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QGLgWoTX8Wt12OHD8V/IkhjC4gqIm8QTOo7a33FLj2f/nKR2gaUENOSeJJywV1wPC26xlQN82H1j+TNaNEvLimNafJ6mhfVE+xdlxhkAZeVVhmRp+E/cJLTX+cnci5M0u2HKVQQZXdWcXD1h0zMluozGMU0kvR5l9nQId23UMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA2RqYP0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA2RqYP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12529C2BCB3;
	Tue, 19 May 2026 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779209500;
	bh=N01SU6YDoFkzdTnXUKmXX4Rd/sGkSQCTOMunTPuW4AQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CA2RqYP0DI3mfJpfI+nHd0+x3eLdpN3sPAhyzMgX4YdCmyvUiw4+N/89rvv7Yzxi/
	 yykQCqw8UCKXv2tUmf23eeW3UGoCbgnMRzzasBFLfLDeeAPsEKcsULVDB90uBZ9Q3q
	 MkIqAxXZ/3fywraV3KUT17MeEOhhV56H/wZ2WegmkN7yVyLPB8BILA3t9GtzXfbks4
	 tve5Y6x69RkBBk1/RQgDq+bvuYLNzVkJbIiIWhW8aWP4DveQMPOtlDmZmZdJ6ISoqq
	 shxo22uLSe54hA4xjD7xA8/OsyZ+/SyoVkYsdZ2DzJQS4BQ/+8ouo1FGNXkSGvJTFm
	 jIrXvnpNwOTlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Fix cold_lru producing zero
 batch_hash in XDP LB benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519163632.2220753-2-puranjay@kernel.org>
References: <20260519163632.2220753-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 16:51:39 +0000
Message-Id: <20260519165140.12529C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The fix for zero `batch_hash` introduces a regression in the `co=
ld_lru` benchmark by destroying the lowest bit of entropy, causing 50% of c=
onsecutive batches to generate identical hashes.
--

commit d60966744103a5bacba48698e7e96189a24c69c1
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Fix cold_lru producing zero batch_hash in XDP LB benchmark

This commit addresses an issue in the cold_lru benchmark where a batch_hash
of zero causes the benchmark to incorrectly hit warm LRU entries. It attemp=
ts
to fix this by bitwise-ORing the input to the hash multiplier with 1.

> diff --git a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c b/tools/tes=
ting/selftests/bpf/progs/xdp_lb_bench.c
> --- a/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_lb_bench.c
> @@ -618,7 +618,7 @@ int xdp_lb_bench(struct xdp_md *xdp)
>  		__u32 *saddr =3D data + saddr_off;
> =20
>  		batch_gen++;
> -		batch_hash =3D (batch_gen ^ bpf_get_smp_processor_id()) * KNUTH_HASH_M=
ULT;
> +		batch_hash =3D ((batch_gen ^ bpf_get_smp_processor_id()) | 1) * KNUTH_=
HASH_MULT;

[Severity: Medium]
Does this code introduce a regression where using | 1 inadvertently destroys
the lowest bit of entropy from the batch generator?

Since batch_gen increments sequentially by 1 per batch execution, forcing
the least significant bit to 1 maps pairs of adjacent values to the same
number. For example, if the CPU ID evaluates to 0, both batch_gen =3D 2 and
batch_gen =3D 3 will yield 3 before the multiplication.

Could this cause 50% of consecutive batches to generate the exact same
batch_hash as the previous batch, causing those iterations to hit the warm
LRU cache entries that were just populated and defeating the purpose of
the cold_lru benchmark?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519163632.2220=
753-1-puranjay@kernel.org?part=3D1
