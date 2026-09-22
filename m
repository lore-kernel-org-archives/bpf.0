Received: from mail-oi2-f28.google.com (mail-oi2-f28.google.com [74.125.231.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13CD3BCD19
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118806; cv=pass; b=qesVE0UGbHSN50T5kn2oMFqLrmV2SlNL3h8X2g6xLG+svFUnfOySOSApqb7z3S+uycA2mJWsimubaMZJylNpnI8pVhDjPFrFRtvbr1bZ5gGLA+Q4XRcy1XGjk/ZxTZsLf+I8ciAwHn3qBavvJQUZkjy0eNubuXvY+mDO0B8VJ4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118806; c=relaxed/simple;
	bh=IvStUyu83m+ZJpmK/qxea4d8TSjPT6RM7HE02/b7XTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNr74m4+j3SyCOp+3EesqOB/bBTIQvqSmZ9YF8QtfsPcHpE+VP2iCgR1pOAKw+gpbd7unlu89Cpzx8vWdAd+IIuTgqqnOm+pYH8jif+aMIoaNs8n8tsGO1dBLdAw/+jQoKBbHsSN57QZfK/xvW+2Shplh7OrJzEKaeZypdh1bqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8w6fVzt; arc=pass smtp.client-ip=74.125.231.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8w6fVzt"
Received: by mail-oi2-f28.google.com with SMTP id 46e09a7af769-80a18990c76so365145a34.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790118804; cv=none;
        d=google.com; s=arc-20260327;
        b=BOyPTSN7rCsJUBR6isqU5LutySyGnftFBqeazwgn4JByEjm6Xxlk4IfhOEb17LTV6N
         v5QLCHfk7Or6oMiOtZ3b5vY/6R1LMaTm9C3Y8o1qfD8usCbanlkfa46j5CzZZoqfxMdf
         jNhUsH+g3uNaexG2W7OV8Ld/YEXYK6lo/At/W3+qlvRVlJLVhEs51xXi1P21o3QmPBQa
         XQkwHh1QL+qz/OE1bDjWXyzA7lMXy/kibWPOemJlLPJTK2T4cdwlI9yJxBtKI5bFYmr0
         i7N2baD+D0rjwfVF6hNUCRN8xXVvPHebgAIgrAt/jDFQXsyt6McOB1zuJ9YsZTvrUiej
         zhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GrWBDc+UFxi1ZgQ3XQujmrT38Ch5FJY+n9RTw4cpuEY=;
        fh=kKBr0GEZmbS2iRctuyUw7o/8INyekhCS1u5F5UMtxQA=;
        b=Zai/aPNm3kD+gEacWep/pJKwBuC0N4+jczgrBNnm0dcgSvXbXJdW0TCskyJEK6OtRQ
         3rZnFnJZCDwY4R0SzzV1ssUvkk9aYsKt8Vp33WdHLL0+cTivinrhY3nM+cJBSmvTLaov
         MK6cwOFlA7HRtkv9zNwXWpeHe0nWa7PAQkJlwmCwF7Jphvm2E74pFSj7bR4qyOnubOjR
         0bnaEfw/jl6M8kUwyc47apS05MzM1O4WbI6CRRtmYqNOeXxpOm41CnlUspomW2f0i+xa
         5vXPSSv6uXGwslgwJpHyRLt9fCFDiI+mkx4rWKuJHiRFXQGJeWtx6wkSBck4NwjTkFa/
         ff4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790118804; x=1790723604; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrWBDc+UFxi1ZgQ3XQujmrT38Ch5FJY+n9RTw4cpuEY=;
        b=c8w6fVztT8ff4ZMxjGGOCwfPnb2wzO7djpEhGDgKXwmeFjmNbtbEFUD/UrzqF1IHHX
         MNLUkdRvimQdiBGnjXM/NppqovVg6gB62KmlPuib2drJxMJ7ehYWY4hwDncS7ie7lOqt
         Pyih9nRcUhdYzuJGPWZA0Mka+fmj3mmxe1RBImguxD1osprCJD7GCeNMiIV8JLE80FTo
         CrfcxtiLCl6Wb7nvVwzutLE9Q+kiUMBKOqCGo79sTRp4/+aUnkpwiV4664aIAofXoCvC
         GMuPG6EHT8EqEY55Fpu/TjmpOvVjGbUPFtO+PivKUYNdui7mANSyukocE0Xai1lTLVBK
         93VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790118804; x=1790723604;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GrWBDc+UFxi1ZgQ3XQujmrT38Ch5FJY+n9RTw4cpuEY=;
        b=r65g396H0EeoNfAXWaaqy6/Msi8K46Xpuv4NgUY4O5blLaDx68vGl9OFgj7wOjzjYJ
         ZOBZrAoCqxk3DNL1kO2qQPKfr1Hcc3jb3EiSpaqyi4D9ktQO64NkJURXDL5sXgoO6vNE
         LOVHQIjiA7uKnhkBgccdGHd6noNKUZg3ATZqiG4S+e2e7gs6iCoEfkLlI7sggVjqf21h
         +ZZkNdnAJJXKcACpaAd6t030b3ftJiEPxvFYyLtyQhmWjWUpAJYh/wNbrMMqCF6fag/Q
         BQySbHfdp/V8A810nmwqGdgdFjrlNl+ScZ7t+vgqSgsneK8CPEkpCY2C7ZcMBYNBvd5I
         VO1w==
X-Gm-Message-State: AFuF++nY0PPQEZrIRX5h27Tr95S/ERhZNtn4H/HOsco8TSCrTSKFn0RQ
	B/OFxEFWYyPqJa/y122lx1zjarfKtDc9OfU+dVR0zExvEDPN+YhcHALX6wCvQ8gEIulIsmoWWSC
	j0pTnw4doEZR7729lPK2x9MZStd8w/r0=
X-Gm-Gg: AYBFou1UQv3ISOnHkbFuWzDjY2S/VMagjCNrrcvngFi/nE6pIs+UPWlRmj9y2ELu6+R
	sKbbs49xbwJwsuEtNiLPwMjAPma47XSfZ2+1sYzJaiFg1gY77WG+WAt6JY289dPu1w3bUmLaQbi
	t+poFooljv9mORfdE2KI3FzcKaqbTqljHnBY6Q5RWpVl3M2k/YSoUZW/eP/XBn1kM4EvStKgksk
	xXXlppKf4rW8E0YNQV/VF49vilMd7kNnryREUbBZlO6Dp6vXH9VX3zHATp03OWA/Yiip8ucfEIF
	HEuZKVJpvPojDvQS/XfwgJXWjmqrvwZFOTJlmFNSJKzzMrPP7Mg7gmpj2gGDz/ujaeFm7dc=
X-Received: by 2002:a05:6820:814:b0:6b3:b9d1:f629 with SMTP id
 006d021491bc7-6d2d0b2df22mr724319eaf.31.1790118803668; Tue, 22 Sep 2026
 16:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920210432.345758-1-xyx2021@mail.ustc.edu.cn> <20260920210432.345758-2-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260920210432.345758-2-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 16:13:10 -0700
X-Gm-Features: AcwNN1Uc9OOpPOk250_vaYwaGb-pLfM88ZiUXHUiEzdjJG70kEGKvt8Uq2sgUbQ
Message-ID: <CAMB2axNe5CX8QcF9BU4RRsC9BORAjnMAx8OX1ywLaCDBj=wyHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Track iterator-owned BTF pointer lifetimes
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>, memxor@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	puranjay@kernel.org
Content-Type: text/plain; charset="UTF-8"

> +++ b/include/linux/btf.h
> @@ -80,6 +80,7 @@
>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
>  #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
>  #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
> +#define KF_ITER_LIFETIME (1 << 18) /* next result borrows the current element's lifetime */

I would hardcode it using the special kfunc list instead of
introducing KF_ITER_LIFETIME.

>
>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize the
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 314ecb0e593b0..6a287f808200b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[...]

> @@ -6224,9 +6236,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>         }
>
>         if (atype == BPF_READ && value_regno >= 0) {
> +               u32 parent_id = reg_lifetime_id(env, reg);
> +
>                 ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
>                 if (ret < 0)
>                         return ret;
> +               if ((regs[value_regno].type & PTR_TRUSTED) &&
> +                   !(regs[value_regno].type & (MEM_RCU | MEM_PERCPU | MEM_USER)))
> +                       regs[value_regno].parent_id = parent_id;
>         }
>

CC Kumar, who might be also working on it and have a fix locally
(mentioned in [0]).

[0] https://lore.kernel.org/bpf/DLGYPZAL708V.3GFLANAPH2L8O@gmail.com/#t
