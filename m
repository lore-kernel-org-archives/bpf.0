Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277EB378D8B
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539833; cv=none; b=Mftv96zDhMYQKHn+BgoLRZ0w7mDkyNILR0PGOrXPDAtQeoEbLxsh4cYJ+hLZRqV/19/wJAeJ5KI32Prvn84zgd1Y9SSoyc/R+XHInbDxQrZDIUTGvP7BeitWpvlrIQdNmQ74n6PZpFsmKeqZguIsIZRX2IkVlZkMaD/IPrKdcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539833; c=relaxed/simple;
	bh=Z3bMRYIrCNqaYhMfNE42dw5j7hxMq2sBClH/dvwWx5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VSoJVk7/Xs/8hWZcz09N0EtH/0bE267A+s7CCFmrmft6IDEg3jI9gRwpXaI2aMUzPErjCCb8PbRO2p4qIFjOPLEkTLVqV28yHyx4MC3km8A/U6vTcc2/PAlSeucCJNhk2o2Wcu8S98qP1MMibOkHVtAxCn1msXE9yr7hxVUXE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNdtYnAv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNdtYnAv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso10213405e9.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774539830; x=1775144630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JESmBTj9TfoGuphdQnydf4vRq4pm5/zZz3s8S0xeoNk=;
        b=fNdtYnAvzkvMbhArCbY519N2vG5OQ+nz0Bs9kjGMg31FJzFE4IZ5aXPlXqbVIlnHaq
         oBjEtyn14/1+KSsHW/odx/22uB0fCGIaicvyn0RB99CBaYlpCKBvX5I0slLSXKvGN7nN
         n4eNEqZSbaaazu59/eM7M9JF7mcop3xZgQXdsS7prDPxl9UI13bhJ5QYSczwGgLtcyU6
         +3HXzjeHx/SDS52VwDrJFnZZCae6ABlS6NeVWAhF9fAJg8sSr06TIXimVP2JmGXg+/Lc
         vP2lC+NGIgtmSKmGQjllOJWNX2xBTj5Rd0pTC01ZAOmBc5Z95U58fSuX1XTiyxOUVlcx
         34wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774539830; x=1775144630;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JESmBTj9TfoGuphdQnydf4vRq4pm5/zZz3s8S0xeoNk=;
        b=FUexhpHzR7oefZ70hmtv6voxKhzBb8Thl/e57Do/80J95gJIgoW9cYJAC/uOCOPdse
         PzRKco0KUL+Hg1ZsT47Vx9qUYHYVty+iwVQeZqgrnWHDPEoUcllysXZ0OVYxIPpt9gpO
         WuA+Qlq9Ri3hXLZFZfEAYVX4LG2g8X8MnGi+pRMYpHGXfUij3afjEZEbUVHE0uBEAf2m
         RGn88/s5a4pIu19BRWAhKd6mwWYzOfrE8OoQXiXggyfoH9ctI8ik/5trkDhBoh5CB6Vc
         Wu/xROMl1YglFce1/fVN2Xkh2SH5HxIHxc9Rgi2+wtHQlcEJQRAfjTvaCFhGNChYuatW
         8NRA==
X-Forwarded-Encrypted: i=1; AJvYcCWLH7Ms0nv5jv8spP8ssxG/hdMHqaC0wMp8i23dJrMhjdhtncD5RROAgQkvxIhLYio80jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGBvF4Vx+g6rvNmAD6vWH6qmJ9aKW6ciZphVZMXjhJ5biI2je6
	pfpTN9xvyEiiGHalRQuK/mWha+HvaimSBe0lr80o/XbxBoOgPBhF2Pv+
X-Gm-Gg: ATEYQzxVVFDefh8r3nsk0Wlz5cXYmq9VGn/ooO/EP6od9R69QMF+5DirtxeNqdnxR8N
	ewEZGpOg7I9L/0vsbonAcMuecAMBJHosydpZf7zCGiDFCNQr/4DvRXHCO8fiqf63P74YrU7INAQ
	nxG+60CgmzJpLcZRcwADBZnAIKQzsDWSyy6jxVvuNDtMT7VkbAMikL2PLrEOFmY/h6jYhtiXCT5
	FFRytNs9y9pnA7qD/D+A24AHL0hYUnGIIwke0I/HoQhHzCd8bMYerIAUbZL+hLa5asUPykM/6R4
	+mMFK/smSYabwpqdur5ajzQ+YMVpl5SS8MhD50xsAry9Wu1yscdyFhHoRRO3Cn0pOlE/vO+eMq3
	HnjwrOsDnqoJ6zcCVLI7pL3oFQp9simBfiHFBfC7a64pJBD8JlAU+mN5IX8h4KLO5cTYCnHvjZ4
	ZFILXUtLYRP7+Rv9I8nFPQmN8Z0jM1fEw+CA==
