Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6F51477C
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682052; cv=none; b=G7YBl2S8QHtQUbo0c0iTY/vx6Yk8+byUx2n836ZR9yZ3CYPl+aUcSobNInmmxcEANViEe3SluCe8JOZVI4KQXmTLgDRo0SsdSD/1ZK4PXSQLgOPtyVYClUlgJ7gh0hD14b4D/Mtv7thrduxOi3cKXVp06mqHxwZ7XFwWKKFXBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682052; c=relaxed/simple;
	bh=eUi6ixGAoe7q5/v7lFOzrZvwWkrsKJpHuoS4QNssZNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FX3z9936ndwxg4x/6CwQ5jdFiwrPV97h06LwvJk35Vu7Lyy8qFPB/3CX3gKykwXQATg4Zl/YkHFvX7UZDI/eTPpyVlZfqAWGJFzcBvTuQxVRsZjE57JjiFX540cduo+GT7bkhiolYjNLrm69QHwhqOM6yygJfMyP0w9eYk36hik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+91MGDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+91MGDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A451F00899;
	Tue, 29 Sep 2026 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682050;
	bh=gf6gbCT6NB5+Ugzw4dOtEnEnpF5k3Y8fENJwlSFYa/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+91MGDKllDPO7RhrQ7CtdUi72NHBSdxE8H7v5ISMTtz9VPw9t2zL+9uUmLSxegU7
	 tnodj3+ibv+p25XxabJym6KcBzyHCnjcpSyk9ac3FQibpFkFzTy1xJafNi2pakKeJj
	 hMoXtf6aRC+QLrER32AmGTQZhXP6eOsNe5QMtGSKF9kEKtaI9k7gmoDyUhPC+NbgRM
	 2stzh6FPWtFWcdo1v+s+ETx6iJKNg8rMr+JUcnd9rKa6u2tYz79G7w/ldZ+6EYhR3y
	 N/wyMTTolrkEFYVpq3B+8phX2rDkC7vvOKSw47PzfCUziCO8+4S2zDEGk9Xn887clJ
	 6Vde1w1i7WWOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 05/15] selftests/bpf: Basic tests for metadata
 passing with gated skb tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-5-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
 <20260928-bpf-meta-gated-tracepoints-v1-5-844dbf3e1edf@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:40:49 +0000
Message-Id: <20260929114049.F3A451F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: ineffective map emptiness check in assert_meta_stash_empty()
--

commit 79ae30674787d12e96bd4c0fbc9d3bd7fe424d9c
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Basic tests for metadata passing with gated skb tracepoints

This commit adds tests for metadata passing where test programs stash
per-packet metadata in a hash map. It covers device round trips and clones
by propagating entries from the copy tracepoint and reclaiming them from
the free tracepoint.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 448807676176c..c9b115c14acb6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
[ ... ]
> @@ -693,3 +704,147 @@ void test_xdp_context_lwt_encap(void)
> =20
>  	test_xdp_meta__destroy(skel);
>  }
> +
> +/* Assert that the free tracepoint prog drained the metadata stash */
> +static void assert_meta_stash_empty(struct bpf_map *meta_map)
> +{
> +	struct bpf_map_info info =3D {};
> +	__u32 info_len =3D sizeof(info);
> +
> +	if (!ASSERT_OK(bpf_map_get_info_by_fd(bpf_map__fd(meta_map), &info,
> +					      &info_len),
> +		       "get_info"))
> +		return;
> +
> +	ASSERT_EQ(info.map_extra, 0, "meta_map not empty");

[Severity: Medium]
Is this map emptiness check effectively a no-op?

For BPF_MAP_TYPE_RHASH maps, info.map_extra reflects the static nelem_hint
configuration parameter set during map creation, rather than the dynamic
number of elements currently residing in the map.

Since the meta_map is not configured with a map_extra attribute, won't it
default to 0 and remain 0 indefinitely, causing this assertion to always
pass even if map elements are actually leaked?

> +}
> +
> +static void test_skb_trace__tuntap(struct test_xdp_meta *skel)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-bpf-meta-g=
ated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com?part=3D5
