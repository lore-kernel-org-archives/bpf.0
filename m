Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2436402C
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616049; cv=pass; b=d3OgXAk5Q7QKmK6A8XMoWTqEzu7zDoCmFzar1GfzsfDdqZVW06mzXe5vPxSRcl4VxngNT0C6pv8wENI6uubu9oPityDVpJPGrkQDQC/+Iy/Qz+wsp1OvWoDS6bvOyL467uYclCMEf/9EWUAuv+IT9deomVvINDhCmzW98InnLH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616049; c=relaxed/simple;
	bh=1RyQFe5Kyzeix//rrB/0IQlX2ISLVCSrxyigLQrsTEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMNsra/GaEnXjqSUXs0SUjERKir1Mhr3yfaHWUDbkLjSjTtY5MwQvspNJ7eUe4kK3WErL8qHvRKButCUv0sRymHfWwgr0yC2b76kwzBh/oH0ahWF65ZmcMvOLJkMx/BTiyhI3D8c15Rry5V+203kFcdZnIOmR23AjkNjmTjRcd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S58lX8s6; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S58lX8s6"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65006c99d38so6266740d50.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 19:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775616047; cv=none;
        d=google.com; s=arc-20240605;
        b=bA1QHCVAJmAoEh3ddQ5DDlg7ZZ8OQ86kCc48bThFUxwKe1fTN9gZvKi0Yh/01UFnFM
         bWxd0mDXP60MijGLLhb4FPFwtgg7rfNWPvTYvK/oMOdBUYt/03cr7IwO2SV/KN5gICus
         GCpIpcFoRs3vDON8uTdGBt3LZSIAuyolDpgvNiz2OxRXhcrCB55Epvib33EbYcxxdRP2
         qBxaQ5BBeJn3xXJFOGFl6es7PYyTzS3/t1e/X9hgtz0IqKRG75s9NVxTzI7Az/+q3Nar
         8gT8QP1WiKAnAjEkkL2RNclIZ9gg+SyK0GyBcU/aVzUOv/nEJVF1DGViLwwAo0fJmnBp
         dMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qMla8O/aLGNk5svT1tXJvXj3U+9GiIyir/xJirV0hvA=;
        fh=ZFxhyXHHwY6fR7y6UaJ9Q3qbAAdYKiuNmQBQ2rgIPUY=;
        b=URGMBH1RwNrLZR8gYNjKDkoxlf00CulHFAHvegl0LAV+BtKCYWIL3kFiJISNME0/U7
         gi5k2oWnjg+X2uk01ahITjX+BRuiwX8adUblDTBfVX7HDgrg2pCjcA0R4eIvwlTSw6ab
         HzKwCglV3qgVh6qQbT05zOMKUq6CXj3K2sTgHxjcvEMw2l1qZQST/hp5757WQEJdDf/y
         /rKo0h0Bsz9SAqM3+oRCpabIievT5IvmaxE/uwONX8lnjZ6iHKEhy0bNVRSyj+e+8yAq
         3iXXYuGa0z32MLTCES62TffrSCT8l6j89gsJq9AhFdnz8S2w9ZGEt0eYJqT2KwEqiYus
         ToWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775616047; x=1776220847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMla8O/aLGNk5svT1tXJvXj3U+9GiIyir/xJirV0hvA=;
        b=S58lX8s6GMmk/m+IgTGP/tgOM8bwQdF1b5yrC63U9nl+/HslKU2TrJy2w+HFjuIKig
         zXdYBcvWYR/gM93f//29cWRRPZTSUxKcaB4dS470r2NXElmsUonVXn8yknDDg3d9mVyD
         +dVIB9IXGAQ6ANxa7CCMkX+raXiwGiCfIgACBsbOTwMMD6h0ibZVe2+8EcBFLbJIx3sb
         lqMvrONqSvB8FuWkMYOCWfUccZ63gloZfyIHP8NDb+WqGNt9z2j0WFzF3GBEyAeU4HLv
         sE+rxwd0P5PbqUgnSlwEJmP5RDhwT8TaQOeosxtxqmMi5+oXfQO8ZW5s9tXlP9UJlCSn
         4Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775616047; x=1776220847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qMla8O/aLGNk5svT1tXJvXj3U+9GiIyir/xJirV0hvA=;
        b=E/5PQzqqrd4z8/RkWQxc4/I5V3wiu1LCUCtD+5FMyvrH8uJX20eEE+dxwmFA8mL9Ke
         B32AUr0bIoAJ5akuPA14XjQ/Bb/RyMwE5A0vKK/vsRTOBex+9GJ4gKlP6FtkXkAj57rv
         Ts5RYa4PF1SAUaNdzEX5+sfHnugXfKuH9VJqJwHV2G1l8c7HpOrQlug+DfzDdL0heelE
         tv2J8lOZ5L8FaucBT2hnaADvwPc7GKP0SxbIa7KPRF5QOL97z5s1KPCUB9HPwBghHaHj
         IQdspXag3R9soc05F6vBBSKFDCgMBhfXUqYPm7grf18KN4e/6XEJmKRU8EHivgDOTAvs
         q45Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVd1djMP0OQw92OnqAJLFGjoBRkwy/By3QlwG2f/tx+jHa+LYeYFNgmE5OXSRjs19Yt6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFVCM081Er4fmjkiceigLPTxN2nf3323FUCQoHyiutGj0SuyG
	0nJTsPEV9q58nu03mkp+rwlh9QtlEuthZt977hH3P6rjyWYHgektG6agaC3Vz85YzMiv3rl/3HA
	NXdyZmJ9Y8xw0j+GwTpyqbTbMF6wjgDM=
