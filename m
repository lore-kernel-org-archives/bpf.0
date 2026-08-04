Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC2443E3E
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887740; cv=none; b=G3YwfHhysBou5mZdl6jga87ylHSLUB54pSE1g00tuc773o6/kZZO7JIK1JfDJtn6SLNltJ0qAKySVOeohu2kADF6HzlAgzk4CawQ30Xf2HmctXfk1VS6RY/Jh3gIIKuQKXDPOmtQJPnOZ/P9McC577A91Qu4MfCmXFCg+WXsF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887740; c=relaxed/simple;
	bh=P4DD+eG/A2JphAwfiUI8L9s9IWuHIxYtuHDCfcfuAoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YPbgF0ODBaB0FbciigvhsafBYFg3qw9lhA2PTzg6uZu34b6WkUQgQlSuRq7w3toVjRl2OwuWe3o7D8+D/I9vi1HE79nA6PHiKHutRaJgUsNNAm9nKc9YKdV7FB2ABNIh6zgpOdg+oQLRjx9nApAcgmSGGZ0aLERjCN7SB+dkYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbSXxdEh; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbSXxdEh"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso319078a91.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 16:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785887739; x=1786492539; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mEarzLqBiNaLZOoX+FjoydJJziZCBQ2+OHBkrFv6APc=;
        b=dbSXxdEhwDrsPw8/z8oS0l8WSrwmCe4recW2Nhnc4guUL+4z5M84iE6LKo32lXXGUt
         cGialYcZ6nTmjERgOzhRat8KijYLkQSKkKNXCPDVfc0q29E6rzoV9CVkZsr7sIVB+uDJ
         l4T2wnLfzNkqyq9WvnqpkTVeevpk7jW4nSWzODVejPvX9FsdTkfWujA9oU7MWB5MNaZE
         gcPm2s0RBHGj5LNJPZMzUoNAGcwYEVfWtJ+qWHarGJNnJmCwZ4AxZ9zVeN4mIM6cY5rS
         SveGBfA+gn8G/DVf5pm3RA/AfJMkBGWhdCx26LDFnQIfV9mSqgetklJoZ+iPuOqRRWYF
         rYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785887739; x=1786492539;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEarzLqBiNaLZOoX+FjoydJJziZCBQ2+OHBkrFv6APc=;
        b=G+sZyA5+uyB66jGLrz6ZG7FZ7lgFSzjjS5cIaAHXH9G9YN0+wqzXmlAEOMtrOybJro
         hA289NbNXdzkcfkYvLEIoaGZpEqB5HS9YQi4IpcuEltGXwzspUFSLAD9o//wa3cJTqY7
         KzqJjTAtp9x4cOwelctqicn1HSYOMOdiWD45pWJceRtY29xteXd0iyrgjycV37ntAqQD
         cnWUZI05hYMWPAIV0zbDKteA3jrWmPRVzouwkkNAnosuhQ6ODwapvnN/ipRTpEgBKzvk
         f5JiBVsDTtHQpZhvGZ7/dX/i608GJ8zz4xE6Gv346GrL8EY/AZie/2lxwfTkVusmdZJ5
         ICCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8bN6x3mLID8rPmJ9yQc7HQR9MfKXke+UnPzB98G5dk4n7MPK1pXCUEq8sNoPfsrMR8Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhCPDyGpj2DACLc2HB43MVcWgs2fqkFnI+B58AeJB9fAVn8D2
	d0OWHmq7sOkEQmjAfcMC9lk7AXnHkJNQVCDc2N66dZun2wksgIav0DxL
X-Gm-Gg: AR+sD11YuNLjSy7BZaOBJg6H7kbrYslcIRefGbg24qYb/yEzHN3TgQs1i2SNqFYeuLG
	fUgFtDy5HTWXOWJnuXR2CKSKxC3KA2/gd8SQOHq2SO4HfN0UaNPGA98aLFu/99cJbnnP4ZQbH8j
	l409zFd2k/E3Bwun4IQamWq97yIfKN3znGA/YHS6wc+sZTGq7gPVcpctSMEMdIUgv3wWbEm6tNt
	lezhjybY/R4cVAoFagAOuWGxUHiiFU9MqT6Ga6XWxf8o7UdIt9reJQIZiAVjcIAbJUEAe6qBHTF
	n3LE0K1mXysVW5tsieBML78ALJ5s3szVIyDA53lgCWZV3n7CbiRoPZR9F3mHgFXxnITZKj/GMAu
	JGHEVBQ4iiu/HB4/Rf8B1zMyGgy/vVLUcVa+m1wYKJ7v7+qhZ+e5+YGnSQ/u/mq0hSDoiGDE3jw
	nKf3mkn6+v+slvcIOdQt0wsMMHzStlG+ughOm67/Vlb6mpIqLJqcojkZSOKDinLV+HAfVI+lNE1
	N6Si9ztYHbcy7Wc
