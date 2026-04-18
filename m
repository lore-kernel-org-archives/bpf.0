Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05929BD95
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776535602; cv=none; b=QxOgc5o9OrAyTLLUSCCs9WPPesjt1xwbGJS7v57L31wlS+WduV6S3bnUBt/6iiAkWv1cV5pRMbT5/1b8Q/ToFKARaZe4QQs7KWQC1uFEf9RuO2XaFmOQ9mpGWAqOzWurbNkH/NW/iyljUMmF7qC5XTEmC4+OLThY6QRwfkiibxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776535602; c=relaxed/simple;
	bh=sMlRcCNlAgGfzHEWm9X7utm/COseoSGeBm8mmokRP6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lq0oQCSWfMDrUlQ2k42wYfAbczlN4/7jSu4Ey+YLQadjpkJZglkhBl6HWuLhpCiFlhnINPqjBtC4DnlCKQ1MFSy+vaLGG4guTeSdeNz1KrhcXu+siPzre15bqnGPW+MGxwWBkki1eaTLdWZYzw0pvgGCXNMbYxq0gOd3mZ8Whos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcl00enp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcl00enp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D95C19424;
	Sat, 18 Apr 2026 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776535602;
	bh=sMlRcCNlAgGfzHEWm9X7utm/COseoSGeBm8mmokRP6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Xcl00enpKbKsD2a/yQZyipSYXk8FJEYdUhQFdjImRU/souLlfjtCrpsgG0VI8q6Ib
	 VjCJ4H0RD/wEEagPGK+2vN/xkWHSK0bQRVgbVp0m74Hf/ZesE4mpuFFr8+30csUONm
	 DB5r7Do6hNx2fiI12Bn1lEDj2uYraW8BtFGsgTcf83Gnc8mCrF09+/HvGpB8fEZ5Op
	 iy9fnWdIKXISko9JjG/A7pNrDt4/4BNvF6W5Sii/kuotHfrGzo0YeCCUTO5wh6NQ1v
	 E47fXYWqAdL7nwxOWvtQXveCzpWzb6KeRo9gEH2EwSgO9Mhc879Tx9b7cEx1tTrfjx
	 ZD5iCu0hbxwxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Introduce
 __bpf_kfunc_mark_deprecated annotation
Reply-To: sashiko@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418171701.610025-3-memxor@gmail.com>
References: <20260418171701.610025-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 18:06:41 +0000
Message-Id: <20260418180642.14D95C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Programs loaded without BTF will silently bypass deprecation war=
nings.
--

commit 90e501a1948d112dbb3b96a16249f1f76f84b290
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Introduce __bpf_kfunc_mark_deprecated annotation

This commit introduces the __bpf_kfunc_mark_deprecated macro to annotate
deprecated kfuncs with a replacement. It applies this annotation to existing
impl-suffixed kfuncs and modifies the verifier to emit warnings when these
deprecated kfuncs are used.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12987,6 +12987,45 @@ static int check_return_code(struct bpf_verifier=
_env *env, int regno, const char
>  static int process_bpf_exit_full(struct bpf_verifier_env *env,
>  				 bool *do_print_state, bool exception_exit);
> =20
> +static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
> +				       struct bpf_kfunc_call_arg_meta *meta,
> +				       int insn_idx, s16 offset)
> +{
> +	const struct bpf_line_info *linfo;
> +	const char *replacement;
> +	const struct btf_type *t;
> +	struct bpf_kfunc_desc *desc;
> +	const char *file;
> +	int line_num;
> +
> +	if (!env->prog->aux->btf)
> +		return;

Will programs loaded without BTF silently bypass the deprecation warning?

The kfunc deprecation tags are stored in the kernel or module BTF
(meta->btf), not the program's BTF.

If we return early here, we skip evaluating the tag entirely. There is a
fallback branch below that handles missing line info which could be used to
emit the warning even if the program doesn't have BTF.

> +
> +	t =3D btf_type_by_id(meta->btf, meta->func_id);
> +	replacement =3D btf_find_decl_tag_value(meta->btf, t, -1, BPF_KFUNC_DEC=
L_TAG_DEPRECATED);

[ ... ]

> +	linfo =3D bpf_find_linfo(env->prog, insn_idx);
> +	if (linfo) {
> +		bpf_get_linfo_file_line(env->prog->aux->btf, linfo, &file, NULL, &line=
_num);
> +		warn(env, "%s:%d (insn #%d) uses deprecated kfunc %s(), which will be =
removed.\n",
> +		     file, line_num, insn_idx, meta->func_name);
> +	} else {
> +		warn(env, "(insn #%d) uses deprecated kfunc %s(), which will be remove=
d.\n",
> +		     insn_idx, meta->func_name);
> +	}
> +
> +	warn(env, "Switch to kfunc %s() instead.\n", replacement);
> +	warn(env, "For older kernels, choose the correct kfunc using bpf_ksym_e=
xists().\n");
> +
> +	desc->warned_deprecated =3D true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418171701.6100=
25-1-memxor@gmail.com?part=3D2
