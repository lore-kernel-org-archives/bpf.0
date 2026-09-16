Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543E4A0F10
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549420; cv=none; b=dX/qtMN1k/dUjOLF0vlvjgvx7T7cZMAEi3N0deU//pqDoJg+ck1uSdjKB8cL+elNaWOLTIH4R2TreI8TmX6lsYiY3DlhhDv5wVtX9o/cHznLvPZikKntguwaS+fe67/lnScs/Qw07L6rDzuENxEMYiwffsRENh5B4EmRLJwLVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549420; c=relaxed/simple;
	bh=LwBZD7QQ3jwX+WMVcC+BMQ8FWX62dV9145yX4Uoenmk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=P9kJlGe/+J8FT+WQbBNz5iocFBM6l3WSl94UUABOqnCy+B07UvGEk1mwZz+snmC1tf1OVTSlGH+F5x3YhmH8Utq6CvGUZZAhv8OJOYF6yNPuII5ZLrIRHl5cY/ATdPX8+1LoQawlzJ8YV/MRy8wgl5BytFDbF25kCkCXfLcyxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGW0O4Wt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGW0O4Wt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433431F0089A;
	Wed, 16 Sep 2026 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549406;
	bh=DAPChJgjXfsVkg9O68xcl5zdUZH8QJIj8koa05VeAcU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mGW0O4WtGJ3633nKCBAcimvEGIXOxjMvX+8qL7uMWPsQZG+N1p9hH4DhzCyY6B77R
	 umdE14BNeiIp/LtnRVLEUiCniuMbD0XQbcIIgLe4dH6yzRZfrmi469uk8ycBC5gvbp
	 vgtjLbNp41QiimII1ftXx8ldW26l4BfJYUcyp7yo3BqVyzwT8aklVSmT7+K6yVEXhT
	 LF4ZvyhtEH7cU47nCtWWF95zGmJxuZC2UtznbO84vHqnjhrKEguuf5v188nvodonA+
	 oLbE2euI0tfB7rahTxxjwA8pbBjwzBED0iW9FCyEC4zryq8rbVCabKTi5Ck1l3N1TA
	 r6i0cqlvVvtNQ==
Content-Type: multipart/mixed; boundary="===============6359189533444094136=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e81968f62d0231178e551de838a0674d8ceeaa7e9a2dbc64c24e03ec88ea92c2@mail.kernel.org>
In-Reply-To: <20260916074118.1007116-3-alan.maguire@oracle.com>
References: <20260916074118.1007116-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 02/11] libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,jolsa@kernel.org
Cc: daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 09:03:25 +0000 (UTC)

--===============6359189533444094136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 908bd344229d5..332a8388fcc41 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -3344,6 +3400,208 @@ int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
>  	return btf_add_decl_tag(btf, value, ref_type_id, component_idx, 1);
>  }
>
> +/*
> + * Append new BTF_KIND_LOC_PARAM with specified size and flags.  Values are
> + * added via btf__add_loc_param_value().
> + *
> + * Returns:
> + *   -  >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_loc_param(struct btf *btf, __u32 size, __u32 flags)
> +{
> +	struct btf_loc_param *p;
> +	struct btf_type *t;
> +	int sz, err;
> +
> +	err = btf_ensure_modifiable(btf);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	sz = sizeof(struct btf_type) + sizeof(*p);
> +	t = btf_add_type_mem(btf, sz);
> +	if (!t)
> +		return libbpf_err(-ENOMEM);
> +
> +	t->name_off = 0;
> +	t->info = btf_type_info(BTF_KIND_LOC_PARAM, 0, 0);
> +	t->size = size;
> +
> +	p = btf_loc_param(t);
> +	p->flags = flags;
> +
> +	return btf_commit_type(btf, sz);
> +}

Does this API validate the size and flags arguments?

The kernel's btf_loc_param_check_meta() in kernel/bpf/btf.c requires size to
be a power of 2, between 1 and 16:

kernel/bpf/btf.c:btf_loc_param_check_meta() {
    size = t->size;
    if (size > 16 || !is_power_of_2(size)) {
            btf_verifier_log_type(env, t, "Unexpected size");
            return -EINVAL;
    }

The equivalent API btf__add_int() validates these constraints up front:

tools/lib/bpf/btf.c:btf__add_int() {
    /* byte_sz must be power of 2 */
    if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
            return libbpf_err(-EINVAL);
    if (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL))
            return libbpf_err(-EINVAL);

Without validation, btf__add_loc_param(btf, 0, ...) or
btf__add_loc_param(btf, 24, ...) succeed but only fail later at BTF_LOAD time.

Similarly, flags is unchecked against the enum btf_loc_param_flags mask
(0x3f). Undefined high bits would collide with future flag definitions.

