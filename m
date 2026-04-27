Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B071374E5C;
	Mon, 27 Apr 2026 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315425; cv=none; b=qvVj8bvCkfmKzxPHpmjKR9iao8V6EalooFLpLutqkwcMGtaJRyt1DxI1S/HNi0hC8g3qMAkv7ER/uoZXBaJHEwejFVCmJ+6z59qDv98hyhvpMsMHZ3xRtABYdeMLXFxJDs6Yv/RsS82Uzq/jy4wzHB/HZPRLlDrC8E6fGIYsocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315425; c=relaxed/simple;
	bh=gFq6eCi+6+ZmtrzgeB3MUBggxNppsr6nQxll1jB6ap8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Aua+e0qBqELDZ2ojVY5H4iERWp85b/i1QP1MT79JQ/3YVcrDpkOVvcU3SnWjEJ/G8X3dxqF8SUDL/UHghREtH9AUWcoVLeVNZKHheX8oyLFDuhgvnVoZremUOkH2tKO5bbWULzDf68z3SA7sSon+Ij5+O/ssv41VclWvtbXW+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt3pT0Ts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt3pT0Ts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F540C2BCB5;
	Mon, 27 Apr 2026 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777315425;
	bh=gFq6eCi+6+ZmtrzgeB3MUBggxNppsr6nQxll1jB6ap8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dt3pT0Tsmlq5sHyNxGuv/G9ayl2UWpoQ5X5U6uAtAZUGH5dfW3oLRLNK/x2ESvtZc
	 CThK8RV6qIierbj3O2wMQtrMADwMcY2obJt/7k+ip/JNlgFyxT17OhYZyTYmn4GBJo
	 zUlx6Fh8lXq+fMWwzY+p/v+RAucJOqnvAsaVY5wvRjtGnwBZIMtR6eaawmCTeruC+q
	 dCq2iRGoylf3HVkTczxh5t51jd3eU8lyHiL55rZvkzB6f5erNIPzLLjAGHzfglrgXa
	 dGCvGUNdM15uk2Mpen58QCD2nIDoVaPBK3OMgVrOp7U9ttHEBoPwVz84NoQrGFn3d/
	 DCT7jYQOtIGNw==
Content-Type: multipart/mixed; boundary="===============5137837707719433631=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <294242698d576e4fedf243ab055c6f9a984e55033933a9bd09808f62a7018e9d@mail.kernel.org>
In-Reply-To: <20260427165906.84420-4-kaitao.cheng@linux.dev>
References: <20260427165906.84420-4-kaitao.cheng@linux.dev>
Subject: Re: [PATCH bpf-next v10 3/8] bpf: Introduce the bpf_list_del kfunc.
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Apr 2026 18:43:44 +0000 (UTC)

--===============5137837707719433631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1e8754877dd1..51b6ea4bb8cb 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2593,6 +2593,15 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
>  	return __bpf_list_del(head, h->prev);
>  }
>
> +__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
> +					       struct bpf_list_node *node)
> +{
> +	struct bpf_list_node_kern *kn = (void *)node;
> +
> +	/* verifier guarantees node is a list node rather than list head */
> +	return __bpf_list_del(head, &kn->list_head);
> +}

Can this kfunc actually be called from any BPF program? Looking at the
verifier's handling of KF_ARG_PTR_TO_LIST_NODE arguments in
check_kfunc_args():

    case KF_ARG_PTR_TO_LIST_NODE:
        if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
            verbose(env, "%s expected pointer to allocated object\n", ...);
            return -EINVAL;
        }
        if (!reg->ref_obj_id) {
            verbose(env, "allocated object must be referenced\n");
            return -EINVAL;
        }

This code path unconditionally requires an owning reference (ref_obj_id
must be non-zero).

However, once a node is added to the list via bpf_list_push_front/back,
the owning reference is converted to a non-owning reference
(ref_obj_id becomes 0) via ref_convert_owning_non_owning() and the
original owning reference is released. Any subsequent access to that
in-list node (including via bpf_list_front/back) only provides
non-owning references with ref_obj_id == 0.

This means:
  - Passing a non-owning ref to bpf_list_del() fails the verifier's
    "!reg->ref_obj_id" check with "allocated object must be referenced"
  - Passing an owning ref to a node not yet in the list passes the
    verifier check, but __bpf_list_del() will return NULL because
    node_kern->owner != head

The sister kfunc bpf_rbtree_remove handles this by having a special
branch in check_kfunc_args() that accepts non-owning references for
that specific kfunc. Does bpf_list_del need similar handling?

Looking at __bpf_list_del() in kernel/bpf/helpers.c:

	node = container_of(n, struct bpf_list_node_kern, list_head);
	if (unlikely(READ_ONCE(node->owner) != head))
		return NULL;

Emil Tsalapatis and the Sashiko review bot raised concerns about
removing the WARN_ON_ONCE that was in v8 of this series. The original
WARN_ON_ONCE helped detect list corruption by triggering a kernel
warning when owner != head. The current unlikely() check silently
returns NULL instead.

Should this check trigger a warning for debugging list corruption issues?

Additionally, the Sashiko review noted a reuse bug: when
bpf_list_head_free() is called on a list that still contains elements,
those elements remain allocated but their owner field still points to
the now-freed head. Since the owner field is checked but never cleared,
could this lead to dangling pointer issues if nodes aren't freed
properly during list cleanup?

> @@ -4725,6 +4734,7 @@ BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
>  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25009536772
--===============5137837707719433631==--
