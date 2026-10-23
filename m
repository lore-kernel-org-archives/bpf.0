Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737970;
	b=OEbMa0Tcu3zMJvm1BNeyAz6j6r4md9Uce2OKB0eD2c6G7gTmeUL+r2tTCwwAdl/RsvNc
	 IFTSja8UyNJS5N7/4PXlJRpQR8gIQ161EU8iHZFYALVtxkWgJV/G9+ch/SSGYKJ540VxG
	 DdhpDDz5xI6OATz8pPDw7YMQ9g+tSb7+8EbWOIK2qi/fGrxWTUErmwEFm7IFbcJQj1uo4
	 gZ2pji8nwfKcCx7X5yLgBdEJ7E4nMy88knem94DchVbrv2zCMVezdG1hkmO9KOL0O/Tc5
	 c4z+wtB4g6tVNR8g8fNHWbOszUSUoziTlSwXEFEr/2CYOrGhV7bQqq3aUioopKZmY+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737970;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j6/6uTawOgJeBwn+MQ7klMygO913tJ57a3jTPJFBRZ8=;
	b=j/TKVM5SXTxn1q+/Fffn+XjMbddRFmj7JxXB9fF7IXRfkRm/sEV2miQt8DX7XG40yZdF
	 7rv5sjHAooVI/xGummJPhkYbvo8ugRAhVNutNPtY4Dm7k0R4vghHdT5zuSPkC2jOby1HN
	 uhTLfJdJTgzciY7algEICI8zR7q3qT1Ce0X3wBqLxVGcBtxyAO//sG2ogMONRBKDDFJQt
	 XBJabWpxCezz/Z1BAuwNiSfeT1wNCYD9qMZbpytLVjH21Z1IPd1eKEw9t9tcKyeht5F9y
	 yS8EYELxB0WUXzsAO2QzESp8+/yKZxKqfNMaUM6G+Ac44VNsATEcVnXuZ+97mDcNQ7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdsdcG5Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78751606A31D
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdsdcG5Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD621F01825;
	Fri, 23 Oct 2026 06:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792737969;
	bh=j6/6uTawOgJeBwn+MQ7klMygO913tJ57a3jTPJFBRZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdsdcG5YFfdebH2Njp9ZZrbDCjyTPve+tWiSSNIoFLqqaiUqBm593T4Fgl8WlQV0e
	 tIXv5A8fwuzvXWSWk4NzF8fFnA/eKHxdf0+sc8fuJADY4MSh/yRZqdL10/nMNEjFaP
	 EPwBN1+NcN6hkUP1N4Vn/RNTTNRx+eIWTTV9fdtqF/nwctD2TMUa5ZKx/zm/mO73Yi
	 +J8r3fv55zEHFScpg+V6v40DN6UOvsGfhKbauAm59GTCYSdpZJr/h21ToOYIplORZN
	 SHMcKLTfvWSWlcwiQzG3TnjsgnKulB15BbdTFAjXzDk4H3xOZeEsmBsfxcek37Nat4
	 90JOuQAuehBYA==
Message-ID: <sashiko-outbox-182361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Fix out-of-bounds btf->types write for
 split BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Yang" <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261023063133.563998-1-yangfeng59949@163.com>
References: <20261023063133.563998-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 06:46:07 +0000
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
- [High] bpf: unchecked btf_add_type() return value in btf_check_all_metas()
--

commit 4ac38a4f66ed4b8171a028c6c026eb14f1efb57a
Author: Feng Yang <yangfeng@kylinos.cn>

bpf: Fix out-of-bounds btf->types write for split BTF

This commit bounds the btf->types array growth in btf_add_type() by
subtracting btf->start_id from the maximum type limit and replacing the
equality check with a greater-than-or-equal check to prevent out-of-bounds
writes when parsing split BTF.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 538129ed24188..7949704712791 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1752,15 +1752,17 @@ static int btf_add_type(struct btf_verifier_env *=
env, struct btf_type *t)
>  		/* Expand 'types' array */
> =20
>  		struct btf_type **new_types;
> -		u32 expand_by, new_size;
> +		u32 expand_by, new_size, max_size;
> =20
> -		if (btf->start_id + btf->types_size =3D=3D BTF_MAX_TYPE) {
> +		if (btf->start_id >=3D BTF_MAX_TYPE ||
> +		    btf->start_id + btf->types_size >=3D BTF_MAX_TYPE) {
>  			btf_verifier_log(env, "Exceeded max num of types");
>  			return -E2BIG;
>  		}

[Severity: High]
Does returning -E2BIG (or -ENOMEM when kvzalloc_objs() fails) in
btf_add_type() actually stop BTF verification when its sole caller,
btf_check_all_metas(), ignores the return value?

In kernel/bpf/btf.c:btf_check_all_metas():

	while (cur < end) {
		struct btf_type *t =3D cur;
		s32 meta_size;

		meta_size =3D btf_check_meta(env, t, end - cur);
		if (meta_size < 0)
			return meta_size;

		btf_add_type(env, t);
		cur +=3D meta_size;
		env->log_type_id++;
	}

	return 0;

When btf_add_type() returns an error here, it returns before appending the
type to btf->types[btf->nr_types++], but btf_check_all_metas() continues
looping over the remaining types and returns 0.

In the btf_parse() path, btf_check_all_types() only iterates up to
btf->nr_types, so if no earlier type references the dropped tail types,
verification succeeds with a silently truncated btf->types array.

In the btf_parse_base() and btf_parse_split() paths, btf_check_all_types() =
is
not called at all:

kernel/bpf/btf.c:btf_parse_split() {
	...
	err =3D btf_check_all_metas(env);
	if (err)
		goto errout;

	err =3D btf_check_modifier_chain_length(env, btf, btf_nr_types(base_btf));
	if (err)
		goto errout;

	return btf;
}

If a split BTF exceeds the limit and an earlier split BTF type references a
dropped type ID at the boundary (which still passes the metadata check in
btf_check_meta()), btf_parse_module() -> btf_parse_split() succeeds with a
truncated btf->types array. Subsequent relocation in btf_relocate() ->
btf_mark_embedded_composite_type_ids() in tools/lib/bpf/btf_relocate.c then
looks up that dropped ID:

	while (next_id) {
		t =3D btf_type_by_id(r->btf, next_id);
		switch (btf_kind(t)) {

Because next_id is >=3D btf->start_id + btf->nr_types, btf_type_by_id() ret=
urns
null and btf_kind(t) dereferences it, while btf_relocate_rewrite_type_id() =
can
also read past the end of r->id_map[].

Similarly, if kvzalloc_objs() fails in btf_add_type(), btf_check_all_metas()
can return 0 with btf->types left null or with types shifted after a transi=
ent
allocation failure.

Should btf_check_all_metas() check and propagate the error returned by
btf_add_type()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023063133.5639=
98-1-yangfeng59949@163.com?part=3D1
