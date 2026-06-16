Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF173376BF4
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639484; cv=none; b=jaeOGDUUnoFFK1kJf6qZBa+uzGJaH41P6/hpPkbXK9fd7F+KbCcH/EmTcdp85R84wUyr8CaTNDTM5S1b7UtKFKugpwMBz84nR9Cw0wbnhr0MRbfpFd3n2eXRU5xemSIBq5jZucH+vt9IVObKUBavlITRz6nKjMLkw9riHvQapgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639484; c=relaxed/simple;
	bh=WD4l4sqCATU2gxWvx002zn8emoJS8OFuUuOurGlTKJ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=YVdNbbvS8TeGwpbOOTJyPVGvyeVoS/P45jR3TLnJ2QpYPTe7e7B0X45LP8vdTeXRt5fTGCDxOzzkOqZhyPuUD5g98tKj3gRpdOPIYN1g+ajQ9Vp4lHvLYzz5LuU6BPwkQJJRW3DcBGoCBvqMNrk+wSauGZ6DKmY0szLXS7FKj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Iw58xqZb; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Iw58xqZb"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304f590dd91so5714152eec.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781639481; x=1782244281; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNTzigFQwbFmsifrPrRSsqzfneDghrV3vzmjFHKgOuY=;
        b=Iw58xqZbE5bp3R64eT2r6zxPNaRkRVZNYaIVER4bTDMxPO+4yGm8MYLCU2T37Dr45q
         y239nMCPIh/NIlRXb5Dujtdkm/veztNXB5FsPlCEBu8ooHSOBI1QCEYN7K8nFyByrqH5
         qIv0Qlx4XapwpMgiRO8xlbCz3gDoHbUqZXgk468xqJ9lPq7AFTmyqpuq26PQdLe9QEd2
         txUEDydl3RGDDS9SKH+JR8UPifsbpa+ILgkmNq1OdagQpndhbaVKuKRxvBk3Z5VovasE
         tmnM4tGuYeQ3YZYEDwjeieqVjpdZ0sSjMSOTYPYZts+1h/uOVaDV07o3FQa+SWnd/Za5
         qaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781639481; x=1782244281;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNTzigFQwbFmsifrPrRSsqzfneDghrV3vzmjFHKgOuY=;
        b=sg6cky7Fqx3c75sgUVMc2s+EhEnhDOI5dgUI1fi+s3M2QV3dZ9rQhPDUC84D9hTD0C
         S6FzRlMBuBVEWZlJzA1b6frvsJVDe4GOlLJ0ppNPHyTqfsDdiEMfnkYlZMWWM9RfcSa+
         vI2hDK5u/nE+Qu27m9tsC15RlB8JOTq3TGjP/e8WyBt2zJIPFsjwfL0AlEcg9LaUs/0T
         6MC2dE5WC9b4n8nzqyiq99zYN9HENynWbOOgZSfTQ9CvdQ4jKyDsefHzV4+J5i1u8V0G
         7nxH2ymCn0mgoJGmV6hoh5WB6y5Vm6+gXI+5XSgRE2lD6VpyDMufWF7mgr+/p3XRblVT
         2a1g==
X-Forwarded-Encrypted: i=1; AFNElJ+9Td3KfrdL18Tg+slkfKkJJ8Ex5TEa/673QlbFNduRMuK6LTDwbckA8pUy+I1ohruWZvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYB0JdDfdByQOP53G+zxJe6HCaz55gI7zTdiTIKjTDWW2Fool+
	oEkjO28V2sVoAvoNUnN0EGQrtSB4v8VqezehPY3ue4FK/xG516iJGjf4OUuStGYeniw=
X-Gm-Gg: Acq92OEDQjx+Eh/HO8Pw1dZ3aWl8yBjOFL+HIpglcbTr1uyGLxNTriDlilT/bmJxufX
	2h1i29kKY5Ewps88V3QdhqERFaEzBZ1UKAbvPbrfpDle/6rcTLAlxM1C8cpXwfq97a1u51Zrlxp
	b2Nv+XSJANyABx9aF0DaAUnd1opgIq1VePk7mqN3CX8aEoy6y/8Zh7lFRVlqsqbpG/UhUcLWipe
	Cejp21QyodZj7y7XzQNtjusXBR0QSpNsy7zMZZAfnd1rASKTVTZ3JArKrgqwG5iLRwJexwbp5U2
	WtPJr/PdU8qizoqlzzrKVbKClK/vxJ6kN/6rNk8DS+aFRatBLT7LMHDK02EDOVuCVB0m2rc+A2o
	OG6i8YzlEDuEFGx74VdNMuwNikrVke0BNyOA/s87UnqQ3a1WBz6CZcDSfuOXAbX1zsHu62XlIBZ
	o2FPxymCtNqRzSKQ8=
