Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB9634FF41
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294505; cv=none; b=Ufp5qgkQeKiwxm8X/cleYMnF62P/eV+lmBOqZAXXENHVMeb9CDO7XE5S75C17B2cxWnTe88KpRp2cEro/ehtpwYAj2XicjuUZGy0z7ssZ3+QrjHXG2/7gY9KqrO4Pof1LXwp+53V3knilezHDJqd2yi2R5BXQnzPtOJKvt1AZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294505; c=relaxed/simple;
	bh=cllRYrtnr+Bm1jPSnk2qFgiIa6ciTLoO9Dhvv/e8lRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kH8NK+qPO/OZmdAmZ+5sPQOhz103v+WcBEciK/JuTjAdhZG+h/xZDk1Pp7LCRivPdBpj9XjF+narWPxRnALtctqjjyrm0KLqzO3WfsW+XZ/9FCctf+gLjVqpaVLSAzTxgYfj7TNI3DlPTNS/LbYgrnmUkajAA1jf+unWKWyOSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkBqDU2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkBqDU2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD881F00898;
	Mon,  1 Jun 2026 06:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780294504;
	bh=hIrK3Vdz98VrWrXKZaA2uPlWNsOaXYcmNkwTO7lNUgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MkBqDU2q/OJ7ke0/hQN0XoFsSAwTlFgi31Yub3qkjG5pbOzJJxPAyCIuvEFzW8A9v
	 u7xvD8v2iYVgCMPIKk6THdqIr995FcKx/+cmKdxTXPZQQaYFPwaB+rykvZN/pIfR6O
	 xjjElObyi/05/3TjDgrCFiSrs1jLuGzRRMzTuumthPBWohonslLZZe2c3VC60zcXqH
	 2dDhl5/miJUr8dOcd8+TvoZnDjQ3qBGtYnmtYxCVEtX7hzNQQAyrIxGEf6V99nkHbQ
	 cg47LAlZloyugmPLIBFvWN+6OkwH0nC7A3Jc2GdnYuq6dHQ6c8AUbpORhGzCWKUcHi
	 bTMnf1oFIKV0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Clear rb node linkage when freeing bpf_rb_root
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601055859.13888-1-kaitao.cheng@linux.dev>
References: <20260601055859.13888-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 06:15:03 +0000
Message-Id: <20260601061503.EFD881F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unbounded O(N) red-black tree traversal inside an IRQ-disabled spi=
nlock critical section introduces latency spikes, potential soft/hard locku=
ps, and deadlocks.

Pre-existing issues:
- [High] Nodes added to a deleted map element's rbtree after `bpf_obj_free_=
fields` are permanently leaked.
--

commit 867fefb5dd2755c5bd12c9f3bd37d5367c6793f3
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

bpf: Clear rb node linkage when freeing bpf_rb_root

This commit modifies bpf_rb_root_free to clear red-black node linkage when
freeing a root. It mirrors list draining behavior by marking nodes as busy
while detaching the root, clearing the linkage, and releasing the owner
before dropping the containing object.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5314c9fed3cf..c7f26336984f0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2296,22 +2296,30 @@ void bpf_rb_root_free(const struct btf_field *fie=
ld, void *rb_root,
>  {
>  	struct rb_root_cached orig_root, *root =3D rb_root;
>  	struct rb_node *pos, *n;
> -	void *obj;
> =20
>  	BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root)=
);
>  	BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bp=
f_rb_root));
> =20
>  	__bpf_spin_lock_irqsave(spin_lock);
>  	orig_root =3D *root;
> +	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
> +		struct bpf_rb_node_kern *node;
> +
> +		node =3D rb_entry(pos, struct bpf_rb_node_kern, rb_node);
> +		WRITE_ONCE(node->owner, BPF_PTR_POISON);
> +	}

[Severity: High]
Since there is no verifier-enforced limit on the number of nodes in a BPF
rbtree, could this O(N) post-order traversal trigger latency spikes, RCU
stalls, or NMI watchdog lockups?

This loop runs inside the __bpf_spin_lock_irqsave() critical section, which
disables local interrupts.

Additionally, since rb_first_postorder() and rb_next_postorder() are
exported and traceable, if an fentry/fexit BPF program is attached to them
and attempts to acquire the same bpf_spin_lock, will it cause a hard deadlo=
ck?

>  	*root =3D RB_ROOT_CACHED;
>  	__bpf_spin_unlock_irqrestore(spin_lock);

[Severity: High]
This isn't a bug introduced by this patch, but does this pattern permanently
leak memory if a concurrent BPF program adds a node after the tree is empti=
ed?

When a map element is replaced or deleted, bpf_obj_free_fields() detaches
the tree here and sets *root =3D RB_ROOT_CACHED. However, a concurrent BPF
program running inside an RCU critical section might still hold a pointer
to the map element.

If that program takes the spinlock and calls bpf_rbtree_add(), it will
successfully add a new node to the now-emptied tree.

After the RCU grace period ends, bpf_mem_free_rcu() frees the map element,
but bpf_obj_free_fields() is never called again. Will the newly added node
be left behind and leaked?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601055859.1388=
8-1-kaitao.cheng@linux.dev?part=3D1
