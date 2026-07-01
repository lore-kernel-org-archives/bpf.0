Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414C3DEFF3;
	Wed,  1 Jul 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918353; cv=none; b=b5n7aNgCZnodEEVUKPD4C0FMRHwQSLAh/r0waI83EHatlFIfgaxr0bZLsrPdMjHm7jVDzK65SD8Cpx4sXG0JrBGqIiXe+e5pfNxCOZ98pVZ8Ig3dyzST1YWXKKl6l5zjrx3dkpCFN+wSGVjHt7IjCC8USvAmsaxWThhZWksJg8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918353; c=relaxed/simple;
	bh=or3hPIZbPoOaBgnTdgyL7/HNn8rMByBUZVMg8606shA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mFj/2yJknYmRRgE+B1kC/tyNJGn49mNW+MCIubvFIGw8CYLhKrfCEbVD3PmPpRBOaZHZgyd8x9cxPMv8ODWK244B9FJ9ubFZEKQ5DM2oKvGARboXSCjsa9zLIMBXaf2Z6eG2bGWbeZaC1OGlZGOzqfZ4F+8V1S/sVhI/0d1V8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wbn3zhq5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wbn3zhq5"
Message-ID: <283f55ab6c34b18168a028ea00bbea5d3c953696.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782918347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2N2ubHpEGlsNN+e4PWzIK19b4wg2KdeWN810bbfmOA=;
	b=wbn3zhq5RlLzW2rEgMi0RqhGCiyj+TtBImo1wigJtguPUmaB7lAVHV3bGoqkFS9MnI6sKg
	ZVA9D7s7IGIxeSADRkAdBOXNECHU7bHPkaIyhacyPXEQmRIzaPnBHdrLSiJnq4jLmYWuDB
	+DQm4tWggeb9V3Ad7M72w9qKgrKxn64=
