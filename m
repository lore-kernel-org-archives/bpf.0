Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0777D34104E
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099350; cv=none; b=hp+eQwkqpzGlBTDdPSOMYCsRKtyaCV62Noc90KTiT3xQeCxEk9C8WHoSnM4PcnQcqIH4eRYMqb4dy+W8mv8IkmvDkGE1r59drv4+aW1+9aA6pPyl3koPyyI33HGu9CkwYX61LiZ3D4yezrxjfq6gTfpiJ8XY+7SrJFUL7OZuUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099350; c=relaxed/simple;
	bh=H9HEUm8U5MK4U+UcwPTJhqyu4UwJK5xeOAfn/gMLpmY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UJn/gy6BIEjDyry4ugxccruE+NBiRbJCpJpyjyitJgO6BtekTH11kEwDoHbUmFvztOjoCAtWeKGYOQ/CXXkmOla5yNEark7Y6TXAK88DKtpTB5AqrIj6WSGBiyGgTJe6hZ8YvHOuLJxgPGaOrchz8IX9CWO3fkV6nHBcNYtHB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkOE6BzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkOE6BzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B341F000E9;
	Wed, 15 Jul 2026 07:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784099348;
	bh=H9v1g7EKp8Uf4V8A+iVOwBqfRLakLF85NSMth3QPbUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkOE6BzNsjntqrvhZq/qaQ4xgEyIs9h9yvkAA78NKezKf8VjDo4MuhsHRC2FPbmiC
	 tHjqsuxo934jVRBBlfkbRFF+N41Fk1THIjGEJtkB1wcQ6H9P5OyNt/ZWtXkmuFym/q
	 ysvQxtrqqKeChofeBP6U3h2uEbFFwhLMXv1pRGeCIEjKy4fsHrHEYD5smW01AjnDVG
	 8Wlc57fPKL3kr2mwPnOnQUED1EJP8obiYOho2bAGcBUqa5JCA5nhvWpNhd2jdEeJiR
	 XVSBiyql7rszL4IcBH9jJbZ+9FpDwwIQy+WSybRoyfFq1aW68cDGOYMpFyYn+82/ST
	 0L/WQqZvgteyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Factor out raw_mode-related fields
 in bpf_call_arg_meta
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715064047.1793790-3-ameryhung@gmail.com>
References: <20260715064047.1793790-1-ameryhung@gmail.com>
 <20260715064047.1793790-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 07:09:07 +0000
Message-Id: <20260715070908.30B341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `bpf_map_peek_elem` reads uninitialized stack memory when used=
 with `BPF_MAP_TYPE_BLOOM_FILTER`, causing a kernel stack information leak.
--

--- Patch [2]: [PATCH bpf-next v2 2/7] bpf: Factor out raw_mode-related fie=
lds in bpf_call_arg_meta ---
commit b67be9cc9af835cbe1e71cd21cd41e24382f1240
Author: Amery Hung <ameryhung@gmail.com>

bpf: Factor out raw_mode-related fields in bpf_call_arg_meta

This patch groups scattered MEM_UNINIT memory argument fields into a new
struct arg_raw_mem_desc. It identifies raw arguments upfront in
check_raw_mode_ok(), matching them by register number in
check_stack_range_initialized() to eliminate the separate raw_mode flag.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7dd961ede88df..1a41f99a9133c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -7727,7 +7725,13 @@ static bool arg_type_is_mem_size(enum bpf_arg_type=
 type)
> =20
>  static bool arg_type_is_raw_mem(enum bpf_arg_type type)
>  {
> -	return base_type(type) =3D=3D ARG_PTR_TO_MEM &&
> +	/*
> +	 * A map value output buffer (e.g. bpf_map_pop_elem) is also a raw
> +	 * (uninitialized) memory argument, and like ARG_PTR_TO_MEM it may be
> +	 * passed as a PTR_TO_STACK that reaches check_stack_range_initialized(=
).
> +	 */
> +	return (base_type(type) =3D=3D ARG_PTR_TO_MEM ||
> +		base_type(type) =3D=3D ARG_PTR_TO_MAP_VALUE) &&
>  	       type & MEM_UNINIT;
>  }

[Severity: Critical]
This is a pre-existing issue, but does treating ARG_PTR_TO_MAP_VALUE as
uninitialized memory expose a stack information leak when used with
bpf_map_peek_elem() and Bloom filters?

The verifier prototype bpf_map_peek_elem_proto specifies MEM_UNINIT | MEM_W=
RITE,
which assumes the map operation acts as an output buffer and will initialize
the memory.

However, when called on a BPF_MAP_TYPE_BLOOM_FILTER, bloom_map_peek_elem()
uses the buffer strictly as an input to compute a hash without writing to i=
t:

kernel/bpf/bloom_filter.c:bloom_map_peek_elem() {
    ...
    for (i =3D 0; i < bloom->nr_hash_funcs; i++) {
        h =3D hash(bloom, value, map->value_size, i);
        if (!test_bit(h, bloom->bitset))
            return -ENOENT;
    }
    ...
}

Since the map never initializes the buffer, but the verifier believes it
does, could a BPF program use this to read uninitialized kernel stack memor=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715064047.1793=
790-1-ameryhung@gmail.com?part=3D2
