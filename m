Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BD26AF5
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812863; cv=none; b=osEX7JLB8GBrkuwSd1G0KjShhANnDI2fPtkprb2U49Wd5f8m31yMXxwV6WrV0jibPDTQudo2x3RQy8UZlUHrbwJXa7PFgQyfSzqOg3iCctgN6X5hJmYDR/SsQxaH2hxXoszDLXuW4OCgFSoNMKr35g/6VMMNqebWMxg/pagJQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812863; c=relaxed/simple;
	bh=pz6IMMaiKPqt8CdcIXoDhU6zkkKix3U+LGPUNTFhd8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYcoTy5hB2Kt688MqYe26LMPryu1G1qA+pZ2rENCRjqvlewpclmmfEDPR2wNhrJzVZnStYaucFqhzowxkFmdv4M/ukTUTpv3sOOJaNyoZBHXgTGm/S+djIfgW2zUboGWyhAbkxIBkxhi6GUZwdPfVGxRDriRPz4U8xuVncV4ROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/cFKfjG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/cFKfjG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709812860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PprRn8kDI3/wfv4+syTNP4ngO62qKbq8b99tpYkD9zA=;
	b=N/cFKfjGdLdfXIVKjPn0KtQ9s5EBeRn4eGrCwpP494CNHJ6sZ/ZGJER5oNWi4A3fjTPMpx
	zRxa8pvhkQpRJCKKPFMWUO2Tmwpt/RqIgYmh+oyD0TKtovYlOJ/W9mK7WTBmLWIXR4W50X
	XDToQkrrhS3y3f0o6vVWDFwa7WQp+0o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-hgv4YhIzMheae-LduBzE3A-1; Thu, 07 Mar 2024 07:00:59 -0500
X-MC-Unique: hgv4YhIzMheae-LduBzE3A-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d34662d6c0so6467191fa.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 04:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812857; x=1710417657;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PprRn8kDI3/wfv4+syTNP4ngO62qKbq8b99tpYkD9zA=;
        b=LCj5z1PJxMOm/JJO9wMkbDFU5ls5qNBWL3NAmnu6lCp6wlMJRiIXjpsrwRCclvODPg
         CrWA+TBEq3PGezRSnP3WOeyRvuLdlW7wdtMMdaRf8juq17XcRdnfCEsaV71NvvB/HZTL
         KsQMMUw7mtR1uTF7vAC5D1X98HdJfuQMR5+XbtXEUaXMpGGvQu29CjFHqmfIfB0C6Z3n
         FOye2WgqMC8x3k9Qv/Y16bxFQTA+3733WfTmh3lijIpCOoH0XxTbvhemYRX+LeZaK6zG
         jRXX+7Oe+NkRyvno0pxsvv9QgBCI/dn6qrE3547U56vzkHMHvSCyUF028ijzQjky3gSO
         irdA==
X-Forwarded-Encrypted: i=1; AJvYcCUpxgW7i//mDxx0pxF6P/nbHheMHjQsRbwpAuc0jcV2d/7HTSzCP2q3IeUiCWyHJ/qhJhziPUxQi+svc1gMyOhTnibW
X-Gm-Message-State: AOJu0YwgEeqKz4nQBuchjTYC46uib9HLTKb6Y2MhCLA07br7cpgssdg4
	+8M+cUnvpyAg0qlmO9uiMHB37hMXmp3pelMk8SIQsoJA+oRCCuiCQGfeTscODRvUY924rDSR0rf
	DBnR4tIYPG6jyvpa9KFyqDyG4jqDyGxIXuK2ErkMe64GoTnCkpA==
X-Received: by 2002:a2e:8ec1:0:b0:2d2:9906:6db2 with SMTP id e1-20020a2e8ec1000000b002d299066db2mr1147113ljl.39.1709812857102;
        Thu, 07 Mar 2024 04:00:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOGO1es7q+9Yoxl2lC3nryqesyRrXgvC/A+cktWzcX15OxWseDrJwKVl0hzBhxIr22EHshfA==
