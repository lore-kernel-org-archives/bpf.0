Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96972331ED0
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476178; cv=none; b=qX3Cyp0PioijSAa8LearFjsppzf9sBGLHpphMAAxNMrTuyct9lNT2gaal2ReTBjpgg1YwAAKuHsBZdtOT3vUWLYO3NKOlP/Gy/W8rNcBnhC40KnC65+gXCQ85h4uE2ziTaMi4YZv/9EQM/sFESv4OFDJrwqBkptnMh+12wkPiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476178; c=relaxed/simple;
	bh=RnG9oTOvT38yn+3VZcPQvvKO6g/OR7D6BqHGRWuxa8g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IzGPNLGoMamDO6qhGQcBSy0FQZrTL6ofJtLKGQ25Svc6btrZ7ODOpnAOs+j8hPPCDVtjOh32QfQnD1LPkEj7Ii6j7g2Sl2/YT1C1ckiQf/fAtYkMZPrTfBj5SEzT/XbilcNFARm0AttFSEYBV0w/f+j7VU18LFZI6dnI2PCuK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n38MxRzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n38MxRzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898201F00A3D;
	Thu,  3 Sep 2026 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788476177;
	bh=BRiu4Q569tzfEl85XAesge20gTFA7bbbm8iYdBSRnk0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n38MxRzptSly5gi3P+SD6mAmNWGwsOQZ6PFYOh705DKEP55Y6N2ap4ykPZlcgEtAI
	 iizFBfvn/vdsOeEdHIszycu5Y8p5/mJPI44i9Hm31SWcgHQavNBzbTWIohVmNXoSFg
	 sb/s47NIhW1V20lbCEspmm39Bzhpqm3wC+C1ZWP8VH079cImCRXjSgT+NLddzThlL9
	 4ajxjPAjV1BYbQH6EaG022hfjy4hBccuHMV9TpTzia54dWho2XQsapSd0hWgNxSbWH
	 oL4SKtMZn8CG2EjqDD6Dn+5naySPK5czg4aFqCTg39adTpfh4ycFIMdNemJkC3udEN
	 3NDPQIAze/6bw==
Content-Type: multipart/mixed; boundary="===============7975998575441448815=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f90306cff123c2b5632dad3f3e0dec774ef6120769f373695556d0e275b50d97@mail.kernel.org>
In-Reply-To: <20260903214758.2727663-3-memxor@gmail.com>
References: <20260903214758.2727663-3-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 2/8] selftests/bpf: Check rbtree callback restrictions in subprogs
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 22:56:16 +0000 (UTC)

--===============7975998575441448815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> index 803419a47c626..4504608196abd 100644
> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c

[ ... ]

> @@ -272,6 +272,47 @@ static bool less__bad_res_spin_unlock(struct bpf_rb_node *a, const struct bpf_rb
>  	return false;
>  }
>
> +static __noinline void rbtree_cb_unlock_relock(void)
> +{
> +	bpf_spin_unlock(&glock);
> +	bpf_spin_lock(&glock);
> +}
> +
> +static __noinline void rbtree_cb_nested_unlock(void)
> +{
> +	rbtree_cb_unlock_relock();
> +	asm volatile ("");
> +}
> +
> +static bool less__bad_subprog_unlock(struct bpf_rb_node *a, const struct bpf_rb_node *b)
> +{
> +	struct node_data *node_a;
> +	struct node_data *node_b;
> +
> +	node_a = container_of(a, struct node_data, node);
> +	node_b = container_of(b, struct node_data, node);
> +	rbtree_cb_nested_unlock();
> +
> +	return node_a->key < node_b->key;
> +}
> +
> +static __noinline void rbtree_cb_noop(void)
> +{
> +	asm volatile ("");
> +}
> +
> +static bool less__subprog_allowed(struct bpf_rb_node *a, const struct bpf_rb_node *b)
> +{
> +	struct node_data *node_a;
> +	struct node_data *node_b;
> +
> +	node_a = container_of(a, struct node_data, node);
> +	node_b = container_of(b, struct node_data, node);
> +	rbtree_cb_noop();
> +
> +	return node_a->key < node_b->key;
> +}
> +

[ ... ]

> @@ -330,4 +371,18 @@ long rbtree_api_add_bad_cb_res_spin_unlock(void *ctx)
>  	return 0;
>  }
>
> +SEC("?tc")
> +__failure __msg("can't spin_{lock,unlock} in rbtree cb")
> +long rbtree_api_add_bad_cb_subprog_unlock(void *ctx)
> +{
> +	return add_with_cb(less__bad_subprog_unlock);
> +}

This isn't a bug, but would it be worth routing one of the existing
bad-callback bodies (like less__bad_fn_call_remove) through the nested
subprog too? The companion verifier change walks frames for all four
restrictions gated by in_rbtree_lock_required_cb(), but only the
spin-lock gate gets nested-frame coverage here. The file already has
direct-callback cases for the kfunc/res_spin/RCU gates
(less__bad_fn_call_remove, less__bad_fn_call_first_unlock_after,
less__bad_res_spin_unlock), so extending one or two through
rbtree_cb_nested_unlock() would be a small addition.

> +
> +SEC("?tc")
> +__success
> +long rbtree_api_add_cb_subprog_allowed(void *ctx)
> +{
> +	return add_with_cb(less__subprog_allowed);
> +}
> +
>  char _license[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33811770362
--===============7975998575441448815==--
