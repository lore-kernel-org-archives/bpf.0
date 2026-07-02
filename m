Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05934E777
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970864; cv=pass; b=cBhCgoMz/IJZMQc+rCT9M8ltq1IOBg7kY7kiaWcosS1EzZqv1S0Y8+CThyYogWjFoiU024LJEm5sp9V2HD6KrZq4dx9vG34W6o91/PJhm1TLNhn1ly7kVzAbrcethizmwFxC6Hzvzdwt8RfvSGogZNmEgnnYbY1VpoPq54Ge85g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970864; c=relaxed/simple;
	bh=IQ/c8WVDoxQrhZvKSrnPQbv4b/9COlcR710Od8nu4tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRCYqc3A9ZaCAryXvKG2n2cbMz6l1i04ZfGaci8MEGAULadMd3X4w0/JoPyOip6++g7vkynH5edCGEnzgBJNr6K6K2uWSu8Y26rIeqKoFPF/YauU9SxMj0I9Kk0OTDkvR+w5saPtfolZCoOvcP6UEi8a9inW8ZicWKvcjmJwsgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZnbC/SR; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZnbC/SR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so1021317a12.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 22:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782970860; cv=none;
        d=google.com; s=arc-20260327;
        b=YEVNudJU5GRmqTQHd8/mvro/6NjEQCYMcd5aQk0rF4LpeESCVXEcFAq+3STe8ZxW//
         znR0p9bYV0hpp8NAfR2tPlbc1bN+vyB9FV6xrPTmDymhY2LgcB1A0uJUo86E0hxTplys
         Brnr385E1rkCak/G545r48FukCHXHwVv9wIKSaveNCjnzVF58vA0C0ROCGbzzSovWylB
         2CbnxjNuH7uX0iOrelQPl+Hp6o+H+QZh6sGcDkgngMgzoKRHttLtX0aIFddmAVuJWFAP
         7dCF57KkpVGx9NEILGt2zujpu5f55DtcNCUThrJoe3SYBlDZV1hcZktOFfmD7DD/dZKc
         3zZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5UfvAgJ8YjTczByfeidWqKA0EosDZTFgQFu0/uNWSo=;
        fh=SvUFgCbfcniZAbc/EmJ1tILJ96lPK51DgcGWlM2Np4Q=;
        b=r5h/jqJNadrjRgBmZu2+6pitBkFqRhEY6KZ59hwniLJndMhp8AHgycszlglr4MkBVJ
         PEcPN/U5mUA5+aCDjgcRiZ05P9trtGsn2+AuTH+CJRoB1YkkDZc45TpYrBSxMhKziyxb
         Tl2oLHyYfvJAyk2+Ufc9/xhW4A3/izO0cG/2i9lCvUb0tG21jfiTBDd5TTICfAwFkMSZ
         6/AW6cWBNm95wXNH8QffOj+wbJQHSSm4Dz5gMl7+c9NXLdB/uFfLo/Lymiw+uFHJFxuc
         pOFiYsBrJH33T+yfDq7b2SNv0rQvAyvB8Uv7dtaYEDs5Lx+hSNnYnFVmyl5VnlOE1304
         Jk1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782970860; x=1783575660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5UfvAgJ8YjTczByfeidWqKA0EosDZTFgQFu0/uNWSo=;
        b=hZnbC/SRBH2AZkGEnTPMfGm08niGDg9CuWxkmErjq29CGkUCWbo6Mvd8CtiGR9ASdZ
         svLyYIWDbfmKULY1Nr15+A5PlL9JqJTI5aULm2/+w/ATMJIb3LEY0+NYI5LP7h1d8VYQ
         Mi4mCId1feAE70jV9MfB1MYLkBg9IYRoItVB1jcyNdwPPiLG3K4wHgOqhq4oDIf5smXv
         zv2ilgMQB24O6zy88bkZX0nwk5Dn7ioa/uKrGmxwCwwk0bTLLdNJdcOvQWaIwYACVAnn
         MCNs5R6pPyoQecQjdDDMJvH7J5yfTeJqZ8p4BPORnjeVTVPD1Lo6hzdrr6wjsUvmv8qW
         CPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782970860; x=1783575660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5UfvAgJ8YjTczByfeidWqKA0EosDZTFgQFu0/uNWSo=;
        b=Vtp+onrd2gOD0CXPp9Eto+lxAhVqwSb4pFHZUtvQEWdUFh2JNO1Ng0wvPBdOo4MYJn
         i88iJCtnsegKcy/5+UThRr9+4ktY1NspRZGKXpkV+5Tx3Boe/7/EQzjUPGKpGw+qnphI
         wl+m1fRAhY5X7CfLEYq+TbdnyF9i0hACVUg6nWSOHN81GD/T1NlSnqZ6OGpdW7iKlNeJ
         FsKo3+OvbwmLO8s9qX0ryQt1WXWpF6gza1i8Rg6H1s46Bjm7TgA9EFm4OflC5y/eLTwr
         mDB1jYNiB4skQZTEVHhRDR0BZnqDNrXVuLXwghhiGbq9HhuA9x4efWqcgOAJL8ViNNn9
         wYKA==