X-Received: by 2002:a2e:8ec1:0:b0:2d2:9906:6db2 with SMTP id e1-20020a2e8ec1000000b002d299066db2mr1147089ljl.39.1709812856486;
        Thu, 07 Mar 2024 04:00:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b005657eefa8e9sm8015764edb.4.2024.03.07.04.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:00:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 85CA0112F374; Thu,  7 Mar 2024 13:00:55 +0100 (CET)
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
In-Reply-To: <CAADnVQJgk7oHnwH5qmbKFchpTQSTAc8ByMyx_iA_XYmkL-YNmw@mail.gmail.com>
References: <20240229112250.13723-1-toke@redhat.com>
 <20240229112250.13723-3-toke@redhat.com>
 <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
 <65e10367cb393_33719208c2@john.notmuch> <878r32b04u.fsf@toke.dk>
 <CAADnVQLzVJRut0v2dQPbBUDW971Fd-EjkOf0pyLh5-W7wYwiYA@mail.gmail.com>
 <87plwa6tgv.fsf@toke.dk>
 <CAADnVQJ=NGbdQXOo=Eu4AG2m=AMJLYF+Gyqh99_YHGy8=EL_Nw@mail.gmail.com>
 <87ttljtzuo.fsf@toke.dk>
 <CAADnVQJgk7oHnwH5qmbKFchpTQSTAc8ByMyx_iA_XYmkL-YNmw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 07 Mar 2024 13:00:55 +0100
Message-ID: <87y1aus13c.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Mar 6, 2024 at 2:32=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Mon, Mar 4, 2024 at 5:02=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
>> >>
>> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> >>
>> >> > On Fri, Mar 1, 2024 at 4:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rge=
nsen <toke@redhat.com> wrote:
>> >> >>
>> >> >> John Fastabend <john.fastabend@gmail.com> writes:
>> >> >>
>> >> >> > Alexei Starovoitov wrote:
>> >> >> >> On Thu, Feb 29, 2024 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=
=B8rgensen <toke@redhat.com> wrote:
>> >> >> >> >
>> >> >> >> > The hashtab code relies on roundup_pow_of_two() to compute th=
e number of
>> >> >> >> > hash buckets, and contains an overflow check by checking if t=
he resulting
>> >> >> >> > value is 0. However, on 32-bit arches, the roundup code itsel=
f can overflow
>> >> >> >> > by doing a 32-bit left-shift of an unsigned long value, which=
 is undefined
