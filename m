Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D63382C7
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792256094; cv=none; b=ch4XzKEUZM0JUKIGwlOJTvbCl7Lk7cis6nd88C0TbGjK83XsBBRpjEOeMLawIayejwqV2WfYopsFC/HWRjfDFfO3uhg6/Zz+3IGyM+NMkcm07TDTeTtwES27cjPwF/272m7prJIVTug/gQfl+bmieTo7fDQpxbl791LyaRUV4qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792256094; c=relaxed/simple;
	bh=nUoFrRA5vvUXqA53sN8dWI2V58KkviNabTNKF/FOiuY=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=ueVLh+u2E5sWmEaAQA2etn0AhW/hZhwhH0NtJLLbveh1VRqOuuv21K67rqhKS4QC+CWymOjIhoKlilXs5VjOMji6KGBzHtmxawvAa3Xo4KgTLfCisRJo637iQB/VYmx/87xzDghAR6FTOTm6GRSI7lafvwC+wgfgfcP8mhskENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB3r0WnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB3r0WnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D1F1F000C5;
	Sat, 17 Oct 2026 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792256092;
	bh=Um8ND+NdqVxrmafmPHAsscNFW6sV+TBbyNSONMRYxhw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lB3r0WnE2Sp7NqjS3VYmGSLLECRexmv1pdTQK9ND/7MJpWG3hXTdB3Jwa1900vIYl
	 7WtpKroE5azFDfT3fqS+PXz614uVxjOCPoVk6REZrsFJWseT/7RyXcqQMQ3yiGkh1G
	 wHq5ZNV7pD9kgor08OTEISnsKn2oPRzxk8AYa7diozesZuRDTTHNzmPjfWTdATZKs+
	 6UQYI4YsQBbIvqA+RQqPhmEy0RuQQH9BOiZbfi9sBTLlxkxrdDSGsBcMXBs7wySyxc
	 jM3tJ1UZb3ZwMthuM7W05MlZCJWra82qnm6M+H3ZYZDVRvySXUhmPbyN8esFfa4yQK
	 hLvoG6mbbuoiA==
Message-ID: <sashiko-outbox-175659@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 18/43] bpf: Bound the nesting that the BTF
 show code follows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017163745.3341787-19-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
 <20261017163745.3341787-19-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 16:54:51 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: btf_show_obj_safe() clobbers -E2BIG from btf_show_start_agg=
r_type()
- [Medium] bpf: btf_show_start_array_type() leaks array_encoding on max dep=
th return
--

commit 759371ec51181daa62496793db6556044a061470
Author: Josef Bacik <josef@toxicpanda.com>

bpf: Bound the nesting that the BTF show code follows

This patch limits BTF struct and array pretty-printing recursion to 32
levels (BTF_SHOW_MAX_DEPTH) to prevent kernel stack overflow when showing
deeply nested BTF types, recording -E2BIG in show->state.status when the
limit is reached.

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
Can show->state.status =3D -E2BIG be overwritten by subsequent members befo=
re
btf_type_snprintf_show() or btf_type_seq_show_flags() returns it?

Returning NULL from btf_show_start_aggr_type() only causes the current
__btf_struct_show() or __btf_array_show() call at BTF_SHOW_MAX_DEPTH to ret=
urn
early. The enclosing __btf_struct_show() and __btf_array_show() loops at
shallower depths continue iterating over remaining members (and execute a
second pass when BTF_SHOW_ZERO is not set and a shallower member is non-zer=
o).

When BTF_SHOW_UNSAFE is not set (such as in bpf_snprintf_btf() and
bpf_seq_printf_btf()), visiting a subsequent member outside the current
32-byte show->obj.safe window calls btf_show_start_type() ->
btf_show_obj_safe():

kernel/bpf/btf.c:btf_show_obj_safe() {
	...
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
	...
}

When copy_from_kernel_nofault() succeeds on that later member, doesn't it
unconditionally reset show->state.status to 0, causing bpf_snprintf_btf() a=
nd
bpf_seq_printf_btf() to return success with truncated output instead of
-E2BIG?

[Severity: Medium]
Also, what happens to show->state.array_encoding when an array of 1-byte
integers hits BTF_SHOW_MAX_DEPTH?

In __btf_array_show(), btf_show_start_array_type() sets
show->state.array_encoding before calling btf_show_start_aggr_type():

kernel/bpf/btf.c:btf_show_start_array_type() {
	show->state.array_encoding =3D array_encoding;
	show->state.array_terminated =3D 0;
	return btf_show_start_aggr_type(show, t, type_id, data);
}

When btf_show_start_aggr_type() returns NULL at BTF_SHOW_MAX_DEPTH,
__btf_array_show() returns early without calling btf_show_end_array_type() =
to
reset show->state.array_encoding to 0:

kernel/bpf/btf.c:__btf_array_show() {
	...
	if (!btf_show_start_array_type(show, t, type_id, encoding, data))
		return;
	...
	btf_show_end_array_type(show);
}

If the skipped array had 1-byte integer elements (encoding =3D=3D BTF_INT_C=
HAR),
won't show->state.array_encoding remain BTF_INT_CHAR while enclosing structs
continue printing shallower members, causing btf_int_show() to format
subsequent non-array 8-bit integer fields as character literals and treat a=
ny
zero byte as a NUL terminator that sets show->state.array_terminated =3D 1 =
and
suppresses remaining 8-bit integer fields?

> +
> +	safe_data =3D btf_show_start_type(show, t, type_id, data);
>  	if (!safe_data)
>  		return safe_data;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017163745.3341=
787-1-alexei.starovoitov@gmail.com?part=3D18
