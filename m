Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792663236;
	b=eeCV0iZaQ8neqg61iZtDwjKtRGIFhjaKDu/O29yoBedN1iD8cmNHK1eCAjl5oyeSUheB
	 dA95/fiv6BSPlz/Co2BuNhvCxePQo4f3HJPJyxFgd3gIDjgPlqgvCaGA1BDH5mnQUqmA/
	 tOKV2ZEtZTHRqRcVUjJn9TzAyZcpZwN4lhraLQ/H4/hP515XMagD0OWb/JcqvgOR8YKnW
	 nPxvyfta7mxWlVNAhk8wKwX4syrvrwZw3rMwgAbCvtX4wyEnlPOnNL2KfCddB2Ipx9R0/
	 AsLx5gsOZAddELpwW9Fz0SngnVanA8uXOKBAZsFninMOYG5kE/SXxHLKEbib4KjErEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6cCL9T5a4uVS6vl4D3kqOpjQoXbPvB1BeBo3YEtKIFk=;
	b=3HXDzOlPiGCF44/M2t8NKg+TgEHEgAiTG6gdHVkeifZWtCdnHp4ebjSAowu9Xd6RhlN+
	 YHoyW91a0/0v1oDRswv1/jlJm/5TRa58WY96s8ainYgLw1d4c94r20opKnpCor+d8r/dk
	 pmGGbkqFxAqbb5exY7ZVWwWcnlhlRyPlA9Ldx+ierW8aRk+NPygfCw05acOo7JhGvS2Mt
	 fIDaOoJKyy/ai6xpCdgtsjHlnuovCiVKsS9Wh5dD5VuSDfULLyWrouUH0CLwGVkwwfeXw
	 0VcXXFax3gb55GFH5uJwB30LG7wqLuW4BTQqPZ+CJayOjyJXj05MKD7cdTAtNOaF9oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="UbB/yb8n";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13C606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 10:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA13C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UbB/yb8n
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c414e5d282eso207291966b.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792663234; cv=none;
        d=google.com; s=arc-20260327;
        b=LstmM3KkPqXBR/NC9DDe7xdE2RXz3Asf6KL4myWbKQjLZBv05OmBbyYV+2eb/JOuEU
         lFGXVCoEsbAXtABp2RNHR0edYDvvHswboYedZ9WHMfEQfXiHcrnuyEvdPaPE0fieEEgD
         KqG7f3ae4mhrMq9O7ABuRipSR2svecpK7HAkEBJ8R+Q3tlK2F9PU70H0n3xAUrjTcfhg
         48nmkrBKCkDMvp8K11sCkH6++K8cPy4oYHe4Rxv0v5WDC1Nn2isZAkQv4LaXmUViJBuO
         Km3DsPVy9AW0RUizWUvQvo7bt5E45PyufNzYBOp7K4Btj022RaTYGVdufKnOCVasbZG5
         LABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6cCL9T5a4uVS6vl4D3kqOpjQoXbPvB1BeBo3YEtKIFk=;
        fh=hNX7o5oQCb8jQ7/GdWS04+RSUObQQvwJK3z7r7XKgHI=;
        b=KY9VoaCmiCC0lOz2jFLrilgIgqy/iy5wwmWKIUo5JU9pDR4UIK1Wpk1a/xBc5lb0s3
         XwUQc4UtSuVTWjt3vBgj2l+prvzs9y4TT7ObjEXRI40g5bbflTF91SLUzVvP/uAofj1e
         7SlpBUXhPiMB9pStbVPC+u1s0Q8WxjTLgK41uMa9YnnSI1/kyy61h6iSzGbL+RMHLt61
         f/Gk9ZetiUcBgrk00cPtEwNJwMu9inT5nnjRN6UO9rSiY9/4huQyX50uSKgkLnXI2/Rp
         v9AS6KdFuqn05rdcWsn7IxwSYMNCcYFY2WF9Y4sral9QsojQZE8SJCQmmpL4sD8c/Jq0
         Ni8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792663234; x=1793268034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6cCL9T5a4uVS6vl4D3kqOpjQoXbPvB1BeBo3YEtKIFk=;
        b=UbB/yb8nrrcAzdxwr8C6/+QLb8qZ0rsrG0TrG2Xbg6ikemTI21LVkvYMlsIJyTPXmO
         Pipw+vVkf6MdakldaJarYvyYTRb/m0nFUbBGKpeZxJC4woi5JLmgHUcMFrIxBJIv/vKX
         8ZJsNxKCOIvD+bS/2gYJVfKIoA6m3rUG/PW2i4O+ivmHDWA0wHFjFd1MRTRYZxgmpZDx
         aFhukbxrL43DR5FEET7mPQz01Tv/B6xU6UH41MkFTMKXxbNDBf5AuzzwwqBW+ctxNaPQ
         HUtVETfgDVg3b4PAEB5VT3wlHTzNMt4YDr54SFcPXnF/kkD/9UD+SVeMrRyPIkOOdGrl
         c3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663234; x=1793268034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cCL9T5a4uVS6vl4D3kqOpjQoXbPvB1BeBo3YEtKIFk=;
        b=CeX/I8uahylytk7J5fEAHetzlji3MWM36AmG9L3sElOdYc/VKfeOT/wuqy1/taXxNg
         pAzCpkLj4KdMPwRPpkJKlzXWZRnykGVq+TFfVPqfilr0Wjc8z2E4nEZX3mNOar7W+MRX
         FMx4NvxxtsqblomzIEzHqadyk2S9ltTOlhI2qIVViKkTJqUZn04HwpzQ/DuXRuHApwO2
         ZFlyB9HdQ1lIy6pzH28C6NUaOVL3sXoT/IuipDj5b39PRKJNIRpcbZbMPVIdZ2RIkblE
         IIZH7+v4Isr1DG7lbJkJDJ9J/ejY7+tR0oXBZnffKsf/pnuAaKYMkslq6grBAiuqpTo+
         sRew==
