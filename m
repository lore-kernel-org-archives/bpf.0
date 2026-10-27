Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793124628;
	b=mSsH31GwGTg9aF20e4u3vZPiPgoytsBaxavDt9laa/8eP/ljUwFLPJUSXH3WmZQ7MQ/A
	 M3/yrDJEzay1sBOhuTBVXpV7FA8+i9YDiKQ66Qa+xhtBn+CEuKENdQo2L0rmYPc55dECv
	 pg25UA+UNdzxi5Ht8PsJ/eUb1/pTRWE9v5UrJueXfbx+oy1/8V747YqYyGqK4eC+0hAr/
	 TXf5LdrKsPRkSjnzzKaOiaa56FGjmB4znAw5O6MLeFgUTxlk9SJxny4tMUpk5907zwLsu
	 y7xP5KhEgcrtJNT7C5fumqvXlHcDi7vr4usw6Tl4f9OfH/0bcmib8SSG6U91wNjm9SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Sisj5/eL+nGBHUCohdByG/h1gq77xLzGBW10ebKB8dY=;
	b=NSfg0eGRB+uDDKBP9GRUwcIyIui0IqSw4WWm16QO9/09hFN8Le3leoDKrb8H7dDMNjMw
	 gM7267AApt9Ww0hFwdohkNQ0oEyeDszbBhuC902/gy4aiBi8lQaB6Zr5F3ZmaZm+9KiBp
	 iPSBUdujJQrc9apeVphf/qlGCLKiCu0MzKXzQkVecnvoAH/CDMT/ps1U6Nxu3ryuVo1lO
	 N76Up2jrsF+8lexqd5yfYyA2MmRrQZvePZQ77ZQWlciIHtZZggFE9IjdnajcngNaWJXOa
	 OAgEXYhiQSh8BYsAvfxHw9+EFbNt4EapRw/N3brwZAnqrLu8pdKguTr9WVDVJehgPsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XdhgBtGM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67C606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C67C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XdhgBtGM
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso129084a91.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793124628; cv=none;
        d=google.com; s=arc-20260327;
        b=EffXn0+82FCjUlZJf0rMVOpYosIO3mUMlp5bKgar8rqFtbEocfwD1fapcZhmx9yokh
         ABFiqAfSRkxTz1BKTXwTQ9jUfragJfMdXFKWVnJMYi2QlHgC7FtRVr03mZu1QVO1BWSk
         ZEEEmYAQVdduPd7ZUzZoTjzUqFjhUVoz5eUxeVy5qDjZNPyDq5ovpu0V3eVU1cSGTvH8
         S3PQNg/zkfN24QmBx892/c1+uNyvufOei2R8auHNMbCoJw8yykWILFWti2C9HpwzNDY6
         BUQ/fqxub90VJg16GAdYE7YNtpMoQrgUAqwQhM6wkp2Mk7tteIKf6ZZ74VjHjTjRJh6L
         RXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sisj5/eL+nGBHUCohdByG/h1gq77xLzGBW10ebKB8dY=;
        fh=7AGZjrfEc6P7+0qA34kgohdKDDyTNtjaUX4OqAFBUnk=;
        b=dloZR+IKip76ABXfMt02b+47VKCciiDTptptRNKm3br4jo+dk9sGQ9Le9RB8Vf6kKI
         GIJaQ4khw22xR2KEhiSK63/sbf95ap9EATrZ3VtadEu8lvIhmkcAq0XXm5XT+ytZubl3
         Q5pAnmc+NQt1/CtgjRxzQyTTPN7+6fojawNtpoptRehnoFjOAJ/lBtPHqqsGsPQcFSC9
         Lso6BfFup1DtC4vl6MEAcE/ynSrRRFsgN4JSGEp3hWKsVIIe+fH+uNbb5JmwYD9qJ8kr
         e/rk90XL6DO1QKJ3DdA/Go1LDe/XvdzE0ynyZRN83qAB4Jqutzm4yj3paTh4WEk2YZDK
         +4wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793124628; x=1793729428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sisj5/eL+nGBHUCohdByG/h1gq77xLzGBW10ebKB8dY=;
        b=XdhgBtGMhiBggE+DVyTdqGsKW7fQfC1gtjDcv9ssvTTnslzgFg667jAHy3uKJ9Os7l
         7Z531ctX7aqcq3AIvKUD9taaMcChtkOHEa3W9zJg1lKNcwSUYBJ03YmPPvx2RprwxbpK
         fc39DPDpnOvi8GXMSC16N2q//ZZXVG+w7muK/vBDL98SniaI91mkcQBdYFMWQe/CCldY
         WqlHwuBo2jn2aTBmjpS0mo8aeylYMftBcSCsNCqaxAp0Hks9sHqy0poj1ZbbQn/36h8b
         LyuV4wdixzq0Mfvn3IYe2cj4k7TTZOseiGV+iLigHPEWCcj/Ro2kdVJ7qgYFQ1nGiKNW
         hT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124628; x=1793729428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sisj5/eL+nGBHUCohdByG/h1gq77xLzGBW10ebKB8dY=;
        b=nSlwvlknV0eoC3E5Hiw7BZDUs/Ri+HA+QVZENdGW2MKpVa9KN1676JzTyk4WWSV//C
         GoZl9ZKYcG7y21B08ht12mW+j/ZBfwpXt/lRSzkkHwF1NLnevPfA9gaC4XbmmlMdkmR1
         mH4h7YcXumA4TELc2wTaIYeJCaaq8DJAMPrsa/+q/pUcDLVK5ScNQOB2IGKofiRTbvvc
         LJ3zh6nV3YgKDePOERZc+RX0ZF7/wTOaryxeWPw5IkbHC67P0GwoThc2HKmp9l5chKx3
         fz9p9aBD7k5AvAFQFRloyy/D8WcxRGHBdV5tccS1rrSrTBPeqx3DWexd+jBTk3j3uQFL
         hQRw==
