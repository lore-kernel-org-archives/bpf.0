Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273B32BF5A
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071134; cv=pass; b=A7qw1ZLhPHZHW+THNWypsaTBTb/oICWvZhf62vaAEFe93wSgBtM8BjSadeU1aluoH7n2EMFcmDhNOBu5tBjNec3mPPA9LzRieZtu/A1PiLZmSLsf8d7Ci/Ft44lt++4VGhzPFXgPDIqJNFUU/9GKRSJSVBRGtBv0DXYfi51upHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071134; c=relaxed/simple;
	bh=w21bd5s3BtPI8VaBfJb008LJniRq6FM/gwcSotoGEXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1/b3wMxT5AdO1nCVJ6lvny/VYX5N7RRs5pS47KxugkMv3o2yCKiXdMLrguSk+s0YuRsHveEPfEskSPXvEp5tsxFfUY60VVZY0lZWrPOjhtMw0H1CRD0xlqwDS1nO/XMhGoYraNvXwEjKc9Ds/dcjGNCypqrXxVhml4Ln+/Gbdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC+/Y1vK; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC+/Y1vK"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a01c80c34so62172381fa.0
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 05:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778071131; cv=none;
        d=google.com; s=arc-20240605;
        b=j+GnKQUi5YZmvliDn5nmJnit7s1gGIA7bGCCALQFUS8e2cGx+jlixEJ903rvXB+rBI
         CRGZjVDi8NASBCRGallvz1hPY19d9fvRFYqurVxtleh+caCsulyAoBealryP5V3nJKqS
         xaVtkh3NaZm0c6qs5ja/sZZt1cwOSFHxpOofIus0tefMwj1AjL+3nKxdBVZHHl1WaKy2
         h3l5uapLTf8TZEKTDIkw/9ocitvjPFq6gh5RisSJCJBEa6fBrTx/wvjLuXfoZJo1/ODz
         xRLa7B/yTYVndwzaQNoSJUZOwEekqI/Bkg2D32h1YJbBNz5S7uYd0i0IbBTQ4sgPpV+N
         au+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rx/XFBRCEQu8HDUik+31Ss6iYuF49qBC+wbiHhNEaa8=;
        fh=jGjJRAAmaq3FR0m9NuOqXsesJP+CTqF6DqvW+NgvYjs=;
        b=kIme/1Wm5HFTGQhJSALU3B32qV9KVCn1m9FNeHE9yS2C/b3tFykme3oA//nRu5/9rF
         xZ0gr0RwUxI6jNhlswzbDBv4cDZb1cW4ZE01pTpt7sbxvYOv/5QyLgU+m+Q7isiTumRT
         /wcblgr4MU0TLbP70bRRSuzxP7Pss3rmOCZOBXl24LyjPBAKvkdxvJwb/QqzX52AawVU
         QomsZVoyMU+2gJWs6u7IlywSfX10pCbLifcEr1shDKePD/5qeuApJI8ufhyvSxpf7pwC
         7AxWkBTdGUz8X+ivgPxzRsBOlTYzuWgNBaZ4BKOOz35iI1xP77TkI72C8X0nzMlbFn+o
         KYmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778071131; x=1778675931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx/XFBRCEQu8HDUik+31Ss6iYuF49qBC+wbiHhNEaa8=;
        b=mC+/Y1vK8JKxzqd+/gKhCRX5rKyx2AF4YtSdKhlxX+VEyVeSXFbpkUcAE5/Eu1VUXL
         nOIOodoWvsXUdvhhNAmRNEsvU4VuEbm7L0+nOScJxTDw7/CAv61DqlZW/NyxmftcgfCP
         k37J9MHqswTCLZeN6m9DAn/1IDtGaRO5kWTl+DtgI+Y+xIWfwuDFZHaERP35sjad1ehm
         mEahV0F+fPvq3wUf7VhpLHzpO2rrCNaxgqkKz/pNLGoVrVpewM3ZFMzPP5fMWECa8xrG
         94fhkDXqIMTMrNEk7XhMN0trRuWVfY0y9ODW/gb8flFrPRmzng+Fsc7Qm08XVj7Hkmyw
         S6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071131; x=1778675931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rx/XFBRCEQu8HDUik+31Ss6iYuF49qBC+wbiHhNEaa8=;
        b=ZsncB21W/dpphzcPhx/bqL1pZHcj+DK3idXz4rwIehJOBIUupPn+twCmwRVet0M3XK
         PoWg83AZBGhgitehyp55uLewfK+TUnvnA5Pl6p7Z2g0ytpMCrOSU2iAii5O02VHxkk+B
         QnAuZjfE76ydQHQn0kLDBiCrMUZPwBQa66IGEbZOB22LZeAqXTJazp/VSZpwyxc4Jip7
         pZNDWvTtdXcJc6vfW+UUGs8r12YDr7eFG+0q0NuNxRH4Asipmu9NBtzv8/8AN8gbwCdb
         iw9qX0BzV+FxYEFqD6sDAijuw+CoF2De21ASFOycEzyciLaf4jFfz91cRi7q5C0E/0+s
         9qNA==
