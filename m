Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794396330;
	b=mC8JLQH0gg/i4olCjHCaBuuOdBmXu9YbjV8o2Dz/KQYxZFGsRWFVD5a+sts2X5lY7YMl
	 ZgKrAtLcAfikw09zHvqaLl3NO42lqK5YV0+hwYjQlcm2Hlxko/379BIqKEtXK9CS0NPL2
	 JCRxZF29wf3Ve7PPvKxeZJ8i4Bu7ETxmKdLvLNzl52H6YmvRl0VWGFE2oLmk6wf/9koiv
	 LoTreIg8i8MapQ+z/ubLumpr/4ddU5ntR4KCIEbbqhnOYjSKDB+p4HZNo64x3P6gXnm26
	 S//5dnVzUq/MANDzDqYZJ5Z8WKMtYtuRg9frcQswu1BnCNO/AEHOefrxcMo1ANpsyFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RQM3vRQ/k65hcNzWHMMmTbRmdgaygzzzb4KWlaKkg/4=;
	b=3Cn6uynemW1dQXv856PcNU4Wrh9vVbA3UB+gBXzU8Lae59YSSwBBg3YUBNlIXMHYcgty
	 hjiViVrPWxKuYtaGuZKY8WOOruh8gkkug+ng4O10GyBbIWFyEeIVL2SO6yOg7l6lzetcW
	 hd53LfphHyGJxMJyKV3oWsCGCulmM19EVA8UGQoVB+HSRaCpkLOgfN6k15y9DL5kdkLj5
	 VrRv9pNPcdEarsPawmNj6Nq5kUQRdShQWWoiDeRlbboXleGND7/xx94PV9gOBdlLUXUwH
	 /D0iSGpAM+7c9OdfrH7f1WwkuY0rw/Gv/RyXzDYX/vLPx23kYVvqezv/m/Tsva/YJWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iYNPu4/Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE1606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 11:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16AE1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iYNPu4/Y
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso4403921c88.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:25:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794396329; cv=none;
        d=google.com; s=arc-20260327;
        b=iflf02v2AFFUWcCotlGjK4GwuxvZ+Zdl6imSPDdcCF0t2pKdkdslfC+SJsMktcN00D
         yltlTwjI4e7EeWM1FgNeUxsXNRDxYhygkY2cTaIydYDpNlI2Pqx8VqS85khkCAhc50ES
         MfiVn26ZBFhHuBYL+DQhS0pfeKfnCTDs3LBcDAGh00fcPgnTKVcglMkhgk/PO1WOE2at
         5lxRVtW/d7CoiBZDHIauRIZMMgM7um10sbkGUlOAsuP0S0k9cJMWyeyLi3oA6tpR0Cn8
         gW24j2gp5rpZ7QP7bisOJClREmO1ibNq+oqhGZz64fdEOeGzPbKR2SufffiTu8COFn5X
         zS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RQM3vRQ/k65hcNzWHMMmTbRmdgaygzzzb4KWlaKkg/4=;
        fh=iSXAkhtEQcGnpv2sKCdGUcM/4W2HvNX/Uomqz8JwNJo=;
        b=SkJ3qFhWuNWdX+0CqX+XfJakIzrFTKUdxVnQXaJBRxR0BS9X2NLjTTTARcxb1rnqXd
         4XzOvPyF8GckJErYKNE9TiT3/PrIGEsMgJ9iu9dqTGe1CJHLCcp1aMgvFUMx+Vg+2GFw
         kn8EDW32D9XYh1C/IrhqjfyoPjvJbdJwBR5baEClOyXLBGM4Z/GtQ2ymZIpKhhyp01Nr
         MzHWClQtIpLIZQ09aSFxaI131SueWDZrBmb75R1VtaMgdqkjtWCbxygA7rEpqosyUcyg
         C7R0yghtkc6n+XRmA84EdVlVJ/8MbGkDqIEiFkQFtzbrb2axy36t+bv05y0owCVpP+6h
         /1+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794396329; x=1795001129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RQM3vRQ/k65hcNzWHMMmTbRmdgaygzzzb4KWlaKkg/4=;
        b=iYNPu4/Y3UATDiZVcfYc1q1iLPT7HEFEtYe/u4rgmkeYtcmcNLnVbvlPMWYc3KXGm/
         eYbr+duIAENzCVxdCUBdTLa3NX6BZhGg5TukCoQAdw4K6BBTfomJeJLvBAtkio5Uyomc
         7BpCNo/SqlqOAbUTHEm9JkJJGAcYcN7y0VcFDRYx0Yls7BMhs3wqbAdn4VZrGNaKNY9r
         GPyfHyv0YlIZFwNtxGcW7z6ORzhWRhIPiAX2cdzuQS6uv0+TnAYxe0YXZaCG0chFZi7o
         k0rbCj8tkKXaY2ywljkvK27BpCJha2zLyWSCpt0/gXtLSI61cd0Daqt/+7AZIkwH0Qer
         rnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794396329; x=1795001129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQM3vRQ/k65hcNzWHMMmTbRmdgaygzzzb4KWlaKkg/4=;
        b=ywUxKbCHyEFRzVAminB7GnjfRgiSQYuhiP5ya1RKJ8oI9K2Hka4w8iyxnUBF22T0q7
         ffH9gQCk4FtYPD9Lg8S4iBcDLvCk5iQnqqRQsKnsBGRquvAn7PqKDgckw7Zq+Fd7k4vN
         QUnda1TIlCMhxRQUBtXdWla6OlKhaN5E50UShHrjk3ygs4bFePJdoHiyrOGNEk3K+EVi
         AO/yHOfFkbSyztbNLCiMy4r7HxjOyrs85tflnHHhAdQp/WsToestxczslN1mmtTGTTvo
         3SSXlZODBaBfNurUlyfR6RdnRfwoPgxuHA4npwJMQJKS8A9dkSaVT29Q0yUxOcVmFO13
         VIAA==