X-Forwarded-Encrypted: i=1; AFNElJ+rNUzBb5zZGFbSX+/kVa9JhnqTd0GVsmlo4Gzq37Rw7NFPG2SnCPppQ2jfDawW3vR+8qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWy3e0jVkLdddT+ulB7MitujXEcmvdkUlL9o7EV28bJw2qWfyr
	pEBGrsmvrxcZYKuPoeyzCTRLMx62vVKkKX7BrteIfNFtCtvI6hJmWjCU1t1yhjiDIeKtvEzXOik
	inG/fQRZ2by8kj1JcEE1qfEforLMpTHE=
X-Gm-Gg: AfdE7cmQ10ISf2QLeA7vtgEsaVgZizTUIPpsZaaYtwdjspgK6v9UHxkVibtqvm70/Dd
	bfHO0XzyVuo3KhUNbvObEYB6tz1VXS5fHWLHKyQ5FGP3olYobrEdmGZYXWf9mgQ2fNVZZjDjzLf
	yaoYmPCe0wiWvSF20o1VKiGtF3zK1zz9CjTgrZcXtT6gPOvyu+ZpLtAgegPEu6bTNVVGVfyVIf0
	imOFY55u3gWV7PF/mWDc5iIPwlcsJ4wigsrN6Sf7MfSvTaJXvhiKX0vfel3viRgHOFCSl3SXIEp
	5wV2Sg0Tni9HjWtm101iHONlEDd3agZPJfVGEPK43NeXlm2aqZzxqBxfRJ6yCQx91DDuxwmEfcf
	a9hHw7ZQ9ZfyXYw==
X-Received: by 2002:a05:6a20:9f93:b0:3b3:fdb0:2295 with SMTP id
 adf61e73a8af0-3bff3ffaea9mr4293388637.6.1782970860276; Wed, 01 Jul 2026
 22:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4Bzb+OOrdGyxbzjh=7MUEbA5FC05E6_iwCjDXcnSO-HZ=ig@mail.gmail.com>
 <tencent_30FB52DFC6440984EEF0EEC70C90A7DAC606@qq.com>
In-Reply-To: <tencent_30FB52DFC6440984EEF0EEC70C90A7DAC606@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Jul 2026 22:40:48 -0700
X-Gm-Features: AVVi8Cd_Aydgpi6ybanaT5W1RYtoYBPVPSh1YD5O91Uma0-voa1CtKjxUtg_WYg
Message-ID: <CAADnVQKvNewGNAoiF8thaqaWuZCFxzeXU3QHg8jP8Dmqag6_JQ@mail.gmail.com>
Subject: Re: [PATCH v5] bpf: Fix smp_processor_id() call trace for preemptible kernels
To: Edward Adam Davis <eadavis@qq.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, sashiko <sashiko-bot@kernel.org>, 
	sashiko-reviews@lists.linux.dev, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:35=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> On Wed, 1 Jul 2026 12:57:52 -0700, Andrii Nakryiko wrote:
> > > bpf_mem_cache_free_rcu() maybe called in preemptible context, this
> > > will trigger the below warning message:
> > >
> > > BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.1=
7/5820
> > > caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
> > > Call Trace:
> > >  check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
> > >  bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
> > >  rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
> > >  __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c=
:3349
> > >  bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
> > >  __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1
> > >
> > > this_cpu_ptr() requires the caller to prevent task migration.
> > > These helpers currently do not enforce that requirement and may
> > > be invoked from preemptible contexts, leading to accesses to another
> > > CPU's per-CPU cache after migration. Use get_cpu_ptr()/put_cpu_ptr()
> > > to pin the task while accessing the per-CPU allocator state.
> > >
> > > Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kf=
ree_rcu().")
> > > Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory =
allocator.")
> > > Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Dfd7e415d891073b83e1=
f
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> >
> > from what I can see, bpf_mem_free() is called through bpf kfuncs only,
> > and all BPF programs run with migration disabled. So this seems like a
> > false positive. For per-cpu checking, it should probably check that
> > either preemption is disabled or migration is disabled. tl;dr, there
> > doesn't seem to be any
> Today, I researched the call sites of bpf_mem_free() in detail; it is
> called directly by bpf kfuns only.
>
> Different BPF program types execute in distinct kernel contexts: for
> instance, XDP and TC typically run in non-sleepable networking contexts,
> whereas `raw_tp`, `tracing`, `LSM`, `syscall` and especially sleepable
> BPF programs may run in contexts where preemption and migration are
> enabled. Consequently, any shared BPF code (such as a helper or kfunc)
> that accesses per-CPU data must not rely on the caller having disabled
> migration; instead, it must internally ensure that CPU migration does
> not occur during the access.
>
> Taking into account the CI reviewer's feedback [1] and my further
> investigation into BPF programs as described above, the adjustments
> related to bpf_mem_free() should be retained.
>
> [1]
> https://lore.kernel.org/all/20260630094823.897BD1F00A3D@smtp.kernel.org
> >
> > pw-bot: cr
> >
> > > v1 -> v2: using guard against preemption
> > > v2 -> v3: replace get/put_cpu() to bpf_disable/enable_instrumentation=
()
> > > v3 -> v4: disable preempt to make this_cpu_ptr() work
> > > v4 -> v5: in mem free disable preemption
> > >
> >
> > maybe throttle your patch resubmission spree a bit?..
> My earlier actions were driven by a desire to keep pace with the CI
> reviewer's response speed.
> Moving forward, I will slow down the cadence of new patch submissions,
> as you suggested.

Don't bother. You don't sound like a human.
Bots are not welcomed here.
