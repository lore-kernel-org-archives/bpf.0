Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67C401486
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540060; cv=none; b=a4TpnGIgoAf1qIPKQ6+xP8aZbVxgeFuVIs9i/WCVRTSFpg6O8SlwMeRfYNEvGQnO6MN1oeukib0hV5zogCGn/DCt8eodskJ2Ln4InoNLVy0WP9H179XdXRCCMXMp3tSG8NBYR9pB/zLCYAyIxCMi8EmAfX4q5nzVmw7MsrUwoEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540060; c=relaxed/simple;
	bh=8zV1mlM9Db93HFNJiRFnSmu8T4K0En+s7iFzjSMIwxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdbcGLuHPtwB4PP5JqyFuZAbrMwOkD+ipWE32FeptR2wsrfz0o0VzfmgCLI5+xELy1jQ6WXtPrNFijjbRQ5YEE7HvO2WxPn8qLWjiPIyRxCNos7Nxgh7lwEeqJB24RYM1N+zUDB1kxqWeIX8cVZnNirycyzuVtVsxuc3h2Rav7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7FIg4Ab; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7FIg4Ab"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso10425575e9.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774540057; x=1775144857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAtXle1ukx/Ym7HaAgYcZ/3AU+9HOiKTUO5QzXa51OE=;
        b=V7FIg4AbOcWXY2xZyFre+jQbrEjuqVbhNj3Y6AujjG5YJa7lwMSv5Gp7fanO5YWwur
         hVn7h/VS99tNqMhOgkDdHP9jkEDOe/ty7TueYk2Jry08/DB8HV95mNjZxqSWwTfRW4sF
         G3EqPrW7aeORZBT4DpRTXdZQufWB018bK1O2CUaKG3JKFTobIgg1rA0nbJ4DiMdoaL3f
         EXDOvzr2Xz2Qht3wmSfOd37Si45NHHW7i9M35haBeuqopyUszp8OpfOP3NKvzpxl1T/y
         xrzCCqPLTgLhlAwzipMWhI4iGi2/TaOsWViOyaU9V+R2qrcUyGGf/a8OwnPx8X0FG1hq
         UUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774540057; x=1775144857;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pAtXle1ukx/Ym7HaAgYcZ/3AU+9HOiKTUO5QzXa51OE=;
        b=dg/a93lTRL9+XRu3j9IEnD14J6m/NSjsH7nsO7ODyh5nAXbAR2NzOnsa5A6xwlBVuT
         pE8wPuiRLgixQmUa2UMTc8wg1RnzNrBbRXZeMrdIJJ49PIxEHWOVXNA+vDeEpDLz5aSP
         75lb0kUKoq0lxi/JnSq8ZxexDqjGx4kznh2ztMSqQ104Qrqv4FglstTlsDv5fHWO1EhG
         FP6bHQiDVaMaKLoPeqEm/skzKC+kcY/11jf+HsZ1H2SxM4rNhoTStIhy9qdRHXd1afHA
         A/9ZVW39jOmjv0SRw7DzefaffBKUsD2bnuxNpq3u7iQi7eyL5t1Q18tzIvk8qBYA1kkU
         Ql0A==
X-Forwarded-Encrypted: i=1; AJvYcCW8lQgetlW8mwGq9H5Ypp6wcu25j3sEgNZigs5vKnLmcv0V/y9pOsi6SdNGtwh10hCSGs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJeAQ2hEpdPwqWvE41qJBFdBVDfD4oVh7HCpWfk9pSPAznmfj6
	nZZeChYy+UHM6OcW9X4a1hzCnWORzm+tgKzj6KDyDZ6P/seY3AHll5Cp
