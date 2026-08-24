Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94040DB39;
	Mon, 24 Aug 2026 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571126; cv=none; b=eZRMj33VvxBdqzPI9QSF6TooJC5cDJbCr6PF5htT2jVPpHvJhhLV1IQn/EAyMbYXw8Pde06Yd+ljiPRzWsAPXCr2AWnTVPKkRtr2xnydxkWMtfGSAzwPM4vGKukaCrSGkisG9HvVA/6848HELFe4DQFUxsxLi1kMkmHHtkuwp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571126; c=relaxed/simple;
	bh=tJIVID/jR/ePjaTL43wLaIlrdcgLYk/kLg2n4x7bvEs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QDWWfS0JvyhbzdYPA0Ml8cX5CgdLgNO0OoVQujcgFiMnFIGUWB6qLT8AUGJCK8j2v/SbYDCOF/GuDl5dzCpwupOlvYtmPFIMB2IfhYC11n63kn3XLu2Ey+AdE1Ftugm1CL1Qc6OKhJVstm/SIPudkegOqrNTzYOOFnH/Y7ljt3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSpN5zYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSpN5zYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8B01F000E9;
	Mon, 24 Aug 2026 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787571123;
	bh=cOmu+TQbQTN5PZVxh/o52XECVrxqVwGlFBIhtIft4tg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YSpN5zYgAgrgwnYJLQubcbQCctM9YB2+bcPGR4QrPk/jW5wrDRczmWqv1EmMFiHoq
	 RKFusA/3tK2BibJjY/01iV2g6CGuHNRX908TpvZke9XsRtDKGX37mXIZwNl8N3fSPZ
	 lnv8sNrWvPXO9WcLzG+XoFIiHF/2GVklnw7r44Y2cKNd/+mNULBu03EPYcB4gQnxH/
	 v5ogFqztzNZNgLEXUcDexpFas8QGKksaCJsWoF+qYm3h9Ke2fMpO7sgGK84hdphV9q
	 iuk0sQZnzwZ69P7jhBOAvSUVpj9M0v+lA05o07cPLuNfQGSx01pVwzndKa0nf1hUq+
	 xQrn90GvgAKOg==
Content-Type: multipart/mixed; boundary="===============0976239516751122981=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <80beacc6bf3b97efb653240ffdee468ca4bd20902093c03c705bf723d8d4f160@mail.kernel.org>
In-Reply-To: <20260824103502.3154292-1-falakreyaz@gmail.com>
References: <20260824103502.3154292-1-falakreyaz@gmail.com>
Subject: Re: [PATCH] bpf: Cancel special fields on rhashtab value recycle instead of freeing
From: bot+bpf-ci@kernel.org
To: falakreyaz@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: falakreyaz@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 11:32:03 +0000 (UTC)

--===============0976239516751122981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d40cb5dd446c..a395928a3cf2 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2864,16 +2864,6 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
>  	return htab_map_alloc_check(attr);
>  }
>
> -static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
> -					struct rhtab_elem *elem)
> -{
> -	if (IS_ERR_OR_NULL(rhtab->map.record))
> -		return;
> -
> -	bpf_obj_free_fields(rhtab->map.record,
> -			    rhtab_elem_value(elem, rhtab->map.key_size));
> -}
> -
>  static void rhtab_mem_dtor(void *obj, void *ctx)
>  {
>  	struct htab_btf_record *hrec = ctx;

> @@ -2963,8 +2953,12 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
>  		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>  		check_and_init_map_value(&rhtab->map, copy);
>  	}
> -	/* Release internal structs: kptr, bpf_timer, task_work, wq */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	/*
> +	 * Cancel timer, workqueue, and task_work fields before deferring the
> +	 * element free. Referenced kptr destruction is not NMI-safe, so leave
> +	 * it for rhtab_mem_dtor() after the RCU grace periods.
> +	 */
> +	bpf_obj_cancel_fields(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>  	return 0;
>  }

Is the deferred referenced kptr release on this path guaranteed to happen?

bpf_mem_cache_free_rcu() only queues the element.  rhtab_mem_dtor() is
reached only through free_all(), which is the sole caller of c->dtor:

kernel/bpf/memalloc.c:free_all() {
	llist_for_each_safe(pos, t, llnode) {
		if (c->dtor)
			c->dtor((void *)pos + LLIST_NODE_SZ, c->dtor_ctx);
		free_one(pos, percpu);
		cnt++;
	}
}

But alloc_bulk() can pull the element back out of the pending-free lists
before free_all() ever sees it, and it recycles the object directly:

kernel/bpf/memalloc.c:alloc_bulk() {
	for (i = 0; i < cnt; i++) {
		...
		obj = llist_del_first(&c->free_by_rcu_ttrace);
		if (!obj)
			break;
		add_obj_to_free_list(c, obj);
	}
	...
	for (; i < cnt; i++) {
		obj = llist_del_first(&c->waiting_for_gp_ttrace);
		if (!obj)
			break;
		add_obj_to_free_list(c, obj);
	}
	...
}

Since bpf_obj_cancel_fields() leaves the BPF_KPTR_REF field populated, does
that element go back onto c->free_llist still holding a live reference, with
rhtab_mem_dtor() never running for it?

The next allocation then reuses it in rhtab_map_update_elem():

kernel/bpf/hashtab.c:rhtab_map_update_elem() {
	...
	elem = bpf_mem_cache_alloc(&rhtab->ma);
	if (!elem)
		return -ENOMEM;

	memcpy(elem->data, key, map->key_size);
	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
	...
}

check_and_init_map_value() -> bpf_obj_init_field() memsets the kptr slot to
zero, so can the old pointer be dropped without the reference ever being
released?  That would leak the pointee (a task_struct or cgroup reference,
for example) on any delete-then-insert workload on an RHASH map with a
__kptr field.

For comparison, the array and hashtab conversion in a3a81d247651 does not
have this window: htab's non-prealloc allocation path never re-initialises
the value, so a recycled element inherits the old kptr instead of having it
zeroed.

Would one of these work instead?

  - release referenced kptrs in rhtab_delete_elem() when not in NMI
    context, since the value is already unlinked from the rhashtable and
    unreachable to other CPUs
  - drop the check_and_init_map_value() call in rhtab_map_update_elem() for
    reused elements, so the recycled element inherits the old kptr the way
    alloc_htab_elem() does
  - defer the kptr release to a context that is guaranteed to run before
    the element can be reused, rather than to the allocator destructor

> [ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> index 17e707dddda8..9fddf03387bb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> @@ -98,6 +98,12 @@ static void test_map_kptr_success(bool test_run)
>  	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
>  	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
>
> +	ret = bpf_map__delete_elem(skel->maps.rhash_map, &key, sizeof(key), 0);
> +	ASSERT_OK(ret, "rhash_map delete");
> +	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
> +	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
> +	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
> +

This new delete on rhash_map, combined with the
bpf_map_update_elem(&rhash_map, ...) added to test_map_kptr_ref1(), looks
like the delete-then-insert sequence described above.

> [ ... ]

Also, the commit message states:

>     On delete, the allocator destructor performs full cleanup after the RCU
>     grace periods.

Does this hold for elements that alloc_bulk() reclaims out of
c->free_by_rcu_ttrace or c->waiting_for_gp_ttrace before free_all() runs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32718933772
--===============0976239516751122981==--
