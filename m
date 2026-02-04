Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3827A465
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770246873; cv=pass; b=BtSI4P65huLrLw2NHaS6+GZoCq5vs8YAoCv+rTNCITCdLU3jpIng+epHuQEp3sqeTjJ87z7Hg4Jidd7rr2kihKRBuhw1wIci0LaUWVUg6wEETdBU+bplw9xG1dO3AOSymW+uGsWOmJx/BCU1d1k7/BMd/ob71tdE2rkQgbNzocw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770246873; c=relaxed/simple;
	bh=IiqA/rFNO1vQW2J9cQnDinMh4QaNx9n6QAdKHhGHXEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzcw9DBf3pz1uVteJxoe832FFMQnle0VBzCGgoc0MiXHH0S94URy/FDz+PuKOe8F8J0347HuOrJiXwfZkwwcB96nEOB0+bkDKTdcIG2VyOZtkc5V4XXTHMjIey0zez22I5ENDw8Ihivehjv+MqKjQoZ9HMqGAUX56XJZUT86Uiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpKuW2wk; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpKuW2wk"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-649d4690174so507128d50.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 15:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770246872; cv=none;
        d=google.com; s=arc-20240605;
        b=EHCeM+EzqdnNgEPo+GNR8Dptkxtyd87NXnyF3fLpzja0jSJHl0c6c172THkeJrn4+B
         lydSK4EpXyNhe2fzHqfZNQuRC4iP663cQdJpQMUUUoUlpC+wnofycpt+tUUjeVIVo6oZ
         gUXpuDusPiVHpG9QXONhgIjJQzlkqgB4qUsLGi2zVFja3FKawsFKSmaKn0fSefIngjZ1
         5kloKEENiUAZEkuVqRyXibrWE5v7pypBVbhr5NDbJmye3N4pmeNgCxibK0/dnDE8y4Q6
         YxZzwm1QT6abAr2N/bNANir3N2WEPMxcnCvlGW/jn/0vlkOp/hfXgeOc3efI4OSNe0nZ
         UE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L7rT1lNMjBmrODx3tmMucvb/RArP0arp17qoTkgB6X0=;
        fh=LBDBkig79hLXi/xUKHpFu4XcxCgggGr7PYubO7H+arA=;
        b=HYf+w+zshB8R9nutCuXmBinL1eW/bfbE0p3Kb8+FqGsy5toSWMZ5oBfDPdDqxcddg9
         Wk05SpNIz7H6RJzUc3de9KqaKZ9xjkaQhQ5lKwnfR2lgJeQCrJRukj8qSiyskyBYkqG+
         a9UOE7ZVKI5GEPb4bMyry+5DHYQdbIzCxtxPffdqJIee0+uK03f98i1kpesfYft9cVml
         xdCBN7KuJ9vE8o5HW3S+kzuaxFi3K3Hh0YMAxA/K6+mz9gh4NrbJ1wyBxwuL20gF/iN4
         xWD2N1YYJU+b/JlLBqa+PI4zN3rAOjlbxuuKDRPfjhgQ4EXfxa5C2IXr+qdmYTcXM7+9
         chFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770246872; x=1770851672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7rT1lNMjBmrODx3tmMucvb/RArP0arp17qoTkgB6X0=;
        b=SpKuW2wk0dE/nZ7GrhfkIEcO8ybVlRiON31Key8DgGusql9SaKZ9D3315T7YVVha9L
         5l02LfU/huAjaLmJS7Pf3zZ4SYbNN00FdXsXjdTK/dovatGsSj7uUpUfqjXn0ZXFIPyE
         6QnRrLXZu25YOxAkp9zEO/HVSWK9mWYTSARL/JupglaY+IulJR3dfnOGf61Oc2fa/aKl
         SbKljaDxeGX9ytdzP6zRa59+t0NzmjFr8SvwLxNDlvoLlI25szIh0/5G41G+FfZ7SFfr
         xafpZfBLJeZtW4diVDTK9hlqaFONJEGuUtHYu69KdSyuKnJozUZMmHdeNzbiskRJPI5S
         /NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770246872; x=1770851672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L7rT1lNMjBmrODx3tmMucvb/RArP0arp17qoTkgB6X0=;
        b=LOHuqJ25DNM/GSo+H4HvAbTmMnmykD3Y0NcqeEQpskP7hfNXzFS62YNt+ewj3xJy34
         fsVXSKEWxfKsRGP/5jmQSIqan+EZeGPoLWW9uRMo7w3cT6PdQub5RJ4Tld3Jkv9dPwuC
         qzyo0WnQVFUDgR0GvZylx4JcvJQl/z0GurCI1yPjT4EFJsrg6bxJZbwWLcE9ABkf9GKd
         jqL8vaHnDwU/PZXh5HIYm6Bpk4/GBp5EVrH5/6AXaDv8waYJyDQ9H16GCrRN9aOUdjA4
         qbNqA42ahUJg4+8I5Z6TvVv7JjQEV7moZVRzJ6k8REqkkjJxEDcDBCPpMs1yiaG6Lhvd
         IHIA==
