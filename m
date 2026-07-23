Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD95534A79D
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827679; cv=pass; b=apW4FHhDHN9BFjcvXkfakTx2Ww0hEzYxihteoj7ZQLxuxHxnFC9R3rn0hexrT/mvfzgvJeXlUYoevLljg6j7EsJX2ggazIq0Ik1OqRDke/zXSefo17xKukw/oik+E15ObAQsvJntim9O/d3g4g1Wcz2q3u3EpbQwDwgXxghuYig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827679; c=relaxed/simple;
	bh=E7YQDCbA984EEVU5isysNrDStCf3ilkHH7jHKz9bIt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOVFKwqclQvcrrPbAiI6EBi/FbPG6Ct1skoYnOYqBRcNKUOUmYQZxq1ZE7ciofmWdH1pem1uUELtrmApYBrXFfe4WUgIMO/xdyuVjhK+2pArKMsu7s2WuwzybhscTMCqGWzwC1tSNn5WYv/6rm9DD55zipskUE9r1SSLzmZW3Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDtF1itc; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDtF1itc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-495509b08ebso1405e9.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 10:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784827671; cv=none;
        d=google.com; s=arc-20260327;
        b=Fn93dO9KIM/ViTHtAda3Z1P/J3gj9u/HUAueOCfan8HxGxh/o5riIkcuh3YAj5vv0a
         Qhio2wmF2UsoUKW5zg9jToQtObYfBWQMM1GxqL64JtbDCHMGNjmlk6vpPCbbPRmi91GI
         uorns6rT9LqxZxJKAyhPy4ieshKGh3n3VsDmuB7CZQ0pOaZMci7Bv/SLs75iuY/aXKmy
         Q/+Vv4Aax4Fvd/PB7xOY+3XuSTcWpWZ8uPzlLLrT991IcbB+IYVfW6ZLpNeSE4tOAmP+
         TsKKK+rKtmSk+TkMjiXQQLc9uxgf/gf8Q00QYI9zg2hQe/MPaAYVapvl7kY1s1Uj8hf0
         7K+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iz/Yj4mobHBZwFAbDfJyEzhBy9+HpOVqCdkWu8wEP5M=;
        fh=YToQLGyvYUY8EOhq27W16zzaUFD4tI7qS5OrzrzrDac=;
        b=TbDM3rrgF1tWD/DDA9xdXyY50lgpHoSaM9rYmQkHt9Sk6hL42zQ50Ueu3D7jJjUGF5
         2XMYaxY/4v9mjs8Xh/2LkuHFDkHn1KnczT1TpPjGzo+2YaUBQh8BLJp4oru6jUNaRBr0
         dBDXJzqsfJe2OJh6r6+E4mwqe41s+8FcebN22wM4JQuPQDR5f3ueBHqheinEYmhSVRnz
         suftnOADnP18UhyolA9Uou5F9fDdvAjec8OPNDp0kyD6CcZ5v2HObNcAfh1GOBbKvB2+
         iC//A5wsawCPx4TVeCcaXtJBHKWr1VuY7171m7JntXzQTuaNuA+zMJGL1JMFH3cNGMv8
         sdew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784827671; x=1785432471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iz/Yj4mobHBZwFAbDfJyEzhBy9+HpOVqCdkWu8wEP5M=;
        b=dDtF1itcalu+nGqrf+G15V5AaI8U5XeaknXCayIIUPO4HtDWy6jWSlEHI60ebd95N4
         31uvWPGVD8Chm86ji2pl+TJSuJODNKr11ckIViyfFyh6kveoraPYzvjrNJWQd3GRVd22
         aKIuLb4w98jDau2b2PGL10Clx2PIPApNVbBStWCl28KXbynqCvmOXF0gv+PKdy60CUME
         K4/7QrAXlY3BrQyk25PG6jVKEGgCkKg83P1cYtEtgx5dTumw3iJ+WD3NIHG9axfadrEV
         yRHQcD/xwyAjYViwqkDzRatoEquRGJYDlDTLMM6bAkXBb92rJRl9YC1Nl/MWqT/VUef4
         dftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827671; x=1785432471;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iz/Yj4mobHBZwFAbDfJyEzhBy9+HpOVqCdkWu8wEP5M=;
        b=oYsz76heVDmbAIo83L+V/1MFvrD5Et0iznsSNeSMhVs41iHcbAXdhNSlAs+LOb+iJp
         4+vZYAOGd2cfMouSDJNVxkuzambwmELAPl845dIh83eKbuuLG/xS/WJBJvTTlZjtCjuF
         NzAasiZSCBDxSyKMSbzHdswvVEmlN0MOKCW/j9cKkLyG2uyOa29Z+qEydqHjhPIWlCgV
         t2Qnd8be2Ds+S+Yi2yD9LbSB9pGAXRleBmi1RDt0w3ZxCcH+FZUOsrXudq+b9WNUjA8F
         EBehym/a+9180Zok9t2GLPglZ8lXhLHb888aJ9EWxiHvF7mGkcrWz6llGZnIIdvt47IZ
         4CmA==
X-Forwarded-Encrypted: i=1; AHgh+RoIM8Rqst7vtt/m5phIUHnObSF89JnPy/s1sL4vDsUyBaStidw7kk4Kk3yxJkd6JLQCP3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvidyALDV7KaZ0VtTeCWnjUtJmn5Ku9dat7HVxwisl7RrIMUi2
	iVKEseV4fz9VeuhkDRzFhWExErFr09DvJp0gjsAK7KZ15D6j1cKxH/FVzvuaGUD/m0mVgWoL6Pv
	MEo5LW2Pqj/YfOOetlgyIvpEI9zn24gR92OLMnmFy
