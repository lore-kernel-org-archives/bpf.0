Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6592D6E64
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054674; cv=pass; b=LSY/jIsvKDSwhAC/rl/yn5TwN3pZE0ynimkzUO6hji4k3OWk/0JvcXRMPBp/oJ743B52vjpDUcZFmdwyGcO9g6WJbe3/ZjwdhzHKSVJdUxq6xKNPFxxXReashwPgzCz17lmUlJdI5HSJkhS4qK24BhU18hykgDOpc7aD6YTMUVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054674; c=relaxed/simple;
	bh=mXn5vCa5+IKK0Bv3wmYQCs4DtTvhfrUBVyfcUxcvus0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwurjkteYWefiZ3VMPZc8WUq+Fu3+giA6vhOJRV1t2ayNYf9pO/Cesome8q4goo5+KRczoOKohR8XnjkUSTHaWCNSFAUm9auVutmb36yyr4Bwie0hv4SglqCOmsbupAYWDbxsOvu5eU6cWGdmC0OzitDmna9lBTE5FRScQw6DWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR+h3FBK; arc=pass smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR+h3FBK"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-38cbb1ad0b6so15913001fa.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 07:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775054671; cv=none;
        d=google.com; s=arc-20240605;
        b=dRdQY18yppOJyvtTE21FENwz56Io+N4+tMoGQybJylbkTIaUE0bVvy68O28zOkPNUj
         vIOiJqVwIuAWmGm6qxYeH3YF4ovD/SHQBc/kA27ycvbl4bRAGNhpI3m9LfKIKlNK17LD
         TbARntGxVHw7o7VtOaH6nYO9qtdLmkwuTZ0a2Om0MV5JZyM7OfX7Y/L1Uh5uwr/sfakI
         xxwtgNxOJ7MSXwjIGxYAPGX4SpX2DsZCgtBDUTM/SAu9CCy/4PHDgAR+VF5PvguCDsx3
         KoKZTlkGKO3qA8F8v5aTfiWKmWZ3G769QEkaAbgmgNuv1iQxxMJ2tCDRcOtwfVTuH4rr
         M7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ii/kDXI3mtal7heDbFrRwZnFkuEsM4FvgZChpem+rP4=;
        fh=SfXskWP2DuQP1+Kt/BSC4XmY5y0KM5kqMi6fF36KHUQ=;
        b=IHgvD4qoVMO8tLbSnBLCHcHhANs0rqiEWdotMOiEJ7fTCPchUIkqL8NrR9EIqzXCQv
         v1AzJysx+R/vSd/ps3Qg9aKxWdhvEa1JCyKeRRNtEYw/lm+VavtVBGCiRnYCrp1pHpJk
         5kyM/hDDh4ln6Oq2NQX7DGgIujgy1CamLFqEqoDbYJWOKhJfJQO6Ib0+K0A59uRu87bw
         P2MRugdbcfPQnL55hIFMMO8cdNs0jDcq0gemx6y2RlnR0FNx1S/YMGun9G5qci6qNFRl
         kmR9MoxPRNaQ6eYtj0YPpjeMkwF5Ye+J/u3Wym5P5234l/iscQPHmN1FUS0+Rb/jX2Mv
         L9Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775054671; x=1775659471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii/kDXI3mtal7heDbFrRwZnFkuEsM4FvgZChpem+rP4=;
        b=nR+h3FBKL+YVQYyQ07u/3whwB5kb47tOisByGHdTHRIYJoBqCQ9UKNBXKx7NpGc22T
         nHOI01rYrKMQ51eM9vpkPGMga9ecbQoQwaxDTIc+0Cj2fqfgfO4xJdeyf6g94uIuAjjY
         EdfxikeABD9WGtz9DBbmx/bwTe3Z3kz9g+V3VqFDngxJIwyEO/9WLUaZoZspnpuRydD3
         0imJWfoo7/gufS3H5sWfU0QhbINFHvMU4ghI//blUaJ7OmMAxqzWnCI6Btx3KaaaP15e
         H2ecGEBwxk9UVgYg+ISPEfU/oB7pRCh6v9SabCqRTo0djFlQiWrhEcb8+IamfohpRrEF
         sHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054671; x=1775659471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii/kDXI3mtal7heDbFrRwZnFkuEsM4FvgZChpem+rP4=;
        b=oqOkpsB0xYIZcDTPOw5gc/j5wqAZ9fJ6QylKBCQNAP1XPYlWAX4G8x0Vmy0b5B/3EE
         6zWgKyaANRA+DvZAFSxle5YCD3Sq/phWw28sXgtpZ9tU78/3hIC7rhTaf1DpgI0oRqFr
         WJMl0xzAEz9CncmgrW8kkTxrnAyCPHQWMrbZTOl0wwFkONE3mkBs2T/Ck219v5KOVng+
         rLl/5nGPu7yF7was2LBEf2n2Ifaw33dT3XUocf0PdiF9EH/ibtpFXkt09o0shPaQB3Ah
         pgBy4wwZkR4V03nis8P7BmbyfTmqnhyS0A9aLhKyls4nCoojleDhWHqIZJ3TDvUEJILg
         QxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp4XGMZWGQgxqiTiXCVDLk4ua+DO9e058SznpwhouqI1P0Rnr7+afus/zLoL/Om0ymEYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzyL3z6Y8N8OyqH8wxCHHo1ZBy4HPAurnnVgIa7M9kFEHUfbcG
	XpthJDyx88vG7FWoWzL5YgnGGymtu4Rs2dbLL3MLgEvV+GVc0CKVpt6kSvFeEqD7C6ho3UCRx4k
	msg37HVsxWA0byb+hKNBAwRsuZVF87d8=
