Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86017350A39
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770905; cv=none; b=GQOrp0D3wlWuLLQEaZyp8UXNkmjSN89HwS7YyH3tD+W8z8e6wwugMimWlPN/Y7k/aK2tNd542QJy4mTUYgb5GHNQiIyu8b/WnJdlItIUyDQ5WHZpKZVNxJD5iRUe/BMXcOpgYI8UKqMs1viT3VdV3e2jRzpnERTRhFVhf17OwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770905; c=relaxed/simple;
	bh=LWzd7B6Ov5p+8oHp6mKvgjwW3Jz3a4xy2JcWIH6uyVI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miujgqcK72hkE4fwoWG2tlU1f8s2q5kzLaNeh/BA7K8+JxBa3fDU4VCFp1gFSXj4B82E4ufIjfI+f54TOWRWhwesJMPJwXkONPiciJyzGlG59umcRXPU2bnsTcb0M0fVqfLLn0n08ixkN6LWf2So1S9uCCDYvvmkxTDkKsvC2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqTHrSIy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqTHrSIy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so39292495e9.1
        for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771770902; x=1772375702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRKUB2AiLenr7E0WblQLVnZoKolZSz4KLpAcSu1+tEU=;
        b=XqTHrSIy60/pkxklUK45yhI4nrR6nf0TTUidcEUQkXznnO2CDachT1uGGV8AI49bhM
         WWVS8yipm4N3msyMZm/9fARczv6UN0G2wKv/lIKcBIASLnZ4XMKGcN+MNelKj129knXs
         sSaNI7Lmrifv/8DL2Bq+mu/2nC4KrQLYG3IPduLEmYCIFLYbHG/Kl5gIl1l6pDx+lOOV
         2naQelyJi68DB6VtTpvBNUFF+zs8Xrw1yXxi3ndIdJZ7ZmbBJYINuAzoAToAIaO2WfIh
         7pX1UznfN9QbHosvwVs2hmXjAl3TloQwO/v8ksiVHFWQfRQjj2ysSMSAtO5hKdveJK33
         ybpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771770902; x=1772375702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRKUB2AiLenr7E0WblQLVnZoKolZSz4KLpAcSu1+tEU=;
        b=P6geR3MA/V1VfgWzPXKEw/ZhsYdL84OYEGvL+u3c/hN/41qeR3Rzh/3Bf11rxuxzrT
         SHGp8OMQ0S1KFyD5UOUl7GEu3WtfSRSMueNyijgmf8O++JY4VidBVoq/3GvZJ1G3X1qM
         Z8jyf3b0AnNAE4cfZ+SE6a8JHvjZC9BY3GMwQ4P9tkx0tpJ8QC1XfDdiUZW5rkxKFBFO
         UmGvkVpO1U8vdzhoW6cAUxPP8xbW5qPuZjnD3Um30/8c3aiBP1noI+fuAmgrbPnZhvd6
         t5J0s2Agx/PhMHy/dkDlcmyo0CcLbqID48EJnIl1W47j1VtYCC47+aaAFJDtlIjUnVZd
         xzUA==
X-Forwarded-Encrypted: i=1; AJvYcCXjO4eJMAj6wb6V++6/6LvqK7plGA1JQOV6qLqT3IRIE3Fx2N9bJYOKtlldyCB6nGzRZFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdCeIeWanDUR+QLfp/co+LouJfBAdCqErFq0MX5IgOCTBlrx4
	9XSTVGQ+YSUj5wTBa4Ot+fnjyUQ2c9NeDJwIEbDqjQK6nsI6VlgEGoo8
X-Gm-Gg: AZuq6aKbi1WRA3B5rpTxCqSRbOknr5Vy/GnT8FTc57wzZu4jQqBiEMQrKY5Na1Lp35q
	U1lVw9VsM5yPGI7bNI36r82XN/D3m/8VKAsfeKrAPllAqOX2BfDQS6slKM13lBcYhuIrbuutz13
	2DCZ4QGUnwK0Ny8z+9grMCFBWFme5OEO5p7d4NTPlqc+MhWUG/ef0nKWIuy+O+ykel+YEwhJTkI
	8E19rizFgcxb/qNs92cmxHwMpwML02LcwVkZMj/li7uWPIVkH2nCrjfgQ3Nhl3fOsqlDNRqEQ9F
	R18fyJLdWT3qQ3lzIGRiyKWeF/8jicMW32J30Uymvucy9VJ8BiUv6fOQt0f7SV9E12l+E111ms/
	BlZUJSNHVVh+gz9PcJ8CRzi4NFB1aysXWsmB0YfBggStc8WpzNL12j/ICkJB56kLrLdkV6l6Pdg
	PB2aGemi0=
X-Received: by 2002:a05:600c:674f:b0:483:6ff1:18b with SMTP id 5b1f17b1804b1-483a9555bafmr99613735e9.0.1771770901801;
        Sun, 22 Feb 2026 06:35:01 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31f9475sm186883455e9.14.2026.02.22.06.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 06:35:01 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Feb 2026 15:34:59 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 07/17] bpf: Add
 bpf_trampoline_multi_attach/detach functions
