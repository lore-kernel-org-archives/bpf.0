Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E31E1C02
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334328; cv=pass; b=oW0hS4itNEtrBhO2npy2RD9XArVJOx9dbYqWeZVLn6pnSKOyLBBOclcou+RwGheq0U2wHRTs6wa/UH0xZc0NvyC1cWS6WDKI706FWDkNpEMUueFwYSfW12OI/WWnyictnhn1NjJmNYyWGId7nhjV0VZefYO8OWoE+JSZBK6jMLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334328; c=relaxed/simple;
	bh=h1kyu8M4L88XCUS9kAsxgjgw7U05l2ZMomlPo8dAfik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsFsKJgOX9Nq0mf9VkfwksBA5YbpKJpVVmqu96R0ByM/2V/btONhlcpP8JOaSpYdZnss/I8Do9ADjG1wcEfxLkRn+1Of98pNz/eq9BSWBJPVvcDuq2rssAvn+6s3KAtoGlpd5mexdtWd4NIPY/MtnlrKPs+UQ+uz7zj1NGDf5Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9k6Ma/b; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9k6Ma/b"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso705868a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 09:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773334326; cv=none;
        d=google.com; s=arc-20240605;
        b=KiFZFsiNf+4R8FWM40SckrAL7K1SR5M1eEgJaeyxtCwU+9uL0M1irwuiVgS7Z7V5jr
         4Liq2uEDePpGdiSN5QEpVOuP9SPn9MgrUMtdIjvKxTFgyj1ztNkeSpiby6ojXuPp1ZoM
         vyJZhnD3eQgXitHYyq3MsfWWwaEBhae85idGAnVqhCF9CT7BEsrcaAVViL2l6AGZQ1YS
         K7aLZSEFxnA6/aCDiiW9Rq8ptwgKvOkHCHKD6ai2yRMBIxoaV75yA7LnWvoHzw+KQ923
         KXlYiX20Qce93fd/JFG2/k6cMx9pCm1WK1BJp7nZjOpw+LDMv4zJQSSTTfCVHl4F2KEu
         wDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1YL2aIojcxVpPyoFH1sBjE+KhcQEXhixU2r1w5P2Bls=;
        fh=Vz3UGfnQjOUcPWlMqShElwOuZFQr6OfoX0HOBASPaI4=;
        b=cSrgBsUxx7sDPflsdIL5ttZx7P/Y722r7BkVnqmSnLWLA7GWKBFaTCShz6DZuwOzbR
         k0hVyTjUzUhPx+zvYi3h7StCyR87dNfhqfRgU+cepLsYSnv4tLPx1nTZdYyI8Rc/2mMJ
         zcEjW0E2jOcAGVQ8czH9EMBAkrPinOpx8ykiMqne5xjyfugHYzuqgjY3xLsbdI1ot49N
         Zuxc+wU7oFoTmfPMKVLZSywEM07Fcp+4RNSIEeUya3MroFyHCxSNnwtmDaq6v0eMHXUX
         2t3gXtOI6oSY9aMH/Hy1APKAykgpdO5m5yMLOswsGQG+eMELFGFWLVMm2RRLMXwmmZeb
         RGZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773334326; x=1773939126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YL2aIojcxVpPyoFH1sBjE+KhcQEXhixU2r1w5P2Bls=;
        b=B9k6Ma/bzu51D5Etl6PCSjZI+QQ7H2RPT3tqUppU2r4ddXSaueQBk9kt9n34u8OYfN
         s9Vo+Ood/e0dQ2xJHsiVrjfFm9/3VTFXmuK+a2p0ApEADDO2CARwPeZHivjiTAJTSgdA
         msxLIshjd++ZEzuIjGb0H0QDsYmS0XnK+1IaV6ZnBp9BPHcdx1vdvcm+2uttqH3mW+E1
         8ql1EgF3XMfLeWaoceou9pyBS97G5A3QtEZdODRnAzqutyRZkIDiaGUU1fibPvWS3/N1
         lnmEQi3Sa/KUutxpW3WU3qQhbNxZ4rbIt0Prf3xt+1+M45Bvl2JlaOsUGUjq4SwEUMGB
         ruMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334326; x=1773939126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1YL2aIojcxVpPyoFH1sBjE+KhcQEXhixU2r1w5P2Bls=;
        b=lp3Kl/r2DnQ7nvOOTuvGhIUavrBpUe/AdVueRpLfvbXUXXvZwJ5Ziz8m94RThuhMdR
         1W52HYD3hKNUvzON0nWtbRiRdSJ8uy3WK3CPP5es7S9oCenceC6rTfxRz0EzIDDXid2a
         W3Nu9DNjPn67RZEbsZcdiuBHC/dDl0PUjuTc8WiOwY+aXV3UwkwEEE7qz2y++PqAUQxS
         vkSm/UH/40nQwoG8P27Yj2B7MCEPOmD4b9C2fHVNGcinBQO1brzMjDZpumErFd4xo9ik
         DMv6K1wBn3gvl4Rv3KaEhXIIGHdronqu0dIW7hxfQimIzjmAUSSZPV4uw2KoYjM8kECz
         he4A==
