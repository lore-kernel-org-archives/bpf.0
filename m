Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794658808;
	b=wW3B+Nz7lYkbN9IRsF/bqTxjErSuKa8Cyx2ZLs7H/EBaaZUgyIUIdVBDKgDIcrWQOUNl
	 T/hINrlSY26/JZ9Qze6+JYNNxs+SX+cxc5VvYX8F3XczvEHZm08ijqLsm4cjlqzeike6P
	 WT0qXZj0xstGKyX+edz8Ysb73seaqVSZ0cJr4gDvOu6Hw7nvoUjDa2R6DF2WQitI0j+B8
	 Ncuh/4tKDzwnRn4v9QJ41QBmW86i0XuVJwJKc8lw+w0EjOgF9fjrKIpbZhDE7HmQHVMEE
	 a5W5VIOkZEE5d3dy+tRexMFq1nUUP8sl27j7jy+h+eziHwhXdko8z/zQDUO1yIEY5AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794658808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=prJY6HPr5koA7BQDxyK6SJbRCN9r/Z2GnnEB4nhqaes=;
	b=gfnLS1b4dXcZY8wbj7uJwCgDtb7aOYYdoTiLynh/w4kPQ5FfckjeHEU/byNJ/dmPHc+2
	 RuGCm67H9lHKrInH6DyAgwGdM8mWyKlJ8rbZBnDSUjYv78ZStty1zOszRIyQO3qRHgEhD
	 FhShBTxXX6H8pERiDhRFsR1j2wLMp7KxfrjtJipt/PF/19sY8tW6gm1Y6hSmxEO2u+EAO
	 NfFFqiCElIhQRqnIIaP9WbVBgIVs9hcmM56GveAGTeXAl6YOJhvrL09aFTSJ2ptD9zndo
	 qAxtBiGfLqlt5ed0E854OgYTf6rXlkx8WXKkX24e264U2M4LqcsgGBa31gHr5csCjkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a8pjTFpe;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8963606A33B
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 12:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8963606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a8pjTFpe
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so16943495e9.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 04:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794658806; x=1795263606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prJY6HPr5koA7BQDxyK6SJbRCN9r/Z2GnnEB4nhqaes=;
        b=a8pjTFpeZ5xGG4NHJqKYwQZhnOtxfiEUplvNQcLcSKep5HLDIPKV8nUbxYTCmKgNz/
         kUogDNir1gyLLFSIWeGRoeb7UJIGt5tsexWOSnb+9D0BpI7ZXvnamKAf9QMj1sY7VaVr
         Tor4N2sMheNaxTTic9VHDcRmzxLqvLuzFbcZtdajQprcsxmuPZd89bRuxaZfUvbIfXhf
         am2o0vxrF/HuBdg/q3vuCWYyzmd1cVEfcWqnCpy/QSpCdCEIn6Mpo8ehMjCbLx1B4BZW
         uUz9SIuD0awqh3SGa6gTfSiLOymeQjbTi4AdhqNLZTENqFGEuysXBPY7AbChyUVlGlyY
         qCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794658806; x=1795263606;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prJY6HPr5koA7BQDxyK6SJbRCN9r/Z2GnnEB4nhqaes=;
        b=FWG2cPbC2/jMr1AhDr4gluI9427XpYCkqc01cj3zPW2N6KpTdF8JsMj6Q7qogSAKbq
         vBBnmB7e2nb+2+KeY0NxSgnBmy8sva22xQL6T4QvUiB1VDlAiL/5jpCezApvc8hG/iUA
         TiJsLlIDmtKxDDydMi10Kf1USTIYzBI/2O6DRvRHb7NMX86dwUx6+cYLgG4FR1SOzCRy
         cEb7Lcq5e4JgnguvGpbSsdXf8nCiLlZo1CEO3Mgz9DmJ25l/83bbZel69o5a2ofikrRw
         VuFk/dEPEcZQp+sIXBo35hI0F6W7bSgL9fLf7tUyAfEBHY1OuO6E8Sfwbl2OGxUt9wxz
         biUw==
X-Forwarded-Encrypted: i=1; AL+hErExKxhkBqZM246JV8QsUsInEW1gf9MWpZFJzYEmTiv3cgrleSAAawM8I89F8wRIzxiPhmQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LyWskX1jhmvtt4A4ld2MzbtOE3vqpXXYcKJlWPQiDk8WRfs2e
	Lg0zLqJe+sQrFOLs3zDyweSbHF99Ne4GoJLEkbbIOCBsOfunhVHdINYk
