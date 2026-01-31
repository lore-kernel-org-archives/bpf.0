Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7E32BF3A;
	Sat, 31 Jan 2026 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769837613; cv=none; b=m4UxOUF6K2ze4MVWXNMPGeYMZ+o1y1C3XfRYcQZrK0H99UKv1MbZRlXH+lD8Vv/3KzzNvgsoPKSCU71S2phMt5LAVk2goOZ0sEFh6h+wF9YWfqDsvGuWGhKKOccJ/zsFb7pUZW60ejKjWwPnSPNfwE4JW9T7+p6sBTR5CiKVpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769837613; c=relaxed/simple;
	bh=P+p16aunagLmuKqsTKiUhxUEzv4rjEwCmBflcpJwHdI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=k8SizdPNRED3jsMUxeCR6Q/ve04rpcqnQkwqTnOkKdtCgS3FywSSHWiRNRtHD0VBRPPAHCsIqZ6tbQk0flvkhazSk9f2J1Jv1Ezp8XIvJeYIwekPpTe9Sdao3yPpEdiDpBRZRHtbkkvDB3JtKVicsWzNwviyldYEi4ilN1fFV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh6Ok4ym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh6Ok4ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4202C4CEF1;
	Sat, 31 Jan 2026 05:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769837613;
	bh=P+p16aunagLmuKqsTKiUhxUEzv4rjEwCmBflcpJwHdI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Dh6Ok4ymEd8QNHh6368BbA7TP49LZtLdwXYM41msKUJf4bo86qdVkgXbJZOgcVqsJ
	 0SJ5KlfGSPIDyKWwUXIxzVoic8rnLqX84586HWELMmCwXHtFBVGWQIRVp7yqxcG/Bh
	 jVUF5OGQGPSGy0p3yjq8WhlYXFt9IGXLwaYoMhbYVskKw+OEoDUPPL8fnuD3xjcVJ/
	 2HPXRAWvalx/HI60OFdUOIFft5HgbYNO4hNMqt6tE4738kAJpEdeXNmGksB4lVGnPq
	 XHCWJPqpaB7VlFChiyhpmdTU27P4wetMtUG/w5t97yXagcVcbOYSWIWL2pJIJFeoc6
	 6MI4xng/ILQRQ==
Content-Type: multipart/mixed; boundary="===============0743677568194036131=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fc5f36c2f50b99cba8b9b6d020a7400911a84c372ca15be7707c8513239228f3@mail.kernel.org>
In-Reply-To: <20260131050920.2574084-2-ameryhung@gmail.com>
References: <20260131050920.2574084-2-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 01/16] bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 31 Jan 2026 05:33:32 +0000 (UTC)

--===============0743677568194036131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index e2fe6c328..6615091dd 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c

[ ... ]

> @@ -368,9 +371,13 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
>  void bpf_selem_link_map(struct bpf_local_storage_map *smap,
>  			struct bpf_local_storage_elem *selem)
>  {
> -	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
> +	struct bpf_local_storage *local_storage;
> +	struct bpf_local_storage_map_bucket *b;
>  	unsigned long flags;
>
> +	local_storage = rcu_dereference_check(selem->local_storage,
> +					      bpf_rcu_lock_held());
> +	b = select_bucket(smap, local_storage);

The commit message states: "This is safe since a selem is always linked to
local_storage before linked to map."

Is this claim accurate? Looking at bpf_local_storage_update(), the order is:

    /* First, link the new selem to the map */
    bpf_selem_link_map(smap, selem);

    /* Second, link (and publish) the new selem to local_storage */
    bpf_selem_link_storage_nolock(local_storage, selem);

The comment explicitly says "First, link the new selem to the map" which is
the opposite order from what the commit message claims.

Similarly, in bpf_sk_storage_clone() when new_sk_storage is non-NULL:

    bpf_selem_link_map(smap, copy_selem);
    bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);

Since bpf_selem_alloc() does not initialize selem->local_storage (it only
sets SDATA(selem)->smap), and bpf_selem_link_storage_nolock() is what sets
selem->local_storage, wouldn't this mean bpf_selem_link_map() reads NULL
from selem->local_storage?

With local_storage being NULL, select_bucket() would compute hash_ptr(NULL)
which returns 0, placing all newly linked selems into bucket 0. Later when
bpf_selem_unlink_map() runs, selem->local_storage has been set, so it
computes a different bucket and tries to unlink from the wrong bucket.

The next commit in the series (82de4fd08 "bpf: Convert bpf_selem_unlink_map
to failable") introduces bpf_selem_link_map_nolock() to fix this for
bpf_local_storage_alloc() and bpf_local_storage_update(), but
bpf_sk_storage_clone() still uses bpf_selem_link_map() and appears to
remain affected throughout the series.

>  	raw_spin_lock_irqsave(&b->lock, flags);
>  	hlist_add_head_rcu(&selem->map_node, &b->list);
>  	raw_spin_unlock_irqrestore(&b->lock, flags);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21539340647

AI-authorship-score: low
AI-authorship-explanation: The commit has typical human characteristics: domain-specific BPF knowledge, concise explanations, and follows kernel conventions.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: Hash bucket mismatch causes selems to be inserted into wrong bucket and never properly unlinked, leading to hash list corruption.

--===============0743677568194036131==--
