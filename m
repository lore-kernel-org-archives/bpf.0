Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A027FB3A
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797083; cv=none; b=n52J13xL0svPhQq8WIYArlj4I9qa2471p3HV2mKm5rvfS2gLZ7E9babCNluYsc23sGl97kxD2XAoobtLknhuXyedjPN5Kl1PsvNkx5qsc8YruJxyoCeMVZFGphFMQw74xPJTDYUXy64QDY5FjZhLmHgySb7L43cBrGTPSr44I/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797083; c=relaxed/simple;
	bh=sMFFbSND571F9e5BnO32z2bIpAusuZFtb9krqtltOZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siEep9mGPY9FR0AKKL8SWW7N5x0begnNknmBtkuyl/tydDQvXEJupg8if/JjTkMIWHDvi7vqzlUeF+Hps0tUm7kAC5htPkxlyC0Qx0o/KUBVA8VLmBTc/kbBHIddUmWRt3YGEBYo2A4txFtWSo46ORaFrSOD7tPcTiRZ/hosMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fODBAfY8; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fODBAfY8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770797079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KMLepV6blUiIfWtTkZP2TITs8xnmjbUSnmFC5JeZ3o=;
	b=fODBAfY8idwjsJTX69PIuaIWCoVcqeXEsTLPk4JUaQDILBXI+8bqCJrCZOOKQs8+hX4D6N
	pK4HW8v2uEO2tjdpEJ9YmeKuWNgdmJmBf2HFaYH83S/ABnDTWJtRlbNX9LuhEaJTi6Iv38
	xJXB/13za36eqx179KtlE1tdlD7HV+I=
From: Menglong Dong <menglong.dong@linux.dev>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Steven Rostedt <rostedt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject:
 Re: [RFC bpf-next 06/12] bpf: Add bpf_trampoline_multi_attach/detach
 functions
Date: Wed, 11 Feb 2026 16:04:28 +0800
Message-ID: <2819584.mvXUDI8C0e@7950hx>
In-Reply-To: <aYSfEy8Zf8bCs4-j@krava>
References:
 <20260203093819.2105105-1-jolsa@kernel.org> <1945516.tdWV9SEqCh@7940hx>
 <aYSfEy8Zf8bCs4-j@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/5 21:45, Jiri Olsa wrote:
> On Thu, Feb 05, 2026 at 05:16:49PM +0800, Menglong Dong wrote:
> > On 2026/2/3 17:38 Jiri Olsa <jolsa@kernel.org> write:
> > > Adding bpf_trampoline_multi_attach/detach functions that allows
> > > to attach/detach multi tracing trampoline.
> > > 
> > > The attachment is defined with bpf_program and array of BTF ids
> > > of functions to attach the bpf program to.
> > > 
> > [...]
> > > @@ -367,7 +367,11 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
> > >  	head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
> > >  	hlist_add_head(&tr->hlist_ip, head);
> > >  	refcount_set(&tr->refcnt, 1);
> > > +#ifdef CONFIG_LOCKDEP
> > > +	mutex_init_with_key(&tr->mutex, &__lockdep_no_track__);
> > > +#else
> > >  	mutex_init(&tr->mutex);
> > > +#endif
> > >  	for (i = 0; i < BPF_TRAMP_MAX; i++)
> > >  		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
> > >  out:
> > > @@ -1400,6 +1404,188 @@ int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> > >  	return -ENOTSUPP;
> > >  }
> > >  
> > > +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
> > 
> > Hi, Jiri. It's great to see your tracing_multi link finally. It looks great ;)
> 
> heya, thanks ;-)
> 
> > 
> > After analyzing a little deeper on the SINGLE_FTRACE_DIRECT_OPS, I
> > understand why it is only supported on x86_64 for now. It seems that
> > it's a little hard to implement it in the other arch, as we need to
> > restructure the implement of ftrace direct call.
> > 
> > So do we need some more ftrace API here to make the tracing multi-link
> > independent from SINGLE_FTRACE_DIRECT_OPS? Otherwise, we can only
> > use it on x86_64.
> 
> I tried to describe it in commit [2] changelog:
> 
>     At the moment we can enable this only on x86 arch, because arm relies
>     on ftrace_ops object representing just single trampoline image (stored
>     in ftrace_ops::direct_call). Archs that do not support this will continue
>     to use *_ftrace_direct api.

Ah, I didn't notice this part before. Thanks for the explain ;)

> 
> > 
> > Have you ever tried to implement the SINGLE_FTRACE_DIRECT_OPS on arm64?
> > The direct call on arm64 is so complex, and I didn't work it out :/
> 
> yes, it seems to be difficult atm, Mark commented on that in [1],
> I don't know arm that good to be of much help in here, cc-ing Mark
> 
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/aIyNOd18TRLu8EpY@J2N7QTR9R3/
> [2] 424f6a361096 ("bpf,x86: Use single ftrace_ops for direct calls")
> 
> > 
> > Thanks!
> > Menglong Dong
> > 
> > > +
> > > +struct fentry_multi_data {
> > > +	struct ftrace_hash *unreg;
> > > +	struct ftrace_hash *modify;
> > > +	struct ftrace_hash *reg;
> > > +};
> > > +
> > [...]
> > > 
> > > 
> > > 
> > 
> > 
> > 
> > 
> 




