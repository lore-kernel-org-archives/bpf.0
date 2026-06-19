Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5882E22BD
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781865488; cv=none; b=V8P0wmjjAzmK75lKOjxZCcrPe0Ixo12bgzftqaF78eqstteq36pePjmphMPLm5kq1mJ70TBgeyxC/tU9xlkzILWxdGTUCo3v08tENv0/mf06+bHNPnNEx3NorH3HG0+J6HN+mj/nTXqbYZpk1Q8HEXjVYXTnoRXvxKRwd1Wlve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781865488; c=relaxed/simple;
	bh=crvHhhF0qMo9FIyOgfb8sWDrthIR7el8SpYIquUS0Oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sp05mwSge11IKiTlW+nMliAlYeCu2kRAT3A54FZiq4KiWUiZAWVbcJX1Tn/lkgZClE5I/ur+UCFhUxzDd4Tyib8nZhpe3V3arfx95byEcJxwmjCQbKOten0d3aK9ATF/6yEPjEJzlGlze3z7WZuOchEe3jwoyCRzDBbWsdRJVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUeWrs4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUeWrs4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07041F000E9;
	Fri, 19 Jun 2026 10:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781865486;
	bh=nSyE6pl6JtkwJi/+7fRUTCFmYcroMloifwyhXxGaOeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nUeWrs4On7pYjxO/oq/Am6BJcH7QHBf20EiYxiVXRZjNeLpwHPAmma6LBn88AQ3oq
	 uGmEU0FR85EQbTf8iEYU+/rVWBb9onzPjr/pNMx5iWtBM2HDmHd4igAIcB/OXE51my
	 O+XgE6hrozqgDkHINSofOr+hr00eiUJzoRTlduMHKT/Y/4oePd56K/5pAR24R9Fha1
	 SURitncmfHNGKQP6KhaLsLGj605gTpGhZQhphHga7441jK2ucs9ibgjylGzyxu5QxL
	 K+0NJK3U0uCpjA6F0K9fSUhfLVzZCXBpLjzevVektfDXKblgF/5yNg0CSIQZiKP/Tb
	 dcQKWFoh0ZpEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] resolve_btfids: preserve parameter names when
 processing implicit args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aelin Reidel" <aelin@mainlining.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619-resolve-btfids-implicit-args-use-after-free-v1-1-2af87d4704c8@mainlining.org>
References: <20260619-resolve-btfids-implicit-args-use-after-free-v1-1-2af87d4704c8@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 10:38:05 +0000
Message-Id: <20260619103805.E07041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: Unpatched stale pointer vulnerability for tag_name=
 in btf__add_decl_attr and btf__add_decl_tag.
- [Medium] The patch leaves a use-after-free vulnerability in the error log=
ging path for param_name.
--

commit 77f893ea076418154cdd4dbd0ddf4fed9a32b30b
Author: Aelin Reidel <aelin@mainlining.org>

resolve_btfids: preserve parameter names when processing implicit args

process_kfunc_with_implicit_args() obtains parameter names through
btf__name_by_offset(), which returns pointers to memory owned by the BTF
object. Because btf__add_func_param() modifies the same BTF and may grow its
internal storage, these pointers can become invalid. This commit duplicates
the parameter name before calling btf__add_func_param() to prevent a stale
pointer dereference.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index f8a91fa7584f4..970b810bb779b 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -1113,6 +1113,7 @@ static int process_kfunc_with_implicit_args(struct =
btf2btf_context *ctx, struct
>  {
>  	s32 idx, new_proto_id, new_func_id, proto_id;
>  	const char *param_name, *tag_name;

[Severity: High]
This is a pre-existing issue, but doesn't tag_name have the exact same stale
pointer vulnerability that this patch fixes for param_name?

Looking earlier in process_kfunc_with_implicit_args(), tag_name is retrieved
and passed directly to BTF-modifying functions:

    tag_name =3D btf__name_by_offset(btf, t->name_off);
    ...
    if (btf_kflag(t))
        err =3D btf__add_decl_attr(btf, tag_name, new_func_id, idx);
    else
        err =3D btf__add_decl_tag(btf, tag_name, new_func_id, idx);

Since tag_name is passed without duplication, if those functions trigger a
reallocation of the BTF internal string table, could string processing insi=
de
them dereference freed memory and crash? Does it need a similar duplication
fix to ensure the pointer remains valid?

> +	char *tmp_param_name;
>  	const struct btf_param *params;
>  	enum btf_func_linkage linkage;
>  	char tmp_name[KSYM_NAME_LEN];

[ ... ]

> @@ -1193,7 +1194,11 @@ static int process_kfunc_with_implicit_args(struct=
 btf2btf_context *ctx, struct
>  		if (is_kf_implicit_arg(btf, &params[i]))
>  			break;
>  		param_name =3D btf__name_by_offset(btf, params[i].name_off);
> -		err =3D btf__add_func_param(btf, param_name, params[i].type);
> +		tmp_param_name =3D strdup(param_name);
> +		if (!tmp_param_name)
> +			return -ENOMEM;
> +		err =3D btf__add_func_param(btf, tmp_param_name, params[i].type);
> +		free(tmp_param_name);
>  		if (err < 0) {
>  			pr_err("ERROR: resolve_btfids: failed to add param %s for %s\n",
>  			       param_name, kfunc->name);

[Severity: Medium]
This isn't a bug introduced by this patch, but does the error logging path
still contain a use-after-free vulnerability for param_name?

If btf__add_func_param() fails after having already triggered a reallocation
of the BTF internal string table, the original param_name pointer could
become a dangling pointer. Since tmp_param_name is freed right before the
error check, the pr_err() call uses the potentially stale param_name pointe=
r.

Would it be safer to defer the free(tmp_param_name) call until after the
error check so the duplicated string can be safely used in the log message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-resolve-bt=
fids-implicit-args-use-after-free-v1-1-2af87d4704c8@mainlining.org?part=3D1
