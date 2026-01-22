Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13630F934
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043267; cv=pass; b=ulIQVFJ9D3hpMoe/dnAlxjohkwYaMBme0dKNzW78sr10wR/0SthnNsLomnOakAhCIfhdtEcpeD73ayOqf8SDGSw8Z6AUJbaDW/QGhId8v78r4ccjK6MAdxE4g1u9zI21BteKUD1XRmJ/nBSGJ4Vkp03H7s5GW7k8lEnKLYHqujw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043267; c=relaxed/simple;
	bh=eCNedl2PKMJiMiRk0LWzQqYYJO40z/8qt0BTukFMW4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3HUnUUzPeGrKZBeH0jJsmFgyZlf2vW4+f9ugYfk9OjpXnh1ScN2OVDgwNVX2ki2YQn7QbNtELwp63axt1WqeMhwoqfSPU6RvFynjYVh/SmrBIkvKbDXauwlZ4jbphMXuoScuOvHAtID6Y5AKis/M/65ipxcMDUvSYpIfDtsN+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igQ9HA3i; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igQ9HA3i"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50299648ae9so71061cf.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:54:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769043260; cv=none;
        d=google.com; s=arc-20240605;
        b=NKWqbFvcDYwRTVsf3EwKw0LNgx8mhAQls9zWC2faAX6VyohHsnBdj4CBINzcyHF4TP
         cFbJi7/jedE82DRJPXnF5x4ra+m5kKRn8VMW0OvItx++fDy4YU8WP4Fwumn27epfhwFA
         s35f1OXK73Sh/b60sBCPnMPvD1R3fUv5HeHXmKE98vJ4jcHToH3geSbOSmdkeIpTcOlg
         6FO1lyQLbjAF6oRE2+THvXBljrcU4SJzZuzE0HqUIZURB/qWrF2mfYB1HamNIpQqCMxL
         4d3QpVj59Ttj/XJGVsmkAptJIjwLoMSMd44CW7XMnUCgJCMgqmSr8a04wDu7q3UDJyt9
         y+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+NqFR4vEi17NIt2eo657HYzQ+UfH+loYG1rnphf1kfI=;
        fh=qei/CEXthLsv+KCqy/7yzZ0ZQ4TWbE2fImWlGC95bYc=;
        b=N7egYDnQdpXX+NpHohjmViu5RThfGJ1Y6qoPWKn5ovF0ATTZ7sgBQ504+GlVWvaXSw
         Zss1kYGjAeeu9tAaIBn7IEHFVbm17PqbhIKqfLBIwlh++mDJry4KVZUEnglRYOFP8SP6
         iVY4ZRxRD7Lgwqnthraok/oVpm0YjgGBJZ+q8KanP/RyUCLpQRBcHoDkqBnrM6jjQ2Bt
         2OjFZQlgyL04OEcXsTQAVvVqQPfngmtMjTLBxe0FlbvyDuLn7OzgZlPlqZzt05OW5MYp
         00D8ufn6lOBpEVvoUPm/UHowbcf5OQspParkCjrgCMZt1nRinex1zIbkW9Nl/nqZ9Hrq
         ed3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769043260; x=1769648060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NqFR4vEi17NIt2eo657HYzQ+UfH+loYG1rnphf1kfI=;
        b=igQ9HA3ijPSKOY2EuF1A8QhKTrVoJOqpHqjRuUfirL33oQvPxdrTliIYEfUFbtZ3+C
         y0jOWHLEetAo56XrzTVFMiDImKqZkaZM9AA9GzoWUmGqTSsgUJHbW61deUmeYkfrqSmf
         MSZLLs8WwHAd0yYaAtmi39/JfyDQ/5kHPrvqG9WAzZjfAKSnrBKTdA8uH4pPidUrEx3B
         i2opPycgEMMz209MoiGOeGA/ClRQCvQKysCGQeODg8BP+UGRWqgJyDrZFpL9gmwon9ej
         8k9xAkpeOS7rjhUFGKe0kIGzcggjjxAi0V3Or25hQaQlg2CcVWit/CzhjEIUn2snB29y
         3fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769043260; x=1769648060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+NqFR4vEi17NIt2eo657HYzQ+UfH+loYG1rnphf1kfI=;
        b=RcbS7v/7tUGxMOcKoAzkZpDWfoFpToAg2PvGDQ7FDbObxhSp6WA9++3HZv8C/4AzOF
         hFfutED2YfB0wBRwQH5q2XWhKP8tUaiBCraXbQZS62q+KWAI4L5dnaGi+iw2yzDbBLIs
         nQscNv+v0rZT6QcbUGOkL25poVX4ULyItYOMIGRB8eLdNcBKAonKRS97f7zdmH9j3cDY
         ZtRDuMW5C9wG8e/qOHrhZHaHfggCuZUzWDDTXY94eUvbiN/DI00YLF1m+o1xww/qnbrl
         CjPlv5X/5JZveVOiLViYMtZ7WjJaqacDntlzwOrtEAxoHg3Te7msakxP9DY0mJY0IAFf
         di3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX35+zb0mDM+aTGBse9oAJTaCGJPmnT2B8SNdHAC9VP1/5nDZquIaTkvzC2Puz283KYBXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzvxVC3Nni1aPZuOPKccJCBhnojPzBi0RBEK+pFpssiy5AiJ+m
	eKTE+rvHSR1pGBS0hixgV3+xhYnfjDglZ5GidEy3v2O+NuSt8hvXYePSR5ImSoQ7RuGCrRXZPqM
	vawHMez4HOeiWBQZET+W3nknbQE630+DPXsNKnbSh
