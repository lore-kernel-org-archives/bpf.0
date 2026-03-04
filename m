Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EBF34D38D
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638996; cv=none; b=QcrJFGklkbH/40RhExVRkl1s3kVyNrmuVrXyNvw92DGrKl2rVOwC/4MLlqKR6Ks4jikCeOg5BJbHxzZUGG3bl5XWPzMtTvzRNSS21SXmBBh1rN/OrIlFrcc3FVearVciY3AoDnlm369tBvDulqGNdli3UPxM5YnvVM5tDKPGi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638996; c=relaxed/simple;
	bh=8qECvAMQIaJBQwNMYa/jdZgoxh1N5I+/3F8YghqJ9PQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iGbAHPPFR09ljbBoiSmF/F3bI9m2KmzZ78qTT2tVt+b4ts0fVOGPep35f7KMZISLvlu6ri/Q19wYDCvm4JrqNozsq5EDLG8k3HMaJSZkH0qUwQUUMPAgQNV0rAGVKh6B4cuMjYDrK+hhpmArLkTVWb6GFprnv9SSpN1ssqvwUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxzztYot; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxzztYot"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b790af67so2069233f8f.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772638993; x=1773243793; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0ikYOmTgcPaP2qaHYSHDWasHLTaPAYvwIqfm9N3sK4=;
        b=kxzztYotAZf0xZ5CFdrH4096LWMJNgmZywWCiPxKDABiSkji7ljju0Z2NSiU90fDj+
         dfIwXIUSWQ1utr1pRI6pGKBNYHpsDDO2xG++ofwirHOimC1LAStP+99TOopSn8GHS9Cm
         1K8iEgYLW44i15gZ1FM722RC9rE73CLKvGbgpn802t+GLepevOdBam53rNDQtpu9WzgV
         coUHe5F2675YFKuqu2jLDef/4DiEISOGegNX9enFYf1Xgmi2je/GKIdhTkmCaVXAsNNT
         3hY0pY3DtTOzIePvOZiWi6giBtKt362Lp+N0bH+bM2ALykBug+zOa9EZxaGzVa0Ok+Cz
         Qo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638993; x=1773243793;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0ikYOmTgcPaP2qaHYSHDWasHLTaPAYvwIqfm9N3sK4=;
        b=nriBHwe7x8tzxQH2CI5xhqSc7T4/y68OCmzNwTRSkLnsFWI77JTmxmLtU2QzfbExA1
         BWOEQ9cTy61M0TkAlXVCV3SXGdlsIl3bGnNJEJBx+pQuRq1LLYGHWY5XRBicXcaGluzP
         MN8EpZiXV1pvhuCKRiH3qt7nmfN/3yAr9WpKJgioo2ZB5ZvTiJPcJnnWBKKnjK64GWo+
         nc7r4VgAU+OxTrGoX/4cfoKF0Wy7mJ/pZZK+xSpQSrypXNd507v9mdBLFOo+e4vLQycn
         +GSZTMkZ3TG3AHa3LbZdQzB/MZacMprHPJxS024vwJjkEDmJF9spvqtOGx5JuAD/gUHU
         RhGg==
X-Gm-Message-State: AOJu0YyGs5iMBBcsK38ha19dTqwtZ9Blb08LG9tP1zoW6a4xgwdRb+2h
	9dLnTQjPR23b9rRqIR0I+4u/qfDzp9hrD9Y4Ge66LmKOgic2P1URXfed
X-Gm-Gg: ATEYQzxR0qcrefwaSqfXi7u4jdkx6r0yUNoQxbC8zmHEoJEqIPNOSAaZLfqvXj20Irx
	O2XkVCSBW3aD4QNTKO0BNO4lQtHEmnXUHeHJjjQwZ6eFQq25U3qcTqmiOaQMsELmsP1CasAfL5k
	t5IVBmLfiudkwhdxwjyCljwRSN0z1v4JBEP5LLpKnvs9uNXtETPCs5riwdthh/yyWXx/BtbJYtG
	QhiRoOnvEWnjYP8UCqbMp0dmwuaTggyWvJ8MFi8if9cCKCkQxu6lpfkYiOVG7wIWYUtg7UkC8vh
	BrPgzeX68DoMFVmCZTSRqFTTU0gqEj05Qp8wqvzuqelUnRjLomnRV9XR5auMfEyUeDXS1z/afCV
	8jWrnq0tltvSSHFa9b4qXTp3qrOlIeMLCsWa1TfirbiuG1M3IX2r3ZDqXtVQ6Zmqk2doerZy+cv
	PeWw3/dKz1KQQbeGdgkVO5/tampUZcf5v819ipqA==
X-Received: by 2002:a5d:588a:0:b0:439:b79d:b9a6 with SMTP id ffacd0b85a97d-439c10adc38mr12284357f8f.11.1772638993132;
        Wed, 04 Mar 2026 07:43:13 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c2f7eca1sm10099102f8f.11.2026.03.04.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:43:12 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] selftests/bpf: Add test cases for bpf_list_del
In-Reply-To: <20260304031606.43884-3-pilgrimtao@gmail.com>
References: <20260304031606.43884-1-pilgrimtao@gmail.com>
 <20260304031606.43884-3-pilgrimtao@gmail.com>
Date: Wed, 04 Mar 2026 15:43:12 +0000
Message-ID: <87zf4ny50v.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chengkaitao <pilgrimtao@gmail.com> writes:

> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Add a node to both an rbtree and a list, retrieve the node from
> the rbtree, use the obtained node pointer to remove it from the
> list, and finally free the node.
>
> To verify the validity of bpf_list_del, also expect the verifier
> to reject calls to bpf_list_del made without holding the spin_lock.
>
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
Do we need to craft those error return codes in the program that is
supposed to be rejected by verifier. Can we implement a minimal code
that triggers the verifier error without all unnecessary noise.
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
> -- 
> 2.50.1 (Apple Git-155)
