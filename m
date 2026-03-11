Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083A08F48
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235614; cv=pass; b=qUyrHu/HqgkmLTkSfkXph15YJerKeb9Tgg6XZP5nJm8QsiMYHVsElxn2s/cnDTb3ziZ+okOmcLxFY1qT7hP/Rc/wUk92q8eEC/CGcsHeRYzZlgdecuaJ0Z2Nt2fu36S/GOQceMIDv7kdChceXTCJTMmtd1zZR2IA9DbTYCM/pgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235614; c=relaxed/simple;
	bh=beILsxZhZT5wVt9M5Qk4lmhAb3r0PmSDur8jWlqDf14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssNkISEYw2XOX+dPZ8wpgeIUAQbkWSc/vaLzJHg9/8jjHNoq4uLc1/itIb6G0sKXdTQIksgXpVlWSxVgV57puJar4NGdM/h2SJWkJRTUQMeckt22PVqrU3bbQFe/fL80fcAOsRXxqUeubMwD3jkaqvp03+tkDjOt5Xtaw3TZ+6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7956LAh; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7956LAh"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439d8df7620so3828199f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 06:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773235611; cv=none;
        d=google.com; s=arc-20240605;
        b=cl2NbGhjGNkbrQgnD1xy4DIsMGlrr1Y1GvRpWYn+woN8kjBVWVINBi9B10iOO8TNPe
         hR+Ft/kJ+Rwk7uOCmzqn+hhbKz9Ws3WrR9didJYYzS3QtpMIvqrmXWqQwZZl6JF+JX0M
         P7+ZMaRWEAfx4HLNRujUGT8pBT0RWT2+KzxcH1AMHm5W1sx8PJsrsbxDeMtPqTe1TtVi
         uR/jTTMvFb8Cv2xtao4RmzxdFXwSIX7LTWnIKK5N+zRL3Oj1ji9zaBE6bC3+1n5PPyKL
         8J84PEsbtBg0FhGV3VO2JrcjqipX1xTejuFZ1gRsDmVAjprfbhb0AXyiJ00WTjRVBUti
         97gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p3srFuWF3GZ8iyM4A/K7BjXDqUBBMWsS5j/OAcnajMw=;
        fh=aNzx1HceCVV/8aMMcD3zvUvlZVPGjxZiTmtdtG4stQ8=;
        b=QwN0RvOM/Yhg4DA2DtGdHiUGoVhzb577zc8L9JXigeDFPA+bl2mZ5K98BhX4eHCzdy
         VImGy2uO9sf9rA345OseeUD5ltEkWTah8eo3pjmM/8xaUmwqKrIz1elNwtZz4Lg2tkW3
         698vstWfVKD5VkEWLpz0TeTnUGgDaQCnY8A1BINtIWdN/+NeHqYxmemleqAI/W3r1ivG
         y9QJskx+/pApv7hf6LJ8hO01Hnhqh0uh+vVkfHRtcN3PYwXUYoN9A4o37Wnb++GmZXsU
         EZfmAL2RWjOv6SC9Zxk5k8sqvfuCuiDz7JRdqXO5fEYM4nC90Q8CXKok83lTZSZGfXCo
         0Pxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773235611; x=1773840411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p3srFuWF3GZ8iyM4A/K7BjXDqUBBMWsS5j/OAcnajMw=;
        b=D7956LAh2emu0D7qGKCauoSvY6P3zslz6N+YKeCasi8yqr9fMcLYXzJuY7785JdGog
         roDupFwtIKZx/NLF74mGVGC3CQ8H5LUaJax5fDrBpAb7msseRyFHEKmPi0xppRi3ZKcz
         6XpC/a+mOmPPkJo4IHFqMtTdNWdRbRjSJkdM+cvPG+Fani7H2X1oAnGwxW1gzT7dLATE
         FK5zTVb43WEDocSKQ2m+8F/MRnkrDoybvqDH4PgzILTQrjy1NCFeXaGfOo0CQ0DGdt62
         pkLkq6/tfr4CkZb3uCIoslm+w/zQ37SVfpQt8vV0ijeVpyqAzwZd0+KqvnKF1VprK5yA
         mp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235611; x=1773840411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3srFuWF3GZ8iyM4A/K7BjXDqUBBMWsS5j/OAcnajMw=;
        b=s30Csz8u0u5joT4+xMK9D7mXHkEEXCNo5TtaRn27JmWCO75zJo2yTTFaAY680eofM1
         EzTVdvDrhIKh8XkO/Z0kw8Ve6IRKLSrFgm0bOAmE3eSp5uPsJ9TywOmhZMAxCXdo41O0
         ucHU/yd7kIchCFjTVCfLaMEz+dJLssFrp3j7YkqCX7hAAac7b8xE/XaQzru4PnvGcL3q
         BoT+xe5AKWoBfHzYU2ZcWN3pdoD/fOycc2N9R5aMgncap9M9AlONkk0cRDBN6kzKIFoF
         GEoX91g/SN+zPnjZ4mMb7g7kRLs6bnqScdmGrJiSJN2llsozWvBcPJVAGhBJ5gVXD87p
         EAsg==
