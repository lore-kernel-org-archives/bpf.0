Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F043FC5C9
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205873; cv=none; b=BGmfxMw1qpdn5bTosp0alhfyxmfnUMrUF3CrX7yAexSEMSsuLV0cwbsajAYVM1dlWbYMrU9Om2Ltd3JGaPzfXwiqxWnLLrASsMkaSS4iRoKUzbfr7UIV3hyFZCqSAxjYR4Ntv1ENyeiI9BGe8mOqs6jbV+zHbj+0nQ8hZ2c7Bmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205873; c=relaxed/simple;
	bh=1zrmgYcYN9U/0LcDFMpa3ygR5RH41tAB5a1WbIjTGBM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=naz5YlqEgkUcS+JQJYZjVV8TX0T4CRQ741ELvOHkhu+5/Hnv4HTr8mcUZeFXeqpz+t397LxXGarl1kbUOC8YdKA0uY7f6Rz1fG5ec3onsZ235qRtCcrwRZin0OOjxwM8as5XEdExpHkNIj+FBh599JmInux7CXOuXU7fp3NdH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiH0dqcg; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiH0dqcg"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso190884a12.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790205870; x=1790810670; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UxqAlmTY5z/mmeHodrtpNgrhuIDbFvZIijyG7PkB3O8=;
        b=LiH0dqcg9cHGx4/lx+JOYRIlTss2mvN5iH5de5jL0hF+hzFsszfrRcDgNMN0G8U+wK
         gbbvxN/+HG13Fx9Y7uWXT1LflhZr2smCd0btHEhouvH3dLeMZyA6wR6e2vbZ8n4CLq1X
         ofC+F5m1Au36zcmkaCaMXzCtx6mZtEZk81+DrnuHP9apbvvVrtRYeTmcz4p24yVif+Fn
         aLnYmVSBEsG4VBlcluCiZNcvXkevmYIxeDdB038115O4N5EoTuslxnv8Wz8jGqbT199C
         TtsLCMQDmUy3JrI/e9qBsE+xeQs+pnAt9n8xa4bm5XlBE4DVTcUkkQDDcVrMC3VImuMy
         haDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790205870; x=1790810670;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxqAlmTY5z/mmeHodrtpNgrhuIDbFvZIijyG7PkB3O8=;
        b=qo8SV8vgVAgoz0UEKl4/lLZqUrbnMk9vNVmrKrSZflC1uTv2v1Vdzo/j2O0Az7C8Xb
         A4z8d+U4HOj1nFffslqpCCloie8moyJUDPYCFaW9rO4nea+aXOT8SRZYjUT5rVFJLjIr
         pjuIjcBdRTZR48nX2SMl5SKNuIlQ0R4vXL9MWNqnDL9qak8zEA+SPxMbd+4UOWzLYy6y
         ElZQUwy/B2BPbUIQV+c5HyzqYR23KOjowwxfeQqfuHZciqdvvGpB+99NjQAJFm4Si7pl
         GTD+jLPUG7D2woNazV2qzJr21sagvhMgkBuZP1YeKpB6Y1NetA7tTgEokUasRz5V8Ugw
         z/SQ==
X-Gm-Message-State: AFuF++nts7RofSOpweziIsMptaGrMDAJJn+49adJHnAnVX5/ftdJHpzU
	HAkszmoh89vtLvaeYqhqsG7ZmtgsFNq39SeY5lBoXHcRhVJYzaxN6jSv
X-Gm-Gg: AYBFou3fm4rbGyKyBG3LmY0pKL8aGHBy5s+oJdCptjRRVL3JaVAzBOx4WaNeHH9ZH2g
	vE3iK70i4yyUUYAyyCTyPcauozrFonM6KVydxrjz3pd5eR4QonAPUAkcqR5/IQf+AK3URDY8jLx
	L8+5hrq4hvc4lgfHoJR+7DJASu+Eqp/4IgtyyabUX0pO+0qcb4U05ml1WMpK+ORxA8w8Knc7a0O
	zbz6ydZRGyuW2nVZZ2CN9DboKSxxRKl3BqDFIlNpBl40Cpecc1lDWHWN+JITX5p0iF6yQ9NzC1K
	7Av7iL0M/zwdGgRQgSeRGJjwyW/q2ig9ckOkkoGlJsLtv6o1NnzAl0mL8QygrPuiBvbq82zADOR
	NY4/BZm1IMkOzIrxzN0XTknpBD7S2Iblh+sn+trUDMh5Zm3LnEVCboIqlhNcMyrgt/PIfqbxAcA
	fLmJ2RWmqARlDpwJ8q2J/y5fhkdbRk9DWWbDAIjB7vE7ZyaloyoGiTsBiTInAaS0cf28KyARaVa
	FAEFLr6TUfZxglC4GTYzNBdxzo0e66xEN7JD5cx5gAlVTtBrCrUQ+XzvIflxtdaXbsnNm5eg+fE
	Fe8=
