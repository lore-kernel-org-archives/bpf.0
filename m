Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DC30B52B
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365930; cv=none; b=E+0DvTJriQdsMxJaCIixDQTrgrQUxTSW6jY6FUTKRreeyy5qFw3srLUJY/mShzrb0wGpMEVKm8XNx7twnX+SbBXuITIQ9JrmqZFXnAhhUu2OFgaUy04Rjvho4Ykem6wuEdfa/bBpSLxGnLgZqxvKIqgn4hIGIWLlYBiIuypZcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365930; c=relaxed/simple;
	bh=8VTOp+JpA3YEgtR1igmL1BYWs323gtKL9YQ1bDjbsy0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtWDussD5+RLy2iMn1m891PXchyXBfvZ830zvWCZtW6jlmczzq3LSai7gsSW1mWSP0nuxOh2UAcFDMZMz7cBbY3pfp/jxC28wfi4Sfv3xw+QnZAaKRJe6gQuk9MZOx9RCugy/KOSOfhoCHV7O58CMpjavkU9Xn6iu/xnNuLjAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw693UJD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw693UJD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837907f535so33606775e9.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365926; x=1771970726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GIaSpSdncseBCd6oA9HXpHh/dLjSz2BM+1lYLoTGM8=;
        b=Tw693UJDnUUuMrTKXjDPzYd2k4MAn03HHZ5f/DyUYIgJHzEYdrzhyqpfHUQsmxdJh1
         zRG51fUWSDGmdA5S9h+kxOcNfjQSJ0KVGZmxjrX0gotwWJg5QF89Hi8bpcIlkWhCP6Kg
         4og4IoSKdGxE3N6Oqpdh9xE+VQihgHaGxMnBmFWighJT/v38ERgE5DSlLu9Rs+FMW4jd
         vceoeRMiG5ffMX1s26mfToRmpIlr3MIRvo88UOlYkJoNTgtnO6gSphzWk3hzOhcA7esD
         bxS48rbG/oQ/CZM8zdgHq5kGDoM5yaGzucunSTZJpNUo3Bp3MOzJJ718fPMJYJK91YDY
         aVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365926; x=1771970726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GIaSpSdncseBCd6oA9HXpHh/dLjSz2BM+1lYLoTGM8=;
        b=Bimoq4CiZMrm5beI0onpebm91zhOJZ5sFgdPvkjDQZM5T/eb4XLBX2d9kzUZD2FTaT
         L1XPqyogjjwPXw2CfThee4798dTg11WSVk7C2aNdBgTkenUaJTkXGseGT3OTe7OJhYmI
         pVvh5YltJha0hYyYVvkGu+pGrmBkWMvJfJYgfaue6N3ji7iHB6TgtAxQ/6LT9fl26cW+
         hYmpJnPab+Wt3+dL2FqiSXUixN9ftHAe6SgQM5/G6UPebNUckoCX5F4AojtUxZ5pl78K
         mAj1o91jsknY/aayBYqjtny/9WTwWs+iy4qVKaqz55s9Pzp5OHEyfdelckNamcLCg5bg
         KFfw==
X-Forwarded-Encrypted: i=1; AJvYcCVg7ye99FUMHr7wHKtQUpEzS4MsZz0ClvEDXfYgvdKwIjcZaB72Hb2FNAi1anewydv91PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPIk2P6pE9ib+TJoX0A7pXpaqMSSgqIKM8c1KlCIvp7/HZt1U
	SJNCbZLSPzkyvY7OkBzK593D6S1eOq2SAQNVS3kQRwvj6DHSyYCaMJr+2H9lPq//
X-Gm-Gg: AZuq6aLAvIQCgfXpcAelkDCh5OWvMpugylv0KQ8Ju9HBHkjK7pZxWb4YyhiR5BDVmUA
	W7qc7LXi6ZyUFJvrsdJSv+AuwOZnDQlfAvWR+RlCHW0krn56SAZYjZMB8djaJ2HQQbKY8Xzn8Sa
	W/TER7zOp4cCwpSSKpaUgLA2n6p2oOjTjuTp8DWC4lzcm9NSP4paKJU3ATyxjpij0trV0Ho5X1W
	3i+1F+ODtPV8bVWLKN3RN9aQUuBurz4xLSTcoXB/HOVODmRmC6vb/ACIaPnxUEJGpYi4XOXFLlL
	PyUM3XKP4sXwdNfdTuWnWCwKQSdN95vRfQUa0w1yF9VrySClCyzsUtJMhHEUqIHwGpqIxC1jRoJ
	U5OQOi3LQJC8bqB8XR4HJlvqhoOL9/GyBTxu6c9f24SolIJ50PDQRcugQT36SdMaVZxx2HpXv6Q
	KV0zuE9YhtyPMl0tBdLP8JHQ74zFvrI1zB
X-Received: by 2002:a05:600c:3e0d:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-48379be7576mr209543885e9.31.1771365926470;
        Tue, 17 Feb 2026 14:05:26 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48397423bb4sm4170935e9.8.2026.02.17.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:05:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Feb 2026 23:05:17 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC bpf-next 06/12] bpf: Add bpf_trampoline_multi_attach/detach
 functions
Message-ID: <aZTmHdWSNxuBktKP@krava>
References: <20260203093819.2105105-7-jolsa@kernel.org>
 <bfbbb9ef3aa022d56e5777597b48b596c4a959e606fcbc9d63f4ee1e6c07941f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfbbb9ef3aa022d56e5777597b48b596c4a959e606fcbc9d63f4ee1e6c07941f@mail.kernel.org>

On Tue, Feb 03, 2026 at 10:14:02AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 2be2f1d0b..b76bb5450 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
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
> > +		if (!tr)
> > +			goto rollback_put;
> 
> When bpf_trampoline_get() returns NULL here, the code jumps to
> rollback_put without setting err. If bpf_check_attach_target() succeeded
> on this iteration (setting err to 0), the function will return 0 instead
> of an error code.
> 
> Should this be something like:
> 
>     tr = bpf_trampoline_get(key, &tgt_info);
>     if (!tr) {
>         err = -ENOMEM;
>         goto rollback_put;
>     }
> 

yep, we should, will add, thnx

jirka

> > +
> > +		mnode->trampoline = tr;
> > +		mnode->node.prog = prog;
> > +	}
> 
> [ ... ]
> 
> > +rollback_put:
> > +	for (j = 0; j < i; j++) {
> > +		mnode = &link->nodes[j];
> > +		bpf_trampoline_put(mnode->trampoline);
> > +	}
> > +
> > +	free_fentry_multi_data(&data);
> > +	return err;
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628
> 
> AI-authorship-score: low
> AI-authorship-explanation: The code follows established kernel patterns and contains a human-typical oversight error (missing error assignment); the commit message has a minor copy-paste error typical of human editing.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Missing error code when bpf_trampoline_get fails causes silent failure under memory pressure, but does not cause crashes or data corruption.

