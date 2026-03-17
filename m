Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670F280A21
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767804; cv=pass; b=sgV1P4eBNC2IDL9v6CkehYLzv37LiShaL0/aqt5GLMGxfg+7X92COU34JLrjOowdD5o8Y8bpjbfeAgXjxYkWFbshZxvrxW6Py3qk/dDmiJYZTkIP+rNnTNY36LnViuHnFU2OEHOTSFlDf4EnUjlb4hAaRKAFHlfK3LqK+aZeTTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767804; c=relaxed/simple;
	bh=sNoN/Xh8CUgNjwW3bTkJAIWBkTvsjLmibZC6m+YJO2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ughyWEVAvA063tH00f4hYIYEnDQ+ZVZeaGO2YxQuKPgoJoBAyXosHBYDAtRbJIWTRbe5N77Bx6QtUJV9971NkIY2BbcLsikFFhcNM+X8pt/qKYa4bTJTkpPQ0Rm7FnWcl2sC+9hxi8YhiipavOf9BUP/sJPMELYuW6ziM4nhkxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDZdws6o; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDZdws6o"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad46a44easo5814799d50.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773767802; cv=none;
        d=google.com; s=arc-20240605;
        b=aarAM587lrUqBHU3scXYg8gUHRxsl2ddjdfSWV+xlXymgKj+CwZ7y49yKLmweFLW8v
         2oiubzG6M2+ufv+7PC1q3OpPvESi9ILXbVPry9XrflonxI4HLoz/2HpgTZGQd3ISUsiM
         kjt5hYnVgS9sgndHEhZi8v8c9ZMpCcq8xvvzpdeuVWQ041Bb1y5ynx1/F96gD6IWgnSX
         UapOi5sEc+j2dOiXP3uG5AKiVUMlgSmLiEMKz5pf+IM8CuGatMlC9xJWHfePddddoqqi
         gZTCO+GaSMmtV+1QIxNEljGgwuxipqkGVlrj2jrEoWU0/4KNQwEptmTjpqQXSNCpt+44
         DoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q2zAeBs9zo2lv0T0WIuTbdsujf/BJxEymoy13o+3BzM=;
        fh=hWUCnLYgBpv/1SPwbOnkGuYo6ovL5GADs9zeWVLPdik=;
        b=hdejUPAjXlvv9DB3I/6F/bYABMqViGEoz3qyEn4SCUsOXtGR8IRcDhRsuDwWNsXgvm
         qXppVdDoGyp2Av63oB/CJ6kMIVXchQAaZIZfiEOz46oj+0vWtXztQcOuRXnnvvQ7zwh2
         7liHYPGR8pnjkp/PhiN/N/oa+Ulj2VRbAKub6IgIzlhLWBVldmTveN5UmGgIrO7dKoUK
         PDAtEcscNEIxD7ssJcmSzDQlhwLHUiAooQSuPCcDWyG3idM81I6g1RsssVB+w9Z2noMr
         2D4sZ3RTAy1NJdIjpLIGMFsppB+5cYg6/B6aa6Tu+izMxOzs5fxvteNyLIQBYlsul/ag
         zVeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767802; x=1774372602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2zAeBs9zo2lv0T0WIuTbdsujf/BJxEymoy13o+3BzM=;
        b=WDZdws6oWYibPv8VCzNsED4TQ3bvSZKG1FPSWVALzrEK94AumASStnR3Y/5H6Ep+oe
         TMLNDjLxtYz8W2Wl/9Ek+o3kjMKzUw0WbbnfWZZ+HMSvG7GJbnyrtFrx7238XdJ02Vxq
         9JXeKCQoKHJ1AFlpqSCXIUIhdL365yGnFI5qkPhXPscH1+Nh9SrhCkkunYNmnz67ICxG
         mdQ+sYL/bXC36O1wyH9tB2/2gD1fqhJDqidmMXB9WNUM4PsjyNOFEB/GMY17HyP4Pmzc
         UVImJWPJHEbsngz5n/YcloejxX/AOsEu3sSg4YhRGEPShejurxuI/zO0+4VrmS/8BvmS
         vtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767802; x=1774372602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q2zAeBs9zo2lv0T0WIuTbdsujf/BJxEymoy13o+3BzM=;
        b=jz9IbSzNekHUNP5O9Mcnqh6vBJLgd9FHoiF004H1h5iFErpGgyIjDZDPN2qngDiVhv
         2B9H6B4QbA56RBXWkGB728AkYlonugt7op8Wm6TsvOT+e1dcquNCCj2up+i+40Nmj8zQ
         Oe2bTB735aOaHGaEv51DP+HZKGFSfToqHxfXutvA+eYGM42/deRHBaokGLA58W8LUalw
         v65DoEPNTZkehk7udJE1cJj1tlRJoXY33BJklQ1WP8V0qlrLsvpGMyfY7ieIHWwUp/hV
         4WVbFUjGhHmfi6XBtoGBWFFlCIACDZUHMrzNja35T/cFDVyO9jdJdbEbxuW/xqH4kTu9
         isEg==