X-Gm-Gg: ATEYQzwU8izjCstPzwwnu2BQYB2XzxO96gKBG5u+zwRebXPl3Z7Kieh9rK1R9UThm91
	fzgR6DiUpijmYULZNYoc7fqq0/TmReJZt4Q5Vqw4Ez+x7t7NZQfOKCZrwfz83La0RtbDxpQ7zzW
	8bLjPsp6l8pcBZiC7ZDPv1jshPB/Cf+sF+9PdoMreGQa05aqjrmJ5UI/EU0vsyjcjr03DYVaDYL
	1IOVuHmOao+JdMukm3nwRrB+7xnHDyduwTH3uvfMjUDnstLQWT8Us/ZJbO+V94OEV7a65wuGX3/
	EAgaX0NTzVv//HFYLtnnq0w/8xQCqrupSMBvepnYYmj/Xj1eTjjTIGUt9HKpe8jITriYcyueeSE
	yB4KKGyy4d+/xVHo7BGLaIs+FuvMshpjThWasKyREmWggpNig5IVfR3b2DbrxvDCs4/6Ke3tYi5
	1LI8PqonVcgOlLBEyJ5rFzCJDG8wQxV2VXdw==
X-Received: by 2002:a05:600c:4685:b0:485:17a7:ba0d with SMTP id 5b1f17b1804b1-4871606cbcemr131084795e9.32.1774540056495;
        Thu, 26 Mar 2026 08:47:36 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fbbf65asm25902095e9.2.2026.03.26.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:47:36 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Aaron Esau <aaron1esau@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update
 path
In-Reply-To: <87o6kaioju.fsf@gmail.com>
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org> <87qzp6ipc7.fsf@gmail.com>
 <CANk7y0jkEKYviXGG2je80Q26MK4nfE4p=wfb_ukDuHGKSy2Qiw@mail.gmail.com>
 <87o6kaioju.fsf@gmail.com>
Date: Thu, 26 Mar 2026 15:47:35 +0000
Message-ID: <87ldfeiodk.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> writes:

> Puranjay Mohan <puranjay12@gmail.com> writes:
>
>> On Thu, Mar 26, 2026 at 3:26=E2=80=AFPM Mykyta Yatsenko
>> <mykyta.yatsenko5@gmail.com> wrote:
>>>
>>> Puranjay Mohan <puranjay@kernel.org> writes:
>>>
>>> > Aaron Esau <aaron1esau@gmail.com> writes:
>>> >
>>> >> Reported-by: Aaron Esau <aaron1esau@gmail.com>
>>> >>
>>> >> htab_map_update_elem() has a use-after-free when BPF_F_LOCK is used
>>> >> for in-place updates.
>>> >>
>>> >> The BPF_F_LOCK path calls lookup_nulls_elem_raw() without holding the
>>> >> bucket lock, then dereferences the element via copy_map_value_locked=
().
>>> >> A concurrent htab_map_delete_elem() can delete and free the element
>>> >> between these steps.
>>> >>
>>> >> free_htab_elem() uses bpf_mem_cache_free(), which immediately returns
>>> >> the object to the per-CPU free list (not RCU-deferred). The memory m=
ay
>>> >> be reallocated before copy_map_value_locked() executes, leading to
>>> >> writes into a different element.
>>> >>
>>> >> When lookup succeeds (l_old !=3D NULL), the in-place update path ret=
urns
>>> >> early, so the =E2=80=9Cfull lookup under lock=E2=80=9D path is not t=
aken.
>>> >>
>>> >> Race:
>>> >>
>>> >>   CPU 0: htab_map_update_elem (BPF_F_LOCK)
>>> >>          lookup_nulls_elem_raw() =E2=86=92 E (no bucket lock)
>>> >>          ...
>>> >>   CPU 1: htab_map_delete_elem()
>>> >>          htab_lock_bucket =E2=86=92 hlist_nulls_del_rcu =E2=86=92 ht=
ab_unlock_bucket
>>> >>          free_htab_elem =E2=86=92 bpf_mem_cache_free (immediate free)
>>> >>   CPU 1: htab_map_update_elem (new key)
>>> >>          alloc_htab_elem =E2=86=92 reuses E
>>> >>   CPU 0: copy_map_value_locked(E, ...) =E2=86=92 writes into reused =
object
>>> >>
>>> >> Reproduction:
>>> >>
>>> >>   1. Create BPF_MAP_TYPE_HASH with a value containing bpf_spin_lock
>>> >>      (max_entries=3D64, 7 u64 fields + lock).
>>> >>   2. Threads A: BPF_MAP_UPDATE_ELEM with BPF_F_LOCK (pattern 0xAAAA.=
..)
>>> >>   3. Threads B: DELETE + UPDATE (pattern 0xBBBB...) on same keys
>>> >>   4. Threads C: same as A (pattern 0xCCCC...)
>>> >>   5. Verifier threads: LOOKUP loop, detect mixed-pattern values
>>> >>   6. Run 60s on >=3D4 CPUs
>>> >>
>>> >> Attached a POC. On 6.19.9 (4 vCPU QEMU, CONFIG_PREEMPT=3Dy),
>>> >> I observed ~645 torn values in 2.5M checks (~0.026%).
>>> >>
>>> >> Fixes: 96049f3afd50 ("bpf: introduce BPF_F_LOCK flag")
>>> >
>>> > Although this is a real issue, your reproducer is not accurate, it wi=
ll
>>> > see torn writes even without the UAF issue, because the verifier thre=
ad
>>> > is not taking the lock:
>>> >
>>> > So the torn write pattern CCCAAAA can mean:
>>> >   1. Thread A finished writing AAAAAAA (while holding the lock)
>>> >   2. Thread C acquired the lock and started writing: field[0]=3DC, fi=
eld[1]=3DC, field[2]=3DC...
>>> >   3. The verifier thread reads (no lock): sees field[0]=3DC, field[1]=
=3DC, field[2]=3DC, field[3]=3DA, field[4]=3DA, field[5]=3DA, field[6]=3DA
>>> >   4. Thread C finishes: field[3]=3DC, field[4]=3DC, field[5]=3DC, fie=
ld[6]=3DC, releases lock
>>> >
>>> > This race happens regardless of whether the element is freed/reused. =
 It
