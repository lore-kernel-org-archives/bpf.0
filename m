Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B00261B9C
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773184657; cv=pass; b=AXvcIu+CpDMFGcbPDMsm7eY9p54Rn1ihbvVBPFJpacDWgOMAfNjfQoyeyazUNr0Cgtb/kXSRvy3pRCDL/y4KqMbF3OpjQEa03uwQWtsPRG0Ui1jredyXWBagbi9yvjhyVmxzLbCCHfywK+uYtzkQ96mynbD9F8sg9XW5vBt6bzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773184657; c=relaxed/simple;
	bh=TW2n/2pJjwHW3jRY166ajO1nWwNac5zZuX4AhKdek30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s85GX4kOlbz3g3w7X4Z+NilERPAKkMsbB+oAvc3QB4/y5VV6To0/QZq5K4aQk2G7O/lAnpmIs7CZbwQI1w3Utb0N4Di1QFj4ApKmBxl6a4KfzEdsV/9lO1xVScKxCcdOYIxmUGVgh3JasFxyi2pke/JtefhBCoVGmDyVHWcqXOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlZ2q1IG; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlZ2q1IG"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7986e538decso131445287b3.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 16:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773184655; cv=none;
        d=google.com; s=arc-20240605;
        b=IjcCRJG7O3LARMPa1DkghlPDWQeWSjhR7Z24v+lnqd4K3w/yWkco3YTPlqFhmGqtVb
         BLuqBYdTACil/X7WFSgHTpaAuCAiAkjivDE2UWmM/1ALY1ltJ0nhlibGiMYrehzs5vUm
         tFfB08NQBxTeaAakxDAQ9HhbEzf4FMT6RO0QMBa+IT4RlOwKJi/KH8M2yIrNL0QtMufx
         HRRJj1jYL6uxnXMJTM1ZzulHohfS2Q9xTqMMQ2QCyi5FWAYZ8mspWXu6t1RFj98U9Bly
         vkIovSGgM6yRGnQzSzXAe0+R2K/z9iJcWD6PDIWRsu7sJSOvJkFJS7pSMWrD8Hi47L5H
         BELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TEvNECIqOlaQmJUCIOk9nPCI8+dk7zXJMUPj5dSPe9A=;
        fh=/jIfwOK7Kh5xofbE16tkesCFY13Hd0XwimlVBHMU4sQ=;
        b=VWfb+N2IGtLtknkafLnxguVQspLVQYWRELrX1ngk2/l6dIAT7hOiDcsT1l3Np8EN91
         vLd9Dlu5qdQhOSmaXNRh5D/Rk4vMH4LY6CPboSydmlsiITSCIl6w2sb/ma5oYNmbqTR/
         qPsF6XSjyb1WvNwjEplsxMxmjxNeTDY/xalj7Jrkt7xaAl4tvo6LzRuRikcLRZvDpeRo
         PXippjzi9aJpwt4XTFJYoiE6Z/oSELzmde6Xx5s7vxBM2NiPmh4qVO/ApOKRXH3f8+/4
         hM/ls2Dhl+JpnTVvDe4u0J/jczTT8m4hMMsL9O48+GtL0LeMm7j1VT65MtnydihVoTag
         DDWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773184655; x=1773789455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEvNECIqOlaQmJUCIOk9nPCI8+dk7zXJMUPj5dSPe9A=;
        b=YlZ2q1IGYRrE6+nNhAOxq22fEbLeuHXIYvtmDPyp/23Wz1KOfTj09id3R6AjdvIcsH
         DCFxI1ERcQOczsV6vMmJ0fjSyD7IUUKh6laRIj18hhpY3pEPBRUap8AO/ix1rXoObzSL
         u7NdLN1wpgMWrSH5/USdyVM/JA1K/Ssy8EASbDualL2z4bfydowdLDtthuEA95O1F6hn
         iq2mjD0KCIpLEV8t5COn99+gQo2Z5A5p1WJWa2pjZb06pKQidNs+JjwrDFDx3FsTwl8x
         nMe0oRBthTWdnLLJ7EzXICCZH5kJwJtYzGuhBEheUJe12FQTgRLHpx8NGbxJlC19eyoe
         oFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773184655; x=1773789455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TEvNECIqOlaQmJUCIOk9nPCI8+dk7zXJMUPj5dSPe9A=;
        b=btQafAYPNqTwup1T/Sm9iHSqywxnWR/UW9v5smBUGI5w22MydZV/r/rBQPorO6xgRo
         mZ0pE8nJgI4WXqkVY3qf0PyhglKmUkU8XHAi/T5J+Y1nova4mTHiE8+UvuLoOYOveAZA
         4eiIM8pfZ+VU5RrYdALkgT24o6AxN9SNTRU0EmHzYdf8TBF/7rSe6Ukv7qChL7E8KTsl
         EMMdVD5GcetWa1KjCteWPTPni5KSHOK7SSbc9HDTrSl+Ph8Ub5UYaYQjKnMdbTVOHkiW
         ttbZ/BJVWOsq9RB7Kg4GQSZeVhEjs2cm6inYMJWylRZYNBzO7ps+rqb55/uh6LmVAIrb
         hwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUokE9r4onOr9I0XEg7jSKRMWM7P0cp/Zc+i1P7teNyrKREz2Yk09JuWSg32RDsaE9WJKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAZtWvmlknaTUsA5HOa8Lr7qLrMSzpGVYvlAl2qxuoKf4dWzm
	z2ViimIJ8hfseNn4FLiD9MtzOC3ftfu84vZiRHVpXFJLMe2UIvdqKpVNuVwaXIQqlZWFMeikUwz
	IUjJcxJzzirhTjYdZ0XaFtwIU9tVH+nc=