X-Received: by 2002:a17:90b:5112:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-3903c592115mr2527143a91.9.1785887738730;
        Tue, 04 Aug 2026 16:55:38 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febe308dbsm2388011a91.0.2026.08.04.16.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 16:55:38 -0700 (PDT)
Message-ID: <018d033499f61651ec8761fe0f7ac9662ef3c096.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Support __arena and
 __arena_nullable on struct_ops arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 04 Aug 2026 16:55:35 -0700
In-Reply-To: <20260803125115.2264733-3-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
	 <20260803125115.2264733-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:

Lgtm except for several nits below.

...

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c

...

> @@ -226,26 +229,30 @@ static int prepare_arg_info(struct btf *btf,
> =C2=A0	info =3D info_buf;
> =C2=A0	for (arg_no =3D 0; arg_no < nargs; arg_no++) {
> =C2=A0		/* Skip arguments that is not suffixed with
> -		 * "__nullable or __ref".
> +		 * "__nullable", "__ref", "__arena" or "__arena_nullable".
> =C2=A0		 */
> =C2=A0		is_nullable =3D btf_param_match_suffix(btf, &stub_args[arg_no],
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 MAYBE_NULL_SUFFIX);
> =C2=A0		is_refcounted =3D btf_param_match_suffix(btf, &stub_args[arg_no],
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REFCOUNTED_SUFFIX);
> +		is_arena_nullable =3D btf_param_match_suffix(btf, &stub_args[arg_no],
> +							=C2=A0=C2=A0 ARENA_MAYBE_NULL_SUFFIX);
> +		is_arena =3D btf_param_match_suffix(btf, &stub_args[arg_no], ARENA_SUF=
FIX);
> =C2=A0
> =C2=A0		if (is_nullable)
> =C2=A0			suffix =3D MAYBE_NULL_SUFFIX;
> =C2=A0		else if (is_refcounted)
> =C2=A0			suffix =3D REFCOUNTED_SUFFIX;
> +		else if (is_arena_nullable)
> +			suffix =3D ARENA_MAYBE_NULL_SUFFIX;
> +		else if (is_arena)
> +			suffix =3D ARENA_SUFFIX;

As discussed already, that's unfortunate that p__arena and p__nullable
are valid, but p__arena__nullable is not, substituted by
p__arena_nullable. Same goes for global subprogs.

> =C2=A0		else
> =C2=A0			continue;
> =C2=A0
> -		/* Should be a pointer to struct */
> -		pointed_type =3D btf_type_resolve_ptr(btf,
> -						=C2=A0=C2=A0=C2=A0 args[arg_no].type,
> -						=C2=A0=C2=A0=C2=A0 &arg_btf_id);
> -		if (!pointed_type ||
> -		=C2=A0=C2=A0=C2=A0 !btf_type_is_struct(pointed_type)) {
> +		/* Should be a pointer to struct, or any pointer for __arena/__arena_n=
ullable */
> +		pointed_type =3D btf_type_resolve_ptr(btf, args[arg_no].type, &arg_btf=
_id);
> +		if (!pointed_type || (!is_arena && !is_arena_nullable && !btf_type_is_=
struct(pointed_type))) {
> =C2=A0			pr_warn("stub function %s has %s tagging to an unsupported type\=
n",
> =C2=A0				stub_fname, suffix);
> =C2=A0			goto err_out;

...

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index ed7999ad6c66..d2d7a2904345 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

...

> @@ -695,6 +743,22 @@ static int bpf_trampoline_update(struct bpf_trampoli=
ne *tr, bool lock_direct_mut
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +	/*
> +	 * Arena ctx args are converted only by the struct_ops indirect
> +	 * trampoline, which dispatches to a single known prog. Generic
> +	 * trampolines can mix progs with different arenas, so no conversion
> +	 * is possible here. Not reachable today: only struct_ops progs get
> +	 * arena ctx args and they never ride generic trampolines.
> +	 */
> +	for (kind =3D 0; kind < BPF_TRAMP_MAX; kind++) {
> +		for (i =3D 0; i < tnodes[kind].nr_nodes; i++) {
> +			if (bpf_prog_has_arena_ctx_arg(tnodes[kind].nodes[i]->link->prog)) {
> +				err =3D -ENOTSUPP;
> +				goto out;
> +			}
> +		}
> +	}

Nit: should this be done in __bpf_trampoline_link_prog() or
     bpf_trampoline_add_prog()? To avoid doing the same check on unlink.
     Since this is an invariant violation, do we want to add WARN_ONCE?

> +
> =C2=A0	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
> =C2=A0	tr->flags &=3D (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL=
_CTX);
> =C2=A0

...
