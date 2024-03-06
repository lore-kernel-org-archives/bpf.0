Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89E5F853
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721159; cv=none; b=bfu6a8LzTq9b2kWR63QWPctjb5d/6HTV9ScpOrIuNmheCneGj5qDox7y4+HWFylDKHm/Yf0gpPNpw4OaMFxaXC0E7RwGcADzkF8mGnykArzPrNbqStxG676vMjEpxFo+fv5W2L2NXgah7fFBcuioJ4CiUZM0l5IBFM3cd5CMdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721159; c=relaxed/simple;
	bh=txBIKxQZkgLZCOSNy76dCGKvAx8Tu8ElYzI5i3Ueloo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRYdKcGXWe8LgTPACUv3bsR1ABe8fUYvhM2VNWR3eEOcp4OBjbk+t+rKS1CpoMfcVA0S+XlcNfIObBFOwAvpgjeQKXC9S0vYEh1iJkcC1jeXoBX/XBEJkltXdr0vADd9GT8vcHKPYGgW/kHEGeqT2RrsLwhP/oVl9Y/is9DefOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZI7c5zLK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZI7c5zLK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709721156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdStkjjGV7PWNh3CxXB/lgpGt7dYWssT6Zeif+EXzpg=;
	b=ZI7c5zLKG06pSy1Qwt+dg7lcBZxd/Fo6bLK8W1dU+IQYfo8Bvdzo2h0qcrVl597BpA7VBt
	k+tSMXoUNzMXWfCB6pBxPNpl5iqj5i5FERgqV/Sro6AghHYuQC6qneTz5qFAErbmehi2wa
	u8R7WijSNka+aXCUs6lEZgNr7cnFsFM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-JuRukbIFN3-hXy7DRK2eeQ-1; Wed, 06 Mar 2024 05:32:34 -0500
X-MC-Unique: JuRukbIFN3-hXy7DRK2eeQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a45b4f09107so64403566b.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721153; x=1710325953;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdStkjjGV7PWNh3CxXB/lgpGt7dYWssT6Zeif+EXzpg=;
        b=ROWL1sukw38KzYAKwMvLNTbhdi8nhT42/JdWXXNMnC+GMdfeYHcyE31yd15WB7dARV
         TShgU6vmLmURysXz31KdYq8LEr5CN2PiMQQHcyzShhRcfNzgZRXePHclYeW14cqE272/
         vPdQBO2ZVTjtL8sKH4ioapGQYRlXx9AsnrWOX6lpesJ+SKLjSRMPVETyEBDQUb5EYuRH
         fWTf7uciJiBSFMwFVOlxd6U2dIn63zQYcAJGKfN4rxoCVhWGQ1+AvZgep3jjFxnI3V7W
         N/4yFDBoot/LMS5OAVtq3OWfEjxFKY/CfkMLiIoUrFjl1lTkUvLfsRmradir/z9Ht/Yv
         SUAw==
X-Forwarded-Encrypted: i=1; AJvYcCWTsyybtIQIXXmTG5qorH/zbdJ9qTGDPd4om3r9kJrQpSYFQXA1sZ81PF9pLKPCbhFyOrQRP8kb4cdzpmUUPNz4OQne
X-Gm-Message-State: AOJu0YyUIqEovoxQKLAf2NBhQWd7co10fqdLSG1oBGIoMIDsr9E6Jr//
	/Z8ZTXY7jc57kiiCNCD/9KbSeOPinuZ3EMJs0MJHNJe5Y+PTDXoDLGNmc4P3So576AA5nvu0wjj
	K4KayuHnNGHrVilK4WeTAeDessM7Nlc2BwnhEoy4IrCHO10hG0w==
X-Received: by 2002:a17:906:1d5a:b0:a44:4932:77bc with SMTP id o26-20020a1709061d5a00b00a44493277bcmr9873280ejh.40.1709721153178;
        Wed, 06 Mar 2024 02:32:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRe22S4SqrGlNO7V8LY++vwBAsejogoJnwlxUNb7hqtXbHFadVUntRgkJTOgRY5/bfNT/3Kw==