>>> > would happen even without thread B (the delete+readd thread). The
>>> > corruption source is the non-atomic read, not the UAF.
>>> Have you confirmed torn reads even with BPF_F_LOCK flag on the
>>> BPF_MAP_LOOKUP_ELEM_CMD? I understand there must not be any torn reads
>>> with spinlock taken on the lookup path.
>>>
>>> The reproducer looks like a good selftest to have, but it needs to be
>>> ported to use libbpf, currently it looks too complex.
>>
>> Yes, I have confirmed torn reads even with BPF_F_LOCK on
>> BPF_MAP_LOOKUP_ELEM_CMD, the results given below are with BPF_F_LOCK.
>> But this is expected behaviour, BPF_F_LOCK performs a lockless lookup
>> and takes only the element's embedded spin_lock for in-place value
>> updates. It does not synchronize against concurrent deletes.
>>
> It does not synchronize against concurrent deletes, yes, but with
> BPF_F_LOCK on BPF_MAP_LOOKUP_ELEM_CMD, we still take the spinlock before
> copying value from the map (syscall.c:354). Deletion does not mutate the
> element, so when the value is reused, it should still take the same lock,
> shouldn't it?

Ok, I think this is just a wonky reproducer:
fill_value(&val, PATTERN_B, seq++);
map_update(g_map_fd, &g_key, &val, BPF_ANY);