X-Forwarded-Encrypted: i=1; AL+hErFM4AUAU6bHfsDzoeHDSlYUruICu15kMyy7HrTza8SxK4E5pfrju+eyEo/rB0Ws52odZBw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WOk6Ku3YqwwoP1SSm3WUfaWdQGYzuMeK47HCPK3oHkblLfluG
	uMhkiRzZ5zQLBLK/+zekiVtd4S0oOzJUdFmoo3q067b2Miuf/Hxfc38cpkoFf6d0m7MMbW1g4EN
	VVxEnQ8Nvqtf7h9ktvG3XA+7FG/CBYAc=
X-Gm-Gg: AYBFou3JBq1eYGGqXicQIW2lbfk82X5QwD5xAPOZ4KvOvTVQqM8wBea8DXRlEIPdyu8
	M91eiKRGQKBxg9OlXGlKCFMs2LbkZaBrOahY2jt+cDgGgCPSr3WoGsXPqqtrFlhbjTtPOdpJ63P
	eUMaOVtTRcaYQD88JOKB/WCt8Y7A2CpXXPV/mkWykQnAZT5iC9YRkMyeKKiWP86ozMg3psgRPqB
	tMDKzbG2ryWzUPp1pzB2w5ndog2ThHcwVUV5NpkhpqsYeRhMAmSNVMl1RUX0Y5/Fm/zUn96zh8i
	ljQeFc7o+KSH0AgUnaMRzIQ81dmhx9LkYgzGcTMPAoMOevm7oYbFfMdGLlC6la30OR2vuErv+zN
	dL3qJfnobL0jD3XQ7hXOERy+bCfnG/XaCN+aWsQ==
X-Received: by 2002:a05:701b:4583:10b0:1a6:4679:6cf4 with SMTP id
 a92af1059eb24-1b3c034aac5mr1833398c88.36.1794396329056; Wed, 11 Nov 2026
 03:25:29 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110164046.454431-16-a.s.protopopov@gmail.com> <f0cac3d0039b840d9e1cab4dffbff15923f87115dda70351043219df57fbd4d8@mail.kernel.org>
