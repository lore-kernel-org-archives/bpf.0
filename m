Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A93B7B9A;
	Tue,  3 Mar 2026 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548830; cv=none; b=pbboq5SZqb5D6S2Qm2S1cBZZ4AEMzFxVWjPkIqlf/+mjQ0AIjcHPjrWmJL3nxJxgG44WYjvg7TUyiifHWVonS4xjMz9Z4nTTFJhi9GnEpQPy1hYBF2RMOsFrrC/cWXNYSmYjndfscDLdtzv4wGCzeje0NxeCRAn7QUQOfh8gVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548830; c=relaxed/simple;
	bh=yVTRTYxNUuoFoHtc5rEeYIv25/6vkbs3QVPHROpZfdk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XjVAJTZwJ8gL7xOGihrCeYWC7O8S/8Az0iEjYRsEgRFr+hK+Qt+/u5XwypALtnYRx0dgoQt1IZ+P2fJNpjcOU2rzDcAtDh6NjDkUOf5s7/IfwPVJZAfxhDUCvPKUqspKVGSxRj9/cD8Z3QZolVYTy6/2XBxeZ9WMx+fARUKRurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDI1XCc5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDI1XCc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C01DC116C6;
	Tue,  3 Mar 2026 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772548829;
	bh=yVTRTYxNUuoFoHtc5rEeYIv25/6vkbs3QVPHROpZfdk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TDI1XCc5qo15C36tbi3Gxr2M82tp+3bhaHB7Hq+5evP6I0Yp75uIfinOGOUC1F0uf
	 yLjGBL9XEhP721kRzaa8xpNCUnrpH9Ed7PbRbTelHXxbhLAX2XqsFgIvc4nhavKFbH
	 YndyF/2CaEERiCNWS6k2zTtilPj2T8IDbApGnnCvtGPmmqYCGSwmLjIxpxCOvQ+oP0
	 Zdjby8pwnUD/i3OximY36RfVqzZW+PMJqCxYIi2aLCB8YgzRM6omrF/Tao2OmgZstG
	 xN9b3ZwwGRjW9NUTHpbgmbtCQJWg87J1ICLx9G4hgnhJTGcbbDrLgZj6vji/BjacK5
	 xL4HSUYmrNOEA==
Content-Type: multipart/mixed; boundary="===============8354238778473276078=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <198ab979488effe54f31ecfb8343e154e65f77f5e419fcdabb93be4f0e48b6f4@mail.kernel.org>
In-Reply-To: <20260303135219.33726-4-pilgrimtao@gmail.com>
References: <20260303135219.33726-4-pilgrimtao@gmail.com>
Subject: Re: [PATCH v4 3/6] bpf: add bpf_list_add_impl to insert node after a given list node
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Mar 2026 14:40:29 +0000 (UTC)

--===============8354238778473276078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Returns 0 on success, -EINVAL if 'prev' is not in a list or 'new'
> is already in a list (or duplicate insertion). On failure, the
> kernel drops the passed-in node.

The commit message says the kernel drops the passed-in node on
failure, but looking at the implementation, only the cmpxchg
failure path actually drops the node:

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
>
> @@ -2497,6 +2497,32 @@
>
> +__bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
> +				  struct bpf_list_node *new,
> +				  struct bpf_list_node *prev,
> +				  void *meta__ign, u64 off)
> +{
> +	struct bpf_list_node_kern *kn = (void *)new, *kp = (void *)prev;
> +	struct btf_struct_meta *meta = meta__ign;
> +	struct list_head *n = &kn->list_head, *p = &kp->list_head;
> +
> +	if (unlikely(!head))
> +		return -EINVAL;
> +
> +	if (WARN_ON_ONCE(READ_ONCE(kp->owner) != head))
> +		return -EINVAL;

These two return paths don't drop 'new' before returning.  The
verifier unconditionally releases the BPF program's reference to
the new node via ref_convert_owning_non_owning() followed by
release_reference(), so nobody holds a reference to it after this
kfunc returns.

In contrast, __bpf_list_add() always either inserts the node or
drops it via __bpf_obj_drop_impl():

    static int __bpf_list_add(...) {
        if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
            __bpf_obj_drop_impl((void *)n - off, rec, false);
            return -EINVAL;
        }
        tail ? list_add_tail(n, h) : list_add(n, h);
        ...
    }

These early return paths should be unreachable because the
verifier guarantees head is valid and the lock is held, but
should the commit message be corrected to match the actual
behavior, or should the early error paths also drop the node
for consistency with __bpf_list_add()?

> +
> +	if (cmpxchg(&kn->owner, NULL, BPF_PTR_POISON)) {
> +		__bpf_obj_drop_impl((void *)n - off,
> +			meta ? meta->record : NULL, false);
> +		return -EINVAL;
> +	}
> +
> +	list_add(n, p);
> +	WRITE_ONCE(kn->owner, head);
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22626485740
--===============8354238778473276078==--
