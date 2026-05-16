Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB12236F7
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778968714; cv=none; b=bu1JG4RZ6vfRQ419iWzUKyMAUJ5WYToPREXnflGezF0xjaD1rqWTcb0UDwUSuMl0yB8GU/GvnF0QoNNMb4RXKtRGoPYLJHECMcxkWjD7vP4ca4d8KFTUjB+rPVbXaP0U14ug6lYjSJ0FfC0JsjC71xtXTOBGj7cNDA+NMOtzRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778968714; c=relaxed/simple;
	bh=FPKl45cmtznKWi/BUdYbaSgXI471CZiWF/DoDmjb6H0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h3R2u//Qw6B+8+2PclUJoW+3toWvx6lGpdaV0yvxHQZrfceJgJdUcRW1AyASHEdS7bzwkTHB6rpgNK/noqrPwJ2Z6iBWHFt54LRZGJBqkHVvrcNq6wDRljK7e98St9tEpcouPV0Rzb5LNVsiwezBfaOpZqY5WE9TCUVev4lhQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAKdEZhG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAKdEZhG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49107C19425;
	Sat, 16 May 2026 21:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778968714;
	bh=FPKl45cmtznKWi/BUdYbaSgXI471CZiWF/DoDmjb6H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FAKdEZhGrHu91IPEC0Se/O9ldT3hZ/3mI9WZ/0s+2vGu8SJwXfK2tkDSaRUuWW+NN
	 6AXBbk1ut59l9cVHXBnGwfgomSPUwIblBrAJk9hOjvUPsP8qK7K33MP5dWNoHSAY42
	 UrgSACV11mIaqMm96TqruAaKtqfxa60iveI7HCh/WJF0b9Ir2UvhUuQmwVS82pbuZL
	 n4hGtOpoqxLHxJTiCaauoY0+ThtgTYgf8pnEs/gwDOcTQS+X+y3emzIYcu9wrMnYce
	 RsG4bgDJci4+kacXgxRSAc1SL2qZF73rFsBHy8ZiYl0rKt2MR2l2RJeSiG762shmiw
	 pfMV31e0HV/WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing/probes: Allow use of BTF names to
 dereference pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260516173310.1dbad146@fedora>
References: <20260516173310.1dbad146@fedora>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 21:58:33 +0000
Message-Id: <20260516215834.49107C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Uninitialized variable `btf` in `btf_find_offset()` causes a kerne=
l crash/panic on error paths.
- [Medium] Nested structure resolution fails if members use BTF modifiers (=
const, volatile) or typedefs.
- [Medium] The updated user-space dereference parser misidentifies valid BT=
F struct accesses and breaks negative user-space offsets.
- [Low] Missing error mapping for `-ENOENT` suppresses trace log errors whe=
n a struct member is not found.
- [Low] The `-E2BIG` error for excessively deep anonymous structures is sil=
ently dropped, creating dead code in the error handler.
--

commit 59c817c69d1d406c3cfa1e1e3659ff16a7e33c9d
Author: Steven Rostedt <rostedt@goodmis.org>
Subject: tracing/probes: Allow use of BTF names to dereference pointers

This patch adds syntax to the FETCHARGS parsing of probes to allow the use
of structure and member names to get the offsets to dereference pointers,
using BTF.

> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> index 00172f301f25a..be88cc4d97dd3 100644
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c

[ ... ]

