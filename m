Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C56486653;
	Tue,  1 Sep 2026 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282688; cv=none; b=KYv7D1EDxZExfvN9HdZZu3IgqYgt24H0vUVDPryI6Ax1dmI3MXyOVDIojvP8SQXqgh1Ksc4jOxfcW66IjGM+VsFcjkxnoWIU9aiU/thu1mzsK65/uCkAsxaYMsnUWQjeMTknxS8X3p83k3BBA2J4cHGbYySwqVvnf7eIaUZ9wI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282688; c=relaxed/simple;
	bh=8Zc08fhtBLvkIYa5mn5xYtoL3Lfikqu3b8IR/DfLVbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BQEe07kp+h6MTifouAJQyYH5fWf/NixOWRlCkYeFy4SiP/E8WIvEeETYRKXqiB85RQ2DZqXoHXggmwacn5ZSdaKGomw0V7D9T1JN+Bp4ArK18Pm29xivjXydlqULMD4AFOCnXZxutg9eI6i+lk61KVd7EI7LVTFLzfyvZvbGJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep4NL6bY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep4NL6bY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF09C1F000E9;
	Tue,  1 Sep 2026 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282687;
	bh=nSqy871XLtgqYqKt8AHhGDmohqHQZbFjRgbkpQueAJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ep4NL6bYlPbN29Vd26LO//omT/HHWIHAuvrJHDRjqZpHp/l5g9yDnReiiGMenXyc4
	 5V4FniwB5tc8qevHo1IafHecZ7B1psLHpqGPz+Gslj3Kd7QHIxWSk4EZNa0LJxPY8u
	 TgArH9VYazv9XUBjfuCaDG9ADUttDMw732P941u+kknNL+TwI2cjwodFjfEL473cGL
	 o5BHgPQzzcpZNa67xFCIIR7CPDLkYXl/IGTh7GFaigCx1Pq8OQxFfgoagfQaoBPD7l
	 8VUykVbPA0M/NzGUPbTyeTfrW0vVAp4Py2ygzm+SEGQ66Rn8PHdm2beSfhMTmoaYYk
	 GqOEhIR0FZDGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 02/18] libbpf: Add support for BTF kinds
 LOC[_PARAM|_PROTO|SEC]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: linux-modules@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260901165757.801449-3-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:11:26 +0000
Message-Id: <20260901171126.DF09C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] btf_equal_loc_param() fails to compare the flags field of BTF_KIND=
_LOC_PARAM, leading to incorrect deduplication.
- [Medium] Public libbpf API functions (e.g., btf__add_locsec, btf__add_loc=
_param, btf__add_loc_proto) return negative error codes directly without us=
ing the required libbpf_err() wrapper.
- [Low] The m_offs array in struct btf_field_desc is mistakenly inflated to=
 size 22 instead of 2, unnecessarily wasting stack memory.
--

commit ce9959576588b24d58d6a9f71651d919ddebad03
Author: Alan Maguire <alan.maguire@oracle.com>
Subject: libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]

This patch adds support for new BTF kinds to libbpf, including deduplication
logic, data accessors, and construction APIs. It also extends the BTF field
iterator to handle the new section types.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index c783359977b46..9449f6f50f18f 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
[ ... ]
> +int btf__add_loc_param(struct btf *btf, __u32 size, __u32 flags)
> +{
[ ... ]
> +	p =3D btf_loc_param(t);
> +	p->flags =3D flags;
> +
> +	return btf_commit_type(btf, sz);

[Severity: Medium]
Since btf__add_loc_param() is a public libbpf API, should its error return
paths be wrapped with libbpf_err() to ensure errno is set properly for
userspace callers? Here, btf_commit_type() can return a negative error code
directly.

> +}
[ ... ]
> +int btf__add_loc_proto(struct btf *btf)
> +{
[ ... ]
> +	t->info =3D btf_type_info(BTF_KIND_LOC_PROTO, 0, 0);
> +	t->size =3D 0;
> +
> +	return btf_commit_type(btf, sizeof(struct btf_type));

[Severity: Medium]
Does this unwrapped negative return code also apply to btf__add_loc_proto()?

> +}
[ ... ]
> +int btf__add_locsec(struct btf *btf, const char *name)
> +{
[ ... ]
> +	if (!str_is_empty(name)) {
> +		name_off =3D btf__add_str(btf, name);
> +		if (name_off < 0)
> +			return name_off;

[Severity: Medium]
Could this leak a negative error code without setting errno? The name_off
result can be negative on failure, and btf__add_locsec is a public API.

> +	}
> +	t->name_off =3D name_off;
> +	t->info =3D btf_type_info(BTF_KIND_LOCSEC, 0, 0);
> +	t->size =3D 0;
> +
> +	return btf_commit_type(btf, sizeof(struct btf_type));

[Severity: Medium]
Similarly, should the return value of btf_commit_type() be wrapped here?

> +}
[ ... ]
> +static bool btf_equal_loc_param(struct btf_type *t1, struct btf_type *t2)
> +{
> +	struct btf_loc_param *p1 =3D btf_loc_param(t1);
> +	struct btf_loc_param *p2 =3D btf_loc_param(t2);
> +	__u32 *v1 =3D (__u32 *)(p1 + 1);
> +	__u32 *v2 =3D (__u32 *)(p2 + 1);
> +	int i, vlen =3D btf_vlen(t1);
> +
> +	if (!btf_equal_common(t1, t2))
> +		return false;
> +	for (i =3D 0; i < vlen; i++, v1++, v2++) {
> +		if (*v1 !=3D *v2)
> +			return false;
> +	}
> +	return true;

[Severity: High]
Does this loop need to compare the flags field of the two btf_loc_param
structures? The current logic checks the trailing parameters but appears
to skip checking if p1->flags equals p2->flags, which might cause
LOC_PARAM types with different metadata to be incorrectly deduplicated.

> +}
[ ... ]
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index cb4d962338441..ebac8db1ccfda 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -580,7 +580,7 @@ struct btf_field_desc {
>  	/* member struct size, or zero, if no members */
>  	int m_sz;
>  	/* repeated per-member offsets */
> -	int m_off_cnt, m_offs[1];
> +	int m_off_cnt, m_offs[22];

[Severity: Low]
Is m_offs sized to 22 here because BTF_KIND_LOCSEC equals 22?=20
Since the iter_init function only specifies 2 offsets for LOCSEC (func and
loc_proto), could this array be sized to the maximum offset count needed=20
(e.g., 2) to avoid unnecessary stack memory consumption when=20
struct btf_field_desc is instantiated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D2
