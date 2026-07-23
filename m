Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0E3D9557
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790087; cv=none; b=ZDl8q4AK1APJ4HG6IlcZOCqPM8UcqCYMb9Ews4gBtCkcASJKfm55xdc8Ul7A5qnHrPeh/QWy936IYOFpCNzoMNmBqDmxo6hf2L9l+2eGLh/XDbPgB+Frf0BNvFEit5IH0oUgjhJx5zHZ4w3GLGwKuWJPEJKQ+fONEqJSAif1qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790087; c=relaxed/simple;
	bh=eeK+6eyMnjHMHPPkdBSZ/ZYrSJdAjKDx7pg8jCDM5oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kC5nEmZ/U3z0oaJMiIXFQgBhgfXIjrLd6KI3D1eXP79cuGoKk0vvTzaxiSuo3FR1Cw8rrw6RR8iiO6xc+DeOwyj5saRmqlLNIxBW9YdvvRl1HbMNTJYYbYlAwuO7VKZ81n+NNvcnytBIFViNKcGwifucszQY/RlVOXWZ5C4u4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFek/+JV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFek/+JV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F921F00A3A;
	Thu, 23 Jul 2026 07:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784790082;
	bh=cFL7/eF5weRRJUSWQKl3p7VBjRk1P1kuSEZ3t+CCfx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eFek/+JVH6bwACn8DuaEMy8kuk3sT+ymctB1MCnlsTVAlZk2Q6YMddqNlQTeGvqvg
	 5Utz2rSfwNlXqTOgFCacdJa5MAhRnz1lnHdNBlRhXtBzopCM/cCrNcIjZ0unIpQ6gU
	 Pr1ZvIZ8k9sz4TSOBl/CUHVmgoAmZ6ZrUYfrbZOSseoTQ5MXZqOep0WhmCnNNXIzzi
	 RlR6a1SF7klMkl1hgly+SC6Z+YjuoV6IVhyEA5IzTNq2IfkOQtJmUD7xSO6pBgRNzg
	 7nNthBIpstxjFcTWIUYiKuS181PgCIAknU2WYWE1/l/90/eXE4OfGWaHKxRYeuF9vQ
	 lMsTULUXU2e3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] libbpf: initialize btf_ext out-parameter early in
 btf_parse_elf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveed Khan" <naveed@digiscrypt.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <178478908698.2.4018643732078767322@digiscrypt.com>
References: <alTie0_4pu-T5Bik@krava>
 <178478908698.2.4018643732078767322@digiscrypt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 07:01:22 +0000
Message-Id: <20260723070122.99F921F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] btf_parse_elf() incorrectly uses IS_ERR() to check for btf_ext__ne=
w() failure, causing .BTF.ext parsing errors to be silently ignored.
- [High] A latent double-free of dist_base_btf exists on the error path of =
btf_parse_elf().
--

--- Patch [1]: [PATCH v3] libbpf: initialize btf_ext out-parameter early in=
 btf_parse_elf() ---
commit 5cc9e33bf25334c39330a03f9b8133245f9ed0c1
Author: Naveed Khan <naveed@digiscrypt.com>

libbpf: initialize btf_ext out-parameter early in btf_parse_elf()

This commit initializes the btf_ext out-parameter to NULL early in
btf_parse_elf(). This prevents callers that pass an uninitialized pointer
from encountering stack garbage during cleanup if the function fails before
reaching the .BTF.ext parsing step.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 823bce895178d..cabe8286f06c9 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1453,6 +1453,9 @@ static struct btf *btf_parse_elf(const char *path, =
struct btf *base_btf,
>  	int err =3D 0, fd =3D -1;
>  	Elf *elf =3D NULL;
> =20
> +	if (btf_ext)
> +		*btf_ext =3D NULL;
> +
>  	if (elf_version(EV_CURRENT) =3D=3D EV_NONE) {
>  		pr_warn("failed to init libelf for %s\n", path);
>  		return ERR_PTR(-LIBBPF_ERRNO__LIBELF);

[Severity: High]
This is a pre-existing issue, but does btf_parse_elf() incorrectly use
IS_ERR() to check for btf_ext__new() failure further down in this function?

tools/lib/bpf/btf.c:btf_parse_elf() {
        ...
        if (btf_ext && secs.btf_ext_data) {
                *btf_ext =3D btf_ext__new(secs.btf_ext_data->d_buf,=20
                                        secs.btf_ext_data->d_size);
                if (IS_ERR(*btf_ext)) {
                        err =3D PTR_ERR(*btf_ext);
                        goto done;
                }
        ...
}

If btf_ext__new() returns NULL on error rather than ERR_PTR, IS_ERR() will
evaluate to false. This would cause the function to silently ignore
malformed .BTF.ext data or allocation failures, leaving *btf_ext as NULL
and misleading the caller into assuming there is no extended BTF data.

[Severity: High]
This is also a pre-existing issue, but is there a latent double-free of
dist_base_btf on the error path of btf_parse_elf()?

Earlier in the function, ownership of dist_base_btf is transferred to btf:

tools/lib/bpf/btf.c:btf_parse_elf() {
        ...
        if (dist_base_btf)
                btf->owns_base =3D true;
        ...
}

Then on the error path, both are explicitly freed:

done:
        ...
        btf__free(dist_base_btf);
        btf__free(btf);

If btf->owns_base is true, btf__free(btf) recursively frees its base BTF,
which points to the same dist_base_btf object. If an error occurs after
the ownership transfer (such as if the btf_ext__new() error check is fixed),
would this lead to a double-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178478908698.2.4018=
643732078767322@digiscrypt.com?part=3D1
