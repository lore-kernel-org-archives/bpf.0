Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7B43D4EF
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901524; cv=none; b=YzsdXhJo8h8u9cOrHxRBkwVYIIsHtgP9HLFvu7yCK4P+FelGxqWTVLwF4jsLKIRm7IcMoSKgzzyryohaqWwA2/4Tk7sL/NoE0mm/xjzDNjUESW4ajC4l9o1ELnvxQYisT6S0pdohKO+34anAnX+Yh87cJfxdoE2wcsBbdcTjc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901524; c=relaxed/simple;
	bh=c3PSpdj4JGiYXVkMEH/HNC4DicZ8zc42tZJMxaNFdcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j0XLmrPcTdzHrxC9IJQeP6IfHsscZDXkz/UeDpTisCGxYXct42McMPbp+D6htHw2U7x1tOaJgokD6KZ7kfUoEdNAYhOydDOHWOWgtEHzcCge8fqUSedVM34DrKOJ2ST1lAmUFBVq543usqbASl1hkWisp/cEXn7etd3e+uz/9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRwuPD0u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRwuPD0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835641F000E9;
	Wed, 27 May 2026 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779901522;
	bh=Af19yPvAW+QuCKXeuoyRGCOKxF+EvtFkGYNBDw1iRLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRwuPD0us3xsPjUVvoHh/NLLbdmsQtD8cJ/vRKY1cSc+CHJ8dCzlXHpY2sv54zze5
	 gtKMS4A6dCopuaiJUgYm90a8ywtAplxxL44ikIZ8XMq2huIWDuh2ityXxrysMdW6Fg
	 MNaxzO0bGUmXfuVxhscPQ+mNW02zaU23qOiDexqgOZmftl8zz6nhs8fb5ROmtACUqu
	 Ze5wz4tSRAClqmTVRKuF1XxjLN6gr/Kfh1sRca3ha34mQGkTKbqhdTPkU3YQiRTeya
	 /YLu3ww0fFuu6L9ASUKA1i02H+7xRd7wca0eRJEp13amwiHdhDKTh7WIRsKT4CBPVp
	 +p1M++oAmCdMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] bootconfig: return 0 from xbc_snprint_cmdline() for
 a leaf root
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527-bootconfig_using_tools-v1-1-b6906a86e7d5@debian.org>
References: <20260527-bootconfig_using_tools-v1-1-b6906a86e7d5@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 17:05:21 +0000
Message-Id: <20260527170522.835641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The early return incorrectly assumes `xbc_node_is_leaf(root)` mean=
s there are no descendant key/value pairs, causing it to silently skip rend=
ering valid subkeys if the root node has both a value and subkeys.
--

commit 7fe40e4bc583f53fe486de6d90af68f475369ee3
Author: Breno Leitao <leitao@debian.org>

bootconfig: return 0 from xbc_snprint_cmdline() for a leaf root

This commit changes xbc_snprint_cmdline() to return 0 instead of an error
when the root node is considered a leaf, preventing a build failure for
empty subtrees in the bootconfig tools.

> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index f445b7703fdd9..3a102c9122f71 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -431,6 +431,16 @@ int __init xbc_snprint_cmdline(char *buf, size_t siz=
e, struct xbc_node *root)
>  	const char *val, *q;
>  	int ret;
> =20
> +	/*
> +	 * A leaf @root (e.g. an empty "kernel {}" subtree, or a key whose
> +	 * only child is a value node) has no descendant key/value pairs to
> +	 * render. The leaf-finding iterator below would otherwise return
> +	 * @root itself, which xbc_node_compose_key_after() rejects with
> +	 * -EINVAL.
> +	 */
> +	if (root && xbc_node_is_leaf(root))
> +		return 0;

[Severity: High]
This is a pre-existing issue, but does this early return unintentionally
skip valid descendant subkeys?

Looking at include/linux/bootconfig.h, xbc_node_is_leaf() evaluates to true
if a node has no children or its first child is a value node:

static inline __init bool xbc_node_is_leaf(struct xbc_node *node)
{
	return xbc_node_is_key(node) &&
		(!node->child || xbc_node_is_value(xbc_node_get_child(node)));
}

If a bootconfig contains a root node with both a value and subkeys
(for example, "kernel =3D val" and "kernel.param =3D 1"), xbc_node_is_leaf()
will evaluate to true for the root node.

Since this patch changes the behavior to return 0 instead of propagating
the -EINVAL error, will it silently skip rendering these descendant subkeys
and cause missing kernel command line parameters?

Would it be safer to drop this early return and instead add a check like
"if (knode =3D=3D root) continue;" inside the xbc_node_for_each_key_value()=
 loop
to skip the root's value while continuing to process its subkeys?

> +
>  	xbc_node_for_each_key_value(root, knode, val) {
>  		ret =3D xbc_node_compose_key_after(root, knode,
>  					xbc_namebuf, XBC_KEYLEN_MAX);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527-bootconfig=
_using_tools-v1-0-b6906a86e7d5@debian.org?part=3D1
