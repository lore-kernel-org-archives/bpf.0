Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDE2727F3;
	Mon,  1 Jun 2026 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337209; cv=none; b=nGR+w0qlbY7k7Sv1CyCmY+LxBAgPu53L2NfkOH1rOgciRwb3E/EiSORd/Y6vHTMg6Z5qPiL2TECjtONo1eejLoWcPXBaFK5hujoyJBjWhlxI5FPs0sfaTHdIFRn1ZrKTZgMcGqgkEWQBy/L3yYOr9c2xgXp+QGN3kJLixmg7VDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337209; c=relaxed/simple;
	bh=RNnQCsEdQYmIbIEkrMyGZMDAU+Anq2EK8sBom5Il4YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWd46Jh1iATGbGEbyenNLAD7hDSPdpcJ8IM/IwgdFDUtiA1NBo9NMpjJs+UAtAY8YNGT/Pwbsvs7h5ZJdy4eyv6Np9mNxXyb+Rq7Bb7zk2S8PtCKtiQ1d5lVh61+uVuWrRyg6mYpgdjEOdOHcxbEaGyjQArwA2gyd+6xrj/HPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aTiPHKmt; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aTiPHKmt"
Message-ID: <5e4e8089-6eb7-4eec-8ad2-820d99368a55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780337204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwRy42BF9NfGNP81n26+y1VM1UW4e3EhFPSI4OCs3Hc=;
	b=aTiPHKmtpQdcEcl5UxTCJdprt79E9chAUuEzqNPnPs+Iy0PcLOHkOTleAU9MEOzhnsCZH+
	bsDoOh4DzqsEArokOL9ribDxKo40DVy7Lo8QJEnTzWlnGVbM6HMUUJeohyG1lviUP/koIt
	3Vkq6ZZ7P5M3G3G+B3aYW1HFRGUcxck=
Date: Mon, 1 Jun 2026 11:06:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Clear rb node linkage when freeing bpf_rb_root
Content-Language: en-GB
To: Kaitao Cheng <kaitao.cheng@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, jolsa@kernel.org
Cc: davemarchevsky@fb.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20260601055859.13888-1-kaitao.cheng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260601055859.13888-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/31/26 10:58 PM, Kaitao Cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> bpf_rb_root_free() detaches the root by copying the current rb_root_cached
> and then replacing the live root with RB_ROOT_CACHED. It then walks the
> copied root and drops each object contained in the tree.
>
> This leaves the rb node state intact while dropping the object. If the
> object is refcounted and survives the drop, its bpf_rb_node_kern still
> contains an owner pointer to the freed root and stale rb tree linkage. If
> a later bpf_rb_root allocation reuses the same address, bpf_rbtree_remove()
> can incorrectly pass the owner check and call rb_erase_cached() on a node
> whose rb pointers belong to the old tree.
>
> Mirror the list draining behavior by marking nodes as busy while the root
> is being detached, then clear the rb node and release the owner before
> dropping the containing object. This makes surviving nodes unowned and
> safe to reject from remove or accept for a later add.
>
> Fixes: 9c395c1b99bd ("bpf: Add basic bpf_rb_{root,node} support")
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>

Please use [PATCH bpf] tag so CI can test it. Do we need a selftest?

LGTM with a few nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/helpers.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9ca195104667..46e8eada463b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2307,22 +2307,30 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>   {
>   	struct rb_root_cached orig_root, *root = rb_root;
>   	struct rb_node *pos, *n;
> -	void *obj;
>   
>   	BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root));
>   	BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bpf_rb_root));
>   
>   	__bpf_spin_lock_irqsave(spin_lock);
>   	orig_root = *root;
> +	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
> +		struct bpf_rb_node_kern *node;

Move 'struct bpf_rb_node_kern *node;' and the below to the top function declaration.
This will make code simpler.

> +
> +		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
> +		WRITE_ONCE(node->owner, BPF_PTR_POISON);
> +	}
>   	*root = RB_ROOT_CACHED;
>   	__bpf_spin_unlock_irqrestore(spin_lock);
>   
>   	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
> -		obj = pos;
> -		obj -= field->graph_root.node_offset;

We can keep this two ...

> +		struct bpf_rb_node_kern *node;
>   
> -
> -		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
> +		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
> +		RB_CLEAR_NODE(pos);
> +		/* Ensure __bpf_rbtree_add() sees the node as unlinked. */
> +		smp_store_release(&node->owner, NULL);
> +		__bpf_obj_drop_impl((char *)pos - field->graph_root.node_offset,
> +				    field->graph_root.value_rec, false);

and then __bpf_obj_drop_impl(...) will not change.

>   	}
>   }
>   

