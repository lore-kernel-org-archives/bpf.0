Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83431E846
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789883815; cv=none; b=Btb7wFO92X2YTTWm+4Tnb5idE9d5mY1KVOV7IvV2wcLYjNHfg1F1B08T2kIDchBgyfqrwROk5GsY1Hq/cB/NnqUq5hOadHkOtLgwjfKaL65UaxmALQUXGPmGOD2YTE9PbeouXI0z7G/+Z/dD9dGRf3G7vj8iXdYiBuMw0gGX4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789883815; c=relaxed/simple;
	bh=yidVDL+Z1GrKYA/7kQ0t4oPrfK9atkmhqGx+BPWz/mY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZTiPFQleN1tWDBDKDfExyervYDmNktPt8dmNESzZKDfdxoy/pHlI4b05VuwF4oQqXrM1BslbK7AD5T5mu5FOa+l3hwFxo+/8/W1Aty5+eX0b9m/Y0wdtnsxOwq6GmuJW4KGTSjnJ4UmcAZybmgV4ZgxqFazSouSqYcTB1DdtTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEvbmxvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEvbmxvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6D91F000FF;
	Sun, 20 Sep 2026 05:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789883813;
	bh=mY9oytsbcodhTTQkQ1xRscgZ9QQNBM941U12J0Iw440=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iEvbmxvgPKjdE9Ny3rugu2LgjH9nseQAmmxw/7587sU56gbGs5kM29tO4dDDh35No
	 rkoGRva5a+trhG3kl/fIcC/lYZkQZyGiz2hAwAZ1N+mgNVQk4BLzZCz5QGyR1vC8ed
	 +iWCJf3U9LdL9RMsJSI7CuuLkxFnVlp369bsFsXV7oshtJ2KzvHKTCMUm1MRLeqqpM
	 BuzIT1VivsH6utBMLATo+0Bbwb3ZOo1wKWg8lLtWC3T21FWs5gqnNBydQos1OhEyuH
	 kAphk2aIn54xX5lBSyBrGMe52nOuNyP5+sBThzuLQOYjcMXOQHGnGkYL7erU9FDTmJ
	 ZnUpSp34jUSdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 01/20] bpf: Accept the compiler's exception
 cleanup table at program load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920054231.865520-1-yonghong.song@linux.dev>
References: <20260920054225.864535-1-yonghong.song@linux.dev>
 <20260920054231.865520-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:56:52 +0000
Message-Id: <20260920055653.6D6D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: unbounded memory allocation in check_cleanup_info via clean=
up_info_cnt
--

commit 18ab7230f0d26780fd3b40453aca2155a679f967
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Accept the compiler's exception cleanup table at program load

This commit adds support for BPF exception handling cleanup tables generated
by LLVM. It introduces a new UAPI to pass the .bpf_cleanup table into the
kernel via BPF_PROG_LOAD, along with the necessary validation logic in
check_cleanup_info().

Link: https://github.com/llvm/llvm-project/pull/192164 [1]

> diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
> index 0e8b3ccc7a5b9..d03dc791042a2 100644
> --- a/kernel/bpf/check_btf.c
> +++ b/kernel/bpf/check_btf.c

[ ... ]

> @@ -407,6 +407,149 @@ static int check_core_relo(struct bpf_verifier_env =
*env,
>  	return err;
>  }
> =20
> +static int cleanup_insn_subprog(struct bpf_verifier_env *env, u32 off)
> +{

[ ... ]

> +static int check_cleanup_info(struct bpf_verifier_env *env,
> +			      const union bpf_attr *attr,
> +			      bpfptr_t uattr)
> +{
> +	u32 krec_size =3D sizeof(struct bpf_cleanup_info);
> +	u32 i, nrec, urec_size, min_size, prev_end =3D 0;
> +	struct bpf_cleanup_info *krecord;
> +	bpfptr_t urecord;
> +	int ret =3D -EINVAL;
> +
> +	nrec =3D attr->cleanup_info_cnt;
> +	if (!nrec)
> +		return 0;
> +	if (nrec > INT_MAX / krec_size)
> +		return -EINVAL;

[Severity: Medium]
Can an unprivileged user trigger a multi-gigabyte memory allocation here
by passing an artificially large attr->cleanup_info_cnt?

While the allocation below uses GFP_KERNEL_ACCOUNT and will not cause a CPU
lockup, kvcalloc() still attempts to allocate and zero up to ~2.1 GB of
memory.

Since each cleanup info record must cover at least one instruction and
they cannot overlap, is there a case where nrec could legitimately
exceed env->prog->len? Would it be safer to add a bounds check like
if (nrec > env->prog->len) before the allocation to prevent this
resource churn?

> +
> +	urec_size =3D attr->cleanup_info_rec_size;
> +	if (urec_size < MIN_BPF_CLEANUP_INFO_SIZE ||
> +	    urec_size > MAX_CLEANUP_INFO_REC_SIZE ||
> +	    urec_size % sizeof(u32)) {
> +		verbose(env, "invalid cleanup info rec size %u\n", urec_size);
> +		return -EINVAL;
> +	}
> +
> +	krecord =3D kvcalloc(nrec, krec_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN=
);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920054225.8645=
35-1-yonghong.song@linux.dev?part=3D1
