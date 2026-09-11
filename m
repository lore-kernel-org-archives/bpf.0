Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9229D3515F8
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139345; cv=none; b=s4uDHPSr+zPrYnNDh5j3uGjZvK10So2JN0rbJ3awR15x9p/kJSgt2aRhTxqtdmNoKMumiXncado4+CWpc352I2F4O8bN1CbX88xnaGbu9nhXSSxIyKKUkiZbZimhEHKQmYggZMigkAnZPvtO54+uhmnzUNAWMjX4ZhQ6f3xYuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139345; c=relaxed/simple;
	bh=TGVxIFLiDFNk/TaJsCA//rn6/bXLkUsuybmt36cPwqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfwhjRNV5zRUiNggwGFNX1LoJenhK/oySvAMxDMkgox9cxlKUrZsaBlGHwLcknDwNJF9+axc5NGhHcNVppFPotAsfpE98apibxl3cv9ThMdoXRXCljMXFYs2e0YFSV77+d5r+J1CU51Yea1ioYD4e4/Go0tbXThm4/vVWaWR2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5cQazLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5cQazLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CF61F00898;
	Fri, 11 Sep 2026 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139344;
	bh=DGCQrSArTmr+zU+Tzkrl9fIqGWxMsjPyYSvw0efrTe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5cQazLHV63aTH1AsA5fw7nt/a+kputl/JHdP77t00XNkxjJIzaAR3K72WJRhU+va
	 bbgUXKi9a7cUR6oj9t/F3oTmwjeqCkm1fx6KHIZAQLa6YkMZPc0KTgACitmOjYEI0s
	 HkVaNUbN7tFXZ79Okgjn6p/AQPYIvjjsT0Zx/eOOVmdi+RzEHSSnyRfNuU+UP4Bsce
	 XTpuGuxFo7Tn2d5PDKf6bKHuZkZ6277/2yQ9rcyEH9vA7nvng5B+0Gg+ZwHo47X1jx
	 C961605HceLF60gmnx5p+oglZGkfL6Mcx+UO9MNkW/xoXYUgeXvF6NQE8+AUQ8UR4e
	 Rt7sy0/pBx13Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 05/14] selftests/bpf: Test skb_ext on cloned
 skbs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-5-0b21e42180b0@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
 <20260910-bpf-meta-inside-skb-ext-v2-5-0b21e42180b0@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:09:03 +0000
Message-Id: <20260911150904.44CF61F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing __msg() macro in __failure verifier tests.
--

commit 3dc92388d2fd6ba878aeec16668062f704faf681
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test skb_ext on cloned skbs

This commit adds coverage for skb_ext behavior when an skb is cloned,
using TC mirred and bpf_clone_redirect(). It tests whether extensions are
readable across clones and verifies copy-on-write isolation.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_skb_ext.c b/tools=
/testing/selftests/bpf/progs/verifier_skb_ext.c
> index db43f10514001..c2611c9315aa7 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_skb_ext.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_skb_ext.c
> @@ -7,6 +7,51 @@
> =20
>  __u64 flags;
> =20
> +SEC("tc")
> +__description("skb_ext slice is invalidated by bpf_clone_redirect")
> +__failure

[Severity: Medium]
Should this test include a __msg("...") macro to verify the exact error
string from the verifier?

If the test fails to load due to an unrelated verifier error (such as a
syntax issue, invalid BTF, or missing kfunc declarations), the test loader
merely checks if loading fails for any reason. This can incorrectly report
a PASS, hiding regressions in the specific slice invalidation logic it is
designed to test.

> +int skb_ext_stale_slice_after_clone_redirect(struct __sk_buff *ctx)
> +{
> +	struct bpf_dynptr meta;
> +	__u8 *slice;

[ ... ]

> +	bpf_clone_redirect(ctx, 1, 0);
> +
> +	/* Stale: the clone shares the ext block the slice points into. */
> +	*slice =3D 0;
> +
> +	return 0;
> +}
> +
> +SEC("tc")
> +__description("skb_ext slice is invalidated when ext is re-opened with F=
_CREATE")
> +__failure

[Severity: Medium]
Similarly, does this test also need a __msg() macro?=20

Without exact error message string verification, the test infrastructure
will pass this test if it fails to load for any reason, rather than
verifying the intended failure reason.

> +int skb_ext_stale_slice_after_recreate(struct __sk_buff *ctx)
> +{
> +	struct bpf_dynptr d1, d2;
> +	__u8 *slice;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-bpf-meta-i=
nside-skb-ext-v2-0-0b21e42180b0@cloudflare.com?part=3D5