> +
> +int btf__add_loc_param_value(struct btf *btf, __u32 value)
> +{
> +	struct btf_type *t;
> +	int sz, err;
> +	__u32 *v;
> +
> +	/* last type should be BTF_KIND_LOC_PARAM */
> +	if (btf->nr_types == 0)
> +		return libbpf_err(-EINVAL);
> +	t = btf_last_type(btf);
> +	if (!btf_is_loc_param(t))
> +		return libbpf_err(-EINVAL);
> +
> +	/* decompose and invalidate raw data */
> +	err = btf_ensure_modifiable(btf);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	sz = sizeof(value);
> +	v = btf_add_type_mem(btf, sz);
> +	if (!v)
> +		return libbpf_err(-ENOMEM);
> +	*v = value;
> +
> +	/* update parent type's vlen */
> +	t = btf_last_type(btf);
> +	err = btf_type_inc_vlen(t);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
> +	return 0;
> +}
> +
> +/*
> + * Append new BTF_KIND_LOC_PROTO
> + *
> + * The prototype is then populated with 0 or more BTF_KIND_LOC_PARAMs via
> + * btf__add_loc_proto_param(); similar to how btf__add_func_param() adds
> + * parameters to a FUNC_PROTO.
> + *
> + * Returns:
> + *   -  >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_loc_proto(struct btf *btf)
> +{
> +	struct btf_type *t;
> +	int err;
> +
> +	err = btf_ensure_modifiable(btf);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	t = btf_add_type_mem(btf, sizeof(struct btf_type));
> +	if (!t)
> +		return libbpf_err(-ENOMEM);
> +
> +	t->name_off = 0;
> +	t->info = btf_type_info(BTF_KIND_LOC_PROTO, 0, 0);
> +	t->size = 0;
> +
> +	return btf_commit_type(btf, sizeof(struct btf_type));
> +}
> +
> +int btf__add_loc_proto_param(struct btf *btf, __u32 id)
> +{
> +	struct btf_type *t;
> +	int sz, err;
> +	__u32 *p;
> +
> +	if (validate_type_id(id))
> +		return libbpf_err(-EINVAL);
> +
> +	/* last type should be BTF_KIND_LOC_PROTO */
> +	if (btf->nr_types == 0)
> +		return libbpf_err(-EINVAL);
> +	t = btf_last_type(btf);
> +	if (!btf_is_loc_proto(t))
> +		return libbpf_err(-EINVAL);
> +
> +	/* decompose and invalidate raw data */
> +	err = btf_ensure_modifiable(btf);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	sz = sizeof(__u32);
> +	p = btf_add_type_mem(btf, sz);
> +	if (!p)
> +		return libbpf_err(-ENOMEM);
> +	*p = id;
> +
> +	/* update parent type's vlen */
> +	t = btf_last_type(btf);
> +	err = btf_type_inc_vlen(t);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
> +	return 0;
> +}
> +
> +int btf__add_locsec(struct btf *btf, const char *name)
> +{
> +	struct btf_type *t;
> +	int name_off = 0;
> +	int err;
> +
> +	err = btf_ensure_modifiable(btf);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	t = btf_add_type_mem(btf, sizeof(struct btf_type));
> +	if (!t)
> +		return libbpf_err(-ENOMEM);
> +
> +	if (!str_is_empty(name)) {
> +		name_off = btf__add_str(btf, name);
> +		if (name_off < 0)
> +			return libbpf_err(name_off);
> +	}
> +	t->name_off = name_off;
> +	t->info = btf_type_info(BTF_KIND_LOCSEC, 0, 0);
> +	t->size = 0;
> +
> +	return btf_commit_type(btf, sizeof(struct btf_type));
> +}

Can btf__add_locsec() succeed with a NULL or empty name?

The kernel unconditionally rejects a LOCSEC with name_off == 0:

kernel/bpf/btf.c:btf_locsec_check_meta() {
    if (!t->name_off ||
        !btf_name_valid_section(env->btf, t->name_off)) {
            btf_verifier_log_type(env, t, "Invalid name");
            return -EINVAL;
    }

btf__add_locsec(btf, NULL) succeeds and returns a valid type ID, but the BTF
blob becomes unloadable with BTF_LOAD -EINVAL only later when the caller
tries to load it.

The analogous API btf__add_datasec() validates this up front:

tools/lib/bpf/btf.c:btf__add_datasec() {
    /* non-empty name */
    if (str_is_empty(name))
            return libbpf_err(-EINVAL);
    name_off = btf__add_str(btf, name);

LOCSEC is validated by the same kernel helper, btf_name_valid_section(), and
there is no kind of LOCSEC the kernel will accept without a name.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35072175008
--===============6359189533444094136==--
