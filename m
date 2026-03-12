Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27738C43F
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333593; cv=pass; b=g6Yp1bilC9faxLj2yJh6IIUWg4tijklk/nqfRRxgpfmDawasxl3tWygTGQPZf2UNrsMkp4uDXrxYfmT8QAWOMUHrg86O9qvBS12OA2mAO/r1u1tNqmpNalfB+6Ioh30Mt+MkOb0re+PqOE7Fg4jlcHiM79qAuWwGk6JmV7jpDNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333593; c=relaxed/simple;
	bh=7lMSHgGTT/H/lDfmT8wqmFKJQw4gi8tCAVW6FTRslNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPwqzeVRD3LR1RMTqzsmLtkI4LsERbJr5eleXaniGXD8QlHmMql/5yhoQO+v4kQxW1ypoFDF6Zz4h2tlJCc3UUMgUCi6C0JfnfkCPRj5pgUxeJK3cO0s9021mY4HPVlrVrNsu6HqyJeax/m++IeEy//ehj3jhphV0aqG6NL6c48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POzk/fNL; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POzk/fNL"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-439b2965d4bso966232f8f.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 09:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773333590; cv=none;
        d=google.com; s=arc-20240605;
        b=ZSrmq6yMHsvKQTt5zxuw6xKBRU7GsM44Hpm1yHep5vlv7/Xl/fQIL76uXDWkYHAPG6
         B2WEdru+CZVdLV2nSDBR7QHHx2P+RR9FBN+G7HIcoHZFlvXM62BuBNF2g58qegWreOcI
         l/j/L0ZQGopa7BYDmVmB0ivBPC/AP8iJcFuHi42j+232/UcUYMHbccChEY50NbjGSJ7k
         JhMO2EhF6bgJ8iE2nhbG/i0GSPRJUwUBr8SwN/yqo34/5mE/aXIMV93aypT29zprSroa
         eBAEmcPO3g7OIbxCVBxqrdNpxq/J7FgcWElrGj6hyy84Qwr/VCbxezx0BB6ac7VTzoIO
         BMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q2Hx/Hnm78BwKed5l6bOEqN7ic8Hzr2a3+/Kwg8GRDU=;
        fh=hxrShpmaur/16Kub1ssLqCovsUzyzDxDYrPiQXcJkNI=;
        b=JC06y1ugmFfrOvAiDmbQ415AGo7BhrpqdBwM86dCU2QmEyb0OkSI3DU+x12RqIevjn
         FNpyuhMT27eWhSV8UOnXNksBqRsF0ddXfmpIz+B1x5f4Sv7NMh+2qAWi8/vhsN1kZH+I
         8QpvImWSpCwqw5YaI3rdyunxEa381mE1Z6LKuVaXjw0UAH3r8/36Xnr+QfaOrYZ/ah+a
         /1keOjid0uUYfRYQKOT7Qn1jsH4GFQU6XUDq0buux1u/+pIa8DIrv4aTMKiYV9r0MP8f
         qJCHFzRvQva5/kfWL9aidZK4PcngvnDvvCHUc9EgUJpj6m75NikNlyVt2QYvgCtTFye/
         aVsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773333590; x=1773938390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2Hx/Hnm78BwKed5l6bOEqN7ic8Hzr2a3+/Kwg8GRDU=;
        b=POzk/fNLlX+ZfKlzfAJovgnP6c407IG6vxgrNYf/DdY6QivXYPf2xLJsoa8S1ciCka
         9KqVHbwpauguJY24h6+Ay5ROLqPNXrVZaWvzvk05EJwgk+sgZzitxbU4fhPfgGe5S3Kt
         5NU/ThSZgnf5EB6ZEMLUXKps66zSjSl11q6FN0VxAmRPQovLhfB0rRU2LWlcwR9qbggC
         zDtRgE/TcHwZtV3I538OPm1fBiAuRZd8EI0e/J7bi/xpbJM94cXySk9a+bVmyOz07qtw
         pb28GWkaKdEajGBTaxzENyXqvQwiIVxF3emd9SEhF/y/Gzs+2LS9VgsqaCed2MvHHkE/
         EPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773333590; x=1773938390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q2Hx/Hnm78BwKed5l6bOEqN7ic8Hzr2a3+/Kwg8GRDU=;
        b=tx49xRtgQZmRHuCoQFOV9wDyse3XHVGlTWzB35/RciKIwcRPvgdYuyvTCBKvYuWIeu
         sWtkpGXz43Z3O8K1/z6AuUzgcnnPgHg0y+cpmqip8Z7HdhKYapABCtJW/5AgJ56SM0f/
         AKg8Ty+H/FYB/rebcCuLrWetuAVd8EoFdZVIQKk9vA267EkCI2+zU75a9+cwGLrAhWol
         I9RiKSv1enONhc9LpHMFxDYTXtPkRk7XwO1LUW5X/r0h5YO1NdfnnRcJi65kd0UTDftB
         pDegAvqEifWHg6vennlixf7oCYpxkJL4TE2f7kKXn6LOmKC5UAkKfrRb6wmjnyCw2P3X
         7T9w==
