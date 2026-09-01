Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34448035A;
	Tue,  1 Sep 2026 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282907; cv=none; b=h7GWMAwdw9n+BasefH821kUBk8jvC4tyRt1z9+8yIEquP5BLKml6MqYYlFdh0sCAItsqiPNI/pdXXayR+EWlzuVRTFaUICcDTQwzlq2AUqyyKfbar/Kmy2Rtcd26INAfN7D3RlvUPWhDF6F8tf0Q3lgqSe6ClDsvzoqfBaWfJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282907; c=relaxed/simple;
	bh=0kcxhJq0I5UQgyZDxcDifoQPZbgSysRM4xlY5bBRrEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tzWesQHx/R/yPXBeuKK62Xbhv5zu1Bs4pBIcseCqRB9biQnc6mcQnvfdyQ7bBo6xiCtgOaYZy19SrrwLhPfzI/EeHmJAN5ICrbvjUq3M8oJ1yRdLMBIAvDwDJUB65wOqxWnUif2xnysAACz+SXobo2lBGaSYqg4gs9eAxHuGVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHxta8FL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHxta8FL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A73F1F000E9;
	Tue,  1 Sep 2026 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282905;
	bh=xbChA7V+Wmh+4R6tbIqi0nd6I79rn1+v4AfdqbEM3gY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QHxta8FLGyF49EzdNkifD8HIy0ZR5AsLGD+mXQmKNMgC3KpUZoTdWDOhuF8eKNr4q
	 0/hO3clYLeztF0g2Bw3qlebMLAD+AhkMTPbKgwjLJqDlDbqcb5dP0biGYvou8CoBqF
	 LLJjpp6cASRE4FxmJ1OvLdGZqg+Jmxq8nPxkQ+Nhlxmp7bdRhyWEM7QTsGqaojmIB6
	 KUJvzeS1DWABSH7MyOyaXBjUcsJThiN36dkx6Hei6icwZ5K3fInyCgg5+VHO4EubxR
	 Grl7grPkQvSmwhHh9SJoPRkOxhFtGWQJAb9goDOWlx4O2yozGWRFrWHbik8ldjlC67
	 AMytXY7LA/5DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 03/18] libbpf: Support moving permuted BTF
 types into split BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260901165757.801449-4-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:15:04 +0000
Message-Id: <20260901171505.2A73F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] If `btf_compact_strings()` fails, `btf__permute()` returns an erro=
r but leaves the BTF object in an irreversibly truncated and permuted state=
 without updating the caller's `id_map`.
- [Low] LIBBPF-001 API rule violation: `btf_add_local_str` incorrectly uses=
 `libbpf_err()` as an internal function, and `btf__add_str` fails to use it=
 on its error return.

Pre-existing issues:
- [High] `btf__permute` completely corrupts base BTF permutations due to in=
correct handling of `start_offs`, resulting in heap out-of-bounds accesses =
and total deletion of the VOID type.
--

commit 9de40ca1824ca5dbac1f65a763fe3a6beedba81f
Author: Alan Maguire <alan.maguire@oracle.com>

libbpf: Support moving permuted BTF types into split BTF
   =20
This commit extends btf__permute() with an optional transfer mode to move
specific permuted BTF types into a newly-created split BTF. It handles
remapping type IDs, migrating referenced strings, and compacting string
tables so that strings exclusive to the moved types reside only in the
split BTF.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9449f6f50f18f..30f8c426d1453 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2147,16 +2147,9 @@ int btf__find_str(struct btf *btf, const char *s)
>   *   - > 0 offset into string section, on success;
>   *   - < 0, on error.
>   */
> -int btf__add_str(struct btf *btf, const char *s)
> +static int btf_add_local_str(struct btf *btf, const char *s)
>  {
> -	int off;
> -	int err;
> -
> -	if (btf->base_btf) {
> -		off =3D btf__find_str(btf->base_btf, s);
> -		if (off !=3D -ENOENT)
> -			return off;
> -	}
> +	int off, err;
> =20
>  	err =3D btf_ensure_modifiable(btf);
>  	if (err)
> @@ -2167,10 +2160,24 @@ int btf__add_str(struct btf *btf, const char *s)
>  		return libbpf_err(off);
        ^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Does the internal static function btf_add_local_str() incorrectly use the
libbpf_err() wrapper here, while the public API btf__add_str() below fails
to wrap its own error return?

> =20
>  	btf->hdr.str_len =3D strset__data_size(btf->strs_set);
> +	btf->strs_deduped =3D false;
> =20
>  	return btf->start_str_off + off;
>  }
> =20
> +int btf__add_str(struct btf *btf, const char *s)
> +{
> +	int off;
> +
> +	if (btf->base_btf) {
> +		off =3D btf__find_str(btf->base_btf, s);
> +		if (off !=3D -ENOENT)
> +			return off;
> +	}
> +
> +	return btf_add_local_str(btf, s);
> +}

[ ... ]

