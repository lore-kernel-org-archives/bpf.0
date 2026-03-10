Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE811F0991
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182339; cv=pass; b=B8V4jT+F2viPTJBgboClMH8tZGYks0z0l/CRZZcEaA9LiuFJoxODAgbmyQOen88ajb4TrnsXHydiyRlVKfX3Wx4rJ1T6Yz0L+nfsX6OChxDxwzNBpWbqjoAA9NZ687QKvvIAI90NGN4gE5MFoT0otJNHpxqfZoASfaBQvf6axgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182339; c=relaxed/simple;
	bh=adN8mSmT5KiyCqqkp3zzDOinhaoiTX/wwWoOdy7T+Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNdGy2eJp6+JiaJrM7xrKWTg4GanevND+155VJuC0Wxw9blNlPVdEcYAnr0Mr+cI+rQuCGOttAOX+s8pk2xXjAfmgzRJY2e74Tqv+dOVigRklgysnMYuKE4ks+gqCWIywQcUr1XpzJDSSRV9FioJtNJbb+Eqcpg2lPzvt8oKRIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcMu46UV; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcMu46UV"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ae222d978so13331809d50.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 15:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773182337; cv=none;
        d=google.com; s=arc-20240605;
        b=dhoWxHPEKhhzDGQQmPE0o6ZF8e8c2JehYhDERmJH+N5+C7Luhn7L5ws5491Tz10NmT
         q8PJ386zuBgw+qqoTc5mb9Wt//fcIEdGPjsxaRSvcp3ezhFlt2/hlnlT+nEdmBN/2JXb
         uaZQ9jSqXDrBOJTCCnRX7UzHPFa1+Iyms3E1S0m/MZUKRaNONBnEjUSNFYo4D+iZmqri
         WiBZCMIeIuFsCr+qn81aPvcPpvbQ2u3xrS5zlIV5204pTYDh4htgwy1eCme9igDouCr5
         GhOf0XS5NSi+cW18z+MCkKJKYzyLp5hTiu6oJB9YqgtfoiLtfZ3z6gu13ZLuBmb/duIy
         CQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7TBB+if74r6iPNJdGoSJqkGfVuG0XXbmvLHrYlJ7O94=;
        fh=mgPlAYTwY/JJfVNQ0GNmQQg4hDQFQS9jdeR9bQsfw1Y=;
        b=Y6Vl91cV9atdLFlP3CQImogFLV9X8bZ8AL2hxdSDcv5MAX7mPbyYgn7NhAwkreU7Fe
         ZQ/srti2+MOinj8DYPZCVTxn4b+Dye7qaDctqFiWLK4S9jJmxFCWhErI0RfMhx+ulnpx
         suA3+okilobo8N+N9evyYWCb3iDHPCC4/WjLWq3MQhZyKcw70P0pgDk10xBubxKoFkRH
         yKDMA2OZsOc4bXa/V6y+OdGxy+4HynjebBktbx73EYCYQ1mx/811M/7gyPnk1zLUjFvf
         O2esf3WcbzBzQMJwKTNRoZ/bjxjrcnl0azsKZ8htCznZt50kHCYgi0q76bfOnzgUZPdA
         uheg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773182337; x=1773787137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TBB+if74r6iPNJdGoSJqkGfVuG0XXbmvLHrYlJ7O94=;
        b=DcMu46UV7VHinLhTqduth2qa3R+Y0n4zgQwTFimZLIFHCxuY6wM3Rm7j5ILpqcEJU9
         vIq3tHMsc3MncrgxB/kB75jDrl0eEbydX9Re7vDaZUxHIlHpz1HZtAiDu2DMbp9CuET5
         267FZQmQCX+NjApc9yANCoBUZoILw3GO+A+L6zF/5h9BVriC5XvIXsUE/aJTzlQii6vD
         NPR4aiNIji/EMCKxV3q4PfGOSO3wvh2UVNCAGougB969DdoLJ+vIa5g7z7fIkHsSejPG
         fj1snxmks1RW3HEViOt9h+PoBMSs5UV4cRALkPn4uIxeCBu2H4Tm2BnxwBAuHrTV6Tsf
         iqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182337; x=1773787137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7TBB+if74r6iPNJdGoSJqkGfVuG0XXbmvLHrYlJ7O94=;
        b=JBQU92tc7zk0+0E6AAvPY9ZXhFH/F69q7tv4hEVcZOyK2u0a3Qz4d81dLZW7lL5GWE
         I9SMrW+vOYMQOWXVMNer+yTF5VN4QXYTpDVih7caB278XJhCFN+ykXO3efK7qe4g08OG
         PyoharBb4ID9yw7J8+4HyXi09lJ5EMyuSfuwUyWFxjPGqjTpHb7BOMtlLoR/9PDNBKs7
         NrNW1NQeVyoW3s6dXUP/hLbmG68bO+Jq2pNgth7Fz4gzlRdhlxsSu5Gix3jNVu37gWjm
         S30juXna+eDV08oliL+m6XA1EKEcekGYi3jUvV7AXZgEEl2/1ZVlISvELd3Rgb//O0uT
         r9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnT0/KmQ4d6mr8Y3YXNUvM5nGkHSyUzca8ZtBUfob5l/FTDXSSGSCpCNYVdVqbXu4mLvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziixixV6VOx/4X+IhLOc44CIHBWpfPGMsglLWYYhou2j6GDEB7
	GWIJk5wX7+3vrcEPErH9G8ay+QfdiCEi+KoNDHJsZOrU0EQPFJBELPqxrH3xVLZQSmwTCPYCZTw
	Ec8jPZeBdd5ESeI4SqSBaYIyOELyUDXI=
