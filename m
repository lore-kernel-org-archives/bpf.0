Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396DD3659F7
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594887; cv=none; b=iG9S/sjofIXoAi73MYfiHW64W2nH40c5hniaBTuH1p7TA6v6UJWujJ+a439dygPsidqvy1Ir08Q4ERjeBbbIwynVHdmCXpqDPB71xy/SmN5t8vCyritECgvjXQgM9khUEZD6ra/PsQ7fk1NGjUZxL4S2IsY2FGYkFZrnqAu6awk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594887; c=relaxed/simple;
	bh=d8eoFkHM4D6/Dpaab+GEZKCQGAypRKh84399coykE+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ez3MOaEqQ4UrtI+fw52iXRbeuGXk+DS/ktliyTNBz3ykIUDuGo386TTGtVP1So+U4nkXC7ts7eKfC8SVQDxckcFW3JL8FRoewMz49ZCAiR53YhXGRaolLpXn4k6KB+nVxhwRWBQse0R6mo0kLw6cM2BIo6J6dQnGgZZdOxrUXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mftM4Wkz; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mftM4Wkz"
Message-ID: <c13cc186-4692-4708-8185-e7117f6100e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772594884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+mRUsZBs/BM4EhW+Hrz6HfcXatQFRe2Y+5hT+7Ec6U=;
	b=mftM4WkztOWRqdvi4RgIng4cGkaUxxl5s7NGxb0l53rLfIVeGtuP+bOWAOb80DvxXMSG+N
	EteND13CZHk99PV4rsWB02WQadXqSvcsrt5mJWvSlF3K9QtgKAoPn7iqE9KE3dtCXrTnov
	DeGdYNYdu99T/IPCXWTUY66nleWwXhg=
Date: Wed, 4 Mar 2026 11:27:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/6] selftests/bpf: Add test cases for bpf_list_del
Content-Language: en-US
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260303135219.33726-1-pilgrimtao@gmail.com>
 <20260303135219.33726-3-pilgrimtao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260303135219.33726-3-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/3/26 21:52, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> Add a node to both an rbtree and a list, retrieve the node from
> the rbtree, use the obtained node pointer to remove it from the
> list, and finally free the node.
> 
> To verify the validity of bpf_list_del, also expect the verifier
> to reject calls to bpf_list_del made without holding the spin_lock.
> 

To avoid the churn of renaming test_bpf_list_del() in patch #4, it would
be better to fold patches #2, #4, and #6 into one patch.

Thanks,
Leon

> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  | 11 +++
>  .../selftests/bpf/progs/refcounted_kptr.c     | 71 +++++++++++++++++++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 4b7210c318dd..54ec9d307fdc 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -99,6 +99,17 @@ extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ks
>   */
>  extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
>  
> +/* Description
> + *	Remove 'node' from the BPF linked list with head 'head'.
> + *	The node must be in the list. Caller receives ownership of the
> + *	removed node and must release it with bpf_obj_drop.
> + * Returns
> + *	Pointer to the removed bpf_list_node, or NULL if 'node' is NULL
> + *	or not in the list.
> + */
> +extern struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
> +					  struct bpf_list_node *node) __ksym;
> +
>  /* Description
>   *	Remove 'node' from rbtree with root 'root'
>   * Returns
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> index 1aca85d86aeb..ac7672cfefb8 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -367,6 +367,77 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
>  INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
>  INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
>  
> +/* Insert node_data into both rbtree and list, remove from tree, then remove
> + * from list via bpf_list_del using the node obtained from the tree.
> + */
> +SEC("tc")
> +__description("test_bpf_list_del: remove an arbitrary node from the list")
> +__success __retval(0)
> +long test_bpf_list_del(void *ctx)
> +{
> +	long err;
> +	struct bpf_rb_node *rb;
> +	struct bpf_list_node *l;
> +	struct node_data *n;
> +
> +	err = __insert_in_tree_and_list(&head, &root, &lock);
> +	if (err)
> +		return err;
> +
> +	bpf_spin_lock(&lock);
> +	rb = bpf_rbtree_first(&root);
> +	if (!rb) {
> +		bpf_spin_unlock(&lock);
> +		return -4;
> +	}
> +
> +	rb = bpf_rbtree_remove(&root, rb);
> +	if (!rb) {
> +		bpf_spin_unlock(&lock);
> +		return -5;
> +	}
> +
> +	n = container_of(rb, struct node_data, r);
> +	l = bpf_list_del(&head, &n->l);
> +	bpf_spin_unlock(&lock);
> +	bpf_obj_drop(n);
> +	if (!l)
> +		return -6;
> +
> +	bpf_obj_drop(container_of(l, struct node_data, l));
> +	return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("bpf_spin_lock at off=32 must be held for bpf_list_head")
> +long list_del_without_lock_fail(void *ctx)
> +{
> +	struct bpf_rb_node *rb;
> +	struct bpf_list_node *l;
> +	struct node_data *n;
> +
> +	bpf_spin_lock(&lock);
> +	rb = bpf_rbtree_first(&root);
> +	if (!rb) {
> +		bpf_spin_unlock(&lock);
> +		return -4;
> +	}
> +
> +	rb = bpf_rbtree_remove(&root, rb);
> +	bpf_spin_unlock(&lock);
> +	if (!rb)
> +		return -5;
> +
> +	n = container_of(rb, struct node_data, r);
> +	l = bpf_list_del(&head, &n->l);
> +	bpf_obj_drop(n);
> +	if (!l)
> +		return -6;
> +
> +	bpf_obj_drop(container_of(l, struct node_data, l));
> +	return 0;
> +}
> +
>  SEC("tc")
>  __success
>  long rbtree_refcounted_node_ref_escapes(void *ctx)

