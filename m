Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5644D6B2
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114887; cv=none; b=uIPxG6knR6JO12UHCPGBolDt8M6q/LkKNj+XCZRKhyRpsE+G1csdozlig9YnH97NKzYh4axdeZqdycLNMNMyupChylrzFlhZOW8avIvy7jXCvawPtfjQNVPo69WqlVRq3qhIoHZeWs2p6vm77t240IzZDzY4w6xb3TSpvmLK3KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114887; c=relaxed/simple;
	bh=6tB6IANqEqGBGSpNROvV6S9uPrOOtGEYjKrPGyw9aTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YtLlOsOfXZx/MmV5wJqfy26Ka+EhhZGKwqBjoSRdE4Ja8me7hUmRZS5rDn+vm0zzT9l4ZFKb2dIxHvjTUj/WPcoQLP6avwHAaJ4z97Nlrwj0GYa2forwzlL/mvhQy4ZH5MCXznYlrH+0lbWohFRg+PFjd+8yMFYgMJMVZGFiCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMthaEya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMthaEya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF16C2BCB7;
	Mon, 18 May 2026 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779114886;
	bh=6tB6IANqEqGBGSpNROvV6S9uPrOOtGEYjKrPGyw9aTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oMthaEya/yDinbawVcvbeSpFxbkK1az3idOjTTIna8DzhD4bybzNBsnKhg1pEde3q
	 mcJbyp0CkCxSFVi2/L0KgpdZQfL+6HqxBEhUd7Sjho/JFv/y0TtI9Wh9HD7t9DpTU+
	 CNUM93P9NQGEHOHqUZx0joFDyEdu1rM7OlpO35iBr6xuxZLCaEEu6PoZ48VAgWwK/C
	 ZXgiT4NvlG75573M5N/alSaub38IdG6Qb+Q1CqLgDmRmsrwd+B0JXHFX9zlY8DLrmM
	 lb0YjgmOpP9Q02CNEkDF+5CQK8br1nvVphIe5N86PMVP6tZyo9tGYuYBLT6IHZ3dIT
	 U3vGDqUFUKLtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] tracing/probes: Allow use of BTF names to
 dereference pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518095832.52659a3a@gandalf.local.home>
References: <20260518095832.52659a3a@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 14:34:46 +0000
Message-Id: <20260518143446.BBF16C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Parser ambiguity breaks valid BTF structure names and user-space d=
ereference syntax.
- [Medium] Root BTF lookup strictly requires BTF_KIND_STRUCT, rejecting uni=
ons and typedefs.
- [Medium] Anonymous structure depth limit prematurely aborts searches acro=
ss sibling members.
- [Medium] Anonymous structures with modifiers are silently skipped during =
member lookup.
- [Low] Non-BTF fallback stub returns an incorrect error code, leading to m=
isleading parser errors.
- [Low] Empty member or structure names incorrectly match anonymous structu=
res.
--

commit c2537a8a71eb55f21c0a67db37298aaf425c7fc7
Author: Steven Rostedt <rostedt@goodmis.org>

tracing/probes: Allow use of BTF names to dereference pointers

This commit adds syntax to FETCHARGS parsing to allow the use of BTF
structure and member names to calculate pointer dereference offsets,
avoiding the need to manually compute raw numeric offsets.

> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c
[ ... ]
> +static int find_member(const char *ptr, struct btf *btf,
> +		       const struct btf_type **type, int level)
> +{
> +	const struct btf_member *member;
> +	const struct btf_type *t =3D *type;
> +	int i;
> +
> +	/* Max of 3 depth of anonymous structures */
> +	if (level > 3)
> +		return -E2BIG;
> +
> +	for_each_member(i, t, member) {
> +		const char *tname =3D btf_name_by_offset(btf, member->name_off);
> +
> +		if (strcmp(ptr, tname) =3D=3D 0) {

Does this code accidentally match anonymous structures when given malformed
inputs? If arg contains consecutive dots like +.member, ptr will be an
empty string. Because anonymous structures have an empty name, strcmp would
return 0 and falsely match.

> +			int offset =3D __btf_member_bit_offset(t, member);
> +			*type =3D btf_type_skip_modifiers(btf, member->type, NULL);
> +			return BITS_ROUNDDOWN_BYTES(offset);
> +		}
> +
> +		/* Handle anonymous structures */
> +		if (strlen(tname))
> +			continue;
> +
> +		*type =3D btf_type_by_id(btf, member->type);
> +		if (btf_type_is_struct(*type)) {

Could this skip anonymous structures or unions declared with modifiers?
If an anonymous structure is declared with const or volatile,
btf_type_is_struct() evaluates to false since the kind is a modifier.
Should it use btf_type_skip_modifiers() here before checking if it is a
struct?

> +			int offset =3D find_member(ptr, btf, type, level + 1);
> +
> +			if (offset < 0) {
> +				if (offset =3D=3D -ENOENT)
> +					continue;
> +				return offset;

Does this prematurely abort searches across valid sibling members?
If a nested anonymous structure exceeds the depth limit, find_member()
returns -E2BIG. Since -E2BIG is not -ENOENT, this returns immediately,
preventing the loop from checking any subsequent named members in the parent
structure.

> +			}
> +
> +			return offset + BITS_ROUNDDOWN_BYTES(member->offset);
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
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

Does restricting the root lookup to BTF_KIND_STRUCT prevent users from
querying offsets on unions or typedefs? A user might want to start a query
with a union like +bpf_attr.member or a typedef to a struct like
+spinlock_t.rlock.

> +	if (id < 0)
> +		goto error;
[ ... ]
> diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
> --- a/kernel/trace/trace_btf.h
> +++ b/kernel/trace/trace_btf.h
[ ... ]
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> +/* Will modify arg, but will put it back before returning. */
> +int btf_find_offset(char *arg, long *offset);
> +#else
> +static inline int btf_find_offset(char *arg, long *offset)
> +{
> +	return -EINVAL;

Would returning -ENODEV instead of -EINVAL here result in a more
accurate error message? parse_probe_arg() maps -EINVAL to
TP_ERR_BAD_STRUCT_FMT ("Unknown BTF structure"), while -ENODEV maps to
TP_ERR_NOSUP_BTFARG ("BTF is not available or not supported").

> +}
> +#endif
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
[ ... ]
> @@ -1165,7 +1165,7 @@ parse_probe_arg(char *arg, const struct fetch_type =
*type,
> =20
>  	case '+':	/* deref memory */
>  	case '-':
> -		if (arg[1] =3D=3D 'u') {
> +		if (arg[1] =3D=3D 'u' && isdigit(arg[2])) {

Can this inadvertently intercept valid BTF structure names? If a BTF type is
named like u32_struct or u8_data (e.g., +u32_struct.member(...)),
arg[1] is 'u' and arg[2] is a digit. This causes the parser to treat it
as a user-space dereference, stripping the +u and failing in kstrtol().

Also, does this break legacy user-space offsets like +u-10(...)? In that
case, arg[2] is - rather than a digit, causing it to fall through to the
BTF parsing path where it fails with TP_ERR_BAD_STRUCT_FMT.

>  			deref =3D FETCH_OP_UDEREF;
>  			arg[1] =3D arg[0];
>  			arg++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518095832.5265=
9a3a@gandalf.local.home?part=3D1
