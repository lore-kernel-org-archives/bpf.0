Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968F38B12B
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479505; cv=none; b=BwTp7f0GaGCAkNGUuRMkADF7XR/GRtlTfElv/syLOTHBg0dqHoWOw745xkUtTF9sJrMO4NNO/tOlvLyPEx4xfEqnjc+MaHjaI+6HduXoYk46rJ9YNm9zzI8wEog9ta8F5VZdswB804ue3rqmzohnn6nn2lpaiPm3rMqIi6od6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479505; c=relaxed/simple;
	bh=1kEXHXFW8U2f6ClLkkxP4faL4+K4pFUgnt9nH9JH3cE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LOdbKJNVdszD+74dpz83kg25DuHfpjOnbbIikVytEUsSF+0jzkBlO9ePDboHtmSBfU2JgWuY/qId9xt0jmJMVrgRfUcDm95tbDe5qdwSBLEz0Br+3JR37OCdv8r7TWmetXdpcTAzn4NIkPa4eKJzxuFX2k+mIEJqWpq7lsUStAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixGrqEMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixGrqEMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11CE1F00893;
	Wed,  3 Jun 2026 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780479503;
	bh=FT1W7pB/bpjeFMTYVg+WsMrXFUpPzLpaJXZrbHnU1sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ixGrqEMTSaJMyeIPuV+udB33YSa3ZgvSdJa4vIuZYEw7mFPv9dlFbev9R9+1xHKD6
	 yy/8sZYZcbSxTOEqPGt8P9Vhm6pnemC7EYG2UTtSFUQueg8BPeLbuhDX+x+WKEvj3T
	 UN4kiaCPsl8DVc1q2zPJ0+U8pP5zB+3qzpJjcMQnAC8gx1jQvYVvpugtqETEaAtxdg
	 tCSdSJ+56j7+bPZ5bwtFjjRR75+8JX0cCofbdQ8VWrq9fVwCuoRzFwbOtC7R4Ruyt6
	 F1mcIxVXgvkv7mFYg6eTRbP3D6LMFmJg7FFDB+tGcGBnPEFMGFlsQESpAJf4wg70PX
	 7dUFlxSdgO2NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] btf: reject to register duplicated kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Chen" <chensong_2000@126.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603091910.7212-1-chensong_2000@126.com>
References: <20260603091910.7212-1-chensong_2000@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 09:38:23 +0000
Message-Id: <20260603093823.B11CE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Over-broad name matching and TOCTOU race in `btf_check_kfunc_name`=
 causes spurious kfunc registration failures.
--

commit f266b4f51a9ccb4dc2dda71022e37347dd375a67
Author: Song Chen <chensong_2000@126.com>
btf: reject to register duplicated kfunc

This patch adds a check to prevent kernel modules from registering kfuncs
that have the same name as existing kfuncs in vmlinux or other modules. It
searches the BTF data for duplicate function names and returns an error if
a match is found.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d785812076..d97956302fe7b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -8684,6 +8684,39 @@ static int btf_check_iter_kfuncs(struct btf *btf, =
const char *func_name,
>  	return 0;
>  }
> =20
> +static int btf_check_kfunc_name(struct btf *btf, const char *func_name, =
u32 kind)
> +{
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	struct btf_module *btf_mod, *tmp;
> +#endif
> +	s32 id;
> +
> +	if (!btf_is_module(btf))
> +		return 0;
> +
> +	id =3D btf_find_by_name_kind(bpf_get_btf_vmlinux(), func_name, kind);

[Severity: High]
Does this check search the entire raw BTF data for vmlinux instead of just
registered kfuncs?=20

Since btf_find_by_name_kind() looks for any BTF_KIND_FUNC, could this
falsely reject a kfunc registration if its name matches any internal or
static kernel function in vmlinux, rather than specifically matching another
registered kfunc?

> +	if (id >=3D 0) {
> +		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
> +		       func_name, id);
> +		return -EINVAL;
> +	}
> +
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	guard(mutex)(&btf_module_mutex);
> +	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
> +		if (btf_mod->btf =3D=3D btf)
> +			continue;
> +		id =3D btf_find_by_name_kind(btf_mod->btf, func_name, kind);

[Severity: High]
Similar to the vmlinux check above, does this search expose the registration
to false conflicts with internal functions within other loaded modules?

Additionally, because a module's BTF is added to the btf_modules list during
the MODULE_STATE_COMING phase (before its initialization and actual kfunc
registration), could concurrent module loading cause spurious registration
failures due to the raw BTF being exposed early?

> +		if (id >=3D 0) {
> +			pr_err("kfunc %s (id: %d) is already present in module %s.\n",
> +			       func_name, id, btf_mod->module->name);
> +			return -EINVAL;
> +		}
> +	}
> +#endif
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603091910.7212=
-1-chensong_2000@126.com?part=3D1