X-Gm-Message-State: AFq9FYIl4cmlYoIxjNu0sEnTqfZDSnZ60/F4PP6RDfzWETwh/tPh2n5D
	wTmCPxgPAtnUHECospcEnc3Nebb5srylDWLzTb/b6DNOMpajxI5GLrjdFSdj62hKnsNz8OASVeM
	OQhRilHZJhK2UKgGULgCak3S4P+n1YmQ=
X-Gm-Gg: AYBFou3iPaJGqc//wfsWEx6MikQk2mJMzvY1HTF7WfyKCBBQX6QCs0vXNEfI0iZhuAF
	/SW3SyhLEhRSJEePtUl9H2cramfMJ8rEdlrCijsbNQ7tjtKF81/u78T64cLWFcWg9lZ4o5o9O3O
	nECHYfuzmy4C0i11/huyjJ+5g0rMfgQ301UYEC9TCVPWeetIEknSQANQ2iiIknuln9+p1ChlZry
	WTaRZPkNV5l41BnYyQNC2odhl7QKiCp3xhXk6fj3BYJEam4bHdW1eWkdzrXvSw/c3c/Uulqhu3H
	VdHp61cIvywfGusJtvhAMKkukoLlwRrRMUA86qjoolFN32vRtRwx+DBGVjA/LlvhS9jYfNCHuqa
	PimRgxXkETU0EyVOsSlJgLRIEyJDj38FQcvvwtlnt5ggyT0D7fhIb
X-Received: by 2002:a17:907:1c84:b0:c40:aa04:18d0 with SMTP id
 a640c23a62f3a-c46795f1c0amr411927366b.17.1792663233900; Thu, 22 Oct 2026
 03:00:33 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021185117.650403-1-puranjay@kernel.org> <ac40b5a677a32b6a04824bf86b78bbb432813792d8b6ecf721c7a6a41ce9db5b@mail.kernel.org>