should have been BPF_ANY | BPF_F_LOCK
>>
>>> >
>>> > If you change the preproducer like:
>>> >
>>> > -- >8 --
>>> >
>>> > --- repro.c     2026-03-26 05:22:49.012503218 -0700
>>> > +++ repro2.c    2026-03-26 06:24:40.951044279 -0700
>>> > @@ -227,6 +227,7 @@
>>> >         attr.map_fd =3D fd;
>>> >         attr.key =3D (uint64_t)(unsigned long)key;
>>> >         attr.value =3D (uint64_t)(unsigned long)val;
>>> > +       attr.flags =3D BPF_F_LOCK;
>>> >         return bpf_sys(BPF_MAP_LOOKUP_ELEM_CMD, &attr, sizeof(attr));
>>> >  }
>>> >
>>> > -- 8< --
>>> >
>>> > Now it will detect the correct UAF problem.
>>> >
>>> > I verified that this updated reproducer shows the problem, the follow=
ing
>>> > kernel diff fixes it:
>>> >
>>> > -- >8 --
>>> >
>>> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> > index bc6bc8bb871d..af33f62069f0 100644
>>> > --- a/kernel/bpf/hashtab.c
>>> > +++ b/kernel/bpf/hashtab.c
>>> > @@ -953,7 +953,7 @@ static void htab_elem_free(struct bpf_htab *htab,=
 struct htab_elem *l)
>>> >
>>> >         if (htab->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH)
>>> >                 bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
>>> > -       bpf_mem_cache_free(&htab->ma, l);
>>> > +       bpf_mem_cache_free_rcu(&htab->ma, l);
>>> >  }
>>> >
>>> >  static void htab_put_fd_value(struct bpf_htab *htab, struct htab_ele=
m *l)
>>> >
>>> > -- 8< --
>>> >
>>> > Before:
>>> >
>>> > [root@alarm host0]# ./repro2
>>> > Running 10 threads for 60 seconds...
>>> >
>>> > Total checks:    49228421
>>> > Torn writes:     5470
>>> > Max torn fields: 3 / 7
>>> > Corruption rate: 0.011111%
>>> >
>>> > Cross-pattern breakdown:
>>> >   A in B: 8595
>>> >   C in B: 7826
>>> >   Unknown: 1
>>> >
>>> > First 20 events:
>>> >   [0] check #42061 seq=3D39070 CCCBBBB
>>> >   [1] check #65714 seq=3D60575 CCCBBBB
>>> >   [2] check #65287 seq=3D60575 CCCBBBB
>>> >   [3] check #70474 seq=3D65793 AAABBBB
>>> >   [4] check #70907 seq=3D65793 AAABBBB
>>> >   [5] check #103389 seq=3D95745 AAABBBB
>>> >   [6] check #107208 seq=3D98672 CCCBBBB
>>> >   [7] check #108218 seq=3D100387 CCCBBBB
>>> >   [8] check #111490 seq=3D103388 CCCBBBB
>>> >   [9] check #140942 seq=3D128894 CCCBBBB
>>> >   [10] check #164845 seq=3D151828 CCCBBBB
>>> >   [11] check #163993 seq=3D151828 CCCBBBB
>>> >   [12] check #169184 seq=3D155453 CCCBBBB
>>> >   [13] check #171383 seq=3D158572 AAABBBB
>>> >   [14] check #179943 seq=3D165425 CCCBBBB
>>> >   [15] check #189218 seq=3D173926 CCCBBBB
>>> >   [16] check #192119 seq=3D177892 CCCBBBB
>>> >   [17] check #194253 seq=3D180562 AAABBBB
>>> >   [18] check #202169 seq=3D187253 CCCBBBB
>>> >   [19] check #205452 seq=3D189021 CCCBBBB
>>> >
>>> > CORRUPTION DETECTED
>>> >
>>> > After:
>>> >
>>> > [root@alarm host0]# ./repro2
>>> > Running 10 threads for 60 seconds...
>>> >
>>> > Total checks:    108666576
>>> > Torn writes:     0
>>> > Max torn fields: 0 / 7
>>> >
>>> > No corruption detected (try more CPUs or longer run)
>>> > [root@alarm host0]# nproc
>>> > 16
>>> >
>>> > I will send a patch to fix this soon after validating the above kernel
>>> > diff and figuring out how we got to this state in htab_elem_free() by
>>> > analyzing the git history.
>>> >
>>> > Thanks for the report.
>>> > Puranjay
