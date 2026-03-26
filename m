Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0503F9F46
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537165; cv=pass; b=pvvp95AL4gju4XJUWIWMudQoZdVzvUqXfmUdMqR+77MT9yBGey0kFnhY5/FS0r6KIvbTKlJ0/GELW8HV8ivaxQhMS6BFNtRim0qWl31fRZRdQQrlelk0jDjrXnQ8W8UwwTCfHiQUioee6YKra+Kmjv7IstM1t6tFndN6J4nXwqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537165; c=relaxed/simple;
	bh=d/5IHTj4hTNA3EEaKQLmWTfVTeqtofYeKstgVim0wnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZmCWQb1m2k77whEnwdc3+k3ghAdYYFOUTTPLuuKmBWcz7cuqLERMPDAKttDT3gnxL5ONzoIYwhz0LunJ0VmX/B53/R6SKuW00tJfdcg5uDgg5W7eo79WOGUR57a5fjyi8WR4pnayMa2XGM+3DsEQKB4mfmkUDOxmZjbipdllvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqvKezeR; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqvKezeR"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-439b2965d4bso861507f8f.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 07:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774537162; cv=none;
        d=google.com; s=arc-20240605;
        b=jCtkNty5Y2+/WPhztWaaY+fy+LVHe/YXU3tG75nq9nUYfm0S8YutDb0E+s3GtG3OMp
         qIi7WrOGGQxk2a6xTlj35WWFSuW1VbLiFwVM3z7ZZuO1JrDtULe2UxBMmzZ2pUm/S0mP
         6h1neue0HA7mRYRmEuGcjnHHv/Clj9D6d15c065rAM/vxCR2DP8WtLZvqKRyDzFo5jNE
         TdBi5SejhLU5CiFpywbr2JdQG5U9qAKIKfX54qBxtoMtI30OKf8Kcr1qnrCtI8uWbdcw
         lz+qQsmwwCSw0AYvXs7jZ3hHskINxGZW5u/lKdrdLHPx9Vinoxk7dInYsdTmeebVfRRH
         F3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vzQWmEYdCYz6Ub0X1oYGPaprs1Zp+6qYJAbA6ngsbjM=;
        fh=VYUA/+S9/KChuqUxxzkPlCXh9ePRIlVQQ2Rs0uzaj54=;
        b=DJ8+TDGpR3Vtml2hB8c7+65A7u2k3a/cFxs6x/TJeazP1jYwv9Ba2BOdAdpp7yGsD9
         WTtbLRPIy8MlflsYaXyYpsVyCknP/XEgB9v4seSx0gabnBblkOFtlhy2t2bWh6JE4nc2
         oEi0HknwTxiZMjkSdDAXCI0+WLOBC7vloc0P4lnwv8aD3pbTtId1oouBF/1p/7WFK227
         9iMT4+jN/NBt3OQK9FHsWiHVbivK5Mb35pTR7VboMeS6x5URgS9kkTeTU7KONaObm1xD
         g+D95Jnb/y0OTp83cuf9dv0CVUiIvGWFLPZ2RQXdPzbTyyZe/Bz2g/6FWoD4Y4EVyRHq
         SX0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537162; x=1775141962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzQWmEYdCYz6Ub0X1oYGPaprs1Zp+6qYJAbA6ngsbjM=;
        b=pqvKezeRvJ0hpN1UUO1ylPuhiUtOlBMGcWkQ9ooxypPSQ2S7uYy2pQfcsuHta+Eyjt
         AwXxhaqqS7AlCzFYz9uz4A1VmNciyuFPlqapWW4RxWS1n758Iy+sFk+uex955uN0YLcR
         z5mKYCt9+o4+tof4rH2uC50aFlARL4KY0pJNIRq8LAtC6u+jP7aPjJAlNevOyWINPMRL
         hv2y/mCi3H46SKGN5Flmh8dQrZ3TbGiCUMSk21ggVqm9IzdLxi6pZJhzkiAaJxdMrN8T
         O0cOqmHA2GL+9ZCZF9dtMVFDurch6USZzIaVAyOhSQJW0PpWAazLCb7nD0sWeKxCEppb
         o9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537162; x=1775141962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzQWmEYdCYz6Ub0X1oYGPaprs1Zp+6qYJAbA6ngsbjM=;
        b=m96slqRUrymyTHZfIbxseauL3bB+QelidF6n4jCsSjH6uOg5KR5jP+JINkPffFtZeD
         n4sEBU2U0LZdzTt2BAaM6E1SeDepJVlPJ+rizT+urcc+P6hnsRuZhClkLSSPUcxyGVw1
         rXIoGb+uauc6P9HGblzGfdp1mcg0BSePJaGPdQQGenPEEtEzkZisc+dXB+bcBP8Ot27K
         wTtXnKKsk56ID3D2Wr2zGgOXc03f1Th6bDTR0A8Wum/Kkl07YW/3YWydLDeyOyTotnil
         cxq1gtU14hNrR6f8nAxqttdA4wEVdEtHcAqcwaELbfXTvj1cAEy29W8xWEEa+G+4GHCd
         MhLw==
