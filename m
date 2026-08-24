Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F544683D;
	Mon, 24 Aug 2026 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586151; cv=none; b=Qc1AFsuRhtbw/H39BKVOeSPV6R7DSubaBtQQ3cs4fDswTaADg8bWq+x/WtpsobgPnS06Iommd6UktAZ6O888GticxkV9D3eo9IipjhxzAjVN08doyHALbLMlcUomlv6kpHNZNePxnEpTcHSFs3VwWuTmvlOAIyHeJHY/qW3mXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586151; c=relaxed/simple;
	bh=kbWjEPmus8NJNscV+jIp4xnuVIMhXR/RgDSHqzz5e1Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=okdZgLZnnpeakQ1JQD+VyKVKpAHDLf28AzuT6BoVkd+++hRM03zpiQ/VLgiKk3CUx4VtqwDqgpTn2fR3gibFoZr3nhsK5AUxczvkrvAGDMZ7A0VLsFSe+Gt8bBxaKbCfl7Rj85Jj65d38JKdf+z2Gr6SMhughjDOEzjfKK0fyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIlXLvJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIlXLvJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2FC1F00A3A;
	Mon, 24 Aug 2026 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586139;
	bh=jR+4zKKXR5BvPkByjE5lYUpa/8YYQNd7HFexqo/3Y48=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TIlXLvJQPD46pK9TNTJeL5raw1ONtHavbcw+M7eMyG4gNGu1dbUXiSPRUtdYjzLyw
	 trckQVLTzNjHwh9oMdpYxARVPQDdRZ622gzi+3C7hHJk5jdWN8ZnT3hSOmZqUN7kp3
	 oQ9ORpSqL0q+sO6Ja9SMu7XXbyLtkzeUH3vXN4SDiSyu20y9ODbsx5+rXE/tjTDw1G
	 6VernUGpanuNCKgPsEP31YHDQVOUyKq7mAfMar1kVTFv2gXuNXqoULL8jspatohgR9
	 xj2hKSDfAffgRa5dJ5IX18PUHl1P9Cpuk7Db6soPnhqJgNxDhP4CLBuo4YTp+d1fe2
	 QbMZsunsvEnSA==
Content-Type: multipart/mixed; boundary="===============6793583527708650850=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <72b64f467854103cba316523709d5f1f9c533e1762d979e26fd6aa6cc44b63bb@mail.kernel.org>
In-Reply-To: <20260824143621.2098856-3-chenyuan_fl@163.com>
References: <20260824143621.2098856-3-chenyuan_fl@163.com>
Subject: Re: [PATCH 2/4] bpf: Fix use-after-free of program BTF in mem-alloc destructor
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,gnq25@mails.tsinghua.edu.cn,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 15:42:19 +0000 (UTC)

--===============6793583527708650850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 0df8db27cd8c..b8df2bc9a9a0 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> +/*
> + * bpf_ma_set_dtor() duplicates the map's btf_record. For kptr fields whose
> + * btf is the program BTF (MEM_ALLOC kptrs, e.g. objects allocated with
> + * bpf_obj_new()/bpf_percpu_obj_new()) btf_record_dup() only borrows the
> + * reference, like btf_parse_fields() did for the map's own record. The
> + * duplicated record is released later from the deferred bpf_mem_alloc
> + * destructor workqueue, by which time the program BTF may already have been
> + * freed (the map dropped its own reference in bpf_map_free()), so reading
> + * field->kptr.btf there would be a use-after-free.
> + *
> + * Hold a reference on non-kernel (program) BTF for the lifetime of the
> + * duplicated record and release it before the record is freed. After the
> + * last btf_put() the object is only destroyed after an RCU grace period, so
> + * btf_record_free() can still safely read the field descriptors.
> + */
> +static void htab_record_prog_btf_ref(struct btf_record *rec, bool get)
> +{
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return;
> +
> +	for (i = 0; i < rec->cnt; i++) {
> +		const struct btf_field *field = &rec->fields[i];
> +
> +		switch (field->type) {
> +		case BPF_KPTR_UNREF:
> +		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU:
> +		case BPF_UPTR:
> +			if (field->kptr.btf && !btf_is_kernel(field->kptr.btf)) {
> +				if (get)
> +					btf_get(field->kptr.btf);
> +				else
> +					btf_put(field->kptr.btf);
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
>  static void htab_dtor_ctx_free(void *ctx)
>  {
>  	struct htab_btf_record *hrec = ctx;
>
> +	htab_record_prog_btf_ref(hrec->record, false);
>  	btf_record_free(hrec->record);
>  	kfree(ctx);
>  }

Does this ordering still have a use-after-free?

The comment states that "After the last btf_put() the object is only
destroyed after an RCU grace period, so btf_record_free() can still safely
read the field descriptors." But in htab_dtor_ctx_free(), the program-BTF
reference is dropped one statement before the record is freed:

    htab_record_prog_btf_ref(hrec->record, false);   /* btf_put() */
    btf_record_free(hrec->record);                   /* reads field->kptr.btf */

htab_record_prog_btf_ref(..., false) ends in btf_put(field->kptr.btf).
Looking at btf_put() in kernel/bpf/btf.c, it only queues the object for RCU
destruction if this was the last reference:

    void btf_put(struct btf *btf)
    {
            if (btf && refcount_dec_and_test(&btf->refcnt)) {
                    btf_free_id(btf);
                    call_rcu(&btf->rcu, btf_free_rcu);
            }
    }

and btf_free_rcu() -> btf_free() -> kfree(btf). The very next statement,
btf_record_free() in kernel/bpf/syscall.c, does for every kptr field:

            if (btf_is_kernel(rec->fields[i].kptr.btf))
                    btf_put(rec->fields[i].kptr.btf);

and btf_is_kernel() is 'return btf->kernel_btf;' - a dereference of the
object whose kfree() was just queued.

In the deferred path this is the last reference, so the drop queues an RCU
free and the following read can land on freed memory. The reachable path is
exactly the scenario described in the commit message:

  bpf_map_free_deferred()
    -> bpf_map_free()
       -> map->ops->map_free (rhtab_map_free / htab_map_free)
          -> bpf_mem_alloc_destroy()
             -> destroy_mem_alloc(), rcu_in_progress != 0
                -> queue_work(system_dfl_wq, &copy->work)
       -> btf_record_free(rec); btf_put(btf);   /* map drops its own BTF ref */
    ... later, on the workqueue ...
  free_mem_alloc_deferred()
    -> free_mem_alloc()
       -> free_mem_alloc_no_barrier()
          -> ma->dtor_ctx_free(ma->dtor_ctx) == htab_dtor_ctx_free

By then the map's reference is gone, so the btf_put() inside
htab_record_prog_btf_ref() drops the last reference and queues
btf_free_rcu. free_mem_alloc_deferred() is a plain, fully preemptible
workqueue worker; there is no rcu_read_lock() anywhere between the work
callback and htab_dtor_ctx_free() or btf_record_free(). Being preempted
outside an RCU read-side critical section is itself a quiescent state, so
on CONFIG_PREEMPT/PREEMPT_RT the grace period can complete and
btf_free_rcu() can run before the worker resumes in btf_record_free().

Could the reference be held until after btf_record_free() has read the
descriptors, or could the pair be wrapped in rcu_read_lock()/
rcu_read_unlock()?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32741782570
--===============6793583527708650850==--