X-Received: by 2002:a17:906:1d5a:b0:a44:4932:77bc with SMTP id o26-20020a1709061d5a00b00a44493277bcmr9873264ejh.40.1709721152746;
        Wed, 06 Mar 2024 02:32:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id hj12-20020a170906874c00b00a456a97faaesm2831100ejb.86.2024.03.06.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:32:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0A9C0112F161; Wed,  6 Mar 2024 11:32:32 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf: Fix hashtab overflow check on 32-bit
 arches
In-Reply-To: <CAADnVQJ=NGbdQXOo=Eu4AG2m=AMJLYF+Gyqh99_YHGy8=EL_Nw@mail.gmail.com>
References: <20240229112250.13723-1-toke@redhat.com>
 <20240229112250.13723-3-toke@redhat.com>
 <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
 <65e10367cb393_33719208c2@john.notmuch> <878r32b04u.fsf@toke.dk>
 <CAADnVQLzVJRut0v2dQPbBUDW971Fd-EjkOf0pyLh5-W7wYwiYA@mail.gmail.com>
 <87plwa6tgv.fsf@toke.dk>
 <CAADnVQJ=NGbdQXOo=Eu4AG2m=AMJLYF+Gyqh99_YHGy8=EL_Nw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 06 Mar 2024 11:32:31 +0100
Message-ID: <87ttljtzuo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Mar 4, 2024 at 5:02=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Fri, Mar 1, 2024 at 4:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
>> >>
>> >> John Fastabend <john.fastabend@gmail.com> writes:
>> >>
>> >> > Alexei Starovoitov wrote:
>> >> >> On Thu, Feb 29, 2024 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8r=
gensen <toke@redhat.com> wrote:
>> >> >> >
>> >> >> > The hashtab code relies on roundup_pow_of_two() to compute the n=
umber of
>> >> >> > hash buckets, and contains an overflow check by checking if the =
resulting
>> >> >> > value is 0. However, on 32-bit arches, the roundup code itself c=
an overflow
>> >> >> > by doing a 32-bit left-shift of an unsigned long value, which is=
 undefined
>> >> >> > behaviour, so it is not guaranteed to truncate neatly. This was =
triggered
>> >> >> > by syzbot on the DEVMAP_HASH type, which contains the same check=
, copied
>> >> >> > from the hashtab code. So apply the same fix to hashtab, by movi=
ng the
>> >> >> > overflow check to before the roundup.
>> >> >> >
>> >> >> > The hashtab code also contained a check that prevents the total =
allocation
>> >> >> > size for the buckets from overflowing a 32-bit value, but since =
all the
>> >> >> > allocation code uses u64s, this does not really seem to be neces=
sary, so
>> >> >> > drop it and keep only the strict overflow check of the n_buckets=
 variable.
