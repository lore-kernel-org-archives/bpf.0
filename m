Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1182459DC
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167633; cv=pass; b=TTEBJ5gg39ZG04zpbILiLm1Him7O3etOyjW0Y8JyO3t/q4aXmzb3HB61FBl+k9nOV0s/ICznXoPYhxmDyIrncN75PqnVFRNtqz6dzb1WSJ5Pz4srCaTD0UiMtLgc6PFRPP1fFtU1T34bitkJVISW3fQsUKi5pqZxCWYEIIA+UzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167633; c=relaxed/simple;
	bh=DmyDsQTdgwrdnRnbSEOhvuw4V7/O5lKI/r9PK721cqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbRa+nQSWmO++klz4Fn4kP38U1LWeyT3yNI2sMOujKcyUhmibss56vutyP5UvkTt+ANSmfujSPJvFnPk56M9HXau74q4MrfN0ywQ+ooBXgi3TDWPbtjbrEJels+pbtIhylSsFO5cuOa/yUynCAUrCYbXbrCAWWMuzdQ7LEzmqes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBQ48qUn; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBQ48qUn"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c3259da34so129812a91.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 17:13:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770167631; cv=none;
        d=google.com; s=arc-20240605;
        b=IxmZc3HCd2bjovu0Xca50h/3c6ilgTelw1j3HQ7+HPCyMBOh3Sy89nZ8cUdKOXSP6y
         BcuDKtNZn+YaluwJAiv9hm3nNjoz6IY76qSfmh5Ebs7eVZ4lC25fyyMLC28HUNly8wdX
         k6yrnXn49tws5qZWTcyZI5QIf+FAYHmirEff5LU1I3Bu86t/a9Hg13QzOethougWa+JB
         dzmlSXmzLdWWwKKOVXZRZ9qHUijsU/PmtTjmZDFn1ZYIiV9EFyf4e5/YrKRYcjnXEpF2
         wpTD85+GW8TusjBFT6D9mqggD9bxQzPTQ0Am6sA72KEMHtJhDbxyVOyj0IDYOUBVUSv1
         SAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRe+QoW4e0CJpFcn15WQGAvB6T9wkt5sXE8i6MGhMV0=;
        fh=wSr5An2mWhVqq4U6CQPtzp4O4vipPthFHJwMzpvpjRs=;
        b=h4B1YdXhg5KNQfZNigiX8CEE8yAQc+3Fh8Z//USJEcf8374N4hbJQI+DRGZUqoadAY
         UvNQXGmdE17TZdpfUqjtkK60YvElTSJyILa7YwxWmh9IPPHKg7XebGeIiUctpsx/95AL
         Bs1U/SMT+klJ76WFI1DVBQZeiXI7OaiO3ueEHsY7Yc3Q+43EgmfWxYseHjhCAKaOldUv
         tbNWZZ2p+Hw1Ie1EgghQXmXglO+mc4AXQ3xfGBG9z0XzRGZ6kqum1NaD1n+0Vap92/Bk
         FLEWa3likdt021ByZW8s55+YWjFaq8Ld8AZ6jhXwC09UdWQY1JCF/CrwG6LqTmXf0rkC
         +3fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770167631; x=1770772431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRe+QoW4e0CJpFcn15WQGAvB6T9wkt5sXE8i6MGhMV0=;
        b=RBQ48qUnydw3Aq3ggvacL9SFkJbcF8aTcjNrK0Md8zsMVC7CH4AWL4H85/OHR39KVG
         eFA7yMwStAFTWoUCi6KJYIQYTN7OA5GK3phmXPMUWy5LL0j9qeV/70B6lQVzxUFWvjOK
         sEQ1lSz3cWj+7t11e5g6BR1YQQiw0I3tzAKXIvrvZaZQHe+QMtLyOh0UDgnpvIYUg6HB
         j4m/4WGAvdR1IL984K8iVZN3vlJKBQHjbSEnOLl3bjaOtnJKdF0T6/6SSdHF2CGhxI64
         AStwperL7R+J+iD7JcRp2hHd3TaCcGDBvIAiy2y29lS/WZpnOT2YltM18INpAU3N024C
         o0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167631; x=1770772431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRe+QoW4e0CJpFcn15WQGAvB6T9wkt5sXE8i6MGhMV0=;
        b=nzLlJxsyK9Sfx5EFzeedioVyUJ4dEt1J7UeFk10OHRYmhB5kXqnjrmO/XtoGYnT8Ny
         qYwaGaYhr3aVa/ilvvHBGqjmRhlcjezxkjPZIOAOXXRYk75G340mXIWGCpRKCPXYBvyr
         LSwev4gSenjj8ubzQ7tSgT0XI3RjlHNW324GcdxOASIqpDD4C+YFfhpzOBvYihU8ifqf
         9XzYacklbaGFs+7MG8ZpGAY+EAmpnc0BOs4I4V5WlziVTcAhRcA0RxapBMYICzxELrR4
         hQSF+zE9wRzKR/70UH21Hky97QpO8QJ/y+UVoy3/NcPKOT7/sLC6/yC6BOmgf8R1txmi
         9cYg==
