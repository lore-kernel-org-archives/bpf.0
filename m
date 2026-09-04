Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1A37A846
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507791; cv=none; b=norv/Ga2qN/+DQoVUatQ/CyNYJuyGcOYdrQmfNihHddnZXdpVLc4we7FHbKkte7K9rkuuwnEZd9SYzIAEBLEGlcC8hzKtqg15zZeTbkNjH5ATkpCtkhiRtXIEX1fJiYYi9cSfUDBVmUXdoFjPCA0+8K6iUuvgyglUhzFZFqJouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507791; c=relaxed/simple;
	bh=3bz2VNG6N/HLjCQEOawIqZ6RbCUpcfpKauNUCjeYwZQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l3Ce/SzvVtwGLK3tPz0dFbACG3JzagFsPa/bIqSUddJ/dzszWXrd1u05hym6Hoyy2ed3ykiko/PlaZ3PUZq//T4IYcvf4e7fkRflHkdvlmAdwlxKeajAqbxO8x/RVwrPWsNUs44qchelGBn0ZE+feheFWzt4aFGJuksprnzRdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNjKMO7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNjKMO7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE5C1F00A3E;
	Fri,  4 Sep 2026 07:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788507789;
	bh=QUFKzktE7TyRT9GWoIrnjdA4qx6TOsWYjtVLB85TMHI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GNjKMO7KU6dvuX5XO6y+Jh+JIJsOhYX9e9pQi1wOTmgeGtFml4l+rJWgadk5To0IZ
	 WN2xOtu/0hAvKEHF8wj4UP2znmhRVEUG1zrtKQ+3SrSReFFC8IMdn6hyOUr+qltVB1
	 qQaOjPhdRkD69xlpInP0StldSswUWeSCVLADMi0MPA5rMzRug6xLnUWdGLaQPQQz79
	 Taaromji7LqtX0qTF0CfXSI3OV53+dO4fFBdtoGc8ukYzohuqUtrajvMwLrVz9CXzZ
	 spr04EtGTLYX9rhrvuBmP50F9OlwHDCSwAlW8w4vSU1cje/LmcU/OU98OzqCDwy9Cj
	 fQvnzN3iMsJwQ==
Content-Type: multipart/mixed; boundary="===============4407579826889591252=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <54096314ad73ac4811ff3d19dbca9e5d70d44555b883355dc7665c29e10876a2@mail.kernel.org>
In-Reply-To: <20260904063650.3877826-5-memxor@gmail.com>
References: <20260904063650.3877826-5-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 4/8] selftests/bpf: Test borrowed refcount acquisition nullability
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: dingning04@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 07:43:08 +0000 (UTC)

--===============4407579826889591252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index eaaed0859f946..7d2f8897e5ad1 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> @@ -19,6 +19,15 @@ struct node_refcounted {
>  	struct bpf_refcount refcount;
>  };
>
> +struct node_refcount_only {
> +	long key;
> +	struct bpf_refcount refcount;
> +};
> +
> +struct map_value_refcount_only {
> +	struct node_refcount_only __kptr *node;
> +};
> +
>  extern void bpf_rcu_read_lock(void) __ksym;
>  extern void bpf_rcu_read_unlock(void) __ksym;
>
> @@ -28,6 +37,13 @@ private(A) struct bpf_rb_root groot __contains(node_acquire, node);
>  private(B) struct bpf_spin_lock lock;
>  private(B) struct bpf_list_head head __contains(node_refcounted, list);
>
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct map_value_refcount_only);
> +	__uint(max_entries, 1);
> +} stashed_refcount_only SEC(".maps");
> +
>  static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
>  {
>  	struct node_acquire *node_a;

[ ... ]

> @@ -89,6 +105,38 @@ long refcount_acquire_non_object(void *ctx)
>  	return bpf_refcount_acquire(ctx) != NULL;
>  }
>
> +SEC("?syscall")
> +__failure __msg("Possibly NULL pointer passed to trusted R1")
> +long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
> +{
> +	struct map_value_refcount_only *mapval;
> +	struct node_refcount_only *tmp, *n, *m;
> +	int idx = 0;
> +
> +	/* Force Clang to emit complete BTF for struct node_refcount_only. */
> +	tmp = bpf_obj_new(typeof(*tmp));
> +	if (!tmp)
> +		return 3;
> +	bpf_obj_drop(tmp);

This isn't a bug, but would a file-scope declaration work here instead of
the bpf_obj_new()/bpf_obj_drop() prologue?

Looking at how other BPF selftests handle the BTF forward-reference issue,
tools/testing/selftests/bpf/progs/local_kptr_stash.c uses a simple
file-scope declaration:

    struct node_data *just_here_because_btf_bug;

and tools/testing/selftests/bpf/progs/rcu_read_lock.c does the same:

    struct rcu_node_data *just_here_because_btf_bug;

Both patterns force complete BTF emission without adding locals or return
paths to the test program.

Since this is a __failure test focused on verifier rejection of a possibly
NULL pointer, would the declarative approach keep the test more focused on
the pattern it is testing?

> +
> +	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
> +	if (!mapval)
> +		return 1;
> +
> +	bpf_rcu_read_lock();
> +	n = mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 2;
> +	}
> +	m = bpf_refcount_acquire(n);
> +	bpf_rcu_read_unlock();
> +
> +	bpf_obj_drop(m);
> +
> +	return 0;
> +}
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33846551561
--===============4407579826889591252==--
