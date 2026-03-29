Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4B37646C;
	Sun, 29 Mar 2026 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774795544; cv=none; b=FLqNiL53Z1zycPIXYvdtM5auipfMmZn6Ip+RAOScmi4JtV2d6CXVR5clnaYs0w+SXdlg0P5HtZh6yXjVi5lFDieKlyVFtxJsn/4jWS5U/0zurkTnoz8iprze+Senf2R1FdT4O7oQsGOQIe7EKOGbi1AhR79AGTS8o7LD+WCkvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774795544; c=relaxed/simple;
	bh=RVkbp1JwoKFigRMkCrU2BJt/HtePGZ2WrmFEhalWXqY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aSZ6xDcBdggnb4pfcVMTmSBDSYP6WmGWk2KG9DioQnx5HD8/Y8pJUIs+Hxy0JJxh6v93WmCV64K8Ly6hU41NaZWT1+eQFc7cT4RcGDlK8a5zBANellerjgXV7nYqXrSfHzv76bhCPNWQmFncoENoLaZ/bJxCUuw1APomOcL781Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVVm2xcB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVVm2xcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B625DC116C6;
	Sun, 29 Mar 2026 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774795544;
	bh=RVkbp1JwoKFigRMkCrU2BJt/HtePGZ2WrmFEhalWXqY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gVVm2xcBXi0PMWMA2b70frX2Y2Tknu/T+xqYVycoAAXFSdn0mxQ0oDF/Mu0W4UbYJ
	 8xx+YHEaKYsCq8wUFC1d/Eluajr6AQxXi5Eg++hGZnscp05G2Lj/35rNSAsDkHU0JR
	 T+IvTJ8n5SamyLfNWFEHoWza1w+xomUDFtgg+IlIMXTXOKdPTBYEmTJgKweJyV7D8F
	 e1vkH54yfrlAVgRR/d8d4Z/yTHrRi+euCoq/pmjtZ62kEEQQvDm3g0fHPQ8ES0Yk+v
	 bhAo1735Qv1/Lx5EzgHOBdlaspnDQHD5ji3OhBWSf4IOn+8+XA2v9BK/eEtaRvQVca
	 owm2YbCLKu3yA==
Content-Type: multipart/mixed; boundary="===============7307341392841228648=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <380d555cac33dac80adcd56735493f0afe0ea54360e454f8e7464a200bb5021e@mail.kernel.org>
In-Reply-To: <20260329140506.9595-4-pilgrimtao@gmail.com>
References: <20260329140506.9595-4-pilgrimtao@gmail.com>
Subject: Re: [PATCH bpf-next v9 3/9] bpf: clear list node owner and unlink before drop
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 29 Mar 2026 14:45:43 +0000 (UTC)

--===============7307341392841228648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 94fcd4ab39e9..8abb99712043 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2247,6 +2247,9 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>  	if (!head->next || list_empty(head))
>  		goto unlock;
>  	head = head->next;
> +	/* Clear owner under spinlock to ensure the owner is always valid */
> +	for (pos = head; pos != orig_head; pos = pos->next)
> +		WRITE_ONCE(container_of(pos, struct bpf_list_node_kern, list_head)->owner, NULL);
>  unlock:
>  	INIT_LIST_HEAD(orig_head);
>  	__bpf_spin_unlock_irqrestore(spin_lock);

Setting owner to NULL under lock A is good for concurrent readers
(bpf_list_front/back), but could it open a window for concurrent
writers?

After the lock is released, the drain loop below processes each node
without holding any lock. Meanwhile, if a BPF program on another CPU
holds a refcounted owning reference to one of these nodes (obtained
earlier via bpf_refcount_acquire), it can attempt __bpf_list_add to
a different list under a different lock B.

In __bpf_list_add():

    if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
        ...
    }
    list_add(n, prev);

Before this patch, owner pointed to the old list head (non-NULL), so
the cmpxchg would fail and the add would be rejected. With owner
cleared to NULL, the cmpxchg succeeds, and list_add() modifies the
node's next/prev to point into list B.

> @@ -2255,7 +2258,9 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>  		void *obj = head;
>
>  		obj -= field->graph_root.node_offset;
> +		pos = head;
>  		head = head->next;
> +		list_del_init(pos);

If the concurrent list_add above has already modified head->next, does
this drain loop then follow into list B's chain? The termination
condition (head != orig_head) would never be satisfied by list B's
nodes, and the loop would call __bpf_obj_drop_impl on list B's nodes
without holding lock B.

Would it be safer to also call list_del_init() under the spinlock
(e.g., splicing into a local list), so that nodes are fully detached
from the chain before the lock is released? The existing comment notes
that draining outside the lock avoids deadlocks from tracing programs,
but the list_del_init operations themselves should be inexpensive
compared to __bpf_obj_drop_impl.

This commit also appears to be a bug fix (addressing stale owner
pointers after drain) but does not include a Fixes: tag. The concurrent
reader issue was introduced when bpf_list_front/back was added.

Suggested tag:

    Fixes: fb5b480205ba ("bpf: Add bpf_list_{front,back} kfunc")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23710972607
--===============7307341392841228648==--
