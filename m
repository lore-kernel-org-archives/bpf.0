Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5941D5AC2;
	Tue,  1 Sep 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788286490; cv=none; b=DFnhzfxXCzOxp8Fpoomm/jydd5bYzlYNFFongn1BFn+jAQgITjyDChW7zzPVUo3Ttyp+ih6dxYxSRhdbai8qkcIqCsq7jjsKr7+amgipqt0rMFW6B7IYXk/MbdLTeUVSFDjnq4ZX2x1vpPC9d/0+BeWiIm3Jj7VdeI/TBklVEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788286490; c=relaxed/simple;
	bh=Q74fB3VP015f3XiZ5T08A7hxIUGZpJNs0FI3LHR2+Qw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s/Z4A5fvKJBXWYZ1rD6W+Zapn59opPit3O55dJ9FWgVy3dOS9j4Zg+6BayEpeZb4rWxiqczcAY3HX2fjJZxWA/uTBUt0oSpkZwJRsdopR1tWlS0LObcb3f3Vxj3Pgt3rVkH1pYQyTXZBzlfv8c6q3wDS6lOKg+UV7Tu/lZakmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br+7cjr0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br+7cjr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D746D1F000E9;
	Tue,  1 Sep 2026 18:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788286489;
	bh=85diNgB1gjiA7HzQx1oMNsSRACXwQ1XQDvGbX5zvKLE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=br+7cjr0B2OFjdHaCWu7v3l/e5UWE2dOdkKjvDPs849Ve4H+W+HPKS9kYa2bRy8sN
	 IR86RXalttvte6CJ64T/8XHSzkMKMb8Ac8gv5mB47agdbksyXA1W5zmE3DeE6l1N+q
	 W81IKMDBySaeonePHyjYl9qikgUuPqTF+LAsOh8yNeyuZ0oXzVFQbXsQdtgeu0R6Mu
	 GY7IL0gPqhqPYF0kcKHBMAgy1JhF8UFDg4S7rvVopvZptBoQWW93NMfe7HYBjvlj2E
	 7aQpXSKXFgfwU/jaRSKLo69NF3Gs0akzEX8yOJxYllbaBhl8/f5ZOubHJOGe2Q1Nrq
	 eI2zQYKLMQSCw==
Content-Type: multipart/mixed; boundary="===============5834501064021467908=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <797b06b4ecde0e90165b2164c65560decf5869c6b9b6f0d4b6376cb49726459b@mail.kernel.org>
In-Reply-To: <20260901165757.801449-4-alan.maguire@oracle.com>
References: <20260901165757.801449-4-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 03/18] libbpf: Support moving permuted BTF types into split BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,bpf@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 18:14:47 +0000 (UTC)

--===============5834501064021467908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9449f6f50f18..30f8c426d145 100644
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
> -		off = btf__find_str(btf->base_btf, s);
> -		if (off != -ENOENT)
> -			return off;
> -	}
> +	int off, err;
>
>  	err = btf_ensure_modifiable(btf);
>  	if (err)
> @@ -2167,10 +2160,24 @@ int btf__add_str(struct btf *btf, const char *s)
>  		return libbpf_err(off);
>
>  	btf->hdr.str_len = strset__data_size(btf->strs_set);
> +	btf->strs_deduped = false;

The refactoring left the API doc comment attached to the new static
helper btf_add_local_str(), so the public btf__add_str() (btf.c:2168) now
has no documentation at all, and its declaration at tools/lib/bpf/btf.h:202
is bare without doxygen. The comment is also no longer descriptive of what
it now documents: the distinguishing property of btf_add_local_str() versus
btf__add_str() is that it always adds to this BTF's own string section and
never reuses a string already present in base_btf, which is exactly what
makes the new transfer mode able to keep split-only strings out of the base.

Should the comment be moved back onto btf__add_str() and btf_add_local_str()
given a one-liner about bypassing the base string table?

The new btf->strs_deduped = false sits in btf_add_local_str(), which is on
the path of every public btf__add_str() call (and therefore of btf__add_int,
btf__add_var, btf__add_field, btf__add_enum_value, btf__add_func_param,
btf__add_datasec, btf__add_locsec, btf_add_composite, btf_add_decl_tag,
btf_add_ref_kind, btf_add_enum_common, and more), not just the new transfer
path.

Before this commit nothing in tools/lib/bpf ever cleared strs_deduped. The
complete set of writers post-commit is: btf_ensure_modifiable() sets it true
when hdr.str_len == 0 or when !base_btf && str_len == 1, end of
btf_dedup_strings() sets it true, plus the two new clears here and in
btf_compact_strings().

For BTF built from scratch, btf__new_empty() (str_len == 1) and
btf__new_empty_split() (str_len == 0) both make btf_ensure_modifiable() set
strs_deduped = true, so pre-commit btf_dedup_strings() returned 0 at its
early-return check and the string table was never rebuilt. Post-commit the
first added string clears the flag, so btf__dedup() now always rebuilds the
string table for such BTF: strings are reordered and unreferenced strings
are dropped. Any offset a caller previously obtained from the public
btf__add_str() and stashed outside a BTF type's name field is therefore
silently invalidated across btf__dedup().

This is not needed by the commit: both btf_compact_strings() call sites
already force btf->strs_deduped = false themselves at btf.c:4536, so the
transfer path does not depend on btf_add_local_str() clearing it.

All in-tree consumers were checked and are safe: bpf_linker's
finalize_btf() (tools/lib/bpf/linker.c:2860) runs finalize_btf_ext() first
and then passes opts.btf_ext = linker->btf_ext to btf__dedup(), so the
offsets produced at linker.c:1968, 2697, 2703, 2740 and 2952 all get
remapped; bpftool merge_btf_files() (tools/bpf/bpftool/btf.c:880) and
resolve_btfids finalize_btf() (tools/bpf/resolve_btfids/main.c:1578) hold no
external string offsets. So there is no in-tree breakage, but this is an
unadvertised behaviour change to a public API plus a full string-table
rebuild on every static link, and the commit message does not mention
btf__add_str() or strs_deduped at all.

Is the clearing of strs_deduped here intentional for non-transfer use of
btf__add_str(), or should it only be cleared in btf_compact_strings() where
the transfer path already sets it?

>
>  	return btf->start_str_off + off;
>  }
>
> +int btf__add_str(struct btf *btf, const char *s)
> +{
> +	int off;
> +
> +	if (btf->base_btf) {
> +		off = btf__find_str(btf->base_btf, s);
> +		if (off != -ENOENT)
> +			return off;
> +	}
> +
> +	return btf_add_local_str(btf, s);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33537080133
--===============5834501064021467908==--
