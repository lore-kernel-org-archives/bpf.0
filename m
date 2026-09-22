Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81C4D2EE0
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119824; cv=pass; b=eP6D3sf9m0jWBFgPqC973Cr0ikY7pdD2nb/ulgu33xJDQDQT97d0UP+hSmm0m6ILJYNZSZqwqvwgpAyZDCvDFWs9Xt1V1NIyemByMfpyo3YN19w3xCGi5zMDHlfhpeCQoyOm+seRtuWr9pm6pQmPSV/AOy5oj9kzmwuIUN0HceY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119824; c=relaxed/simple;
	bh=QvpkalNceT0Dv4UHhKns9D6g68GmKVYG5LBjIJTE1ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1vY35LZ+i2M4Ph1Rn5rVwW0hmJczzn7LMDiN6rvHF4vOreYo8dqYOoVgqZsNSmqGG6l7YJlc7WNK3XdwRGORNCvzsJgpjPveMKCwUindOdaeTyeCOPO9xH1L9iV0P60CNcuGmS5wxqBiHI1SW5oV4be+2Dv7x2jQn3qmDSum9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeGSMIHm; arc=pass smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeGSMIHm"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-811424a645bso269759a34.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790119822; cv=none;
        d=google.com; s=arc-20260327;
        b=qAxrWu3kkI3BVJoNX9ETpbSrNU4WmLMNoy7G96MmVAJNrEGYHdNftF8LRjO6pxvKvu
         yb+77zhjpU7fkE40l8d8Zt83nZHDvH6k24F1/LI32BKu7DRMMcMXVAGf0bm/pkm6FzEg
         8sM+xzrEVGEgmaEmbd/Y1hqGrEn62BMIeG6g9KwpaR9MXSOYEy+YOR0C52ZosYU+gjay
         Vk50W2cDhXYNvVjKyRTcy1SIKot9gZNT8W07Sn7oSyaVPHOcGRsUp41NzxonIEr5C2Ft
         YZMcq7yflEfk4c1pP3c7+UlGdBAO40OpRayDRg2Id0//wJPbaYhrAextdaeGfoA6VbzZ
         3pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zdOUGh7cWbk4GkcksfCE4suo+MwMF7QRY2MS//TIAzA=;
        fh=kKBr0GEZmbS2iRctuyUw7o/8INyekhCS1u5F5UMtxQA=;
        b=SUCqTxnvvATalQy+NG3FaHrkEWEU3QgUtJzFV+cW7JKDArLjk29gOEIpBtmiza1BL5
         2Zw6Gz+f2FZQumCiTbw1Fce5lFsXrw4XKBq9sKt7rOaHMFEDvWCHz34SnuNGGuE3hhea
         nZ1SPxB1+Cwm5lLOR/TVMr+pXIdKwiCGXC5/EKmKuNVFH6LXnXg0sXZ7Hgv8hGM9Ukac
         T2yS+7ozgnbXW9gQqoH1DDuzkV/dZPk2cmrk7YF3EObSyOPVXO7v3qY9QswlD10MoxnL
         Ssz3RLnSC0NpQkHOmvEnX1Wtv9cE3ajYleFXB+vWwpmilAcLAxqP+mA4jLqMtz5c868+
         K3XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790119822; x=1790724622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zdOUGh7cWbk4GkcksfCE4suo+MwMF7QRY2MS//TIAzA=;
        b=HeGSMIHmZxkAfgyfG8C12XdAMfdzY64ffw2tozc3qym0ffn7Twv+8Ot5IDc+PIWujn
         4win4bxBTIAud7Oun43y3RoyWsfpf8xIrM/WdOdEzekde6UWCHLxUSaEc6dqU/gNaGt3
         wUtGB0I/FOEHApUDWX7U/L5kadU1/vc1qIRn4swOxQyRsJ9BXuBdmIlB1BX8qcwepD8j
         P45I1g9666wsdxzb4TzR4cNC08TzIrm5fyqAqmA+jnKnmXlkna878jLIEAXapJCLV+0b
         YyZkgO+nSTa3Ak5TJBu1JnbuSX6DW1X0mXzo6Y/8w3//BdGYkYTRYMFJP9MEbc73GWk1
         wDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790119822; x=1790724622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zdOUGh7cWbk4GkcksfCE4suo+MwMF7QRY2MS//TIAzA=;
        b=Vmdq+Nw1m7hl6y8588XhufFQHslur1Olzq9oSP3ighuQJHm82kn1pWVAQT1rqEiOUW
         ICfQguMAkmotxQXFscp8wZaPM8mCU/Ds/RFx1/FuYVWe+JTBXer3U+CqT0Zs6hBmfJq5
         zz74HxJU35sV9r8GT29NotRvo10PvmqEkaUb1Myb2AwWIUk9YqHnWiU8CUe5XevOwQXa
         Xf597DAu7jHmQIEG7HBO+1BvlTh/OptdlZnHpmqblGJ52FB1CG2tnPLCtoAfU6b6YJml
         q//rvyNmJqHmudvYg0cblxkWCadmcrHBtZ7agv0GVGjAI/YUm/7JxTEhq4WmckQkP/NN
         8meQ==