>> >> >> >> > behaviour, so it is not guaranteed to truncate neatly. This w=
as triggered
>> >> >> >> > by syzbot on the DEVMAP_HASH type, which contains the same ch=
eck, copied
>> >> >> >> > from the hashtab code. So apply the same fix to hashtab, by m=
oving the
>> >> >> >> > overflow check to before the roundup.
>> >> >> >> >
>> >> >> >> > The hashtab code also contained a check that prevents the tot=
al allocation
>> >> >> >> > size for the buckets from overflowing a 32-bit value, but sin=
ce all the
>> >> >> >> > allocation code uses u64s, this does not really seem to be ne=
cessary, so
>> >> >> >> > drop it and keep only the strict overflow check of the n_buck=
ets variable.
>> >> >> >> >
>> >> >> >> > Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missin=
g overflow and zero size checks")
>> >> >> >> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.=
com>
>> >> >> >> > ---
>> >> >> >> >  kernel/bpf/hashtab.c | 10 +++++-----
>> >> >> >> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> >> >> >> >
>> >> >> >> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> >> >> >> > index 03a6a2500b6a..4caf8dab18b0 100644
>> >> >> >> > --- a/kernel/bpf/hashtab.c
>> >> >> >> > +++ b/kernel/bpf/hashtab.c
>> >> >> >> > @@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(uni=
on bpf_attr *attr)
>> >> >> >> >                                                           num=
_possible_cpus());
>> >> >> >> >         }
>> >> >> >> >
>> >> >> >> > -       /* hash table size must be power of 2 */
>> >> >> >> > -       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_=
entries);
>> >> >> >> >
>> >> >> >> >         htab->elem_size =3D sizeof(struct htab_elem) +
>> >> >> >> >                           round_up(htab->map.key_size, 8);
>> >> >> >> > @@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(u=
nion bpf_attr *attr)
>> >> >> >> >                 htab->elem_size +=3D round_up(htab->map.value=
_size, 8);
>> >> >> >> >
>> >> >> >> >         err =3D -E2BIG;
>> >> >> >> > -       /* prevent zero size kmalloc and check for u32 overfl=
ow */
>> >> >> >> > -       if (htab->n_buckets =3D=3D 0 ||
>> >> >> >> > -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
>> >> >> >> > +       /* prevent overflow in roundup below */
>> >> >> >> > +       if (htab->map.max_entries > U32_MAX / 2 + 1)
>> >> >> >> >                 goto free_htab;
>> >> >> >>
>> >> >> >> No. We cannot artificially reduce max_entries that will break r=
eal users.
>> >> >> >> Hash table with 4B elements is not that uncommon.
>> >> >>
>> >> >> Erm, huh? The existing code has the n_buckets > U32_MAX / sizeof(s=
truct
>> >> >> bucket) check, which limits max_entries to 134M (0x8000000). This =
patch
>> >> >> is *increasing* the maximum allowable size by a factor of 16 (to 2=
.1B or
>> >> >> 0x80000000).
>> >> >>
>> >> >> > Agree how about return E2BIG in these cases (32bit arch and over=
flow) and
>> >> >> > let user figure it out. That makes more sense to me.
>> >> >>
>> >> >> Isn't that exactly what this patch does? What am I missing here?
>> >> >
>> >> > I see. Then what are you fixing?
>> >> > roundup_pow_of_two() will return 0 and existing code is fine as-is.
>> >>
>> >> On 64-bit arches it will, yes. On 32-bit arches it ends up doing a
>> >> 32-bit left-shift (1UL << 32) of a 32-bit type (unsigned long), which=
 is
>> >> UB, so there's no guarantee that it truncates down to 0. And it seems=
 at
>> >> least on arm32 it does not: syzbot managed to trigger a crash in the
>> >> DEVMAP_HASH code by creating a map with more than 0x80000000 entries:
>> >>
>> >> https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
>> >>
>> >> This patch just preemptively applies the same fix to the hashtab code,
>> >> since I could not find any reason why it shouldn't be possible to hit
>> >> the same issue there. I haven't actually managed to trigger a crash
>> >> there, though (I don't have any arm32 hardware to test this on), so in
>> >> that sense it's a bit theoretical for hashtab. So up to you if you wa=
nt
>> >> to take this, but even if you don't, could you please apply the first
>> >> patch? That does fix the issue reported by syzbot (cf the
>> >> reported-and-tested-by tag).
>> >
>> > I see.
>> > Since roundup_pow_of_two() is non deterministic on 32-bit archs,
>> > let's fix them all.
>> >
>> > We have at least 5 to fix:
>> > bloom_filter.c:                 nr_bits =3D roundup_pow_of_two(nr_bits=
);
>> > devmap.c:               dtab->n_buckets =3D
>> > roundup_pow_of_two(dtab->map.max_entries);
>> > hashtab.c:      htab->n_buckets =3D roundup_pow_of_two(htab->map.max_e=
ntries);
>> > stackmap.c:     n_buckets =3D roundup_pow_of_two(attr->max_entries);
>> >
>> > hashtab.c:           htab->map.max_entries =3D roundup(attr->max_entri=
es,
>> >                                                 num_possible_cpus());
>> >
>> > bloom_filter looks ok as-is,
>> > but stack_map has the same issue as devmap and hashtab.
>> >
>> > Let's check for
>> > if (max_entries > (1u << 31))
>> > in 3 maps and that should be enough to cover all 5 cases?
>> >
>> > imo 1u << 31 is much easier to visualize than U32_MAX/2+1
>> >
>> > and don't touch other checks.
>> > This patch is removing U32_MAX / sizeof(struct bucket) check
>> > and with that introduces overflow just few lines below in bpf_map_area=
_alloc.
>>
>> Are you sure there's an overflow there? I did look at that and concluded
>> that since bpf_map_area_alloc() uses a u64 for the size that it would
>> not actually overflow even with n_buckets =3D=3D 1<<31. There's a check =
in
>> __bpf_map_area_alloc() for the size:
>>
>>         if (size >=3D SIZE_MAX)
>>                 return NULL;
>>
>> with
>>
>> #define SIZE_MAX        (~(size_t)0)
>>
>> in limits.h. So if sizeof(size_t) =3D=3D 4, that check against SIZE_MAX
>> should trip and the allocation will just fail; but there's no overflow
>> anywhere AFAICT?
>
> There is an overflow _before_ it calls into bpf_map_area_alloc().
> Here is the line:
>         htab->buckets =3D bpf_map_area_alloc(htab->n_buckets *
>                                            sizeof(struct bucket),
>                                            htab->map.numa_node);
> that's why we have:
> if (htab->n_buckets > U32_MAX / sizeof(struct bucket))
> before that.

Ah, right. I was assuming that the compiler was smart enough to
implicitly convert that into the type of the function parameter before
doing the multiplication, but of course that's not the case. Thanks!

-Toke

