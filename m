Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A5384CC6
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791017240; cv=pass; b=dxWZFl0Nj6/qnnsylVnzf5cua73n0lwjlcEWjSqy5Ginwhu9NZeinRUuHb9scNiSSiK/2S1cVJeS2H2YIF/5KqaT9N8P5RaQF2sQcbrl1TwZHq8fmTi+gje63K91R68MuEB4/dcaZ6/nkIlcTfopSH36z3IQibW7fTS47GfUq1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791017240; c=relaxed/simple;
	bh=YJbrX/vCmT/nwmhXiLhT4JJHkhYun1n5JE/xPnZef88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvLwh9nShmoMvGlJPbjUIIZ+eSuRNbSjN306lrJbEdq2VqbDT2WoDse0J7IrCXAKJVxOsyOAuX3dEdmImYE/rFbxqujqhWXhEmMgNIn1dyclWvmH1mtmiuyt74328l+fCR024wi5iYtnm8+CPt7dTGVoxYStwp3ClqTIf8FNsNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XHRe7h52; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHRe7h52"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a021c28046so14905e9.1
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 01:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791017237; cv=none;
        d=google.com; s=arc-20260327;
        b=eqSfELmtUn7TRs+4vFe5n/dVOMmQrc4urtSA/FFhhF/ou+p5hxFx+J9BeF6R5XHKmy
         DqoJGakZTRcrz3E3M3MMcVCuM9Frzbxirs3WP7I444RRQK6rIH0tbZEnjc0ZvAJFWLJ7
         c1FIqQ5agLYN+/+ykFK2ipTnQGi5F+fprlhMtU3KZKzBqhdiCZKROYwNxjdiQTkRWXgO
         tvkdpboacOKY2q9QOArubVj3HOGkuFLVzplKj2BLgkZYykiZ9FF2yEVamuX9o/E2/EuX
         vFwTonQviDXra6Re4yy7Rgrv9bPo9rOTXceS5djRTud7nECyXw2/JWxjtusUpk7F1Ble
         1IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=746wAMHewz8f00PoFb79OM9/H7YkTkpGxvh84Ci27zs=;
        fh=AFEG9SRlPqqPyf3qc7v1WYf/l8+dIiwYoa4FFXldj3Q=;
        b=llH5gXg0cfX4AxIpx4TvJTc3NojOxq5pOU/VLU8ksy89w0+5vyWwckIVjDjyrJMN7/
         3v/M8iWrbO3JE1CuuHsZtHPi0DmyIlNBLLY3gj9STwSS0R3uFw6pB6jynwN6LmwlHAWM
         wVVM7ingDhWUeDlSRZGmjjAbBbi8e1zEMrG8cPDYRNacT+Aeb/+adcQUJ/gow/1otMf7
         Nfm8IWoBHaGPiAA2ujQB/GETqwVi5WasBsS5r1cb+aSLHDN7hVIlf9RISUFpmvN2QMTd
         gIrdJGdHWvuYFa2EV8sALpBfFdoqJfGMlQHdhKuaaDOMZ1YKQDGyu/D2kWsEdY22/I0P
         eBCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791017237; x=1791622037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=746wAMHewz8f00PoFb79OM9/H7YkTkpGxvh84Ci27zs=;
        b=XHRe7h52u3QvNH0Fji7iedsXclVdBdL4DwVOrcJIMNVQxKUGCs+46B7M7/VF9FHwN1
         Qb3qQxkhl3WzA1l10wjjhgj9/7D7bP2qdmCJ5CEU55wJ2Pr3Z24ICEa5eFBkXx0uRCwk
         M2HAhM6RMPqcRNTL5PrrgWWf6AVzfQjJJNGFN03BE4tvKmE63PK3CLtyhGi3Xlt8/JDS
         OeJYi3VfEs9daN+lLCGXoOo7fRYJy5LM5Tt7mLAp995uJcKjkN0QFL9xp73So5rG6q75
         qLF2COgv6nFni1/4Y4khP/Tu5Plu38KDTavTYFFEvqUN/1sACipaRu4TpcfCP2pkUGVT
         wXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791017237; x=1791622037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=746wAMHewz8f00PoFb79OM9/H7YkTkpGxvh84Ci27zs=;
        b=22ctM8Jiguzyj9jd4QpLXUjB/023BCq91A+BtXkv+xHgftqToYeFI+wbjLA5FSwbAN
         x6sGwkeiEC1jyBFeIRsTONwYXcOmstPk4C64wTYlpksv32iJs7uA55m1oqJBXvpTiVzq
         ytw8FSOwARacoEeNKZ6gx358g9tcX9nBzxxnvVF5TopZMUOnEtj/QhsKITQAsuJ0m/Tx
         T0/3nkA/N66cZ+mEgV5smYf/fl6bteAx+OOo6IFyPJo16oh7mo7B8TKyifl3jy++21vs
         RJRyjeAZJFu1d/cfqKf7Y71J3qqPXoCeFlrPSgQO9agQSlvq4CMckutAVKB6lLpLb0HM
         fu+g==
