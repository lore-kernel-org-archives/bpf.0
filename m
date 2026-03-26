Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6173FE65B
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538813; cv=none; b=j2t4/s2zEqgMvwgVpTAmlUuWVuucrXegJXmsHHNKypotvGnqF0sDC2sfn1AM/51mcevQZR33pBl0BsoxIRwa+Rbw0wTaEaakJvcFh9r9TiPAFTu7bmbCp1CpYHzPT0Ad9JDETZWIvXEcaqvo9Z/2c65I7soyUG8YWAI8joa8q5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538813; c=relaxed/simple;
	bh=LfX65/fvypeB8ZZnyRUC5RNldKCJNprb45zwfByUoNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BD6lUFryrclKUcMARNiRTHnWuACtIIs8GxnZfFqrWYSBxh8NI4UmgaOB2Sy4S9kozA3GYmZ2mFiW/H5ZbxkGeIhaO6iLNrYxzx5VV8bGXunj1RhBvoxNztA/9n4+Snngt89aHs1mpRu5NJGQVkJ79NSNdyq8K1EcEs83Gafa2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEnfa6/i; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEnfa6/i"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so8987545e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538811; x=1775143611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E2brWpe5VuESxWqGCnIwmMCRGDXAwbKqGPplYhF8/g=;
        b=TEnfa6/iNEqxTmrqqoNzlPjkmIAF0vnGBG4Y9tRNJy7TVtRYOC0FIxzyhvSv+n6nZW
         hbXT778ryYC3FB1QTe3OrqwW5qy53Tu4/wFGatxWr4H5qB3CVnOgppKXU/N265mr/w6J
         zw2yf35bo38XEVfLudZuruqYUMHyXjd+IP0fRQXtnbtKrfVARafU8gMx/qAgqo3agQqC
         umug5Lm9OWcMymh+3Vsy9LnP0eozsgZzINii+lycHgW3Zu1EjlLY4Hlaik04Eij1kkke
         yZUDlYBHvvalgmoUz0f66Uy5SKdRJ5PM/G4ACuV4cnhQoQH0M/nxQOVxQ/eqh4x9Vngz
         eFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538811; x=1775143611;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3E2brWpe5VuESxWqGCnIwmMCRGDXAwbKqGPplYhF8/g=;
        b=f73n7nzJwEZqqFv5x014tiGkKv97UqrKJcQw15nkYSv7oh759p01S3Ec2/Vaqsp0om
         T6H2JZc6/ynjI5BA7hQeJnk9qDD9+N4zJL75liO8Fx8IKngPP59fDigMVybPDmz7zPOP
         DQGCKKOwM8Mg8FFMKjnXxaeM5jslx0r43qB77rKb9xIihIwtkWk319eZdA3pF49r6+zm
         q/hZ9iHecrZYB01deytXILwsawNg4vGjAuOf7czTNIhAHDS/DY0m7SsgGJgcI/aN2oPG
         wCvOw4pEfV0DWKpRq8D6DSUPwylr/JagoQh4uyPF114k0EOihcwLra7IMnf8UvoCH99g
         c2SA==
X-Forwarded-Encrypted: i=1; AJvYcCW61YPiKLLSl3j2ipR1gH5rHyTF5yucPBOPA7SsR1yvWXVyxY3TJPVxg5qV2CjpJ0hvh90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz573Lcga5EvUFSGnEZJX9MsTnKHP6wzd1kYbC9Uadq220USh4G
	PGw4Z+42CByhjDyePqSIDQDXu85tjrbAZJHk1ZR9OuZ9EkPRiVGnGEHL
X-Gm-Gg: ATEYQzwOVZI0PWqMZ1xgaH/g3Sh5gm739vBrNdnyM0yQVV9tvzNdokrc0UcVdJbRTZd
	3Tnv7fyFsqUmEyltuk+Fsf/mBVkl2c6638Mgdr+VW0XY4PE6gq4iNbvzsTHkSiz5Ci6lzw1aF6u
	jELlXM7OlFB/vf0AwquZpRyxsE7uvvKilFwmPSZ4/imtc7X1MzJny/WuObRmx//X/kBRb6N9xQ3
	xg67w5FY6RVX28DdEQY7BUppeQci2PKefc5dK/Y5gV/0Qorkx6K6LPWLCoSXsxPzjOD/P43I+Qc
	FUksbB9f1dIG+kaE6RNTXehMNj4zA7h9pvsDEoPumD8NnaIr3qd48NgQn6RjIezrENFCaB/HMDc
	5NSRujwfkxgaT16kMDUtWF0fZ/W6chy844fyFa1KyC7A6hrhS9nuGBcSbcx1HDDWa5zyRQqIl63
	anUbg8/7twJIT2do+Zzae/i/30tR33Sn4oEg==