X-Gm-Gg: AeBDies+o6GNdeCdz0yGifdA/Vjzbf6+vzGq6wnU2yHAlswuMl3x5+KyDFOQzfqJq6j
	7Zp99cy9JpbI6X8oUPcbLAftxG2fJQX3O0WQA5MN06Jf92GJcBotP6yaUsAqZltZuFwFYPZm1CV
	N5YJWas3i6nDWL6aHD/ZhLR4wmFeirfDrz5ZeJupTkLW2DovrvGB5htR+ak/LuY3sWe3P76M2r3
	SFlWYQcxucNR3N1QGFXvhBoTu4ifuMTbsU726j+kqo6yAYSmBgm7gZ91CvOsS8K880swXFcKpo6
	QLpPhSx3WFnt47MsQENFU4ZKWaxFEl7aP4rc8gnEtiIDVQnjn24=
X-Received: by 2002:a05:690e:128c:b0:650:747d:f70f with SMTP id
 956f58d0204a3-650747df9a4mr7606277d50.66.1775616047269; Tue, 07 Apr 2026
 19:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-4-laoar.shao@gmail.com> <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
 <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
 <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
 <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com> <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com> <adUd0Mojbtrwmeod@pathway.suse.cz>
In-Reply-To: <adUd0Mojbtrwmeod@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 8 Apr 2026 10:40:10 +0800
X-Gm-Features: AQROBzD7OzdJXLVqfJs5CVSyjbxMY4IuVSSuRahFgmBMCr0BGFPcLQcyfxn3E20
Message-ID: <CALOAHbDG9mq1iJv5suct=cqJ+2r8VvJ-dXN=nuvMw0XYqnUjxA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Petr Mladek <pmladek@suse.com>
Cc: Song Liu <song@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 11:08=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Tue 2026-04-07 17:45:31, Yafang Shao wrote:
> > On Tue, Apr 7, 2026 at 11:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Tue, Apr 7, 2026 at 10:54=E2=80=AFAM Song Liu <song@kernel.org> wr=
ote:
> > > >
> > > > On Mon, Apr 6, 2026 at 2:12=E2=80=AFPM Joe Lawrence <joe.lawrence@r=
edhat.com> wrote:
> > > > [...]
> > > > > > > > - The regular livepatches are cumulative, have the replace =
flag; and
> > > > > > > >   are replaceable.
> > > > > > > > - The occasional "off-band" livepatches do not have the rep=
lace flag,
> > > > > > > >   and are not replaceable.
> > > > > > > >
> > > > > > > > With this setup, for systems with off-band livepatches load=
ed, we can
> > > > > > > > still release a cumulative livepatch to replace the previou=
s cumulative
> > > > > > > > livepatch. Is this the expected use case?
> > > > > > >
> > > > > > > That matches our expected use case.
> > > > > >
> > > > > > If we really want to serve use cases like this, I think we can =
introduce
> > > > > > some replace tag concept: Each livepatch will have a tag, u32 n=
umber.
> > > > > > Newly loaded livepatch will only replace existing livepatch wit=
h the
> > > > > > same tag. We can even reuse the existing "bool replace" in klp_=
patch,
> > > > > > and make it u32: replace=3D0 means no replace; replace > 0 are =
the
> > > > > > replace tag.
> > > > > >
> > > > > > For current users of cumulative patches, all the livepatch will=
 have the
> > > > > > same tag, say 1. For your use case, you can assign each user a
> > > > > > unique tag. Then all these users can do atomic upgrades of thei=
r
> > > > > > own livepatches.
> > > > > >
> > > > > > We may also need to check whether two livepatches of different =
tags
> > > > > > touch the same kernel function. When that happens, the later
> > > > > > livepatch should fail to load.
>
> I still think how to make the hybrid mode more secure:
>
>     + The isolated sets of livepatched functions look like a good rule.
>     + What about isolating the shadow variables/states as well?