Subject: Re: [PATCH] bpftool: use btf_vlen()/btf_kind()/btf_kflag() helpers
 consistently
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: luoliang@kylinos.cn, Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 01 Jul 2026 23:05:23 +0800
In-Reply-To: <20260701062541.704792-1-luoliang@kylinos.cn>
References: <20260701062541.704792-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Wed, 2026-07-01 at 14:25 +0800, luoliang@kylinos.cn wrote:
> From: luoliang <luoliang@kylinos.cn>
>=20
> The btf_vlen(), btf_kind() and btf_kflag() inline helpers defined in
> tools/lib/bpf/btf.h are thin wrappers around the BTF_INFO_VLEN(),
> BTF_INFO_KIND() and BTF_INFO_KFLAG() UAPI macros - each one simply
> returns the corresponding macro applied to t->info.
>=20
> bpftool already uses these helpers in most places, but 13 call sites
> in btf.c and btf_dumper.c still open-code the raw macros. Use the
> helpers consistently, matching the rest of bpftool as well as libbpf.
>=20
> No functional change.
>=20
> Signed-off-by: Liang Luo <luoliang@kylinos.cn>
> ---
> =C2=A0tools/bpf/bpftool/btf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 12 ++++++------
> =C2=A0tools/bpf/bpftool/btf_dumper.c | 14 +++++++-------
> =C2=A02 files changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 6ef908adf3a4..24e4cb600b3f 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -179,7 +179,7 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
> =C2=A0	case BTF_KIND_STRUCT:
> =C2=A0	case BTF_KIND_UNION: {
> =C2=A0		const struct btf_member *m =3D (const void *)(t + 1);
> -		__u32 i, vlen =3D BTF_INFO_VLEN(t->info);
> +		__u32 i, vlen =3D btf_vlen(t);
> =C2=A0
> =C2=A0		if (json_output) {
> =C2=A0			jsonw_uint_field(w, "size", t->size);
> @@ -193,7 +193,7 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
> =C2=A0			const char *name =3D btf_str(btf, m->name_off);
> =C2=A0			__u32 bit_off, bit_sz;
> =C2=A0
> -			if (BTF_INFO_KFLAG(t->info)) {
> +			if (btf_kflag(t)) {
> =C2=A0				bit_off =3D BTF_MEMBER_BIT_OFFSET(m->offset);
> =C2=A0				bit_sz =3D BTF_MEMBER_BITFIELD_SIZE(m->offset);
> =C2=A0			} else {
> @@ -224,7 +224,7 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
> =C2=A0	}
> =C2=A0	case BTF_KIND_ENUM: {
> =C2=A0		const struct btf_enum *v =3D (const void *)(t + 1);
> -		__u32 i, vlen =3D BTF_INFO_VLEN(t->info);
> +		__u32 i, vlen =3D btf_vlen(t);
> =C2=A0		const char *encoding;
> =C2=A0
> =C2=A0		encoding =3D btf_kflag(t) ? "SIGNED" : "UNSIGNED";
> @@ -300,7 +300,7 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
> =C2=A0		break;
> =C2=A0	}
> =C2=A0	case BTF_KIND_FWD: {
> -		const char *fwd_kind =3D BTF_INFO_KFLAG(t->info) ? "union"
> +		const char *fwd_kind =3D btf_kflag(t) ? "union"
> =C2=A0							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "struct";
nit: coding style, and can be one line.
> =C2=A0
> =C2=A0		if (json_output)
> @@ -322,7 +322,7 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
> =C2=A0	}
> =C2=A0	case BTF_KIND_FUNC_PROTO: {
> =C2=A0		const struct btf_param *p =3D (const void *)(t + 1);
> -		__u32 i, vlen =3D BTF_INFO_VLEN(t->info);
> +		__u32 i, vlen =3D btf_vlen(t);
> =C2=A0
> =C2=A0		if (json_output) {
> =C2=A0			jsonw_uint_field(w, "ret_type_id", t->type);
> @@ -365,7 +365,7 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
> =C2=A0	case BTF_KIND_DATASEC: {
> =C2=A0		const struct btf_var_secinfo *v =3D (const void *)(t + 1);
> =C2=A0		const struct btf_type *vt;
> -		__u32 i, vlen =3D BTF_INFO_VLEN(t->info);
> +		__u32 i, vlen =3D btf_vlen(t);
> =C2=A0
> =C2=A0		if (json_output) {
> =C2=A0			jsonw_uint_field(w, "size", t->size);
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumpe=
r.c
> index 9dc8425b1789..e4075824343f 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -476,8 +476,8 @@ static int btf_dumper_struct(const struct btf_dumper =
*d, __u32 type_id,
> =C2=A0	if (!t)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	kind_flag =3D BTF_INFO_KFLAG(t->info);
> -	vlen =3D BTF_INFO_VLEN(t->info);
> +	kind_flag =3D btf_kflag(t);
> +	vlen =3D btf_vlen(t);
> =C2=A0	jsonw_start_object(d->jw);
> =C2=A0	m =3D (struct btf_member *)(t + 1);
> =C2=A0
> @@ -535,7 +535,7 @@ static int btf_dumper_datasec(const struct btf_dumper=
 *d, __u32 type_id,
> =C2=A0	if (!t)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	vlen =3D BTF_INFO_VLEN(t->info);
> +	vlen =3D btf_vlen(t);
> =C2=A0	vsi =3D (struct btf_var_secinfo *)(t + 1);
> =C2=A0
> =C2=A0	jsonw_start_object(d->jw);
> @@ -557,7 +557,7 @@ static int btf_dumper_do_type(const struct btf_dumper=
 *d, __u32 type_id,
> =C2=A0{
> =C2=A0	const struct btf_type *t =3D btf__type_by_id(d->btf, type_id);
> =C2=A0
> -	switch (BTF_INFO_KIND(t->info)) {
> +	switch (btf_kind(t)) {
> =C2=A0	case BTF_KIND_INT:
> =C2=A0		return btf_dumper_int(t, bit_offset, data, d->jw,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 d->is_plain_text);
> @@ -631,7 +631,7 @@ static int __btf_dumper_type_only(const struct btf *b=
tf, __u32 type_id,
> =C2=A0
> =C2=A0	t =3D btf__type_by_id(btf, type_id);
> =C2=A0
> -	switch (BTF_INFO_KIND(t->info)) {
> +	switch (btf_kind(t)) {
> =C2=A0	case BTF_KIND_INT:
> =C2=A0	case BTF_KIND_TYPEDEF:
> =C2=A0	case BTF_KIND_FLOAT:
> @@ -661,7 +661,7 @@ static int __btf_dumper_type_only(const struct btf *b=
tf, __u32 type_id,
> =C2=A0		break;
> =C2=A0	case BTF_KIND_FWD:
> =C2=A0		BTF_PRINT_ARG("%s %s ",
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTF_INFO_KFLAG(t->info) ? "union" : "s=
truct",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btf_kflag(t) ? "union" : "struct",
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btf__name_by_offset(btf, t->name_=
off));
> =C2=A0		break;
> =C2=A0	case BTF_KIND_VOLATILE:
> @@ -718,7 +718,7 @@ static int btf_dump_func(const struct btf *btf, char =
*func_sig,
> =C2=A0		BTF_PRINT_ARG("%s(", btf__name_by_offset(btf, func->name_off));
> =C2=A0	else
> =C2=A0		BTF_PRINT_ARG("(");
> -	vlen =3D BTF_INFO_VLEN(func_proto->info);
> +	vlen =3D btf_vlen(func_proto);
> =C2=A0	for (i =3D 0; i < vlen; i++) {
> =C2=A0		struct btf_param *arg =3D &((struct btf_param *)(func_proto + 1))=
[i];
> =C2=A0

