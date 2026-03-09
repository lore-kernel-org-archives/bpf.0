Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A831077A
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038648; cv=none; b=lhJLUXoem78VjsLNcsGUPpRrq+Pz++U8knHBgxt9/+8faSX/0nWphpB7aMUssIlYZjl7OE+M0gm9ANlR1BhHDfqkSdMToJI+uE8+Q3/3uenZHGdl4iMLzw5joJN1/7BtQiJwbB7MsxvuDLfjHxl0j4eH+H8nGjA91RW7xR0tEXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038648; c=relaxed/simple;
	bh=i4XPAdJnPZ/xPclSdynzuYErp+zmE12wOPhtNQo1gww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn36JngcaxNFKYsTHX7ekC1yPG2l94lnipLW/Wi4go485qSmIWub22i0g8nwrCz85ba1Ns8Tk3dvbmqsmDYaAwZ0GEC7NfvG7LrAf2ZSFFK2lKJml+T3HwGs076Xkq7Mne1nNyUBU/Ui9gxFFRWzvEvOF72n5Vkx6u/AZSxCqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d/tYZr/D; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d/tYZr/D"
Message-ID: <4f40d120-41d1-4723-a410-63d095d2b31d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773038645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsKqNm75ziOMXjHylnDTr26Keea6DiD9cYdsbvAljTk=;
	b=d/tYZr/DiCULiK56Zm2vV+UQl54JzwYe/hr7F8QqVHaMeX4mFP78LqaWLvbyWOJcPM40H5
	Ee2TCYPmYMjweSOh13hxMIOiRrY4SdFuOrhfku2Kd/oGW+AU/KKYiql4enxYYZxH6vm/XA
	TFfg+t9EZzGMKiXDeg7ZswPgIB81Z/g=
Date: Mon, 9 Mar 2026 14:43:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 4/5] selftests/bpf: Add test cases for
 bpf_list_del/add/is_first/is_last/empty
Content-Language: en-US
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260308134614.29711-1-pilgrimtao@gmail.com>
 <20260308134614.29711-5-pilgrimtao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260308134614.29711-5-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/26 21:46, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> Extend the refcounted_kptr test: add a node to both an rbtree and a