X-Gm-Message-State: AFuF++kbKKYAQzZXNUgqmHUpVxxgQzhn/PXXJZLuWklo0PbZ+T/lWvWh
	TqciKeYJaQgenHHHp9lKzH+X9mnONv4Wsh15L7BBiTBvFGJ5wkW3Efdzo3/2BDnDdVDDc1AEHna
	Xd6oDBQKid70O9wBpeBmMiqy2NuhPtRE=
X-Gm-Gg: AYBFou1aCGtIrBGk4y8ceZ3ZJrm4q7967De4PZNpBLQu0Jc6pLFzgGi+epTDkKgZ/LP
	vfhLajpPKH/7NRUnDNw3Vsn+zcV/maVCSkS5C73B7uvGC7v0XkiZz0fNQkHuHgsvM7PjI/hutiJ
	/inrFiT8MUDxgI+A7sQ0Ydyav92Tdi+cbJDT9Gl02QrJsU7C3D59SmDfZBDnjbZidlXfCnpsYm7
	y+rKTIoA2tB3q+nyY5Xt3/gMkvIK/NPrCxTEEVUnnAJnEtZzgvnHhtud5V+dWQsFZIBA4Iu0AmZ
	XWsKhlraOByPEAcKF56OuaNnI75a1ZU3zY+KgKBi2Ds+rWdkvQBhHX0I903Af/+loZ+89ZU=
X-Received: by 2002:a05:6820:4c14:b0:6d2:3dd6:7984 with SMTP id
 006d021491bc7-6d2d2617abemr843837eaf.61.1790119821765; Tue, 22 Sep 2026
 16:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920210432.345758-1-xyx2021@mail.ustc.edu.cn>
 <20260920210432.345758-2-xyx2021@mail.ustc.edu.cn> <CAMB2axNe5CX8QcF9BU4RRsC9BORAjnMAx8OX1ywLaCDBj=wyHg@mail.gmail.com>
In-Reply-To: <CAMB2axNe5CX8QcF9BU4RRsC9BORAjnMAx8OX1ywLaCDBj=wyHg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 16:30:08 -0700
X-Gm-Features: AcwNN1Xjxx1Ak-55UPk4J2W1SfzcCDsMCuBorH-T7ejCfuTEkyiN_snkUbAkT4o
Message-ID: <CAMB2axMt8K6tnLZ_wNzx_c=tCqpUeLOETitN98_v1y7Z7J2EwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Track iterator-owned BTF pointer lifetimes
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>, memxor@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	puranjay@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 4:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> > +++ b/include/linux/btf.h
> > @@ -80,6 +80,7 @@
> >  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as i=
ts second argument */
> >  #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments sup=
plied by the verifier */
> >  #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin=
_lock-ed region */
> > +#define KF_ITER_LIFETIME (1 << 18) /* next result borrows the current =
element's lifetime */
>
> I would hardcode it using the special kfunc list instead of
> introducing KF_ITER_LIFETIME.
>

No strong preference for special kfunc list over KF_XXX.

Let's do opt-out because that is the safe default behavior.

> >
> >  /*
> >   * Tag marking a kernel function as a kfunc. This is meant to minimize=
 the
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 314ecb0e593b0..6a287f808200b 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
>
> [...]
>
> > @@ -6224,9 +6236,14 @@ static int check_ptr_to_btf_access(struct bpf_ve=
rifier_env *env,
> >         }
> >
> >         if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
> > +               u32 parent_id =3D reg_lifetime_id(env, reg);
> > +
> >                 ret =3D mark_btf_ld_reg(env, regs, value_regno, ret, re=
g->btf, btf_id, flag);
> >                 if (ret < 0)
> >                         return ret;
> > +               if ((regs[value_regno].type & PTR_TRUSTED) &&
> > +                   !(regs[value_regno].type & (MEM_RCU | MEM_PERCPU | =
MEM_USER)))
> > +                       regs[value_regno].parent_id =3D parent_id;
> >         }
> >
>
> CC Kumar, who might be also working on it and have a fix locally
> (mentioned in [0]).
>
> [0] https://lore.kernel.org/bpf/DLGYPZAL708V.3GFLANAPH2L8O@gmail.com/#t