>> >> >> >
>> >> >> > Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing o=
verflow and zero size checks")
>> >> >> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >> >> > ---
>> >> >> >  kernel/bpf/hashtab.c | 10 +++++-----
>> >> >> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> >> >> >
>> >> >> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> >> >> > index 03a6a2500b6a..4caf8dab18b0 100644
>> >> >> > --- a/kernel/bpf/hashtab.c
>> >> >> > +++ b/kernel/bpf/hashtab.c
>> >> >> > @@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(union =
bpf_attr *attr)
>> >> >> >                                                           num_po=
ssible_cpus());
>> >> >> >         }
>> >> >> >
>> >> >> > -       /* hash table size must be power of 2 */
>> >> >> > -       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_ent=
ries);
>> >> >> >
>> >> >> >         htab->elem_size =3D sizeof(struct htab_elem) +
>> >> >> >                           round_up(htab->map.key_size, 8);
>> >> >> > @@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(unio=
n bpf_attr *attr)
>> >> >> >                 htab->elem_size +=3D round_up(htab->map.value_si=
ze, 8);
>> >> >> >
>> >> >> >         err =3D -E2BIG;
>> >> >> > -       /* prevent zero size kmalloc and check for u32 overflow =
*/
>> >> >> > -       if (htab->n_buckets =3D=3D 0 ||
>> >> >> > -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
>> >> >> > +       /* prevent overflow in roundup below */
>> >> >> > +       if (htab->map.max_entries > U32_MAX / 2 + 1)
>> >> >> >                 goto free_htab;
>> >> >>
>> >> >> No. We cannot artificially reduce max_entries that will break real=
 users.
>> >> >> Hash table with 4B elements is not that uncommon.
>> >>
>> >> Erm, huh? The existing code has the n_buckets > U32_MAX / sizeof(stru=
ct
>> >> bucket) check, which limits max_entries to 134M (0x8000000). This pat=
ch
>> >> is *increasing* the maximum allowable size by a factor of 16 (to 2.1B=
 or
>> >> 0x80000000).
>> >>
>> >> > Agree how about return E2BIG in these cases (32bit arch and overflo=
w) and
>> >> > let user figure it out. That makes more sense to me.
>> >>
>> >> Isn't that exactly what this patch does? What am I missing here?
>> >
>> > I see. Then what are you fixing?
>> > roundup_pow_of_two() will return 0 and existing code is fine as-is.
>>
>> On 64-bit arches it will, yes. On 32-bit arches it ends up doing a
>> 32-bit left-shift (1UL << 32) of a 32-bit type (unsigned long), which is
>> UB, so there's no guarantee that it truncates down to 0. And it seems at
>> least on arm32 it does not: syzbot managed to trigger a crash in the
>> DEVMAP_HASH code by creating a map with more than 0x80000000 entries:
>>
>> https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
>>
>> This patch just preemptively applies the same fix to the hashtab code,
>> since I could not find any reason why it shouldn't be possible to hit
>> the same issue there. I haven't actually managed to trigger a crash
>> there, though (I don't have any arm32 hardware to test this on), so in
>> that sense it's a bit theoretical for hashtab. So up to you if you want
>> to take this, but even if you don't, could you please apply the first
>> patch? That does fix the issue reported by syzbot (cf the
>> reported-and-tested-by tag).
>
> I see.
> Since roundup_pow_of_two() is non deterministic on 32-bit archs,
> let's fix them all.
>
> We have at least 5 to fix:
> bloom_filter.c:                 nr_bits =3D roundup_pow_of_two(nr_bits);
> devmap.c:               dtab->n_buckets =3D
> roundup_pow_of_two(dtab->map.max_entries);
> hashtab.c:      htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entr=
ies);
> stackmap.c:     n_buckets =3D roundup_pow_of_two(attr->max_entries);
>
> hashtab.c:           htab->map.max_entries =3D roundup(attr->max_entries,
>                                                 num_possible_cpus());
>
> bloom_filter looks ok as-is,
> but stack_map has the same issue as devmap and hashtab.
>
> Let's check for
> if (max_entries > (1u << 31))
> in 3 maps and that should be enough to cover all 5 cases?
>
> imo 1u << 31 is much easier to visualize than U32_MAX/2+1
>
> and don't touch other checks.
> This patch is removing U32_MAX / sizeof(struct bucket) check
> and with that introduces overflow just few lines below in bpf_map_area_al=
loc.

Are you sure there's an overflow there? I did look at that and concluded
that since bpf_map_area_alloc() uses a u64 for the size that it would
not actually overflow even with n_buckets =3D=3D 1<<31. There's a check in
__bpf_map_area_alloc() for the size:

	if (size >=3D SIZE_MAX)
		return NULL;

with

#define SIZE_MAX	(~(size_t)0)

in limits.h. So if sizeof(size_t) =3D=3D 4, that check against SIZE_MAX
should trip and the allocation will just fail; but there's no overflow
anywhere AFAICT?

Anyway, I'm OK with keeping the check; I'll respin with the changed
constant and add the check to stackmap.c as well.

-Toke

