Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960503F86FA;
	Fri,  5 Jun 2026 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655845; cv=none; b=qshdGv+8DqunsChf3YIJGaOIidDZsNnsqE9H8nIZ2YCaeZogZw/+eKcA4vvf0qF/3TeNf2lw8ku/RU7WLf+fBa21bVOjYASDqNX3qhBs/Lm+iEG0jjqULmxrTDnHmPlR1T1hAR+1WOqw7c5tDCfHcv/znHDF0vGk4BEeib6LY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655845; c=relaxed/simple;
	bh=XU2jyUc5aCCU8cfWxgl1WLxWPKlmKjA64WZt9lsWEyY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NLEOfjXYmX4rjbNqDxk4vS3C36J2YdP9B0NGpPcUrd0sRdCRsX6V+fAKHIhU1nF3yGUIynp95i9+Qqy+tqZncFYLwvLP6V8XoWqeXcr5y/voI8/G4Vl/oYNJ1dIEHxVFC/UYVW4d9ZNn6+h8IA3AIhrcgtn/JWSpQI+jahtiz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEes5yBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEes5yBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4611F00893;
	Fri,  5 Jun 2026 10:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780655844;
	bh=XeUnXPPs+LuxnA2/ffLqK6Odk4vhMTeREQch4KPR2TQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KEes5yBm6RL37O73BcZYFI6zHZAk7tx73te+hD0XzvRisEQOuOpsNoJ07yWjDxqLh
	 gPrmKOoNJ9ZfEVWcvsJ03XqQJdq1vWnY6zZFfAFYhIghRSbKFiBivf3JG6bRO/31Mu
	 athuDxSA2cmCSXfKsovhjUoGXc3R1KBpLO4hekiYpacwo/RRfQj5bbgIf5Wdj8ObyW
	 fgglvvvGCAoeQzsjMb+vBTmCfMa3NwWEmPdS5oWjr0LtcRgwBzLJCHBt414B1A2jyS
	 CZ4rzl/LzT5kaodCXp/LF6WP78jPhltW3k56NeS1460/zefLrDdN++CtBMyCJipx+Y
	 VzHftM6Bghjjg==
Content-Type: multipart/mixed; boundary="===============5583059474410768053=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7684717afb20bc3ab9510a4d4e17e7e0bb17c5e4cdfda47b576f7e75e9ddafe@mail.kernel.org>
In-Reply-To: <20260605094143.5509-1-kaitao.cheng@linux.dev>
References: <20260605094143.5509-1-kaitao.cheng@linux.dev>
Subject: Re: [PATCH bpf-next v2] bpf: Clear rb node linkage when freeing bpf_rb_root
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: davemarchevsky@fb.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kaitao.cheng@linux.dev,chengkaitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 10:37:24 +0000 (UTC)

--===============5583059474410768053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 03004e4451f5..8ba2b8965caf 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2306,6 +2306,7 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>  		      struct bpf_spin_lock *spin_lock)
>  {
>  	struct rb_root_cached orig_root, *root = rb_root;
> +	struct bpf_rb_node_kern *node;
>  	struct rb_node *pos, *n;
>  	void *obj;
>
> @@ -2314,14 +2315,20 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>
>  	__bpf_spin_lock_irqsave(spin_lock);
>  	orig_root = *root;
> +	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
> +		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
> +		WRITE_ONCE(node->owner, BPF_PTR_POISON);
> +	}

An earlier review of v1 raised a concern about this loop that does not
appear to have been resolved in this version.

This new bpf_rbtree_postorder_for_each_entry_safe() walk runs inside the
__bpf_spin_lock_irqsave() critical section, which disables local
interrupts. There is no verifier-enforced limit on the number of nodes
in a bpf rbtree.

Can this unbounded O(N) traversal cause latency spikes, RCU stalls, or
NMI watchdog lockups for a large tree while interrupts are disabled?

rb_first_postorder() and rb_next_postorder(), reached through
bpf_rbtree_postorder_for_each_entry_safe(), are exported and traceable.
If an fentry/fexit bpf program is attached to one of them and tries to
acquire the same bpf_spin_lock, can that deadlock while this loop holds
the lock?

The original discussion is here:

  https://lore.kernel.org/bpf/20260601061503.EFD881F00898@smtp.kernel.org/

The reply on the thread noted the per-iteration work is small but left
the deadlock question open. Would it help to move the owner poisoning
out of the locked section, or otherwise bound the work done under the
lock?

>  	*root = RB_ROOT_CACHED;
>  	__bpf_spin_unlock_irqrestore(spin_lock);
>
>  	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
>  		obj = pos;
>  		obj -= field->graph_root.node_offset;
> -
> -
> +		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
> +		RB_CLEAR_NODE(pos);
> +		/* Ensure __bpf_rbtree_add() sees the node as unlinked. */
> +		smp_store_release(&node->owner, NULL);
>  		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
>  	}
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27008654905
--===============5583059474410768053==--