X-Gm-Message-State: AOJu0Yy7R8zHpd+rWR04i7LiWvNuaE/Hr0k9ruuif4QGKoEQQzKdpCO0
	eUGX70NF5RlfCjndEXxLCaJ+XaHYKCp2/tTnt080/aza50/RMv9wzD4WiWwQtSY3zd9UfbFwT9e
	PLOIUd7aaMiwpQhLUlom8iUxOaYc99RXeKa88
X-Gm-Gg: ATEYQzwMv1eg0OJIpmeMVFpVaR0fBD1eEsUYBAmwuT5noxYneEn5h2FJ6IFE2HdzXqp
	/mQZ4xmI4rWewioMeiBr2eAJpyz08S1pHXX0Jw8Cmm2mugnw3wJxlxiOQqwH/8yoX+JkWKFlL6W
	hB2KSbVKgoNAVMVBNnPUHVFTfZ1vLrPZx2Pb1x5ouyinHH4tiAQs7fNSsimd1OkY0sTr3kNYRVA
	KMJlgsuD7o3d7aUhPWShaKVGgP9Up4lis1386m5BdobKA8nGjmaTRPO6QzQOzQNq/jU25fVXRt9
	aHARyTmH2PzpMr5jEiozKHA=
X-Received: by 2002:a17:90b:530c:b0:359:120f:d3aa with SMTP id
 98e67ed59e1d1-35a21ea2f3dmr282656a91.14.1773334326240; Thu, 12 Mar 2026
 09:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312002025.2495953-1-memxor@gmail.com> <CAEf4Bzb0mJsdP7vRwXiHYmqv5NogxPfOR1bFgFme9aKcQDvswA@mail.gmail.com>
 <CAP01T75aH9W8w3F7JP7yjtOFQsy+dc_2MMMSxSdQ-bM8aC2O7g@mail.gmail.com>
In-Reply-To: <CAP01T75aH9W8w3F7JP7yjtOFQsy+dc_2MMMSxSdQ-bM8aC2O7g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 09:51:53 -0700
X-Gm-Features: AaiRm520RnTx8vLIYFVJwXH8catU6M7srgmwFswswSndXw0BZany9cts5msstpM
Message-ID: <CAEf4BzZhV+vqXVBOLorkfwYiydHr+nNpe1Jso2UtVX8mTk+gzA@mail.gmail.com>
Subject: Re: [PATCH bpf v1] bpf: Release module BTF IDR before module unload
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>, 
	Gregory Bell <grbell@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 9:39=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 12 Mar 2026 at 17:22, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Wed, Mar 11, 2026 at 5:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Gregory reported in [0] that the global_map_resize test when run in
> > > repeatedly ends up failing during program load. This stems from the f=
act
> > > that BTF reference has not dropped to zero after the previous run's
> > > module is unloaded, and the older module's BTF is still discoverable =
and
> > > visible. Later, in libbpf, load_module_btfs() will find the ID for th=
is
> > > stale BTF, open its fd, and then it will be used during program load
> > > where later steps taking module reference using btf_try_get_module()
> > > fail since the underlying module for the BTF is gone.
> > >
> > > Logically, once a module is unloaded, it's associated BTF artifacts
> > > should become hidden. The BTF object inside the kernel may still rema=
in
> > > alive as long its reference counts are alive, but it should no longer=
 be