> list, retrieve the node from the rbtree to obtain the node pointer,
> then add a new node after the first in the list, and finally use
> bpf_list_del to remove both nodes.
> 
> The test asserts that the list is non-empty after insert, asserts the
> first and last nodes after bpf_list_add, and asserts that the list is
> empty after removing both nodes.
> 
> To verify the validity of bpf_list_del/add, the test also expects the
> verifier to reject calls to bpf_list_del/add made without holding the
> spin_lock.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  |  16 ++
>  .../selftests/bpf/progs/refcounted_kptr.c     | 140 ++++++++++++++++++
>  2 files changed, 156 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 4b7210c318dd..005ca9d84677 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -85,6 +85,22 @@ extern int bpf_list_push_back_impl(struct bpf_list_head *head,
>  /* Convenience macro to wrap over bpf_list_push_back_impl */
>  #define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, node, NULL, 0)
>  
> +/* Description
> + *	Insert 'new' after 'prev' in the BPF linked list with head 'head'.
> + *	The bpf_spin_lock protecting the list must be held. 'prev' must already
> + *	be in that list; 'new' must not be in any list. The 'meta' and 'off'
> + *	parameters are rewritten by the verifier, no need for BPF programs to
> + *	set them.
> + * Returns
> + *	0 on success, -EINVAL if head is NULL, prev is not in the list with head,
> + *	or new is already in a list.
> + */
> +extern int bpf_list_add_impl(struct bpf_list_head *head, struct bpf_list_node *new,
> +			     struct bpf_list_node *prev, void *meta, __u64 off) __ksym;
> +
> +/* Convenience macro to wrap over bpf_list_add_impl */
> +#define bpf_list_add(head, new, prev) bpf_list_add_impl(head, new, prev, NULL, 0)
> +
>  /* Description
>   *	Remove the entry at the beginning of the BPF linked list.
>   * Returns
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> index 1aca85d86aeb..c2defa991acd 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -367,6 +367,146 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
>  INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
>  INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
>  
> +/*
> + * Insert one node in tree and list, remove it from tree, add a second node
> + * after it with bpf_list_add, check bpf_list_is_first/is_last/empty, then
> + * remove both nodes from list via bpf_list_del.
> + */
> +SEC("tc")
> +__description("list_add_del_and_check: test bpf_list_add/del/is_first/is_last/empty")
> +__success __retval(0)
> +long list_add_del_and_check(void *ctx)
> +{
> +	long err = 0;
> +	struct bpf_rb_node *rb;
> +	struct bpf_list_node *l_node, *l_node_ref;
> +	struct node_data *n_rb, *n_new, *n_new_ref;
> +

Prefer inverted Christmas tree style.

> +	err = __insert_in_tree_and_list(&head, &root, &lock);
> +	if (err)
> +		return err;
> +
> +	bpf_spin_lock(&lock);
> +	/* Test1: bpf_list_empty */
> +	if (bpf_list_empty(&head)) {
> +		bpf_spin_unlock(&lock);
> +		return -4;
> +	}
> +
> +	rb = bpf_rbtree_first(&root);
> +	if (!rb) {
> +		bpf_spin_unlock(&lock);
> +		return -5;
> +	}
> +
> +	rb = bpf_rbtree_remove(&root, rb);
> +	bpf_spin_unlock(&lock);
> +	if (!rb)
> +		return -6;
> +
> +	n_rb = container_of(rb, struct node_data, r);
> +	n_new = bpf_obj_new(typeof(*n_new));
> +	if (!n_new) {
> +		bpf_obj_drop(n_rb);
> +		return -7;
> +	}
> +	n_new_ref = bpf_refcount_acquire(n_new);
> +	if (!n_new_ref) {
> +		bpf_obj_drop(n_rb);
> +		bpf_obj_drop(n_new);
> +		return -8;
> +	}
> +
> +	bpf_spin_lock(&lock);
> +	/* Test2: bpf_list_add */
> +	if (bpf_list_add(&head, &n_new->l, &n_rb->l)) {
> +		bpf_spin_unlock(&lock);
> +		bpf_obj_drop(n_rb);
> +		bpf_obj_drop(n_new_ref);
> +		return -9;
> +	}
> +
> +	/* Test3: bpf_list_is_first/is_last */
> +	if (!bpf_list_is_first(&head, &n_rb->l) ||
> +	    !bpf_list_is_last(&head, &n_new_ref->l)) {
> +		bpf_spin_unlock(&lock);
> +		bpf_obj_drop(n_rb);
> +		bpf_obj_drop(n_new_ref);
> +		return -10;
> +	}
> +
> +	/* Test4: bpf_list_del */
> +	l_node = bpf_list_del(&head, &n_rb->l);
> +	l_node_ref = bpf_list_del(&head, &n_new_ref->l);
> +	bpf_spin_unlock(&lock);
> +	bpf_obj_drop(n_rb);
> +	bpf_obj_drop(n_new_ref);
> +
> +	if (l_node)
> +		bpf_obj_drop(container_of(l_node, struct node_data, l));
> +	else
> +		err = -11;
> +
> +	if (l_node_ref)
> +		bpf_obj_drop(container_of(l_node_ref, struct node_data, l));
> +	else
> +		err = -12;
> +
> +	bpf_spin_lock(&lock);
> +	/* Test5: bpf_list_empty */
> +	if (!bpf_list_empty(&head))
> +		err = -13;
> +	bpf_spin_unlock(&lock);
> +	return err;
> +}
> +

Could you split this test into 5 tests?

More easily to understand the purpose of tests with fewer lines.

Thanks,
Leon

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
> +	bpf_spin_unlock(&lock);
> +	if (!rb)
> +		return -1;
> +
> +	n = container_of(rb, struct node_data, r);
> +	/* Error case: delete list node without holding lock */
> +	l = bpf_list_del(&head, &n->l);
> +	if (!l)
> +		return -2;
> +	bpf_obj_drop(container_of(l, struct node_data, l));
> +
> +	return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("bpf_spin_lock at off=32 must be held for bpf_list_head")
> +long list_add_without_lock_fail(void *ctx)
> +{
> +	struct bpf_rb_node *rb;
> +	struct bpf_list_node *l;
> +	struct node_data *n;
> +
> +	bpf_spin_lock(&lock);
> +	rb = bpf_rbtree_first(&root);
> +	l = bpf_list_front(&head);
> +	bpf_spin_unlock(&lock);
> +	if (!rb || !l)
> +		return -1;
> +
> +	n = container_of(l, struct node_data, l);
> +	/* Error case: add list node without holding lock */
> +	if (bpf_list_add(&head, &n->l, l))
> +		return -2;
> +
> +	return 0;
> +}
> +
>  SEC("tc")
>  __success
>  long rbtree_refcounted_node_ref_escapes(void *ctx)