X-Forwarded-Encrypted: i=1; AJvYcCUkes60fQ8E1xYiEN32Qr/KzMMr3qKv+0hYaNmP+yQRuA95TZc7GKqfieXtJWEfnq1p/oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB16amx6RhcJkRg+Cyek0QvKitPgyzKSjKqAQ+9zlOIBIdVAgj
	1Njx11V8EYV0EVfedTQpf58nIJFbmAMuVOMFrB7sVUjaSZBwZEjdmISDgDzNe6Pn2bFy7wxPmz8
	mVyLSaEnasuTRMwTUPOzjfwoNNK0ihRM=
X-Gm-Gg: ATEYQzxOoVgAk0pS7SL6z4ilcYzLH8eP0hx7b3GACbdsDEvt7kfYL2O0w+XI74l7nYM
	m73krrAIp8wLuPdStPKbcMggi40vLrziO++r4EdPLfsy4utL2Q8z49ooghOuoarTKhG7B8kUv+C
	tdgoIvJLTztQukcXpItsze5Tw1q6BzWe6Nl14GoNFJymMEh01cUc1oP1lKjIBRy58/XTH8HjAix
	rho7xBB6RiJ9pjLHEooYQfBkUpn5a3T+f+iqT4EY6j2yQGXBziya71ZCRJNxZSicrrTSpMtpFlZ
	DPQPwoWyC7UiuY43A6fiH/psPWtqoH5jZiScc5h/2sq0HwQg3hIl/fbVN0b8Dofco+BzqnA=
X-Received: by 2002:a05:6000:4007:b0:439:d769:ec56 with SMTP id
 ffacd0b85a97d-43b887f0b9emr11917935f8f.0.1774537162050; Thu, 26 Mar 2026
 07:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org>
