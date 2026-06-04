Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3D35B12B
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617533; cv=none; b=EwkNFdmPqivy8YYml+XRlM9kDzVpn7QGzprP9f29mSDYppbZszealRaUZqxM2nNABFfVvea4iCQwBafBldnoMdRNio8eQkwW48Ep1DEN21iy9k9IOoEumUFJjhC/J7t86JgZ6dYah8ynhlDigPqVvLRlD8EVfZbv929/qiKgwt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617533; c=relaxed/simple;
	bh=L9TaszB4HhqNgjRHdpmF72LGPexhKNRPqlHvUwrzTWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=udl7YwoNRAHDNYPgHs9KPR1FEsfipn1lavmACtL+geLsI9adaAY/8MFVLSr7G5Eay78M1pywyI63asrL8k8/C8nQFjQbPAQHsMUk75YCu87hJTIQvThqez3HtxJ7+8mztuYyMWb39IJh8c8hWLRKOf6SNcMlPEdaW1ZEDofbork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTlG5/M3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTlG5/M3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174E61F00893;
	Thu,  4 Jun 2026 23:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780617532;
	bh=9xzMrKQFuBOvKlCVbms2MHwL2A6+jxWcqHLZ5WCL/fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTlG5/M3pthOGDYYMG50nMAW80FwgtsVwzk4hncUNFxzBHmgFz1zwghqOmMAx/Lw4
	 eTbBvDiTnB78icbWMevOXz7zSe7xUqv+tneEU7Ybm47QfMWjzBWFzVJQEp31FWgpbc
	 jxKLtjcOVAwlIsae5vxL2Q3frRXixemsSRxn0CBA9off4Jm1W3mwhMTBVL+MfcQR8s
	 CQ3MzK6RrQoicT2n4rqNDPElH4Ft7MQlQYmZgpiz7/LibwgaLakPiRoYQl0ffnqXKk
	 CE7ebLu1jqoRkZJ6M1YiK0/4aZZbKu2EtNfReoUwHQaBQAA9vDt7j1VdSqU3EZYzQP
	 Oo6+FaVibEYaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] selftests/bpf: libarena: Add rbtree
 data structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604235016.20856-2-emil@etsalapatis.com>
References: <20260604235016.20856-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 23:58:51 +0000
Message-Id: <20260604235852.174E61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rb_destroy() unconditionally frees the rbtree handle even if node =
removal fails or the loop terminates early, leaking all remaining nodes and=
 risking a Use-After-Free.
- [Medium] rb_least() and rb_destroy() lack NULL pointer validation for the=
 rbtree argument, leading to potential NULL pointer dereferences.
--

commit 73769b0f46630a26f3f9bdbf4c6e6ee81439114f
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add rbtree data structure

This commit adds a native red-black tree data structure to libarena.
The tree uses the libarena memory allocator to manage its data and
provides a set of APIs for key-value and node-based operations.

> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> new file mode 100644
> index 0000000000000..979059e9860d6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c

[ ... ]

> +__weak
> +int rb_destroy(struct rbtree __arena *rbtree)
> +{
> +	int ret =3D 0;
> +
> +	arena_subprog_init();
> +
> +	if (rbtree->alloc =3D=3D RB_NOALLOC) {

[Severity: Medium]
Should there be a NULL check for rbtree before dereferencing it here?
Most other APIs in this file include if (unlikely(!rbtree)) at the beginnin=
g,
so it looks like it might be missing here.

> +		/*
> +		 * We cannot do anything about RB_NOALLOC nodes. The whole
> +		 * point of RB_NOALLOC is that the nodes are directly owned
> +		 * by the caller that allocates and inserts them. We could
> +		 * unilaterally grab all nodes and free them anyway, but that
> +		 * would almost certainly cause UAF as the callers keep accessing
> +		 * the now freed nodes. Throw an error instead.
> +		 */
> +		if (rbtree->root) {
> +			arena_stderr("WARNING: Trying to destroy RB_NOALLOC tree "
> +					"without removing all nodes");
> +			return -EBUSY;
> +		}
> +
> +		goto out;
> +	}
> +
> +	while (rbtree->root && can_loop) {
> +		ret =3D rb_remove(rbtree, rbtree->root->key);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	arena_free(rbtree);

[Severity: High]
If the loop breaks early because rb_remove() fails or can_loop is exhausted,
does unconditionally freeing rbtree here orphan the remaining nodes?

Since ret retains the error code from rb_remove(), the caller will see an
error, but the tree pointer will have been freed, potentially risking a
use-after-free if the caller attempts any cleanup.

> +	return ret;
> +}

[ ... ]

> +__weak int rb_least(struct rbtree __arena *rbtree, u64 *key, u64 *value)
> +{
> +	struct rbnode __arena *least;
> +	if (!rbtree->root)

[Severity: Medium]
Does this code need a NULL check for rbtree before checking rbtree->root?
Similar to rb_destroy(), it appears to be missing the validation used in
the rest of the exported functions.

> +		return -ENOENT;
> +
> +	least =3D rbnode_least(rbtree->root);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604235016.2085=
6-1-emil@etsalapatis.com?part=3D1
