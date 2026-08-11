Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799A3DB339
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484285; cv=pass; b=gVTP91575wLzqXUPoB/MPNBsfQN8vlWt7ryR25pzgcVteBPG01i2sOMFh074tIqDxsLhmydCE/wVB4zO+3yyOmBKWgqPW06seNlxWjnpCN9smK0vo7c+gmIxW5VlXjjk+f+WokAOxtxW6xoniPcAsMwHK2sinrtaPyzhZO/1KIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484285; c=relaxed/simple;
	bh=kQJpZ2LxciOVgNsyG0oOcBBWpjuJ/RktW+iJUDTkurA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jj+3a5zRyYHsTCfrGlU476rnFhHk3N8uoEbIWWeBzn639db6OBiMpiI2oCmln5zMnorTvq8E64X60itdAXG5fb9wy4WZU21ZNu2QB2I2UiRhJ+yyud758376XCuTHdfJ+Vb74+ckqRpqV9ETtgvM6A9OQEZmD3b09espHBK5CTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBp5sN1Z; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBp5sN1Z"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-669944f60b3so246812d50.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786484282; cv=none;
        d=google.com; s=arc-20260327;
        b=lSb+8MIA12+6qjTZz7/3u2Nw8gHOYa0ihVNknmdqMGAsMqjOLBpT08Z/Odnb4RgES5
         SjFmYhQJn6T73lrWy6J7SPWiqKJR9fFPzdmLMyxPH6jsG4v27BTe/IkbyV+1e38WbC/z
         VyfIvRbzYJGcpwujGJEl46KT+JXiE7W1jW3HTGs4HTHr6yDLGZ9fZ0bpcpUi1F1HAQSz
         xN9CYBLwnhCBAMyy9yOrCs3H9MipNHN+aVCcwN/RgrlbjHbPOfNgrsqLsNKonj4IfWPz
         l98ryDNqgrwdEP/9bNpQL1nrXWIDxEKeAEBAl8J/oMGGvcNj00rVocxmXkoQt9S5Iyr/
         D4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2IbqDq8BGgv2lk3IKTjhWJ3RsrCW4o60xvNtWDoJF08=;
        fh=KFuCT+lsuCBthncmPgCKNp8gBFIheQk8cxGC6Wnibas=;
        b=YtqiBo7RkE1yQuSxbM7hYqBJ34MvJkJ392G1+AQGmoAc4BlF1SsVbwB+tt9mkhLnc/
         LKCghP3Fp5HQ/Aq5p36J9XEMR+tVNQ9UM/j4+yBJRe2d9Vf7T3V0mniSo4qE53QZnkuT
         nEXlKhFPqPIiiry6hbK2m1LDLGligmXgYnN+g9I1VDPH+hYiGUBoVnuGhGla/ubKNs08
         h++gV3k+OgNfJ3qUllTei7Kw/N0wTcKp2YkBD6RAJZHKJeP/hFA+UAh5oA116GspRGew
         BxYmZdak5Kes9j/0oqoRqXVS0nMPGtKsjfxbvniRFrcHLblxwlpu3ZL58k/zwzly1PUY
         IKqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786484282; x=1787089082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2IbqDq8BGgv2lk3IKTjhWJ3RsrCW4o60xvNtWDoJF08=;
        b=YBp5sN1ZaUKO8OEiIV13F39VrLUMVgE3YTX9Nbu+mvALWPqvlWO8bcrdB9pr1c8xAO
         SwDD2SgRq+wITkOpShf9YCaB78S6LPlLBBYPJH4Ztgvy9CPPsBqGQL/tn2memdSMOW2Q
         Hu6F189woZZswkkgMBPxebUj7reYpxrUFxLZ9nHDunYQEEv7XqyX2a4oYw3aLki/GVci
         ZnpFpzKZ59qkYz3UwauwyzwKNIIaVCwp4NXozmQyMaeJwW6nVq9YA2juExqoezzx3Ntr
         BeotFnyRwkNC7oyx7eBbITpJ6kJHrkuk8VSeg/1s9racsAQ1AopIl6woQYvxmNbKyQXj
         CMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786484282; x=1787089082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IbqDq8BGgv2lk3IKTjhWJ3RsrCW4o60xvNtWDoJF08=;
        b=XICAA1TEDqrh9OHI/0nk22CcTsMZe/0LikpGOXWLccrTwbe3nxDN/3S5eLQJmGqOAg
         NP5Jagz/Dn2ufzQJfyxSoWdBJaEB0FdTv6wbRc9/6ll5iFdBqtg7GHYIM4ZpdkWKz9Pj
         yPSKuGrgpJMezpuF5/SJKP6TQ8YRTcMbDy/WrgyUbCR7jcDzadzJ/4bgeqcVuWdMZEyM
         kN4w+oZtH+rGtJ4r2BXFOGq+Jooj3YPnB9W+l8zzsWl0bCWfn4qTKiFwfUtSWhOdbHCj
         8AftrVU61qO/76e99H7JyEsAxaQEB6rTvzkgKdDTzww+vn3JItzHdGGgz14zi3PssNkg
         mbjA==
X-Gm-Message-State: AOJu0YzvB8ZTtsWBSfdNqt2o6djpBxdUuMTK2oGdckQENLJ3aY5Y5vco
	Vv/Snn6IFnbUfEg9CTnz6nG2skwCrU09D6Dzag5dc4c0YQkbvBGN4AOZerRchCUYdc2XT9qTrrT
	b9iCVdWu49OHYO3BqBujV8Kib3PgM2PI=
