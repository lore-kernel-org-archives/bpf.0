Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483480;
	b=1wwARwrcGYoczkDBTSaaQl94PQ/7q4Rn4Kp/92WtNMgKJSNZCnS3vVd4orG8YUr9C5nb
	 4fV8crkYPbY/LfSn5YU1RkDqwajymEbJN0+j7DI2vbAGSW+waRcoKP+pnm3vfzCOXm3Vj
	 1GHu7wOauCxGb3yDgBCObEDsrwy2wQ+C+d0iboprem37N7XxzBiQ9Zd2gLLxCvnn1dnrV
	 B4J3/b/ss6VNnCrpFO8ABSYZlFd66pJ8XerrJwV3N23sslTU/2nGopL7xcNkc935Zuq3G
	 Z112gtS3V6oqIR3GMWFZZrGTa/W12LHRcCL/Y4DGMYGE8sgqgbMHviwcv8jWvyXKcaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483480;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hu6Ap42/vpdKsczGhkoXGQbS71YsejWqmO6Og5y2a1I=;
	b=XbXbOxJAy4Ctnnb+t3QqmBFZU49FptSkkoJ46/pxYlDLiyI37+5j1Cvbo3uOMbqs59Hx
	 BVY88LvPdxHAvYG6GUUauAXylyVxAr96g4sKKacOIYGOMb3eC9vRNBVtw/hHbKKLbycca
	 mSuGEz4/WsDTW7hpO+eysYKB615NDM951Tpz6FEPrau9u7n7Zv4HIW8oaz2pZ8rUXb6jm
	 zA29cCtNRArWRn9L2hketxdbu2wwA7PB0WWHJWWhtsmoEiHI+I3FWBvDkw9KAWL4IGHFj
	 7mx8IDof5RMJy/Ya2nulcdHtgj7sOFg15+fAwW708beG7df4I1WP1FRSUA2Z1hmC2FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6rV8Z8I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B8606A31D
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6rV8Z8I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62E21F000C4;
	Tue, 20 Oct 2026 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483480;
	bh=hu6Ap42/vpdKsczGhkoXGQbS71YsejWqmO6Og5y2a1I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=S6rV8Z8IJ+HrVgB0kgUX4BM36Nqm6K2cwZZZgQro3pDazcYTp9eiecn6A/2tB/7ad
	 1hojvWGTiWZQuM5co5LnQMp9mTuwWMH3bA7/p0q5RfJv6C19dhg5BrgZChd5eRlwgI
	 0tnJX1whrNOKDr1MZBZVkKO227NqHlzMIi2Mi0nqaUxUqEvJ7uI5wWp4suC8Dj0Fem
	 jhyf6+H25UH1WIrIqtTO32lNkG31V7Rg/aNTpipzilb4WUW0D5aEiUh6Ovrd7y5+As
	 P4XgF7Olj4mx76GCKix1qkvKzdl06p3AOzbyi+k8CDOAqF72hNybTreglyEQZ2sgbk
	 y47Ugkz0mBCfQ==
Message-ID: <sashiko-outbox-178475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/1] bpf: reject raw iteration over managed map
 fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiling Zou" <zhilinz@nebusec.ai>, bpf@vger.kernel.org
In-Reply-To: <96a6b5dcf721e49c049662cc269d8ac8c389b6af.1792217106.git.zhilinz@nebusec.ai>
References: <cover.1792217106.git.zhilinz@nebusec.ai>
 <96a6b5dcf721e49c049662cc269d8ac8c389b6af.1792217106.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:04:39 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: ERR_PTR dereference on map->record in map iterator prog c=
hecks
--

commit 5c7120e7a68cabfb0dcb935074cfe787d4f05fb6
Author: Zhiling Zou <zhilinz@nebusec.ai>

bpf: reject raw iteration over managed map fields

This commit restricts BPF map iterators (bpf_map_elem and bpf_sk_storage_ma=
p)
to accessing only the prefix before the first BTF-managed field in a map
value, and revalidates replacement programs during bpf_link_update().

Link: https://lore.kernel.org/all/1fa798d444efac579e91ee0716e228902a8f9afe.=
1791980149.git.zhilinz@nebusec.ai/

> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index c19b360bad9ea..04cf255587aa8 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -135,10 +125,39 @@ static int bpf_iter_attach_map(struct bpf_prog *pro=
g,
>  	else
>  		value_size =3D round_up(map->value_size, 8) * num_possible_cpus();
> =20
> -	if (key_acc_size > key_size || value_acc_size > value_size) {
> -		err =3D -EACCES;
> +	if (key_acc_size > key_size || value_acc_size > value_size)
> +		return -EACCES;
> +
> +	/* Fields are sorted by offset; max_rdwr_access is an exclusive end. */
> +	if (map->record && value_acc_size > map->record->fields[0].offset)
> +		return -EACCES;

[Severity: Critical]
Can this dereference an ERR_PTR in bpf_iter_map_elem_check_prog() when
attaching or updating a map iterator on a BTF-enabled map whose value type
is not a struct or datasec (for example, an int or __u32)?

During BPF_MAP_CREATE, map_check_btf() in kernel/bpf/syscall.c sets
map->record =3D btf_parse_fields(...):

	map->record =3D btf_parse_fields(btf, value_type,
				       BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_L=
IST_HEAD |
				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR |
				       BPF_TASK_WORK,
				       map->value_size);
	if (!IS_ERR_OR_NULL(map->record)) {

When value_type is a scalar (or any non-struct/non-datasec type),
btf_parse_fields() -> btf_find_field() returns ERR_PTR(-EINVAL) (and can
also return ERR_PTR(-E2BIG) when a struct exceeds BTF_FIELDS_MAX). Because
map_check_btf() and the per-map-type check callbacks guard special-field
handling with !IS_ERR_OR_NULL(map->record), map creation succeeds while
map->record holds a non-NULL error pointer.

When BPF_LINK_CREATE or BPF_LINK_UPDATE later calls
bpf_iter_map_elem_check_prog(), checking only if (map->record) evaluates to
true and dereferences map->record->fields[0].offset.

Should this check !IS_ERR_OR_NULL(map->record) instead, matching
check_map_access() and other map->record users?

[ ... ]

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fad..ffbcfab9a71c3 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -846,12 +846,35 @@ static void bpf_iter_fini_sk_storage_map(void *priv=
_data)
>  	bpf_map_put_with_uref(seq_info->map);
>  }
> =20
> +static int bpf_iter_sk_storage_map_check_prog(struct bpf_prog *prog,
> +					      struct bpf_map *map)
> +{
> +	if (map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
> +		return -EINVAL;
> +
> +	if (prog->aux->max_rdwr_access > map->value_size)
> +		return -EACCES;
> +
> +	/* Fields are sorted by offset; max_rdwr_access is an exclusive end. */
> +	if (map->record &&
> +	    prog->aux->max_rdwr_access > map->record->fields[0].offset)
> +		return -EACCES;

[Severity: Critical]
Similarly, in bpf_iter_sk_storage_map_check_prog(), won't this crash when
map->record is an ERR_PTR (such as on sk_stg_map in the existing
test_bpf_sk_storage_map selftest, which uses __type(value, int))? Should
this also use !IS_ERR_OR_NULL(map->record)?

[ ... ]

=E5=AE=8C=E7=BE=8E=E7=BB=93=E6=9D=9F=E3=80=82 (Wait - no extra text! Let me=
 make sure there is no extra text at the end).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792217106.gi=
t.zhilinz@nebusec.ai?part=3D1