X-Forwarded-Encrypted: i=1; AJvYcCW7iT+Iii1Y9AUGTQlIrt5FdubefUDiqGXT26sWPntpsUm1SdEfs8DVMMlPzdYRd+zC+zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RYGP3EOnjvEQam1n2MnFg2gxipKf1HLJ+XAxAcioJhuYLbOh
	MYgayASAGI8Mk6vHZyNH5sG0V0302/4jRTEuFDSXt0t1GCihDjkRFk9oYVXsbgUesPgmfHGzMXy
	RNZ+WGgB8ZB0OhLP+vls7sUiVHzZP7cw=
X-Gm-Gg: AZuq6aLBAL8x32EFr6pDgmRSq1U2F4HkGiR2jfEreyz999ZVQgKdgtmHBcI8gk/2QVR
	d4vJsPnLTzjXRgxbrk2jXJm2EEitxsiEhGLGOd6y5wzumsdI2dMD7Ysm84pOs+9ti3NFU13Ow8D
	qhiqTaIYqmr5Q/Z1ioFfhKQjL2Pm2pMcuZwKMOOXcDhxyxKg6cfKcY7eosGHIRJeCu1SHGzYDDA
	egnMN09mxTQ4dz3ljUjj+9SopaYCCD9U4y48Sa81bVi08Z54Pd862xmU+67n9E3Y8vC+4t137n/
	CScBu1A0m68=
X-Received: by 2002:a53:d7c6:0:b0:646:7a21:f03c with SMTP id
 956f58d0204a3-649db4be747mr2931371d50.81.1770246871745; Wed, 04 Feb 2026
 15:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201175050.468601-1-ameryhung@gmail.com> <20260201175050.468601-11-ameryhung@gmail.com>
 <d512e9fd-eb04-4194-ab75-b1d2e775461a@linux.dev>
In-Reply-To: <d512e9fd-eb04-4194-ab75-b1d2e775461a@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 4 Feb 2026 15:14:21 -0800
X-Gm-Features: AZwV_QhmrPJGhmmgnk-sHczAamINAc3SuRZriRPTwBx2UAj2CNnp1HOLOF_gmDc
Message-ID: <CAMB2axPMJe6hGeyaAXvzHKyap+9uoH=q66dtCTD-C4zioJa5DA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 10/16] bpf: Support lockless unlink when
 freeing map or local storage
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 9:39=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 2/1/26 9:50 AM, Amery Hung wrote:
> > +/*
> > + * Unlink an selem from map and local storage with lockless fallback i=
f callers
> > + * are racing or rqspinlock returns error. It should only be called by
> > + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
> > + */
> > +static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *sel=
em,
> > +                                 struct bpf_local_storage_map_bucket *=
b)
> > +{
> > +     struct bpf_local_storage *local_storage;
> > +     struct bpf_local_storage_map *smap;
> > +     bool in_map_free =3D !!b;
> > +     unsigned long flags;
> > +     int err, unlink =3D 0;
> > +
> > +     local_storage =3D rcu_dereference_check(selem->local_storage, bpf=
_rcu_lock_held());
> > +     smap =3D rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_h=
eld());
> > +
> > +     /*
> > +      * Prevent being called twice from the same caller on the same se=
lem.
> > +      * map_free() and destroy() each holds a link_cnt on an selem.
> > +      */
> > +     if ((!smap && in_map_free) || (!local_storage && !in_map_free))
>
> There is chance that map_free() can see "!smap" in the very first call
> of bpf_selem_unlink_nofail(). For example, the destroy() may grab the
> b->lock and do the hlist_del_init_rcu(&selem->map_node). In the unlikely
> case, the destroy() cannot grab the local_storage->lock, so it does
> atomic_dec_and_test(&selem->link_cnt). If map_free() hits the !smap in
> the very first time, it cannot move on to do
> atomic_dec_and_test(&selem->link_cnt), and the selem will be leaked. It
> is unlikely if we can assume destroy() should be able to hold its own
> local_storage->lock (no bpf prog should be holding it and no ETIMEDOUT).
>
> I think the same goes for the "!local_storage" check calling from destroy=
().
>

