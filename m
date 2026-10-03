Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405F238166
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 04:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791002674; cv=none; b=muBNE36YqXISaps+1F/D6+nmVB6qQsqxMPCBmS9j+H67Os9BC2CigmGH90CmsUee2SFe2KyXP1H+qzPRoozenbizWp8o4wBr19Mja6TPgXAm14rYKHUyplzh+QhRpZjE5+oN8+SmfmDBgJVKxMdBn4MgFBuIspTqN9+4i5EqNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791002674; c=relaxed/simple;
	bh=ozo7ddyiKT+hEBsIc9hpwPwJkI+f6tpdysrEyaq1izU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1H1CHlAdn49BfaHtWccQk35jlQpZDNTS40l7qZQRk45YSdFPwiaJ2QPn3+zLVc7jGoZQQzJD+6rPAENdVaaTIrirnSlixyuOG/2W+VnteAhGZJbF0lQ4u4pLbH4krx71pKZ1wlML4ZZXXblbJTStMLIi0AGKtBkf1hZqo0ZU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7DPoz0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7DPoz0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059B01F000FF;
	Sat,  3 Oct 2026 04:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791002673;
	bh=jaikqOWgOXNftF8gpZSrrVtn7E/QlKp8vnp9cMXUNcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y7DPoz0+1rHwuO+7hM56A8vlMohvjxN/HnI8NKH7Yj6gteof7Y6jnrLGQecCF7e6m
	 qcbpuWGHtvPHwdAseC9z+4lgk8yKUFM4grl4FtRDMAHwN2Yo/ECoFu8dYk2rUd0TaB
	 hXoJ3G0tOM7+FX8C3iACNlywKeT9R5u67JJ2E+IxsHy2yekSZBy1+QTDNx+/B6oFy/
	 beGBZW8RLri7WY5TmWvZoxrW4PUIjs03poO/2R8hkl/OkMQXmGVHyAwY91kQlPcGk1
	 hwXlQJNDShC2dEOWqMozxAdiwcsPNNZJwN/FjyCxwrWi2/mb899VjRMHgQ23i2JPP6
	 D1w1DfX03kIRg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 2/3] tools/ufq_iosched: add BPF example scheduler and
 build scaffolding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261003042748.33795-2-kaitao.cheng@linux.dev>
References: <20261003042748.33795-1-kaitao.cheng@linux.dev>
 <20261003042748.33795-2-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 04:44:32 +0000
Message-Id: <20261003044433.059B01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ufq_iosched: bpf_rbtree_left() returns structural child missing =
logical predecessor
--

commit 64af8341d2a8ec597c3320deffd60d7e970c5a0d
Author: Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: tools/ufq_iosched: add BPF example scheduler and build scaffolding

Add ufq_iosched as a simple example for the UFQ block I/O scheduler. In the
ufq_simple example, we implement the eBPF struct_ops hooks the kernel expos=
es so
we can exercise and validate the behavior and stability of the kernel UFQ
scheduling framework.

diff --git a/tools/ufq_iosched/ufq_simple.bpf.c b/tools/ufq_iosched/ufq_sim=
ple.bpf.c
new file mode 100644
index 0000000000000..f49ef0d192588
--- /dev/null
+++ b/tools/ufq_iosched/ufq_simple.bpf.c
[ ... ]
> +static struct request *merge_bio_left_unlock(struct ufq_simple_data *ufq=
_sd,
> +					     struct bpf_rb_root *tree,
> +					     struct sort_tree_node *snode,
> +					     struct request *cand)
> +{
> +	struct sort_tree_node *left_node =3D NULL, *owned;
> +	sector_t cand_start, left_start, left_end;
> +	struct bpf_rb_node *tmp, *removed =3D NULL;
> +	struct request *left_rq =3D NULL;
> +	bool merged =3D false;
> +
> +	cand_start =3D cand->__sector;
> +	tmp =3D bpf_rbtree_left(tree, &snode->rb_node);
> +	if (!tmp)
> +		goto end;
> +
> +	left_node =3D container_of(tmp, struct sort_tree_node, rb_node);

[Severity: Medium]
Will bpf_rbtree_left() return the structural left child of the RB-tree node
instead of the logically adjacent predecessor in the sorted order?

If the logical predecessor is an ancestor or the rightmost node of the left
subtree, will this structural check test the wrong node and miss valid doub=
le
merge opportunities for I/O requests?

[ ... ]
> +static struct request *merge_bio_right_unlock(struct ufq_simple_data *uf=
q_sd,
> +					      struct bpf_rb_root *tree,
> +					      struct sort_tree_node *snode,
> +					      struct request *cand)
> +{
> +	struct bpf_rb_node *right_rb, *removed =3D NULL;
> +	struct sort_tree_node *right_node =3D NULL;
> +	struct request *right_rq =3D NULL;
> +	sector_t cand_end, right_start;
> +	bool merged =3D false;
> +
> +	cand_end =3D cand->__sector + (cand->__data_len >> SECTOR_SHIFT);
> +
> +	right_rb =3D bpf_rbtree_right(tree, &snode->rb_node);
> +	if (!right_rb)
> +		goto end;
> +
> +	right_node =3D container_of(right_rb, struct sort_tree_node, rb_node);

[Severity: Medium]
Does bpf_rbtree_right() return the structural right child instead of the
logically adjacent successor?

Similar to the left check above, will this structural check bypass valid
double merge opportunities when the logical successor is not the direct
right child?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003042748.3379=
5-1-kaitao.cheng@linux.dev?part=3D2
