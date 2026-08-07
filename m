Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF5367B99
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140372; cv=pass; b=IgszStF+SQttXJJCmBsknECsme3fYb4yK3O3ogaHID5Qe4oKL8GjjLGxNToXDqwVS5KzWmiSZxs5CXl8YPP5lDHsyBfmIvdGqcplri0O+U/JOzKsnQsocApjIpRXxLGdfmDCECAoRjSWwzw6RWBx0TP4qWeF21lOvZ8AzGNpgNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140372; c=relaxed/simple;
	bh=ayAVOkYDxTLcQ/YuYnkxIC6DyQ/vvq/ddc0m64lXxa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsKngKIQb0gA3FzPH5knqCWy15dKZgjntYAzksX8OJj97QaqoB7C+/Io3AkTyK1dln5Kvp0vNX5E9cxv0xn0HvLawBcD09Fcs1Hq23raoZAz7yGbVeLf1xEOLeqTHMfu+pcyJmNL1HihpNggUjUSQbJj2/goqnxjk+q9gfCeAbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF2KC6UA; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF2KC6UA"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so30223a91.3
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 15:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786140370; cv=none;
        d=google.com; s=arc-20260327;
        b=HUxtxi19CzL7rU0KeRRsGYlucKaUvsD8oV7UJcITLHPfGJfwWyPSbtiPPiq9Nf8z/j
         xxFsj6AlyBriFG42UUZzlGcgzACDiEy3sPSWZhQ7g6Ki8TGQU1fUUxClPYlPoSjuvN0/
         7FJSy58fjcuazDHkCmFLFWuFGol2ixfXOH9EJsjXdZ2kUhGr0GIyfbYPVBxuBMCOCRuf
         Pqhh8Hmzia3YK7XPAkm/d/K9WjFkPCdN94Z2lABUhZjYbOYh185PuYY6+GlsHo0h5z+N
         of6PQBygi3AgWqVn74UpMjJtFW74Jlcp7QZHrL+1jxCM4+PtdUndW1jlmFEXL8vmuU2z
         LC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v7W53OKtetAES/Ur15d10M2fBqkK0v+olT1EjWbF8sk=;
        fh=uNSGatdDK6vSR4cpGHrsjN4pj3dxOq0UjVrq+Hgi9mw=;
        b=EJTWg0Z2DYcoDZeHBOyUJhxHVh6v4kHFFjmYw9D7MOMOr8YuyyS6gN7yVuSbiQLNsD
         F9WSRTtrD8gD1UHGhSphDIH4ICRrHYX9v5k5s7+2qm36uR6MQUxXO46h0HCt8O8/Cxhu
         zjm7YB1jBbi6NRUFoOxcUjCIC2uzj6EsOXw6z8vr7WF+Uhx+wdbEnN6l8gv0QHEJsOF9
         /wLamPNUZaXDwsPjtX5YeXl3YpiAh86WrNLCUPQTQf3hFFjD60Q32recSSn2BO83jZRk
         aIDr4Wr6woEBqdo2RNf6v3w5THyC8KIWv1Km7HSGSORuTBQIwc6Vf0oyNcOMWhxQx6iI
         DfRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140370; x=1786745170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v7W53OKtetAES/Ur15d10M2fBqkK0v+olT1EjWbF8sk=;
        b=ZF2KC6UAbBLF1khTRdknXB+cj+7UYSm2XMXPFHxmzA4ZOX9y0npbd4+DY2y3PiPps3
         3Wy41S77kx1K+n6+IwAoMk5+4OUVLvI5ctlJGZ1aoSA1Xj2NdQ3t0sjx4QKy9Y46553X
         tO/zrIuIOdUoEowixLVE+wHfKdNimTagDdC4NSBNIn67DExjV6ZDUwxBGqBxKP0o2ODb
         vezJXi7ptWamsdjVBMsuYFsZAMI7lKC2lJXRSDvQv+4mE2NFbnxkvD42B8sr4ZdJhICG
         yWV/P2UCK3+KMaBiMIyaAmiYbf+P5FrpsYK5E5dC0kZhE1Zye6Jz452QQTHFc2cF/Yji
         NeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140370; x=1786745170;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v7W53OKtetAES/Ur15d10M2fBqkK0v+olT1EjWbF8sk=;
        b=aAARB5N7D6Td7nNkOJ5T+HvFuuzypvsEz9tPNALAQum1v8+AKgIqy39jlmA2VqQDwM
         yYk7MLuwPnIvoAQzJsrnJ3fi3M1S8AeXaboVM6A958w7I+JZwYko/yk39lqAW05Nguz1
         kRqwfBc4ZQU4GHfHsQVgoktUC9eHS0vkxYFRjB/d/pfvFCgyOx7nMTCExSr46hxwjxyo
         NdYxs7JdIyiybWamDWq8t1+rDefgW8Ma6oWu4BgeN2gkqd+2Q2h192LzrLQLxgaIi/rR
         WUcLpeCwRlbV1z+okv3QkVlHH8LV4nSyOQgfgiSQTnQN426Y9WeCeGoNaqgyRh9z15Ot
         FXQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLVwO+CpGp+uHd79q2/Z2ZuP9mMuUogkLHYqN7CetpIaEscAKL+Tg9T1Aj8oxAoG1FYyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12V3W6KlwRHBsyPn4JvPSOxc4nz+4VqslCJLQmYij8CjtXyap
	RUnI7r1TjOY7KZmiISEujGFQJFzPk357auSzKV/4fQlYunoCWF5KBhWdpZriJInJQ6vMY4rYeUe
	LG16iogY/QmSvfUMc1FT+nDht1Kg4NEs=
