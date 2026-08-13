Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15B2C3268
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665012; cv=none; b=S17Og482qvk+gyEUioZXrOrYQL/vQ0a7g+AeR/yZvQpw/uLT/BvvCPC2mJYQCQNbC5lHoH0p23QjxCkIKbZ5pM0cef5ldUrJAkzt14jZN9PMzPwTSJb8SLWKcFWtWiV7hZPidQdA9/2WDe/Up2HQp5c+BhDJPXiYSF5uZjRa+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665012; c=relaxed/simple;
	bh=Mi8wDgb9AAm24uWpCdrIacxxaFUwHfNYn7BmsSyLjPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZPD5nd665RyIVKDVs+Eg9tzOWg+0cLFzsTA4al+X/G0tcFFyGeT/nLaEIhONaNzBSyTfSkg4DLpr5mVYVoW1ly537H2/fXQkVUgnmjaKjcizSrzu4vkeI314q+IwNUZeBXv3LhhblSuZnEbFFmpnHarbLMk7o9GGZPkVW9U9Zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3f1m6bE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3f1m6bE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8F71F000E9;
	Thu, 13 Aug 2026 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786665010;
	bh=tBnk5zvnh8KwcsuRCwNsbHZT2eqiiHbSVzCMoMGPCw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M3f1m6bExh5M9dBdG5a4qNti8j/Nxw43fV9Fm8DvEAWrjW//XMRoqMm0C8afr6W5i
	 +dE1QvKjmxa3v+XsLYjtKHKKsi/yTxmdXjdUsQ14j414RAG/NDjo0mcmDigSbRbCG0
	 ri3V7oC+NPEAOt6lAFRChpqeic88CpeoaltAUyZlWJPd4v98Bw5nNzmNjLj4kETNTz
	 yDsgROYyvNpU1ps3f32TjtmtQOp6cd6A6wS7EUivuS87Th2fcT3jb+tv+VJcbMX9s1
	 rMr/TGLQ2bZn2xQWHBTsErSUpmXsFBnlPxDb95JH47rBr5bMV7m1bkH99uBb27ouQu
	 YP8dZGPTxL3fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: Allow use of feature cache for
 non-token cases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260408105324.663280-2-alan.maguire@oracle.com>
References: <20260408105324.663280-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:50:06 +0000
Message-Id: <20260813235010.BB8F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `bpf_object_prepare_token` unconditionally overwrites `obj->feat=
_cache` if BPF tokens are supported, leaking any custom cache set by `bpf_o=
bject_set_feat_cache` and causing test mocking to be environment-dependent.
--

--- Patch [1]: [PATCH v2 bpf-next 1/2] libbpf: Allow use of feature cache f=
or non-token cases ---
commit 118614ae13eed03565933d30357d27d00e3145b4
Author: Alan Maguire <alan.maguire@oracle.com>

libbpf: Allow use of feature cache for non-token cases

This patch exposes a new internal API, bpf_object_set_feat_cache(),
allowing BPF selftests to assign a custom feature cache to a bpf_object.
This enables simulating missing kernel features to test BTF sanitization
fallback paths.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 42bdba4efd0c6..b7b636786d387 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -5203,12 +5203,20 @@ bool kernel_supports(const struct bpf_object *obj=
, enum kern_feature_id feat_id)
>  		 */
>  		return true;
> =20
> -	if (obj->token_fd)
> +	if (obj->feat_cache)
>  		return feat_supported(obj->feat_cache, feat_id);
> =20
>  	return feat_supported(NULL, feat_id);
>  }
> =20
> +/* Used in testing to simulate missing features. */
> +void bpf_object_set_feat_cache(struct bpf_object *obj, struct kern_featu=
re_cache *cache)
> +{
> +	if (obj->feat_cache)
> +		zfree(&obj->feat_cache);
> +	obj->feat_cache =3D cache;
> +}
> +

[Severity: Medium]
If a test sets a custom cache using this function and then loads the object,
could bpf_object_prepare_token() overwrite and leak this custom cache if BPF
token creation succeeds?

Looking at bpf_object_prepare_token(), it unconditionally allocates a new
cache when token creation is successful:

tools/lib/bpf/libbpf.c:bpf_object_prepare_token() {
    ...
	obj->feat_cache =3D calloc(1, sizeof(*obj->feat_cache));
	if (!obj->feat_cache) {
		close(token_fd);
		return -ENOMEM;
	}
    ...
}

Would this cause testing environments to behave non-deterministically?
It seems tests might successfully preserve the mock cache on systems without
token delegation (where bpf_token_create fails and returns early), but lose
the mocked state and leak the initially injected cache on systems with token
support.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408105324.6632=
80-1-alan.maguire@oracle.com?part=3D1
