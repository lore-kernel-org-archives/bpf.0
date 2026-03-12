Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BBE3815C8
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347855; cv=pass; b=kogZWMZ/24NKUb8hPPYF4SQz7m+0PmuDsUXQr0bxrkOaD4J3poE3znC8kAd8293GQWK1MWDGMbrAg9SOWDdUzMGXR9kP/omRP4R83gDCUpGtHYvUjsbJyTL/r8qT6f4gopQkgQI1l6ujo9Ugfg98dDs3zjNXiiaKcFAwqIq5Vn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347855; c=relaxed/simple;
	bh=+OHM0B8fVkT3x2ANGyu30fC+Qp11Ch2ajUhX7qZOIeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9W3oyBbVYati1VhdGzF8T1zfEEuaHgewrUwP/BrTEE4S7fGaEP6JsdSTXc9UEePN6u4j1VfjR7zXmpVH/QahICkknS9ext2ZP6vaLqMNIYBOKYf20ks92Ec7XYJw3CA64hSA+gztRqbT8DuJZCW9XJDAb7eK3aWTgoUaWS0H5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5ExNZ/q; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5ExNZ/q"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so1419509b3a.3
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 13:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773347854; cv=none;
        d=google.com; s=arc-20240605;
        b=ZSLwYcBfX8Km3N1xcfPkqz5N1w9k9Ap6ySzTEjYZnt0TraA+v0gpwzi3Wu2EzcyR5T
         58rkl6FvDLPpk2K9wW543jAhKzek1rS4BSx9EWccAJJTJg+7H2jEPznv8dcMyZdsw4Dv
         aCP2meqgQ+eswZI5Og8ckHWBUV3+zUKKGuZnrEEN1dPBzPQY7Z0jnS116O/QPSPW4++J
         Pi+ghzAY1lC5+POmsh25qgPzI5/0AcFx8ALFmYe1bU1YPyZ7P2a/JLSVInL4wcM7AMaQ
         ouhxS371bD1hDWdnD2CbXbJpMvTMrWF1g8kPq+xATi7UDf53g2wKgh2hXyxoFYPBeMs6
         xTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3lJItdyMpwBQLqiGMVrL9y5NeGEPhdwIwSQXLuHkG0M=;
        fh=5s5QIkm4LzB5BaPIrMh8OZiTvayviaB9fb0uMglWSHo=;
        b=a4jDUDBETbhst5yyb/iGjh/pMrIesQwenm2rTaHJW7RuUBywrN+1u1ZNojDIVQmMAJ
         yaR1rm6g46dhu9/uRi7ctjOpESk+o+A0ghcMWDb9tZwUL5Vmo9iKYvhZRQ8hzOeahGjM
         FYil+sYT4wZEMjkX/jNs8ZLdqxHuS2gQDvUnPlOVnB+oTB8BnRsjWcRS+IHGNrC1uUS+
         g8O9cKOdhjawtNN0vJ3zEic6qb/zLyVvDOWEzCqNCmPW9FWCGhE62HJyc5raJK4CTUCd
         QQEUK3hhhS3/BwGmtdg2abiJeV9ngwrMjZ4aI5nC7bLwlNw8W/oqiRTKVrtfFjj40s+N
         KC2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773347854; x=1773952654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lJItdyMpwBQLqiGMVrL9y5NeGEPhdwIwSQXLuHkG0M=;
        b=U5ExNZ/qBQHivH28OhVpC5N7BpB/2+N6HKRT+cxmQDtrF34HBfbRif5D4WMHWkNJK6
         +1++Oqz8wyTNLdBUoVcvAVOY3X+ecivvX9Q2bPn/4w+odE9m3sWKjtbflkkat4Q6MCQH
         D/5Z2PJuKZspG1iTUK4czQTFL7BbwF35wWqQEHoat5meeuiisA57JBFYqJV03bQ9PdoA
         4+s12hcvu+o31lGPPIP0XL3WaZxqBWf4DtnJC9D4gnYOf/6Uzwu53y+PGnwWkE5zyIo8
         IycqUjTc5lOkOMOuWmNpHF3pAZcgG0d7xe0UWBRikrdzYuvdeiEEAAAsef69fUHZQhEs
         hQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773347854; x=1773952654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3lJItdyMpwBQLqiGMVrL9y5NeGEPhdwIwSQXLuHkG0M=;
        b=HGq3A7GhMJ7zVKmY+fMC/dOcjRk4uIkhkL5oCcRHuArVjPO/T0izVUrs8d2wblAHWd
         j1CCtdFnFoxPO05WbpGjCGeIIyO5uTLbTcuFGL+BseHLmlVWYH0Zo+9OJyaO56G/o9q+
         sh7R6GrJzWOIyuHG7PLB0vg/DgNLEBuwpMet/LKAksqzxloFG3v0j5WwmBnchMlQaQq6
         YcUQSuPUprVp8ubO1BSS/yS62CmlXvmAdoM51Lr0LjoHmkvJM0NtqADyrRUr+hQNPe/S
         Yj3hZutioTasNsZu447Lze06bEga11ou9CIKM7uZAWMhpohBdKnBlyOePV1ti2WVNNgz
         GOjw==
X-Gm-Message-State: AOJu0YxKse3dfuDv2tlvzWIW9gjHiz4kacPLxqWYnJDu3QsiTGdwvXgU
	zSi1QcwNnKSwhBaDSzgp1l2YPbx+SYXXjQBPHL6RZ7Gh8joXPsckJWuO2jW+ALhDdbBwCfeBpoj
	t+5rcLxIA3dUe29ZtuLrx1zpwfRYNIT0=