X-Gm-Gg: ATEYQzxRBEQT7/qv7JP9bEgU6CBtkGdYPHzTHs9DwuMje2gpG3/SDRLBdOHZXLcJ51Y
	YxMfDjaycvIZRpbyLCb6PXnOKQPrIrLMjN2KSpiiXHkxRslQrCqrF3j4feGBIJEqMYWsfoLGJ51
	u035FKH7ibfW+N6UjoZ3SHNL3nc9pXAzA5g5G3W5EaozjPw8Ab5iOVHbEd1No6bYp2gdzbSxY+0
	6xkvF4lJeLozgNubM0wxjUZ0uuSDnfps+yp7nBdqLoBLKzHne56Ennp7YDz0UO9hMG5wfHaOD8G
	FA96xBEpOPGUHwZf7S1cjwM=
X-Received: by 2002:a05:690c:c4fa:b0:798:caa3:86de with SMTP id
 00721157ae682-799180063a7mr3267307b3.66.1773182336701; Tue, 10 Mar 2026
 15:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773170190.git.grbell@redhat.com> <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
 <CAP01T75MFfp8oBrogRvm+BRh7=fvm9pP0vTvNm=RW3r3=WDB7g@mail.gmail.com>
In-Reply-To: <CAP01T75MFfp8oBrogRvm+BRh7=fvm9pP0vTvNm=RW3r3=WDB7g@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 10 Mar 2026 15:38:45 -0700
X-Gm-Features: AaiRm51t--WL-oahp6NxodzYZjHVBz95XbYIDu6aRQhzB4toDFhSTuNn5qHOvx4
Message-ID: <CAMB2axPT8L60FGN5wben-pa73toOwLcD8cuGqbNUg6AB57ePYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition
 in struct_ops
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Gregory Bell <grbell@redhat.com>, bpf@vger.kernel.org, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 2:41=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 10 Mar 2026 at 21:21, Gregory Bell <grbell@redhat.com> wrote:
> >
> > When running BPF struct_ops tests consecutively, the second test fails
> > because BTF object references take longer to be released while their
> > associated module is removed from btf_modules list immediately
> > during module unload. This creates a race condition where the second
> > test retrieves the cached BTF object but cannot find valid module
> > information, causing btf_try_get_module() to return NULL.
> >
> > Fix this by modifying MODULE_STATE_GOING handling to wait for
> > active BTF references to be released before completing module
> > cleanup. This ensures BTF objects are properly cleaned up from the
> > cache before their module metadata is removed, eliminating the timing
> > window that caused the race condition.
> >
> > Signed-off-by: Gregory Bell <grbell@redhat.com>
> > ---
> >  kernel/bpf/btf.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 09fcbb125155..81c9f46a7bb7 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notifier_blo=
ck *nb, unsigned long op,
> >                 list_for_each_entry_safe(btf_mod, tmp, &btf_modules, li=
st) {
> >                         if (btf_mod->module !=3D module)
> >                                 continue;
> > -
> > +                       unsigned int timeout =3D 1000;
> > +                       while (refcount_read(&btf_mod->btf->refcnt) > 1
> > +                       && timeout > 0 ) {
> > +                               msleep(1);
> > +                               timeout--;
> > +                       }
>
> This isn't the right way to address such issues. Your diagnosis is
> correct but fix is just papering over real problems.

Second that the fix is not right.

>
> The better way would be to block the discovery of such BTFs once the
> module is unloaded.
> I.e. once we return to userspace after module unload, subsequent calls
> to obtain an fd for such BTFs should not succeed.
> If someone is racing to look it up while the unload happens, so be it,
> they will fail anyway.
>
> I would use a bool flag in struct btf, set it inside the critical
> section at this point with WRITE_ONCE, then test it early in
> bpf_find_btf_id and bpf_core_find_cands with || in !btf_is_module
> condition.
> Using READ_ONCE of course.
> Also, we need to add it to btf_get_fd_by_id, so that once conversions
> from stale IDs to FDs don't succeed.
> Looking at load_module_btfs(), it already handles the ENOENT case when
> id lookup succeeds, but fd lookup fails.
> So for stale ids it should just skip over their errors if we return
> the same ENOENT as the refcount_inc_not_zero case.
> We will still report stale ids, but not allow their conversion.
> We could filter id lookup too but it will penalize the common code and
> we need extra radix tree lookup just for BTF case.
>
> For me locally, these changes seem to address the problem. I could
> send the fix, but if you would like to take a stab at the above
> change, please go ahead.
>

I guess this is worth a fix because it makes btf_get_fd_by_id() less
likely to return to stale id. However, there is still a small window
between btf_get_fd_by_id() and btf_try_get_module() so struct_ops map
creation can still fail.

As for the solution, there already is btf_mod->flags. So maybe instead
of adding a bool, just test the flag?

>
>
> >                         list_del(&btf_mod->list);
> >                         if (btf_mod->sysfs_attr)
> >                                 sysfs_remove_bin_file(btf_kobj, btf_mod=
->sysfs_attr);
> > --
> > 2.52.0
> >
> >
>