X-Forwarded-Encrypted: i=1; AKwUvBxPKpZWeLhT4agop13g6HKfSlqoKrGKKkrfI+ByOJY48CqILO6ivA6YQulEWaxhBibXje4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbTHAlHP/Jmcx3AED1Jrjxag0y/UQ2Rbb5EJWHAsb/7BPtd5hw
	OfxyK2CSIkwd5D09JgiBQhPWZYR9w+DyVkgBOAqtTh/LnwqKgtZRxIAXzLBGdbrv1oaroMwQ/jV
	GWlsaLOm4n3MCoxRbog9McNYTIvWuKpmDCfIO
X-Gm-Gg: AYBFou2W1L/ytjCNAQshmeHDnyA1Xl/ZbdkNBAuGbgOgWNm2tW1X2OJafz8MZAOLrQ0
	7UZMGG/RTygkdDkUuuBBEKtnR6dpjCJIn6ubiqQg5/7+L2USOs4vjc93ZCXat/OJ6u7tMLzZYZh
	eTSKcFrT41kmtwveCjz4qi/HKm4DzmAo+oEcUwLgYNUX+O3lVZD64OkAB9cUzFxSkNBh6EuE37f
	Xp+spQIZDoa4b2W/A5tw8kkoz9dPxmtfbCOEvGjiyPkIgj/cfIYa1eCgDFHsCvnafHGySJTMDI6
	zsb7iZW0hvgLgvdPKZDDUMTHd8g0PRQyz6YrfUcDxgixgCtUK18KLZuMjeQLmY0EnntASVzx0Id
	WrRXbW630TPrnUrpbv2N+LovDPA6TGHWe+DzUyrfHgfAXbIKcOZqWL5W6B0uNmsE8tzhp89fGav
	Op9WXlzAgOr0FmbqgoQ53PmZoYFQJwHxVSjQ==