X-Forwarded-Encrypted: i=1; AJvYcCWEsGJauerLYIH0tSSLjcHn+us+7eyO9bktanhsjAG24Oo0e/kiH2A75ERXyH9WDMtKKaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhiURy4nUSqKkR9H++MYGTeVNp5keUJGgS1uWJ0HBUqozsESpr
	YF5aR0E7tmoeidf8HHXb19u8+Tz6bKZyxhs8WG+QOoaDVCH98TkUq61PbEwICxYbCrptQoaOJNL
	/P6fS8/WBXBb4MQ5TvFi5oVgRl2WtyDw=
X-Gm-Gg: ATEYQzxWN9wUcfLmNLvTz7RiBJLQ+Alv2BW/FRf4KVAyYc+SwtJyMH7CVqCi5nYJ+7q
	hXfp6j6srW7hWsDNBrFzyK4VHaBGIkkTzZyQE0xFhoTNpAhCUcm+WNJCHrslZPUqvht2U64Cx8B
	DreWWo3PWKlmX+I1dMBEdxT2ifZPdhUTw7waOcj625WPAbDxhXySG//pVDF468qQbXRlhg0atle
	KO1V+0cm1SYFRlgBnIwCjPDEMwveyPyT0jFIr4qEI6Vd/BatnSTHvD5Rr7CV+GCf65mZlmahmIw
	3BbTgpI6IKI+OnfORGvw
X-Received: by 2002:a53:be4b:0:b0:649:b31e:8f4e with SMTP id
 956f58d0204a3-64e91619389mr343424d50.70.1773767801490; Tue, 17 Mar 2026
 10:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
 <CAMB2axN9xYPzAJVQVywx3sxYa5ViRxt2oktt1LFXsSD_XsuJrA@mail.gmail.com> <SY0P300MB07691E08E5283FE074C81BE2C641A@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB07691E08E5283FE074C81BE2C641A@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 17 Mar 2026 10:16:29 -0700
X-Gm-Features: AaiRm51gOU8njsC2VoBSF2OL4VzOChb4st-LR63ZRP8xg4-IJKtd30ho-twlx18
Message-ID: <CAMB2axOw_qZQ2ksTPSVb7LqAGv1sxjA9u+EyfE8ygd4Rxa9BGw@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when !HAVE_CMPXCHG_DOUBLE
To: Levi Zim <rsworktech@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, stable@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:40=E2=80=AFPM Levi Zim <rsworktech@outlook.com> w=
rote:
>
>
>
> On 3/17/26 3:53 AM, Amery Hung wrote:
> > On Sat, Mar 14, 2026 at 9:02=E2=80=AFAM Levi Zim via B4 Relay
> > <devnull+rsworktech.outlook.com@kernel.org> wrote:
> >>
> >> From: Levi Zim <rsworktech@outlook.com>
> >>
> >> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
> >> For example, this causes bpf_task_storage_get with flag
> >> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
> >>
> >> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> >> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
> >> for correctness. Add a comment about this limitation that architecture=
's
> >> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
> >> bpf_local_storage_alloc always fail.
> >
> > Let's not do this.
> >
> > This re-introduces deadlock to local storage. In addition, local
> > storage will switch to using kmalloc_nolock() entirely.
>
> I noticed the PREEMPT_RT case needs kmalloc_nolock for correctness and di=
dn't
> disable kmalloc_nolock in that code path when !HAVE_CMPXCHG_DOUBLE.
>

It is also not correct to use kmalloc() on !PREEMPT_RT. A BPF program
in NMI or tracing kmalloc internal that tries to allocate memory for
local storage can deadlock.

> But in the original series [1], It appears that switching to kmalloc_nolo=
ck
> is purely for performance benefits and not for fixing deadlocks in local =
storage.
> And I didn't see any "Fixes" tag in [1].
>

There is no deadlock issue with BPF memory allocator and
kmalloc_nolock(). For context, the patch you are referencing is part
of a series of refactoring to
- Move from BPF memory allocator to kmalloc_nolock() [1]
- Remove percpu busy lock [2]

Please refer to the cover letter for the motivation and changes made

[1] https://lore.kernel.org/bpf/20251112175939.2365295-1-ameryhung@gmail.co=
m/
[2] https://lore.kernel.org/bpf/20260205222916.1788211-1-ameryhung@gmail.co=
m/


