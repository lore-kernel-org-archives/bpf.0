Received: from mta1.migadu.com (out-156.mta1.migadu.com [95.215.58.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A833030F
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786942490; cv=none; b=pUEqcHubNSxwHlBhvXQ017B1pc5KYsO1uMVFawT8UnuWhymmYWjatVlvneO0DeaHy05fEB4fIEo86crkWt396xO47G0QF/PpzRcWK8nLcUhHg3T2x5/PGp21BlDiLX+cDg0J/T+OKcIhaPbfHo+pQSJP/rfMtFotSFadmnOQdzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786942490; c=relaxed/simple;
	bh=dbAoGVBRuUvMmPmhiZ4u6YNK1J5v+C3LqR2Yeoa+leI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoCb+vm8totxXGf8nloZHzIFjR+KH9MjhkUudXrwVdY+A4ng53eSMQ2GnUHp2YNfbkmPnEPM6rUkBGy7gEOnu9TdaREt9pTblLcniKrmMsiBmKkBhR/jr5u+sk5TzkQC/aFGjfLFGZ3rxIxaComb4WKDqE6H/HaHNw8TrbyrPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gB2E3sE0; arc=none smtp.client-ip=95.215.58.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gB2E3sE0"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dbAoGVBRuUvMmPmhiZ4u6YNK1J5v+C3LqR2Yeoa+leI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786942484; v=1; x=1787547284;
 b=gB2E3sE0znq4ViErd9ZJ/e/Rl27lbddoVosne2BtRAKJo2TrpsVScrr3R3Ki/LK+fE4C6eNO
 1lxR+J9WNZMTuhZJsAp31qr/GNzrtMkhY8+6JOarrjxo7ZjGaTy7GC72hcl9T12ahdNpergxlpk
 vGztiTtO+E3+pt9OkLcjIgEI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 9105983903091a03;
	Mon, 17 Aug 2026 04:54:34 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <d5dc645b-3efe-4875-93ec-4c89ee323de8@linux.dev>
Date: Mon, 17 Aug 2026 12:54:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: fix UAF of trampoline progs before image release
To: Junseo Lim <zirajs7@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 Sechang Lim <rhkrqnwk98@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20260815071927.147049-1-zirajs7@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260815071927.147049-1-zirajs7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/8/26 15:19, Junseo Lim wrote:
[...]
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
>  
>  struct bpf_trampoline {
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

Looks better to factor out a helper for it, e.g.
bpf_tramp_image_put_progs().

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

Ditto.

Thanks,
Leon

> +
>  	err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
>  					  &tr->func.model, tr->flags, tnodes,
>  					  tr->func.addr);