X-Received: by 2002:a05:7301:6447:b0:307:91f5:8eee with SMTP id 5a478bee46e88-30bc9ab7f03mr529598eec.12.1781639480848;
        Tue, 16 Jun 2026 12:51:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1a8e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bbbd636fasm2362945eec.22.2026.06.16.12.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 12:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 15:51:18 -0400
Message-Id: <DJAQHH1BGTIN.IKCRPQQXBBT1@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Jiri Olsa"
 <jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 11/14] resolve_btfids: Process KF_ARENA_*
 flags in resolve_btfids
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-12-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-12-ihor.solodrai@linux.dev>

On Mon Jun 1, 2026 at 6:18 PM EDT, Ihor Solodrai wrote:
> For kfuncs flagged KF_ARENA_RET, KF_ARENA_ARG1 or KF_ARENA_ARG2,
> address_space(1) attribute (type tag with kflag=3D1) needs to be emitted
> to BTF for the return type or arg type respectively.
>
> So far this has been done by pahole [1].
>
> Implement the emission of the arena attributes in resolve_btfids: for
> flagged kfuncs create a new function prototype with updated BTF types,
> adding tags as necessary.
>
> Similar to decl tags emission, the transformation is idempotent: if
> the types are already tagged with address_space(1), it's a noop.
>
> [1] https://lore.kernel.org/dwarves/20250228194654.1022535-1-ihor.solodra=
i@linux.dev/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/resolve_btfids/main.c | 131 ++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index f276200b1a68..aafbcfec755b 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -162,6 +162,9 @@ struct object {
>  };
> =20
>  #define KF_FASTCALL (1 << 12)
> +#define KF_ARENA_RET (1 << 13)
> +#define KF_ARENA_ARG1 (1 << 14)
> +#define KF_ARENA_ARG2 (1 << 15)
>  #define KF_IMPLICIT_ARGS (1 << 16)
>  #define KF_IMPL_SUFFIX "_impl"
> =20
> @@ -1294,6 +1297,128 @@ static int ensure_decl_tag(struct btf2btf_context=
 *ctx, const char *tag_name,
>  	return push_decl_tag_id(ctx, new_id);
>  }
> =20
> +static bool is_arena_type_attr(struct btf *btf, u32 id)
> +{
> +	const struct btf_type *t =3D btf__type_by_id(btf, id);
> +	const char *name;
> +
> +	if (!t || !btf_is_type_tag(t) || !btf_kflag(t))
> +		return false;
> +	name =3D btf__name_by_offset(btf, t->name_off);
> +	return name && strcmp(name, "address_space(1)") =3D=3D 0;

The type is just called "arena" - address_space(1) is a different
attribute that is consumed by the compiler and is not visible in the BTF.

While we're at it, can we factor the name out into a #define?

> +}
> +
> +static s32 ensure_arena_tagged_ptr(struct btf *btf, u32 ptr_id)
> +{
> +	const struct btf_type *ptr =3D btf__type_by_id(btf, ptr_id);
> +	s32 tag_id;
> +
> +	if (!ptr || !btf_is_ptr(ptr))
> +		return -EINVAL;
> +
> +	if (is_arena_type_attr(btf, ptr->type))
> +		return ptr_id;

Another thing: Clang (very very) recently got support for adding
btf_type_tag for typedef'ed types. Do we nned to expand the check
to run in a loop like so:

while (btf_is_modifier()) {
	if type_tag()
		test();

	follow the chain
}

to find tags hidden within typedefs?

> +
> +	tag_id =3D btf__add_type_attr(btf, "address_space(1)", ptr->type);
> +	if (tag_id < 0)
> +		return tag_id;

Same here wrt name.

> +
> +	return btf__add_ptr(btf, tag_id);
> +}
> +
> +/*
> + * Build a FUNC_PROTO for @kfunc with each arena-flagged return/paramete=
r
> + * pointer tagged with address_space(1). Pointers already tagged are kep=
t as is.
> + *
> + * If nothing needs tagging, the original proto id is returned unchanged=
.
> + * Otherwise a new FUNC_PROTO is created and its id returned. The origin=
al
> + * proto may be shared with sibling FUNCs, so it must not be modified in=
 place.
> + */
> +static s32 ensure_arena_tagged_proto(struct btf *btf, struct kfunc *kfun=
c)
> +{
> +	const struct btf_type *func =3D btf__type_by_id(btf, kfunc->btf_id);
> +	u32 proto_id =3D func->type;
> +	const struct btf_type *proto =3D btf__type_by_id(btf, proto_id);
> +	const struct btf_param *params =3D btf_params(proto);
> +	u32 nr_params =3D btf_vlen(proto);
> +	s32 arg0_type_id =3D nr_params > 0 ? (s32)params[0].type : -1;
> +	s32 arg1_type_id =3D nr_params > 1 ? (s32)params[1].type : -1;
> +	s32 ret_type_id =3D proto->type;
> +	s32 new_proto_id, id;
> +	bool changed =3D false;
> +	int err;
> +
> +	if (kfunc->flags & KF_ARENA_RET) {
> +		id =3D ensure_arena_tagged_ptr(btf, ret_type_id);
> +		if (id < 0)
> +			return id;
> +		changed |=3D id !=3D ret_type_id;
> +		ret_type_id =3D id;
> +	}
> +
> +	if (nr_params > 0 && (kfunc->flags & KF_ARENA_ARG1)) {
> +		id =3D ensure_arena_tagged_ptr(btf, arg0_type_id);
> +		if (id < 0)
> +			return id;
> +		changed |=3D id !=3D arg0_type_id;
> +		arg0_type_id =3D id;
> +	}
> +
> +	if (nr_params > 1 && (kfunc->flags & KF_ARENA_ARG2)) {
> +		id =3D ensure_arena_tagged_ptr(btf, arg1_type_id);
> +		if (id < 0)
> +			return id;
> +		changed |=3D id !=3D arg1_type_id;
> +		arg1_type_id =3D id;
> +	}
> +
> +	if (!changed)
> +		return proto_id;
> +
> +	new_proto_id =3D btf__add_func_proto(btf, ret_type_id);
> +	if (new_proto_id < 0)
> +		return new_proto_id;
> +
> +	for (int i =3D 0; i < nr_params; i++) {
> +		s32 param_type_id;
> +		const char *name;
> +
> +		proto =3D btf__type_by_id(btf, proto_id);
> +		params =3D btf_params(proto);
> +		name =3D btf__name_by_offset(btf, params[i].name_off);
> +
> +		if (i =3D=3D 0)
Nit: switch() {}?
> +			param_type_id =3D arg0_type_id;
> +		else if (i =3D=3D 1)
> +			param_type_id =3D arg1_type_id;
> +		else
> +			param_type_id =3D params[i].type;
> +
> +		err =3D btf__add_func_param(btf, name ?: "", param_type_id);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	pr_debug("resolve_btfids: added arena-tagged proto for kfunc %s: %d\n",=
 kfunc->name, new_proto_id);
> +
> +	return new_proto_id;
> +}
> +
> +static int process_kfunc_with_arena_flags(struct btf2btf_context *ctx, s=
truct kfunc *kfunc)
> +{
> +	struct btf_type *t;
> +	s32 proto_id;
> +
> +	proto_id =3D ensure_arena_tagged_proto(ctx->btf, kfunc);
> +	if (proto_id < 0)
> +		return proto_id;
> +
> +	t =3D (struct btf_type *)btf__type_by_id(ctx->btf, kfunc->btf_id);
> +	t->type =3D proto_id;
> +
> +	return 0;
> +}
> +
>  static int btf2btf(struct object *obj)
>  {
>  	struct btf2btf_context ctx =3D {};
> @@ -1321,6 +1446,12 @@ static int btf2btf(struct object *obj)
>  			if (err)
>  				goto out;
>  		}
> +
> +		if (kfunc->flags & (KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)) {
> +			err =3D process_kfunc_with_arena_flags(&ctx, kfunc);
> +			if (err)
> +				goto out;
> +		}
>  	}
> =20
>  	err =3D 0;