X-Forwarded-Encrypted: i=1; AKwUvBylB3xkAjjtIM/A42z3/kTHQxLM0FvwGnbS34ZvXsJBrGKB79pRE4S8yjNA0OvJa8Bt1jU=@vger.kernel.org
X-Gm-Message-State: AFuF++kthRUvggM9QX2o9wz9Uij3RDPvW09/h/wnVhfe0Detk0uJBG3h
	zLz5guwNw96ti4vp6eHjlKEZWE2pOXKol/be+ub98CD3vMzMWiRapAQldU+By2JXCyDYywzOJWM
	Gu0ghM/O/URJgfzmIuSjubhD+8CkBk2vw3LxSg35WERx1qhP4/EGazUCuOOJv4g==
X-Gm-Gg: AYBFou2PvxGYJxdC6Zw3of+JggGnHuavh4vnYID+8nnyZXSIcj0tlJGxFUutGBBfnG6
	uwZto21NzjTsVUDHFo4uNJ+F0p4lGweKs2rjV+d1Wh9FpkTsPBMlzYANGPxee74Nf+QHCT97Klv
	817b5M151A39+3Mt+41iEz+rLveKaMTL+6RlAz5pq+q5dGXHZj0m8NJDqFcmu3+c90OaUOl6Ivs
	bm2d7GolZ4fHRvQD/T7221RtK2Ml9aQiVXhaqL454DMnFVyNcw9gWbz4k2ot4zHemycRJfcc+MM
	yWa6Doj56VaJsnYpx3onOoIVZnLy7hUcHgGDXUSnpf1sXe1v+rd+CnAztdT+Jn5fxW0wZEoD2Se
	7142Kng0GcneAZfcT34/Kcr6VDg==
X-Received: by 2002:a05:600d:848e:20b0:4a0:2229:528 with SMTP id
 5b1f17b1804b1-4a168152435mr459295e9.1.1791017236930; Sat, 03 Oct 2026
 01:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002161738.621133-1-tjmercier@google.com> <20261002161738.621133-3-tjmercier@google.com>
 <DLUZYDAX6849.KKV543CJGGXH@gmail.com>
In-Reply-To: <DLUZYDAX6849.KKV543CJGGXH@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Sat, 3 Oct 2026 10:47:05 +0200
X-Gm-Features: AclHuK9JTcv24SfY-wF9YmNxhuGB1AXVuzqe7ziF79FmPpxWTB2IuNVQPvrhG4w
Message-ID: <CABdmKX0XN5Lapej9osNc4sOGGO3Hz7_tQjxxj-CfittTUOZMmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 8:41=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 02, 2026 at 09:17 AM T.J. Mercier <tjmercier@google.com> wrot=
e:
> > +static __always_inline struct htab_elem *
> > +__lookup_elem_raw(struct bpf_htab *htab, struct hlist_nulls_head *head=
,
> > +               u32 hash, void *key, u32 key_size,
> > +               struct hlist_nulls_node **out_n)
> >  {
> >       struct hlist_nulls_node *n;
> >       struct htab_elem *l;
> >
> > -     hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> > -             if (l->hash =3D=3D hash && !memcmp(&l->key, key, key_size=
))
> > -                     return l;
> > +     if (htab_has_hash(htab)) {
>
> [...]
>
> > +             unsigned long k =3D 0;
> > +
> > +             memcpy(&k, key, key_size);
>
> My bot is saying that this will break 32-bit builds with FORTIFY_SOURCE.
> __htab_map_lookup_elem_u64() inlines all of it with key_size =3D=3D 8.
> has_hash is a run-time load, so the compiler has to keep this branch
> and it's a memcpy of 8 bytes into 4 byte 'k'.
> fortify_memcpy_chk() will hit __write_overflow_field().
> That's a build error in i386 and arm allmodconfig.

I see the build error on 32bit with FORTIFY_SOURCE.

> has_hash is a compile time constant in __htab_map_lookup_elem_u32()
> and _u64(), just like key_size.
> Only htab_map_gen_lookup() emits them, so the map is BPF_MAP_TYPE_HASH,
> never LRU.
> Don't read it from htab in these two.

Ok, sizeof(u32) > sizeof(unsigned long) like in htab_map_alloc()
should do the trick for those two call sites.

Thanks,
T.J.