X-Gm-Gg: AR+sD12lvFM8ZRx/EtTFKplmrxoGQ9rHctj70EByVkgj39mt15vPeRe+62T9OgF7P2r
	xYynjwNzQRh6DVsBZcwD4wi86OHZdmRur35vw98vHgbqOKqJlhoVHquAtRoDTVGfB3gA550nzAP
	yyLDNf3fboxaGCpNau+NtVnLt11b474UcSRMalYt4ucKW2+PQuMHnV4Icw/aX9VXRxDGqsccH9I
	YPW6aglHW8kc3qHcVK6oLoevzCqKN7OEZ/qYAAO1OsAbun6z1Oa0vmAQ+1tNkQZjKiapXqo0KV1
	l6JybwChQm4XwWbXzzTHjDVKRun2Cg2z5CcY3eyVsoXclvf1
X-Received: by 2002:a05:600c:5908:b0:495:6d47:59b5 with SMTP id
 5b1f17b1804b1-4957bcdfa79mr28605e9.6.1784827670817; Thu, 23 Jul 2026 10:27:50
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722203801.1854941-1-tjmercier@google.com>
 <20260722203801.1854941-3-tjmercier@google.com> <0fe51955-39f7-48ca-8ce5-bc842868d53e@gmail.com>
In-Reply-To: <0fe51955-39f7-48ca-8ce5-bc842868d53e@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 23 Jul 2026 10:27:37 -0700
X-Gm-Features: AUfX_mz4IZw63r-BlpZS_ac49JC851B5P_rc0ab7MN847r9tfbXGEivS7vltV_A
Message-ID: <CABdmKX07MAoa62XtLO24yHv4jW8QHKsheAg_aWQuGV9kAatHeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] bpf: htab: Reduce elem_size by 8 bytes for small key sizes
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 7:12=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 7/22/26 9:38 PM, T.J. Mercier wrote:
> > For standard and PCPU (non-LRU) hash maps with small key sizes (<=3D 8
> > bytes), comparing keys requires only an 8 byte compare. Storing a cache=
d
> > 32-bit hash value to shortcut full key comparisons provides no
> > performance advantage for small keys, and consumes memory for every
> > element.
> >
> > This memory can be saved by eliminating hash along with its associated
> > 4 byte padding before the key, reducing the elem_size (and key_offset)
> > by 8 bytes for standard and PCPU maps.
> >
> > Introduce htab_has_hash() to check whether a map requires a cached hash
> > field. Update htab_elem_set_hash(), lookup_elem_raw(), and
> > lookup_nulls_elem_raw() to conditionally bypass hash checking and
> > storage when htab_has_hash() is false.
> >
> > Together with the previous patch, this reduces the minimum standard and
> > preallocated hash map element size from 64 bytes down to 32 bytes, and
> > non-preallocated per-CPU element size from 64 bytes down to 40 bytes.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  kernel/bpf/hashtab.c                          | 35 +++++++++++++------
> >  .../selftests/bpf/progs/map_ptr_kern.c        |  2 +-
> >  2 files changed, 25 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 57729c3dff3d..b8c30d402958 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> ...
> >
> >       hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> > -             if (htab_elem_hash(htab, l) =3D=3D hash &&
> > +             if ((!htab_has_hash(htab) || htab_elem_hash(htab, l) =3D=
=3D hash) &&
> >                   !memcmp(htab_elem_key(htab, l), key, key_size))
> >                       return l;
> >
> > @@ -812,7 +825,7 @@ static struct htab_elem *lookup_nulls_elem_raw(stru=
ct bpf_htab *htab,
> >
> >  again:
> >       hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> > -             if (htab_elem_hash(htab, l) =3D=3D hash &&
> > +             if ((!htab_has_hash(htab) || htab_elem_hash(htab, l) =3D=
=3D hash) &&
>
> htab_has_hash() is constant for any concrete map, maybe we can store it i=
n the
> struct bpf_htab (it has few holes) and we already describe layout there,
> or at least not calculate on each element in the bucket in the loop.

Ah, that's true. There's already a htab dereference anyway to read the
map_type and key_size, so might as well use a byte in bpf_htab to read
a new has_hash directly.


>
> >                   !memcmp(htab_elem_key(htab, l), key, key_size))
> >                       return l;
> >
> > @@ -3219,7 +3232,7 @@ static int rhtab_map_check_btf(struct bpf_map *ma=
p, const struct btf *btf,
> >  {
> >       struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, m=
ap);
> >
> > -     return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
> > +     return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor, offsetof(=
struct rhtab_elem, data));
> >  }
> >
> >  static void rhtab_map_free_internal_structs(struct bpf_map *map)
> > diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/t=
esting/selftests/bpf/progs/map_ptr_kern.c
> > index 373c8d17ea55..6bd4cb68c20c 100644
> > --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> > @@ -114,7 +114,7 @@ static inline int check_hash(void)
> >       VERIFY(check_default_noinline(&hash->map, map));
> >
> >       VERIFY(hash->n_buckets =3D=3D MAX_ENTRIES);
> > -     VERIFY(hash->elem_size =3D=3D 64);
> > +     VERIFY(hash->elem_size =3D=3D 32);
> >
> >       VERIFY(hash->count.counter =3D=3D 0);
> >       VERIFY(bpf_map_sum_elem_count(map) =3D=3D 0);
>