X-Forwarded-Encrypted: i=1; AJvYcCVKtkZREcCIDpwLGVNtI/wy+mbiS/E01r20tHGTAcYBaGca/132G4nPk+hmTFNwMERPUAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZLybHhg5CnFfdatbimaJica2f7Nh7bvSe+dOQj/CWtAjOohc
	DRMVF9+mWn5bxM0SH7GLpUwnaQpbtx6kSSIEvB296HlW0n3FYlrhZvbB6NtJ8T9mmau0xCjbeKc
	2xPTcjwhlJQBOeZhP9G7oSeZhPfAHd/levg==
X-Gm-Gg: AZuq6aK3Hqie4bFWoiWMwcyvzmQPmuQUSEzpvgDl6LlvSvMTKB6oYGPkVN9tdEP8v2L
	3m1ZpQUsPR/8YnmrxhaDUKkGTbzrnK/KaWJLhSs970TgxnooRBXS0jLX2z78AgqVHXsTpGBFCh7
	14ZdPHFoEPlz7z3UidacwQ7z4s9D7Q9kmAyfQU5TfY95ot7s+4wtmsj5TTHJ0UZYUHf+QS4D6rK
	rRf3NoXkGWEZu1vqqZ5KTEgXBLvy+O643S5vanC+6020LR44Pez4tdqoErbsr4JnG3pWFsiOG+p
	XwEVF6ucr6E=
X-Received: by 2002:a17:90b:4fc1:b0:341:8bda:d0ae with SMTP id
 98e67ed59e1d1-354871afde8mr1064836a91.20.1770167631008; Tue, 03 Feb 2026
 17:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128165710.928294-1-chen.dylane@linux.dev> <d41c3d60-09e8-4f49-a8f4-5fe4f7db37e1@linux.dev>
In-Reply-To: <d41c3d60-09e8-4f49-a8f4-5fe4f7db37e1@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 17:13:39 -0800
X-Gm-Features: AZwV_QhSIrQ_48HzHYS_GA0rsb9AhwXfkygzrUDk5xaSJwBMiY_M40SagWnKd30
Message-ID: <CAEf4BzYCj4ZT=a3uWVD9fEL6XQR8ZHzM6oyewBD0H1cHq_uFwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Remove RCU lock for perf callchain buffer
To: Tao Chen <chen.dylane@linux.dev>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:52=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> =E5=9C=A8 2026/1/29 00:57, Tao Chen =E5=86=99=E9=81=93:
> > As Andrii suggested, BPF can guarantee perf callchain buffer won't
> > be released during use, for bpf_get_stack_id, BPF stack map will
> > keep them alive by delaying put_callchain_buffer() until freeing time
> > or for bpf_get_stack/bpf_get_task_stack, BPF program itself will hold
> > these buffers alive again, until freeing time which is delayed until
> > after RCU Tasks Trace + RCU grace period.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > ---
> >   kernel/bpf/stackmap.c | 12 +-----------
> >   1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index da3d328f5c1..2e682d8697b 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -460,9 +460,6 @@ static long __bpf_get_stack(struct pt_regs *regs, s=
truct task_struct *task,
> >
> >       max_depth =3D stack_map_calculate_max_depth(size, elem_size, flag=
s);
> >
> > -     if (may_fault)
> > -             rcu_read_lock(); /* need RCU for perf's callchain below *=
/
> > -
> >       if (trace_in) {
> >               trace =3D trace_in;
> >               trace->nr =3D min_t(u32, trace->nr, max_depth);
> > @@ -473,11 +470,8 @@ static long __bpf_get_stack(struct pt_regs *regs, =
struct task_struct *task,
> >                                          crosstask, false, 0);
> >       }
> >
> > -     if (unlikely(!trace) || trace->nr < skip) {
> > -             if (may_fault)
> > -                     rcu_read_unlock();
> > +     if (unlikely(!trace) || trace->nr < skip)
> >               goto err_fault;
> > -     }
> >
> >       trace_nr =3D trace->nr - skip;
> >       copy_len =3D trace_nr * elem_size;
> > @@ -493,10 +487,6 @@ static long __bpf_get_stack(struct pt_regs *regs, =
struct task_struct *task,
> >               memcpy(buf, ips, copy_len);
> >       }
> >
> > -     /* trace/ips should not be dereferenced after this point */
> > -     if (may_fault)
> > -             rcu_read_unlock();
> > -
> >       if (user_build_id)
> >               stack_map_get_build_id_offset(buf, trace_nr, user, may_fa=
ult);
> >
>
> Hi Andrii,
>
> I send this patch as a separate submission, and I'm not sure when the
> patchset will be merged. After this merged, i will update v9. Is it ok?

See my reply to your other patch set. We should probably just replace
RCU manipulations with preempt_disable/enable and be done with all of
this. (and RCU Tasks Trace is implying RCU right now and that is going
to be guaranteed moving forward, we already make this assumption in
recent bpf_timer patch set).

>
> The previous patchset:
> https://lore.kernel.org/bpf/CAEf4BzbubXxLHsO_2aVBG_oYE1Sc9iafLyvcX-PEjcQ7=
EXWCqA@mail.gmail.com/
>
> And i also saw Qing reported a syzbot issue recently.
> https://lore.kernel.org/bpf/20260128084538.1889001-1-wangqing7171@gmail.c=
om/
>
> --
> Best Regards
> Tao Chen
