Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71B231A23
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910857; cv=none; b=fWpVrnBQW2UddlpUrSNEP/0RTIr/JB7gmBAZG+z7ApSQhhMVRfdYhN2CXuv3M3LzIhPX6KUa6/MCHTz4EEAZ0BoLrBASI8+Tbvw1CRr4NuWeMCWVaO1T4OKPPoxJVFL9N7/0/rocZGDOwI15bRkDro96hVluhvaXRb4xiAaej9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910857; c=relaxed/simple;
	bh=OHgtyH4zHxxrWEG+z/nNEa+EdBd04lCBj/Txj9JVMeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cdl+ql/3dJwen2wQ+CYZpHU0NmIcoSjGqjSWwEsSVcjwZ3CA1MInL2CZ+WlTM/3xql3sB7kOBTdFnO0bpa1vgIcBAW3dTdQZuko8MCQjF4PCxxmrBhJFEcSCZsMich2hvkSTIxe6kqLFZOroF6ZnuxGeTsVgLwr5PaF1NoDFewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If+pvFXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If+pvFXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FE61F000E9;
	Fri, 28 Aug 2026 09:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787910856;
	bh=48mGfdD5i3Gh8wEAZvxinJB60L16RN3H92eq8vHoz/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=If+pvFXpTGm3g9DjqyrEyGX9jDftf0xdz/fERZiXMC5lFZGyraNAzQi4L5XSvBxW6
	 OJU0T8z0zYM7hBF1zSmEvL5Eaig5QvI3oL/mQNFVS/scaCyE60oS0vpNV/3M4byIqP
	 Zy/CYkfwxH8pzSdMRyKTmSmknMiBf9Q9r+NyDpMMijak5dT5vzdIwqxlaL7y1QuST6
	 POvcCf1dyfNOuKxCqK8RCUWEXHhKyUJay+mhrWjkzzCNhWQ0WMkz23zCt/J6/9g/x0
	 tUIXfbiKKXgd48q+sph0vCoiq5S8oMnWj/V+dYdgFdawciD/D0epF7QREQNBLdl4tO
	 xt3rpWIR2wzOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Fix NULL-ptr-deref when dumping a key-less
 BTF hash map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260828093142.179856-1-jiayuan.chen@linux.dev>
References: <20260828093142.179856-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:54:15 +0000
Message-Id: <20260828095416.50FE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] btf_modifier_show dereferences NULL when a modifier resolves to a =
void type.
--

commit 36dc7c26f56375bd142801da1fcbc83e4a765c35
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: Fix NULL-ptr-deref when dumping a key-less BTF hash map
   =20
This patch fixes a NULL pointer dereference in btf_type_show() that occurs
when dumping a key-less BTF hash map. It restores previous behavior by
rejecting key-less BTF in hash map check callbacks, and adds a NULL check
for void types in btf_type_show() to gracefully handle any other paths.

Reported-by: syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a8f4e88.27659fcc.2ceef7.0008.GAE@googl=
e.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index da36d4b9d31ab..c32265dc4ae7e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8229,6 +8229,10 @@ static void btf_type_show(const struct btf *btf, u=
32 type_id, void *obj,
>  	memset(&show->state, 0, sizeof(show->state));
>  	memset(&show->obj, 0, sizeof(show->obj));
> =20
> +	/* A void type (e.g. type_id 0) has no show op, don't deref NULL. */
> +	if (!t || !btf_type_ops(t))
> +		return;
> +
>  	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
>  }

[Severity: High]
This is a pre-existing issue, but does this fix need to be extended to
btf_modifier_show() as well?

If a user with BPF tracing privileges invokes the bpf_snprintf_btf() helper
with a btf_id of a modifier that points to void (e.g., const void),
btf_type_show() will see the modifier type and pass this check since
modifier_ops is not NULL.

Execution would then proceed to btf_modifier_show(), which strips the modif=
ier
and resolves the underlying type to btf_void:

kernel/bpf/btf.c:btf_modifier_show() {
	if (btf->resolved_ids)
		t =3D btf_type_id_resolve(btf, &type_id);
	else
		t =3D btf_type_skip_modifiers(btf, type_id, NULL);

	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
}

Since btf_type_ops(t) for btf_void is NULL, wouldn't this unconditional call
result in an immediate NULL pointer dereference, bypassing the check added
here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828093142.1798=
56-1-jiayuan.chen@linux.dev?part=3D1