X-Gm-Message-State: AOJu0YzdozSudit7NW96Y2Xrbz7p0vgzYZYMyZPi/gnb8AU6PyfoVxL9
	qqnvqzhhBMtaCwi+DUnaHR5hMwOAuucLa2lWvMgr53c9d75halIsMuN5sRTvk6BcH/ziqD4JH8r
	qMjBy3KDd+MLE6Knt/FvGaDlZqgMJnFah+mAIpcrbNQ==
X-Gm-Gg: ATEYQzyP3K97VIxO39y9UoHT9B+hnj76bvcA2loRhpa9x9QZwR+PW21v1kSkimcmdnS
	rvzyF92yVizFLUuvMxiEMga+YpLMxNsbgiL8i2R7OEj+jJ5mS3st7LDoL3rwpTH6v6xNLFDgrNb
	tFeO4qaYLY6K7niATSjQepfYAnzqjrGEltSfsRMAGA53wjzRD7zaM1M5+NWatP0Z92XRAN+VwRp
	jhaJahS7JHS1Nir6V+aIbrO0y0l0Xti+rbYHhOeyxQjIVof8AD9+cIz+YwqdwAsMN/okGi/9Y2b
	aDV6Px4ZZM7cuP4Yyliyg6ByWcmVWFMP7Y6myNX0Fv9vcY49HsEw+Usb5M1c13A5Lg4xxJc=
X-Received: by 2002:a05:6000:200d:b0:439:c3d1:a399 with SMTP id
 ffacd0b85a97d-43a04d897e7mr613016f8f.21.1773333590183; Thu, 12 Mar 2026
 09:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312002025.2495953-1-memxor@gmail.com> <CAEf4Bzb0mJsdP7vRwXiHYmqv5NogxPfOR1bFgFme9aKcQDvswA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb0mJsdP7vRwXiHYmqv5NogxPfOR1bFgFme9aKcQDvswA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 12 Mar 2026 17:39:13 +0100
X-Gm-Features: AaiRm50RWWUjCNdkpK3ZmBiGsiNaQOpoXiNK8BxOQwX6Z_eRvvUTGVlUmg2NYz0
Message-ID: <CAP01T75aH9W8w3F7JP7yjtOFQsy+dc_2MMMSxSdQ-bM8aC2O7g@mail.gmail.com>
Subject: Re: [PATCH bpf v1] bpf: Release module BTF IDR before module unload
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>, 
	Gregory Bell <grbell@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2026 at 17:22, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Wed, Mar 11, 2026 at 5:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Gregory reported in [0] that the global_map_resize test when run in
