Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA8B652
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771546472; cv=pass; b=h0C1c6iC45eE13nQpSJG78Os4f94xiKVHWx0SVQNzApXw2cOgG8O8I0EJfhTUBFbGC15K/M7ZMlg5VAdDPp77XrFMuh43RA+B6VrkvRdIez9by8fWr+jFNYEzJZgAwdGRWlfClITfCJg3qja2d76lR3bPXRPRZfJwV++WulAywk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771546472; c=relaxed/simple;
	bh=T+JYFM/fE7mWSDoHnbeykdnAnGFWjNpCiqVMedTXXPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVuKM+OhGV6XXw36AgLT1GhN36WSJgg/ygbARLhtYHIuC3HAR9NuAfJdY3mXc9Qec2WApJ3A0O2QXsjhEZAezMPRfgfDUECPXSCeQRzXnvA9/NtaiMBQq1bpk1jJuxaIF0iDhqZjpYhzczk0Likl+tG+8ogCxX1L8+8QDRkOxOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVEPpG2y; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVEPpG2y"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f7a30515aso189348066b.0
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 16:14:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771546469; cv=none;
        d=google.com; s=arc-20240605;
        b=Fdr774SicXzC7UnEEANTbLwdhNLBBmNTNDO072ItozFNB75gxY8UGXcGwd1YXWhWny
         pmx6USzQb7hUOf/XVoPtN2qy7PKXzNHJha2QfzLUx01IWOPJBR1bbzSnHuhoCLq2FdAt
         8Gj3AMmIImV9tQ4L0sFZRu6LQGAdqmZNwrCFjhzXKsN57x1PyrLwX+Revc6UsRkCPipA
         LQPExNuqM3RvkjivxykcX+ms3AIZmi/CpQzQDY2rrpEHXAMDO5EktihWmZ2yN2ojALQZ
         BiSyB1RdEkqSuuQ1NrVie4yO6Qs4+2jfCxhf++x1LTwcPCyyZ2LPKNcz6bszPud7hi6z
         St8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4E5EpOC6or/ObLpk4NJH78O0YyNQJkWuGFNUhMCSCc=;
        fh=8DoVh3Iyt0R+s2t7XOny+wXcz6YPk7eroGHcz2JdAg4=;
        b=T6WpgfwFKyHQfMNUXdGDrZC6ggNob7a2xUs7qLK5bk0/RYykKaQHdzsuvl/XtiYGeE
         kDtY/YJfprrhh/glXpiueqZwhgnKBeUYoONd0MLfo9vWQ01lgYxDuXnp4GutgYD6cv2N
         /tu5qYkEAgrfc0wH0PVzHV+FMDBVTnKuNSY87GAfaJmH3u1czO45fe09Zl0RqvoovCfD
         AUDHPXGjtvwT6BcpkG8/LvMwdvGvjVMKXCwSde2YU43ROArD9cPWUC/1lZUrSFQESuTR
         D5Y0akRT0GLmV3a5VfaW/Cv92wIdra9AoX7z4+D9J+oLZ7iBit/IP2PyRlEnx5S/aM0y
         PB2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771546469; x=1772151269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4E5EpOC6or/ObLpk4NJH78O0YyNQJkWuGFNUhMCSCc=;
        b=lVEPpG2y7d+9YK+CWYxwZOu1yXIJGV29RU73TSrotXNVedd2TL1A3+SM8ayYQksQdb
         KrvetMKeQEAmJvOozctBK4XdFc7MyeWA1BzHinRqLm6jb/Gq9oNC5S62FJJElO0IPZST
         3swbBxRHJ8UZkBwm9Lzdrj7c4Kyywlz/vR2dvYI3aFow8TeLyxQhnipzSNtv8AvAes7v
         d0hWXCggP4s2+PfKLx9v8N6jG0sE8CsngaVuOTVcpWx+UNuSt+CZUL379IlcyYegXfNl
         wqChQwCqmL00ypgBvG6h/w0RHNxKGyTQ2ToJ9QPFP9ywSZSqWX1G5Neyd+YW6e2zoc7s
         sJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771546469; x=1772151269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4E5EpOC6or/ObLpk4NJH78O0YyNQJkWuGFNUhMCSCc=;
        b=LwzTOPwqkI287wRF6xCd0qPv2zoTJzighR8FED1742uaqHk0xZF0seoWMjVhP0UyjX
         2RC36eiF2tjod8ghPw6SjfeCxfDFJXdvF1VgGW1WMnjDz6uHVUU0Nkrb2zNMR95UhDAT
         uEAo46mEXofxllXOuqDI0jz2I6THkIeQNlnQhIlAXycbionuCeMzFoMmCmQzAa5yP2/S
         NNwCy0qKctw87Q3uCBUFTkqdA71eO3llF7yp193IVZbcldFuYgJHdeJcOle/DNHW15n4
         YGCK83Cr1HV2Y0jmzPzIjTxDWpyxU+r+HS45pEB3OKuAm2r/bsGlCM2tgfCAu1mzw/qh
         R5zQ==
