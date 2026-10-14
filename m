Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0233556B
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970004; cv=none; b=pYulVozkkaN5z1kwz6diDBi+DtzyYCyptgxMrXh3SzQ45iv5+6xnfZbe1WKVWdEV+k+8IHuZjktBeLB1GnClGEQ4JiGYvEADDE6Gz2eYVYSTruScHoMH6d8f0f8ziaC/CZESRYm/voAfJSfWabaJWsRwV/g1R/P1UYqxgUC9X+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970004; c=relaxed/simple;
	bh=xom4DIAfYXt4JYrn50/eoVphw0Ha+wmvJ1wyX+pe+bQ=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=LxwHhs1dieIOQ9lSyJOBIbSqdSmrldDG1z+TMz7hg8hApKpsrEJeEA8DACG1Y84zu1YXYi+V4kVqoxByHC52+WKlO02DFESGmrEByfSwRC6OLVJZOR5j4bKC0vyxl5w8ay/8D2mpVjGaJotGAF8vem9pjF0ZLzVN2uv6+/NCiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAEcNdsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAEcNdsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EF91F000FF;
	Wed, 14 Oct 2026 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791970000;
	bh=0PoBVJZPuuH/j4AO7aWuGJz2ccZjENURAgIk06iOb1k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PAEcNdsDR39ytmYHDB5m0uVfvtzMXWwbq9q6LcgMuXGx9Eb496IG/vgbYnCmLoDhm
	 k81hgk9quRDoYrhVNeDE1oAyjhTggkXiIa97rr63XaKNOgVdCINQEXK5fro3jeTUP6
	 HnwhQXWbWlX+RsKYjJvGG/rBPbu64STXRKKLviRC4w67kHZ5Q5Ak+00TnTKZkY73FK
	 maamPBoeTkLBG4zn/l7/GzG5A9RzmuK/MSKyoRfjGNTWWBUIVLP8Wm5VgwOplkN1kb
	 W6nFiQlRnuT4Pwl6/Z4jSBMwSKDj8rr3DW6NOLuBtjjLEBssdDsYUaeYIcnVnjIH97
	 xwFwUnj8QpCZA==
Message-ID: <sashiko-outbox-171070@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: allow ksock connect/send calls from wq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261014091450.19107-1-mahe.tardy@gmail.com>
References: <20261014091450.19107-1-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 09:26:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: selftests: u64 map key mismatch causes ksock_wq failure on =
big-endian
--

commit e40a8841b185289348c211758c8754c0959c28bd
Author: Mahe Tardy <mahe.tardy@gmail.com>

bpf: allow ksock connect/send calls from wq

This commit relaxes the constraint on not using the workqueues for ksock=20
connect() or send() kfuncs. It also updates the selftests to verify this=20
behavior.

> diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing=
/selftests/bpf/progs/ksock_wq.c
> index 16a1873d132ed..290736e219e1d 100644
> --- a/tools/testing/selftests/bpf/progs/ksock_wq.c
> +++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
> @@ -14,15 +15,19 @@ struct ksock_wq_value {
> =20
>  struct {
>  	__uint(type, BPF_MAP_TYPE_ARRAY);
> -	__uint(max_entries, 1);
> +	__uint(max_entries, 2);
>  	__type(key, u32);
>  	__type(value, struct ksock_wq_value);
>  } work_map SEC(".maps");

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
Could this cause failures on big-endian systems?

In ksock_wq_start(), the key variable was changed from u32 to u64, but
work_map is defined as a BPF_MAP_TYPE_ARRAY with a u32 key.

When &key is passed to bpf_map_lookup_elem(), big-endian systems will read
the first 4 bytes of the u64 (which will be 0 for both iterations in the
loop).

This would cause the lookup to return the element at index 0 multiple times,
leading to double-initialization of the same workqueue via bpf_wq_init()
and subsequent failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014091450.1910=
7-1-mahe.tardy@gmail.com?part=3D1
