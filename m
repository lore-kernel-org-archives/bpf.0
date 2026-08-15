Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B830E85D
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781031; cv=none; b=h5sYbTRFDQmyJaGeULdx4pdeHtM/JAvEcUEmaKODH/cv10otx03+Er1AYatM5V6a5lhdzmwkR4aa+5q+Q5bOWtl8nApd/tSrlB2W3PPZpCNXBx/qbIRmCIJx9xVBdj5q3QAozScQY6vpHVW4+WGx+pAc1UAwryIXsfa0OHuwjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781031; c=relaxed/simple;
	bh=b0PH8+/eI0Ivtl7xKXELu2WDRGgb89+6WHqd5BLyC5w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=O6sUvcY/XTfMme1aMdDJkw5WDiyZJU3JZUa2EDng+2/zZHLnirwKnSoOqOjs8sHk1iA0ERZ9vt1uInxjMqbZUAMZVDoTICRlF55y1SP9slAGkXS1bvxYy+VzU63qZM2xGqhAE6YRNJBR/Y/il4pvA6iXL9j0RnJ0um7ld9WOyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJPsETWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJPsETWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F9B1F000E9;
	Sat, 15 Aug 2026 08:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781029;
	bh=/M12M2tqm3R6qhQw8x2EUdHAJQtA66Ovsqm5P+JQ/fw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MJPsETWyGyVAUeJNeYJ410ZMwS2SFKYYO5vGYpuFgkFyhLDunDxrRDtAnGo8/h8xA
	 NIFG/HZiF1BcPY2puHMMmHq63TV7XqyP0o96qQlJWaCffYvU1qDJRjNQYkkcbbXJS1
	 2Tz/h2bR1QglvJ7/q0uJZRrHKi93dEWY9w4bIdGrnNAmoZmmy/EF6L9gHzxJNYwGdQ
	 VUNDR6q1Pat0EGz9lRV2g9nimwgp+Ic18RvXxeK1HA92e193nGGeQWkPpdCrTA2uT1
	 e4SZ5PjaXeUA1rYd3I4O9+rtDlhJmJHbs3K3n7g9i6RSM81Lp7Z/gkSLcFp9YDHmRD
	 lC/1odd2feqUQ==
Content-Type: multipart/mixed; boundary="===============4279827506109544686=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b767b596b56f669bc7df18af00adb4c640754ba7b6290e0c834d493133cdbb32@mail.kernel.org>
In-Reply-To: <20260815071927.147049-1-zirajs7@gmail.com>
References: <20260815071927.147049-1-zirajs7@gmail.com>
Subject: Re: [PATCH bpf] bpf: fix UAF of trampoline progs before image release
From: bot+bpf-ci@kernel.org
To: zirajs7@gmail.com,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,andrii@kernel.org
Cc: john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,rhkrqnwk98@gmail.com,paulmck@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 08:03:48 +0000 (UTC)

--===============4279827506109544686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..bacb6bc2e27b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1376,6 +1376,11 @@ struct bpf_tramp_image {
>  		struct rcu_head rcu;
>  		struct work_struct work;
>  	};
> +#ifdef CONFIG_PREEMPTION
> +	/* Programs called from this image must outlive deferred image freeing. */
> +	struct bpf_prog *progs[BPF_MAX_TRAMP_LINKS];
> +	int nr_progs;
> +#endif
>  };

This isn't a bug, but since struct bpf_tramp_image is also instantiated on
the stack by arch_bpf_trampoline_size() on several architectures, would a
separately kmalloc'd array of size total (or reusing the tnodes array that
bpf_trampoline_update() already has) keep both the struct and those stack
frames from growing by around 312 bytes?

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 1a721fc4bef5..ff6b331c965b 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -531,6 +531,13 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
>
>  static void bpf_tramp_image_free(struct bpf_tramp_image *im)
>  {
> +#ifdef CONFIG_PREEMPTION
> +	int i;
> +
> +	for (i = 0; i < im->nr_progs; i++)
> +		bpf_prog_put(im->progs[i]);
> +#endif
> +
>  	bpf_image_ksym_del(&im->ksym);
>  	arch_free_bpf_trampoline(im->image, im->size);
>  	bpf_jit_uncharge_modmem(im->size);
> @@ -678,6 +685,9 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  	u32 orig_flags = tr->flags;
>  	bool ip_arg = false;
>  	int err, total, size;
> +#ifdef CONFIG_PREEMPTION
> +	int i, kind;
> +#endif
>
>  	tnodes = bpf_trampoline_get_progs(tr, &total, &ip_arg);
>  	if (IS_ERR(tnodes))
> @@ -740,6 +750,16 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  		goto out;
>  	}
>
> +#ifdef CONFIG_PREEMPTION
> +	for (kind = 0; kind < BPF_TRAMP_MAX; kind++)
> +		for (i = 0; i < tnodes[kind].nr_nodes; i++) {
> +			struct bpf_prog *prog = tnodes[kind].nodes[i]->link->prog;
> +
> +			bpf_prog_inc(prog);
> +			im->progs[im->nr_progs++] = prog;
> +		}
> +#endif
> +
>  	err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
>  					  &tr->func.model, tr->flags, tnodes,
>  					  tr->func.addr);

This isn't a bug, but could the changelog say a sentence about why the
new references are only needed under CONFIG_PREEMPTION, mirroring the
!PREEMPT reasoning already written out in bpf_tramp_image_put()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31872362891
--===============4279827506109544686==--