In-Reply-To: <ac40b5a677a32b6a04824bf86b78bbb432813792d8b6ecf721c7a6a41ce9db5b@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 22 Oct 2026 11:00:20 +0100
X-Gm-Features: AclHuK-rCpiM1zcE6C9r2QQU_kAXeH6eoLQXflhvxQCxHISd0RVGXY8aalzAENY
Message-ID: <CANk7y0jM5A4pBLpPJ1LaLunAo7SSbjzitji_Su6tEiCHi2hnFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Drop percpu_counter from the htab
 element count
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, mykyta.yatsenko5@gmail.com, 
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 8:23=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Drop percpu_counter from the htab element count
>
> TL;DR:
> - On 32-bit kernels, torn s64 elem_count reads or NMI races may make
>   is_map_full() wrong: spurious -E2BIG, or inserts past max_entries
> - Two comment-style nits
>
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index bf78e09f4d51..6e2115477cb9 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
>
> [ ... ]
>
> > @@ -94,10 +94,10 @@ struct bpf_htab {
> >               struct bpf_lru lru;
> >       };
> >       struct htab_elem *__percpu *extra_elems;
> > -     /* number of elements in non-preallocated hashtable are kept
> > -      * in either pcount or count
> > +     /* number of elements in non-preallocated hashtable. With
> > +      * use_percpu_counter it only follows map.elem_count in steps of
> > +      * PERCPU_COUNTER_BATCH, see is_map_full()
> >        */
> > -     struct percpu_counter pcount;
> >       atomic_t count;
> >       bool use_percpu_counter;
> >       bool has_hash;
>
> this isn't a bug, but this multi-line comment still has text on the openi=
ng
> /* line.  Since the comment is being rewritten anyway, could the /* go on=
 its
> own line, as is preferred under kernel/bpf/?
>
> [ ... ]
>
> > @@ -739,29 +739,20 @@ static struct bpf_map *htab_map_alloc(union bpf_a=
ttr *attr)
>
> [ ... ]
>
> > +/* is_map_full() needs htab->max_entries - cur_number_of_elems to be m=
ore than
> > + * batch * nr_cpu_ids for the percpu counter to be faster than atomic_=
t. In
> > + * practice the average bpf hash map size is 10k. With batch count of =
32 a 10k
> > + * hash map on a system with 64 cpus can be filled up to 80%:
> >   * 10k - 8k > 32 _batch_ * 64 _cpus_
> > - * and __percpu_counter_compare() will still be fast. At that point ha=
sh map
> > + * and is_map_full() will still be fast. At that point hash map
> >   * collisions will dominate its performance anyway. Assume that hash m=
ap filled
> >   * to 50+% isn't going to be O(1) and use the following formula to cho=
ose
> > - * between percpu_counter and atomic_t.
> > + * between the percpu counter and atomic_t. The batch has to be a powe=
r of 2.
> >   */
> >  #define PERCPU_COUNTER_BATCH 32
>
> this isn't a bug, but the same applies to the rewritten comment above
> PERCPU_COUNTER_BATCH, which also starts its text on the opening /* line.
> Could it use the /* on its own line style as well?
>
> [ ... ]
>
> > @@ -1162,30 +1151,33 @@ static void htab_put_fd_value(struct bpf_htab *=
htab, struct htab_elem *l)
> >
> >  static bool is_map_full(struct bpf_htab *htab)
> >  {
> > -     if (htab->use_percpu_counter)
> > -             return __percpu_counter_compare(&htab->pcount, htab->map.=
max_entries,
> > -                                             PERCPU_COUNTER_BATCH) >=
=3D 0;
> > -     return atomic_read(&htab->count) >=3D htab->map.max_entries;
> > +     s64 count =3D atomic_read(&htab->count);
> > +
> > +     /* each cpu's elem_count is ahead of count by less than the batch=
 */