> @@ -6678,33 +6759,82 @@ int btf__permute(struct btf *btf, __u32 *id_map, =
__u32 id_map_cnt,
>  	if (err)
>  		goto done;
> =20
> +	/*
> +	 * Build the inverse map: for each requested destination ID, record the
> +	 * original type ID that will occupy it. order_map is indexed by the
> +	 * destination ID relative to the first ID represented by id_map. The
> +	 * caller id_map maps old IDs to requested destinations, but BTF types
> +	 * must be emitted in destination-ID order; the inverse map supplies the
> +	 * old type to copy for each output slot without repeatedly searching
> +         * id_map.
> +         */
>  	for (i =3D start_offs; i < id_map_cnt; i++) {
> -		id =3D id_map[i];
> -		if (id < btf->start_id || id >=3D btf__type_cnt(btf)) {
> +		__u32 requested_id =3D new_id_map[i];
> +		__u32 order_idx;
> +
> +		if (btf_permute_id_is_transfer(requested_id)) {
> +			if (!transfer_btfp) {
> +				err =3D -EINVAL;
> +				goto done;
> +			}
> +			requested_id &=3D ~BTF_PERMUTE_ID_TRANSFER;
> +			nr_transfer++;
> +		}
> +		if (requested_id < btf->start_id || requested_id >=3D btf__type_cnt(bt=
f)) {
>  			err =3D -EINVAL;
>  			goto done;
>  		}
> -		id -=3D btf->start_id - start_offs;
> +		order_idx =3D requested_id - btf->start_id + start_offs;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does the order_idx calculation go out of
bounds for base BTFs?

For a base BTF, btf->start_id is 0 and start_offs is 1. If requested_id
reaches id_map_cnt - 1 (the maximum valid ID), order_idx will become
id_map_cnt.

This would cause an out-of-bounds access when writing to order_map[order_id=
x]
below, since order_map is allocated with size id_map_cnt.

>  		/* cannot be mapped to the same ID */
> -		if (order_map[id]) {
> +		if (order_map[order_idx]) {
>  			err =3D -EINVAL;
>  			goto done;
>  		}
> -		order_map[id] =3D i + btf->start_id - start_offs;
> +		order_map[order_idx] =3D i + btf->start_id - start_offs;
> +	}

[ ... ]

> @@ -6729,18 +6916,58 @@ int btf__permute(struct btf *btf, __u32 *id_map, =
__u32 id_map_cnt,
>  			goto done;
>  	}
> =20
> -	for (nt =3D new_types, i =3D 0; i < id_map_cnt - start_offs; i++) {
> +	/* Install the compacted parent types and rebuild their index. */
> +	for (nt =3D new_types, i =3D 0; i < nr_base_types; i++) {
>  		btf->type_offs[i] =3D nt - new_types;
>  		nt +=3D btf_type_size(btf, nt);
>  	}
> -
> -	free(order_map);
>  	free(btf->types_data);
>  	btf->types_data =3D new_types;
> +	committed =3D true;
> +	btf_hdr_update_type_len(btf, nt - new_types);
> +	btf->nr_types =3D nr_base_types;
> +
> +	/*
> +	 * An important goal is to also transfer strings to the transfer
> +	 * BTF where they do not have duplicates in BTF. This is important
> +	 * for cases like inline BTF where inline function names could
> +	 * comprise a significant portion of the string table. The approach
> +	 * is to first compact the set of strings in the base now transfer
> +	 * is complete; this will remove unreferenced strings. Then
> +	 * local references in the transfer BTF have to be moved downwards
> +	 * based upon that compaction. Finally also compact transfer BTF
> +	 * references so that we replace duplicate references in split with
> +	 * base references where present.
> +	 *
> +	 * Once all this is done, we end up with transfer-only strings in
> +	 * transfer split BTF and shared strings in BTF. The result is
> +	 * a transfer BTF with a lot of transfer-only strings will not
> +	 * pollute the string table of the non-transfer BTF.
> +	 */
> +	if (transfer_btf) {
> +		err =3D btf_compact_strings(btf, btf_ext);
> +		if (err)
> +			goto done;
                ^^^^^^^^^

[Severity: High]
If btf_compact_strings() fails here, we return an error but the
btf->types_data replacement has already been committed.=20

Does this leave the BTF object in an irreversibly corrupted state from the
caller's perspective, since id_map is not updated on the error path and the
transferred types are lost?

> +		err =3D btf_permute_rebase_split_strs(transfer_btf, old_str_off);
> +		if (err)
> +			goto done;
> +		err =3D btf_compact_strings(transfer_btf, NULL);
> +		if (err)
> +			goto done;
> +		*transfer_btfp =3D transfer_btf;
> +	}
> +
> +	/* On success return the final old-to-new type-ID map to the caller. */
> +	memcpy(id_map, new_id_map, id_map_cnt * sizeof(*id_map));
> +	free(new_id_map);
> +	free(order_map);
>  	return 0;
> =20
>  done:
> +	free(new_id_map);
>  	free(order_map);
> -	free(new_types);
> +	if (!committed)
> +		free(new_types);
> +	btf__free(transfer_btf);
>  	return libbpf_err(err);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D3