X-Forwarded-Encrypted: i=1; AJvYcCWJe+7Tsfa1iLO2/iNXJ23F4zjuC+m7MywAGZyyJZk4b7RVOZfGH6IaI9eFrD3w77MRE8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YziejHFoZpHT/FBRBo4nc8p10LMCZF7yEeHJdFU6hqGNbUMgoTt
	kbfDlUyGGg+cxCPef6Lhb2LuU5PBWM9Q3X4OXcxMm7dMpc0NdFqzyHxQAwl1BOXreb81hvD1Vjn
	7dc9SGTaWEMKCXbZXErOHUF0w7LaTBRI=
X-Gm-Gg: ATEYQzwURX7Kt2ogUge+Vmzfh+6Zwr0JM6nollLCittIDIIgssxkNpXt/UoTT5Lb5xZ
	Q9c2WAzdu3JWk4QGgknfwCkCtkY0c1oqJoNf4Yb7DEzH0EwVzXfFjcGENeIW+oCmivZqaQ0Wrdx
	lLZLNN6Ex82mAS/ePJxXRT6hsv7JSx0JEUc2nbcfCCCJA/r+WM0MmjjgqqFdpemYGQdGpOSKZYf
	VY5WZOysNsqKugzJe2Bwy7Qbs54ZgW1m6mZ5Oo0XGApiYTIO1jByYgoKCNP22nhdTLECN9466WH
	AtN5Z0rFtM1QtIS8hQ5QsKjUAnSg5e71fvCYqFUSCGnaWYZAUrZCP6K0hct0
X-Received: by 2002:a05:6000:430e:b0:439:d750:42e3 with SMTP id
 ffacd0b85a97d-439f81efeaemr5258531f8f.25.1773235611022; Wed, 11 Mar 2026
 06:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev> <20260311130321.1055808-1-memxor@gmail.com>
In-Reply-To: <20260311130321.1055808-1-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 11 Mar 2026 14:26:14 +0100
X-Gm-Features: AaiRm512c8q2qDA3kisUqJtacPkWDmpjzlIPelWoJuhoZx79ENuGE4WLK9b2zT4
Message-ID: <CAP01T76QJoMnMKNp8KrJ7NnShe78HQOoADXZTZVqAnpSbyzYfw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Release module BTF IDR before module unload
To: martin.lau@linux.dev, grbell@redhat.com
Cc: ameryhung@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 14:03, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/btf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 09fcbb125155..d18e218049ed 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
>         refcount_inc(&btf->refcnt);
>  }
>
> +static bool btf_is_module(const struct btf *btf);
> +

This probably needs to be 'bool btf_is_module(const struct btf *btf);'
, i.e. without static.
I didn't get a warning in my build, strangely enough, but nevertheless.

Gregory, please give it a spin and see if it fixes the bug for you.
Martin, please let me know if this looks ok to you.

>  void btf_put(struct btf *btf)
>  {
>         if (btf && refcount_dec_and_test(&btf->refcnt)) {
> -               btf_free_id(btf);
> +               /*
> +                * IDR for module BTFs is freed when module's BTF reference is
> +                * dropped, which may happen before the final put.
> +                */
> +               if (!btf_is_module(btf))
> +                       btf_free_id(btf);
>                 call_rcu(&btf->rcu, btf_free_rcu);
>         }
>  }
> @@ -8383,6 +8390,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>                         if (btf_mod->module != module)
>                                 continue;
>
> +                       /*
> +                        * For modules, we do the freeing of BTF IDR as soon as
> +                        * module goes away to disable BTF discovery, since the
> +                        * btf_try_get_module() on such BTFs will fail.
> +                        */
> +                       btf_free_id(btf_mod->btf);
>                         list_del(&btf_mod->list);
>                         if (btf_mod->sysfs_attr)
>                                 sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
> --
> 2.52.0
>
