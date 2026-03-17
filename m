Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE23F7889
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773219; cv=pass; b=RQh17CpKJ5CqYHM+Qqr9V+ZM5UvAe6EHpC5tQGBeL6tGjRyZjwMX4W2BTfaxURuaVZ17LW8BkEX6xy7FjWHm4C6RhE8cT/9JGFX2By2/4WAUdepCy1OvcNfltqOgFfUD89Ouy7GfFyftqy2e2FVEiV55KHYu75N3+HH6VyaMDUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773219; c=relaxed/simple;
	bh=dPlpzE9piAh3FZdYGe/J9y+3TJL2aCp7uT+YPhEC+6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CS4S9dHEeH+36v6J+LcTFeoDcRyzUvxzAofqnQULLz+eijfydVdElY+fib3fh1uPvXSkL0WwG+nsps1Tt4OzM7MBt9WkDrnuIhNLEyNTZU8dEivflExWVa4fa4+liTX0ld7DxwAoGhosak/pP8I7Ilmu8Ik1ekMXxBWcGtde6xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqHw652f; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqHw652f"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-485409ab264so1369125e9.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 11:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773773216; cv=none;
        d=google.com; s=arc-20240605;
        b=jmwQsv4sl7wRzEoV0kl+vqayxRm6U0kcANP91uQcLU1t5QUhRbTxBIpeXo+7JgZZU2
         x2X+Rn7MNVjvqsNmYGOC75Tuzq1AmvLSjIdJIYaPfvE46f70fkUB5UHtArAgvg9eiFT8
         KTLGQudNfsmBQOvYx1jOlsLZZ/IXuIbLyknENHOI9tS1u6zB98v7iMDCXGOzGFygG3Q4
         o2t7/v1g2M/Y4hjrfpxixy801A5R9EE10nRAca7mh2AElJ5Xnvaa9Vlp8yc8O2ewDbKL
         0gtfVGcT7hj+RF53X2KCdhpgwcQM70x0pB8LqMQA3nO11JsFep9OYEpWmypw6FSwIgDI
         AImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XJHP0hjeJ+jzh5vYCo3gBM6kpB4Zy04Iag6QW8wa1Qo=;
        fh=7Bi9m0SSSmpfarA/NWrENCbMqXHE0+3sj+rzsU41unA=;
        b=CVQIpPjIudxx42ssI3iSASs5WKKOlG2U9M/dxgBFsd53JC1Q8HSVYAvyLeKn6x0aKT
         3XiRuPgnBpG5dk1E0Y0dCK2e/E25fcv4ALaXm1I+uDBNBWWUO69qPl9CBUbKo/dB0M0D
         wN5N6DjM+cvrb2R9a2mYM4yWS0PusDLLGnOy8UAYnQp6rNS4pcevbZZJ8pkridwOvwob
         0FGNHx0ZNUxxvzjP8cKab4Pi2B9wEfuOLNjdVnbVqQ+GpTazdg6O8MVz1LYmBw9oFTVZ
         243iv5ent5nXdqr4fQNNvWQeXunpBseOS1TNYNa20AdN526EwlVCe2oCW58GRt6tO5fD
         yUmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773216; x=1774378016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XJHP0hjeJ+jzh5vYCo3gBM6kpB4Zy04Iag6QW8wa1Qo=;
        b=nqHw652fRAIjbzhTlyGpiKn8cupRG3lElwJtq7Ptv3vuOHkPXGPgxl/biHJoDoNLLC
         pdLcrgGwbLrmkYPoWm7AJGIT1GpydbAXcTntExyOg652crJOE+zKjrvUDuK65x9oo47N
         61RGl8nEfTzJ29gspGyyThqV7avU3OYQoVRy3aDM7yA8wrKOS2hXKS5TEP0qDXLlyuhc
         iVUQfl1gVm3NCAP4HwITxyEPi1bz57jimX/KiYLJqn5IpALmFFnS+c5RPr5qsbooqVLL
         E7PMJYEnggMLNddBx5lqR7o4c2ZHSyff8n1efpAYXDXAS2AE7ZTCreHefpX50MyexWp3
         sntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773216; x=1774378016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJHP0hjeJ+jzh5vYCo3gBM6kpB4Zy04Iag6QW8wa1Qo=;
        b=hQH5xCt6gvG+u3Qk2ZlMMRRlIa20faTCfkgs9r/gP2XwOE8qNlQz11agZp/5qhxsIw
         7a1ZKJ18iC4jLghgbqWL+Y5DQC8YF8JRnpKfogAIIq8xK0mH73sW1ymNVEhwBf+ZsI9+
         FbkuxTWFFEdvubeKapjo3q++4RSaWUtDeLPnhBEEOTkPOOjwjhO2ZhIQxqIRtr4dqyja
         9VkfQOnxRwsQjuAA47e/wSfQyEWCYlV/Ty+Dqq8L4ZLiznwiDG99RLs2Uv4dGvQC/aKZ
         RzRA6Myqwem9s0geVm/h/+WUN+7nB/89vvJp4g2gknq3tp5cbZh4833yjYIhybYGEjEs
         YbEg==