X-Gm-Gg: ATEYQzxLFP3i84PlwBk376TzFzIWD8Kt1TcqbOScBHFNAzTu9+aeitryOAjz3A40SM1
	G4LOmMO3t81EkStAqp33o5GezIG7OB0iRrzEZUkmxXCl8oU14MD7oIYYW+5bF1pqXE/68Zwf3vw
	0nHk8jXSpWcMjryYAjU64jktmUtUCb/G01XBKZnjz4FBr4GpPYOPeELY4cGBiD9SDf8Zl2KXl6y
	AMn7/k66vKhLb6N1i9JLfMf7o2hjTrL7qRaSzy0FClpiA5Sr9Qq14hDh/lQkIEICLp2wCP+hUFd
	EtyvHgUK3f7EdQcDjp/jeGMIDcucrpEL4A==
X-Received: by 2002:a05:6a00:9295:b0:829:af4a:5eb5 with SMTP id
 d2e1a72fcca58-82a196d34d8mr682738b3a.3.1773347853683; Thu, 12 Mar 2026
 13:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312180643.3806586-1-memxor@gmail.com>
In-Reply-To: <20260312180643.3806586-1-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 13:37:21 -0700
X-Gm-Features: AaiRm53lXM1nmKaEql5w5Qd0M-MbC-NXYYqAGDLU7BLy_RpThG9y6mVTSbNrQZE
Message-ID: <CAEf4Bzb89jDcmcArtc6i+0dNqhZ4V6NZQZwyvO=hOHUA32o7=Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Release module BTF IDR before module unload
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>, 
	Gregory Bell <grbell@redhat.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 11:06=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Gregory reported in [0] that the global_map_resize test when run in
> repeatedly ends up failing during program load. This stems from the fact
> that BTF reference has not dropped to zero after the previous run's
> module is unloaded, and the older module's BTF is still discoverable and
> visible. Later, in libbpf, load_module_btfs() will find the ID for this
> stale BTF, open its fd, and then it will be used during program load
> where later steps taking module reference using btf_try_get_module()
> fail since the underlying module for the BTF is gone.
>
> Logically, once a module is unloaded, it's associated BTF artifacts
> should become hidden. The BTF object inside the kernel may still remain
> alive as long its reference counts are alive, but it should no longer be
> discoverable.
>
> To fix this, let us call btf_free_id() from the MODULE_STATE_GOING case
> for the module unload to free the BTF associated IDR entry, and disable
> its discovery once module unload returns to user space. If a race
> happens during unload, the outcome is non-deterministic anyway. However,
> user space should be able to rely on the guarantee that once it has
> synchronously established a successful module unload, no more stale
> artifacts associated with this module can be obtained subsequently.
>
> Note that we must be careful to not invoke btf_free_id() in btf_put()
> when btf_is_module() is true now. There could be a window where the
> module unload drops a non-terminal reference, frees the IDR, but the
> same ID gets reused and the second unconditional btf_free_id() ends up
> releasing an unrelated entry.
>
> To avoid a special case for btf_is_module() case, set btf->id to zero to
> make btf_free_id() idempotent, such that we can unconditionally invoke it
> from btf_put(), and also from the MODULE_STATE_GOING case. Since zero is
> an invalid IDR, the idr_remove() should be a noop.
>
> Note that we can be sure that by the time we reach final btf_put() for
> btf_is_module() case, the btf_free_id() is already done, since the
> module itself holds the BTF reference, and it will call this function
> for the BTF before dropping its own reference.
>
>   [0]: https://lore.kernel.org/bpf/cover.1773170190.git.grbell@redhat.com
>
> Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Reported-by: Gregory Bell <grbell@redhat.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> Changelog:
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20260312002025.2495953-1-memxor@gmail.com
>
>  * Remove special case from btf_free_id(), and call it unconditionally. (=
Alexei)
> ---
>  kernel/bpf/btf.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4872d2a6c42d..d08ae973df69 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1788,6 +1788,13 @@ static void btf_free_id(struct btf *btf)
>          */
>         spin_lock_irqsave(&btf_idr_lock, flags);

I'dd add if (btf->id > 0) here, why even call idr_remove() if it has
no chances of succeeding

>         idr_remove(&btf_idr, btf->id);
> +       /*
> +        * Clear the id here to make this function idempotent, since it w=
ill get
> +        * called a couple of times for module BTFs: on module unload, an=
d then
> +        * the final btf_put(). btf_alloc_id() starts IDs with 1, so we c=
an use
> +        * 0 as sentinel value.
> +        */
> +       btf->id =3D 0;
>         spin_unlock_irqrestore(&btf_idr_lock, flags);
>  }
>
> @@ -8382,6 +8389,13 @@ static int btf_module_notify(struct notifier_block=
 *nb, unsigned long op,
>                         if (btf_mod->module !=3D module)
>                                 continue;
>
> +                       /*
> +                        * For modules, we do the freeing of BTF IDR as s=
oon as
> +                        * module goes away to disable BTF discovery, sin=
ce the
> +                        * btf_try_get_module() on such BTFs will fail. T=
his may
> +                        * be called again on btf_put(), but it's ok to d=
o so.
> +                        */
> +                       btf_free_id(btf_mod->btf);
>                         list_del(&btf_mod->list);
>                         if (btf_mod->sysfs_attr)
>                                 sysfs_remove_bin_file(btf_kobj, btf_mod->=
sysfs_attr);
> --
> 2.52.0
>