> +static int find_member(const char *ptr, struct btf *btf,
> +		       const struct btf_type **type, int level)
> +{

[ ... ]

> +		/* Handle anonymous structures */
> +		if (strlen(tname))
> +			continue;
> +
> +		*type =3D btf_type_by_id(btf, member->type);
> +		if (btf_type_is_struct(*type)) {
> +			int offset =3D find_member(ptr, btf, type, level + 1);
> +
> +			if (offset < 0)
> +				continue;

If find_member() returns -E2BIG due to deep anonymous structure nesting,
this check appears to swallow the error and just skip to the next member.
Does this prevent -E2BIG from ever reaching the caller and make the
TP_ERR_MEMBER_TOO_DEEP error handling dead code?

> +
> +			return offset + BITS_ROUNDDOWN_BYTES(member->offset);
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/**
> + * btf_find_offset - Find an offset of a member for a structure

[ ... ]

> +int btf_find_offset(char *arg, long *offset_p)
> +{
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	long offset =3D 0;
> +	char *ptr;
> +	int ret;
> +	s32 id;
> +
> +	ptr =3D strchr(arg, '.');
> +	if (!ptr)
> +		return -EINVAL;
> +
> +	*ptr =3D '\0';
> +
> +	ret =3D -ENXIO;
> +	id =3D bpf_find_btf_id(arg, BTF_KIND_STRUCT, &btf);
> +	if (id < 0)
> +		goto error;

If bpf_find_btf_id() fails here, it returns an error code and does not
initialize the btf pointer.

Does this cause btf_put(btf) to dereference an uninitialized stack pointer
in the error path below, potentially leading to a panic?

> +
> +	/* Get BTF_KIND_FUNC type */
> +	t =3D btf_type_by_id(btf, id);
> +
> +	/* May allow more than one member, as long as they are structures */
> +	do {
> +		ret =3D -ENXIO;
> +		if (!t || !btf_type_is_struct(t))
> +			goto error;

If a structure member is a typedef or has a modifier (like const), the
updated type from find_member() will be BTF_KIND_TYPEDEF or BTF_KIND_CONST.

Will btf_type_is_struct() then fail on the next iteration of this loop?
Should btf_type_skip_modifiers() be used to resolve the underlying structure
type first?

[ ... ]

> +error:
> +	btf_put(btf);
> +	if (ptr)
> +		*ptr =3D '.';
> +	return ret;
> +}

[ ... ]

> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index e0d3a0da26af5..6fcede2de1a55 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1165,7 +1165,7 @@ parse_probe_arg(char *arg, const struct fetch_type =
*type,
> =20
>  	case '+':	/* deref memory */
>  	case '-':
> -		if (arg[1] =3D=3D 'u') {
> +		if (arg[1] =3D=3D 'u' && isdigit(arg[2])) {

Does this new condition misidentify valid BTF structure lookups that happen
to start with 'u' followed by a digit, such as +u16_port.id($arg)?

Also, does it break previously valid negative user-space offsets like
+u-10($arg) since arg[2] would be a hyphen instead of a digit?

>  			deref =3D FETCH_OP_UDEREF;
>  			arg[1] =3D arg[0];
>  			arg++;
> @@ -1178,7 +1178,22 @@ parse_probe_arg(char *arg, const struct fetch_type=
 *type,
>  			return -EINVAL;
>  		}
>  		*tmp =3D '\0';
> -		ret =3D kstrtol(arg, 0, &offset);
> +		if (arg[0] !=3D '-' && !isdigit(*arg)) {
> +			int err =3D 0;
> +			ret =3D btf_find_offset(arg, &offset);
> +			switch (ret) {
> +			case -ENODEV: err =3D TP_ERR_NOSUP_BTFARG; break;
> +			case -E2BIG: err =3D TP_ERR_MEMBER_TOO_DEEP; break;
> +			case -EINVAL: err =3D TP_ERR_BAD_STRUCT_FMT; break;
> +			case -ENXIO: err =3D TP_ERR_BAD_BTF_TID; break;
> +			}

If find_member() cannot find the specified member, it returns -ENOENT.
Since -ENOENT is missing from this switch statement, err remains 0 and
__trace_probe_log_err() is skipped.

Should there be a mapping for -ENOENT (perhaps to TP_ERR_NO_BTF_FIELD) so
users get a specific error log when they misspell a field name?

> +			if (err)
> +				__trace_probe_log_err(ctx->offset, err);
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			ret =3D kstrtol(arg, 0, &offset);
> +		}
>  		if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516173310.1dba=
d146@fedora?part=3D1