X-Received: by 2002:a05:600c:5296:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-4871605bdffmr123434995e9.25.1774539830238;
        Thu, 26 Mar 2026 08:43:50 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df7e7sm8349819f8f.26.2026.03.26.08.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:43:49 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Aaron Esau <aaron1esau@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update
 path
In-Reply-To: <CANk7y0jkEKYviXGG2je80Q26MK4nfE4p=wfb_ukDuHGKSy2Qiw@mail.gmail.com>
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org> <87qzp6ipc7.fsf@gmail.com>
 <CANk7y0jkEKYviXGG2je80Q26MK4nfE4p=wfb_ukDuHGKSy2Qiw@mail.gmail.com>
Date: Thu, 26 Mar 2026 15:43:49 +0000
Message-ID: <87o6kaioju.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> On Thu, Mar 26, 2026 at 3:26=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> Puranjay Mohan <puranjay@kernel.org> writes:
>>
>> > Aaron Esau <aaron1esau@gmail.com> writes:
>> >
>> >> Reported-by: Aaron Esau <aaron1esau@gmail.com>
>> >>
>> >> htab_map_update_elem() has a use-after-free when BPF_F_LOCK is used
>> >> for in-place updates.
>> >>
>> >> The BPF_F_LOCK path calls lookup_nulls_elem_raw() without holding the
>> >> bucket lock, then dereferences the element via copy_map_value_locked(=
).
>> >> A concurrent htab_map_delete_elem() can delete and free the element
>> >> between these steps.
>> >>
>> >> free_htab_elem() uses bpf_mem_cache_free(), which immediately returns
>> >> the object to the per-CPU free list (not RCU-deferred). The memory may
>> >> be reallocated before copy_map_value_locked() executes, leading to
>> >> writes into a different element.
>> >>
>> >> When lookup succeeds (l_old !=3D NULL), the in-place update path retu=
rns
>> >> early, so the =E2=80=9Cfull lookup under lock=E2=80=9D path is not ta=
ken.
>> >>
>> >> Race:
>> >>
>> >>   CPU 0: htab_map_update_elem (BPF_F_LOCK)
>> >>          lookup_nulls_elem_raw() =E2=86=92 E (no bucket lock)
>> >>          ...
>> >>   CPU 1: htab_map_delete_elem()
>> >>          htab_lock_bucket =E2=86=92 hlist_nulls_del_rcu =E2=86=92 hta=
b_unlock_bucket
>> >>          free_htab_elem =E2=86=92 bpf_mem_cache_free (immediate free)
>> >>   CPU 1: htab_map_update_elem (new key)
>> >>          alloc_htab_elem =E2=86=92 reuses E
>> >>   CPU 0: copy_map_value_locked(E, ...) =E2=86=92 writes into reused o=
bject
>> >>
>> >> Reproduction:
>> >>
>> >>   1. Create BPF_MAP_TYPE_HASH with a value containing bpf_spin_lock
>> >>      (max_entries=3D64, 7 u64 fields + lock).
>> >>   2. Threads A: BPF_MAP_UPDATE_ELEM with BPF_F_LOCK (pattern 0xAAAA..=
.)
>> >>   3. Threads B: DELETE + UPDATE (pattern 0xBBBB...) on same keys
>> >>   4. Threads C: same as A (pattern 0xCCCC...)
>> >>   5. Verifier threads: LOOKUP loop, detect mixed-pattern values
>> >>   6. Run 60s on >=3D4 CPUs
>> >>
>> >> Attached a POC. On 6.19.9 (4 vCPU QEMU, CONFIG_PREEMPT=3Dy),
>> >> I observed ~645 torn values in 2.5M checks (~0.026%).
>> >>
>> >> Fixes: 96049f3afd50 ("bpf: introduce BPF_F_LOCK flag")
>> >
>> > Although this is a real issue, your reproducer is not accurate, it will
>> > see torn writes even without the UAF issue, because the verifier thread
>> > is not taking the lock:
>> >
>> > So the torn write pattern CCCAAAA can mean:
>> >   1. Thread A finished writing AAAAAAA (while holding the lock)
>> >   2. Thread C acquired the lock and started writing: field[0]=3DC, fie=
ld[1]=3DC, field[2]=3DC...
>> >   3. The verifier thread reads (no lock): sees field[0]=3DC, field[1]=
=3DC, field[2]=3DC, field[3]=3DA, field[4]=3DA, field[5]=3DA, field[6]=3DA
>> >   4. Thread C finishes: field[3]=3DC, field[4]=3DC, field[5]=3DC, fiel=
d[6]=3DC, releases lock
>> >
>> > This race happens regardless of whether the element is freed/reused.  =
It
>> > would happen even without thread B (the delete+readd thread). The
>> > corruption source is the non-atomic read, not the UAF.
>> Have you confirmed torn reads even with BPF_F_LOCK flag on the
>> BPF_MAP_LOOKUP_ELEM_CMD? I understand there must not be any torn reads
>> with spinlock taken on the lookup path.
>>
>> The reproducer looks like a good selftest to have, but it needs to be
>> ported to use libbpf, currently it looks too complex.
>
> Yes, I have confirmed torn reads even with BPF_F_LOCK on
> BPF_MAP_LOOKUP_ELEM_CMD, the results given below are with BPF_F_LOCK.
> But this is expected behaviour, BPF_F_LOCK performs a lockless lookup
> and takes only the element's embedded spin_lock for in-place value
> updates. It does not synchronize against concurrent deletes.
>
It does not synchronize against concurrent deletes, yes, but with
BPF_F_LOCK on BPF_MAP_LOOKUP_ELEM_CMD, we still take the spinlock before
copying value from the map (syscall.c:354). Deletion does not mutate the
element, so when the value is reused, it should still take the same lock,
shouldn't it?
>
>> >
>> > If you change the preproducer like:
>> >
>> > -- >8 --
>> >
>> > --- repro.c     2026-03-26 05:22:49.012503218 -0700
>> > +++ repro2.c    2026-03-26 06:24:40.951044279 -0700
>> > @@ -227,6 +227,7 @@
>> >         attr.map_fd =3D fd;
>> >         attr.key =3D (uint64_t)(unsigned long)key;
>> >         attr.value =3D (uint64_t)(unsigned long)val;
>> > +       attr.flags =3D BPF_F_LOCK;
>> >         return bpf_sys(BPF_MAP_LOOKUP_ELEM_CMD, &attr, sizeof(attr));
>> >  }
>> >
>> > -- 8< --
>> >
>> > Now it will detect the correct UAF problem.
>> >
>> > I verified that this updated reproducer shows the problem, the followi=
ng
>> > kernel diff fixes it:
>> >
>> > -- >8 --
>> >
>> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> > index bc6bc8bb871d..af33f62069f0 100644
>> > --- a/kernel/bpf/hashtab.c
>> > +++ b/kernel/bpf/hashtab.c
>> > @@ -953,7 +953,7 @@ static void htab_elem_free(struct bpf_htab *htab, =
struct htab_elem *l)
>> >
>> >         if (htab->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH)
>> >                 bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
>> > -       bpf_mem_cache_free(&htab->ma, l);
>> > +       bpf_mem_cache_free_rcu(&htab->ma, l);
>> >  }
>> >
>> >  static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem=
 *l)
