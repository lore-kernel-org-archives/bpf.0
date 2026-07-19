Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07318A6DB
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784471670; cv=none; b=oWWCXUbkVJqe5i8sy6KVEh5HORKWtJsidG/Rc0QrZpr3AX+ub+oJOENijfHuxw6KacNAAULmXZG6umv4AMu28Mqk3bJz3Q07H16Q/1xTNf5HXrSoZI5x/RqKD5JvZxq/QO4hpOotGhi/8vkJ54GfS4fEexOdkO1G1P5v8cC48nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784471670; c=relaxed/simple;
	bh=DCCLBbYV5FYVNNriIRoeqs1BA1MrChAip2eCU1q76HA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ax7M0PqcvsqznL+TkBcEquozXlFAvBsl8jyzPrxCnhOUD70xEBRGJNS/+Isqf66s+Ry7hy5LeeICWjGahBVqIXQ1SfB4O4jIfnqFDGj+umQlxWx09zh85W0zLolaui9ZKJs29pXXRUOeN0+ZC5aSdcVYBQmskvPdNb7h6pKD3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYbRKpvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYbRKpvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA8D1F000E9;
	Sun, 19 Jul 2026 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784471669;
	bh=HPTyZBIlwF0cwh8F2enGUEzu4K+PC4tWaJQcgrc1evY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BYbRKpvkBqAC+oJStBtuRW87JAmRzoj6VCJXvMz9ElGh0GLQ0mTVAhENxzKcyj9Kl
	 VE4qhaEg0zO5yDFUprq1iq5QAHWEEH4irzer8q47LO5TDyhSaIUkq/g8zWGAJOO5Ve
	 Fb7sKVyr/0C48dOoyqxS6X4rE6R0D49jnUhaREKpbltgC5gSa5pRNT//iwc5R0WB9X
	 Jo9aWU2WVu8lPpG1jjgsoQ/LwaKzY/bB5/kPHTrWeW38EM5QICi2+T0zJ169D5I/h+
	 jm7aeKNis6uZUe+y4MW5Orphgd672WL3zaCUmAXwv5z8BzTwsQ5upZlJmCkEhfJzk2
	 VVhfJi0l+CpRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Preserve unique-field state across
 nested structs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719142401.2420111-2-memxor@gmail.com>
References: <20260719142401.2420111-1-memxor@gmail.com>
 <20260719142401.2420111-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 14:34:28 +0000
Message-Id: <20260719143429.1BA8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BPF_REFCOUNT is incorrectly marked as non-unique, allowing users t=
o trigger a WARN_ON_ONCE via duplicate fields.
- [High] Typo in BPF_RES_SPIN_LOCK parsing checks the wrong offset, allowin=
g users to trigger a WARN_ON_ONCE.
--

--- Patch [1]: [PATCH bpf-next v1 1/2] bpf: Preserve unique-field state acr=
oss nested structs ---
commit cc8eb6296aa42dface6bb303fbfdec9c1e0e7566
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Preserve unique-field state across nested structs

This commit addresses an issue where btf_find_struct_field() initialized a
fresh seen mask for every recursive descent. By sharing the seen_mask point=
er
across the traversal, it properly detects duplicate unique fields to prevent
an invariant warning during map creation.

> btf_find_struct_field() initializes a fresh seen mask for every recursive
> descent. Unique special fields in different levels of the same aggregate
> therefore do not see one another. The duplicate fields can reach
> btf_parse_fields(), where they trigger an invariant WARN_ON_ONCE(). A
> crafted user BTF can consequently trigger the warning before map creation
> checks capabilities.

[Severity: High]
This isn't a bug introduced by this patch, but looking at
btf_get_field_type() in kernel/bpf/btf.c, BPF_REFCOUNT is defined as
non-unique (is_unique =3D false).

If a user creates a BPF map using a BTF struct containing two bpf_refcount
fields, they bypass the uniqueness check. When btf_parse_fields() processes
them, the second field triggers the invariant check:

kernel/bpf/btf.c:btf_parse_fields() {
    ...
    case BPF_REFCOUNT:
        WARN_ON_ONCE(rec->refcount_off >=3D 0);
    ...
}

Can a crafted user BTF still trigger this WARN_ON_ONCE() using duplicate
refcount fields?


[Severity: High]
This is a pre-existing issue, but looking at the BPF_RES_SPIN_LOCK case in
btf_parse_fields(), it appears to check the wrong offset:

kernel/bpf/btf.c:btf_parse_fields() {
    ...
    case BPF_RES_SPIN_LOCK:
        WARN_ON_ONCE(rec->spin_lock_off >=3D 0);
        /* Cache offset for faster lookup at runtime */
        rec->res_spin_lock_off =3D rec->fields[i].offset;
        break;
    ...
}

If a user provides a BTF struct containing both a bpf_spin_lock and
a bpf_res_spin_lock, wouldn't this trigger the WARN_ON_ONCE() before
reaching the intended graceful rejection?

kernel/bpf/btf.c:btf_parse_fields() {
    ...
    if (rec->spin_lock_off >=3D 0 && rec->res_spin_lock_off >=3D 0) {
        ret =3D -EINVAL;
        goto end;
    }
    ...
}

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index cbb1e49b9bcbf..8d628552ef99e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3751,7 +3751,7 @@ static int btf_repeat_fields(struct btf_field_info =
*info, int info_cnt,
>  static int btf_find_struct_field(const struct btf *btf,
>  				 const struct btf_type *t, u32 field_mask,
>  				 struct btf_field_info *info, int info_cnt,
> -				 u32 level);
> +				 u32 level, u32 *seen_mask);
> =20
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719142401.2420=
111-1-memxor@gmail.com?part=3D1