X-Gm-Gg: AR+sD10OPpdMjmpkJHVSGln30O17cfE1yV+sbALb6DtnsWJtEHXDo4kezNBzRhl8bvx
	LEE+Qs8k0oBndLlEDU/DQZlJ6G5vp87pLiELmGdYFUbgbkdpt3AUtCBF7+DVgk5nXn/XEgkRE2A
	MQLFgh03H0cjE7BQid/2IRqpq2w+Ar6v4Vw2Eq4yv8Vfjr2aVFK+QBp1s3aEgWSOlAjtlXs2p4D
	OSo4uLMLdHoUk5zVSUiSr2Lf978qIWqRWARBOEAb6+CGuO6mGuIRTp3jSzyXEBwwB0MyRa0n/VL
	6jGMw/W/TxiJBcpB9/rj9q52R791cxceW677cy+iYzM9
X-Received: by 2002:a53:c148:0:b0:668:d09:f354 with SMTP id
 956f58d0204a3-66b345ba1d9mr99815d50.50.1786484282326; Tue, 11 Aug 2026
 14:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-9-ameryhung@gmail.com>
 <DJXS2O9LFN5T.8BCWIJOB6N4M@etsalapatis.com>
In-Reply-To: <DJXS2O9LFN5T.8BCWIJOB6N4M@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 11 Aug 2026 14:37:51 -0700
X-Gm-Features: AUfX_my1PtitOvYVmAIz6f7TjlV4KeLtpQSene380p3dvpq5XY0TfBc2QnQqmZs
Message-ID: <CAMB2axO0dhqd71m+PGo51RbjFHsztD3=0B7sxg-aCSKg9j1C6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/15] bpf: Add a few bpf_cgroup_array_*
 helper functions
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 2:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> > From: Martin KaFai Lau <martin.lau@kernel.org>
> >
> > In the upcoming patch, the array can store a struct_ops map.
> > The array could have a cfi_stubs acting as a dummy instead of
> > the dummy_bpf_prog. The array logic will need to skip the cfi_stubs
> > also in order to support storing struct_ops map in the array.
> >
> > bpf_cgroup_array_length(), bpf_cgroup_array_copy_to_user(), and
> > bpf_cgroup_array_delete_safe_at() are added as a preparation work
> > to allow skipping the cfi_stubs in the upcoming patch. This patch
> > only skips the dummy_bpf_prog which is the same as the existing behavio=
r.
> > The current bpf_prog_array_*() callers are changed to call the new
> > bpf_cgroup_array_*(). This is a no-op change.
> >
> > Unlike bpf_prog_array_copy_to_user(), bpf_cgroup_array_copy_to_user()
> > does not need a temporary buffer. The cgroup caller already holds
> > cgroup_mutex and dereferences the effective array with
> > rcu_dereference_protected(), so it does not copy to userspace
> > from an RCU read-side critical section. Details in commit 0911287ce32b.
> >
> > Another addition is the bpf_cgroup_array_free(). This prepares
> > the array to have a different rcu gp for the struct_ops use case,
> > for example, a struct_ops could have mix of sleepable ops and
> > non-sleepable ops. In this patch, bpf_cgroup_array_free() only
> > goes through the regular rcu gp. This is a no-op change also.
> >
> > bpf_prog_dummy() is also added to return the global dummy_bpf_prog.
> >
> > bpf_cgroup_array_dummy() is added to decide the sentinel based on atype=
.
> > It now always returns bpf_prog_dummy(). In the upcoming patch,
> > it can return a cfi_stubs if the atype belongs to a struct_ops.
> >
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> One style issue below.
>
> > ---
> >  include/linux/bpf.h |  1 +
> >  kernel/bpf/cgroup.c | 79 +++++++++++++++++++++++++++++++++++++++------
> >  kernel/bpf/core.c   |  5 +++
> >  3 files changed, 76 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 047ffc029666..e371a4733135 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2561,6 +2561,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *ol=
d_array,
> >                       struct bpf_prog *include_prog,
> >                       u64 bpf_cookie,
> >                       struct bpf_prog_array **new_array);
> > +struct bpf_prog *bpf_prog_dummy(void);
> >
> >  struct bpf_run_ctx {};
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 7abbe12e108f..081d81de1816 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -319,6 +319,67 @@ static void bpf_cgroup_link_auto_detach(struct bpf=
_cgroup_link *link)
> >       link->cgroup =3D NULL;
> >  }
> >
> > +static void bpf_cgroup_array_free(struct bpf_prog_array *array)
> > +{
> > +     if (!array || array =3D=3D &bpf_empty_prog_array)
> > +             return;
> > +     kfree_rcu(array, rcu);
> > +}
> > +
> > +static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
> > +{
> > +     return bpf_prog_dummy();
> > +}
> > +
> > +static int bpf_cgroup_array_length(struct bpf_prog_array *array,
> > +                                enum cgroup_bpf_attach_type atype)
> > +{
> > +     struct bpf_prog_array_item *item;
> > +     int cnt =3D 0;
> > +
> > +     for (item =3D array->items; item->prog; item++)
> > +             if (item->prog !=3D bpf_cgroup_array_dummy(atype))
> > +                     cnt++;
>
> The outer parenthesis needs braces since its body is an if-statement.

Ack. I will add the braces.

[...]
