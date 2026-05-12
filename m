Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37843368D45;
	Tue, 12 May 2026 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568078; cv=none; b=FzKjx7LAiXfH1VSkGZ3TDybGJZZ65z/k4wYLJP1tP0gkhJU+GUM039bCnlOvUlRwXvMzLKNrB05qDMQTvhLiXqDCA3YzZ6Kua2ihWY/i0b03BY9D3SSF+qbFZkqbrnhic8Lhzz+OzHPQKCpgxruKUUl2bGgoCcCMinYupRxofzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568078; c=relaxed/simple;
	bh=KZCs2IEve65XxsroLrtak+nYoUQ+rbx2jEYDQ/eJzg0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=L2wD2O3gt7V2lHjB2XaVuz9Ld5fI8Nmpz8AmP225pIYBqjNo5HeFCCHstSfiB5u58rO0HFaddnSQppR6WYas1zLBGoxtDXcPKwmNMUyaRJR6KzBgmqA6QGRk2lWkcDXK7DSNtsZa+qTEoGoXRtw4wm+Sg7wc/zJAZD/jq7uDw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swqL9yDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swqL9yDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996F3C2BCB8;
	Tue, 12 May 2026 06:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778568076;
	bh=KZCs2IEve65XxsroLrtak+nYoUQ+rbx2jEYDQ/eJzg0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=swqL9yDaU6ybiCrG0aIaP5Gq6wf7IqjvvqhhVlrm4Wu6hOnszI4/wH5yL+V0xu+Z1
	 YN2K2DCYHA0aEWLgkis8U0srNUiryhT3vWGZpdjFCSnuOcZW63r8Yf6csgQb6pFwSw
	 6GfdTcypXfgGzmwnQ6GeYhyDAHlJx0oOrpnYdy+ZaRWQqcUD8ixrP7UsBmgwrdWOk8
	 hw7r+sqkwOUtAwl2eMH29qf4wGs7fdpoFnJ7TF3ik7XOwQVBqzirzNEWdbELrOZEFx
	 YvnZHTO/RVuMGUnHmCPxclCf0TEBWvD5fCv3iRs9nTnJ80NvYoNRCVdcCRQ7Z9mv1b
	 i5aU9kXhlUwUQ==
Content-Type: multipart/mixed; boundary="===============8980568653896192434=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <297a19ac8fb5fc8ab279a932137bf39604f2f3637521ff6d7d4b39c364a52e07@mail.kernel.org>
In-Reply-To: <20260512055919.95716-4-kaitao.cheng@linux.dev>
References: <20260512055919.95716-4-kaitao.cheng@linux.dev>
Subject: Re: [PATCH RESEND bpf-next v10 3/8] bpf: Introduce the bpf_list_del kfunc.
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,ast@kernel.org,corbet@lwn.net,martin.lau@linux.dev,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,skhan@linuxfoundation.org,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-doc@vger.kernel.org,vmalik@redhat.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 12 May 2026 06:41:14 +0000 (UTC)

--===============8980568653896192434==
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
> +

Looking at bpf_list_pop_front() and bpf_list_pop_back() in the same
file, both functions read from the list_head (h->next or h->prev)
before passing it to __bpf_list_del(). If the list is uninitialized,
they end up passing potentially invalid pointer values to __bpf_list_del(),
which then has to handle this by initializing the list and returning NULL.

While __bpf_list_del() handles this correctly, would it be clearer to
move the initialization check into the top-level kfuncs (like
bpf_list_pop_front/back) so that __bpf_list_del() always receives a
valid list_head pointer rather than potentially garbage values that
get ignored later?

Reference: https://lore.kernel.org/bpf/af50d188f6bc2de81fe3c321b26a645a9425ba9f2644cb6f8525d5bb637385f9@mail.kernel.org/

> @@ -4725,6 +4734,7 @@ BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
>  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 11054ad89c14..a6bcbe68cd72 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10744,6 +10744,7 @@ enum special_kfunc_type {
>  	KF_bpf_list_push_back,
>  	KF_bpf_list_pop_front,
>  	KF_bpf_list_pop_back,
> +	KF_bpf_list_del,
>  	KF_bpf_list_front,
>  	KF_bpf_list_back,
>  	KF_bpf_cast_to_kern_ctx,

[ ... ]

> @@ -11456,7 +11459,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>
>  	switch (node_field_type) {
>  	case BPF_LIST_NODE:
> -		ret = is_bpf_list_push_kfunc(kfunc_btf_id);
> +		ret = is_bpf_list_push_kfunc(kfunc_btf_id) ||
> +		      kfunc_btf_id == special_kfunc_list[KF_bpf_list_del];
>  		break;
>  	case BPF_RB_NODE:
>  		ret = (is_bpf_rbtree_add_kfunc(kfunc_btf_id) ||

Can bpf_list_del actually be called from BPF programs? Looking at the
verifier's handling of KF_ARG_PTR_TO_LIST_NODE arguments in
check_kfunc_args():

	case KF_ARG_PTR_TO_LIST_NODE:
		...
		if (!reg->ref_obj_id) {
			verbose(env, "allocated object must be referenced\n");
			return -EINVAL;
		}

This code path unconditionally requires an owning reference (ref_obj_id
must be non-zero). However, once a node is added to the list via
bpf_list_push_front/back, the owning reference is converted to a
non-owning reference (ref_obj_id becomes 0). This means bpf_list_del
cannot be called on nodes that are actually in the list.

The sister kfunc bpf_rbtree_remove handles this by having a special
branch in check_kfunc_args() that accepts non-owning references for
that specific kfunc. Does bpf_list_del need similar handling to allow
removing nodes that are actually in the list?

Reference: https://lore.kernel.org/bpf/294242698d576e4fedf243ab055c6f9a984e55033933a9bd09808f62a7018e9d@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25716874656
--===============8980568653896192434==--