X-Received: by 2002:a05:600c:83c6:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-48715fcc5acmr119027005e9.8.1774538810169;
        Thu, 26 Mar 2026 08:26:50 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb4bf57sm34154725e9.0.2026.03.26.08.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:26:49 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Aaron Esau <aaron1esau@gmail.com>,
 bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update
 path
In-Reply-To: <m2se9mg16x.fsf@kernel.org>
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org>
Date: Thu, 26 Mar 2026 15:26:48 +0000
Message-ID: <87qzp6ipc7.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> Aaron Esau <aaron1esau@gmail.com> writes:
>
>> Reported-by: Aaron Esau <aaron1esau@gmail.com>
>>
>> htab_map_update_elem() has a use-after-free when BPF_F_LOCK is used
>> for in-place updates.
>>
>> The BPF_F_LOCK path calls lookup_nulls_elem_raw() without holding the
>> bucket lock, then dereferences the element via copy_map_value_locked().
>> A concurrent htab_map_delete_elem() can delete and free the element
>> between these steps.
>>
>> free_htab_elem() uses bpf_mem_cache_free(), which immediately returns
>> the object to the per-CPU free list (not RCU-deferred). The memory may
>> be reallocated before copy_map_value_locked() executes, leading to
>> writes into a different element.
>>
>> When lookup succeeds (l_old !=3D NULL), the in-place update path returns
>> early, so the =E2=80=9Cfull lookup under lock=E2=80=9D path is not taken.
>>
>> Race:
>>
>>   CPU 0: htab_map_update_elem (BPF_F_LOCK)
>>          lookup_nulls_elem_raw() =E2=86=92 E (no bucket lock)
>>          ...
>>   CPU 1: htab_map_delete_elem()
>>          htab_lock_bucket =E2=86=92 hlist_nulls_del_rcu =E2=86=92 htab_u=
nlock_bucket
>>          free_htab_elem =E2=86=92 bpf_mem_cache_free (immediate free)
>>   CPU 1: htab_map_update_elem (new key)
>>          alloc_htab_elem =E2=86=92 reuses E
>>   CPU 0: copy_map_value_locked(E, ...) =E2=86=92 writes into reused obje=
ct
>>
>> Reproduction:
>>
>>   1. Create BPF_MAP_TYPE_HASH with a value containing bpf_spin_lock
>>      (max_entries=3D64, 7 u64 fields + lock).
>>   2. Threads A: BPF_MAP_UPDATE_ELEM with BPF_F_LOCK (pattern 0xAAAA...)
>>   3. Threads B: DELETE + UPDATE (pattern 0xBBBB...) on same keys
>>   4. Threads C: same as A (pattern 0xCCCC...)
>>   5. Verifier threads: LOOKUP loop, detect mixed-pattern values
>>   6. Run 60s on >=3D4 CPUs
>>
>> Attached a POC. On 6.19.9 (4 vCPU QEMU, CONFIG_PREEMPT=3Dy),
>> I observed ~645 torn values in 2.5M checks (~0.026%).
>>
>> Fixes: 96049f3afd50 ("bpf: introduce BPF_F_LOCK flag")
>
> Although this is a real issue, your reproducer is not accurate, it will
> see torn writes even without the UAF issue, because the verifier thread
> is not taking the lock:
>
> So the torn write pattern CCCAAAA can mean:
>   1. Thread A finished writing AAAAAAA (while holding the lock)
>   2. Thread C acquired the lock and started writing: field[0]=3DC, field[=
1]=3DC, field[2]=3DC...
>   3. The verifier thread reads (no lock): sees field[0]=3DC, field[1]=3DC=
, field[2]=3DC, field[3]=3DA, field[4]=3DA, field[5]=3DA, field[6]=3DA
>   4. Thread C finishes: field[3]=3DC, field[4]=3DC, field[5]=3DC, field[6=
]=3DC, releases lock
>
> This race happens regardless of whether the element is freed/reused.  It
> would happen even without thread B (the delete+readd thread). The
> corruption source is the non-atomic read, not the UAF.
Have you confirmed torn reads even with BPF_F_LOCK flag on the
BPF_MAP_LOOKUP_ELEM_CMD? I understand there must not be any torn reads
with spinlock taken on the lookup path.

