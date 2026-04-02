Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258423EA85
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138559; cv=pass; b=j5J0OmYgXZ/R/pkfAHoZm0J46STOoQwqWm+M4PeGxiQUKS2r6NvyiJjeEouxlPmZmzSJ46wGiSg0Xyf+EXlgzwv7RDkIvG/hbANMsrujnRpqNvCTkDJ/m9cftk11wRDJpunq+cG/DhsIYyko67JyEnJR73PK2Zj0oYbjdtbmN3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138559; c=relaxed/simple;
	bh=cYnJFMxi9EQzoukluL7y96raoZFW7insbY+YI76UzUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3KeuVgVzDtM4x40XO39PL+pgMNdWler/K/R+i7hU9FmNnN5bHQ+wrQMl1wmKy25+0XkwmTf/p/vwXjCcNPxGKBz+fqzxpChnSVzhCKeB114lLPhaV04r9k4JkxAfloO1FiHKvxp0jG34CtuI1wTzCzfW/M42hILVuLO41/raQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzwnKUu2; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzwnKUu2"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so565457f8f.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 07:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775138557; cv=none;
        d=google.com; s=arc-20240605;
        b=SXuxT3rYH+Z2RM2W+VFoJgo8cXfF1xP+pCFbJ5JwFhlRlTZEbmyaY3BjoJYTAnltAv
         8DSrcqk4/yOiC1eFf0RB+tZ3k9lOlvk8lqZUY4nso+8IGxyGwIbO5KSNPLeihAJoUm/m
         kv1aC04Jh3etAGaT+Pungm2AJHdq88jZjYsnjg1Yqy526o27JmOI5eyCP/64QTPH3hCf
         GA0WQ4BWRbUYq/ZWItDCn2Q8c4xDAx4p1Ig72pN/RdBWEF9iKAOvLI/7FEmnYKCL9p5x
         SH+wheuQh4RjSyEhcPS99Ma/9p3sDYNaH2IOevEg4vvpTnLtni6NnhZiLMGxy4a9mHUj
         txBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+7rBDz4IiPLoVHa5kPrhaTo8Ds2C/LV1bZASn33O9cc=;
        fh=ZjZnlGJ4j6GsPbdN9KU7cNTEhuDuKixuJSySPsKlUQw=;
        b=GBcJa13KQw1SLI8/1V+//VfF91oSuSAN92d+BGuFp6SjwQgBljBHRodFx51GnOpc1m
         Rz4skdavLOI+hh3f1VxpWK2bHaTBzEEF1ZnTAokUp52JcVhjcHGxoV7GGHhLsxFdzsfi
         N10l7MC9KqHncSVrXs9smS+ucJNmPD7tvj21+6udLLAjXJzpEutZr/Vq1QGcc/990RoC
         jGFYxiLzz08MyMJt77VVO7PC1cKDEipceGLqr8TZfWgbGOFaPbunQdZH/QqrjyxkBm7G
         HriSTiryn47EFW+YPPCestZoM2nSSNGiGVA6HcogYtKwkFSWcik5NEHCExNHcEKLRm5i
         iYjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775138557; x=1775743357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7rBDz4IiPLoVHa5kPrhaTo8Ds2C/LV1bZASn33O9cc=;
        b=rzwnKUu2UQSS8e9nG26hDZigoJU/nrElZlS75PUAHRqgVI7pRWvwcK+FIoMc7JezZC
         b8ZX0zgJ8/BGkh1f1ha7Ezic2LAY3+Y9JOM3HztpNBD+prLYbyfhEesWhrskEFNMeDRM
         Z82zE9ANJSBOwUiuXDxdnTlSExZxQW4WQg8AID7uA9l2QY9DoJNWBMQRLIHnEqnFYhJC
         VEiD2q4Vo+QF5pTO8scSnzoF9KzvkvyYZOV5lCwjuWLfYxxu9j/w6fUWfhoYECzxf8g1
         6dZ2TYuJUChxXWhyDbjUsXxenRa4MGwcWZZ8gYrVKAqAqQUMnJNRH80jxm13qKz0W341
         cKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775138557; x=1775743357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7rBDz4IiPLoVHa5kPrhaTo8Ds2C/LV1bZASn33O9cc=;
        b=DGu6nZMWv4fRxeVGGLJesnS2SuFWWrzS82xMiD2Fs2OWbeYV2kQUiLIm7KU8P+8w7A
         TEqOX38Tnlx9PGTl7F4eCGgieN+HBU5RfbnOUtVSlgH9p03zgattXDrvUsK6hyyx96iN
         eoK7s1nohiBgO1h+sTsy9sfiwg93CjiksoNpdRJpncLoA2GGlRJEQyF1aWKYTOc+H4b9
         NMbI//UbDkMyj9fvmBHTweXwyYBIU+g1lhgj6NPrpmIVE8yK8G+VWQnYYIdaZvY7zoVy
         SN6Z9I/MVXbUbOraoLJTG7OWP3CT/CaNKJV83GhowU7Y+heu8UlCmNaRKkMQ2K7Cj6ZG
         TupQ==