X-Received: by 2002:a05:6a20:6a08:b0:3db:752:f89f with SMTP id adf61e73a8af0-3de0e72a029mr485462637.2.1790205870266;
        Wed, 23 Sep 2026 16:24:30 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3b82aasm1812239a12.9.2026.09.23.16.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 16:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 23:24:29 +0000
Message-Id: <DLN30MYFP3U2.1BH9I50MEBUEX@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, <eddyz87@gmail.com>
Subject: Re: [PATCH 2/3] bpf: Add sleepable arena page allocation path
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260824082530.47553-1-emil@etsalapatis.com>
 <20260824082530.47553-3-emil@etsalapatis.com>
 <DKYHFTVFY5T7.1TLXUTDOWQXF7@gmail.com>
 <CABFh=a4H9_3pkFzgyrooz8eg=8pa-f_JHK3XdLSvTfV_nVN8JA@mail.gmail.com>
In-Reply-To: <CABFh=a4H9_3pkFzgyrooz8eg=8pa-f_JHK3XdLSvTfV_nVN8JA@mail.gmail.com>

On Wed Sep 23, 2026 at 9:48 PM UTC, Emil Tsalapatis wrote:
> On Wed, Aug 26, 2026 at 1:25=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon Aug 24, 2026 at 1:25 AM PDT, Emil Tsalapatis wrote:
>> > The bpf_arena_alloc_pages() function currently only allocates pages
>> > inside a spinlock critical section with IRQs off. This forces the use
>> > of alloc_pages_nolock() in the BPF allocator, even when the caller is
>> > a sleepable BPF function. This in turn causes allocation failures even
>> > in cases where falling into the allocator slow path and possibly
>> > sleeping would eventually succeed. This can be triggered consistently
>> > by heavy BPF arena users like scx.
>> >
>> > Add a separate arena page allocation path just for sleepable callers.
>> > The path preallocates the arena memory to be added to the tree before
>> > taking the critical section.
>> >
>> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> > ---
>> >  include/linux/bpf.h  |  6 ++++
>> >  kernel/bpf/arena.c   | 76 +++++++++++++++++++++++++++++++++++++++++--=
-
>> >  kernel/bpf/syscall.c |  8 +----
>> >  3 files changed, 79 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> > index ffa5626411ac..d15ed7a3879b 100644
>> > --- a/include/linux/bpf.h
>> > +++ b/include/linux/bpf.h
>> > @@ -710,6 +710,12 @@ void bpf_map_free_internal_structs(struct bpf_map=
 *map, void *obj);
>> >  int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
>> >                                  struct bpf_dynptr *ptr__uninit);
>> >
>> > +static inline bool is_bpf_alloc_nonsleepable(void)
>> > +{
>> > +     return preempt_count() > 0 || irqs_disabled() ||
>> > +             IS_ENABLED(CONFIG_PREEMPT_RT);
>> > +}
>> > +
>> >  #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
>> >  void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__i=
gn, u32 page_cnt, int node_id,
>> >                                         u64 flags);
>> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> > index da356989786a..126ddae763f9 100644
>> > --- a/kernel/bpf/arena.c
>> > +++ b/kernel/bpf/arena.c
>> > @@ -683,8 +683,73 @@ static int arena_adjust_tree(struct bpf_arena *ar=
ena, long uaddr, long page_cnt,
>> >       return range_tree_clear(&arena->rt, *pgoff, page_cnt);
>> >  }
>> >
>> > -static long arena_alloc_pages_internal(struct bpf_arena *arena, long =
page_cnt,
>> > -             long uaddr, long pgoff, int node_id, bool sleepable)
>> > +static long arena_alloc_pages_sleepable(struct bpf_arena *arena, long=
 page_cnt,
>> > +             long uaddr, long pgoff, int node_id)
>> > +{
>> > +     u64 kern_vm_start =3D bpf_arena_get_kern_vm_start(arena);
>> > +     struct apply_range_data data;
>> > +     struct page **pages =3D NULL;
>> > +     unsigned long flags;
>> > +     u32 uaddr32;
>> > +     int ret, i;
>> > +
>> > +     pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_A=
CCOUNT);
>> > +     if (!pages)
>> > +             return 0;
>> > +
>> > +     ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, page=
s);
>> > +     if (ret) {
>> > +             kvfree(pages);
>> > +             return 0;
>> > +     }
>> > +
>> > +     data.i =3D 0;
>> > +     data.pages =3D pages;
>> > +     data.arena =3D arena;
>> > +
>>
>> Why have this split?
>> Always use an approach of allocating pages outside of the lock?
>>
>
> Mainly to avoid multiple kmalloc_nolock() allocations outside the lock
> for the sleepable
> path. That should matter for larger allocations. The two separate
> paths also stay simpler
> than if we had a single path (at the cost of a bit of extra
> duplication). I can change to a single
> code path during respin if you feel these are not worth having two
> internal calls.

Hmm. I would think one way to do things is easier. Less branches to worry a=
bout.
Give it a shot? If it looks worse, then keep it as-is.
