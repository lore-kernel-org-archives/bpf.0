Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1C12BF18
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036743; cv=none; b=n+g6zKqEzTjZuH5pX8Uyj2GJZtzYTO8rd05D6E494FaXI3aGPcDyObU4EmX+/CO5f5VUFIri5bDSp2Szmr9a7iGSv6NEH5gbzMs3X32sivOwFM5NmkP7ZwINcGtkQ/okTyl9aR1/ywu01B3DZJLRAFq6CTo3DhqXieQTYUwtsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036743; c=relaxed/simple;
	bh=Iad1tyKhiFMIDC8Xt0/zXsbE/rY3pkbp2kXvv1eL2yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezKclpqa96DqLAea9KFXl3YztiSagxeByu+75y1PedzxVmlkTz3gJI9Yzo3vqVGTGYv4fkMJm1ME6g6NtvBqkPNKcAMEEDAQUeZOuwzTmEKxpwCaODoo0OfktgIUM3ADtFM8A4TttpetLVS/BidegRJ4ST6BtuZNy6NaChCysG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVMA7iKn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVMA7iKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711036734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/BIMjBq7uK/tVcgzATJ/EBrygqAy5kphRG6l+IH21c=;
	b=PVMA7iKnN9vg3gNwQbxMvoYHDpetOm0DYhk7VdfxK89/0opX4SrU9MEvmIQ0Jf0W0d3J2M
	/BgOg5jx74K3/167a9GaAAgtP8c5RCeMS1cImLPiRSw5jc4ZBSMDwszWbblo9apA9n5Vqc
	Za78FciUZA7mRqhAWdtUX6rOWE/esMc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Pb2aUo0VOzSJbXJNEQvupg-1; Thu, 21 Mar 2024 11:58:51 -0400
X-MC-Unique: Pb2aUo0VOzSJbXJNEQvupg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a46f6c1104eso131899766b.1
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 08:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711036730; x=1711641530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/BIMjBq7uK/tVcgzATJ/EBrygqAy5kphRG6l+IH21c=;
        b=u706V5g9ThOsTR2MOCV802rZq4b9CVKvnVP9iQJ9V922Wpz8iBvuTJ0kUeT4/a3m52
         m3H26Qf9GcNSrqJUCmzF5w+wlsuozkNUvMKkHG6ECLKkc5HF1uwelYGB3n4+pSkB8RKm
         26kFzJtnsl6jxqr7JfKLdIZIWceR6TBaZ84MZboh37YJfJMTcm0LaGS6GTpdIuXPyoIF
         yvwurin0fI65x1C5UQWpLm6j5ZIbutZvLn72hRSeYsSjTbWb6eQoM6TEQcX5v+4YnQDi
         lw2h5Q1kGkSP8vXPMrKgCaHEvOPzd4vcnIctaRWsByv/ZEQch5DxKg2IP05OmrIYP7JX
         ddpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQYcyPLq+/dKrV3Gu1qXV19cNA0Ncxrxke9qYXkUIF6BGlUvURMDlvPUR4xx/Ntkx9MvZ8XUdylR0qmR98RxATouuY
X-Gm-Message-State: AOJu0Yzec+PFyDJSVrRTvgRWmU5SJmc6CQVqlHSarqD94AaK78kQZ9rE
	6r7zwnC/5/FKL1brTkJnBQCG0mC9DkzVLJ4VpkCLEsAoB93l9s1/QEv7dPog1C470Ea3kTdptxC
	QhiEp5ReUVm1KXk/eTZv/xznzo38doJLozJ6hLBvBnMU05MMqR4KBIyoo9gt4MOGhxM2bJNu7LD
	qa6LwlOERuwGnCoe4DFBi2I24X
X-Received: by 2002:a17:906:c149:b0:a45:bde1:a334 with SMTP id dp9-20020a170906c14900b00a45bde1a334mr3108492ejc.27.1711036730292;
        Thu, 21 Mar 2024 08:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLAjPwlWHH+uhpm++Xyte28ALX+FmmBQ1UMFwPp+aVKCO/tWvAIb4yfOYkcRBNFi+4fGQDhXBDoSX46ViEtiI=
X-Received: by 2002:a17:906:c149:b0:a45:bde1:a334 with SMTP id
 dp9-20020a170906c14900b00a45bde1a334mr3108485ejc.27.1711036730019; Thu, 21
 Mar 2024 08:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
 <20240315-hid-bpf-sleepable-v4-2-5658f2540564@kernel.org> <88fde9a0bb55c74fe34667e891572d8af9eec21d.camel@gmail.com>
In-Reply-To: <88fde9a0bb55c74fe34667e891572d8af9eec21d.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 21 Mar 2024 16:58:38 +0100
Message-ID: <CAO-hwJ+bTHfraJkpDDchP4k+JDZKChbv8pb+9Wwc7E45P9X-jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:59=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
> [...]
>
> > @@ -12021,6 +12034,12 @@ static int check_kfunc_args(struct bpf_verifie=
r_env *env, struct bpf_kfunc_call_
> >                       if (ret)
> >                               return ret;
> >                       break;
> > +             case KF_ARG_PTR_TO_TIMER:
> > +                     if (reg->type !=3D PTR_TO_MAP_VALUE) {
> > +                             verbose(env, "arg#%d doesn't point to a m=
ap value\n", i);
> > +                             return -EINVAL;
> > +                     }
> > +                     break;
>
> I think that pointer offset has to be checked as well,
> otherwise the following program verifies w/o error:

I initially thought it would be harder than it actually was.

Fixed (with the new test below) in v5.

Cheers,
Benjamin

>
> --- 8< ----------------------------
>
> #include <linux/bpf.h>
> #include <time.h>
> #include <errno.h>
> #include <bpf/bpf_helpers.h>
> #include "bpf_tcp_helpers.h"
>
> extern int bpf_timer_set_sleepable_cb_impl(struct bpf_timer *timer,
>                 int (callback_fn)(void *map, int *key, struct bpf_timer *=
timer), void *aux__ign) __ksym;
>
> #define bpf_timer_set_sleepable_cb(timer, cb) \
>         bpf_timer_set_sleepable_cb_impl(timer, cb, NULL)
>
> struct elem {
>         struct bpf_timer t;
> };
>
> struct {
>         __uint(type, BPF_MAP_TYPE_ARRAY);
>         __uint(max_entries, 2);
>         __type(key, int);
>         __type(value, struct elem);
> } array SEC(".maps");
>
> static int cb_sleepable(void *map, int *key, struct bpf_timer *timer)
> {
>         return 0;
> }
>
> SEC("fentry/bpf_fentry_test5")
> int BPF_PROG2(test_sleepable, int, a)
> {
>         struct bpf_timer *arr_timer;
>         int array_key =3D 1;
>
>         arr_timer =3D bpf_map_lookup_elem(&array, &array_key);
>         if (!arr_timer)
>                 return 0;
>         bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);
>         bpf_timer_set_sleepable_cb((void *)arr_timer + 1, // <-- note inc=
orrect offset
>                                    cb_sleepable);
>         bpf_timer_start(arr_timer, 0, 0);
>         return 0;
> }
>
> char _license[] SEC("license") =3D "GPL";
>
> ---------------------------- >8 ---
>