X-Forwarded-Encrypted: i=1; AFNElJ9QADyKCJ5dpS+8RvhxRYKXD5fvHQlOOQCWgoNNdwosFZS9KPaw9FRY2pufiYG7lkqT+Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/EsaRW6oIRayFYoPRPur4JDVo0toVbZpOhHs38o9tYYRKxIA
	uGsS5qtskCPjY4pdqgGfkGXwT0ytYofRh8VtBO8GbMHfdsEP49NikCvkx1yPmZVTuFs4jQWF0my
	apCiGwxbyAbUZ+SEHmNNdCHXdJI8Xgzs=
X-Gm-Gg: AeBDieuQNpeLAmSESQ/lzeSSRAaiVU8jkaW4w0QcyOhYzcjOY2vEQvD3pm2JQ0dLIOS
	JLRY3IL1q2x8KUSjBk6Uciz7iApG/1Rf7kG29JoLpAfxwe/dIe8Ex0cEfgwSut9eYk8zQLyjitV
	gjnZo0uXtaw0zfrE9Nhbcg+lOePTrLsd+Z/aU1yMbHwXaVBA5NpcIUrTGEmlxA47EOeLBQGy/Z5
	7p/MR5Aw29G8+zaIAzYF46RXHSghYCfqHGb/0pnBHC6gVzD9nZHPV0xbctyDdJQfWOETgoz3Knh
	8t76DeVCdzWlGJPRCVb7
X-Received: by 2002:a05:6512:3c93:b0:5a4:11e:5c7e with SMTP id
 2adb3069b0e04-5a887adff04mr1090469e87.5.1778071130517; Wed, 06 May 2026
 05:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165024.1526680-3-vernon2gm@gmail.com> <91c02dbb561c7a4d760ff3314c99fed77870e0d7665848b5832f6719d21feb17@mail.kernel.org>
In-Reply-To: <91c02dbb561c7a4d760ff3314c99fed77870e0d7665848b5832f6719d21feb17@mail.kernel.org>
From: Vernon Yang <vernon2gm@gmail.com>
Date: Wed, 6 May 2026 20:38:38 +0800
X-Gm-Features: AVHnY4KNmriAzvSUTSBe2OOUqmXce4yr6SLVLgUurI33PcXDXqVQ_V3zHDt9EOA
Message-ID: <CACZaFFPAv4PdJBfdsT5Gzk3quvGYHh15gt9yxLdKLYW=sq0LOA@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: add bpf_cgroup_{flush_stats,stall} function
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, surenb@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	baohua@kernel.org, lance.yang@linux.dev, dev.jain@arm.com, 
	yanglincheng@kylinos.cn, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 1:23=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index baa12b24bb64..d7b04f1fc9f1 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
