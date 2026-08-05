Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270A3ED5C9
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917259; cv=none; b=mMPAo6omyLJQH8WrzT/fOmG2+Yh6MOuZ0EC7rcdIi0APlar/ZmtluC2/Te/LyS0JlpUV6jyKJTBMfRck6r7GGiCUnnQg1sf/Jda9SfdgH+3bQ7caDSO6segy02iZJCDNgJBiZIfuS5nHO9k/pt0mfz12rDFv1wRtyonoI4WUUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917259; c=relaxed/simple;
	bh=a7sRoi3nHvuFhLoQ4Y+8dFA5DNggoyzANuvxIuAeOSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bUDWltb4/YKRaq8pRI067mVTn8gYS2Si6K+0B3UejCKyugymxjPKcC2IWQiqf9J1p4DVJ5kdrhHX5u0bFXeRkQbrKK3LhXTNiQ7s++6zH6uokHU+yIMuRJ+e90X7Ex8DP2mtjYAp4jLScWP8HZcbHBfDoquu6VuPzUVWJ42wdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0PnPmIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0PnPmIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4411F00A3A;
	Wed,  5 Aug 2026 08:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785917245;
	bh=iIa7R6dcd2lgXlVhwCygpSGBiodGDSkd8vt57sSw9X8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E0PnPmIEI1EuzQPaBUT7x9RSkuatsc93M/9xyAe/LiL4kzMUzAIucNTraBAIALIX/
	 Ztz9fnYnshzzsEkshK1gRTuDycEWTRZyPgq4p0GcOPRJDUjSrm5UdWXmKJOJOAbshb
	 JU/wXfZze9PacmKxe7sLYb4o4+LUU6t07v44KQ+ZCvDhDUXOY6akjNfFH5I3LUoQpd
	 fWJmWbg6xlZafMqMNFkLr59z35h9oFVnGQXzWpyUOHDDJjP2pQf4lOLTtNE157CvFP
	 F2V1p1qWNIzdnWsqBCDhH3An5DQOHwsKqIuAJDwAYqicatJFGC/IuTN/RAq9y1K4WQ
	 C2V6ek7cQo2Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fsverity: reject short BPF digest buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yichong Chen" <chenyichong@uniontech.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805075655.950308-1-chenyichong@uniontech.com>
References: <20260805075655.950308-1-chenyichong@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 08:07:24 +0000
Message-Id: <20260805080725.0E4411F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds write (TOCTOU) due to use of shared memory in pointe=
r arithmetic.
--

--- Patch [1]: [PATCH] fsverity: reject short BPF digest buffers ---
commit f40b6203fcacca3140ba489474dd88b289d0ffc4
Author: Yichong Chen <chenyichong@uniontech.com>

fsverity: reject short BPF digest buffers

bpf_get_fsverity_digest() reports the digest size as the full hash digest
size. However, when the provided dynptr only has room for part of the
digest, the helper currently copies the truncated digest and still returns
success. This changes it to return -EOVERFLOW instead to match the ioctl
measurement path.

> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index cfe2d5e535f96..4cfadba95488b 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -148,9 +148,11 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file =
*file, const struct bpf_dynp
>  	arg->digest_size =3D hash_alg->digest_size;
> =20
>  	out_digest_sz =3D dynptr_sz - sizeof(struct fsverity_digest);
> +	if (out_digest_sz < hash_alg->digest_size)
> +		return -EOVERFLOW;
> =20
>  	/* copy digest */
> -	memcpy(arg->digest, vi->file_digest,  min_t(int, hash_alg->digest_size,=
 out_digest_sz));
> +	memcpy(arg->digest, vi->file_digest, hash_alg->digest_size);
> =20
>  	/* fill the extra buffer with zeros */
>  	if (out_digest_sz > hash_alg->digest_size)

[Severity: High]
This is a pre-existing issue, but can the arg->digest_size field be modified
concurrently after it is initialized?

Looking at bpf_get_fsverity_digest(), the memset() operation directly follo=
wing
this hunk uses arg->digest_size to compute the destination pointer:

    if (out_digest_sz > hash_alg->digest_size)
        memset(arg->digest + arg->digest_size, 0,
               out_digest_sz - hash_alg->digest_size);

Since arg is a pointer into a dynptr that might be backed by shared memory,
if an attacker overwrites arg->digest_size with a large value before the
memset() executes, could this cause an out-of-bounds write of zeros into
kernel memory?

Would it be safer to use hash_alg->digest_size instead of re-reading
arg->digest_size when calculating the pointer offset for the memset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805075655.9503=
08-1-chenyichong@uniontech.com?part=3D1
