Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF027467F
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220414; cv=none; b=CXvIy6JgBieK/ukbP37DaShyt3fO0rxl8/EQhI19UQZYPWvFr5DYM1QHHJ8UI1bVpflPb8o/jNlJcFU6hxYZ/3s2hTOGFkDmff7K+V8IbYTBoE16gKAb4sow7S79r7BiZuKz3pSJsLs+F9UakwV4lZWRM8zif1ZkDANhdi+8Dyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220414; c=relaxed/simple;
	bh=g8gwzSXB6wxMpRx6zQm0NKw5Q7sm2A80TShp6fkyA1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NoR32aPoTlpmm+6XPNQSkU00Al1Ub0vWYAg9ZCMIeimy/vfbksDJqVtJnS7+FUFy5x+Yx8Ka+aiKODVQFwoxH3SB1LhLrJv/khYTHtNvZMnlcriTxpqUzRzHsKQN7dTc/FIM1+0ZNKWQlbaXVdPThAVs8NBGOBwHtE3ut7M1TE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jsq1Xd3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jsq1Xd3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F191F000E9;
	Tue, 28 Jul 2026 06:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785220413;
	bh=2Ax3/vOsZWCNB0/MTJYG96OFV0YxdLuyNY/DJ3c87Vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jsq1Xd3+hJ7oWsuV4ctydKTCfrFlWq4yihhHx4Vdu+HZ/3CZF1KJRGKOJ2O5UK8OH
	 w1++l/anXvEftaERAlg7QyTpEiPzswvm9qUnPjICnvAWFVgifwN+f6Rxg05YQ/ydd3
	 0aEHb38eH/k77WqjAemDAveo/2ioD5DL14J/6baRJBemTNGGKwhYHma5J+A7/YYJc+
	 HadFszYYJgEpVVH21HDQK4HJ+Kn3bgH4DPnJkoyDJ2qXWdRCUTIHR1NeWmmzaXFpRW
	 95Awdmr+hUAKo1NPEWCDc+02B3Eik+WW0w8Omg6EYNIIeqjjz/5RDj4HXoueJwWOlu
	 NPx1m0dMyAo2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: log error code on trampoline unlink
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: xu.xin16@zte.com.cn
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728142621001Ee2lrcnZpeNuxtxRES69Z@zte.com.cn>
References: <20260728142621001Ee2lrcnZpeNuxtxRES69Z@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 06:33:32 +0000
Message-Id: <20260728063333.24F191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] If `bpf_trampoline_unlink_prog` fails to update the physical t=
rampoline image, the detach path ignores the error and proceeds to free the=
 BPF program, resulting in a Use-After-Free (UAF) when the active trampolin=
e continues to call the freed memory.
--

--- Patch [1]: [PATCH bpf-next v3] bpf: log error code on trampoline unlink=
 failure ---
commit 0b0618c3d340947a280eadeb940ccfebcad04f6f
Author: xu xin <xu.xin16@zte.com.cn>

bpf: log error code on trampoline unlink failure

This commit replaces silent WARN_ON_ONCE with WARN_ONCE to log the actual
error code from bpf_trampoline_unlink_prog() during link teardown.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ff9e3aa293d5..b4b4fc49bba79 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3547,10 +3547,12 @@ static void bpf_tracing_link_release(struct bpf_l=
ink *link)
>  {
>  	struct bpf_tracing_link *tr_link =3D
>  		container_of(link, struct bpf_tracing_link, link.link);
> +	int err;
> =20
> -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link.node,
> -						tr_link->trampoline,
> -						tr_link->tgt_prog));
> +	err =3D bpf_trampoline_unlink_prog(&tr_link->link.node,
> +					tr_link->trampoline,
> +					tr_link->tgt_prog);
> +	WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
> =20
>  	bpf_trampoline_put(tr_link->trampoline);

[Severity: Critical]
This isn't a bug introduced by this patch, but since the commit message
mentions troubleshooting UAF crashes here, does this error path directly ca=
use
that UAF?

If bpf_trampoline_update() fails inside __bpf_trampoline_unlink_prog(), the
program is removed from the software list, but the physical trampoline is n=
ot
updated:

__bpf_trampoline_unlink_prog() {
    ...
    bpf_trampoline_remove_prog(tr, node);
    return bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, dat=
a);
}

Because bpf_tracing_link_release() merely logs the error and continues, it
will proceed to tear down the link and free the BPF program memory.

Will the unmodified physical trampoline then blindly jump into the now-freed
BPF program on the next kernel function invocation?

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 129d07db117ec..9b9eea02dd58d 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1004,12 +1004,15 @@ static void bpf_shim_tramp_link_release(struct bp=
f_link *link)
>  {
>  	struct bpf_shim_tramp_link *shim_link =3D
>  		container_of(link, struct bpf_shim_tramp_link, link.link);
> +	int err;
> =20
>  	/* paired with 'shim_link->trampoline =3D tr' in bpf_trampoline_link_cg=
roup_shim */
>  	if (!shim_link->trampoline)
>  		return;
> =20
> -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link.node, shim_lin=
k->trampoline, NULL));
> +	err =3D bpf_trampoline_unlink_prog(&shim_link->link.node, shim_link->tr=
ampoline, NULL);
> +	WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
> +
>  	bpf_trampoline_put(shim_link->trampoline);
>  }

[Severity: Critical]
This is a pre-existing issue, but this shim release callback appears to suf=
fer
from the exact same flaw.

If the unlink fails, it ignores the error and continues, leaving the hardwa=
re
hook active for a program that is about to be freed.

> @@ -1720,15 +1723,16 @@ int bpf_trampoline_multi_detach(struct bpf_prog *=
prog, struct bpf_tracing_multi_
>  {
>  	struct bpf_tracing_multi_data *data =3D &link->data;
>  	struct bpf_tracing_multi_node *mnode;
> -	int i;
> +	int i, err;
> =20
>  	trampoline_lock_all();
> =20
>  	for_each_mnode(mnode, link) {
>  		data->entry =3D &mnode->entry;
>  		bpf_trampoline_multi_attach_init(mnode->trampoline);
> -		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampol=
ine,
> -					NULL, &trampoline_multi_ops, data));
> +		err =3D __bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,N=
ULL,
> +					&trampoline_multi_ops, data);
> +		WARN_ONCE(err, "__bpf_trampoline_unlink_prog returns error: %d\n", err=
);
>  	}

[Severity: Critical]
This is also a pre-existing issue.

Similar to the other paths, this loop ignores unlink failures. Can this all=
ow
all attached programs to be freed even if their physical hooks remain activ=
e?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728142621001Ee=
2lrcnZpeNuxtxRES69Z@zte.com.cn?part=3D1
