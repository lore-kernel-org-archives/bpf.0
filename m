Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F983396D36
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643173; cv=none; b=k1ViQrCwHClqRxPl67BmvVaE8N6e2dEKE7+Gc78jPZqhP1Ah95X+73ThWmtH8atjlyEElWvPyREn48PqEHaxj2HT6jocDdnGOxhrjm2u+JTNQp47wBvkW1leW/dg04D0EcmhdEbQuJc6rMwR6PNNe+SqTWxT8gYsVeHmRzrbzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643173; c=relaxed/simple;
	bh=bupdxKorZHn84KFMPLSWqvLoM6Hnr7C+x0m9FWEtJeA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XzOvyCc5j96LN+ZzmLUMwYpsNBue993AdJj6Mlqw7x4LgI3wvVZjwwC9w0gWRCwyEb1JzXjp1IFm/l2c16DlrV66pgnCNy+LnEb6BbytFo2maBc6nbVjcJp5f2Xt5WJNFbDI05hhzKpFNGG0tK1Tp4gr3duAe+RYQYl+geiXVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDFngjT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDFngjT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0EB1F00893;
	Tue, 29 Sep 2026 00:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790643170;
	bh=v8xwM1+KBGAf2JFN761cYFZVkkWAhR/Z+b/r7O1boqM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IDFngjT8uyiLalxsqDlA5OIZ754TRsKsAecNK5GVxCrUD9LKs9VZ5Q+vhNlUkVwYp
	 Noo5SfxKfveV5UTMplfBFs8W9wTbLuuYQBsv7M8sX+dtgLL+j7KyllBAVCSdhERZGa
	 Z9831Yw8U5XmLOURpMZYQdJR7Pl6rJSqasn/eX3Cc6sfB2rqI2z83pB8mEp71iMYJX
	 fu4dBt+8gVEa2YZM6HHLJQLZPRmdtEi4/vO4oAfknbiFwy403yT26GB2Dl0ITuNx6w
	 8auIiL9Wrw9RED1Kl07MJx/DiPhaw2A7FuKbSDejgoxLKu0aYf3Ex8u+22x6sezClu
	 r+2Do/+/oJX5w==
Content-Type: multipart/mixed; boundary="===============3096520016120494582=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d9813f2fa7409b21b9688959b70d04f46ceb1da43f0ded88a921acaee62df4e3@mail.kernel.org>
In-Reply-To: <20260929001746.3256138-1-yonghong.song@linux.dev>
References: <20260929001746.3256138-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v7 20/22] selftests/bpf: Add __set_global() and __ret_global() test tags
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 00:52:50 +0000 (UTC)

--===============3096520016120494582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index f3dbc3b59bff..9afa163fac5a 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -93,6 +93,11 @@
>   * __failure         Expect program load failure in privileged mode.
>   * __failure_unpriv  Expect program load failure in unprivileged mode.
>   *
> + * __set_global      Set a global variable of the program to a value before
> + *                   executing it.
> + * __ret_global      Execute the program and check that a global variable
> + *                   holds the given value afterwards. The variable has to
> + *                   live in .bss or .data and be four or eight bytes wide.
>   * __retval          Execute the program using BPF_PROG_TEST_RUN command,
>   *                   expect return value to match passed parameter:
>   *                   - a decimal number

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 25eeb1c1248b..2492841f7a49 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c

[ ... ]

> +static int find_global_var(struct bpf_object *obj, const char *name,
> +			   struct bpf_map **map, __u32 *off, __u32 *sz,
> +			   bool *is_signed)
> +{
> +	static const char * const secs[] = { ".bss", ".data" };
> +	struct btf *btf = bpf_object__btf(obj);
> +	int i, s;
> +	__u32 vsz;
> +
> +	if (!btf) {
> +		PRINT_FAIL("no BTF for object\n");
> +		return -ENOENT;
> +	}
> +
> +	for (s = 0; s < ARRAY_SIZE(secs); s++) {
> +		const struct btf_type *sec, *vt;
> +		const struct btf_var_secinfo *vsi;
> +		struct bpf_map *m = NULL, *iter;
> +		size_t slen = strlen(secs[s]);
> +		int id;
> +
> +		bpf_object__for_each_map(iter, obj) {
> +			const char *mname = bpf_map__name(iter);
> +			size_t len = mname ? strlen(mname) : 0;
> +
> +			if (len >= slen && strcmp(mname + len - slen, secs[s]) == 0) {
> +				m = iter;
> +				break;
> +			}
> +		}

This isn't a bug, but could the map loop here be replaced with
bpf_object__find_map_by_name(obj, secs[s]), as veristat's
set_global_vars() does? That would tie the map to the DATASEC by its
section name and make the comment about the two lookups not agreeing on a
size unnecessary.

> +		id = btf__find_by_name_kind(btf, secs[s], BTF_KIND_DATASEC);
> +		if (!m || id < 0)
> +			continue;
> +
> +		sec = btf__type_by_id(btf, id);
> +		vsi = btf_var_secinfos(sec);
> +		for (i = 0; i < btf_vlen(sec); i++, vsi++) {
> +			const struct btf_type *var = btf__type_by_id(btf, vsi->type);
> +
> +			if (strcmp(btf__name_by_offset(btf, var->name_off), name))
> +				continue;
> +			if (vsi->size != 4 && vsi->size != 8) {
> +				PRINT_FAIL("'%s' is %u bytes, only 4 and 8 are supported\n",
> +					   name, vsi->size);
> +				return -EINVAL;
> +			}
> +			vt = btf__type_by_id(btf, btf__resolve_type(btf, var->type));
> +			if (!vt || !(btf_is_int(vt) || btf_is_any_enum(vt))) {
> +				PRINT_FAIL("'%s' is not an int or an enum\n", name);
> +				return -EINVAL;
> +			}
> +			*is_signed = global_var_is_signed(vt);
> +			/*
> +			 * The map is found by the suffix of its name and the
> +			 * section by its own, so nothing so far has made the
> +			 * two agree on a size.
> +			 */
> +			vsz = bpf_map__value_size(m);
> +			if (vsi->offset > vsz || vsi->size > vsz - vsi->offset) {
> +				PRINT_FAIL("'%s' at %u+%u is outside '%s' of %u bytes\n",
> +					   name, vsi->offset, vsi->size,
> +					   bpf_map__name(m), vsz);
> +				return -EINVAL;
> +			}
> +			*map = m;
> +			*off = vsi->offset;
> +			*sz = vsi->size;
> +			return 0;
> +		}
> +	}
> +
> +	PRINT_FAIL("no global variable '%s'\n", name);
> +	return -ENOENT;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904
--===============3096520016120494582==--
