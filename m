Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37E38F223
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283037; cv=none; b=Thy7bTzSoRVg3Hwchr0v0Dq4OchaNkpbR3DWhyywbvZfJPhL3btRpfcY6TTA3INZA1y+KqLPPKN3svOnRtgMknschS3+oLeJpZYOJEpKjrl5qv6yF3EUjb/lhW1l+HEW6+DXsFEsbve8tGmxCVT9qYvo2P99IE8kXu7I4+ifI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283037; c=relaxed/simple;
	bh=llCfhdWLAUf38LDLJNhs92NfagMppXOX8/a21f7RzNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVb4XGEygWrOh2KVu8dzKznDajMpzMGHGRjdZjtoYZY7mf5DIDqlN9u/YtJqAgBKA5+2ABwOD2GBhFwhhuxBVPWHFzy8xRR9W6oqXFJ18ZeNjEi/DcflQfRsT6LpM5ur+9L02iRiIZh32qehv8yPmuJM5L+BO6rFu+vnyC+Ku78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PTo2bB4F; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PTo2bB4F"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770283024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txA+2pjtunrOQaD73Lox37GtWLRfO/g8FhDa6Ku5D/k=;
	b=PTo2bB4FznxY+gotNzEWgl0pk9kG4zNEDlMPIAJ9pIq0h3UsuppTeLrutp55jpwrGuuVui
	LosqELPVfyClfLbnxcKKM3o8A1bt6OQqEhlv5Y4/nZh819gSpkAKofJkwot5WgIl8bOvZ3
	LFFUkWdc9MCu19AtL8qUBMI74VRgx84=
From: Menglong Dong <menglong.dong@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Subject:
 Re: [RFC bpf-next 06/12] bpf: Add bpf_trampoline_multi_attach/detach
 functions
Date: Thu, 05 Feb 2026 17:16:49 +0800
Message-ID: <1945516.tdWV9SEqCh@7940hx>
In-Reply-To: <20260203093819.2105105-7-jolsa@kernel.org>
References:
 <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-7-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/3 17:38 Jiri Olsa <jolsa@kernel.org> write:
> Adding bpf_trampoline_multi_attach/detach functions that allows
> to attach/detach multi tracing trampoline.
> 
> The attachment is defined with bpf_program and array of BTF ids
> of functions to attach the bpf program to.
> 
[...]
> @@ -367,7 +367,11 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
>  	head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
>  	hlist_add_head(&tr->hlist_ip, head);
>  	refcount_set(&tr->refcnt, 1);
> +#ifdef CONFIG_LOCKDEP
> +	mutex_init_with_key(&tr->mutex, &__lockdep_no_track__);
> +#else
>  	mutex_init(&tr->mutex);
> +#endif
>  	for (i = 0; i < BPF_TRAMP_MAX; i++)
>  		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
>  out:
> @@ -1400,6 +1404,188 @@ int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>  	return -ENOTSUPP;
>  }
>  
> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)

Hi, Jiri. It's great to see your tracing_multi link finally. It looks great ;)

After analyzing a little deeper on the SINGLE_FTRACE_DIRECT_OPS, I
understand why it is only supported on x86_64 for now. It seems that
it's a little hard to implement it in the other arch, as we need to
restructure the implement of ftrace direct call.

So do we need some more ftrace API here to make the tracing multi-link
independent from SINGLE_FTRACE_DIRECT_OPS? Otherwise, we can only
use it on x86_64.

Have you ever tried to implement the SINGLE_FTRACE_DIRECT_OPS on arm64?
The direct call on arm64 is so complex, and I didn't work it out :/

Thanks!
Menglong Dong

> +
> +struct fentry_multi_data {
> +	struct ftrace_hash *unreg;
> +	struct ftrace_hash *modify;
> +	struct ftrace_hash *reg;
> +};
> +
[...]
> 
> 
> 