X-Gm-Message-State: AOJu0YxQgP0FFtgd/tqyyqgImtBNAzwOXFUf370eijElb0UqLtDIo+JZ
	w9ZyBcecpSk9xL4ezsyeJOgA6wEXHBBMZh37TdNpr+YQNNuZlzDtoWN9UmuuoBtQ9BVQwdpJNaJ
	3CzigObI2jbKd2en9L+jwH2Vp1b1NqRE=
X-Gm-Gg: AeBDietr/jPGJYyKe7tk/I9zcHxVQSL9DZWvLFOuat87jEd3mRhzE7iwX9IZeW31y3C
	9XTJFEcwC9QgLWEl+F4xIol4a5rNSoVJAes8bYnkcDmY4Z/jxH6abrLTNNw0lqu4cSgPMGMRnHd
	l+GRg+6wvtMW2ysgM8RZtcX2iFv6VtjoixWHMIhPtOMF8dj300xK38tiW2gf9LL2UwnaUYd05sR
	qm+0kquZkrCj81lzl/LjYzBZbReAK4soo6tiS2syz5nCvb9KM7y16JEuY1+b4liImEmTZWp1iHf
	S57qUuT6lQ8v9lzwkoC1o0OrUXSjG1ZQGRzEwrFshxZkWlB+XvfFQlPMrDzUM0q/OgItQE3HhOf
	yoaSkomy3CvlJWHzBkVK6Cdii6Q==
X-Received: by 2002:a05:6000:1847:b0:439:beee:43b5 with SMTP id
 ffacd0b85a97d-43d1f1b013fmr6697807f8f.3.1775138556513; Thu, 02 Apr 2026
 07:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402061744.10885-7-alexei.starovoitov@gmail.com> <990f6097eb8184cc1895c622c8fa70d7aef9899d77b893ce4241825ba4fd5116@mail.kernel.org>
In-Reply-To: <990f6097eb8184cc1895c622c8fa70d7aef9899d77b893ce4241825ba4fd5116@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 07:02:25 -0700
X-Gm-Features: AQROBzBZ7t_5rDqW4Wz3PT9dUECzIpD4vWNoKCwFCnpMz9Kra-6DqO_slq8tqFo
Message-ID: <CAADnVQKg6jgLX_OD=hFfQZ5eS-qLi7n07BJ-DkGJtNAxC27=Qw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/6] bpf: Add helper and kfunc stack access
 size resolution
To: bot+bpf-ci@kernel.org
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 12:56=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2a5d862a82db..bca8129fd1ed 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > +     /* ptr + __sz/__szk pair: size is in the next register */
> > +     if (arg + 1 < nargs &&
> > +         (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
> > +          btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
> > +             int size_reg =3D BPF_REG_1 + arg + 1;
> > +
> > +             if (aux->const_reg_mask & BIT(size_reg)) {
> > +                     size =3D (s64)aux->const_reg_vals[size_reg];
> > +                     goto out;
> > +             }
> > +             return MAX_BPF_STACK;
> > +     }
>
> Should this check is_kfunc_arg_uninit() before the return MAX_BPF_STACK
> fallback?  When the size register is a known constant, the goto out path
> handles uninit correctly by returning -size.  But when the size is not
> constant, this return bypasses the out: label's uninit check entirely.
>
> In bpf_helper_stack_access_bytes(), the equivalent path handles this:
>
>     if (at & MEM_UNINIT)
>         return 0;
>     return MAX_BPF_STACK;
>
> If a kfunc with a __uninit pointer and a variable __sz companion is
> added in the future, this would return MAX_BPF_STACK (indicating a
> 512-byte read) for what is actually a write-only buffer.

If it's ever added in the future, then yes.
Right now __uninit is only used with dynptr-s.
So I'm going to keep it as-is.