X-Gm-Gg: ATEYQzydupJ/8s72cP5JiQNpDh93WqQbnUBLy9Y4TGmPxKjmIxzyK+xNKO8GqdzydQD
	zbu4Qb+iOBj3n2IrJ7ipwlK42pik05mEvIUUAkOMp9xfj+n2nbbodex5fwVrmQz84zZm6yZbjux
	SCqSSFqn69DrIpNumPQPib7BcVDtmeMQFrRcZIT0fQ0XxMMf/JyVKh3XTIQbVnDpof9ogAQ8U0E
	+Ide0ShhVLrq3VmYz+lngwzYQyqrBwgIXxS5mDIWJBAih227IGl4HQMwJVHoNV9KrjH47+Oyf7t
	QHGcXqFCzx6rvIoxv6YF+JU=
X-Received: by 2002:a05:690c:c530:b0:797:cd05:bd01 with SMTP id
 00721157ae682-79917fe5abamr4290847b3.52.1773184655491; Tue, 10 Mar 2026
 16:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773170190.git.grbell@redhat.com> <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
 <CAP01T75MFfp8oBrogRvm+BRh7=fvm9pP0vTvNm=RW3r3=WDB7g@mail.gmail.com>
 <CAMB2axPT8L60FGN5wben-pa73toOwLcD8cuGqbNUg6AB57ePYg@mail.gmail.com> <CAP01T76cPcToNwu_NMFU6QDO8qZB+n9WA0_qxSzrasZV-=G-Qw@mail.gmail.com>