X-Gm-Gg: AYBFou23aBZyu1sx32cuMhgkIF7Oq/PeBF9v6Y0TXrsNPK3NcRFcHIALoJFPrDNMWCr
	CeMmAWE2veT6hbJLbt2EysMW6yQCc1igGbU2mggjxXDV2Q2QE17568LTcgb3BFlaDDRvtsBo2kn
	hth+joyy/COGZc1Zz1GtNRtZ27qXG+apzTUkhy6PSrtdbNIeihOIv/gMfcS+zvEvN/vYoZIGNt8
	VlcBIHwfnExTkSxpM/u2+T04GvS9EPnMNIXCQSOjdOldBTSkXEm9BKuU541ouxtagmU27QZIhwV
	eGNu13+gBGAmY12vf/D7acKO1j0+DJAwYZzpRymnNJTD2mwHqLZXGjABb0gOa0YAvd/idGwPJiA
	F0BCFaXNVLYuIEUTufFYeW6JkABgCALOTRCtiawq7bacVZPEl7P4UvP0Xl8qyigeGG1Twc2kWZu
	QfQ7L0lLC6ivBMsFAwxJvWhHKekZiLKf4zI+/FvVQMnVeSb7Sx2AZjju0wlyxPbgP2kLr5wJ453
	E5ZsX6/ukmFUrsZsIkbZH0qfGRRSwJojtFEy3oMnhQCKiCKEIXP8JRX6txHu0qTqVojIjVPkE1A
	AlAoA28ruN2ZY72+c5NW30qVGwNCl4rWLy5bq6WwBTRBgbog4+tx/ZhCsez1WHlnoz7l+K2QQe2
	QrymP7KFRBAs=
X-Received: by 2002:a05:600c:4f90:b0:4a2:8c5:5e5 with SMTP id 5b1f17b1804b1-4bb55a47680mr107254845e9.7.1794658805736;
        Sat, 14 Nov 2026 04:20:05 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56719391sm55103415e9.1.2026.11.14.04.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:20:05 -0800 (PST)
Date: Sat, 14 Nov 2026 12:20:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Petr Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, Lorenzo Stoakes
 <ljs@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Andrey Grodzovsky
 <andrey.grodzovsky@crowdstrike.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 next 08/13] kallsyms: Optimise symbol name search
Message-ID: <20261114122004.758239d4@pumpkin>
In-Reply-To: <CAG2KctqLmjL1EZgc8GoLZ_FU9xvqYam_xabvT2q=Ofm91CW38g@mail.gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
	<20261111115911.1142000-9-david.laight.linux@gmail.com>
	<CAG2KctqLmjL1EZgc8GoLZ_FU9xvqYam_xabvT2q=Ofm91CW38g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Nov 2026 16:45:33 -0800
Samuel Wu <wusamuel@google.com> wrote:

> On Wed, Nov 11, 2026 at 3:59=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > Change the alphabetically ordered lookup table (kallsyms_seqs_of_names)
> > to one that indexes the table of compressed names rather than the
> > array of symbol values.
> > This removes all the linear scans during the binary search for the symb=
ol
> > name.
> > Once the name has been found a second binary search of the 'markers' ar=
ray
> > followed by a linear scan for the symbols address gives the symbol valu=
e.
> >
> > This linear scan is done once for each address returned, whereas the old
> > code did the scan for each of the ~17 comparisons in the binary search
> > (and the binary search was done twice for a symbol that appears once).
> >
> > For normal kernels the index table stays at 24 bits per symbol (now host
> > ordered), but a 32 bit table is used if necessary (probably only for
> > allyesconfig builds - which needs 26 bits on x86-64).
> >
> > Use the low bit of the index table value to indicate that the symbol has
> > the same name as the previous one.
> > Use this to avoid the second lookup to find if the name is unique, speed
> > up the search for the first symbol with a given name, and simplify
> > kallsyms_on_each_match_symbol().
> >
> > Speeds up lookup by name by a factor of about 12, and makes a massive
> > difference to the time taken to lookup symbols that occur 100s or
> > 1000s (or maybe 10000s) of times.
> >
> > The slowest 'lookup by name' changes being a symbol that is duplicated =
a lot
> > to one that is very long.
> >
> > Build for BE kernels correctly flips the byte order in the index table.
> >
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >
> > v3:
> > - Use a discrimant union for the name table instead of weak symbols.
> >   Undefined weak symbols can't be guaranteed to be zero and a build
> >   mismatch left both undefined.
> > - Patch the kallsyms_off_size_24 static key from an initcall,
> >   the first name lookup might not be allowed to sleep.
> >   Leave a conditional in the 32bit offset case, it is unlikely
> >   to be needed for a real kernel.
> > - Merge in the following patch that optimised the scan for duplicates.
> >
> >  kernel/kallsyms.c          | 162 ++++++++++++++++++++++++-------------
> >  kernel/kallsyms_internal.h |   7 +-
> >  scripts/kallsyms.c         |  49 +++++++----
> >  3 files changed, 148 insertions(+), 70 deletions(-)
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index d18d78e626db..fd42a1a8ed3e 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -177,6 +177,36 @@ static unsigned int get_symbol_offset(unsigned lon=
g pos)
> >         return name - kallsyms_names;
> >  }
> >
> > +/*
> > + * Find the value of a symbol given the offset in the compressed strea=
m.
> > + */
> > +static unsigned long get_name_address(unsigned int name_offset)
> > +{
> > +       unsigned int low, pos, high;
> > +
> > +       low =3D 0;
> > +       high =3D ((kallsyms_num_syms - 1) >> 8) + 1;
> > +
> > +       while (high - low > 1) {
> > +               pos =3D low + (high - low) / 2;
> > +               if (name_offset >=3D kallsyms_markers[pos])
> > +                       low =3D pos;
> > +               else
> > +                       high =3D pos;
> > +       }
> > +
> > +       pos =3D kallsyms_markers[low];
> > +       for (low <<=3D 8; pos < name_offset; low++) {
> > +               unsigned int len =3D kallsyms_names[pos];
> > +               if (len & 0x80)
> > +                       len +=3D (kallsyms_names[pos + 1] << 7) - 0x7f;
> > +               pos +=3D 1 + len;
> > +       } =20
>=20
> Is this just get_symbol_data() from previous patch? If so, that would
> make it more readable.

Readability is in the eye of the reader!
Open-coded you can see what it does without jumping around the file
to find the definition...

It is much the same logic.
But it isn't quite the same - it needs the offset to the next symbol
not the pointer to the symbol data.
It is the same as get_symbol_offset() uses, there are enough changes in
this set without adding extra ones.

>=20
> > +
> > +       return kallsyms_sym_address(low);
> > +}
> > +
> > +
> >  unsigned long kallsyms_sym_address(int idx)
> >  {
> >         /* non-relocatable 32-bit kernels just embed the value directly=
 */
> > @@ -185,66 +215,87 @@ unsigned long kallsyms_sym_address(int idx)
> >         return (unsigned long)offset_to_ptr(kallsyms_offsets + idx);
> >  }
> >
> > -static unsigned int get_symbol_seq(int index)
> > -{
> > -       unsigned int i, seq =3D 0;
> > +static DEFINE_STATIC_KEY_FALSE(kallsyms_off_size_24);
> >
> > -       for (i =3D 0; i < 3; i++)
> > -               seq =3D (seq << 8) | kallsyms_seqs_of_names[3 * index +=
 i];
> > +/*
> > + * Get the offset into the compressed list of names for the n'th
> > + * symbol in the 'sorted by name' list.
> > + * Returns 'offset << 1 | is_duplicate_name'.
> > + * To save memory (the array can have 200k+ entries) the values are us=
ually
> > + * 24 bit (host ordered) but will be 32 bit if necessary.
> > + */
> > +static inline unsigned int get_symbol_name_offset(unsigned long index)
> > +{
> > +       if (static_branch_likely(&kallsyms_off_size_24) ||
> > +           unlikely(kallsyms_offs_of_names.size =3D=3D 24)) {
> > +               u8 *off =3D kallsyms_offs_of_names.offs + index * 3;
> > +#if !defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> > +               return ((struct {unsigned int v:24 __packed; } __packed=
 *)off)->v;
> > +#else
> > +#if defined(__BIG_ENDIAN)
> > +               return (*(u32 *)(off - 1)) & 0xffffff;
> > +#else
> > +               return (*(u32 *)(off - 1)) >> 8;
> > +#endif
> > +#endif
> > +       }
> >
> > -       return seq;
> > +       return ((u32 *)&kallsyms_offs_of_names.offs)[index];
> >  }
> >
> > -static int kallsyms_lookup_names(const char *name,
> > -                                unsigned int *start,
> > -                                unsigned int *end)
> > +static int kallsyms_set_kallsyms_off_size(void)
> >  {
> > +       if (kallsyms_offs_of_names.size =3D=3D 24)
> > +               static_branch_enable(&kallsyms_off_size_24);
> > +
> > +       return 0;
> > +}
> > +early_initcall(kallsyms_set_kallsyms_off_size);
> > +
> > +static int kallsyms_lookup_names(const char *name, unsigned int *start)
> > +{
> > +       unsigned int mid, off;
> > +       int low, high;
> >         int ret;
> > -       int low, mid, high; =20
>=20
> nit: any issue with mixing signed and unsigned here? Simpler to keep
> them the same type if possible.

=46rom what I remember they can't all be unsigned.
It might only be because kallsyms_num_syms can, in theory, be 0.
If low and high are signed that doesn't need a separate check.
mid is best unsigned because it is used for an array index
(on sane architectures that zero extend 32bit results in 64bit regs).

>=20
> > -       unsigned int seq, off;
> >         low =3D 0;
> >         high =3D kallsyms_num_syms - 1;
> >
> > -       while (low <=3D high) {
> > +       for (;;) {
> > +               if (low > high)
> > +                       return -1;
> >                 mid =3D low + (high - low) / 2;
> > -               seq =3D get_symbol_seq(mid);
> > -               off =3D get_symbol_offset(seq);
> > -               ret =3D kallsyms_strcmp_symbol(off, name);
> > -               if (ret > 0)
> > +               off =3D get_symbol_name_offset(mid);
> > +               ret =3D kallsyms_strcmp_symbol(off >> 1, name);
> > +               if (ret > 0) {
> >                         low =3D mid + 1;
> > -               else if (ret < 0)
> > -                       high =3D mid - 1;
> > -               else
> > -                       break;
> > -       }
> > -
> > -       if (low > high)
> > -               return -ESRCH;
> > -
> > -       low =3D mid;
> > -       while (low) {
> > -               seq =3D get_symbol_seq(low - 1);
> > -               off =3D get_symbol_offset(seq);
> > -               if (kallsyms_strcmp_symbol(off, name) !=3D 0)
> > -                       break;
> > -               low--;
> > -       }
> > -       *start =3D low;
> > -
> > -       if (end) {
> > -               high =3D mid;
> > -               while (high < kallsyms_num_syms - 1) {
> > -                       seq =3D get_symbol_seq(high + 1);
> > -                       off =3D get_symbol_offset(seq);
> > -                       if (kallsyms_strcmp_symbol(off, name) !=3D 0)
> > +                       continue;
> > +               }
> > +               if (!ret) {
> > +                       /*
> > +                        * Found a match, but need the first one.
> > +                        * Most symbols (and all exported/global ones) =
only occur
> > +                        * once, most of the others only occur a small =
number of
> > +                        * times so it is worth doing a linear scan tha=
t avoids the
> > +                        * kallsyms_strcmp_symbol() call.
> > +                        * However some symbols occur a large number of=
 times
> > +                        * (_sub_D_65535_0 is repeated 24610 times in a=
n x86-64
> > +                        * allyesconfig, __func__.0 442 in a more norma=
l kernel).
> > +                        * Avoid a long linear scan by returning to the=
 binary
> > +                        * search if a short linear search is fruitless.
> > +                        */
> > +                       unsigned int scan =3D 16;
> > +                       while ((off & 1) && scan--)
> > +                               off =3D get_symbol_name_offset(--mid);
> > +                       if (!(off & 1)) =20
>=20
> Curious if you have numbers comparing with and without this linear
> scan. Did a quick check on my desktop and phone, and ~99% of symbols
> are unique already; of the ~1% that are repeated, they're generally
> compiler generated local variables which I think are rare targets for
> symbolization (AFAIK).

Indeed duplicates are unusual and unlikely to be looked up.
So the single bit check is definitely a win.
Most of the duplicates only appear a very few times (IIRC most just twice)
so if you do look one up the linear scan saves the name compare.
The loop is also cheap (the compiler will optimise away one of the
(off & 1) tests) and doesn't usually cost anything.

The selftest code does look up all the symbols, with just the linear
scan it affects the results.

> Just a vanilla lower_bound() would halve the line count of this function.=
 :)

I'm not sure what you mean.
Without the 'duplicate' flag continuing the binary search so that it will f=
ind
the first match pretty much costs (on average) one extra compare for every
lookup (of unique names).
The bounded linear scan is only 3 lines.

Deleting the comment would save more lines :-)

David

>=20
> >                                 break;
> > -                       high++;
> >                 }
> > -               *end =3D high;
> > +               high =3D mid - 1;
> >         }
> >
> > -       return 0;
> > +       *start =3D mid;
> > +
> > +       return off;
> >  }
> >
> >  /* Lookup the address for this symbol. Returns 0 if not found. */
> > @@ -257,9 +308,9 @@ unsigned long kallsyms_lookup_name(const char *name)
> >         if (!*name)
> >                 return 0;
> >
> > -       ret =3D kallsyms_lookup_names(name, &i, NULL);
> > -       if (!ret)
> > -               return kallsyms_sym_address(get_symbol_seq(i));
> > +       ret =3D kallsyms_lookup_names(name, &i);
> > +       if (ret >=3D 0)
> > +               return get_name_address(ret >> 1);
> >
> >         return module_kallsyms_lookup_name(name);
> >  }
> > @@ -289,17 +340,20 @@ int kallsyms_on_each_symbol(int (*fn)(void *, con=
st char *, unsigned long),
> >  int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
> >                                   const char *name, void *data)
> >  {
> > -       int ret;
> > -       unsigned int i, start, end;
> > +       int name_offset, ret;
> > +       unsigned int sym_number;
> >
> > -       ret =3D kallsyms_lookup_names(name, &start, &end);
> > -       if (ret)
> > +       name_offset =3D kallsyms_lookup_names(name, &sym_number);
> > +       if (name_offset < 0)
> >                 return 0;
> >
> > -       for (i =3D start; !ret && i <=3D end; i++) {
> > -               ret =3D fn(data, kallsyms_sym_address(get_symbol_seq(i)=
));
> > +       do {
> > +               ret =3D fn(data, get_name_address(name_offset >> 1));
> > +               if (ret)
> > +                       break;
> >                 cond_resched();
> > -       }
> > +               name_offset =3D get_symbol_name_offset(++sym_number);
> > +       } while (name_offset & 1);
> >
> >         return ret;
> >  }
> > diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
> > index 81a867dbe57d..11fb0de92ede 100644
> > --- a/kernel/kallsyms_internal.h
> > +++ b/kernel/kallsyms_internal.h
> > @@ -13,6 +13,11 @@ extern const char kallsyms_token_table[];
> >  extern const u16 kallsyms_token_index[];
> >
> >  extern const unsigned int kallsyms_markers[];
> > -extern const u8 kallsyms_seqs_of_names[];
> > +
> > +/* Although constant, size is volatile for better code generation. */
> > +extern struct {
> > +       volatile unsigned int size;     /* 24 or 32 */
> > +       unsigned char offs[];           /* int:24[] or int:32[] */
> > +} kallsyms_offs_of_names;
> >
> >  #endif // LINUX_KALLSYMS_INTERNAL_H_
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 74db751600b4..930ec27a53c0 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c
> > @@ -403,7 +403,7 @@ static void sort_symbols_by_name(void)
> >
> >  static void write_src(void)
> >  {
> > -       unsigned int i, k, len, off, seq;
> > +       unsigned int i, k, len, off, off_size, table_size;
> >         unsigned int best_idx[256];
> >         unsigned int *markers, markers_cnt;
> >         unsigned long bin_offset =3D 0;
> > @@ -453,7 +453,7 @@ static void write_src(void)
> >                 unsigned char len[2];
> >
> >                 se =3D table[i];
> > -               se->seq =3D i;
> > +               se->seq =3D off;
> >
> >                 /* The length must be less than that of the original sy=
mbol. */
> >                 if (!se->len || se->len > KSYM_NAME_LEN)
> > @@ -485,7 +485,7 @@ static void write_src(void)
> >                         if ((i & 0xFF) =3D=3D 0)
> >                                 markers[i >> 8] =3D off;
> >
> > -                       printf("\t.byte\t%u", len[0]);
> > +                       printf("\t/* n:%u */\t.byte\t%u", off, len[0]);
> >                         if (len_len =3D=3D 2)
> >                                 printf(",%u", len[1]);
> >
> > @@ -500,6 +500,7 @@ static void write_src(void)
> >                 memcpy(se->sym, buf, se_len + 1);
> >         }
> >         write_incbin(&bin_offset, off);
> > +       table_size =3D off;
> >         printf(".size kallsyms_names, . - kallsyms_names\n");
> >         printf("\n");
> >
> > @@ -560,7 +561,7 @@ static void write_src(void)
> >                                out_bin_file ? '\n' : '\t');
> >                 }
> >                 if (!out_bin_file)
> > -                       printf("/* %c %s */\n", table[i]->sym[0], table=
[i]->sym + 1);
> > +                       printf("/* n:%u %c %s */\n", table[i]->seq, tab=
le[i]->sym[0], table[i]->sym + 1);
> >         }
> >         printf(".size kallsyms_offsets, . - kallsyms_offsets\n");
> >         printf("\n");
> > @@ -570,23 +571,41 @@ static void write_src(void)
> >         sort_symbols_by_name();
> >         stamp("sort by name");
> >
> > -       output_label("kallsyms_seqs_of_names");
> > -       write_incbin_header("seq_of_names", &bin_offset);
> > +       off_size =3D table_size < (1u << 23) ? 24 : 32;
> > +       output_label("kallsyms_offs_of_names");
> > +       printf("\t.long\t%u\n", off_size);
> > +       write_incbin_header("offs_of_names", &bin_offset);
> >         for (i =3D 0; i < table_cnt; i++) {
> >                 se =3D table[i];
> > -               seq =3D se->seq;
> > +               off =3D se->seq << 1;
> > +               if (i && se->len =3D=3D table[i - 1]->len &&
> > +                   !memcmp(se->sym + 1, table[i - 1]->sym + 1, se->len=
 - 1))
> > +                       /* Mark that this is a duplicate of the previou=
s symbol */
> > +                       off |=3D 1;
> >                 if (out_bin_file) {
> > -                       unsigned int seq_be =3D htobe32(seq);
> > -                       fwrite((char *)&seq_be + 1, 1, 3, out_bin_file);
> > +                       unsigned int off_te =3D big_endian ? htobe32(of=
f) >> (32 - off_size): htole32(off);
> > +                       fwrite(&off_te, 1, off_size / 8 , out_bin_file);
> >                 } else {
> > -                       /* The three spaces before the tab line up the =
comments */
> > -                       printf("\t.byte\t%u,%u,%u   \t/* %8d %c %s */\n=
",
> > -                               seq >> 16, (seq >> 8) & 0xff, seq & 0xf=
f,
> > -                               seq, se->sym[0], se->sym + 1);
> > +                       if (off_size =3D=3D 32) {
> > +                               printf("\t.long\t%#4x", off);
> > +                       } else {
> > +                               if (big_endian)
> > +                                       off =3D __builtin_bswap32(off) =
>> 8;
> > +                               /* The trailing three spaces line up th=
e comments */
> > +                               printf("\t.byte\t%u,%u,%u   ",
> > +                                       off & 0xff, (off >> 8) & 0xff, =
off >> 16);
> > +                       }
> > +                       printf("\t/* n:%-8d %c %s */\n",
> > +                               se->seq, se->sym[0], se->sym + 1);
> >                 }
> >         }
> > -       write_incbin(&bin_offset, table_cnt * 3);
> > -       printf(".size kallsyms_seqs_of_names, . - kallsyms_seqs_of_name=
s\n");
> > +       write_incbin(&bin_offset, table_cnt * (off_size / 8));
> > +       /* Add a terminator without the 'duplicate' flag. */
> > +       if (off_size =3D=3D 24)
> > +               printf("\t.byte\t0,0,0\n");
> > +       else
> > +               printf("\t.long\t0\n");
> > +       printf(".size kallsyms_offs_of_names, . - kallsyms_offs_of_name=
s\n");
> >
> >         stamp("write name index");
> >
> > --
> > 2.39.5
> > =20

