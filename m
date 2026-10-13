Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15664A4985
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916561; cv=none; b=ICrV2iAu8fHPFLbb48pafffbcrbR4yExVJ0/c6YwR9bpIBXwSNtjjzwsorA8AKy2faghPVtkzPjjZYgX99E40blcV/1i8c9+ub2m1wlR0Zo5iHM3/h/D04NpDiijdJM9NzQDZKxAdLGGcD6582w4IjmPJ+sGEXlNb+rwI8fi9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916561; c=relaxed/simple;
	bh=HU9AFexpe1MIWs73n/rLpvGxIbI7vxA67641e/huCaI=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=MhZMGWaGIljlFLD4XlgLk9v/Y7kLj9JnA6IGKe6nhrbjaqiFpHSh4tDgG0LLrKZmE49+vc3B6OUVaF/ZxJWmTSjOwQlWVjasnV98lNngWQ3Mb+7N3N6drx8lkNjJ06ECErX6K7v1eE60/yxInfA5EmYBzccVus9YSRKmMNQIBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5fFbEjM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5fFbEjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E7E1F00893;
	Tue, 13 Oct 2026 18:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916559;
	bh=3PuPtlpazy+gRDZ5cFmfkhMEM7J7a/y39Iv9THIatos=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=l5fFbEjM9JLIetJKU/dD2bw51sQaktDSLzvocYBwzbh+aLD7Ly+iyKpXbph+E8PEU
	 Eln3zoX4m6MJfqMDtS9b+wD+OgUpdQMZN+pzDj7eqUGD00W8Xg0mftbonQmq4o34uS
	 mw5JZZWvp7/MM2oj6X8NZOvInq5yboV7tGeMZi+6BU0jIe1Jz2mjCRjia2yBlLJLKC
	 pAJ8Hv9o1OLy7XDlJSf7W0o4m302vX9aevIxzi95cj6xrHhpmUfr5Wlbtiao+yUSUV
	 48HNBVa4W00vtn3zaKW1RH85xNNH8vSPjDsrvOAamCUtW7KdCGMqnqe9HsNlacLfc5
	 OvxSpR6Z8D1qA==
Message-ID: <sashiko-outbox-170341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: allow ksock connect/send calls from wq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261013182726.276372-1-mahe.tardy@gmail.com>
References: <20261013182726.276372-1-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:35:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: u64 map key causes workqueue double-init on big-e=
ndian
--

commit 5eb6c40a460d2cca2d0dee2b208a0164f311d369
Author: Mahe Tardy <mahe.tardy@gmail.com>

bpf: allow ksock connect/send calls from wq

This commit relaxes the constraint preventing the use of ksock kfuncs from
asynchronous workqueues. It also updates the ksock_wq selftest to verify
that connect() and send() function properly when called from workqueues.

> diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing=
/selftests/bpf/progs/ksock_wq.c
> index 16a1873d132ed..290736e219e1d 100644
> --- a/tools/testing/selftests/bpf/progs/ksock_wq.c
> +++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
[ ... ]
> @@ -43,20 +73,40 @@ static int ksock_wq_callback(void *map, int *key, voi=
d *value)
>  SEC("syscall")
>  int ksock_wq_start(void *ctx)
>  {
> +	struct bpf_ksock_create_opts opts =3D {
> +		.family =3D AF_INET,
> +		.type =3D SOCK_DGRAM,
> +		.protocol =3D IPPROTO_UDP,
> +	};
>  	struct ksock_wq_value *value;
> -	u32 key =3D 0;
> -	int err;
> +	struct bpf_ksock *ks;
> +	u64 key =3D 0;
> +	int err =3D 0;
> =20
> -	value =3D bpf_map_lookup_elem(&work_map, &key);
> -	if (!value)
> -		return -ENOENT;
> -	err =3D bpf_wq_init(&value->work, &work_map, 0);
> -	if (err)
> +	ks =3D bpf_ksock_create(&opts, sizeof(opts), &err);
> +	if (!ks)
>  		return err;
> -	err =3D bpf_wq_set_callback(&value->work, ksock_wq_callback, 0);
> +	err =3D ksock_ctx_insert(ks);
>  	if (err)
>  		return err;
> -	return bpf_wq_start(&value->work, 0);
> +	for (key =3D 0; key < 2; key++) {
> +		value =3D bpf_map_lookup_elem(&work_map, &key);

[Severity: Medium]
Can this cause a workqueue double-init on big-endian architectures?

The work_map map is defined with a u32 key, but the key variable here was
changed to u64. On big-endian systems, passing &key to bpf_map_lookup_elem()
will read the most significant 32 bits, which will evaluate to 0 for both
key =3D 0 and key =3D 1.

Because of this, the loop would fetch the map element for index 0 twice.
During the second iteration, bpf_wq_init() would be called on value->work
while it may already be actively queued from the first iteration. Does
re-initializing an active work_struct without serialization run the risk
of corrupting the global workqueue list and crashing?

> +		if (!value)
> +			return -ENOENT;
> +		err =3D bpf_wq_init(&value->work, &work_map, 0);
> +		if (err)
> +			return err;
> +		if (key)
> +			err =3D bpf_wq_set_callback(&value->work, ksock_wq_create, 0);
> +		else
> +			err =3D bpf_wq_set_callback(&value->work, ksock_wq_connect_send, 0);
> +		if (err)
> +			return err;
> +		err =3D bpf_wq_start(&value->work, 0);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182726.2763=
72-1-mahe.tardy@gmail.com?part=3D1
