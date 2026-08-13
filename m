Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9CA48BD34
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635772; cv=none; b=TwUx0t7xkmgW1p3t+1hqPk/GhlcFb2p/tEe6el3O4XQJzDuZuxfKIdyUX10kjgwtxQ9TJO7pQZfiFP7nfJmAKPyA3ZWIyYd3YD+i7zGTt/VFlK3SVg4aa9YMyt65J4NL+BenlniyVw6zh1sohi/XFRBJZ0gWi9Lt0s+a24Wotqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635772; c=relaxed/simple;
	bh=DsTCygJTaKZiH+BqNscJuUIOUaP0MoRgt8GZ4RTlBTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e5XuAD0QQUEK82KEcvHffJqngPJO5rIJ8+P96xraIdqWlzHSp7T5IG2t1ZCMT2rIljTEOYBB0oZqA2mVVEixPeUY/SXZ3BP1eV2N0Ajw0uYJFAeqCh9B8Mkl/hdviq+h7Wu0rqGyvyZBUt/KLKYNJOYeARSE0J+t9qu2goPbp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml+9KNb1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml+9KNb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA831F000E9;
	Thu, 13 Aug 2026 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786635769;
	bh=Yp/zTfl7Gb1sv786R21fWp/06PvLW5AoU58dMqwP54g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ml+9KNb1CnNMePPD2VpsE7rh1mrTJ0Y+PjEgGFQOY5chZK1oMJ7dbJUDw0U/Et8iJ
	 C4pgPQaE8LkvQ8d4s4HQo7MFcfD4VDGBkmI5qz0K6wLPVeEovP1mw9eoPi2LQf/HDF
	 162QltUnPtco6DGAsHH1myL74rJw9ESDioy5J1aA7/A6WWNQ/VjZnZuRWhoIYpuo+1
	 ZaNYVP0/4gWG3h4bosxvV4/BQ5snWnio75JEqJUBFNx//9lPGbRAPhZGtuQHlJ8OZg
	 ZRhgfs79UX/bLLj5eNHLAABb6J3OZEKQYi2RYfpnASkbssOyxleoPGRlCJIgll0pk+
	 bCdxGZOHD3clA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v12 05/10] libbpf: Add support for global
 percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813152324.97937-6-leon.hwang@linux.dev>
References: <20260813152324.97937-1-leon.hwang@linux.dev>
 <20260813152324.97937-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:42:48 +0000
Message-Id: <20260813154249.1CA831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] bpftool gen skeleton fails to generate fields for .percpu maps, br=
eaking lightweight skeleton generation memory layout.

Pre-existing issues:
- [High] A massive >4GB ELF section causes a gigabyte-scale out-of-bounds m=
emcpy buffer overflow in libbpf.
--

--- Patch [5]: [PATCH bpf-next v12 05/10] libbpf: Add support for global pe=
rcpu data ---
commit ba7ffd0a036fafab1adafd7c20bbbb6455fe6cf6
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Add support for global percpu data

Add support for global percpu data in libbpf by adding a new ".percpu"
section, similar to ".data". It enables efficient handling of percpu
global variables in bpf programs.

>     When generating loader for lightweight skeleton, update the percpu_ar=
ray
>     map used for global percpu data using BPF_F_ALL_CPUS, in order to upd=
ate
>     values across all CPUs using one value slot.

[Severity: High]
Does this change break bpftool's lightweight skeleton generation for .percpu
maps?

Looking at tools/bpf/bpftool/gen.c:get_map_ident(), the hardcoded sfxs
array lacks the ".percpu" suffix:

    static const char *sfxs[] =3D { ".data", ".rodata", ".bss", ".kconfig" =
};

This causes the .percpu map to be silently skipped during skeleton
generation.

Since the BPF loader program is generated based on the true array index
(map_idx =3D map - obj->maps), skipping .percpu in the generated C struct
shifts all subsequent maps. Can this cause the loader program to read or wr=
ite
out of bounds of the skel->maps structure?

>    =20
>     Unlike global data, the mmaped data for global percpu data will be ma=
rked
>     as read-only after populating the percpu_array map. Thereafter, users=
 can
>     read those initialized percpu data after loading prog. If they want to
>     update the percpu data after loading prog, they have to update the
>     percpu_array map using key=3D0 instead.
>    =20
>     Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa825..e574870fb7169 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -1983,7 +2000,7 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
>  	}
> =20
>  	def =3D &map->def;
> -	def->type =3D BPF_MAP_TYPE_ARRAY;
> +	def->type =3D is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYPE_ARRA=
Y;
>  	def->key_size =3D sizeof(int);
>  	def->value_size =3D data_sz;

[Severity: High]
This is a pre-existing issue, but does this code cause a buffer
overflow if a malicious BPF ELF file contains a data section larger than 4G=
B?

The 64-bit size_t data_sz is truncated into the 32-bit unsigned int
def->value_size. The mmap allocation will use this undersized truncated
value, but the subsequent memcpy below uses the original 64-bit data_sz,
overflowing the undersized map->mmaped buffer:

    if (data)
        memcpy(map->mmaped, data, data_sz);

Can this lead to a massive out-of-bounds write in libbpf?

>  	def->max_entries =3D 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813152324.9793=
7-1-leon.hwang@linux.dev?part=3D5