X-Gm-Message-State: AOJu0Yz1Ud6h0f4uwvHWgiqEnHXehhSuwaQ7usjtVwdAwyH1DB3FF7IP
	SIP4tOk4OhlQbvWzciMEWib04damaMMFuFnN/zbtrwsmdImugSfj0JXBrlAzOG7OSen8xAVcTVn
	nz3y6tPLhhaIVTcbxxVtWtmtVJpaMPqQ=
X-Gm-Gg: AZuq6aIaY7tlNHfBBXltEk169sBF4bNY8/wJx2hoafB/s3gG0fYux07oEi5v4cYihMC
	Q72noQTOnbeWa+UCczzy9yQ8kwiZwXL+u3uGKPKiFmFhAN6Y9RlSFu88rYLUl4m5V3Wy9j1DHlT
	NQev6IICX7XgQzu8t4Uc0XnlOYoCXMkpwQnmR3iC7vcAuqaqP5fRePa3ukRcPhOxy2c4/MsRn08
	8HkfrgL44OeC2RE7NjVNz/YnfotrhINejwhebiKv9soBG2eBPWAr5dDRAMcql7+K3OMf7+BgF9j
	I2Rzx2d7
X-Received: by 2002:a17:907:2d8e:b0:b3b:5fe6:577a with SMTP id
 a640c23a62f3a-b8fc38f91fdmr1073952666b.8.1771546469202; Thu, 19 Feb 2026
 16:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218182555.1501495-1-puranjay@kernel.org> <20260218182555.1501495-3-puranjay@kernel.org>
 <CAADnVQKm+oNX704R8sZrbaHFnmvjC2yBw-UT+T3O4FQ0Rxuavg@mail.gmail.com>
In-Reply-To: <CAADnVQKm+oNX704R8sZrbaHFnmvjC2yBw-UT+T3O4FQ0Rxuavg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 20 Feb 2026 00:14:17 +0000
X-Gm-Features: AaiRm53rOzSxAXmwTx7CMt0vHzKN6RJK3Xpxc7Jqoapohg67Kmz-gYKSxm5sa0A
Message-ID: <CANk7y0jPK1oNNsQy8J1uLRaHcakLQvpdx2hze+zhw_5k+0zgTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Add KF_FORBID_SLEEP modifier for
 KF_ACQUIRE kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 3:24=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 18, 2026 at 10:26=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> > @@ -20054,6 +20086,9 @@ static bool refsafe(struct bpf_verifier_state *=
old, struct bpf_verifier_state *c
> >         if (old->active_rcu_locks !=3D cur->active_rcu_locks)
> >                 return false;
> >
> > +       if (old->forbid_sleep_count !=3D cur->forbid_sleep_count)
> > +               return false;
> > +
> >         if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
> >                 return false;
> >
> > @@ -20067,6 +20102,9 @@ static bool refsafe(struct bpf_verifier_state *=
old, struct bpf_verifier_state *c
> >                         return false;
> >                 switch (old->refs[i].type) {
> >                 case REF_TYPE_PTR:
> > +                       if (old->refs[i].forbid_sleep !=3D cur->refs[i]=
.forbid_sleep)
> > +                               return false;
> > +                       break;
>
> I don't like yet another special case.
> We already have active_locks, active_rcu_locks, etc.
> All that is way too specific. Let's figure out a generic way
> or piggy back on existing active*, since all of them already prevent slee=
ping:
> static inline bool in_sleepable_context(struct bpf_verifier_env *env)
> {
>         return !env->cur_state->active_rcu_locks &&
>                !env->cur_state->active_preempt_locks &&
>                !env->cur_state->active_locks &&
>                !env->cur_state->active_irq_id &&
>                in_sleepable(env);
> }

I thought about this and looked at how each of these are used. Each of
these carry semantics beyond sleep prevention, so they can't simply be
consolidated or reused. But forbid_sleep_count is not strictly needed
as we can just loop over every reference in the refs array and see if
any reference has the nosleep flag set, but this would mean iterating
the list every time. I tried using one of these already existing
active* but it would add more complexity.
