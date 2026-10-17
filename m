Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A921CC59
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201583; cv=none; b=i51md7+R+TJkVaWkcSDifFpX99kjin+wa4lG69yEQzTSBfaRdmlKalyOxwmyZ0MeAytFbBNZzQeiu9yTMaR/ta8cuZwQQHETIbsvK8pxm8F6Mo61ziZLGU43f6qrZBb4gjo9h35lZEoZsP63IOQ6F+xXMIGCNlrke8jNOyimC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201583; c=relaxed/simple;
	bh=5mw0W9xSbBEnPSp/SBS0BTDsY/EDweQGdXja+14bj2A=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=ktePHahtBY+IGvfgen0K9Df12XYTyBtGx0u+Uli3B8HW+wnX9sVNlDHU5W0YBftmV6Px81D1CL6jo0IisSPR/pkioCF4Bh+5euI2Tj9l3Mzpj8sMVGfrSQT6hmbHt6T/Hsh3jS+ZRLZVLyu24gQrFU14eKZhF3+ZsRjcDxJSJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTCedraD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTCedraD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A401F000C4;
	Sat, 17 Oct 2026 01:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201581;
	bh=G+IFjucRTQnqCEo8AiQrM6yJfqjeCAz0TGbRuuMiFug=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DTCedraD9IcTa1ddRqSkcS4OnhdKgv4vSEJ8IX5wwNEtRGcTxNqMOS/vq7hHlzQ0G
	 KWYF08J1ggm3hroO6c31RQ6aX3Y5Q279SAnCWwcKeRNEG1650t4j4VGxE+Ru3QlJNz
	 VwnkhpXnp87Os5Sq4WA9sOtjX9GAU/csGg0qTAKCdTpPeJMu8c0+6XusXuMyHDnScf
	 BvYwPPOIBBoFoiQgycxfg/teK9mpt4Ruv4yYEYw+9gR65VUk9A/JVRxZki+Wot5YWE
	 w38dzF3YtL1iHslF8XunRqRCHEbhbyipqqIU7h11xLc0uzPolLrA0Fy+usGCHXJO68
	 lyrTMD+44APbw==
Message-ID: <sashiko-outbox-175149@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 17/38] bpf: Bound the nesting that the BTF show
 code follows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017012451.364800-9-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
 <20261017012451.364800-9-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 01:46:21 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: btf_show_obj_safe() clobbers -E2BIG set by btf_show_start_a=
ggr_type()
- [Medium] bpf: btf_show_start_array_type() leaks array_encoding on max dep=
th error
--

commit f2e2b108df464bcad9ef6d63627fcf113f33d61f
Author: Josef Bacik <josef@toxicpanda.com>

bpf: Bound the nesting that the BTF show code follows

This commit limits the recursion depth in btf_show_start_aggr_type() to
BTF_SHOW_MAX_DEPTH (32) and sets show->state.status to -E2BIG to prevent
kernel stack overflows when pretty-printing deeply nested BTF structs and
arrays.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64c78434fa050..a9bf4c3c0a273 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1081,6 +1081,8 @@ static const struct btf_type *btf_type_skip_qualifi=
ers(const struct btf *btf,
>  }
> =20
>  #define BTF_SHOW_MAX_ITER	10
> +/* nested structs and arrays shown; __btf_show_indent() has as many colu=
mns */
> +#define BTF_SHOW_MAX_DEPTH	32
> =20
>  #define BTF_KIND_BIT(kind)	(1ULL << kind)
> =20
> @@ -1474,8 +1476,18 @@ static void *btf_show_start_aggr_type(struct btf_s=
how *show,
>  				      const struct btf_type *t,
>  				      u32 type_id, void *data)
>  {
> -	void *safe_data =3D btf_show_start_type(show, t, type_id, data);
> +	void *safe_data;
> =20
> +	/*
> +	 * Structs and arrays are shown by recursion.  BTF loading bounds the
> +	 * depth of one resolve walk, not how deep resolved types may nest.
> +	 */
> +	if (show->state.depth >=3D BTF_SHOW_MAX_DEPTH) {
> +		show->state.status =3D -E2BIG;
> +		return NULL;
> +	}

[Severity: Medium]
Can show->state.status =3D -E2BIG get overwritten by a subsequent call to
btf_show_obj_safe()?

Returning NULL from btf_show_start_aggr_type() stops the current aggregate =
at
depth 32, but enclosing callers in __btf_struct_show() and __btf_array_show=
()
continue iterating over their remaining members or elements (as well as run=
ning
the second display pass after the depth_check pass in btf_struct_show() and
btf_array_show() when BTF_SHOW_ZERO is not set).

When bpf_snprintf_btf() or bpf_seq_printf_btf() runs, BTF_SHOW_UNSAFE is not
set. If any subsequent member or pass calls
btf_show_start_type()->btf_show_obj_safe() for data outside the current 32-=
byte
show->obj.safe window, btf_show_obj_safe() unconditionally overwrites
show->state.status:

kernel/bpf/btf.c:btf_show_obj_safe() {
	if (!safe) {
		size_left =3D btf_show_obj_size_left(show, data);
		if (size_left > BTF_SHOW_OBJ_SAFE_SIZE)
			size_left =3D BTF_SHOW_OBJ_SAFE_SIZE;
		show->state.status =3D copy_from_kernel_nofault(show->obj.safe,
							      data, size_left);
		if (!show->state.status) {
			show->obj.data =3D data;
			safe =3D show->obj.safe;
		}
	}
}

When copy_from_kernel_nofault() succeeds, show->state.status is reset to 0,=
 so
btf_type_snprintf_show() and btf_type_seq_show_flags() will return success
instead of -E2BIG.

[Severity: Medium]
Also, when btf_show_start_aggr_type() returns NULL at BTF_SHOW_MAX_DEPTH, d=
oes
btf_show_start_array_type() leave show->state.array_encoding set?

In __btf_array_show(), a 1-byte integer array sets encoding =3D BTF_INT_CHA=
R and
calls btf_show_start_array_type(), which sets show->state.array_encoding be=
fore
calling btf_show_start_aggr_type():

kernel/bpf/btf.c:btf_show_start_array_type() {
	show->state.array_encoding =3D array_encoding;
	show->state.array_terminated =3D 0;
	return btf_show_start_aggr_type(show, t, type_id, data);
}

When btf_show_start_aggr_type() returns NULL, __btf_array_show() returns ea=
rly
without calling btf_show_end_array_type() to clear show->state.array_encodi=
ng:

kernel/bpf/btf.c:__btf_array_show() {
	if (!btf_show_start_array_type(show, t, type_id, encoding, data))
		return;
}

When recursion unwinds to enclosing structs, any subsequent scalar 8-bit
integer member visited by btf_int_show() will see
show->state.array_encoding =3D=3D BTF_INT_CHAR, causing printable bytes to =
be
formatted as character literals and a zero byte to set
show->state.array_terminated =3D 1, suppressing subsequent 8-bit integer fi=
elds:

kernel/bpf/btf.c:btf_int_show() {
	case 8:
		if (show->state.array_encoding =3D=3D BTF_INT_CHAR) {
			/* check for null terminator */
			if (show->state.array_terminated)
				break;
			if (*(char *)data =3D=3D '\0') {
				show->state.array_terminated =3D 1;
				break;
			}
}

> +
> +	safe_data =3D btf_show_start_type(show, t, type_id, data);
>  	if (!safe_data)
>  		return safe_data;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017012058.3557=
87-1-alexei.starovoitov@gmail.com?part=3D17