> > > discoverable.
> > >
> > > To fix this, let us call btf_free_id() from the MODULE_STATE_GOING ca=
se
> > > for the module unload to free the BTF associated IDR entry, and disab=
le
> > > its discovery once module unload returns to user space. If a race
> > > happens during unload, the outcome is non-deterministic anyway. Howev=
er,
> > > user space should be able to rely on the guarantee that once it has
> > > synchronously established a successful module unload, no more stale
> > > artifacts associated with this module can be obtained subsequently.
> > >
> > > Note that we must be careful to not invoke btf_free_id() in btf_put()
> > > when btf_is_module() is true now. There could be a window where the
> > > module unload drops a non-terminal reference, frees the IDR, but the
> > > same ID gets reused and the second unconditional btf_free_id() ends u=
p
> > > releasing an unrelated entry.
> >
> > what if we just check module_is_live() state for module BTFs during
> > GET_FD_BY_ID() operation and return -ENOENT? We already have
> > refcount_inc_not_zero(&btf->refcnt), it's just another "it's still
> > there, but not valid to be taken ahold by user space" condition
>
> We will need the module pointer to be able to do module_is_live(), but
> in this case the module is already gone.
> I was achieving the same thing in my first proposal, I didn't share
> the diff, but TL;DR was setting a bool in btf->module_unloaded and
> checking for it after refcount_inc_not_zero.
> Set btf->module_unloaded from MODULE_STATE_GOING.
>
> I don't have much of a preference for the above or the current diff.

The part I don't particularly like is that we have two different cases
when ID is removed, based on whether BTF is module BTF or not. What if
we add `btf->id =3D 0;` after idr_remove within spinlock area in
btf_free_id() and then call btf_Free_id() unconditionally both on
module unload and in normal btf_put path?

>
> >
> > >
> > > We can be sure that by the time we reach final btf_put() for
> > > btf_is_module() case, the btf_free_id() is already done, since the
> > > module itself holds the BTF reference, and it will call this function
> > > for the BTF before dropping its own reference.
> > >
> > >   [0]: https://lore.kernel.org/bpf/cover.1773170190.git.grbell@redhat=
.com
> > >
> > > Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
> > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > Reported-by: Gregory Bell <grbell@redhat.com>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/btf.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 4872d2a6c42d..c44fb9c9386f 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
> > >         refcount_inc(&btf->refcnt);
> > >  }
> > >
> > > +bool btf_is_module(const struct btf *btf);
> > > +
> > >  void btf_put(struct btf *btf)
> > >  {
> > >         if (btf && refcount_dec_and_test(&btf->refcnt)) {
> > > -               btf_free_id(btf);
> > > +               /*
> > > +                * IDR for module BTFs is freed when module's BTF ref=
erence is
> > > +                * dropped, which _will_ happen before the final put.
> > > +                */
> > > +               if (!btf_is_module(btf))
> > > +                       btf_free_id(btf);
> > >                 call_rcu(&btf->rcu, btf_free_rcu);
> > >         }
> > >  }
> > > @@ -8382,6 +8389,12 @@ static int btf_module_notify(struct notifier_b=
lock *nb, unsigned long op,
> > >                         if (btf_mod->module !=3D module)
> > >                                 continue;
> > >
> > > +                       /*
> > > +                        * For modules, we do the freeing of BTF IDR =
as soon as
> > > +                        * module goes away to disable BTF discovery,=
 since the
> > > +                        * btf_try_get_module() on such BTFs will fai=
l.
> > > +                        */
> > > +                       btf_free_id(btf_mod->btf);
> > >                         list_del(&btf_mod->list);
> > >                         if (btf_mod->sysfs_attr)
> > >                                 sysfs_remove_bin_file(btf_kobj, btf_m=
od->sysfs_attr);
> > > --
> > > 2.52.0
> > >
