Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A7134B6
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702973; cv=none; b=NaeYTRiot5C2eoEp/NPp0keYigbDIBM9/AfE9lhPdfFBH/aV8lPIoPKICdWc9iDE4W2owYUfYdNiqY3Scp+7+s6ajAcW/iVVNpZsU8AAiLSI6fSAwz0fMWCt/ARPw4noj/PRLBBzijpMRzyuNbyMFldqeEbYQ4TeawAiOBcRfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702973; c=relaxed/simple;
	bh=lFbWU2V4bUYv+UwUSolVewow5lpxe/1aVkrMjq6SfIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bwzycn5+7KE2Wzv7AGrb1NfM+5pmafXH8SgWE8AED6lHML2qvmRomURF6sw/wBkXHvIcSTMyX2xoTR2QOq13Dzto/sVPqwtgbX6YrPBVAR4cTR3Ug5h6MZNYICUMlEms6xtYrBbqbZ+frG+sycoPggcIID1IfDmGFeuF72t1nh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnLYQ46h; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnLYQ46h"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412eced6d1aso10946145e9.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 21:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709702970; x=1710307770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hO/jkYJiKShXeOvH8vrwngnXgZOiizip9D+4um2l42w=;
        b=OnLYQ46hD3UIa3qscWGDD4ZdU48EJrdzIGFUAgPrtn8g+4nIWN4lFwLpZ8bx+3XEY6
         52UKe7ksKINW9z3ye6UMIphHddMUdPPwj9jlQ05DaX5T6gLCyuh/jy5QbqniPZ1WzQLn
         K6kBpLaRcphZz0ABflj/jnAHdGUdQY9IL57sAoY2O8TPoygi3l2lFMBjaruPpdppy+OL
         x1tBMLQ7duT7z+sEYfS9NzmsMHlAHLxWlEmK35TJSDaQNa6xgNcTZvPKqg5YqClB44c0
         iuj+hYYo06L12r/eGC1putAkr5wXrHjhBnGLDlbUQxi0ZIK0cSpcyMwC5+rhlRY1HaKb
         JZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709702970; x=1710307770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hO/jkYJiKShXeOvH8vrwngnXgZOiizip9D+4um2l42w=;
        b=OkjktKVWh2jvLb0syG+1l8qZSCJEIt0o9cNZzO9JFYX9kDHXx1dkwRejsH5FUC4Fdk
         FKWqmYiSGM1xsieaM4KsVGRSdyzHAMw14B7+cyfoWPhvsLbAOuiHfkqDEX/fCUPnsKQ7
         fR86Y2lJ+/F5D5rzFfam8jxTsLfdaOAjKgMOQe0siwv2yTdT8IrQxfxDabLCUirkdPuh
         jtz1EfysM6IdGO3gm6Fh7r89K1jQ/f/gRD8hQiS8IDHlxKYfDuLAcBqt3lFicl9uM7Ak
         0GRadMiD4JmITLMmpKyR51TceG2bN89iC5++MVdQWAV9Ca/xUpAJk1/Mp02Ox1xOFCbU
         E8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWp2Qu+NZNjy1wralwk3bfYC7zTK8qHGpIICnSg+SnkfsG90XkrZ7pfwSrX9k0TF8YJBmWm8CtCrQR3KJkzs+kUsmaH
X-Gm-Message-State: AOJu0Yyc7+Ep3xYZ9SfbtTLzxRCxxhwaCa31S19rNoR4EfJpt2CkhNG3
	0ZMlyNwluvdXod/KXOIWjNrzobIlatDuyrRpehvzCR2dlsC8gcIOF5uM6yw2I8+cdLQfjRWwj1T
	2CTHWiNEdjgCPqpLTmguprGBxt58=
X-Google-Smtp-Source: AGHT+IGZOF2as98y33KVVJdSoeDImSeo+/fYQiw6kVoKcnfO7KwfyggCHbr971B2dA/AG4tcgSa3QRQE4CX5Sp4wYE4=
X-Received: by 2002:a5d:4e50:0:b0:33e:4ce5:9df5 with SMTP id
 r16-20020a5d4e50000000b0033e4ce59df5mr2235241wrt.12.1709702969566; Tue, 05
 Mar 2024 21:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229112250.13723-1-toke@redhat.com> <20240229112250.13723-3-toke@redhat.com>
 <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
 <65e10367cb393_33719208c2@john.notmuch> <878r32b04u.fsf@toke.dk>
 <CAADnVQLzVJRut0v2dQPbBUDW971Fd-EjkOf0pyLh5-W7wYwiYA@mail.gmail.com> <87plwa6tgv.fsf@toke.dk>