X-Gm-Gg: AZuq6aL/h+oyA4L8s/ns61nMNJvA8cYgyRVnoLLRt/veT9ykT4GU6jm/64iLDCQn5bf
	ByMobdt+NK7UtwwS1ctjQAP5GX8XX0q9Aceq/d4WwEHvJhnANI+jm0Zo9Jpkqh9M/8ty4RpJygO
	VU4L9zv1LO1xDOoti1D3rxu8n9gXbSMR8gyBHteMNoRayoJZXzAj3Oi05pnIHONkFp6qsMpheTs
	3iB6Fa04drikTDAYbW6kyCxVRds8EDcuNshnBYTPEoB9YP88rcYumrd5ANehdKMFK40J4e7ALs8
	EycksPsEu858+Dvf2rFWYHOw0krt5Ea6cQ==
X-Received: by 2002:ac8:7f11:0:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-502ebd67f28mr5244541cf.8.1769043259374; Wed, 21 Jan 2026
 16:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-19-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-19-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 00:54:08 +0000
X-Gm-Features: AZwV_QiKaqX658yaaNclaMUDJFMuWaWyjwe3fGXZJxanEvpjJyRl1f7lSqjnfpQ
Message-ID: <CAJuCfpHggP+iefwGTOWnSxDma5U=uMROYNs8KS0A=u2w=1rq_w@mail.gmail.com>
Subject: Re: [PATCH v3 19/21] slab: remove frozen slab checks from __slab_free()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 2:41=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Currently slabs are only frozen after consistency checks failed. This
> can happen only in caches with debugging enabled, and those use
> free_to_partial_list() for freeing. The non-debug operation of
> __slab_free() can thus stop considering the frozen field, and we can
> remove the FREE_FROZEN stat.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Functionally looks fine to me. Do we need to do something about the
UAPI breakage that removal of a sysfs node might cause?

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 476a279f1a94..7ec7049c0ca5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -333,7 +333,6 @@ enum stat_item {
>         FREE_RCU_SHEAF_FAIL,    /* Failed to free to a rcu_free sheaf */
>         FREE_FASTPATH,          /* Free to cpu slab */
>         FREE_SLOWPATH,          /* Freeing not to cpu slab */
> -       FREE_FROZEN,            /* Freeing to frozen slab */
>         FREE_ADD_PARTIAL,       /* Freeing moves slab to partial list */
>         FREE_REMOVE_PARTIAL,    /* Freeing removes last object */
>         ALLOC_FROM_PARTIAL,     /* Cpu slab acquired from node partial li=
st */
> @@ -5103,7 +5102,7 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>                         unsigned long addr)
>
>  {
> -       bool was_frozen, was_full;
> +       bool was_full;
>         struct freelist_counters old, new;
>         struct kmem_cache_node *n =3D NULL;
>         unsigned long flags;
> @@ -5126,7 +5125,6 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>                 old.counters =3D slab->counters;
>
>                 was_full =3D (old.freelist =3D=3D NULL);
> -               was_frozen =3D old.frozen;
>
>                 set_freepointer(s, tail, old.freelist);
>
> @@ -5139,7 +5137,7 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>                  * to (due to not being full anymore) the partial list.
>                  * Unless it's frozen.
>                  */
> -               if ((!new.inuse || was_full) && !was_frozen) {
> +               if (!new.inuse || was_full) {
>
>                         n =3D get_node(s, slab_nid(slab));
>                         /*
> @@ -5158,20 +5156,10 @@ static void __slab_free(struct kmem_cache *s, str=
uct slab *slab,
>         } while (!slab_update_freelist(s, slab, &old, &new, "__slab_free"=
));
>
>         if (likely(!n)) {
> -
> -               if (likely(was_frozen)) {
> -                       /*
> -                        * The list lock was not taken therefore no list
> -                        * activity can be necessary.
> -                        */
> -                       stat(s, FREE_FROZEN);
> -               }
> -
>                 /*
> -                * In other cases we didn't take the list_lock because th=
e slab
> -                * was already on the partial list and will remain there.
> +                * We didn't take the list_lock because the slab was alre=
ady on
> +                * the partial list and will remain there.
>                  */
> -
>                 return;
>         }
>
> @@ -8721,7 +8709,6 @@ STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
>  STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
> -STAT_ATTR(FREE_FROZEN, free_frozen);
>  STAT_ATTR(FREE_ADD_PARTIAL, free_add_partial);
>  STAT_ATTR(FREE_REMOVE_PARTIAL, free_remove_partial);
>  STAT_ATTR(ALLOC_FROM_PARTIAL, alloc_from_partial);
> @@ -8826,7 +8813,6 @@ static struct attribute *slab_attrs[] =3D {
>         &free_rcu_sheaf_fail_attr.attr,
>         &free_fastpath_attr.attr,
>         &free_slowpath_attr.attr,
> -       &free_frozen_attr.attr,
>         &free_add_partial_attr.attr,
>         &free_remove_partial_attr.attr,
>         &alloc_from_partial_attr.attr,
>
> --
> 2.52.0
>
