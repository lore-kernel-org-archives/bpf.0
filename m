Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC09311587;
	Wed, 25 Feb 2026 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014971; cv=none; b=KAYq4YhrCdDkwecTn6lwiIvBbZuLbumm5ZN+ZHNdV6NZcADgrSUaGFkhKzCd5h8UeCLMNJHM0ydb68tu3WNVpKdOYQ/O26PZn7kNiCDxQ/kUG83j8dVlKZwCLbJihnJMnlHKnydVqpjRTRkbilhLCFl7LqdeUAw7tKlCmVvy/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014971; c=relaxed/simple;
	bh=gdrtsR2FeVso8a4uVhevoFIWVVb/zq+AI6iRvYROt+k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MBSDBihiPsn63lBTKIiLmG78Y4pZ8mbkDpmR5Yt+Htvra57v5jQkwc1CD47RSJP2m1UYKJAivNevSLheoki8H4wPOqImrdGQiLLAbmDd3VmHenqdpNNoOXj7SxfFPdbXJ/n9xI/Ii4b5Gcpg8+dWS8LTkgYddaBa9iXFk70qvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+/JSkBQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+/JSkBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D2DC116D0;
	Wed, 25 Feb 2026 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772014970;
	bh=gdrtsR2FeVso8a4uVhevoFIWVVb/zq+AI6iRvYROt+k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=i+/JSkBQbsl7LRQglWfnqh6v0ORD/7UuQX401tJ9A9RvWmyeJzKPUD2t4OQ408Jpi
	 EtVubx4Qtcs5jlGCMrEleHJtvprw/yelWy9hfBAyK4gpcKuKasIRmbNk66+kq/d+Hz
	 WbezYtqNQFJhMjJaZoHDVCvnouNnaR/hJHq69day/L1INhBGzXRTLs3H6IqqHnkaQx
	 lBmciBqVPhHg0G6eG9SuwAl5vvL8MQTiKatxKXHsF1dBzisztPQqf/rW6jT111kayz
	 nXKgbwPqV9s28RIGT3BiY2jN8Rulnwq9EmytTyjaRfx8/EF9QuTCBI36oopjGG3XyP
	 2+0m5NyMpsDng==
Content-Type: multipart/mixed; boundary="===============6960624909808448222=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d09a2c3a207cf3f14215fc078df83b1904f7911a6b3978940a84554afaf965e9@mail.kernel.org>
In-Reply-To: <20260225092651.94689-2-pilgrimtao@gmail.com>
References: <20260225092651.94689-2-pilgrimtao@gmail.com>
Subject: Re: [PATCH v2 1/6] bpf: Introduce the bpf_list_del kfunc.
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,leon.hwang@linux.dev,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 10:22:48 +0000 (UTC)

--===============6960624909808448222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_node *node)
> +{
> +	struct bpf_list_node_kern *knode = (struct bpf_list_node_kern *)node;
> +
> +	if (unlikely(!knode))
> +		return NULL;
> +
> +	if (WARN_ON_ONCE(!READ_ONCE(knode->owner)))
> +		return NULL;
> +
> +	list_del_init(&knode->list_head);
> +	WRITE_ONCE(knode->owner, NULL);
> +
> +	return node;
> +}

Unlike bpf_list_pop_front/bpf_list_pop_back which take a
bpf_list_head argument, bpf_list_del takes only a bpf_list_node.
The list_head argument is what triggers the verifier's lock check
in __process_kf_arg_ptr_to_graph_root() via
check_reg_allocation_locked().

Since bpf_list_del has no list_head argument, the verifier path
goes through __process_kf_arg_ptr_to_graph_node() which has no
lock check. Can a BPF program call bpf_list_del without holding
the bpf_spin_lock?

Consider the following sequence:

    bpf_spin_lock(&obj->lock);
    ref = bpf_list_front(&obj->head);
    owned = bpf_refcount_acquire(ref);
    bpf_spin_unlock(&obj->lock);
    /* owned is PTR_TO_BTF_ID | MEM_ALLOC, still valid */
    bpf_list_del(&owned->node);  /* no lock held */

bpf_refcount_acquire returns an owning reference that survives
lock release. The verifier allows passing the node field of this
owning reference to bpf_list_del without any lock enforcement.

If another CPU concurrently operates on the same list under the
lock, the unprotected list_del_init here would race with those
operations and could corrupt the list.

For reference, bpf_rbtree_remove avoids this by taking both
root and node arguments, where the root triggers the lock check:

kernel/bpf/verifier.c:__process_kf_arg_ptr_to_graph_root() {
    ...
    if (check_reg_allocation_locked(env, reg)) {
        verbose(env, "bpf_spin_lock at off=%d must be held ...\n",
            rec->spin_lock_off, head_type_name);
        return -EINVAL;
    }
    ...
}

Would it make sense to add a similar lock check in
__process_kf_arg_ptr_to_graph_node() for kfuncs that only
take a node argument?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13089,6 +13093,9 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
>  		return -EINVAL;
>  	}
>
> +	if (!*node_field)
> +		*node_field = field;
> +
>  	field = *node_field;
>
>  	et = btf_type_by_id(field->graph_root.btf, field->graph_root.value_btf_id);

This is where the node_field is set for bpf_list_del. For push
operations, *node_field was already set by the list_head argument
processing in __process_kf_arg_ptr_to_graph_root (which includes
the lock check). For bpf_list_del, *node_field starts as NULL and
is set here from the node's own field, bypassing the root path
entirely and with it the lock enforcement.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22391130139

AI-authorship-score: medium
AI-authorship-explanation: Formulaic commit message style and brute-force linear scan suggest possible AI generation, but coherent cross-file BPF verifier integration shows domain understanding.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: Missing bpf_spin_lock enforcement in the verifier for bpf_list_del allows concurrent unprotected list_del_init, which can corrupt the linked list and crash the kernel.

--===============6960624909808448222==--