>
> [ ... ]
>
> > @@ -2819,6 +2820,32 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u6=
4 cgid)
> >       return cgrp;
> >  }
> >
> > +/**
> > + * bpf_cgroup_stall - acquire the total stall time of cgroup
> > + * @cgrp: cgroup struct
> > + * @states: psi states
> > + *
> > + * Return the total stall time.
> > + */
> > +__bpf_kfunc unsigned long bpf_cgroup_stall(struct cgroup *cgrp,
> > +                                        enum psi_states states)
> > +{
> > +     struct psi_group *group =3D cgroup_psi(cgrp);
> > +
> > +     return div_u64(group->total[PSI_AVGS][states], NSEC_PER_MSEC);
> > +}
>
> Can cgroup_psi() return NULL here? Looking at include/linux/psi.h, cgroup=
_psi()
> returns cgrp->psi for non-root cgroups, which is allocated in
> psi_cgroup_alloc() only when the psi_cgroups_enabled static branch is tru=
e.
>
> When the kernel boots with cgroup_disable=3Dpressure or psi=3D0, cgrp->ps=
i remains
> NULL for all non-root cgroups. The sysfs *.pressure files are gated by
> cgroup_psi_enabled() so they never hit this case, but these new kfuncs ar=
e
> directly callable from BPF programs without such gating.
>
> A BPF program could obtain a valid non-root cgroup (e.g., via
> bpf_cgroup_from_id) and call bpf_cgroup_stall on it. If PSI is disabled f=
or
> cgroups, this would dereference NULL at group->total[...].
>
> Similarly for bpf_cgroup_flush_stats below, passing NULL to
> psi_group_flush_stats would eventually reach __psi_group_flush_stats whic=
h
> does mutex_lock(&NULL->avgs_lock).
>
> Should these functions check for NULL after calling cgroup_psi()?

Good catch, I will fix that in the next version. Thanks!

> A subsystem pattern also flags this as potentially concerning: the `state=
s`
> parameter is used directly as an array index without bounds checking. The
> backing array is declared as u64 total[NR_PSI_AGGREGATORS][NR_PSI_STATES =
- 1]
> (see include/linux/psi_types.h, struct psi_group), while enum psi_states =
has
> the range 0..NR_PSI_STATES-1 (PSI_NONIDLE is the last member).
>
> The BPF verifier only checks that the register is SCALAR_VALUE and does n=
ot
> validate enum ranges. Because the parameter is not marked __const, a BPF
> program can pass any scalar, including values derived from map lookups or
> arithmetic.
>
> Passing PSI_NONIDLE (a valid enum value) reads one element past the inner
> array; passing a negative value (legal because enum is signed int in C) r=
eads
> memory before the array. This would leak adjacent memory contents to the =
BPF
> program.
>
> Existing BPF cgroup-stat kfuncs guard against this pattern:
>
> bpf_mem_cgroup_page_state (mm/bpf_memcontrol.c):
>         if (unlikely(!memcg_stat_item_valid(idx)))
>                 return (unsigned long)-1;
>
> bpf_mem_cgroup_memory_events (mm/bpf_memcontrol.c):
>         if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
>                 return (unsigned long)-1;

Good catch, I will add bounds checking, in a format similar to the
above. Thanks!

> Should this function add a similar check, such as:
>         if ((unsigned int)states >=3D NR_PSI_STATES - 1)
>                 return -1;
>
> > +
> > +/**
> > + * bpf_cgroup_flush_stats - Flush cgroup's statistics
> > + * @cgrp: cgroup struct
> > + */
> > +__bpf_kfunc void bpf_cgroup_flush_stats(struct cgroup *cgrp)
> > +{
> > +     struct psi_group *group =3D cgroup_psi(cgrp);
> > +
> > +     psi_group_flush_stats(group);
> > +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/252852=
79315
