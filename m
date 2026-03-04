Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2034EEEE
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638828; cv=none; b=lrLXmfy7AIYW6e//aZZE75HSumxyrMRaRls/G6rYt4mmCW/M5Ps9yzz3gSSwq5U3gyKD4zoC3YNykHWeIVfG13qYjaA5hHvz7Eg0LA3cJrete2JZFnV1DCfMClMMUJRChrD/9oSIEsJwSes2bUb8pU+2jB+9JuIE6K51PkvwzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638828; c=relaxed/simple;
	bh=k2nBFpS9fppSZ+E+YPtXIaO9vEZ0zeTUV9rFMO63JgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X053i6y2FWFbH6SvwZvL8JaiQKuOQWRRj1QImC0/wu0UBdzJMI1Suqj1K4cufjYKWhbN1ZgeO2jbe2L6oa2/u5thydwsBkErCCBXGpT8OgJ8QyvTz8QT+Hmbb8wrrA831xDpAcVOypzicdcJnRG5wVtYNUlID5Z/rTd6tpLtflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvgpTGho; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvgpTGho"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48372efa020so62175615e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 07:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772638825; x=1773243625; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nqRZvA6ar4NE2XUljdnWCP0iRfuf99S4MTbfk/iA4c=;
        b=JvgpTGho1/83VyRMC0VDO4xrnlsDRm9ZtPv8Q2qczyOb7RuFEDxe+AQ6cgnE+YEB5N
         0yAJmJjCFYh8O6Z28FG5IaFe0VQBXs6KmqxVFxqhYF/6C9KvSdfkXKRG2yDUmtAJd5uE
         TD8f1S05i3iU6HT28Jad6sNiH4tYoZI57UCbIJlaFC9JT2na1WVWa2ADcUJ5BdsMpjmh
         KQ4DiYKYZ7HsryA+GKz+ZuHpvdOF2QFoCpNABCWHLgO/yfZgNGtT3hh+r2rmYrU1Q/Sq
         4KfIqPa9gt1dMr2WMVSAk1uW1BSoRmKkEwR+nJQSdHsjP9JdA44FaONb296uIM2ks+NI
         GQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638825; x=1773243625;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nqRZvA6ar4NE2XUljdnWCP0iRfuf99S4MTbfk/iA4c=;
        b=tG5axtB2Qigrrg9ED2ecznyMdVRXOTN2OeqNsX3ErOuoC/SUsjDyfYNgKTlXKTV1YA
         SYTK5fy/HTW9aRpBy/7INkQWwGGL/ZAG0StC1eQ3fDF4/ISGQ1BJDkbKkhnd4o9BL9i8
         cMxOqCpdGSYeLrBoYH+UhL3XPzmlL3L6gKdcDk2F7eBHKFJkPzsDgorSj0bhtEu3qETZ
         bZg13BA501TguPGs3XwdnD+DQXS4hEjEX2M2BUR8OfUhRbZ7CMn8AW2p0baJGO2gy+uL
         /Q71MlijrVU2j8zwAuHV33RFxkH3cK5Ibsy9xLY1c//9bnvJnp8eGsLT+nlauqxqlT4b
         UQYg==
X-Gm-Message-State: AOJu0YzMW/tWcPT88tx8pn34MDcXK04BnKB0mEGuirhlCHTbCY8jrDDJ
	fHvsbxsSJQ9cd3MXZ5pkN2djhWhuQCw2RqqPRZwZRFmYfGMpdGoxR8DD