> Could you provide a more detailed explanation? Thanks!
>
> [1]: https://lore.kernel.org/all/20251114201329.3275875-1-ameryhung@gmail=
.com/
>
> > For riscv hardware without zacas extension, I think a workaround with
> > some performance overhead is to enable CONFIG_SLUB_DEBUG and
> > slub_debug options.
>
> There is a patch [2] that enables HAVE_CMPXCHG_DOUBLE for riscv so I thin=
k
> it will not be a problem for riscv in the future, even for hardware witho=
ut zacas
> extension because the kernel has fallback implementation for zacas.
>
> However, this would still be an issue for other architectures. Currently =
only
> x86, arm64, s390 and loongarch have HAVE_CMPXCHG_DOUBLE in 7.0-rc4.
> I don't think letting users enable slub_debug would be a reasonable worka=
round.
>
> [2]: https://patchew.org/linux/20260220074449.8526-1-mssola@mssola.com/
>
> Best regards,
> Levi
>
> >>
> >> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_n=
olock() in local storage")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> >> ---
> >> I find that bpf_task_storage_get with flag BPF_LOCAL_STORAGE_GET_F_CRE=
ATE
> >> always fails for me on 6.19 kernel on riscv64 and bisected it.
> >>
> >> In f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_noloc=
k()
> >> in local storage"), bpf memory allocator is replaced with kmalloc_nolo=
ck.
> >> This approach is problematic for architectures that lack CMPXCHG_DOUBL=
E
> >> because kmalloc_nolock always fails in this case:
> >>
> >> In function kmalloc_nolock (kmalloc_nolock_noprof):
> >>
> >>         if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
> >>                 /*
> >>                  * kmalloc_nolock() is not supported on architectures =
that
> >>                  * don't implement cmpxchg16b, but debug caches don't =
use
> >>                  * per-cpu slab and per-cpu partial slabs. They rely o=
n
> >>                  * kmem_cache_node->list_lock, so kmalloc_nolock() can
> >>                  * attempt to allocate from debug caches by
> >>                  * spin_trylock_irqsave(&n->list_lock, ...)
> >>                  */
> >>                 return NULL;
> >>
> >> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> >> (But not for a PREEMPT_RT case as explained in the comment and commitm=
sg)
> >>
> >> Note for stable: this only needs to be picked into v6.19 if the patch
> >> makes it into 7.0.
> >> ---
> >> Changes in v3:
> >> - Use macro instead of const static variable to avoid triggering
> >>   warnings.
> >> - Wrap lines at 80 columns
> >> - Link to v2: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v2=
-1-576e33e4fa67@outlook.com
> >>
> >> Changes in v2:
> >> - Drop the modification to the PREEMPT_RT case as it requires
> >>   kmalloc_nolock for correctness.
> >> - Add a comment to the PREEMPT_RT case about the limitation when
> >>   not HAVE_CMPXCHG_DOUBLE but enables PREEMPT_RT.
> >> - Link to v1: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v1=
-1-24abf3f75a9f@outlook.com
> >> ---
> >>  include/linux/bpf_local_storage.h | 1 +
> >>  kernel/bpf/bpf_cgrp_storage.c     | 3 ++-
> >>  kernel/bpf/bpf_local_storage.c    | 4 ++++
> >>  kernel/bpf/bpf_task_storage.c     | 3 ++-
> >>  4 files changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_loc=
al_storage.h
> >> index 8157e8da61d40..d8f2c5d63a80e 100644
> >> --- a/include/linux/bpf_local_storage.h
> >> +++ b/include/linux/bpf_local_storage.h
> >> @@ -18,6 +18,7 @@
> >>  #include <asm/rqspinlock.h>
> >>
> >>  #define BPF_LOCAL_STORAGE_CACHE_SIZE   16
> >> +#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBL=
E)
> >>
> >>  struct bpf_local_storage_map_bucket {
> >>         struct hlist_head list;
> >> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_stora=
ge.c
> >> index c2a2ead1f466d..cd18193c44058 100644
> >> --- a/kernel/bpf/bpf_cgrp_storage.c
> >> +++ b/kernel/bpf/bpf_cgrp_storage.c
> >> @@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *ma=
p, void *key, void *next_key)
> >>
> >>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
> >>  {
> >> -       return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
> >> +       return bpf_local_storage_map_alloc(attr, &cgroup_cache,
> >> +                                          KMALLOC_NOLOCK_SUPPORTED);
> >>  }
> >>
> >>  static void cgroup_storage_map_free(struct bpf_map *map)
> >> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_sto=
rage.c
> >> index 9c96a4477f81a..a6c240da87668 100644
> >> --- a/kernel/bpf/bpf_local_storage.c
> >> +++ b/kernel/bpf/bpf_local_storage.c
> >> @@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
> >>         /* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
> >>          * preemptible context. Thus, enforce all storages to use
> >>          * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
> >> +        *
> >> +        * However, kmalloc_nolock would fail on architectures that do=
 not
> >> +        * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
> >> +        * bpf_local_storage_alloc would always fail.
> >>          */
> >>         smap->use_kmalloc_nolock =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? t=
rue : use_kmalloc_nolock;
> >>
> >> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_stora=
ge.c
> >> index 605506792b5b4..6e8597edea314 100644
> >> --- a/kernel/bpf/bpf_task_storage.c
> >> +++ b/kernel/bpf/bpf_task_storage.c
> >> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *ma=
p, void *key, void *next_key)
> >>
> >>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
> >>  {
> >> -       return bpf_local_storage_map_alloc(attr, &task_cache, true);
> >> +       return bpf_local_storage_map_alloc(attr, &task_cache,
> >> +                                          KMALLOC_NOLOCK_SUPPORTED);
> >>  }
> >>
> >>  static void task_storage_map_free(struct bpf_map *map)
> >>
> >> ---
> >> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
> >> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
> >>
> >> Best regards,
> >> --
> >> Levi Zim <rsworktech@outlook.com>
> >>
> >>
>