> > +     if (htab->use_percpu_counter &&
> > +         count + nr_cpu_ids * PERCPU_COUNTER_BATCH >=3D htab->map.max_=
entries)
> > +             count =3D bpf_map_sum_elem_count(&htab->map);
> > +     return count >=3D htab->map.max_entries;
> >  }
>
> Can a torn read of the per-cpu s64 elem_count on 32-bit kernels make
> is_map_full() return the wrong answer here?
>
> bpf_map_sum_elem_count() does READ_ONCE(*pcount) on each s64, which on 32=
-bit
> is split into two 32-bit loads (see include/asm-generic/rwonce.h).  A per=
-cpu
> elem_count crosses zero regularly, since an element is often freed on a
> different CPU from the one that allocated it.
>
> A 0 -> -1 update rewrites both halves:
>
>     0x00000000_00000000 -> 0xffffffff_ffffffff
>
> If another CPU in htab_map_update_elem() -> alloc_htab_elem() ->
> is_map_full() reads the counter in the middle of that update, it can see
> 0x00000000_ffffffff (+4294967295).  Then "count >=3D htab->map.max_entrie=
s" is
> true and alloc_htab_elem() returns -E2BIG for a map that is not full.
>
> A -1 -> 0 update can read as -4294967296, which lets an insert go past
> max_entries.
>
> The old slow path was percpu_counter_sum(), which reads s32 per-cpu count=
ers
> and fbc->count under fbc->lock.  Near max_entries fbc->count is a large
> positive value, so a torn read could not affect that decision.  Before th=
is
> patch, torn elem_count reads only affected the iterator statistics.
>
> >
> >  static void inc_elem_count(struct bpf_htab *htab)
> >  {
> > -     bpf_map_inc_elem_count(&htab->map);
> > +     s64 cnt =3D this_cpu_inc_return(*htab->map.elem_count);
> >
> > -     if (htab->use_percpu_counter)
> > -             percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER=
_BATCH);
> > -     else
> > +     if (!htab->use_percpu_counter)
> >               atomic_inc(&htab->count);
> > +     else if (!(cnt & (PERCPU_COUNTER_BATCH - 1)))
> > +             atomic_add(PERCPU_COUNTER_BATCH, &htab->count);
> >  }
> >
> >  static void dec_elem_count(struct bpf_htab *htab)
> >  {
> > -     bpf_map_dec_elem_count(&htab->map);
> > +     s64 cnt =3D this_cpu_dec_return(*htab->map.elem_count);
> >
> > -     if (htab->use_percpu_counter)
> > -             percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTE=
R_BATCH);
> > -     else
> > +     if (!htab->use_percpu_counter)
> >               atomic_dec(&htab->count);
> > +     else if (!((cnt + 1) & (PERCPU_COUNTER_BATCH - 1)))
> > +             atomic_sub(PERCPU_COUNTER_BATCH, &htab->count);
> >  }
>
> The same concern applies to inc_elem_count() and dec_elem_count().
> this_cpu_inc_return() on the s64 per-cpu elem_count uses
> this_cpu_add_return_8, which x86 only defines under CONFIG_X86_64.
> Elsewhere it falls back to this_cpu_generic_add_return(), a
> raw_local_irq_save() read-modify-write that an NMI can interrupt.
>
> On x86-32, if an NMI perf_event program updates another bucket of the sam=
e
> map in that window, it can see the same return value as the interrupted
> context.  If that value is a multiple of PERCPU_COUNTER_BATCH, both conte=
xts
> run:
>
>     atomic_add(PERCPU_COUNTER_BATCH, &htab->count);
>
> (or both run atomic_sub() on the dec side).  htab->count then stays 32 of=
f
> from the sum of 32 * floor(elem_count / 32) permanently, and the error gr=
ows
> over time.
>
> That breaks the "each cpu's elem_count is ahead of count by less than the
> batch" invariant that the fast path in is_map_full() relies on.  A downwa=
rd
> drift lets the fast path return false while the map is already full.
>
> The old x86-32 fast path used this_cpu_try_cmpxchg() on s32 counters
> (HAVE_CMPXCHG_LOCAL), which an NMI cannot split.
>
> This seems to contradict the commit message statement "so that is exact, =
in
> NMI as well" for 32-bit kernels.  Should the batched elem_count scheme be
> limited to configurations with native 64-bit per-cpu ops, or should the
> summing side handle torn values?

We don't really care about 32-bit kernels in this code path, so I will
not do any change to this unless someone else really thinks it is
necessary.
