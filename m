Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F252385D7E;
	Thu, 21 May 2026 04:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336490; cv=none; b=nFl2ZhfhEunNmWv8+sgo+3Rg472zlJ4eUcC3Cjz1hqgCsrzqz8dyEGgjfrAZUO6DdaGPd2ZtS/gckYYiICDrmdfULvzXcg/ZJkOUehMFtprwmdIwCWYTKGMfW5I95yOPhxLTUNljWfd0po7Gn+Wv0El0d9eki/RZIwlGv7J4XSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336490; c=relaxed/simple;
	bh=QFR6C8wh0WVpRMIVxkrzujvyth5nTpujg8pr/bnlBYE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NY95j37Ymh2mmGnYGZ+N+LK3ynzMtPl/rJJZEwUdnpgJ27AFlQKn80xnjY4h9eAxp6hklOHZKUsoYJxt8Ee4yamcP/AOVt1Zb9sFO0gd2dMDejwlI49G2U/Cian/zdt05iHeWbQxo9X1bKiFz0VOVU8AWYsYFdKLxWKt5TyAwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMy3RVTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMy3RVTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD34C1F000E9;
	Thu, 21 May 2026 04:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779336489;
	bh=tcn4ApfCGarJ7JITZjCvuMhuuEDuxOjra6VBOmUEC7E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TMy3RVTtaQY8rJGEVBXbLTDHjKJvbfdPeR3OgOJm32y0ThhIg58GHoKcaAN2pGn0X
	 bz2cl+nLg1YYPQhLHtDLrKd8safCPymQ/eOrCoN0CN9LaWvpIydqI/JT6Iq2c1Kh6e
	 ss7rInNDnH1RUW55L0eLlrLVMhx9njjR9Xgt8FVRIkKt/iwTFFCTtlvc5FHB7J+Ko2
	 I+wdcLJGJZZNqTCTStcYX/pEMJyUrV73D/+CODBJapl3tghtPYeQJG+F9IjLwaUbQU
	 mphIOG780yKrFi99vmTTbsGu5PzrKm+VV5q1WIHuW3iMmcvBqEE2VLiZi3K57StxDh
	 QBMMsE5ZXjskw==
Content-Type: multipart/mixed; boundary="===============4087047492165139329=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <35619368729a7d55f123388f7e99a79b10f788968aaf9c8124b3ea4fe6ca3134@mail.kernel.org>
In-Reply-To: <20260521032306.97118-3-kaitao.cheng@linux.dev>
References: <20260521032306.97118-3-kaitao.cheng@linux.dev>
Subject: Re: [PATCH bpf-next v11 2/8] bpf: clear list node owner and unlink before drop
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,ast@kernel.org,corbet@lwn.net,martin.lau@linux.dev,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,skhan@linuxfoundation.org,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-doc@vger.kernel.org,vmalik@redhat.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 04:08:08 +0000 (UTC)

--===============4087047492165139329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 094457c3e6d3..59855b434f0b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2247,10 +2247,11 @@ EXPORT_SYMBOL_GPL(bpf_base_func_proto);
>  void bpf_list_head_free(const struct btf_field *field, void *list_head,
>  			struct bpf_spin_lock *spin_lock)
>  {
> -	struct list_head *head = list_head, *orig_head = list_head;
> +	struct list_head *head = list_head, drain, *pos, *n;
>
>  	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct bpf_list_head));
>  	BUILD_BUG_ON(__alignof__(struct list_head) > __alignof__(struct bpf_list_head));
> +	INIT_LIST_HEAD(&drain);
>
>  	/* Do the actual list draining outside the lock to not hold the lock for
>  	 * too long, and also prevent deadlocks if tracing programs end up
> @@ -2261,20 +2262,30 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>  	__bpf_spin_lock_irqsave(spin_lock);
>  	if (!head->next || list_empty(head))
>  		goto unlock;
> -	head = head->next;
> +	list_for_each_safe(pos, n, head) {
> +		struct bpf_list_node_kern *node;
> +
> +		node = container_of(pos, struct bpf_list_node_kern, list_head);
> +		WRITE_ONCE(node->owner, BPF_PTR_POISON);
> +		list_move_tail(pos, &drain);
> +	}

Does this introduce an unbounded delay with interrupts disabled?

The original code detached the head in O(1) time. Now there is an O(N)
loop inside __bpf_spin_lock_irqsave(). Since BPF lists can grow quite
large, could this cause soft lockups?

This also appears to contradict the comment just above the lock which
explicitly mentions doing the actual list draining outside the lock to
not hold it for too long.

Lore reference:
https://lore.kernel.org/bpf/20260513060221.DB2C7C2BCB7@smtp.kernel.org/
Reviewer: sashiko-bot@kernel.org
Date: Wed, 13 May 2026 06:02:21 +0000

>  unlock:
> -	INIT_LIST_HEAD(orig_head);
> +	INIT_LIST_HEAD(head);
>  	__bpf_spin_unlock_irqrestore(spin_lock);
>
> -	while (head != orig_head) {
> -		void *obj = head;
> +	while (!list_empty(&drain)) {
> +		struct bpf_list_node_kern *node;
>
> -		obj -= field->graph_root.node_offset;
> -		head = head->next;
> +		pos = drain.next;
> +		node = container_of(pos, struct bpf_list_node_kern, list_head);
> +		list_del_init(pos);
> +		/* Ensure __bpf_list_add() sees the node as unlinked. */
> +		smp_store_release(&node->owner, NULL);
>  		/* The contained type can also have resources, including a
>  		 * bpf_list_head which needs to be freed.
>  		 */
> -		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
> +		__bpf_obj_drop_impl((char *)pos - field->graph_root.node_offset,
> +				    field->graph_root.value_rec, false);
>  	}
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26204125015
--===============4087047492165139329==--