In-Reply-To: <m2se9mg16x.fsf@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 15:58:45 +0100
X-Gm-Features: AQROBzA5T1wgwcp38FoeSFAhbEkwEUQpOz3IFhHjwpdwQX-vwQYCNCu01QT7zYk
Message-ID: <CAP01T74f3XrftbddSJ-=svtcR5f_MYbkrwfh0a=zr6kM6tB+dA@mail.gmail.com>
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update path
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Aaron Esau <aaron1esau@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Mar 2026 at 14:46, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Aaron Esau <aaron1esau@gmail.com> writes:
>
> > Reported-by: Aaron Esau <aaron1esau@gmail.com>
> >
> > htab_map_update_elem() has a use-after-free when BPF_F_LOCK is used
> > for in-place updates.
> >
> > The BPF_F_LOCK path calls lookup_nulls_elem_raw() without holding the
> > bucket lock, then dereferences the element via copy_map_value_locked().
> > A concurrent htab_map_delete_elem() can delete and free the element
> > between these steps.
> >
> > free_htab_elem() uses bpf_mem_cache_free(), which immediately returns
> > the object to the per-CPU free list (not RCU-deferred). The memory may
> > be reallocated before copy_map_value_locked() executes, leading to
> > writes into a different element.
> >
> > When lookup succeeds (l_old !=3D NULL), the in-place update path return=
s
> > early, so the =E2=80=9Cfull lookup under lock=E2=80=9D path is not take=
n.
> >
> > Race:
> >
> >   CPU 0: htab_map_update_elem (BPF_F_LOCK)
> >          lookup_nulls_elem_raw() =E2=86=92 E (no bucket lock)
> >          ...
> >   CPU 1: htab_map_delete_elem()
> >          htab_lock_bucket =E2=86=92 hlist_nulls_del_rcu =E2=86=92 htab_=
unlock_bucket
> >          free_htab_elem =E2=86=92 bpf_mem_cache_free (immediate free)
> >   CPU 1: htab_map_update_elem (new key)
> >          alloc_htab_elem =E2=86=92 reuses E
> >   CPU 0: copy_map_value_locked(E, ...) =E2=86=92 writes into reused obj=
ect
> >
> > Reproduction:
> >
> >   1. Create BPF_MAP_TYPE_HASH with a value containing bpf_spin_lock
> >      (max_entries=3D64, 7 u64 fields + lock).
> >   2. Threads A: BPF_MAP_UPDATE_ELEM with BPF_F_LOCK (pattern 0xAAAA...)
> >   3. Threads B: DELETE + UPDATE (pattern 0xBBBB...) on same keys
> >   4. Threads C: same as A (pattern 0xCCCC...)
> >   5. Verifier threads: LOOKUP loop, detect mixed-pattern values
> >   6. Run 60s on >=3D4 CPUs
> >
> > Attached a POC. On 6.19.9 (4 vCPU QEMU, CONFIG_PREEMPT=3Dy),
> > I observed ~645 torn values in 2.5M checks (~0.026%).
> >
> > Fixes: 96049f3afd50 ("bpf: introduce BPF_F_LOCK flag")
>
> Although this is a real issue, your reproducer is not accurate, it will
> see torn writes even without the UAF issue, because the verifier thread
> is not taking the lock:
>
> So the torn write pattern CCCAAAA can mean:
>   1. Thread A finished writing AAAAAAA (while holding the lock)
>   2. Thread C acquired the lock and started writing: field[0]=3DC, field[=
1]=3DC, field[2]=3DC...
>   3. The verifier thread reads (no lock): sees field[0]=3DC, field[1]=3DC=
, field[2]=3DC, field[3]=3DA, field[4]=3DA, field[5]=3DA, field[6]=3DA
>   4. Thread C finishes: field[3]=3DC, field[4]=3DC, field[5]=3DC, field[6=
]=3DC, releases lock
>
> This race happens regardless of whether the element is freed/reused.  It
> would happen even without thread B (the delete+readd thread). The
> corruption source is the non-atomic read, not the UAF.
>
> If you change the preproducer like:
>
> -- >8 --
>
> --- repro.c     2026-03-26 05:22:49.012503218 -0700
> +++ repro2.c    2026-03-26 06:24:40.951044279 -0700
> @@ -227,6 +227,7 @@
>         attr.map_fd =3D fd;
>         attr.key =3D (uint64_t)(unsigned long)key;
>         attr.value =3D (uint64_t)(unsigned long)val;
> +       attr.flags =3D BPF_F_LOCK;
>         return bpf_sys(BPF_MAP_LOOKUP_ELEM_CMD, &attr, sizeof(attr));
>  }
>
> -- 8< --
>
> Now it will detect the correct UAF problem.
>
> I verified that this updated reproducer shows the problem, the following
> kernel diff fixes it:
>
> -- >8 --
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index bc6bc8bb871d..af33f62069f0 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -953,7 +953,7 @@ static void htab_elem_free(struct bpf_htab *htab, str=
uct htab_elem *l)
>
>         if (htab->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH)
>                 bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
> -       bpf_mem_cache_free(&htab->ma, l);
> +       bpf_mem_cache_free_rcu(&htab->ma, l);
>  }
>

Immediate value reuse is expected behavior. BPF_F_LOCK only serializes
writes to the map value from the syscall path, it doesn't guarantee
that a concurrent delete won't unlink the element (such that it gets
reused).