X-Gm-Gg: ATEYQzy/5WZbwc7bk/pa69WYjrajem8Jg9Ov7skSoDOcd0erZRrPS2VXrJ2497Hq/wk
	7BAHs0OHXhUt/lJafGwPA9Re8NQ7gsDmAtZ7aNzuLF+VDfnGenlWfZKru+JWI9SOkIzqGf6cS8I
	gTwh0WZDfe5FC/cMOmGj+KtOFHbcFLWVxuxRL5H6wFnX7uO4pbr66DgKWNGDswK75ghrNQ2J8AX
	pRVBHcFPJUQaMEVWJe4GCsowD6QD/sdrn55uj30dXmvAO5sn0DY/NRuUHCGc9ahAA6ZTt2Lm5Zp
	lmSXDhddW8O+mPwk9y6g1eXSNjH3J6h9Vcqr6SKWu3rq2G5iRun4+XOKlJA=
X-Received: by 2002:a05:651c:2117:b0:38b:f110:aff2 with SMTP id
 38308e7fff4ca-38cc2fbd4e8mr15242301fa.14.1775054670881; Wed, 01 Apr 2026
 07:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401142316.2452-1-tpluszz77@gmail.com>
In-Reply-To: <20260401142316.2452-1-tpluszz77@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Apr 2026 16:43:54 +0200
X-Gm-Features: AQROBzBZDZ9ZIHnU2rfTotpcavllzmHYpDksc8qDfl7P1G56OYoOs9ENh2TOIdE
Message-ID: <CAP01T75rsoZYRsYSawazg4WyRDL8z-iz-VJBb7Sr5xpEzUR2tg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: reject direct access to nullable PTR_TO_BUF pointers
To: Qi Tang <tpluszz77@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 16:38, Qi Tang <tpluszz77@gmail.com> wrote:
>
> check_mem_access() matches PTR_TO_BUF via base_type() which strips
> PTR_MAYBE_NULL, allowing direct dereference without a null check.
>
> Map iterator ctx->key and ctx->value are PTR_TO_BUF | PTR_MAYBE_NULL.
> On stop callbacks these are NULL, causing a kernel NULL dereference.
>
> Add a type_may_be_null() guard to the PTR_TO_BUF branch, matching the
> existing PTR_TO_BTF_ID pattern.

Just this much info is enough, please drop the stack trace from the commit log.

>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:bpf_prog_5f0e2be830ac3243_null_deref_iter+0x10/0x25
>   Call Trace:
>    bpf_iter_run_prog+0x1c2/0x2e0
>    __bpf_hash_map_seq_show+0x120/0x180
>    bpf_seq_read+0x29c/0x530
>    vfs_read+0x179/0x930
>    ksys_read+0xef/0x1c0
>    do_syscall_64+0xe0/0x1290
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   Kernel panic - not syncing: Fatal exception
>
> Fixes: 20b2aff4bc15 ("bpf: Introduce MEM_RDONLY flag")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---

The fix looks fine, but please split the kernel fix and selftests into
separate patches.
E.g. look at this series:
https://lore.kernel.org/bpf/20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com
Also, use the subject prefix [PATCH bpf ...] for v3.

pw-bot: cr

> [...]