The reproducer looks like a good selftest to have, but it needs to be
ported to use libbpf, currently it looks too complex.
>
> If you change the preproducer like:
>
> -- >8 --
>
> --- repro.c     2026-03-26 05:22:49.012503218 -0700
> +++ repro2.c    2026-03-26 06:24:40.951044279 -0700
> @@ -227,6 +227,7 @@
>         attr.map_fd =3D fd;
>         attr.key =3D (uint64_t)(unsigned long)key;
>         attr.value =3D (uint64_t)(unsigned long)val;
> +       attr.flags =3D BPF_F_LOCK;
>         return bpf_sys(BPF_MAP_LOOKUP_ELEM_CMD, &attr, sizeof(attr));
>  }
>
> -- 8< --
>
> Now it will detect the correct UAF problem.
>
> I verified that this updated reproducer shows the problem, the following
> kernel diff fixes it:
>
> -- >8 --
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index bc6bc8bb871d..af33f62069f0 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -953,7 +953,7 @@ static void htab_elem_free(struct bpf_htab *htab, str=
uct htab_elem *l)
>
>         if (htab->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH)
>                 bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
> -       bpf_mem_cache_free(&htab->ma, l);
> +       bpf_mem_cache_free_rcu(&htab->ma, l);
>  }
>
>  static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
>
> -- 8< --
>
> Before:
>
> [root@alarm host0]# ./repro2
> Running 10 threads for 60 seconds...
>
> Total checks:    49228421
> Torn writes:     5470
> Max torn fields: 3 / 7
> Corruption rate: 0.011111%
>
> Cross-pattern breakdown:
>   A in B: 8595
>   C in B: 7826
>   Unknown: 1
>
> First 20 events:
>   [0] check #42061 seq=3D39070 CCCBBBB
>   [1] check #65714 seq=3D60575 CCCBBBB
>   [2] check #65287 seq=3D60575 CCCBBBB
>   [3] check #70474 seq=3D65793 AAABBBB
>   [4] check #70907 seq=3D65793 AAABBBB
>   [5] check #103389 seq=3D95745 AAABBBB
>   [6] check #107208 seq=3D98672 CCCBBBB
>   [7] check #108218 seq=3D100387 CCCBBBB
>   [8] check #111490 seq=3D103388 CCCBBBB
>   [9] check #140942 seq=3D128894 CCCBBBB
>   [10] check #164845 seq=3D151828 CCCBBBB
>   [11] check #163993 seq=3D151828 CCCBBBB
>   [12] check #169184 seq=3D155453 CCCBBBB
>   [13] check #171383 seq=3D158572 AAABBBB
>   [14] check #179943 seq=3D165425 CCCBBBB
>   [15] check #189218 seq=3D173926 CCCBBBB
>   [16] check #192119 seq=3D177892 CCCBBBB
>   [17] check #194253 seq=3D180562 AAABBBB
>   [18] check #202169 seq=3D187253 CCCBBBB
>   [19] check #205452 seq=3D189021 CCCBBBB
>
> CORRUPTION DETECTED
>
> After:
>
> [root@alarm host0]# ./repro2
> Running 10 threads for 60 seconds...
>
> Total checks:    108666576
> Torn writes:     0
> Max torn fields: 0 / 7
>
> No corruption detected (try more CPUs or longer run)
> [root@alarm host0]# nproc
> 16
>
> I will send a patch to fix this soon after validating the above kernel
> diff and figuring out how we got to this state in htab_elem_free() by
> analyzing the git history.
>
> Thanks for the report.
> Puranjay