X-Gm-Gg: ATEYQzy649ApPRXHXeyfggFW0Q7DGqlivkvVQEUpaZkHq6JtoOUxNbqgcZRcO4CW1cG
	EUKFZJMCiC71LcAkWUlOe8imwdP2zJ1pis84yIpXoyDs0HCx8M+zXFM4VBHxsog7OVky3pEV9it
	39peeAW1o7o8w4/Ste3Mwoz6zPMlyAyTSd+G9h7+U4/tNWq807/FPvxr5MYVBkmBai7baOPihMI
	EH2RXFo48KOTp8okw72nLveGzzICwD82ZH8ucs1g4jaeAcBwVHclD8xPpUzuCNZ+xwg6oICmoVl
	MFkuzuJL4AInhJ2F76UDnq5fw/aKkj+qYGlnVeNoYRL6Qw5kivMZ5qKKwu8zOBq6EW1OMZ1JVel
	D3MKo2q1hf0LA2yKxfB8zG3D8COaQ3OyjpTX8Pl4xsR6WbR/WhLbw8/dZQlESOiYuxrY8LIFJaP
	q7F4clf1Mvxdoepc+k8rHz3+vgbLeuz7FYxr25gQ==
X-Received: by 2002:a05:600c:4e51:b0:483:7783:5373 with SMTP id 5b1f17b1804b1-4851988ce8fmr42377075e9.23.1772638824824;
        Wed, 04 Mar 2026 07:40:24 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187b7851sm102849015e9.3.2026.03.04.07.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:40:24 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] selftests/bpf: Add test case for bpf_list_add_impl
In-Reply-To: <20260304031606.43884-5-pilgrimtao@gmail.com>
References: <20260304031606.43884-1-pilgrimtao@gmail.com>
 <20260304031606.43884-5-pilgrimtao@gmail.com>
Date: Wed, 04 Mar 2026 15:40:23 +0000
Message-ID: <87342fzjq0.fsf@gmail.com>
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
> Extend refcounted_kptr test to exercise bpf_list_add:
> add a second node after the first, then bpf_list_del both nodes.
>
> To verify the validity of bpf_list_add, also expect the verifier
> to reject calls to bpf_list_add made without holding the spin_lock.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  |  16 +++
>  .../selftests/bpf/progs/refcounted_kptr.c     | 122 ++++++++++++++++--
>  2 files changed, 124 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 54ec9d307fdc..fdcc7a054095 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -110,6 +110,22 @@ extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksy
>  extern struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
>  					  struct bpf_list_node *node) __ksym;
should this be available from vmlinux.h?
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
>   *	Remove 'node' from rbtree with root 'root'
>   * Returns
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> index ac7672cfefb8..5a83274e1d26 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -367,18 +367,19 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
>  INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
>  INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
>  
> -/* Insert node_data into both rbtree and list, remove from tree, then remove
> - * from list via bpf_list_del using the node obtained from the tree.
> +/* Insert one node in tree and list, remove it from tree, add a second
Use kernel comment style: first line is just "/*" then text starts from
the next one.
> + * node after it in list with bpf_list_add, then remove both nodes from
> + * list via bpf_list_del.
>   */
It sounds like the new test is quite different from the previous, why
not add a separate test running new codepaths instead of retrofitting
into the existing test?
>  SEC("tc")
> -__description("test_bpf_list_del: remove an arbitrary node from the list")
> +__description("test_list_add_del: test bpf_list_add/del")
>  __success __retval(0)
> -long test_bpf_list_del(void *ctx)
> +long test_list_add_del(void *ctx)
>  {
> -	long err;
> +	long err = 0;
>  	struct bpf_rb_node *rb;
> -	struct bpf_list_node *l;
> -	struct node_data *n;
> +	struct bpf_list_node *l, *l_1;
> +	struct node_data *n, *n_1, *m_1;
nit: The naming scheme is a little bit confusing.
>  
>  	err = __insert_in_tree_and_list(&head, &root, &lock);
>  	if (err)
> @@ -392,20 +393,48 @@ long test_bpf_list_del(void *ctx)
>  	}
>  
>  	rb = bpf_rbtree_remove(&root, rb);
> -	if (!rb) {
> -		bpf_spin_unlock(&lock);
> +	bpf_spin_unlock(&lock);
> +	if (!rb)
>  		return -5;
> -	}
>  
>  	n = container_of(rb, struct node_data, r);
> +	n_1 = bpf_obj_new(typeof(*n_1));
> +	if (!n_1) {
> +		bpf_obj_drop(n);
> +		return -1;
> +	}
> +	m_1 = bpf_refcount_acquire(n_1);
> +	if (!m_1) {
> +		bpf_obj_drop(n);
> +		bpf_obj_drop(n_1);
> +		return -1;
> +	}
> +
> +	bpf_spin_lock(&lock);
> +	if (bpf_list_add(&head, &n_1->l, &n->l)) {
> +		bpf_spin_unlock(&lock);
> +		bpf_obj_drop(n);
> +		bpf_obj_drop(m_1);
> +		return -8;
> +	}
> +
>  	l = bpf_list_del(&head, &n->l);
> +	l_1 = bpf_list_del(&head, &m_1->l);
>  	bpf_spin_unlock(&lock);
>  	bpf_obj_drop(n);
> -	if (!l)
> -		return -6;
> +	bpf_obj_drop(m_1);
>  
> -	bpf_obj_drop(container_of(l, struct node_data, l));
> -	return 0;
> +	if (l)
Can we do early returns, like
if (!l)
   return -6;