Message-ID: <aZsUE6er2DL2E2Rp@krava>
References: <20260220100649.628307-8-jolsa@kernel.org>
 <1e9f20706c4184df2a84a176fd520277f1d2a9bc08f1101b00b34ff415b6158c@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e9f20706c4184df2a84a176fd520277f1d2a9bc08f1101b00b34ff415b6158c@mail.kernel.org>

On Fri, Feb 20, 2026 at 10:57:54AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 2d701bc6e1a5..c32205adfebe 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> 
> [ ... ]
> 
> > +static int unregister_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr,
> > +				   void *ptr)
> > +{
> > +	unsigned long addr = (unsigned long) old_addr;
> > +	unsigned long ip = ftrace_location(tr->ip);
> > +	struct fentry_multi_data *data = ptr;
> > +
> > +	if (bpf_trampoline_use_jmp(tr->flags))
> > +		addr = ftrace_jmp_set(addr);
> > +	return add_ftrace_hash_entry_direct(data->unreg, ip, addr) ? 0 : -ENOMEM;
> > +}
> 
> [ ... ]
> 
> > +int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
> > +				struct bpf_tracing_multi_link *link)
> > +{
> > +	struct bpf_attach_target_info tgt_info = {};
> > +	struct bpf_tracing_multi_node *mnode;
> > +	int j, i, err, cnt = link->nodes_cnt;
> > +	struct fentry_multi_data data = {};
> > +	struct bpf_trampoline *tr;
> > +	u64 key;
> > +
> > +	data.reg = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +	if (!data.reg)
> > +		return -ENOMEM;
> > +
> > +	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +	if (!data.modify) {
> > +		free_ftrace_hash(data.reg);
> > +		return -ENOMEM;
> > +	}
> 
> data.unreg is left as NULL here. In the forward path this is
> fine since only data.reg and data.modify are used, but the
> rollback path can reach unregister_fentry_multi() which calls
> add_ftrace_hash_entry_direct(data->unreg, ...) with a NULL hash.
> 
> This happens when rollback_unlink calls
> __bpf_trampoline_unlink_prog() on a trampoline that had no
> other BPF programs before this attach. Removing the only
> program brings total to 0, so bpf_trampoline_update_ops()
> calls ops->unregister_fentry, reaching:
> 
>     unregister_fentry_multi()
>       add_ftrace_hash_entry_direct(data->unreg, ip, addr)
>         __add_hash_entry(hash, entry)
>           ftrace_hash_key(hash, ...)    <-- NULL dereference
> 
> Should data.unreg also be allocated here to cover the rollback
> path?

I knew I should have added rollback tests ;-) right, we need the unreg
hash as well.. it's on my todo, will add fix and add tests next version

> 
> > +
> > +	for (i = 0; i < cnt; i++) {
> > +		mnode = &link->nodes[i];
> > +		err = bpf_check_attach_target(NULL, prog, NULL, ids[i], &tgt_info);
> > +		if (err)
> > +			goto rollback_put;
> > +
> > +		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, ids[i]);
> > +
> > +		tr = bpf_trampoline_get(key, &tgt_info);
> > +		if (!tr) {
> > +			err = -ENOMEM;
> > +			goto rollback_put;
> > +		}
> > +
> > +		mnode->trampoline = tr;
> > +		mnode->node.link = &link->link;
> > +	}
> 
> After this loop completes, all cnt trampolines have been
> obtained via bpf_trampoline_get() with refcounts incremented.
> 
> > +
> > +	trampoline_lock_all();
> > +
> > +	for (i = 0; i < cnt; i++) {
> > +		mnode = &link->nodes[i];
> > +		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
> > +						 &trampoline_multi_ops, &data);
> > +		if (err)
> > +			goto rollback_unlink;
> > +	}
> 
> [ ... ]
> 
> > +rollback_unlink:
> > +	for (j = 0; j < i; j++) {
> > +		mnode = &link->nodes[j];
> > +		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
> > +					NULL, &trampoline_multi_ops, &data));
> > +	}
> > +	trampoline_unlock_all();
> > +
> > +rollback_put:
> > +	for (j = 0; j < i; j++)
> > +		bpf_trampoline_put(link->nodes[j].trampoline);
> 
> When __bpf_trampoline_link_prog() fails at index i in the
> second loop, this falls through from rollback_unlink to
> rollback_put with i still set to the failing index. But all
> cnt trampolines were obtained in the first loop above.
> 
> The rollback_put loop only puts trampolines 0..i-1, leaving
> trampolines i..cnt-1 with elevated refcounts that are never
> released.
> 
> When rollback_put is reached directly from the first loop
> (bpf_trampoline_get or bpf_check_attach_target failure), the
> j < i bound is correct since only 0..i-1 were obtained.
> 
> Could the rollback_unlink path set i = cnt before falling
> through, or use a separate loop bound for the put?

good catch, I think that's a good fix, thnx

jirka