X-Received: by 2002:a17:90b:1c8b:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3adea8966a7mr8243781a91.18.1793124627674; Tue, 27 Oct 2026
 11:10:27 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
 <20261023222652.3927736-5-ihor.solodrai@linux.dev> <CAEf4Bza2KV8ZbV2eeGyNabErZ43gY+md4WP6N7XPVL0_dw-mAA@mail.gmail.com>
In-Reply-To: <CAEf4Bza2KV8ZbV2eeGyNabErZ43gY+md4WP6N7XPVL0_dw-mAA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Oct 2026 11:10:12 -0700
X-Gm-Features: AclHuK-pRRYatyGrNLs39VoJyoRGauWkcPfPcUV_q73km1GHgRx8Q266-DlWdRI
Message-ID: <CAEf4BzYQxvhJdPqV8DNATdCqjEHtiHPHjSD7UDR6GZRg=wKQ5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/8] bpftool: Skip __bpf_relocatable on
 verifier-rewritten context types
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	David Faust <david.faust@oracle.com>, Ian Rogers <irogers@google.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Vineet Gupta <vineet.gupta@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:06=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 23, 2026 at 3:27=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linu=
x.dev> wrote:
> >
> > The verifier translates accesses to UAPI context and socket types,
> > such as __sk_buff and bpf_sock, into accesses to kernel structures.
> > It picks the kernel field by the instruction's offset and keeps the
> > base register. For example, in bpf_convert_ctx_access() [1]:
> >
> >         switch (si->off) {
> >         ...
> >         case offsetof(struct __sk_buff, mark):
> >                 ...
> >                 *insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg=
,
> >                                       bpf_target_off(struct sk_buff, ma=
rk,
> >                                                      4, target_size));
> >
> > So these accesses require a load or store with an immediate offset
> > from an unmodified pointer. Their UAPI field offsets are fixed, so
> > CO-RE relocation is unnecessary. With preserve_access_index, the
> > compiler can instead emit pointer arithmetic, for example
> > for ((u8 *)&skb->mark)[1].  The verifier then rejects an otherwise
> > valid program.
> >
> > Omit the attribute from the 13 such types when dumping C. Also omit it
> > from their nested anonymous records: keeping it there can root
> > relocations at an unnamed type, which libbpf cannot resolve.
> >
> > The last addition to this set was bpf_sk_lookup, introduced in 2020 by
> > commit e9ddbb7707ff ("bpf: Introduce SK_LOOKUP program type with a
> > dedicated attach point"). Keep the set hardcoded in bpftool so the
> > exclusion also works with older kernels.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/net/core/filter.c?h=3Dv7.2#n9939
> >
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > ---
> >  tools/bpf/bpftool/btf.c | 84 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 82 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > index 5a2c5341b736..5c88f665e6b9 100644
> > --- a/tools/bpf/bpftool/btf.c
> > +++ b/tools/bpf/bpftool/btf.c
> > @@ -6,6 +6,7 @@
> >  #endif
> >  #include <errno.h>
> >  #include <fcntl.h>
> > +#include <linux/bitmap.h>
> >  #include <linux/err.h>
> >  #include <stdbool.h>
> >  #include <stdio.h>
> > @@ -1092,22 +1093,101 @@ static struct sort_datum *sort_btf_c(const str=
uct btf *btf)
> >         return datums;
> >  }
> >
> > +/*
> > + * The verifier translates field accesses of some types into accesses
> > + * to kernel structures, see bpf_convert_ctx_accesses().
> > + * The translation keys on the immediate offset of each load or store,
> > + * so offsets into these types must stay immediates.
> > + */
> > +static const char * const btf_c_static_offset_types[] =3D {
> > +       "__sk_buff",
> > +       "bpf_perf_event_data",
> > +       "bpf_sk_lookup",
> > +       "bpf_sock",
> > +       "bpf_sock_addr",
> > +       "bpf_sock_ops",
> > +       "bpf_sockopt",
> > +       "bpf_sysctl",
> > +       "bpf_tcp_sock",
> > +       "bpf_xdp_sock",
> > +       "sk_msg_md",
> > +       "sk_reuseport_md",
> > +       "xdp_md",
> > +};
> > +
> > +static bool btf_c_needs_static_offset(const struct btf *btf, const str=
uct btf_type *t)
> > +{
> > +       const char *name;
> > +       size_t i;
> > +
> > +       if (!btf_is_struct(t))
> > +               return false;
> > +
> > +       name =3D btf__name_by_offset(btf, t->name_off);
> > +       for (i =3D 0; i < ARRAY_SIZE(btf_c_static_offset_types); i++) {
> > +               if (!strcmp(name, btf_c_static_offset_types[i]))
> > +                       return true;
> > +       }
> > +       return false;
> > +}
> > +
> > +/*
> > + * Anonymous records within types that need static offsets must not st=
art
> > + * CO-RE access chains. Named records, typedefs and pointer targets ar=
e
> > + * separate types.
> > + */
> > +static void btf_c_mark_no_pai(const struct btf *btf, __u32 id, unsigne=
d long *no_pai)
>
> mark_static_offset to keep terminology consistent?