In-Reply-To: <CAP01T76cPcToNwu_NMFU6QDO8qZB+n9WA0_qxSzrasZV-=G-Qw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 10 Mar 2026 16:17:24 -0700
X-Gm-Features: AaiRm53wo8-nV0u6zCe_bRgbBVbvqHY9rHoSrBJeWSjG-1eL1qth7EP4ZHNTWG8
Message-ID: <CAMB2axMTkN5R3+JQL-2L0fWAqzOQOFOxp7+WKF4DLUF-FqgiPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition
 in struct_ops
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Gregory Bell <grbell@redhat.com>, bpf@vger.kernel.org, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 3:48=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 10 Mar 2026 at 23:38, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > On Tue, Mar 10, 2026 at 2:41=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Tue, 10 Mar 2026 at 21:21, Gregory Bell <grbell@redhat.com> wrote:
> > > >
> > > > When running BPF struct_ops tests consecutively, the second test fa=
ils
> > > > because BTF object references take longer to be released while thei=
r
> > > > associated module is removed from btf_modules list immediately
> > > > during module unload. This creates a race condition where the secon=
d
> > > > test retrieves the cached BTF object but cannot find valid module
> > > > information, causing btf_try_get_module() to return NULL.
> > > >
> > > > Fix this by modifying MODULE_STATE_GOING handling to wait for
> > > > active BTF references to be released before completing module
> > > > cleanup. This ensures BTF objects are properly cleaned up from the
> > > > cache before their module metadata is removed, eliminating the timi=
ng
> > > > window that caused the race condition.
> > > >
> > > > Signed-off-by: Gregory Bell <grbell@redhat.com>
> > > > ---
> > > >  kernel/bpf/btf.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 09fcbb125155..81c9f46a7bb7 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notifier=
_block *nb, unsigned long op,
> > > >                 list_for_each_entry_safe(btf_mod, tmp, &btf_modules=
, list) {
> > > >                         if (btf_mod->module !=3D module)
> > > >                                 continue;
> > > > -
> > > > +                       unsigned int timeout =3D 1000;
> > > > +                       while (refcount_read(&btf_mod->btf->refcnt)=
 > 1
> > > > +                       && timeout > 0 ) {
> > > > +                               msleep(1);
> > > > +                               timeout--;
> > > > +                       }
> > >
> > > This isn't the right way to address such issues. Your diagnosis is
> > > correct but fix is just papering over real problems.
> >
> > Second that the fix is not right.
> >
> > >
> > > The better way would be to block the discovery of such BTFs once the
> > > module is unloaded.
> > > I.e. once we return to userspace after module unload, subsequent call=
s
> > > to obtain an fd for such BTFs should not succeed.
> > > If someone is racing to look it up while the unload happens, so be it=
,
> > > they will fail anyway.
> > >
> > > I would use a bool flag in struct btf, set it inside the critical
> > > section at this point with WRITE_ONCE, then test it early in
> > > bpf_find_btf_id and bpf_core_find_cands with || in !btf_is_module
> > > condition.
> > > Using READ_ONCE of course.
> > > Also, we need to add it to btf_get_fd_by_id, so that once conversions
> > > from stale IDs to FDs don't succeed.
> > > Looking at load_module_btfs(), it already handles the ENOENT case whe=
n
> > > id lookup succeeds, but fd lookup fails.
> > > So for stale ids it should just skip over their errors if we return
> > > the same ENOENT as the refcount_inc_not_zero case.
> > > We will still report stale ids, but not allow their conversion.
> > > We could filter id lookup too but it will penalize the common code an=
d
> > > we need extra radix tree lookup just for BTF case.
> > >
> > > For me locally, these changes seem to address the problem. I could
> > > send the fix, but if you would like to take a stab at the above
> > > change, please go ahead.
> > >
> >
> > I guess this is worth a fix because it makes btf_get_fd_by_id() less
> > likely to return to stale id. However, there is still a small window
> > between btf_get_fd_by_id() and btf_try_get_module() so struct_ops map
> > creation can still fail.
>
> That's fine, it means that module unload is happening in parallel, so
> it's racy and non-deterministic anyway.
> When the user controls the module unload though, they should not be
> getting stale BTF fds once module unload has returned to user space.
> At that point all associated artifacts shouldn't be discoverable.
>
> >
> > As for the solution, there already is btf_mod->flags. So maybe instead
> > of adding a bool, just test the flag?
>
> You mean struct btf instead of btf_mod? I don't see the flags field there=
.
> The btf_mod->flags won't work, it's already deleted and freed by this
> time, and requires us to go first from the BTF to the btf_mod.
> So it has to be in struct btf.
>

I was thinking about updating btf_module->flags when handling
MODULE_STATE_GOING. Then btf_get_fd_by_id() can call
btf_try_get_module() to check flags if it's module BTF. If the module
is already freed then it returns -ENOENT.

>
> >
> > >
> > >
> > > >                         list_del(&btf_mod->list);
> > > >                         if (btf_mod->sysfs_attr)
> > > >                                 sysfs_remove_bin_file(btf_kobj, btf=
_mod->sysfs_attr);
> > > > --
> > > > 2.52.0
> > > >
> > > >
> > >