bpf_obj_drop(l);
if (!l_1)
   return -7;
bpf_obj_drop(l_1);

The point of returning different errors per each error path is to make
it easy to understand where your test errored out by just looking at err.
> +		bpf_obj_drop(container_of(l, struct node_data, l));
> +	else
> +		err = -6;
> +
> +	if (l_1)
> +		bpf_obj_drop(container_of(l_1, struct node_data, l));
> +	else
> +		err = -6;
> +
> +	return err;
>  }
>  
>  SEC("?tc")
> @@ -438,6 +467,71 @@ long list_del_without_lock_fail(void *ctx)
>  	return 0;
>  }
>  
> +SEC("?tc")
> +__failure __msg("bpf_spin_lock at off=32 must be held for bpf_list_head")
> +long list_add_without_lock_fail(void *ctx)
> +{
> +	long err = 0;
> +	struct bpf_rb_node *rb;
> +	struct bpf_list_node *l, *l_1;
> +	struct node_data *n, *n_1, *m_1;
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
> +	bpf_spin_unlock(&lock);
> +	if (!rb)
> +		return -5;
> +
> +	n = container_of(rb, struct node_data, r);
> +	n_1 = bpf_obj_new(typeof(*n_1));
> +	if (!n_1) {
> +		bpf_obj_drop(n);
> +		return -1;
> +	}
> +	m_1 = bpf_refcount_acquire(n_1);
> +	if (!m_1) {
> +		bpf_obj_drop(n);
> +		bpf_obj_drop(n_1);
> +		return -1;
> +	}
> +
> +	/* Intentionally no lock: verifier should reject bpf_list_add without lock */
> +	if (bpf_list_add(&head, &n_1->l, &n->l)) {
> +		bpf_obj_drop(n);
> +		bpf_obj_drop(m_1);
> +		return -8;
> +	}
> +
> +	bpf_spin_lock(&lock);
> +	l = bpf_list_del(&head, &n->l);
> +	l_1 = bpf_list_del(&head, &m_1->l);
> +	bpf_spin_unlock(&lock);
> +	bpf_obj_drop(n);
> +	bpf_obj_drop(m_1);
> +
> +	if (l)
> +		bpf_obj_drop(container_of(l, struct node_data, l));
> +	else
> +		err = -6;
> +
> +	if (l_1)
> +		bpf_obj_drop(container_of(l_1, struct node_data, l));
> +	else
> +		err = -6;
> +
> +	return err;
> +}
Do we need this big test just to trigger that verifier error?
> +
>  SEC("tc")
>  __success
>  long rbtree_refcounted_node_ref_escapes(void *ctx)
> -- 
> 2.50.1 (Apple Git-155)