ah, this is a bit different from static offset, it's nested anon types
within static offset... hmm, then maybe "non_relocatable"? "pai" is
quite unconventional abbreviation, I keep reminding myself that it's
preserve access index

>
> > +{
> > +       const struct btf_type *t =3D btf__type_by_id(btf, id);
> > +       const struct btf_member *m =3D btf_members(t);
> > +       __u32 i;
> > +
> > +       __set_bit(id, no_pai);
> > +       for (i =3D 0; i < btf_vlen(t); i++, m++) {
> > +               const struct btf_type *mt;
> > +               __u32 mid =3D m->type;
> > +
> > +               mt =3D btf__type_by_id(btf, mid);
> > +               while (btf_is_array(mt) || btf_is_mod(mt)) {
> > +                       mid =3D btf_is_array(mt) ? btf_array(mt)->type =
: mt->type;
> > +                       mt =3D btf__type_by_id(btf, mid);
> > +               }
> > +               if (btf_is_composite(mt) && !mt->name_off && !test_bit(=
mid, no_pai))
> > +                       btf_c_mark_no_pai(btf, mid, no_pai);
> > +       }
> > +}
> > +
> >  static int btf_c_annotate_records(struct btf *btf)
> >  {
> >         __u32 i, cnt =3D btf__type_cnt(btf);
> > +       unsigned long *no_pai;
> >         int err;
> >
> > +       no_pai =3D bitmap_zalloc(cnt);
>
> this will cause problems for github mirror that won't have access to
> linux-internal include/linux/bitmap.h, I'd just open-code a simple
> bitmap or use bool array for simplicity, memory usage increase doesn't
> really matter here
>
> > +       if (!no_pai)
> > +               return -ENOMEM;
> > +
> > +       for (i =3D 1; i < cnt; i++) {
> > +               if (btf_c_needs_static_offset(btf, btf__type_by_id(btf,=
 i)))
> > +                       btf_c_mark_no_pai(btf, i, no_pai);
> > +       }
> > +
> >         for (i =3D 1; i < cnt; i++) {
> >                 const struct btf_type *t =3D btf__type_by_id(btf, i);
> >
> >                 if (!btf_is_composite(t))
> >                         continue;
> > +               if (test_bit(i, no_pai))
> > +                       continue;
> >                 err =3D btf__add_decl_attr(btf, "__bpf_relocatable", i,=
 -1);
> >                 if (err < 0)
> > -                       return err;
> > +                       goto out;
> >         }
> >
> > -       return 0;
> > +       err =3D 0;
> > +out:
> > +       bitmap_free(no_pai);
> > +       return err;
> >  }
> >
> >  static int dump_btf_c(struct btf *btf,
> > --
> > 2.56.0
> >