X-Gm-Message-State: AOJu0Yx3ejeDsAK5Iy4JaZvUndp+bUwETFHIgaG++KvFkIOGVobRNtat
	qxL3Z6HipXyp6Lo5TVQ8/AxCw2ZEAIiSELbz9JyC2f7ZNFalIx6Es9rv8992ypBVFchNnRLyFqG
	sPb90O9JdfmykFyFoQickGOlbM3Y2fWs=
X-Gm-Gg: ATEYQzyu6ly+gwnwe8yGRYPope4jjl/Akq/Qyw9dB/pfzrYoxKqJw59PX/HwoeDdUnU
	F2VBP2fqOo0/ZBwtoxWJXO86E+HPorEG+gH/TAcwbdHNgvWapRTkcfI2JMqppBvaiNwnmlnrGov
	vX/wUXuFgmTRPiWx/Dfq27jcz2UMsmJat23yu80GG1SGrJeuhTN/Hy1jDQK7ILEwo7KEsA9Lqvj
	BpOPvMEUw54yUxDRq/3ISOk5Jo+Vc8tBeE1rECGECZiesMxPGvAuhzw+CpUBRsix7wfzdceBaUY
	HYf7ShFY4LeU5RNvXXbjm3wHxcrSAiXqJX5mx57r4zyahwp40DmaC0FYJ+M=
X-Received: by 2002:a05:600c:8709:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-486f40a0cfdmr13461935e9.2.1773773216226; Tue, 17 Mar 2026
 11:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317111850.2107846-1-memxor@gmail.com> <20260317111850.2107846-4-memxor@gmail.com>
 <DH57NGRHX9CO.2K2NWI7CJNN1S@etsalapatis.com>
In-Reply-To: <DH57NGRHX9CO.2K2NWI7CJNN1S@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Mar 2026 19:46:19 +0100
X-Gm-Features: AaiRm50qHZ1f3ylxJchNzc0B_RJDeGN70urmZT-80Dt7nZc7Npke5Zdi3E7TWSo
Message-ID: <CAP01T74hQLH__UoRfH_M9zF0wEpJ4evr_rV+MLUaKvme8P9P-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: Reject modified syscall PTR_TO_CTX
 for global subprogs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Dan Schatzberg <dschatzberg@meta.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Mar 2026 at 17:50, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> On Tue Mar 17, 2026 at 7:18 AM EDT, Kumar Kartikeya Dwivedi wrote:
> > Now that syscall programs allow modified offsets to be passed as a
> > context argument, we must make sure that they are passed unmodified to
> > global subprogs. The reasoning is that we can have inconsistent and
> > potentially unsafe max_ctx_offset based checks if the global subprog is
> > used to access the ctx, or when it is replaced by an extension prog.
> > We'll need a post-processing pass to correctly identify the
> > max_ctx_offset across the call graph, but it's extra work for little
> > functional gain, hence just reject this case.
> >
> > We have to make this change now, since we opened up the checks made in
> > check_func_arg_reg_off for BPF_PROG_TYPE_SYSCALL's PTR_TO_CTX in past
> > commits.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> Whether we end up merging it into patch #1 or not, the logic is correct.
>
> > ---
> >  kernel/bpf/verifier.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 50639bb69d91..3f34510ec183 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10778,6 +10778,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
> >                               bpf_log(log, "arg#%d expects pointer to ctx\n", i);
> >                               return -EINVAL;
> >                       }
> > +                     /*
> > +                      * We should not allow modified offset ctx to be passed
> > +                      * into global subprogs, to avoid messing up the math of
> > +                      * max_ctx_offset for the whole program. Supporting this
> > +                      * will require a post-verification pass, not worth it.
> > +                      */
> > +                     if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL &&
> > +                         (!tnum_is_const(reg->var_off) || reg->var_off.value)) {
> > +                             bpf_log(log, "arg#%d of syscall prog must have zero offset\n", i);
> > +                             return -EINVAL;
> > +                     }

Discussed a bit with Emil offlist and we need to make similar checks
for tail calls as well.
Repeating this rejection pattern after opening up the constraints in
check_func_arg_reg_off can be repetitive and error prone, so a better
idea we discussed is making it conditional on arg_type == PTR_TO_CTX
in check_func_arg_reg_off. In summary, whenever we pass it as a ctx
argument type to anything, we must pass it unmodified, in other cases,
it can be passed with a modified offset. This will handle its escaping
into global subprogs and tail calls, and in the future, indirect
function calls in a natural manner.


> >               } else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
> >                       ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
> >                       if (ret < 0)
>
