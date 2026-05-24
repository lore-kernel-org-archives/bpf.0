Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDE2F872
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779613802; cv=none; b=UtjRD0YEP9h12E+g1aEvp6m3iPo7Hvcdsv72Eon2XQTmg1hKKegLQIPSd2WSFJ6IimFhnGOJiP5QMHU0KjAFq3T9lwgqm3j0Wk2wnO1R8SwJhLPGqIFh8SqTCi+qTtiqovITPAnok0uvL9YGmuHIBdMjNelus7zy4PEgtu1VaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779613802; c=relaxed/simple;
	bh=We3DJFb4HxPEjYAnkWjtWdCvWKM4MFSElIlAl1aUF50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tLwfzvBWY+UwNFS0Re7gnikI8OR3YNjceN96wNuEulmOj+ZEPhh6h8aauoJajj4WlzgeNjciP+IoGYk2fGVcJl1E8bxNfpTbAKEfJih5r020mRQ3kVyGZP7rV0JPO7WT7nGLi/LYl4ntG6AfAteUnkXo8z99zxjqAp2CDvuamBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkuQVPl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkuQVPl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1D11F00A3F;
	Sun, 24 May 2026 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779613800;
	bh=d4XCAC4DiDhy0TzyBBNgA1casCFsHvVmStnXhRBWY3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hkuQVPl059yoNBotQDTJNir8HOJk/00oHz1X/flUfWw6tpsnuZYaeCAN1BAXD1tDq
	 Pek5u2+6sJi09rnKPKC64UcE0i+3UuYxCwnklUydDzIZyqimvdkpC2CyKuup7m6cXh
	 3UVnmeTLUwTwiGaZ0CdG1ccqPp7NiZVRZuomxiZ+MUCKn6ntI9yJVusJuQ5TU8oNeK
	 WUXMCgNiP5Yi8caeOCP/HLx+J+Q9hX8/IqhH9PAzOxngXGEE8SsYfuIdPIVIMAXIK0
	 F3Ff2fMO8HtPs+hx+CbDoQSR6SQNIFor1JEKs2G4uKEfDgWri221gQWwL/XbLrPcbD
	 KJ+kZXUgjYmRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated
 kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Chen" <chensong_2000@126.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260524082944.10625-1-chensong_2000@126.com>
References: <20260524082944.10625-1-chensong_2000@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 09:10:00 +0000
Message-Id: <20260524091000.8C1D11F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The duplicate kfunc check incorrectly searches raw BTF data for an=
y function, rejecting kfunc registration if any unrelated static or global =
function shares the name.
--

commit 3dd29707347d5a7d6755ecd640562865f115a75b
Author: Song Chen <chensong_2000@126.com>
kernel/bpf/btf.c: reject to register duplicated kfunc

This commit adds a check during kfunc registration to search for duplicated
kfunc names in both vmlinux and loaded modules. It prints an error and
returns -EINVAL if a duplicate name is found.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d785812076..5fc2b4ca23470 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -8684,6 +8684,47 @@ static int btf_check_iter_kfuncs(struct btf *btf, =
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
> +	int ret =3D 0;
> +
> +	if (!btf_is_module(btf))
> +		goto out;
> +
> +	id =3D btf_find_by_name_kind(bpf_get_btf_vmlinux(),
> +					func_name, kind);
> +	if (id >=3D 0) {

[Severity: High]
Does this logic incorrectly reject kfuncs that happen to share a name with
unrelated internal functions?

btf_find_by_name_kind() searches the entire raw BTF data for any function
with the matching name and BTF_KIND_FUNC. It does not check if the found
function is actually a registered kfunc.

If a module attempts to register a legitimate kfunc, couldn't the registrat=
ion
be unconditionally rejected if its name matches an unrelated static or glob=
al
function in vmlinux or another loaded module?

Would it be safer to verify if the matching function ID is actually registe=
red
as a kfunc, perhaps by consulting btf->kfunc_set_tab?

> +		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
> +					func_name, id);
> +		ret =3D -EINVAL;
> +		goto out;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524082944.1062=
5-1-chensong_2000@126.com?part=3D1