In-Reply-To: <f0cac3d0039b840d9e1cab4dffbff15923f87115dda70351043219df57fbd4d8@mail.kernel.org>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 11 Nov 2026 12:25:16 +0100
X-Gm-Features: AclHuK-c_MqedBoRZ4SvekPJBUyZVgQfnPd-lx4-godoXQbKoO4ZRLhpAZaTYE8
Message-ID: <CAGn_ityTsSTiHjh6Mm8QfrhWWoUqm4SiCRYuJdHVwp+dZxk9Uw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 15/18] resolve_btfids: Tag fmod_ret candidates
 as targets
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, almagui@kernel.org, john.fastabend@gmail.com, 
	qmo@kernel.org, brauner@kernel.org, kpsingh@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, sashal@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 9:21=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > resolve_btfids: Tag fmod_ret candidates as targets
>
> TL;DR: Nits only in resolve_btfids fmodret.c: the second branch in
> relocation_offset() looks unreachable or wrong, and record field offsets =
are
> hardcoded in three functions. No functional bugs reported.

yes to both nits, will fix

> > diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btf=
ids/fmodret.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/tools/bpf/resolve_btfids/fmodret.c
>
> [ ... ]
>
> > +static bool relocation_offset(const GElf_Shdr *target, GElf_Addr offse=
t,
> > +                           size_t width, size_t *result)
> > +{
> > +     if (target->sh_size < width)
> > +             return false;
> > +     if (offset >=3D target->sh_addr &&
> > +         offset - target->sh_addr <=3D target->sh_size - width) {
> > +             *result =3D offset - target->sh_addr;
> > +             return true;
> > +     }
> > +     /* ET_REL relocation offsets are relative to their target section=
. */
> > +     if (offset <=3D target->sh_size - width) {
> > +             *result =3D offset;
> > +             return true;
> > +     }
> > +     return false;
> > +}
>
> this isn't a bug, but when is the second branch in relocation_offset() ta=
ken?
>
> For the module sections that use this helper, sh_addr is 0, so the first
> test already returns the section-relative offset, and with sh_addr =3D=3D=
 0 the
> second condition cannot be true once the first has failed.
>
> The second branch is reached only when sh_addr !=3D 0 and offset < sh_add=
r,
> which would be a linked image whose r_offset lies below the target sectio=
n.
> Treating that address as a section offset would be wrong there.
>
> Would it be clearer to pick the interpretation from e_type, or to drop th=
e
> fallback?
>
> [ ... ]
>
> > +static char *format_values(const unsigned char *buf, size_t offset, si=
ze_t ptr_size,
> > +                        unsigned int encoding)
> > +{
> > +     unsigned int nr =3D read_elf_value(buf + offset + 16 + ptr_size, =
4, encoding);
> > +     const unsigned char *p =3D buf + offset + FMODRET_META_HEADER_SIZ=
E(ptr_size);
>
> [ ... ]
>
> > +static int choose_functions(struct elf_function_list *functions, const=
 struct btf *btf,
>
> [ ... ]
>
> > +             if (!read_elf_value(buf + record + 16 + ptr_size, 4, enco=
ding))
> > +                     continue;
> > +             stats->with_values++;
> > +             flags =3D read_elf_value(buf + record + 12, 4, encoding);
>
> this isn't a bug, but the record field offsets (flags at 12, nr_values at
> 16 + ptr_size) are written out by hand in parse_records(), format_values(=
)
> and choose_functions().  parse_records() has already decoded flags and
> nr_values, and the other two decode them again from the raw buffer at the
> same offsets.
>
> fmodret_metadata.h has macros for the magic, the version and the header
> size, but none for the field offsets.
>
> Would it be simpler to put the offsets in fmodret_metadata.h, or to have =
a
> small helper return flags and nr_values for a record, so that the three
> functions do not each repeat 12 and 16 + ptr_size?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/429818=
85558