We might consider extending the klp_shadow_* API to support the new
livepatch tag.

>
> > > That sounds like a viable solution. I'll look into it and see how we
> > > can implement it.
> >
> > Does the following change look good to you ?
> >
> > Subject: [PATCH] livepatch: Support scoped atomic replace using replace=
 tags
> >
> > Extend the replace attribute from a boolean to a u32 to act as a replac=
e
> > tag. This introduces the following semantics:
> >
> >   replace =3D 0: Atomic replace is disabled. However, this patch remain=
s
> >                eligible to be superseded by others.
> >   replace > 0: Enables tagged replace (default is 1). A newly loaded
> >                livepatch will only replace existing patches that share =
the
> >                same tag.
> >
> > To maintain backward compatibility, a patch with replace =3D=3D 0 does =
not
> > trigger an outgoing atomic replace, but remains eligible to be supersed=
ed
> > by any incoming patch with a valid replace tag.
> >
> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index ba9e3988c07c..417c67a17b99 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -123,7 +123,11 @@ struct klp_state {
> >   * @mod:       reference to the live patch module
> >   * @objs:      object entries for kernel objects to be patched
> >   * @states:    system states that can get modified
> > - * @replace:   replace all actively used patches
> > + * @replace:   replace tag:
> > + *             =3D 0: Atomic replace is disabled; however, this patch =
remains
> > + *                  eligible to be superseded by others.
>
> This is weird semantic. Which livepatch tag would be allowed to
> supersede it, please?
>
> Do we still need this category?

It can be superseded by any livepatch that has a non-zero tag set.

This ensures backward compatibility: while a non-atomic-replace
livepatch can be superseded by an atomic-replace one, the reverse is
not permitted=E2=80=94an atomic-replace livepatch cannot be superseded by a
non-atomic one.

>
> > + *             > 0: Atomic replace is enabled. Only existing patches w=
ith a
> > + *                  matching replace tag will be superseded.
> >   * @list:      list node for global list of actively used patches
> >   * @kobj:      kobject for sysfs resources
> >   * @obj_list:  dynamic list of the object entries
> > @@ -137,7 +141,7 @@ struct klp_patch {
> >         struct module *mod;
> >         struct klp_object *objs;
> >         struct klp_state *states;
> > -       bool replace;
> > +       unsigned int replace;
>
> This already breaks the backward compatibility

It doesn't break backward compatibility.

> by changing the type
> and semantic of this field. I would also change the name to better
> match the new semantic. What about using:
>
>
>   * @replace_set: Livepatch using the same @replace_set will get
>                 atomically replaced, see also conflicts[*].
>
>         unsigned int replace_set;
>
> [*] A livepatch module, livepatching an already livepatches function,
>     can be loaded only when it has the same @replace_set number.
>
>     By other words, two livepatches conflict when they have a different
>     @replace_set number and have at least one livepatched version
>     in common.

Renaming it to @replace_set makes sense to me.

>
> >
> >         /* internal */
> >         struct list_head list;
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 28d15ba58a26..e4e5c03b0724 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -793,6 +793,8 @@ void klp_free_replaced_patches_async(struct
> > klp_patch *new_patch)
> >         klp_for_each_patch_safe(old_patch, tmp_patch) {
> >                 if (old_patch =3D=3D new_patch)
> >                         return;
> > +               if (old_patch->replace && old_patch->replace !=3D
> > new_patch->replace)
> > +                       continue;
> >                 klp_free_patch_async(old_patch);
> >         }
> >  }
> > @@ -1194,6 +1196,8 @@ void klp_unpatch_replaced_patches(struct
> > klp_patch *new_patch)
> >         klp_for_each_patch(old_patch) {
> >                 if (old_patch =3D=3D new_patch)
> >                         return;
> > +               if (old_patch->replace && old_patch->replace !=3D
> > new_patch->replace)
> > +                       continue;
> >
> >                 old_patch->enabled =3D false;
> >                 klp_unpatch_objects(old_patch);
>
> This handles only the freeing part. More changes will be
> necessary:
>
>    + klp_is_patch_compatible() must check also conflicts
>      between livepatches with different @replace_set.
>      The conflicts might be in the lists of:
>
>         + livepatched functions
>         + state IDs (aka callbacks and shadow variables IDs)
>
>    + klp_add_nops() must skip livepatches with another @replace_set
>
>    + klp_unpatch_replaced_patches() should unpatch only
>      patches with the same @replace_set

I appreciate the guidance on this.

>
> Finally, we would need to update existing selftests
> plus add new selftests.
>
> It is possible that I have missed something.
>
> Anyway, you should wait for more feedback before you do too much
> coding, especially the selftests are not needed at RFC stage.

Sure.

--=20
Regards
Yafang