X-Gm-Gg: AR+sD112jts9PJ430CB8i0ngugkxXCNMJmdbhv4/MEI/jEy1bpU8+41DYwpNKP+goDK
	+j1dXJoMEzmRYt6AZA/i1dkTzaCohE+frGDPZAuVIsE0fLdOERhCVtskbbZIQYSy3I+l1xDnazr
	dmpCTQYXpTC2n4KG6nf4qaE9FkBVXOCoV0ZqpnAIPZpcZJM4uB3GzfRXYAwzH0sn6kqSl4qCzmW
	LTfh2HE6t8p45veYoE3DX/A7bYOYWe4CWpdg2tfDiaT38IcHV5kFMcQHMEiTpgkhfsifMizW9/U
	2MmqFi2r2yRyQQS1LYsmVpYkr8watqHxKkgmGIDZfOHla1wkgKcyhgiTchISuOJb+KAex5RsU+/
	dK3JzVYub8btH/QVJRTWJJzQDSEJypQ9uuWSFORhV8jf0EWQO2OtD
X-Received: by 2002:a17:90b:1d4f:b0:38f:7f60:ba35 with SMTP id
 98e67ed59e1d1-3903c5381d6mr25486520a91.5.1786140370247; Fri, 07 Aug 2026
 15:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805011517.1717238-1-memxor@gmail.com> <20260805011517.1717238-3-memxor@gmail.com>
 <952a9aa9e0e8d0e8bbcf54dda79b1b88ff48e1ff.camel@gmail.com>
In-Reply-To: <952a9aa9e0e8d0e8bbcf54dda79b1b88ff48e1ff.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Aug 2026 15:05:54 -0700
X-Gm-Features: AUfX_mxYNF1ZEHadXyLXR-b73OrG2vKEdBbijpndVmnb-T7WjHWRNZ3JuT-IdMs
Message-ID: <CAEf4BzbX+PDV-uM2qLAh_K0e55oDnhbfRiEd0bFvEmyXfF6Dhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/6] bpf: Propagate async callback
 instructions to scheduling subprograms
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:18=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-08-05 at 03:15 +0200, Kumar Kartikeya Dwivedi wrote:
>
> ...
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 9de45ade473b..42fa464c520f 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -447,6 +447,8 @@ static_assert(MAX_BPF_STACK / 8 <=3D (1 << 6));
> >  struct bpf_verifier_state {
> >       /* call stack tracking */
> >       struct bpf_func_state *frame[MAX_CALL_FRAMES];
> > +     u32 async_stats_subprog_ids[MAX_CALL_FRAMES];
> > +     u32 async_stats_subprog_cnt;
>
> One async callback can call another async callback, e.g. see program
> 'test1' in progs/timer.c. Meaning that this array is not really bound
> by MAX_CALL_FRAMES and the code below may overflow it.
>
> Overall, it seems that having an alternative full call stack solely
> for the purpose of accounting is an overkill. I'd just show async

I agree, it's a bit too much, even though it's useful to be consistent
with non-async callbacks. How about we simplify this just remembering
which entry level subprog (main or global) was active when async cb
was scheduled, and account this async cb to that root program's total?

btw, does anyone remember why we "detach" async cb?

pw-bot: cr


> subprograms as their own roots, tbh. On the other hand, same
> subprogram can be called both as an async and as a regular subprogram :)
> so the idea of a separate spine is not w/o it's merit.
> If we decide to stick with it, maybe pick a better name?
> 'verification_call_stack' or something like this?
>
> If we decide to go with this separate call stack, would it be possible
> to adapt the code in a way that only this call stack is used for
> accounting? (e.g. is filled on regular subprogram calls etc).
>
> Another option is to build an implicit call graph in env while
> verifying and count only self instructions and counters on edges.
> Then propagate the data over the graph in post-order traversal
> (subprog_topo_order is already computed). I think I like this idea
> the most.
>
> ...
>
> > @@ -2293,6 +2298,12 @@ static struct bpf_verifier_state *push_async_cb(=
struct bpf_verifier_env *env,
> >                       0 /* frameno within this callchain */,
> >                       subprog /* subprog number within this prog */);
> >       elem->st.frame[0] =3D frame;
> > +     cnt =3D env->cur_state->async_stats_subprog_cnt;
> > +     memcpy(elem->st.async_stats_subprog_ids, env->cur_state->async_st=
ats_subprog_ids,
> > +            cnt * sizeof(elem->st.async_stats_subprog_ids[0]));
> > +     for (i =3D 0; i <=3D env->cur_state->curframe; i++)
> > +             elem->st.async_stats_subprog_ids[cnt++] =3D env->cur_stat=
e->frame[i]->subprogno;
> > +     elem->st.async_stats_subprog_cnt =3D cnt;
> >       return &elem->st;
> >  }
>
> ...
>
