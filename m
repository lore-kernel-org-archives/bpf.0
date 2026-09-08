Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3FF550DB1
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889139; cv=none; b=rT1AzM0y7GddZLtOwYPbTLtBpP0aW/GwdpN0cASCNWfjjapRSsk7++TRJPJQBV8EVgfvHp7vR+dDza+kargHZ5jJ13EU1fpl+/JZGzo2niqXAxOcWFQNgsgp6TlQGRvGlCIwYP5jX3YgWqe0Yi5fRylw4RX9h7j2CVs9kjRaO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889139; c=relaxed/simple;
	bh=lMMyumfMwLB/nK2rjqn1siFo+iqE8nueCE65OtEQPsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FqImzJp+iIF+1I3YQ0cx1muznstCkduz6OqNZ4847lDhcjJPZzvsrYwl5E20QCpYnNH55rAbXGREGWPqQCFuqUUTL8I+56cnfRQkt+oGxu5x9snJxZ7PwB+RXMTFrvbsN13jarwTTAQcxkY1RezJSYev4HPowHWFUHVP55OBx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQfHHyRs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQfHHyRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0621F00A3A;
	Tue,  8 Sep 2026 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889138;
	bh=Q0bvxk5qMt/AyyzxAgh2+9EiBthGeBkvP/wJ8+6af+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQfHHyRsAA8l9CbH7lQcEXFevuqKR2IGJXx0II3ib2imn77ad6ndtV1HvQ3whnRVb
	 q61aNao2g6pZZEQ6nFaxVmvqBgvqQ+F7c70SSb44QsnvPHmGXtumWtoQX0uyvPfpW5
	 JFlZkvjQ55I9dhc2MNw4CaSLeNI47ikWicVxIu1LoqfmXAIVq3VK0RK/zrKgxow36a
	 EwN8EYfnfwg8cHPAsJnlByELTlCCEwY5m8udLN9T9bmTDQUaAdxz2pv6eZ3Ao0C3HE
	 K6TNiC8LEdMctVagErcBq+CJxUbgC6++tPfBkfzJjEtZT3TC1gbZEOUSpR7GYH84+7
	 Z4jUgGo0t3h0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] libbpf: defer arena map size check to load
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260908-libbpf_arena_thing-v1-1-0092c0e0d91b@meta.com>
References: <20260908-libbpf_arena_thing-v1-1-0092c0e0d91b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:38:57 +0000
Message-Id: <20260908173857.DE0621F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL pointer dereference in init_arena_map_data() when processing =
a SHT_NOBITS .arena section.
--

commit 839c80f912fa6d6c52eb18408dfd0437488f602b
Author: Mykyta Yatsenko <yatsenko@meta.com>

libbpf: defer arena map size check to load time

init_arena_map_data() used the build-host page size while it opened an
object. This could reject skeleton generation when the build host and
target use different page sizes.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c036e8a91ed88..413b8b305194e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -3107,8 +3095,7 @@ static int bpf_object__init_user_btf_maps(struct bp=
f_object *obj, bool strict,
>  		obj->arena_map_idx =3D i;
> =20
>  		if (obj->efile.arena_data) {
> -			err =3D init_arena_map_data(obj, map, ARENA_SEC, obj->efile.arena_dat=
a_shndx,
> -						  obj->efile.arena_data->d_buf,
> +			err =3D init_arena_map_data(obj, map, obj->efile.arena_data->d_buf,
>  						  obj->efile.arena_data->d_size);

[Severity: High]
This isn't a bug introduced by this patch, but can we pass a NULL pointer to
init_arena_map_data() here?

If the ELF section is of type SHT_NOBITS with a non-zero size, elf_getdata()
can return an Elf_Data structure where d_buf is NULL but d_size is non-zero.

In that case, bpf_object__init_user_btf_maps() passes a NULL data pointer
to init_arena_map_data(), which then executes:

tools/lib/bpf/libbpf.c:init_arena_map_data() {
    ...
	memcpy(obj->arena_data, data, data_sz);
    ...
}

leading to a NULL pointer dereference. Could we validate that d_buf is not
NULL before calling memcpy, or handle SHT_NOBITS sections differently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-libbpf_are=
na_thing-v1-1-0092c0e0d91b@meta.com?part=3D1
