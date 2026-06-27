Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A11EE7B7
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782573655; cv=none; b=FbeBhUArWSPZM7SURs2pKnQJeZI1DgNc5N0fltN7hAzYF1rojzKXZBBlQKlNaKGU53O0BP3a2jdTIUa5w8eLRTFRVXQXcdg1TKHrGVCkuhUCpMiGhgdvZEHp8SQwl62gBrHRUu/rPe07DLxlOX3xbN8jXSpAg+MZ4sdzZjqsKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782573655; c=relaxed/simple;
	bh=DrpAKA9MWrQl+Mc/ekGFuv6gAkSSx4Zm19Vsf0W15hA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DrG/AzmCZen3hyk3A3py0gAw2MAkopErU+OGNh04o3tyt81nkJ3lTnxWJvKIZh2O3QtoXZ3IhDYfTz6fdtImaFw6WucTvEgpDqhGWEf4csUg65tdQWJAkX3SsxNnu4ECeqFTyUZ2b6VJ0P+sZcOp5NCICrvh1M37fLDaFWNMbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBR0AKOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBR0AKOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4CF1F000E9;
	Sat, 27 Jun 2026 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782573653;
	bh=gADDjTlDRj06eA3Qqxgxa10WGc7kC/QUD+OVl9F+Khw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IBR0AKOgW9YQtHiBBoYZ+oAgH4KqudlVkN4ei4uQNwXCzrPgJX+P8auGrddDUS2qt
	 +ff/+2+IEiwC9qcgwcv/yM5qtJzioZNxm/yf+QT9ChQ1J7ZWzNQpmouXdlQWy9r51j
	 vjMWqpLIwaZseTezOmwFGmbSrkYAER6j/oih75+c8CB5RIJlyZYZSemg5fgllUXEUy
	 QzkebQaey2R4ipMWgL40N90Hpe+7XU2XYb99zw8HH3W8nacWhFn4EzM7e27N+AR+Vv
	 7R2gqy9dZm8eFDvUMjcWrv20WfEb+Pcsj82/nQc3SP9eYeIND0gTV5UPZF47gY9M1f
	 PJp0sW8vabaHA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 05/12] bpf: Collect SDT probe BTF IDs from
 BTF decl tags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <ec8e3dcd0857d4ed80151ab68be9acf01fa4d93b.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <ec8e3dcd0857d4ed80151ab68be9acf01fa4d93b.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 15:20:52 +0000
Message-Id: <20260627152053.7C4CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Missing bounds check for `val.nargs` during `BPF_MAP_TYPE_INSN=
_ARRAY` map update allows a massive out-of-bounds stack write (buffer overf=
low).
- [High] Modifying the size of `struct bpf_insn_array_value` breaks ABI com=
patibility.
- [Medium] `sdt_collect_btf_ids()` unconditionally dereferences `obj->btf`,=
 causing a segmentation fault when an ELF file lacks BTF info.
- [Medium] The `<nargs>` parameter in the `bpf_sdt:<name>:<nargs>` BTF tag =
is ignored during parsing, potentially causing incorrect BTF ID assignments.
--

commit f74606f5fc3911fea2fa7d9d52875deb5fbf475d
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Collect SDT probe BTF IDs from BTF decl tags

Collect SDT probe BTF IDs from BTF decl tags matching name pattern
"bpf_sdt:<name>:<nargs>". The IDs are ultimately stored in each probe
entry of the SDT map.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7739,6 +7739,7 @@ struct bpf_insn_array_value {
>  	__u32 orig_off;
>  	__u32 xlated_off;
>  	__u32 jitted_off;
> +	__u32 btf_id;		/* BTF FUNC_PROTO type ID (0 if none) */

[Severity: High]
Does changing the size of struct bpf_insn_array_value break ABI backward
compatibility?

When libbpf attempts to load a BPF program on an older kernel, create_jt_ma=
p()
will use the new sizeof(struct bpf_insn_array_value) for the .jumptables map
value size.

Will older kernels reject this map creation since they expect the value size
to be exactly the old size?

>  	__u8  nargs;		/* argument count (0..5) */
>  	__u8  arg_reg[5];	/* BPF register for each argument */
>  	__u8  pad[2];

[ ... ]

> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -103,6 +103,7 @@ static long insn_array_update_elem(struct bpf_map *ma=
p, void *key, void *value,
>  	insn_array->values[index].orig_off =3D val.orig_off;
> =20
>  	if (insn_array->subtype =3D=3D BPF_INSN_ARRAY_SUBTYPE_SDT) {
> +		insn_array->values[index].btf_id =3D val.btf_id;
>  		insn_array->values[index].nargs =3D val.nargs;

[Severity: Critical]
Is there a bounds check missing for val.nargs before it is copied here?

If a malicious user provides a large value for val.nargs during map update,
could this cause an out-of-bounds write later in the attach path?

For example, in bpf_sdt_link_attach(), the loop iterates based on this valu=
e:

bpf_sdt_link_attach() {
    ...
    tgt_info.fmodel.nr_args =3D sdt->val.nargs;
    for (i =3D 0; i < sdt->val.nargs; i++) {
        tgt_info.fmodel.arg_size[i] =3D 8;
        tgt_info.fmodel.arg_regs[i] =3D sdt->val.arg_reg[i];
    }
    ...
}

Since the target arrays have a fixed capacity, would a large nargs value
overflow the kernel stack buffer?

>  		memcpy(insn_array->values[index].arg_reg, val.arg_reg, sizeof(val.arg_=
reg));
>  	}

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -6692,6 +6693,57 @@ static int create_jt_map(struct bpf_object *obj, s=
truct bpf_program *prog, struc
>  	return err;
>  }
> =20
> +static void sdt_collect_btf_ids(struct bpf_object *obj)
> +{
> +	int n =3D btf__type_cnt(obj->btf);

[Severity: Medium]
Can obj->btf be NULL here if the ELF object was compiled without BTF
information?

If so, would calling btf__type_cnt() on a NULL pointer cause a segmentation
fault during bpf_object__open() when parsing SDT notes?

> +	const struct btf_type *t;
> +	int i;

[ ... ]

> +		/* match by name (tag format: "bpf_sdt:<name>:<nargs>") */
> +		for (j =3D 0; j < obj->sdt_entry_cnt; j++) {
> +			struct sdt_entry *e =3D &obj->sdt_entries[j];
> +
> +			if (!e->btf_id && strlen(e->name) =3D=3D name_len &&
> +			    strncmp(tag + 8, e->name, name_len) =3D=3D 0)
> +				e->btf_id =3D func_proto_id;

[Severity: Medium]
Does this string comparison logic correctly handle overloaded SDT probes?

The code parses the tag format "bpf_sdt:<name>:<nargs>" and compares the
probe name, but it appears to ignore the nargs substring when matching
the tag.

If multiple probes share the same name but have different argument counts,
could this assign the incorrect BTF ID to a probe, causing the kernel to fa=
il
the program load when verifying the argument count?

> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D5