In-Reply-To: <87plwa6tgv.fsf@toke.dk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Mar 2024 21:29:18 -0800
Message-ID: <CAADnVQJ=NGbdQXOo=Eu4AG2m=AMJLYF+Gyqh99_YHGy8=EL_Nw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Fix hashtab overflow check on 32-bit arches
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 5:02=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Fri, Mar 1, 2024 at 4:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> >>
> >> John Fastabend <john.fastabend@gmail.com> writes:
> >>
> >> > Alexei Starovoitov wrote:
> >> >> On Thu, Feb 29, 2024 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rg=
ensen <toke@redhat.com> wrote:
> >> >> >
> >> >> > The hashtab code relies on roundup_pow_of_two() to compute the nu=
mber of
> >> >> > hash buckets, and contains an overflow check by checking if the r=
esulting
> >> >> > value is 0. However, on 32-bit arches, the roundup code itself ca=
n overflow
> >> >> > by doing a 32-bit left-shift of an unsigned long value, which is =
undefined
> >> >> > behaviour, so it is not guaranteed to truncate neatly. This was t=
riggered
> >> >> > by syzbot on the DEVMAP_HASH type, which contains the same check,=
 copied
> >> >> > from the hashtab code. So apply the same fix to hashtab, by movin=
g the
> >> >> > overflow check to before the roundup.
> >> >> >
> >> >> > The hashtab code also contained a check that prevents the total a=
llocation
> >> >> > size for the buckets from overflowing a 32-bit value, but since a=
ll the
> >> >> > allocation code uses u64s, this does not really seem to be necess=
ary, so
> >> >> > drop it and keep only the strict overflow check of the n_buckets =
variable.
> >> >> >
> >> >> > Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing ov=
erflow and zero size checks")
> >> >> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> >> > ---
> >> >> >  kernel/bpf/hashtab.c | 10 +++++-----
> >> >> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >> >> >
> >> >> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> >> > index 03a6a2500b6a..4caf8dab18b0 100644
> >> >> > --- a/kernel/bpf/hashtab.c
> >> >> > +++ b/kernel/bpf/hashtab.c
> >> >> > @@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(union b=
pf_attr *attr)
> >> >> >                                                           num_pos=
sible_cpus());
> >> >> >         }
> >> >> >
> >> >> > -       /* hash table size must be power of 2 */
> >> >> > -       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entr=
ies);
> >> >> >
> >> >> >         htab->elem_size =3D sizeof(struct htab_elem) +
> >> >> >                           round_up(htab->map.key_size, 8);
> >> >> > @@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(union=
 bpf_attr *attr)
> >> >> >                 htab->elem_size +=3D round_up(htab->map.value_siz=
e, 8);
> >> >> >
> >> >> >         err =3D -E2BIG;
> >> >> > -       /* prevent zero size kmalloc and check for u32 overflow *=
/
> >> >> > -       if (htab->n_buckets =3D=3D 0 ||
> >> >> > -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
> >> >> > +       /* prevent overflow in roundup below */
> >> >> > +       if (htab->map.max_entries > U32_MAX / 2 + 1)
> >> >> >                 goto free_htab;
> >> >>
> >> >> No. We cannot artificially reduce max_entries that will break real =
users.
> >> >> Hash table with 4B elements is not that uncommon.
> >>
> >> Erm, huh? The existing code has the n_buckets > U32_MAX / sizeof(struc=
t
> >> bucket) check, which limits max_entries to 134M (0x8000000). This patc=
h
> >> is *increasing* the maximum allowable size by a factor of 16 (to 2.1B =
or
> >> 0x80000000).
> >>
> >> > Agree how about return E2BIG in these cases (32bit arch and overflow=
) and
> >> > let user figure it out. That makes more sense to me.
> >>
> >> Isn't that exactly what this patch does? What am I missing here?
> >
> > I see. Then what are you fixing?
> > roundup_pow_of_two() will return 0 and existing code is fine as-is.
>
> On 64-bit arches it will, yes. On 32-bit arches it ends up doing a
> 32-bit left-shift (1UL << 32) of a 32-bit type (unsigned long), which is
> UB, so there's no guarantee that it truncates down to 0. And it seems at
> least on arm32 it does not: syzbot managed to trigger a crash in the
> DEVMAP_HASH code by creating a map with more than 0x80000000 entries:
>
> https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
>
> This patch just preemptively applies the same fix to the hashtab code,
> since I could not find any reason why it shouldn't be possible to hit
> the same issue there. I haven't actually managed to trigger a crash
> there, though (I don't have any arm32 hardware to test this on), so in
> that sense it's a bit theoretical for hashtab. So up to you if you want
> to take this, but even if you don't, could you please apply the first
> patch? That does fix the issue reported by syzbot (cf the
> reported-and-tested-by tag).

I see.
Since roundup_pow_of_two() is non deterministic on 32-bit archs,
let's fix them all.

We have at least 5 to fix:
bloom_filter.c:                 nr_bits =3D roundup_pow_of_two(nr_bits);
devmap.c:               dtab->n_buckets =3D
roundup_pow_of_two(dtab->map.max_entries);
hashtab.c:      htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entrie=
s);
stackmap.c:     n_buckets =3D roundup_pow_of_two(attr->max_entries);

hashtab.c:           htab->map.max_entries =3D roundup(attr->max_entries,
                                                num_possible_cpus());

bloom_filter looks ok as-is,
but stack_map has the same issue as devmap and hashtab.

Let's check for
if (max_entries > (1u << 31))
in 3 maps and that should be enough to cover all 5 cases?

imo 1u << 31 is much easier to visualize than U32_MAX/2+1

and don't touch other checks.
This patch is removing U32_MAX / sizeof(struct bucket) check
and with that introduces overflow just few lines below in bpf_map_area_allo=
c.