> > repeatedly ends up failing during program load. This stems from the fac=
t
> > that BTF reference has not dropped to zero after the previous run's
> > module is unloaded, and the older module's BTF is still discoverable an=
d
> > visible. Later, in libbpf, load_module_btfs() will find the ID for this
> > stale BTF, open its fd, and then it will be used during program load
> > where later steps taking module reference using btf_try_get_module()
> > fail since the underlying module for the BTF is gone.
> >
> > Logically, once a module is unloaded, it's associated BTF artifacts
> > should become hidden. The BTF object inside the kernel may still remain
> > alive as long its reference counts are alive, but it should no longer b=
e
> > discoverable.
> >
> > To fix this, let us call btf_free_id() from the MODULE_STATE_GOING case
> > for the module unload to free the BTF associated IDR entry, and disable
> > its discovery once module unload returns to user space. If a race
> > happens during unload, the outcome is non-deterministic anyway. However=
,
> > user space should be able to rely on the guarantee that once it has
> > synchronously established a successful module unload, no more stale
> > artifacts associated with this module can be obtained subsequently.
> >
> > Note that we must be careful to not invoke btf_free_id() in btf_put()
> > when btf_is_module() is true now. There could be a window where the
> > module unload drops a non-terminal reference, frees the IDR, but the
> > same ID gets reused and the second unconditional btf_free_id() ends up
> > releasing an unrelated entry.
>
> what if we just check module_is_live() state for module BTFs during
> GET_FD_BY_ID() operation and return -ENOENT? We already have
> refcount_inc_not_zero(&btf->refcnt), it's just another "it's still
> there, but not valid to be taken ahold by user space" condition

We will need the module pointer to be able to do module_is_live(), but
in this case the module is already gone.
I was achieving the same thing in my first proposal, I didn't share
the diff, but TL;DR was setting a bool in btf->module_unloaded and
checking for it after refcount_inc_not_zero.
Set btf->module_unloaded from MODULE_STATE_GOING.

I don't have much of a preference for the above or the current diff.

>
> >
> > We can be sure that by the time we reach final btf_put() for
> > btf_is_module() case, the btf_free_id() is already done, since the
> > module itself holds the BTF reference, and it will call this function
> > for the BTF before dropping its own reference.
> >
> >   [0]: https://lore.kernel.org/bpf/cover.1773170190.git.grbell@redhat.c=
om
> >
> > Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Reported-by: Gregory Bell <grbell@redhat.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 4872d2a6c42d..c44fb9c9386f 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
> >         refcount_inc(&btf->refcnt);
> >  }
> >
> > +bool btf_is_module(const struct btf *btf);
> > +
> >  void btf_put(struct btf *btf)
> >  {
> >         if (btf && refcount_dec_and_test(&btf->refcnt)) {
> > -               btf_free_id(btf);
> > +               /*
> > +                * IDR for module BTFs is freed when module's BTF refer=
ence is
> > +                * dropped, which _will_ happen before the final put.
> > +                */
> > +               if (!btf_is_module(btf))
> > +                       btf_free_id(btf);
> >                 call_rcu(&btf->rcu, btf_free_rcu);
> >         }
> >  }
> > @@ -8382,6 +8389,12 @@ static int btf_module_notify(struct notifier_blo=
ck *nb, unsigned long op,
> >                         if (btf_mod->module !=3D module)
> >                                 continue;
> >
> > +                       /*
> > +                        * For modules, we do the freeing of BTF IDR as=
 soon as
> > +                        * module goes away to disable BTF discovery, s=
ince the
> > +                        * btf_try_get_module() on such BTFs will fail.
> > +                        */
> > +                       btf_free_id(btf_mod->btf);
> >                         list_del(&btf_mod->list);
> >                         if (btf_mod->sysfs_attr)
> >                                 sysfs_remove_bin_file(btf_kobj, btf_mod=
->sysfs_attr);
> > --
> > 2.52.0
> >