Will fix it by changing to use bits to track whether map_free() or
destroy() has seen this selem or not.

>
> > +             return;
> > +
> > +     if (smap) {
> > +             b =3D b ? : select_bucket(smap, local_storage);
> > +             err =3D raw_res_spin_lock_irqsave(&b->lock, flags);
> > +             if (!err) {
> > +                     /*
> > +                      * Call bpf_obj_free_fields() under b->lock to ma=
ke sure it is done
> > +                      * exactly once for an selem. Safe to free specia=
l fields immediately
> > +                      * as no BPF program should be referencing the se=
lem.
> > +                      */
> > +                     if (likely(selem_linked_to_map(selem))) {
> > +                             hlist_del_init_rcu(&selem->map_node);
> > +                             bpf_obj_free_fields(smap->map.record, SDA=
TA(selem)->data);
> > +                             unlink++;
> > +                     }
> > +                     raw_res_spin_unlock_irqrestore(&b->lock, flags);
> > +             }
> > +             /*
> > +              * Highly unlikely scenario: resource leak
> > +              *
> > +              * When map_free(selem1), destroy(selem1) and destroy(sel=
em2) are racing
> > +              * and both selem belong to the same bucket, if destroy(s=
elem2) acquired
> > +              * b->lock and block for too long, neither map_free(selem=
1) and
> > +              * destroy(selem1) will be able to free the special field=
 associated
> > +              * with selem1 as raw_res_spin_lock_irqsave() returns -ET=
IMEDOUT.
> > +              */
> > +             WARN_ON_ONCE(err && in_map_free);
> > +             if (!err || in_map_free)
> > +                     RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
> > +     }
> > +
> > +     if (local_storage) {
> > +             err =3D raw_res_spin_lock_irqsave(&local_storage->lock, f=
lags);
> > +             if (!err) {
> > +                     /*
> > +                      * Normally, map_free() can call mem_uncharge() i=
f destroy() is
> > +                      * not about to return to the owner, which can th=
en go away
> > +                      * immediately. Otherwise, the charge of the sele=
m will stay
> > +                      * accounted in local_storage->selems_size and un=
charged during
> > +                      * destroy().
> > +                      */
> > +                     if (likely(selem_linked_to_storage(selem))) {
> > +                             hlist_del_init_rcu(&selem->snode);
> > +                             if (smap && in_map_free &&
>
> I think the smap non-null check is not needed.

While smap is still valid in map_free(), SDATA(selem)->smap could have
been init to NULL, and then mem_uncharge() will dereference a null
pointer.

>
> > +                                 refcount_inc_not_zero(&local_storage-=
>owner_refcnt)) {
> > +                                     mem_uncharge(smap, local_storage-=
>owner, smap->elem_size);
> > +                                     local_storage->selems_size -=3D s=
map->elem_size;
> > +                                     refcount_dec(&local_storage->owne=
r_refcnt);
> > +                             }
> > +                             unlink++;
> > +                     }
> > +                     raw_res_spin_unlock_irqrestore(&local_storage->lo=
ck, flags);
> > +             }
> > +             if (!err || !in_map_free)
> > +                     RCU_INIT_POINTER(selem->local_storage, NULL);
> > +     }
> > +
> > +     /*
> > +      * Normally, an selem can be unlinked under local_storage->lock a=
nd b->lock, and
> > +      * then freed after an RCU grace period. However, if destroy() an=
d map_free() are
> > +      * racing or rqspinlock returns errors in unlikely situations (un=
link !=3D 2), free
> > +      * the selem only after both map_free() and destroy() drop their =
link_cnt.
> > +      */
> > +     if (unlink =3D=3D 2 || atomic_dec_and_test(&selem->link_cnt))
> > +             bpf_selem_free(selem, false);
>
> This can be bpf_selem_free(..., true) here.

Ack.

>
>