>> >
>> > -- 8< --
>> >
>> > Before:
>> >
>> > [root@alarm host0]# ./repro2
>> > Running 10 threads for 60 seconds...
>> >
>> > Total checks:    49228421
>> > Torn writes:     5470
>> > Max torn fields: 3 / 7
>> > Corruption rate: 0.011111%
>> >
>> > Cross-pattern breakdown:
>> >   A in B: 8595
>> >   C in B: 7826
>> >   Unknown: 1
>> >
>> > First 20 events:
>> >   [0] check #42061 seq=3D39070 CCCBBBB
>> >   [1] check #65714 seq=3D60575 CCCBBBB
>> >   [2] check #65287 seq=3D60575 CCCBBBB
>> >   [3] check #70474 seq=3D65793 AAABBBB
>> >   [4] check #70907 seq=3D65793 AAABBBB
>> >   [5] check #103389 seq=3D95745 AAABBBB
>> >   [6] check #107208 seq=3D98672 CCCBBBB
>> >   [7] check #108218 seq=3D100387 CCCBBBB
>> >   [8] check #111490 seq=3D103388 CCCBBBB
>> >   [9] check #140942 seq=3D128894 CCCBBBB
>> >   [10] check #164845 seq=3D151828 CCCBBBB
>> >   [11] check #163993 seq=3D151828 CCCBBBB
>> >   [12] check #169184 seq=3D155453 CCCBBBB
>> >   [13] check #171383 seq=3D158572 AAABBBB
>> >   [14] check #179943 seq=3D165425 CCCBBBB
>> >   [15] check #189218 seq=3D173926 CCCBBBB
>> >   [16] check #192119 seq=3D177892 CCCBBBB
>> >   [17] check #194253 seq=3D180562 AAABBBB
>> >   [18] check #202169 seq=3D187253 CCCBBBB
>> >   [19] check #205452 seq=3D189021 CCCBBBB
>> >
>> > CORRUPTION DETECTED
>> >
>> > After:
>> >
>> > [root@alarm host0]# ./repro2
>> > Running 10 threads for 60 seconds...
>> >
>> > Total checks:    108666576
>> > Torn writes:     0
>> > Max torn fields: 0 / 7
>> >
>> > No corruption detected (try more CPUs or longer run)
>> > [root@alarm host0]# nproc
>> > 16
>> >
>> > I will send a patch to fix this soon after validating the above kernel
>> > diff and figuring out how we got to this state in htab_elem_free() by
>> > analyzing the git history.
>> >
>> > Thanks for the report.
>> > Puranjay
